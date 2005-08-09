Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 35EA667FB1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 05:23:27 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 9 Aug 2005 12:23:25 -0700
To: Dale Farnsworth <dale@farnsworth.org>, linuxppc-embedded@ozlabs.org
Message-ID: <20050809192324.GB20480@xyzzy.farnsworth.org>
References: <20050809185327.GA19340@xyzzy.farnsworth.org>
	<20050809190319.GC30956@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050809190319.GC30956@gate.ebshome.net>
Subject: Re: [PATCH] ppc32: Add usb support to IBM stb04xxx platforms
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 12:03:19PM -0700, Eugene Surovegin wrote:
> On Tue, Aug 09, 2005 at 11:53:27AM -0700, Dale Farnsworth wrote:
> [snip]
> 
> > Index: linux-2.5-usb-405/arch/ppc/platforms/4xx/redwood5.c
> > ===================================================================
> > --- linux-2.5-usb-405.orig/arch/ppc/platforms/4xx/redwood5.c
> > +++ linux-2.5-usb-405/arch/ppc/platforms/4xx/redwood5.c
> > @@ -52,8 +52,18 @@
> >  void __init
> >  redwood5_setup_arch(void)
> >  {
> > +	u32 mask;
> > +
> >  	ppc4xx_setup_arch();
> >  
> > +	/*
> > +	 * Set up USB interrupt as positive polarity and level-sensitive.
> > +	 * Firmware should do this, but apparently does not.
> > +	 */
> > +	mask = 1 << (31 - USB0_IRQ);
> > +	mtdcr(DCRN_UIC_PR(UIC0), mfdcr(DCRN_UIC_PR(UIC0)) | mask);
> > +	mtdcr(DCRN_UIC_TR(UIC0), mfdcr(DCRN_UIC_TR(UIC0)) & ~mask);
> > +
> 
> Please, DO NOT DO THIS. 
> 
> There is a way to configure UIC settings without messing with UIC 
> registers directly. Refer to asm-ppc/ppc4xx_pic.h and other 4xx board 
> ports for more information.
> 
> Eugene

Deja vu all over again, eh Eugene?  I re-submitted the wrong old patch.
Correct (I hope) patch follows.




Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

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
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
