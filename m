Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 28F412C01E0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:37 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 26/32] usb: gadget: s3c2410_udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:46:04 +0200
Message-ID: <1359042370-4358-27-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/s3c2410_udc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
index fc07b43..302e137 100644
--- a/drivers/usb/gadget/s3c2410_udc.c
+++ b/drivers/usb/gadget/s3c2410_udc.c
@@ -1677,13 +1677,6 @@ static int s3c2410_udc_start(struct usb_gadget *g,
 	udc->driver = driver;
 	udc->gadget.dev.driver = &driver->driver;
 
-	/* Bind the driver */
-	retval = device_add(&udc->gadget.dev);
-	if (retval) {
-		dev_err(&udc->gadget.dev, "Error in device_add() : %d\n", retval);
-		goto register_error;
-	}
-
 	/* Enable udc */
 	s3c2410_udc_enable(udc);
 
@@ -1700,7 +1693,6 @@ static int s3c2410_udc_stop(struct usb_gadget *g,
 {
 	struct s3c2410_udc *udc = to_s3c2410(g);
 
-	device_del(&udc->gadget.dev);
 	udc->driver = NULL;
 
 	/* Disable udc */
@@ -1838,9 +1830,9 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 		goto err_mem;
 	}
 
-	device_initialize(&udc->gadget.dev);
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
+	udc->gadget.register_my_device = true;
 
 	the_controller = udc;
 	platform_set_drvdata(pdev, udc);
-- 
1.8.1.rc1.5.g7e0651a
