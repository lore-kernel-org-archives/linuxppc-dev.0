Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id DAC8867A33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 10:05:28 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 30 Mar 2005 17:05:21 -0700
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050331000521.GA22041@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6.10-rc2] ppc32: Add usb support to IBM stb04xxx platforms
	including Redwood5
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-usb-405/arch/ppc/platforms/4xx/ibmstb4.c
===================================================================
--- linux-2.5-usb-405.orig/arch/ppc/platforms/4xx/ibmstb4.c
+++ linux-2.5-usb-405/arch/ppc/platforms/4xx/ibmstb4.c
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <asm/ocp.h>
+#include <asm/usb.h>
 #include <platforms/4xx/ibmstb4.h>
 
 static struct ocp_func_iic_data ibmstb4_iic0_def = {
@@ -72,12 +73,70 @@
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
+/* Power up the USB subsection */
+static int enable_usb(struct platform_device *pdev)
+{
+	u32 mask;
+
+	mask = 1 << (31 - USB0_IRQ);
+	mtdcr(DCRN_UIC_PR(UIC0), mfdcr(DCRN_UIC_PR(UIC0)) | mask);
+	mtdcr(DCRN_UIC_TR(UIC0), mfdcr(DCRN_UIC_TR(UIC0)) & ~mask);
+	return 0;
+}
+
+/* Power down the USB subsection */
+static void disable_usb(struct platform_device *pdev)
+{
+	u32 mask;
+
+	mask = 1 << (31 - USB0_IRQ);
+	mtdcr(DCRN_UIC_PR(UIC0), mfdcr(DCRN_UIC_PR(UIC0)) & ~mask);
+	mtdcr(DCRN_UIC_TR(UIC0), mfdcr(DCRN_UIC_TR(UIC0)) | mask);
+}
+
+static struct usb_hcd_platform_data pd = {
+	.start = enable_usb,
+	.stop = disable_usb,
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
+		.platform_data = &pd,
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
Index: linux-2.5-usb-405/include/asm-ppc/usb.h
===================================================================
--- /dev/null
+++ linux-2.5-usb-405/include/asm-ppc/usb.h
@@ -0,0 +1,14 @@
+/*
+ * ppc/usb.h:
+ *
+ */
+#ifndef _PPC_USB_H
+#define _PPC_USB_H
+
+struct usb_hcd_platform_data {
+	char *name;
+	int (*start) (struct platform_device *pdev);
+	void (*stop) (struct platform_device *pdev);
+};
+
+#endif /* !(_PPC_USB_H) */
