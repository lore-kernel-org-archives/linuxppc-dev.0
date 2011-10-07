Return-Path: <tmarri@amcc.com>
Received: from denmail01.apm.com (denmail01-v4020.amcc.com [192.195.68.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 62DB9B71EE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2011 13:38:52 +1100 (EST)
From: tmarri@apm.com
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v14 10/10] USB/ppc4xx:Synopsys DWC OTG driver enable gadget
 support
Date: Thu,  6 Oct 2011 19:31:13 -0700
Message-Id: <1317954673-12032-1-git-send-email-tmarri@apm.com>
Cc: tmarri@apm.com, greg@kroah.com, Mark Miesfeld <mmiesfeld@apm.com>,
 Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tirumala Marri <tmarri@apm.com>

Enable gadget support

Signed-off-by: Tirumala R Marri <tmarri@apm.com>
Signed-off-by: Fushen Chen <fchen@apm.com>
Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
---
 drivers/usb/Makefile              |    1 +
 drivers/usb/gadget/Kconfig        |   11 +++++++++++
 drivers/usb/gadget/gadget_chips.h |    3 +++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 30ddf8d..a2daf43 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -50,4 +50,5 @@ obj-$(CONFIG_USB_SPEEDTOUCH)	+= atm/
 obj-$(CONFIG_USB_MUSB_HDRC)	+= musb/
 obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
 obj-$(CONFIG_USB_OTG_UTILS)	+= otg/
+obj-$(CONFIG_USB_DWC_OTG)	+= dwc/
 obj-$(CONFIG_USB_GADGET)	+= gadget/
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 5a084b9..5f1f89f 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -316,6 +316,17 @@ config USB_GADGET_MUSB_HDRC
 	  This OTG-capable silicon IP is used in dual designs including
 	  the TI DaVinci, OMAP 243x, OMAP 343x, TUSB 6010, and ADI Blackfin
 
+# dwc_otg builds in ../dwc along with host support
+config USB_GADGET_DWC_HDRC
+	boolean "DesignWare USB Peripheral"
+	depends on DWC_OTG_MODE || DWC_DEVICE_ONLY
+	select USB_GADGET_DUALSPEED
+	select USB_GADGET_SELECTED
+	select USB_GADGET_DWC_OTG
+	help
+	  This OTG-capable Designware USB IP which has host and device
+	  modes.
+
 config USB_M66592
 	tristate "Renesas M66592 USB Peripheral Controller"
 	select USB_GADGET_DUALSPEED
diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index f3a83cd..cbf2ce7 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -49,6 +49,7 @@
 #define gadget_is_s3c2410(g)		(!strcmp("s3c2410_udc", (g)->name))
 #define gadget_is_s3c_hsotg(g)		(!strcmp("s3c-hsotg", (g)->name))
 #define gadget_is_s3c_hsudc(g)		(!strcmp("s3c-hsudc", (g)->name))
+#define gadget_is_dwc_otg_pcd(g)	(!strcmp("dwc_otg_pcd", (g)->name))
 
 /**
  * usb_gadget_controller_number - support bcdDevice id convention
@@ -115,6 +116,8 @@ static inline int usb_gadget_controller_number(struct usb_gadget *gadget)
 		return 0x30;
 	else if (gadget_is_net2272(gadget))
 		return 0x31;
+	else if (gadget_is_dwc_otg_pcd(gadget))
+		return 0x32;
 
 	return -ENOENT;
 }
-- 
1.6.1.rc3
