Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DE71F2C015C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:06 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 08/32] usb: gadget: bcm63xx_udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:46 +0200
Message-ID: <1359042370-4358-9-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/bcm63xx_udc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63xx_udc.c
index 47a4993..10b0475 100644
--- a/drivers/usb/gadget/bcm63xx_udc.c
+++ b/drivers/usb/gadget/bcm63xx_udc.c
@@ -2367,13 +2367,13 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&udc->lock);
 	INIT_WORK(&udc->ep0_wq, bcm63xx_ep0_process);
-	dev_set_name(&udc->gadget.dev, "gadget");
 
 	udc->gadget.ops = &bcm63xx_udc_ops;
 	udc->gadget.name = dev_name(dev);
 	udc->gadget.dev.parent = dev;
 	udc->gadget.dev.release = bcm63xx_udc_gadget_release;
 	udc->gadget.dev.dma_mask = dev->dma_mask;
+	udc->gadget.register_my_device = true;
 
 	if (!pd->use_fullspeed && !use_fullspeed)
 		udc->gadget.max_speed = USB_SPEED_HIGH;
@@ -2413,10 +2413,6 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 		}
 	}
 
-	rc = device_register(&udc->gadget.dev);
-	if (rc)
-		goto out_uninit;
-
 	bcm63xx_udc_init_debugfs(udc);
 	rc = usb_add_gadget_udc(dev, &udc->gadget);
 	if (!rc)
@@ -2439,7 +2435,6 @@ static int bcm63xx_udc_remove(struct platform_device *pdev)
 
 	bcm63xx_udc_cleanup_debugfs(udc);
 	usb_del_gadget_udc(&udc->gadget);
-	device_unregister(&udc->gadget.dev);
 	BUG_ON(udc->driver);
 
 	platform_set_drvdata(pdev, NULL);
-- 
1.8.1.rc1.5.g7e0651a
