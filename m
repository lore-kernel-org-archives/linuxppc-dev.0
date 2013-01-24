Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EFB042C0102
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:19 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 07/32] usb: gadget: atmel_usba_udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:45 +0200
Message-ID: <1359042370-4358-8-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/atmel_usba_udc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index a7aed84..f0f9423 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1900,9 +1900,9 @@ static int __init usba_udc_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "FIFO at 0x%08lx mapped at %p\n",
 		 (unsigned long)fifo->start, udc->fifo);
 
-	device_initialize(&udc->gadget.dev);
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
+	udc->gadget.register_my_device = true;
 
 	platform_set_drvdata(pdev, udc);
 
@@ -1962,12 +1962,6 @@ static int __init usba_udc_probe(struct platform_device *pdev)
 	}
 	udc->irq = irq;
 
-	ret = device_add(&udc->gadget.dev);
-	if (ret) {
-		dev_dbg(&pdev->dev, "Could not add gadget: %d\n", ret);
-		goto err_device_add;
-	}
-
 	if (gpio_is_valid(pdata->vbus_pin)) {
 		if (!gpio_request(pdata->vbus_pin, "atmel_usba_udc")) {
 			udc->vbus_pin = pdata->vbus_pin;
@@ -2007,9 +2001,6 @@ err_add_udc:
 		gpio_free(udc->vbus_pin);
 	}
 
-	device_unregister(&udc->gadget.dev);
-
-err_device_add:
 	free_irq(irq, udc);
 err_request_irq:
 	kfree(usba_ep);
@@ -2053,8 +2044,6 @@ static int __exit usba_udc_remove(struct platform_device *pdev)
 	clk_put(udc->hclk);
 	clk_put(udc->pclk);
 
-	device_unregister(&udc->gadget.dev);
-
 	return 0;
 }
 
-- 
1.8.1.rc1.5.g7e0651a
