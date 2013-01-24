Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32A252C0164
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:19 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 10/32] usb: gadget: fsl_qe_udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:48 +0200
Message-ID: <1359042370-4358-11-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/fsl_qe_udc.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index ec50f18..08c8432 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2523,13 +2523,9 @@ static int qe_udc_probe(struct platform_device *ofdev)
 
 	/* name: Identifies the controller hardware type. */
 	udc->gadget.name = driver_name;
-
-	device_initialize(&udc->gadget.dev);
-
-	dev_set_name(&udc->gadget.dev, "gadget");
-
 	udc->gadget.dev.release = qe_udc_release;
 	udc->gadget.dev.parent = &ofdev->dev;
+	udc->gadget.register_my_device = true;
 
 	/* initialize qe_ep struct */
 	for (i = 0; i < USB_MAX_ENDPOINTS ; i++) {
@@ -2592,13 +2588,9 @@ static int qe_udc_probe(struct platform_device *ofdev)
 		goto err5;
 	}
 
-	ret = device_add(&udc->gadget.dev);
-	if (ret)
-		goto err6;
-
 	ret = usb_add_gadget_udc(&ofdev->dev, &udc->gadget);
 	if (ret)
-		goto err7;
+		goto err6;
 
 	dev_set_drvdata(&ofdev->dev, udc);
 	dev_info(udc->dev,
@@ -2606,8 +2598,6 @@ static int qe_udc_probe(struct platform_device *ofdev)
 			(udc->soc_type == PORT_QE) ? "QE" : "CPM");
 	return 0;
 
-err7:
-	device_unregister(&udc->gadget.dev);
 err6:
 	free_irq(udc->usb_irq, udc);
 err5:
@@ -2702,7 +2692,6 @@ static int qe_udc_remove(struct platform_device *ofdev)
 
 	iounmap(udc->usb_regs);
 
-	device_unregister(&udc->gadget.dev);
 	/* wait for release() of gadget.dev to free udc */
 	wait_for_completion(&done);
 
-- 
1.8.1.rc1.5.g7e0651a
