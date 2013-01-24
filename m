Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D090F2C01D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:34 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 23/32] usb: gadget: r8a66597-udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:46:01 +0200
Message-ID: <1359042370-4358-24-git-send-email-balbi@ti.com>
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kgene.kim@samsung.com, eric.y.miao@gmail.com,
 kuninori.morimoto.gx@renesas.com, alexander.shishkin@linux.intel.com,
 gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com,
 nicolas.ferre@atmel.com, linux-geode@lists.infradead.org,
 haojian.zhuang@gmail.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
 ben-linux@fluff.org, dahlmann.thomas@arcor.de, linux@arm.linux.org.uk,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/r8a66597-udc.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 5a80751..40ef4bd 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1837,7 +1837,6 @@ static int __exit r8a66597_remove(struct platform_device *pdev)
 		clk_put(r8a66597->clk);
 	}
 
-	device_unregister(&r8a66597->gadget.dev);
 	kfree(r8a66597);
 	return 0;
 }
@@ -1915,17 +1914,12 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	r8a66597->irq_sense_low = irq_trigger == IRQF_TRIGGER_LOW;
 
 	r8a66597->gadget.ops = &r8a66597_gadget_ops;
-	dev_set_name(&r8a66597->gadget.dev, "gadget");
 	r8a66597->gadget.max_speed = USB_SPEED_HIGH;
 	r8a66597->gadget.dev.parent = &pdev->dev;
 	r8a66597->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	r8a66597->gadget.dev.release = pdev->dev.release;
 	r8a66597->gadget.name = udc_name;
-	ret = device_register(&r8a66597->gadget.dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "device_register failed\n");
-		goto clean_up;
-	}
+	r8a66597->gadget.register_my_device = true;
 
 	init_timer(&r8a66597->timer);
 	r8a66597->timer.function = r8a66597_timer;
@@ -1939,7 +1933,7 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "cannot get clock \"%s\"\n",
 				clk_name);
 			ret = PTR_ERR(r8a66597->clk);
-			goto clean_up_dev;
+			goto clean_up;
 		}
 		clk_enable(r8a66597->clk);
 	}
@@ -2007,8 +2001,6 @@ clean_up2:
 		clk_disable(r8a66597->clk);
 		clk_put(r8a66597->clk);
 	}
-clean_up_dev:
-	device_unregister(&r8a66597->gadget.dev);
 clean_up:
 	if (r8a66597) {
 		if (r8a66597->sudmac_reg)
-- 
1.8.1.rc1.5.g7e0651a
