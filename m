Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C2652C0239
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:43 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 27/32] usb: renesas_usbhs: gadget: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:46:05 +0200
Message-ID: <1359042370-4358-28-git-send-email-balbi@ti.com>
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
 drivers/usb/renesas_usbhs/mod_gadget.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index dd41f61..b42d81d 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -981,15 +981,12 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 	/*
 	 * init gadget
 	 */
-	dev_set_name(&gpriv->gadget.dev, "gadget");
 	gpriv->gadget.dev.parent	= dev;
 	gpriv->gadget.dev.release	= usbhs_mod_gadget_release;
 	gpriv->gadget.name		= "renesas_usbhs_udc";
 	gpriv->gadget.ops		= &usbhsg_gadget_ops;
 	gpriv->gadget.max_speed		= USB_SPEED_HIGH;
-	ret = device_register(&gpriv->gadget.dev);
-	if (ret < 0)
-		goto err_add_udc;
+	gpriv->gadget.register_my_device = true;
 
 	INIT_LIST_HEAD(&gpriv->gadget.ep_list);
 
@@ -1018,15 +1015,13 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 
 	ret = usb_add_gadget_udc(dev, &gpriv->gadget);
 	if (ret)
-		goto err_register;
+		goto err_add_udc;
 
 
 	dev_info(dev, "gadget probed\n");
 
 	return 0;
 
-err_register:
-	device_unregister(&gpriv->gadget.dev);
 err_add_udc:
 	kfree(gpriv->uep);
 
@@ -1042,8 +1037,6 @@ void usbhs_mod_gadget_remove(struct usbhs_priv *priv)
 
 	usb_del_gadget_udc(&gpriv->gadget);
 
-	device_unregister(&gpriv->gadget.dev);
-
 	kfree(gpriv->uep);
 	kfree(gpriv);
 }
-- 
1.8.1.rc1.5.g7e0651a
