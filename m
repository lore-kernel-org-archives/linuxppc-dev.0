Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id C126767F75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 04:53:29 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 9 Aug 2005 11:53:27 -0700
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050809185327.GA19340@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATH] ppc32: Add usb support to IBM stb04xxx platforms
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[ I previously submitted this on March 31st.  Though I received a copy
back from the linuxppc-embedded mailing list, I don't find a copy in
the archive.  (The same thing happend to my submission of asm-ppc/usb.h.)
So I'm resending. ]

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-usb-405/arch/ppc/platforms/4xx/ibmstb4.c
===================================================================
--- linux-2.5-usb-405.orig/arch/ppc/platforms/4xx/ibmstb4.c
+++ linux-2.5-usb-405/arch/ppc/platforms/4xx/ibmstb4.c
@@ -72,12 +72,43 @@
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
@@ -52,8 +52,18 @@
 void __init
 redwood5_setup_arch(void)
 {
+	u32 mask;
+
 	ppc4xx_setup_arch();
 
+	/*
+	 * Set up USB interrupt as positive polarity and level-sensitive.
+	 * Firmware should do this, but apparently does not.
+	 */
+	mask = 1 << (31 - USB0_IRQ);
+	mtdcr(DCRN_UIC_PR(UIC0), mfdcr(DCRN_UIC_PR(UIC0)) | mask);
+	mtdcr(DCRN_UIC_TR(UIC0), mfdcr(DCRN_UIC_TR(UIC0)) & ~mask);
+
 #ifdef CONFIG_DEBUG_BRINGUP
 	printk("\n");
 	printk("machine\t: %s\n", PPC4xx_MACHINE_NAME);
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
