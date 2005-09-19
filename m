Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id D4BA4682A9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 10:50:52 +1000 (EST)
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Matt Porter <mporter@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="=-ROrG5sihtmhl1eeLxwPn"
Message-Id: <1127174130.28179.380.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 19 Sep 2005 16:55:30 -0700
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] Add support for USB to 440EP platform files
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--=-ROrG5sihtmhl1eeLxwPn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds support for the USB host and device interfaces on the 440EP to
the appropriate platform-specific files.

Signed off by: John Otken <jotken@softadvances.com>
Signed off by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-ROrG5sihtmhl1eeLxwPn
Content-Disposition: attachment; filename=440ep-ppc-usb.patch
Content-Type: text/x-patch; name=440ep-ppc-usb.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

diff -uprN linux-2.6/include/asm-ppc/ibm44x.h linux-2.6-dev/include/asm-ppc/ibm44x.h
--- linux-2.6/include/asm-ppc/ibm44x.h	2005-09-12 11:18:19.000000000 -0700
+++ linux-2.6-dev/include/asm-ppc/ibm44x.h	2005-09-13 13:51:23.000000000 -0700
@@ -169,6 +169,7 @@
 #ifdef CONFIG_440EP
 #define DCRN_SDR_UART2		0x0122
 #define DCRN_SDR_UART3		0x0123
+#define DCRN_SDR_USB0		0x0320
 #define DCRN_SDR_CUST0		0x4000
 #endif
 
Binary files linux-2.6/arch/ppc/boot/images/ramdisk.gz and linux-2.6-dev/arch/ppc/boot/images/ramdisk.gz differ
Binary files linux-2.6/arch/ppc/boot/images/ramdisk.image.gz and linux-2.6-dev/arch/ppc/boot/images/ramdisk.image.gz differ
diff -uprN linux-2.6/arch/ppc/platforms/4xx/ibm440ep.c linux-2.6-dev/arch/ppc/platforms/4xx/ibm440ep.c
--- linux-2.6/arch/ppc/platforms/4xx/ibm440ep.c	2005-09-12 11:17:54.000000000 -0700
+++ linux-2.6-dev/arch/ppc/platforms/4xx/ibm440ep.c	2005-09-13 14:00:10.000000000 -0700
@@ -182,23 +182,48 @@ struct ppc4xx_uic_settings ppc4xx_core_u
 	},
 };
 
-static struct resource usb_gadget_resources[] = {
+static struct resource ohci_usb_resources[] = {
 	[0] = {
-		.start	= 0x050000100ULL,
-		.end 	= 0x05000017FULL,
+		.start	= 0x0EF601000ULL,
+		.end 	= 0x0EF60107FULL,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= 55,
-		.end	= 55,
+		.start	= 40,
+		.end	= 40,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
 
+static struct resource usb_gadget_resources[] = {
+	[0] = {
+		.start  = 0x050000100ULL,
+		.end    = 0x05000017FULL,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 55,
+		.end    = 55,
+		.flags  = IORESOURCE_IRQ,
+		.name   = "usb_device_irq",
+	},
+};
+
 static u64 dma_mask = 0xffffffffULL;
 
+static struct platform_device ohci_usb_device = {
+	.name           = "ppc-soc-ohci",
+	.id             = 1,
+	.num_resources  = ARRAY_SIZE(ohci_usb_resources),
+	.resource       = ohci_usb_resources,
+	.dev            = {
+		.dma_mask = &dma_mask,
+		.coherent_dma_mask = 0xffffffffULL,
+	}
+};
+
 static struct platform_device usb_gadget_device = {
-	.name		= "musbhsfc",
+	.name		= "musbhsfc_udc",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(usb_gadget_resources),
 	.resource       = usb_gadget_resources,
@@ -210,6 +235,7 @@ static struct platform_device usb_gadget
 
 static struct platform_device *ibm440ep_devs[] __initdata = {
 	&usb_gadget_device,
+	&ohci_usb_device,
 };
 
 static int __init

--=-ROrG5sihtmhl1eeLxwPn--
