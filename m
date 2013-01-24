Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BA2E2C00DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:24 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 14/32] usb: gadget: imx_udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:52 +0200
Message-ID: <1359042370-4358-15-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/imx_udc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/imx_udc.c b/drivers/usb/gadget/imx_udc.c
index a0eb857..c8b5da3 100644
--- a/drivers/usb/gadget/imx_udc.c
+++ b/drivers/usb/gadget/imx_udc.c
@@ -1341,20 +1341,12 @@ static int imx_udc_start(struct usb_gadget *gadget,
 	imx_usb->driver = driver;
 	imx_usb->gadget.dev.driver = &driver->driver;
 
-	retval = device_add(&imx_usb->gadget.dev);
-	if (retval)
-		goto fail;
-
 	D_INI(imx_usb->dev, "<%s> registered gadget driver '%s'\n",
 		__func__, driver->driver.name);
 
 	imx_udc_enable(imx_usb);
 
 	return 0;
-fail:
-	imx_usb->driver = NULL;
-	imx_usb->gadget.dev.driver = NULL;
-	return retval;
 }
 
 static int imx_udc_stop(struct usb_gadget *gadget,
@@ -1370,8 +1362,6 @@ static int imx_udc_stop(struct usb_gadget *gadget,
 	imx_usb->gadget.dev.driver = NULL;
 	imx_usb->driver = NULL;
 
-	device_del(&imx_usb->gadget.dev);
-
 	D_INI(imx_usb->dev, "<%s> unregistered gadget driver '%s'\n",
 		__func__, driver->driver.name);
 
@@ -1472,8 +1462,7 @@ static int __init imx_udc_probe(struct platform_device *pdev)
 	imx_usb->clk = clk;
 	imx_usb->dev = &pdev->dev;
 
-	device_initialize(&imx_usb->gadget.dev);
-
+	imx_usb->gadget.register_my_device = true;
 	imx_usb->gadget.dev.parent = &pdev->dev;
 	imx_usb->gadget.dev.dma_mask = pdev->dev.dma_mask;
 
-- 
1.8.1.rc1.5.g7e0651a
