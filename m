Return-Path: <tmarri@amcc.com>
Received: from denmail01.apm.com (denmail01-v4020.amcc.com [192.195.68.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 19F01B7203
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Oct 2011 09:09:28 +1100 (EST)
From: tmarri@apm.com
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 10/10] USB/ppc4xx:Synopsys DWC OTG driver enable gadget
 support
Date: Fri, 14 Oct 2011 15:09:22 -0700
Message-Id: <1318630162-14461-1-git-send-email-tmarri@apm.com>
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
 drivers/usb/gadget/Kconfig        |   10 ++++++++++
 drivers/usb/gadget/gadget_chips.h |    3 +++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 5a084b9..4908164 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -316,6 +316,16 @@ config USB_GADGET_MUSB_HDRC
 	  This OTG-capable silicon IP is used in dual designs including
 	  the TI DaVinci, OMAP 243x, OMAP 343x, TUSB 6010, and ADI Blackfin
 
+# dwc_otg builds in ../dwc along with host support
+config USB_GADGET_DWC_HDRC
+	boolean "DesignWare USB Peripheral"
+	depends on DWC_OTG_MODE || DWC_DEVICE_ONLY
+	select USB_GADGET_DUALSPEED
+	select USB_GADGET_SELECTED
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
