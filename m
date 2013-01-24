Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CFA62C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:29 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 19/32] usb: gadget: mv_udc_core: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:57 +0200
Message-ID: <1359042370-4358-20-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/mv_udc_core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index 67d72f9..60741af 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -2138,8 +2138,6 @@ static int mv_udc_remove(struct platform_device *pdev)
 
 	mv_udc_disable(udc);
 
-	device_unregister(&udc->gadget.dev);
-
 	/* free dev, wait for the release() finished */
 	wait_for_completion(udc->done);
 
@@ -2311,15 +2309,11 @@ static int mv_udc_probe(struct platform_device *pdev)
 	udc->gadget.max_speed = USB_SPEED_HIGH;	/* support dual speed */
 
 	/* the "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&udc->gadget.dev, "gadget");
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	udc->gadget.dev.release = gadget_release;
 	udc->gadget.name = driver_name;		/* gadget name */
-
-	retval = device_register(&udc->gadget.dev);
-	if (retval)
-		goto err_destroy_dma;
+	udc->gadget.register_my_device = true;
 
 	eps_init(udc);
 
@@ -2342,7 +2336,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 		if (!udc->qwork) {
 			dev_err(&pdev->dev, "cannot create workqueue\n");
 			retval = -ENOMEM;
-			goto err_unregister;
+			goto err_destroy_dma;
 		}
 
 		INIT_WORK(&udc->vbus_work, mv_udc_vbus_work);
@@ -2370,8 +2364,6 @@ static int mv_udc_probe(struct platform_device *pdev)
 
 err_create_workqueue:
 	destroy_workqueue(udc->qwork);
-err_unregister:
-	device_unregister(&udc->gadget.dev);
 err_destroy_dma:
 	dma_pool_destroy(udc->dtd_pool);
 err_free_dma:
-- 
1.8.1.rc1.5.g7e0651a
