//
//  ViewController.swift
//  Kingfisher源码分析
//
//  Created by Yangyang on 2020/11/4.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    var imageView = UIImageView()
    var imageView2 = UIImageView()
    
    var imageURL = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604489026898&di=498614fbe4c83a2036aebff7d4229d28&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201205%2F03%2F01400598djmyeczcskh2yr.jpg"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = UIColor.red
        imageView.frame = CGRect(x: 50, y: 200, width: 300, height: 200)
        self.view.addSubview(imageView)
        
        imageView2.backgroundColor = UIColor.red
        imageView2.frame = CGRect(x: 50, y: 500, width: 300, height: 200)
        self.view.addSubview(imageView2)
        
        kingfisherMethod2()
    }
    
    func originMethod1() {
        guard let url = URL(string: imageURL),
              let data = try? Data(contentsOf: url) else { return }
        imageView.image = UIImage(data: data)
    }

    func originMethod2() {
        DispatchQueue.global().async {
            guard let url = URL(string: self.imageURL),
                  let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    func kingfisherMethod() {
        let url = URL(string: imageURL)
        imageView.kf.setImage(with: url)
    }
    
    func kingfisherMethod2() {
        let url = URL(string: imageURL)
        imageView.kf.setImage(with: url, placeholder: nil, options: nil) { (receivedSize, totalSize) in
            debugPrint("receivedSize:\(receivedSize),totalSize:\(totalSize)")
        } completionHandler: { (result) in
            let image = try? result.get()
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        let url = URL(string: imageURL)
//        imageView2.kf.setImage(with: url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        debugPrint("UIViewController didReceiveMemoryWarning")
    }
    
}

