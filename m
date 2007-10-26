Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10BA6DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 22:15:01 +1000 (EST)
Date: Fri, 26 Oct 2007 16:13:30 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 1/2] USB: Rework OHCI PPC OF for new bindings
Message-ID: <20071026121330.GA28960@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4720DA11.9030103@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, david-b@pacbell.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rework ohci-ppc-of driver to use big-endian property instead of
ohci-be/ohci-le compatible strings. Also remove unnecessary
user-selectable USB_OHCI_HCD_PPC_OF_LE/BE stuff, because
USB_OHCI_BIG_ENDIAN_DESC/MMIO should always be enabled for ppc
and USB_OHCI_LITTLE_ENDIAN is selected for USB_OHCI_HCD_PCI by default.
The compatible "mpc5200-ohci" property is kept for old bindings support.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/usb/host/Kconfig       |   17 ++--------------
 drivers/usb/host/ohci-ppc-of.c |   42 ++++++++++-------------------------------
 2 files changed, 14 insertions(+), 45 deletions(-)

diff -pruN linux-2.6.orig/drivers/usb/host/Kconfig linux-2.6/drivers/usb/host/Kconfig
--- linux-2.6.orig/drivers/usb/host/Kconfig	2007-10-25 19:20:12.000000000 +0400
+++ linux-2.6/drivers/usb/host/Kconfig	2007-10-25 22:59:34.000000000 +0400
@@ -128,23 +128,12 @@ config USB_OHCI_HCD_PPC_OF
 	bool "OHCI support for PPC USB controller on OF platform bus"
 	depends on USB_OHCI_HCD && PPC_OF
 	default y
+	select USB_OHCI_BIG_ENDIAN_DESC
+	select USB_OHCI_BIG_ENDIAN_MMIO
 	---help---
 	  Enables support for the USB controller PowerPC present on the
 	  OpenFirmware platform bus.
 
-config USB_OHCI_HCD_PPC_OF_BE
-	bool "Support big endian HC"
-	depends on USB_OHCI_HCD_PPC_OF
-	default y
-	select USB_OHCI_BIG_ENDIAN_DESC
-	select USB_OHCI_BIG_ENDIAN_MMIO
-
-config USB_OHCI_HCD_PPC_OF_LE
-	bool "Support little endian HC"
-	depends on USB_OHCI_HCD_PPC_OF
-	default n
-	select USB_OHCI_LITTLE_ENDIAN
-
 config USB_OHCI_HCD_PCI
 	bool "OHCI support for PCI-bus USB controllers"
 	depends on USB_OHCI_HCD && PCI && (STB03xxx || PPC_MPC52xx || USB_OHCI_HCD_PPC_OF)
@@ -180,7 +169,7 @@ config USB_OHCI_BIG_ENDIAN_MMIO
 config USB_OHCI_LITTLE_ENDIAN
 	bool
 	depends on USB_OHCI_HCD
-	default n if STB03xxx || PPC_MPC52xx
+	default n if STB03xxx || PPC_MPC52xx || USB_OHCI_HCD_PPC_OF
 	default y
 
 config USB_UHCI_HCD
diff -pruN linux-2.6.orig/drivers/usb/host/ohci-ppc-of.c linux-2.6/drivers/usb/host/ohci-ppc-of.c
--- linux-2.6.orig/drivers/usb/host/ohci-ppc-of.c	2007-10-25 19:20:12.000000000 +0400
+++ linux-2.6/drivers/usb/host/ohci-ppc-of.c	2007-10-25 23:08:14.000000000 +0400
@@ -15,8 +15,8 @@
 
 #include <linux/signal.h>
 
-#include <asm/of_platform.h>
-#include <asm/prom.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 
 static int __devinit
@@ -91,15 +91,10 @@ ohci_hcd_ppc_of_probe(struct of_device *
 	int irq;
 
 	int rv;
-	int is_bigendian;
 
 	if (usb_disabled())
 		return -ENODEV;
 
-	is_bigendian =
-		of_device_is_compatible(dn, "ohci-bigendian") ||
-		of_device_is_compatible(dn, "ohci-be");
-
 	dev_dbg(&op->dev, "initializing PPC-OF USB Controller\n");
 
 	rv = of_address_to_resource(dn, 0, &res);
@@ -134,10 +129,14 @@ ohci_hcd_ppc_of_probe(struct of_device *
 	}
 
 	ohci = hcd_to_ohci(hcd);
-	if (is_bigendian) {
+
+	if (of_get_property(dn, "big-endian", NULL))
 		ohci->flags |= OHCI_QUIRK_BE_MMIO | OHCI_QUIRK_BE_DESC;
-		if (of_device_is_compatible(dn, "mpc5200-ohci"))
-			ohci->flags |= OHCI_QUIRK_FRAME_NO;
+
+	if (of_device_is_compatible(dn, "mpc5200-usb-ohci") ||
+	    of_device_is_compatible(dn, "mpc5200-ohci")) {
+		ohci->flags |= OHCI_QUIRK_BE_MMIO | OHCI_QUIRK_BE_DESC |
+			       OHCI_QUIRK_FRAME_NO;
 	}
 
 	ohci_hcd_init(ohci);
@@ -187,35 +186,16 @@ static int ohci_hcd_ppc_of_shutdown(stru
 
 
 static struct of_device_id ohci_hcd_ppc_of_match[] = {
-#ifdef CONFIG_USB_OHCI_HCD_PPC_OF_BE
 	{
-		.name = "usb",
-		.compatible = "ohci-bigendian",
+		.compatible = "mpc5200-ohci",
 	},
 	{
-		.name = "usb",
-		.compatible = "ohci-be",
-	},
-#endif
-#ifdef CONFIG_USB_OHCI_HCD_PPC_OF_LE
-	{
-		.name = "usb",
-		.compatible = "ohci-littledian",
+		.compatible = "usb-ohci",
 	},
-	{
-		.name = "usb",
-		.compatible = "ohci-le",
-	},
-#endif
 	{},
 };
 MODULE_DEVICE_TABLE(of, ohci_hcd_ppc_of_match);
 
-#if	!defined(CONFIG_USB_OHCI_HCD_PPC_OF_BE) && \
-	!defined(CONFIG_USB_OHCI_HCD_PPC_OF_LE)
-#error "No endianess selected for ppc-of-ohci"
-#endif
-
 
 static struct of_platform_driver ohci_hcd_ppc_of_driver = {
 	.name		= "ppc-of-ohci",
