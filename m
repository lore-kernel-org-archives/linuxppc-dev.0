Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 334522C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:49 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 28/32] usb: gadget: pxa25x_udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:46:06 +0200
Message-ID: <1359042370-4358-29-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/pxa25x_udc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index fa9c344..9deffd3 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -1266,13 +1266,6 @@ static int pxa25x_udc_start(struct usb_gadget *g,
 	dev->gadget.dev.driver = &driver->driver;
 	dev->pullup = 1;
 
-	retval = device_add (&dev->gadget.dev);
-	if (retval) {
-		dev->driver = NULL;
-		dev->gadget.dev.driver = NULL;
-		return retval;
-	}
-
 	/* ... then enable host detection and ep0; and we're ready
 	 * for set_configuration as well as eventual disconnect.
 	 */
@@ -1331,7 +1324,6 @@ static int pxa25x_udc_stop(struct usb_gadget*g,
 	dev->gadget.dev.driver = NULL;
 	dev->driver = NULL;
 
-	device_del (&dev->gadget.dev);
 	dump_state(dev);
 
 	return 0;
@@ -2140,9 +2132,9 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 	dev->timer.function = udc_watchdog;
 	dev->timer.data = (unsigned long) dev;
 
-	device_initialize(&dev->gadget.dev);
 	dev->gadget.dev.parent = &pdev->dev;
 	dev->gadget.dev.dma_mask = pdev->dev.dma_mask;
+	dev->gadget.register_my_device = true;
 
 	the_controller = dev;
 	platform_set_drvdata(pdev, dev);
-- 
1.8.1.rc1.5.g7e0651a
