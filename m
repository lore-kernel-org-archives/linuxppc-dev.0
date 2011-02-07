Return-Path: <tmarri@amcc.com>
Received: from denmail01.apm.com (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0CFF9B7405
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 09:48:49 +1100 (EST)
From: tmarri@apm.com
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/10] USB/ppc4xx:Synopsys DWC OTG driver enable gadget support
Date: Mon,  7 Feb 2011 14:48:43 -0800
Message-Id: <1297118923-27477-1-git-send-email-tmarri@apm.com>
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
 drivers/usb/gadget/Kconfig        |   22 ++++++++++++++++++++++
 drivers/usb/gadget/gadget_chips.h |    9 +++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 5df8a8d..de7c10b 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -365,6 +365,28 @@ config USB_GADGET_MUSB_HDRC
 	  This OTG-capable silicon IP is used in dual designs including
 	  the TI DaVinci, OMAP 243x, OMAP 343x, TUSB 6010, and ADI Blackfin
 
+# dwc_otg builds in ../dwc_otg along with host support
+config USB_GADGET_DWC_HDRC
+	boolean "DesignWare USB Peripheral"
+	depends on DWC_OTG_MODE || DWC_DEVICE_ONLY
+	select USB_GADGET_DUALSPEED
+	select USB_GADGET_SELECTED
+	select USB_GADGET_DWC_OTG
+	help
+	This OTG-capable Designware USB IP
+
+config USB_GADGET_DWC_OTG
+	boolean "OTG Support"
+	depends on USB_GADGET_DWC_HDRC
+	help
+	The most notable feature of USB OTG is support for a
+	"Dual-Role" device, which can act as either a device
+	or a host.  The initial role choice can be changed
+	later, when two dual-role devices talk to each other.
+	Select this only if your board has a Mini-AB connector.
+
+
+
 config USB_GADGET_M66592
 	boolean "Renesas M66592 USB Peripheral Controller"
 	select USB_GADGET_DUALSPEED
diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index e896f63..d1fab43 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -136,6 +136,12 @@
 #define gadget_is_s3c_hsotg(g)    0
 #endif
 
+#if defined(CONFIG_DWC_OTG_MODE) || defined(CONFIG_DWC_DEVICE_ONLY)
+#define gadget_is_dwc_otg_pcd(g)	(!strcmp("dwc_otg_pcd", (g)->name))
+#else
+#define gadget_is_dwc_otg_pcd(g)	0
+#endif
+
 #ifdef CONFIG_USB_GADGET_EG20T
 #define	gadget_is_pch(g)	(!strcmp("pch_udc", (g)->name))
 #else
@@ -207,6 +213,9 @@ static inline int usb_gadget_controller_number(struct usb_gadget *gadget)
 		return 0x27;
 	else if (gadget_is_ci13xxx_msm(gadget))
 		return 0x28;
+	else if (gadget_is_dwc_otg_pcd(gadget))
+		return 0x29;
+
 	return -ENOENT;
 }
 
-- 
1.6.1.rc3
