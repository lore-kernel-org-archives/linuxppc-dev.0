Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 152FF2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:46:54 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 01/32] usb: gadget: udc-core: allow udc class register
 gadget device
Date: Thu, 24 Jan 2013 17:45:39 +0200
Message-ID: <1359042370-4358-2-git-send-email-balbi@ti.com>
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

Currently all UDC drivers are calling
device_register() before calling
usb_add_gadget_udc(). In order to avoid
code duplication, we can allow udc-core.c
register that device.

However that would become a really large patch,
so to cope with the meanwhile and allow us
to write bite-sized patches, we're adding
a flag which will be set by UDC driver once
it removes the code for registering the
gadget device.

Once all are converted, the new flag will
be removed.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/udc-core.c | 23 +++++++++++++++++++----
 include/linux/usb/gadget.h    |  4 ++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc-core.c b/drivers/usb/gadget/udc-core.c
index 2a9cd36..9195054 100644
--- a/drivers/usb/gadget/udc-core.c
+++ b/drivers/usb/gadget/udc-core.c
@@ -173,6 +173,14 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 	if (!udc)
 		goto err1;
 
+	if (gadget->register_my_device) {
+		dev_set_name(&gadget->dev, "gadget");
+
+		ret = device_register(&gadget->dev);
+		if (ret)
+			goto err2;
+	}
+
 	device_initialize(&udc->dev);
 	udc->dev.release = usb_udc_release;
 	udc->dev.class = udc_class;
@@ -180,7 +188,7 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 	udc->dev.parent = parent;
 	ret = dev_set_name(&udc->dev, "%s", kobject_name(&parent->kobj));
 	if (ret)
-		goto err2;
+		goto err3;
 
 	udc->gadget = gadget;
 
@@ -189,18 +197,22 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 
 	ret = device_add(&udc->dev);
 	if (ret)
-		goto err3;
+		goto err4;
 
 	mutex_unlock(&udc_lock);
 
 	return 0;
-err3:
+
+err4:
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
 
-err2:
+err3:
 	put_device(&udc->dev);
 
+err2:
+	if (gadget->register_my_device)
+		put_device(&gadget->dev);
 err1:
 	return ret;
 }
@@ -254,6 +266,9 @@ found:
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	device_unregister(&udc->dev);
+
+	if (gadget->register_my_device)
+		device_unregister(&gadget->dev);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 2e297e8..fcd9ef8 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -494,6 +494,9 @@ struct usb_gadget_ops {
  *	only supports HNP on a different root port.
  * @b_hnp_enable: OTG device feature flag, indicating that the A-Host
  *	enabled HNP support.
+ * @register_my_device: Flag telling udc-core that UDC driver didn't
+ *	register the gadget device to the driver model. Temporary until
+ *	all UDC drivers are fixed up properly.
  * @name: Identifies the controller hardware type.  Used in diagnostics
  *	and sometimes configuration.
  * @dev: Driver model state for this abstract device.
@@ -531,6 +534,7 @@ struct usb_gadget {
 	unsigned			b_hnp_enable:1;
 	unsigned			a_hnp_support:1;
 	unsigned			a_alt_hnp_support:1;
+	unsigned			register_my_device:1;
 	const char			*name;
 	struct device			dev;
 	unsigned			out_epnum;
-- 
1.8.1.rc1.5.g7e0651a
