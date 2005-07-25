Return-Path: <jotken@softadvances.com>
Received: from smtpauth03.mail.atl.earthlink.net
	(smtpauth03.mail.atl.earthlink.net [209.86.89.63])
	by ozlabs.org (Postfix) with ESMTP id 71A6467C64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 01:07:40 +1000 (EST)
Message-ID: <42E4D55D.5070704@softadvances.com>
Date: Mon, 25 Jul 2005 07:04:45 -0500
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: weissg@vienna.at
Subject: [PATCH] Support 440EP On-Chip OHCI USB Host Controller
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch adds support for the AMCC 440EP on-chip OHCI USB host controller.  I tested it on the Bamboo and Yosemite boards using the 2.6.12 kernel.

This patch depends on Wade Farnsworth's "PPC440EP SoC and Bamboo board support" patch from 2005-04-07 and my "fix invalid function name usb_hcd_put in ohci-ppc-soc.c" patch from 2005-07-20:

http://patchwork.ozlabs.org/linuxppc/patch?id=1311
http://patchwork.ozlabs.org/linuxppc/patch?id=1803

Comments are welcome.

Signed-off-by: John Otken <jotken@softadvances.com>


diff -uprN b/arch/ppc/platforms/4xx/bamboo.c c/arch/ppc/platforms/4xx/bamboo.c
--- b/arch/ppc/platforms/4xx/bamboo.c	2005-07-24 16:14:36.000000000 -0500
+++ c/arch/ppc/platforms/4xx/bamboo.c	2005-07-25 06:34:52.498441038 -0500
@@ -431,5 +431,7 @@ void __init platform_init(unsigned long 
 #ifdef CONFIG_KGDB
 	ppc_md.early_serial_map = bamboo_early_serial_map;
 #endif
+
+	SDR_WRITE( 0x320, 1 );		/* little endian usb (SDR0_USB0) */
 }
 
diff -uprN b/arch/ppc/platforms/4xx/ibm440ep.c c/arch/ppc/platforms/4xx/ibm440ep.c
--- b/arch/ppc/platforms/4xx/ibm440ep.c	2005-07-24 16:14:36.000000000 -0500
+++ c/arch/ppc/platforms/4xx/ibm440ep.c	2005-07-24 18:00:38.000000000 -0500
@@ -187,3 +187,44 @@ struct ppc4xx_uic_settings ppc4xx_core_u
 	},
 };
 
+static struct resource ohci_usb_resources[] = {
+	[0] = {
+	    .start	= 0x0EF601000,
+	    .end	= 0x0EF601000 + 0x80 - 1,
+	    .flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+	    .start	= 40,
+	    .end	= 40,
+	    .flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 dma_mask = 0xffffffffULL;
+
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
+	    .dma_mask = &dma_mask,
+	    .coherent_dma_mask = 0xffffffffULL,
+	    .platform_data = &platform_data,
+    }
+};
+
+static struct platform_device *ibm440ep_devs[] __initdata = {
+	&ohci_usb_device,
+};
+
+static int __init
+   ibm440ep_platform_add_devices(void)
+{
+	return platform_add_devices(ibm440ep_devs, ARRAY_SIZE(ibm440ep_devs));
+}
+arch_initcall(ibm440ep_platform_add_devices);
diff -uprN b/drivers/usb/host/Kconfig c/drivers/usb/host/Kconfig
--- b/drivers/usb/host/Kconfig	2005-07-14 09:48:19.000000000 -0500
+++ c/drivers/usb/host/Kconfig	2005-07-24 18:00:38.000000000 -0500
@@ -68,7 +68,7 @@ config USB_OHCI_HCD
 
 config USB_OHCI_HCD_PPC_SOC
 	bool "OHCI support for on-chip PPC USB controller"
-	depends on USB_OHCI_HCD && (STB03xxx || PPC_MPC52xx)
+	depends on USB_OHCI_HCD && (STB03xxx || PPC_MPC52xx || 440EP)
 	default y
 	select USB_OHCI_BIG_ENDIAN
 	---help---
@@ -92,7 +92,7 @@ config USB_OHCI_BIG_ENDIAN
 config USB_OHCI_LITTLE_ENDIAN
 	bool
 	depends on USB_OHCI_HCD
-	default n if STB03xxx || PPC_MPC52xx
+	default n if STB03xxx || PPC_MPC52xx || 440EP
 	default y
 
 config USB_UHCI_HCD
diff -uprN b/include/asm-ppc/usb.h c/include/asm-ppc/usb.h
--- b/include/asm-ppc/usb.h	1969-12-31 17:00:00.000000000 -0700
+++ c/include/asm-ppc/usb.h	2005-07-24 18:00:38.000000000 -0500
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
