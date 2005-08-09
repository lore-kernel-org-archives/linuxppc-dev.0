Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id C293F6800A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 07:38:24 +1000 (EST)
Date: Tue, 9 Aug 2005 14:38:23 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20050809143822.A17201@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Add usb support to IBM stb04xxx platforms
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Support ochi-ppc-soc.c on IBM stb04xxx platforms

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

Index: linux-2.5-usb-405/arch/ppc/platforms/4xx/ibmstb4.c
===================================================================
--- linux-2.5-usb-405.orig/arch/ppc/platforms/4xx/ibmstb4.c
+++ linux-2.5-usb-405/arch/ppc/platforms/4xx/ibmstb4.c
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
 #include <platforms/4xx/ibmstb4.h>
 
 static struct ocp_func_iic_data ibmstb4_iic0_def = {
@@ -72,12 +73,51 @@
 	  .irq		= IDE0_IRQ,
 	  .pm		= OCP_CPM_NA,
 	},
-	{ .vendor	= OCP_VENDOR_IBM,
-	  .function	= OCP_FUNC_USB,
-	  .paddr	= USB0_BASE,
-	  .irq		= USB0_IRQ,
-	  .pm		= OCP_CPM_NA,
-	},
 	{ .vendor	= OCP_VENDOR_INVALID,
 	}
 };
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity 	= 0x7fffff01,
+	  .triggering	= 0x00000000,
+	  .ext_irq_mask	= 0x0000007e,	/* IRQ0 - IRQ5 */
+	}
+};
+
+static struct resource ohci_usb_resources[] = {
+	[0] = {
+		.start	= USB0_BASE,
+		.end	= USB0_BASE + USB0_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= USB0_IRQ,
+		.end	= USB0_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 dma_mask = 0xffffffffULL;
+
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
+static struct platform_device *ibmstb4_devs[] __initdata = {
+	&ohci_usb_device,
+};
+
+static int __init
+ibmstb4_platform_add_devices(void)
+{
+	return platform_add_devices(ibmstb4_devs, ARRAY_SIZE(ibmstb4_devs));
+}
+arch_initcall(ibmstb4_platform_add_devices);
Index: linux-2.5-usb-405/arch/ppc/platforms/4xx/ibmstb4.h
===================================================================
--- linux-2.5-usb-405.orig/arch/ppc/platforms/4xx/ibmstb4.h
+++ linux-2.5-usb-405/arch/ppc/platforms/4xx/ibmstb4.h
@@ -73,9 +73,9 @@
 #define OPB0_BASE	0x40000000
 #define GPIO0_BASE	0x40060000
 
+#define USB0_BASE	0x40010000
+#define USB0_SIZE	0xA0
 #define USB0_IRQ	18
-#define USB0_BASE	STB04xxx_MAP_IO_ADDR(0x40010000)
-#define USB0_EXTENT 4096
 
 #define IIC_NUMS 2
 #define UART_NUMS	3
Index: linux-2.5-usb-405/arch/ppc/platforms/4xx/redwood5.c
===================================================================
--- linux-2.5-usb-405.orig/arch/ppc/platforms/4xx/redwood5.c
+++ linux-2.5-usb-405/arch/ppc/platforms/4xx/redwood5.c
@@ -18,6 +18,19 @@
 #include <linux/ioport.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
+#include <asm/ppc4xx_pic.h>
+
+/*
+ * Define external IRQ senses and polarities.
+ */
+unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 3 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 4 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext Int 5 */
+};
 
 static struct resource smc91x_resources[] = {
 	[0] = {
