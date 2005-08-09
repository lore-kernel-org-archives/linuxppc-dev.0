Return-Path: <jotken@softadvances.com>
Received: from smtpauth07.mail.atl.earthlink.net
	(smtpauth07.mail.atl.earthlink.net [209.86.89.67])
	by ozlabs.org (Postfix) with ESMTP id 6B86F67EF1
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 22:03:10 +1000 (EST)
Message-ID: <42F89B89.2050000@softadvances.com>
Date: Tue, 09 Aug 2005 07:03:21 -0500
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: roffermanns@sysgo.com
Subject: [PATCH] Support 440EP On-Chip OHCI USB Host Controller (v2)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This updated patch adds support for the AMCC 440EP on-chip
OHCI USB host controller.  I tested it on the Bamboo board
using the 2.6.13-rc6 kernel.

This patch depends on my "fix invalid function name
usb_hcd_put in ohci-ppc-soc.c" patch from 2005-07-20:

http://patchwork.ozlabs.org/linuxppc/patch?id=1803

Thanks to Wade Farnsworth for a bug fix.

This patch supersedes my previous patch released on
2005-07-25 and duped on 2005-07-27.

Comments are welcome.


Signed-off-by: John Otken <jotken@softadvances.com>


diff -uprN a/arch/ppc/platforms/4xx/ibm440ep.c b/arch/ppc/platforms/4xx/ibm440ep.c
--- a/arch/ppc/platforms/4xx/ibm440ep.c	2005-08-04 14:56:30.000000000 -0500
+++ b/arch/ppc/platforms/4xx/ibm440ep.c	2005-08-05 07:21:55.000000000 -0500
@@ -194,8 +194,37 @@ static struct resource usb_gadget_resour
 	},
 };
 
+static struct resource ohci_usb_resources[] = {
+	[0] = {
+		.start	= 0x0EF601000,
+		.end	= 0x0EF60107F,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 40,
+		.end	= 40,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 static u64 dma_mask = 0xffffffffULL;
 
+#include <asm/usb.h>
+
+static struct usb_hcd_platform_data platform_data;
+
+static struct platform_device ohci_usb_device = {
+	.name		= "ppc-soc-ohci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ohci_usb_resources),
+	.resource	= ohci_usb_resources,
+	.dev		= {
+		.dma_mask = &dma_mask,
+		.coherent_dma_mask = 0xffffffffULL,
+		.platform_data = &platform_data,
+	}
+};
+
 static struct platform_device usb_gadget_device = {
 	.name		= "musbhsfc",
 	.id		= 0,
@@ -208,6 +237,7 @@ static struct platform_device usb_gadget
 };
 
 static struct platform_device *ibm440ep_devs[] __initdata = {
+	&ohci_usb_device,
 	&usb_gadget_device,
 };
 
diff -uprN a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
--- a/drivers/usb/host/Kconfig	2005-08-04 14:56:33.000000000 -0500
+++ b/drivers/usb/host/Kconfig	2005-08-08 18:30:58.000000000 -0500
@@ -81,12 +81,12 @@ config USB_OHCI_HCD
 
 config USB_OHCI_HCD_PPC_SOC
 	bool "OHCI support for on-chip PPC USB controller"
-	depends on USB_OHCI_HCD && (STB03xxx || PPC_MPC52xx)
+	depends on USB_OHCI_HCD && (STB03xxx || PPC_MPC52xx || 440EP)
 	default y
 	select USB_OHCI_BIG_ENDIAN
 	---help---
-	  Enables support for the USB controller on the MPC52xx or
-	  STB03xxx processor chip.  If unsure, say Y.
+	  Enables support for the USB controller on the MPC52xx,
+	  STB03xxx, or 440EP processor chip.  If unsure, say Y.
 
 config USB_OHCI_HCD_PCI
 	bool "OHCI support for PCI-bus USB controllers"
@@ -105,7 +105,7 @@ config USB_OHCI_BIG_ENDIAN
 config USB_OHCI_LITTLE_ENDIAN
 	bool
 	depends on USB_OHCI_HCD
-	default n if STB03xxx || PPC_MPC52xx
+	default n if STB03xxx || PPC_MPC52xx || 440EP
 	default y
 
 config USB_UHCI_HCD
diff -uprN a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
--- a/drivers/usb/host/ohci.h	2005-08-04 14:56:33.000000000 -0500
+++ b/drivers/usb/host/ohci.h	2005-08-08 18:31:04.000000000 -0500
@@ -560,7 +560,7 @@ static inline u32 hc32_to_cpup (const st
  * some big-endian SOC implementations.  Same thing happens with PSW access.
  */
 
-#ifdef CONFIG_STB03xxx
+#if defined(CONFIG_STB03xxx) || defined(CONFIG_440EP)
 #define OHCI_BE_FRAME_NO_SHIFT	16
 #else
 #define OHCI_BE_FRAME_NO_SHIFT	0
diff -uprN a/drivers/usb/Kconfig b/drivers/usb/Kconfig
--- a/drivers/usb/Kconfig	2005-08-04 14:56:33.000000000 -0500
+++ b/drivers/usb/Kconfig	2005-08-05 06:55:33.000000000 -0500
@@ -25,6 +25,7 @@ config USB_ARCH_HAS_OHCI
 	# PPC:
 	default y if STB03xxx
 	default y if PPC_MPC52xx
+	default y if 440EP
 	# MIPS:
 	default y if SOC_AU1X00
 	# more:
diff -uprN a/include/asm-ppc/usb.h b/include/asm-ppc/usb.h
--- a/include/asm-ppc/usb.h	1969-12-31 17:00:00.000000000 -0700
+++ b/include/asm-ppc/usb.h	2005-08-05 06:13:58.000000000 -0500
@@ -0,0 +1,13 @@
+/*
+ * ppc/usb.h:
+ *
+ */
+#ifndef _PPC_USB_H
+#define _PPC_USB_H
+
+struct usb_hcd_platform_data {
+	int (*start) (struct platform_device *pdev);
+	void (*stop) (struct platform_device *pdev);
+};
+
+#endif /* !(_PPC_USB_H) */
