Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B75AE2C0214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:40 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 24/32] usb: gadget: s3c-hsotg: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:46:02 +0200
Message-ID: <1359042370-4358-25-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/s3c-hsotg.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 833d85b..bd8292d 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -3552,17 +3552,13 @@ static int s3c_hsotg_probe(struct platform_device *pdev)
 
 	dev_info(dev, "regs %p, irq %d\n", hsotg->regs, hsotg->irq);
 
-	device_initialize(&hsotg->gadget.dev);
-
-	dev_set_name(&hsotg->gadget.dev, "gadget");
-
 	hsotg->gadget.max_speed = USB_SPEED_HIGH;
 	hsotg->gadget.ops = &s3c_hsotg_gadget_ops;
 	hsotg->gadget.name = dev_name(dev);
-
 	hsotg->gadget.dev.parent = dev;
 	hsotg->gadget.dev.dma_mask = dev->dma_mask;
 	hsotg->gadget.dev.release = s3c_hsotg_release;
+	hsotg->gadget.register_my_device = true;
 
 	/* reset the system */
 
@@ -3643,12 +3639,6 @@ static int s3c_hsotg_probe(struct platform_device *pdev)
 
 	s3c_hsotg_phy_disable(hsotg);
 
-	ret = device_add(&hsotg->gadget.dev);
-	if (ret) {
-		put_device(&hsotg->gadget.dev);
-		goto err_ep_mem;
-	}
-
 	ret = usb_add_gadget_udc(&pdev->dev, &hsotg->gadget);
 	if (ret)
 		goto err_ep_mem;
@@ -3687,10 +3677,8 @@ static int s3c_hsotg_remove(struct platform_device *pdev)
 	}
 
 	s3c_hsotg_phy_disable(hsotg);
-
 	clk_disable_unprepare(hsotg->clk);
 
-	device_unregister(&hsotg->gadget.dev);
 	return 0;
 }
 
-- 
1.8.1.rc1.5.g7e0651a
