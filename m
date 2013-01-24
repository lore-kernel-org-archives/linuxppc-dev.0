Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5CDE2C015C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:15 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 09/32] usb: gadget: dummy_hcd: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:47 +0200
Message-ID: <1359042370-4358-10-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/dummy_hcd.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
index 95d584d..8155d4a 100644
--- a/drivers/usb/gadget/dummy_hcd.c
+++ b/drivers/usb/gadget/dummy_hcd.c
@@ -982,16 +982,10 @@ static int dummy_udc_probe(struct platform_device *pdev)
 	dum->gadget.name = gadget_name;
 	dum->gadget.ops = &dummy_ops;
 	dum->gadget.max_speed = USB_SPEED_SUPER;
+	dum->gadget.register_my_device = true;
 
-	dev_set_name(&dum->gadget.dev, "gadget");
 	dum->gadget.dev.parent = &pdev->dev;
 	dum->gadget.dev.release = dummy_gadget_release;
-	rc = device_register(&dum->gadget.dev);
-	if (rc < 0) {
-		put_device(&dum->gadget.dev);
-		return rc;
-	}
-
 	init_dummy_udc_hw(dum);
 
 	rc = usb_add_gadget_udc(&pdev->dev, &dum->gadget);
@@ -1007,7 +1001,6 @@ static int dummy_udc_probe(struct platform_device *pdev)
 err_dev:
 	usb_del_gadget_udc(&dum->gadget);
 err_udc:
-	device_unregister(&dum->gadget.dev);
 	return rc;
 }
 
@@ -1018,7 +1011,6 @@ static int dummy_udc_remove(struct platform_device *pdev)
 	usb_del_gadget_udc(&dum->gadget);
 	platform_set_drvdata(pdev, NULL);
 	device_remove_file(&dum->gadget.dev, &dev_attr_function);
-	device_unregister(&dum->gadget.dev);
 	return 0;
 }
 
-- 
1.8.1.rc1.5.g7e0651a
