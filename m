Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 7A29367BDD
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 03:13:08 +1100 (EST)
Date: Thu, 23 Nov 2006 17:12:01 +0100 (MET)
From: nd@bplan-gmbh.de
To: nd@bplan-gmbh.de
Subject: [PATCH 2/2] USB OHCI OpenFirmware support
Message-Id: <11642982471282-git-send-email-nd@bplan-gmbh.de>
In-Reply-To: <11642982461138-git-send-email-nd@bplan-gmbh.de>
References: <11642982453599-git-send-email-nd@bplan-gmbh.de>
	<11642982461138-git-send-email-nd@bplan-gmbh.de>
Cc: linux-usb-devel@lists.sourceforge.net, greg@kroah.com, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, stern@rowland.harvard.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Nicolas DET <nd@bplan-gmbh.de>

Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
---
 drivers/usb/host/Kconfig    |   19 +++++++++++++++++++
 drivers/usb/host/ohci-hcd.c |    6 ++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index cf10cbc..f5ef6f5 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -106,6 +106,25 @@ config USB_OHCI_HCD_PPC_SOC
 	  Enables support for the USB controller on the MPC52xx or
 	  STB03xxx processor chip.  If unsure, say Y.
 
+config USB_OHCI_HCD_PPC_OF
+	bool "OHCI support for PPC USB controller for OpenFirmware platform"
+	depends on USB_OHCI_HCD && PPC_OF
+	default y
+	---help---
+	  Enables support for the USB controller PowerPC OpenFirmware platform
+
+config USB_OHCI_HCD_PPC_OF_BE
+	bool "Support big endian HC"
+	depends on USB_OHCI_HCD_PPC_OF
+	default y
+	select USB_OHCI_BIG_ENDIAN
+
+config USB_OHCI_HCD_PPC_OF_LE
+	bool "Support little endian HC"
+	depends on USB_OHCI_HCD_PPC_OF
+	default n
+	select USB_OHCI_LITTLE_ENDIAN
+
 config USB_OHCI_HCD_PCI
 	bool "OHCI support for PCI-bus USB controllers"
 	depends on USB_OHCI_HCD && PCI && (STB03xxx || PPC_MPC52xx)
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 9be6b30..04413b6 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -930,6 +930,10 @@ #ifdef CONFIG_USB_OHCI_HCD_PPC_SOC
 #include "ohci-ppc-soc.c"
 #endif
 
+#ifdef CONFIG_USB_OHCI_HCD_PPC_OF
+#include "ohci-ppc-of.c"
+#endif
+
 #if defined(CONFIG_ARCH_AT91RM9200) || defined(CONFIG_ARCH_AT91SAM9261)
 #include "ohci-at91.c"
 #endif
@@ -950,6 +954,8 @@ #if !(defined(CONFIG_PCI) \
       || defined (CONFIG_ARCH_AT91RM9200) \
       || defined (CONFIG_ARCH_AT91SAM9261) \
       || defined (CONFIG_ARCH_PNX4008) \
+      || defined (CONFIG_USB_OHCI_HCD_PPC_OF_LE) \
+      || defined (CONFIG_USB_OHCI_HCD_PPC_OF_BE) \
 	)
 #error "missing bus glue for ohci-hcd"
 #endif
-- 
1.4.3.2
