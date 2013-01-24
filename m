Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1A4D2C0118
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:19 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 11/32] usb: gadget: fsl_udc_core: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:49 +0200
Message-ID: <1359042370-4358-12-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/fsl_udc_core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 49642d4..b78b734 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2526,9 +2526,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	udc_controller->gadget.dev.release = fsl_udc_release;
 	udc_controller->gadget.dev.parent = &pdev->dev;
 	udc_controller->gadget.dev.of_node = pdev->dev.of_node;
-	ret = device_register(&udc_controller->gadget.dev);
-	if (ret < 0)
-		goto err_free_irq;
+	udc_controller->gadget.register_my_device = true;
 
 	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
 		udc_controller->gadget.is_otg = 1;
@@ -2561,7 +2559,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 			DTD_ALIGNMENT, UDC_DMA_BOUNDARY);
 	if (udc_controller->td_pool == NULL) {
 		ret = -ENOMEM;
-		goto err_unregister;
+		goto err_free_irq;
 	}
 
 	ret = usb_add_gadget_udc(&pdev->dev, &udc_controller->gadget);
@@ -2573,8 +2571,6 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 
 err_del_udc:
 	dma_pool_destroy(udc_controller->td_pool);
-err_unregister:
-	device_unregister(&udc_controller->gadget.dev);
 err_free_irq:
 	free_irq(udc_controller->irq, udc_controller);
 err_iounmap:
@@ -2624,7 +2620,6 @@ static int __exit fsl_udc_remove(struct platform_device *pdev)
 	if (pdata->operating_mode == FSL_USB2_DR_DEVICE)
 		release_mem_region(res->start, resource_size(res));
 
-	device_unregister(&udc_controller->gadget.dev);
 	/* free udc --wait for the release() finished */
 	wait_for_completion(&done);
 
-- 
1.8.1.rc1.5.g7e0651a
