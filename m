Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3A53E2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:46:55 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 03/32] usb: musb: gadget: let udc-core manage gadget-dev
Date: Thu, 24 Jan 2013 17:45:41 +0200
Message-ID: <1359042370-4358-4-git-send-email-balbi@ti.com>
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

By simply setting a flag, we can delete a little
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_gadget.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 8767874..1c4a8e8 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1871,12 +1871,11 @@ int musb_gadget_setup(struct musb *musb)
 	musb->g.speed = USB_SPEED_UNKNOWN;
 
 	/* this "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&musb->g.dev, "gadget");
 	musb->g.dev.parent = musb->controller;
 	musb->g.dev.dma_mask = musb->controller->dma_mask;
 	musb->g.dev.release = musb_gadget_release;
 	musb->g.name = musb_driver_name;
-
+	musb->g.register_my_device = true;
 	musb->g.is_otg = 1;
 
 	musb_g_init_endpoints(musb);
@@ -1884,11 +1883,6 @@ int musb_gadget_setup(struct musb *musb)
 	musb->is_active = 0;
 	musb_platform_try_idle(musb, 0);
 
-	status = device_register(&musb->g.dev);
-	if (status != 0) {
-		put_device(&musb->g.dev);
-		return status;
-	}
 	status = usb_add_gadget_udc(musb->controller, &musb->g);
 	if (status)
 		goto err;
@@ -1903,8 +1897,6 @@ err:
 void musb_gadget_cleanup(struct musb *musb)
 {
 	usb_del_gadget_udc(&musb->g);
-	if (musb->g.dev.parent)
-		device_unregister(&musb->g.dev);
 }
 
 /*
-- 
1.8.1.rc1.5.g7e0651a
