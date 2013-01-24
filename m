Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC52F2C0118
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:20 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 12/32] usb: gadget: fusb300_udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:50 +0200
Message-ID: <1359042370-4358-13-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/fusb300_udc.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/fusb300_udc.c b/drivers/usb/gadget/fusb300_udc.c
index 8c2372f..798a25b 100644
--- a/drivers/usb/gadget/fusb300_udc.c
+++ b/drivers/usb/gadget/fusb300_udc.c
@@ -1422,15 +1422,12 @@ static int __init fusb300_probe(struct platform_device *pdev)
 
 	fusb300->gadget.ops = &fusb300_gadget_ops;
 
-	device_initialize(&fusb300->gadget.dev);
-
-	dev_set_name(&fusb300->gadget.dev, "gadget");
-
 	fusb300->gadget.max_speed = USB_SPEED_HIGH;
 	fusb300->gadget.dev.parent = &pdev->dev;
 	fusb300->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	fusb300->gadget.dev.release = pdev->dev.release;
 	fusb300->gadget.name = udc_name;
+	fusb300->gadget.register_my_device = true;
 	fusb300->reg = reg;
 
 	ret = request_irq(ires->start, fusb300_irq, IRQF_SHARED,
@@ -1478,19 +1475,10 @@ static int __init fusb300_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_add_udc;
 
-	ret = device_add(&fusb300->gadget.dev);
-	if (ret) {
-		pr_err("device_add error (%d)\n", ret);
-		goto err_add_device;
-	}
-
 	dev_info(&pdev->dev, "version %s\n", DRIVER_VERSION);
 
 	return 0;
 
-err_add_device:
-	usb_del_gadget_udc(&fusb300->gadget);
-
 err_add_udc:
 	fusb300_free_request(&fusb300->ep[0]->ep, fusb300->ep0_req);
 
-- 
1.8.1.rc1.5.g7e0651a
