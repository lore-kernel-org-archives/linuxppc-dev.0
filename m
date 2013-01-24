Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8A90A2C0231
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:43 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 29/32] usb: gadget: pxa27x_udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:46:07 +0200
Message-ID: <1359042370-4358-30-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/pxa27x_udc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index f7d2579..23a3eed 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -1814,11 +1814,6 @@ static int pxa27x_udc_start(struct usb_gadget *g,
 	udc->gadget.dev.driver = &driver->driver;
 	dplus_pullup(udc, 1);
 
-	retval = device_add(&udc->gadget.dev);
-	if (retval) {
-		dev_err(udc->dev, "device_add error %d\n", retval);
-		goto fail;
-	}
 	if (!IS_ERR_OR_NULL(udc->transceiver)) {
 		retval = otg_set_peripheral(udc->transceiver->otg,
 						&udc->gadget);
@@ -1876,8 +1871,6 @@ static int pxa27x_udc_stop(struct usb_gadget *g,
 
 	udc->driver = NULL;
 
-	device_del(&udc->gadget.dev);
-
 	if (!IS_ERR_OR_NULL(udc->transceiver))
 		return otg_set_peripheral(udc->transceiver->otg, NULL);
 	return 0;
@@ -2462,9 +2455,9 @@ static int __init pxa_udc_probe(struct platform_device *pdev)
 		goto err_map;
 	}
 
-	device_initialize(&udc->gadget.dev);
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = NULL;
+	udc->gadget.register_my_device = true;
 	udc->vbus_sensed = 0;
 
 	the_controller = udc;
-- 
1.8.1.rc1.5.g7e0651a
