Return-Path: <jotken@softadvances.com>
Received: from smtpauth03.mail.atl.earthlink.net
	(smtpauth03.mail.atl.earthlink.net [209.86.89.63])
	by ozlabs.org (Postfix) with ESMTP id AEA7067EEE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 01:25:12 +1000 (EST)
Message-ID: <43020555.8080500@softadvances.com>
Date: Tue, 16 Aug 2005 10:25:09 -0500
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] Support 440EP On-Chip OHCI USB Host Controller (v3)
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

I'm cross posting this to linux-usb-devel.  Let me know if
that's a mistake.

This patch depends on my "fix invalid function name
usb_hcd_put in ohci-ppc-soc.c" patch from 2005-07-20:

http://patchwork.ozlabs.org/linuxppc/patch?id=1803

It also depends on Dale Farnsworth's "2.6.12-3 header
<asm/usb.h> missing" patch on 2005-08-10 to remove usb.h:

http://patchwork.ozlabs.org/linuxppc/patch?id=1969

Thanks to Wade Farnsworth for a bug fix.

This patch supersedes my previous versions released on
2005-07-25, 2005-07-27, and 2005-08-09:

http://patchwork.ozlabs.org/linuxppc/patch?id=1841
http://patchwork.ozlabs.org/linuxppc/patch?id=1855
http://patchwork.ozlabs.org/linuxppc/patch?id=1965

Comments are welcome.


Signed-off-by: John Otken <jotken@softadvances.com>


diff -uprN b/arch/ppc/platforms/4xx/ibm440ep.c c/arch/ppc/platforms/4xx/ibm440ep.c
--- b/arch/ppc/platforms/4xx/ibm440ep.c	2005-08-09 05:45:59.000000000 -0500
+++ c/arch/ppc/platforms/4xx/ibm440ep.c	2005-08-15 16:22:02.031794568 -0500
@@ -194,8 +194,32 @@ static struct resource usb_gadget_resour
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
 
+static struct platform_device ohci_usb_device = {
+	.name		= "ppc-soc-ohci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ohci_usb_resources),
+	.resource	= ohci_usb_resources,
+	.dev		= {
+		.dma_mask = &dma_mask,
+		.coherent_dma_mask = 0xffffffffULL,
+	}
+};
+
 static struct platform_device usb_gadget_device = {
 	.name		= "musbhsfc",
 	.id		= 0,
@@ -208,6 +232,7 @@ static struct platform_device usb_gadget
 };
 
 static struct platform_device *ibm440ep_devs[] __initdata = {
+	&ohci_usb_device,
 	&usb_gadget_device,
 };
 
diff -uprN b/drivers/usb/host/Kconfig c/drivers/usb/host/Kconfig
--- b/drivers/usb/host/Kconfig	2005-08-09 05:46:03.000000000 -0500
+++ c/drivers/usb/host/Kconfig	2005-08-15 16:20:41.177288635 -0500
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
diff -uprN b/drivers/usb/host/ohci.h c/drivers/usb/host/ohci.h
--- b/drivers/usb/host/ohci.h	2005-08-09 05:46:03.000000000 -0500
+++ c/drivers/usb/host/ohci.h	2005-08-15 16:20:41.183288079 -0500
@@ -560,7 +560,7 @@ static inline u32 hc32_to_cpup (const st
  * some big-endian SOC implementations.  Same thing happens with PSW access.
  */
 
-#ifdef CONFIG_STB03xxx
+#if defined(CONFIG_STB03xxx) || defined(CONFIG_440EP)
 #define OHCI_BE_FRAME_NO_SHIFT	16
 #else
 #define OHCI_BE_FRAME_NO_SHIFT	0
diff -uprN b/drivers/usb/Kconfig c/drivers/usb/Kconfig
--- b/drivers/usb/Kconfig	2005-08-09 05:46:02.000000000 -0500
+++ c/drivers/usb/Kconfig	2005-08-15 16:20:41.184287986 -0500
@@ -25,6 +25,7 @@ config USB_ARCH_HAS_OHCI
 	# PPC:
 	default y if STB03xxx
 	default y if PPC_MPC52xx
+	default y if 440EP
 	# MIPS:
 	default y if SOC_AU1X00
 	# more:
