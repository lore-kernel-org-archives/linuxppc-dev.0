Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77E032C0113
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:39 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 25/32] usb: gadget: s3c-hsudc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:46:03 +0200
Message-ID: <1359042370-4358-26-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/s3c-hsudc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index 4a3d620..dee6810 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -1304,18 +1304,16 @@ static int s3c_hsudc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&hsudc->lock);
 
-	dev_set_name(&hsudc->gadget.dev, "gadget");
-
 	hsudc->gadget.max_speed = USB_SPEED_HIGH;
 	hsudc->gadget.ops = &s3c_hsudc_gadget_ops;
 	hsudc->gadget.name = dev_name(dev);
 	hsudc->gadget.dev.parent = dev;
 	hsudc->gadget.dev.dma_mask = dev->dma_mask;
 	hsudc->gadget.ep0 = &hsudc->ep[0].ep;
-
 	hsudc->gadget.is_otg = 0;
 	hsudc->gadget.is_a_peripheral = 0;
 	hsudc->gadget.speed = USB_SPEED_UNKNOWN;
+	hsudc->gadget.register_my_device = true;
 
 	s3c_hsudc_setup_ep(hsudc);
 
@@ -1346,12 +1344,6 @@ static int s3c_hsudc_probe(struct platform_device *pdev)
 	disable_irq(hsudc->irq);
 	local_irq_enable();
 
-	ret = device_register(&hsudc->gadget.dev);
-	if (ret) {
-		put_device(&hsudc->gadget.dev);
-		goto err_add_device;
-	}
-
 	ret = usb_add_gadget_udc(&pdev->dev, &hsudc->gadget);
 	if (ret)
 		goto err_add_udc;
@@ -1360,7 +1352,6 @@ static int s3c_hsudc_probe(struct platform_device *pdev)
 
 	return 0;
 err_add_udc:
-	device_unregister(&hsudc->gadget.dev);
 err_add_device:
 	clk_disable(hsudc->uclk);
 err_res:
-- 
1.8.1.rc1.5.g7e0651a
