//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 中村泰輔 on 2019/08/15.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    // 画面上の数字
    var numberOnScreen: Double = 0
    // 前回表示されていた数字
    var previousNumber: Double = 0
    // 計算してもいいか否かを判断する
    var calculationMath = false
    // +, ×, -, ÷
    var operation : Int = 0
    // 数値かどうかを確認する
    var isEditable: Bool = true
    // 数字を追加させない
    var inValue : Bool = false
    // 計算結果
    var answerNumber : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // クリア処理
    func clear(){
        // 画面を綺麗にする
        scoreLabel.text = ""
        // それぞれの値を初期化
        previousNumber = 0
        numberOnScreen = 0
        operation = 0
        calculationMath = false
        inValue = false
        isEditable = true
    }
    
    
    @IBAction func tappedNumber(_ sender: UIButton) {
        
        if isEditable {
            // 数字を取り扱えるかを判断
            if calculationMath {
                // ボタンのタグ番号をラベルに送る
                scoreLabel.text = String(sender.tag)
                numberOnScreen = Double(scoreLabel.text!)!
                calculationMath = false
                // 数字を取り扱えない場合
            } else {
                // 数字が代入
                scoreLabel.text = scoreLabel.text! + String(sender.tag)
                // 数字が表示
                numberOnScreen = Double(scoreLabel.text!)!
            }
        }
        // 追加
        inValue = true
       }
    
    @IBAction func functionButton(_ sender: UIButton) {
        
        // 編集可能
        isEditable = true
        // Cが押された場合
        if sender.tag == 10 {
            clear()
        }
            // 追加可能で、イコールの場合
        else if inValue && sender.tag == 15 {
            // 実行の分岐
            switch operation {
            // 割り算
            case 11:
                if numberOnScreen != 0 {
                    answerNumber = previousNumber / numberOnScreen
                } else {
                    answerNumber = Double.infinity
                }
            // 掛け算
            case 12:
                answerNumber = previousNumber * numberOnScreen
            // 引き算
            case 13:
                answerNumber = previousNumber - numberOnScreen
            // 足し算
            case 14:
                answerNumber = previousNumber + numberOnScreen
            // エラー表示
            default:
                break
            }
            // 小数点の値を分離
            let decimal : [String] = String(answerNumber).components(separatedBy: ".")
            // 結果が有限で、かつ整数の場合
            if !answerNumber.isInfinite && decimal.last == "0" {
                // 小数点以下が０である場合
                scoreLabel.text = String(Int(answerNumber))
                
            } else {
                // 小数を表示する
                scoreLabel.text = String(answerNumber)
            }
            // 数値が入っている
            inValue = true
            // 上書き不可
            isEditable = false
        } else {
            // もし妥当な数値なら代入
            if inValue {
                previousNumber = Double(scoreLabel.text!)!
            }
            // ダグ番号によって処理を洗濯
            switch sender.tag {
            // 割り算
            case 11:
                scoreLabel.text = "÷"
            // 掛け算
            case 12:
                scoreLabel.text = "×"
            // 引き算
            case 13:
                scoreLabel.text = "-"
            // 足し算
            case 14:
                scoreLabel.text = "+"
            // エラー表示
            default:
                break
            }
            inValue = false
            // 演算子を記憶
            operation = sender.tag
            // 計算していい
            calculationMath = true
        }
    }

}
