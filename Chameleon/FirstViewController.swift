//
//  FirstViewController.swift
//  Chameleon
//
//  Created by travel on 16/3/19.
//  Copyright © 2016年 travel. All rights reserved.
//

import UIKit


class CustomerView1:UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func ch_switchTheme(now: AnyObject, pre: AnyObject?) {
        if let now = ThemeSwitchHelper<ColorName>.parseTheme(now) {
            text = "\(now)"
            backgroundColor = UIColor.colorWithHexString(now.rawValue)
        } else {
            text = "color not defined"
        }
    }
}

class CustomerView2:UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func ch_switchTheme(now: AnyObject, pre: AnyObject?) {
        if let now = ThemeSwitchHelper<ColorName>.parseTheme(now) {
            text = "\(now) no AndroidGree AntiqueBras"
            backgroundColor = UIColor.colorWithHexString(now.rawValue)
        } else {
            text = "color not defined"
        }
    }
}

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var leftPick: UIPickerView!
    @IBOutlet weak var rightPick: UIPickerView!
    
    @IBOutlet weak var systemLabel: UILabel!
    @IBOutlet weak var customerView2: CustomerView2!
    @IBOutlet weak var customerView1: CustomerView1!

    var datas:[ColorName] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datas = [.Ambe, .SA, .AmericanRos, .Amethys, .AndroidGree, .AntiFlashWhit,
                 .AntiqueBras, .AntiqueBronz, .AntiqueFuchsi, .AntiqueRub, .AntiqueWhit,
                 .Ao, .AppleGree, .Aprico, .Aqu, .Aquamarin]
        
        
        systemLabel.ch_switchThemeBlock = { [weak self](now: AnyObject, pre: AnyObject?) -> Void in
            if let now = ThemeSwitchHelper<ColorName>.parseTheme(now) {
                self?.systemLabel.backgroundColor = UIColor.colorWithHexString(now.rawValue)
                self?.systemLabel.text = "\(now)"
            } else {
                let df = NSDateFormatter.init()
                df.dateFormat = "mm:ss"
                self?.systemLabel.text = df.stringFromDate(NSDate.init()) + "\tno data in ch_switchThemeBlock"
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datas.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .Center
        label.text = "\(datas[row])"
        return label
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let cell = pickerView.viewForRow(row, forComponent: component) {
            cell.backgroundColor = UIColor.colorWithHexString(datas[row].rawValue)
        }
        
        UIApplication.ch_switchTheme(datas[row])
    }
}

