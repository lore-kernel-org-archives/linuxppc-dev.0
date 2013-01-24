Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4CFB22C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:00 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 04/32] usb: gadget: omap_udc: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:42 +0200
Message-ID: <1359042370-4358-5-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/omap_udc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index d0c87b1..234e82b 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2631,10 +2631,9 @@ omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 	udc->gadget.max_speed = USB_SPEED_FULL;
 	udc->gadget.name = driver_name;
 
-	device_initialize(&udc->gadget.dev);
-	dev_set_name(&udc->gadget.dev, "gadget");
 	udc->gadget.dev.release = omap_udc_release;
 	udc->gadget.dev.parent = &odev->dev;
+	udc->gadget.register_my_device = true;
 	if (use_dma)
 		udc->gadget.dev.dma_mask = odev->dev.dma_mask;
 
@@ -2911,14 +2910,12 @@ bad_on_1710:
 	}
 
 	create_proc_file();
-	status = device_add(&udc->gadget.dev);
+	status = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
 	if (status)
 		goto cleanup4;
 
-	status = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
-	if (!status)
-		return status;
-	/* If fail, fall through */
+	return 0;
+
 cleanup4:
 	remove_proc_file();
 
@@ -2989,7 +2986,6 @@ static int omap_udc_remove(struct platform_device *pdev)
 	release_mem_region(pdev->resource[0].start,
 			pdev->resource[0].end - pdev->resource[0].start + 1);
 
-	device_unregister(&udc->gadget.dev);
 	wait_for_completion(&done);
 
 	return 0;
-- 
1.8.1.rc1.5.g7e0651a
