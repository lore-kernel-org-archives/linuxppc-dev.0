Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB56F2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:09 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 05/32] usb: gadget: amd5536udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:43 +0200
Message-ID: <1359042370-4358-6-git-send-email-balbi@ti.com>
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

By simply setting a flag, we drop some boilerplate
code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/amd5536udc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/amd5536udc.c b/drivers/usb/gadget/amd5536udc.c
index 3dac001..1827d4c 100644
--- a/drivers/usb/gadget/amd5536udc.c
+++ b/drivers/usb/gadget/amd5536udc.c
@@ -3080,7 +3080,6 @@ static void udc_pci_remove(struct pci_dev *pdev)
 	if (dev->active)
 		pci_disable_device(pdev);
 
-	device_unregister(&dev->gadget.dev);
 	pci_set_drvdata(pdev, NULL);
 
 	udc_remove(dev);
@@ -3276,6 +3275,7 @@ static int udc_probe(struct udc *dev)
 	dev->gadget.dev.release = gadget_release;
 	dev->gadget.name = name;
 	dev->gadget.max_speed = USB_SPEED_HIGH;
+	dev->gadget.register_my_device = true;
 
 	/* init registers, interrupts, ... */
 	startup_registers(dev);
@@ -3301,13 +3301,6 @@ static int udc_probe(struct udc *dev)
 	if (retval)
 		goto finished;
 
-	retval = device_register(&dev->gadget.dev);
-	if (retval) {
-		usb_del_gadget_udc(&dev->gadget);
-		put_device(&dev->gadget.dev);
-		goto finished;
-	}
-
 	/* timer init */
 	init_timer(&udc_timer);
 	udc_timer.function = udc_timer_function;
-- 
1.8.1.rc1.5.g7e0651a
