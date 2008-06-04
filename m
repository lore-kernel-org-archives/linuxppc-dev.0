Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 51E63DE619
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 01:45:38 +1000 (EST)
Date: Wed, 4 Jun 2008 19:45:36 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] [POWERPC] 86xx: mpc8610_hpcd: add support for IrDA
Message-ID: <20080604154536.GC31162@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Timur Tabi <timur@freescale.com>, Zhang Wei <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for IrDA on MPC8610HPCD. IrDA platfrom hook is
used to setup IR clocks and to manage the on-board transceiver.

(The original BSP patch comes with lots of Sign offs, providing them
here.)
Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
Signed-off-by: Jason Jin <Jason.jin@freescale.com>
Signed-off-by: Timur Tabi <timur@freescale.com>
Signed-off-by: York Sun <yorksun@freescale.com>
Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8610_hpcd.dts     |   20 ++++
 arch/powerpc/platforms/86xx/Kconfig        |    1 +
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |  164 ++++++++++++++++++++++++++--
 3 files changed, 174 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index fa9c297..6f550ef 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -171,6 +171,18 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		irda@2d000 {
+			compatible = "fsl,mpc8610-irda";
+			interrupt-parent = <&mpic>;
+			interrupts = <73 2>;
+			reg = <0x2d000 0x1000>;
+
+			irda-transceiver {
+				compatible = "vishay,tfdu6102";
+				gpios = <&soc_gpio2 18 0>;
+			};
+		};
+
 		mpic: interrupt-controller@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
@@ -204,6 +216,14 @@
 			fsl,has-rstcr;
 		};
 
+		soc_gpio2: gpio-controller@f100 {
+			#gpio-cells = <2>;
+			compatible = "fsl,mpc8610-gpio-bank",
+				     "fsl,mpc8349-gpio-bank";
+			reg = <0xf100 0x100>;
+			gpio-controller;
+		};
+
 		i2s@16000 {
 			compatible = "fsl,mpc8610-ssi";
 			cell-index = <0>;
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 053f49a..f1d5d0f 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -21,6 +21,7 @@ config SBC8641D
 config MPC8610_HPCD
 	bool "Freescale MPC8610 HPCD"
 	select DEFAULT_UIMAGE
+	select FSL_MPC8349_GPIO
 	help
 	  This option enables support for the MPC8610 HPCD board.
 
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index eb16208..684e1ed 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -22,7 +22,10 @@
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
+#include <linux/fsl_ir.h>
+#include <linux/gpio.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -39,7 +42,144 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/fsl_soc.h>
 
-static unsigned char *pixis_bdcfg0, *pixis_arch;
+#define PX_BRDCFG0_DVISEL	(1 << 3)
+#define PX_BRDCFG0_DLINK	(1 << 4)
+#define PX_BRDCFG0_DIU_MASK	(PX_BRDCFG0_DVISEL | PX_BRDCFG0_DLINK)
+#define PX_BRDCFG0_IRDAEN	(1 << 5)
+
+static u8 __iomem *pixis_bdcfg0;
+static u8 __iomem *pixis_arch;
+static u32 __iomem *clkdvdr;
+static DEFINE_SPINLOCK(clkdvdr_lock);
+static u32 __iomem *ircr;
+static u32 __iomem *gpiocr;
+static int speed_gpio;
+
+/*
+ * FIXME: documentation says that bits are reserved. I just made up the
+ * names.
+ */
+#define CLKDVDR_IRCKEN		0x40000000
+#define CLKDVDR_IRCLK_MASK	0x0000FF00
+#define CLKDVDR_IRCLK(x)	(((x) << 8) & CLKDVDR_IRCLK_MASK)
+
+#define IRCR_IR1SEL		0x00000001
+
+static void mpc8610_set_ir_mode(struct fsl_ir *ir, u32 speed)
+{
+	if (speed > 115200) {
+		unsigned long flags;
+
+		/* FIR */
+		if (gpio_is_valid(speed_gpio))
+			gpio_set_value(speed_gpio, 1);
+
+		spin_lock_irqsave(&clkdvdr_lock, flags);
+		if (speed == 4000000) {
+			clrbits32(clkdvdr, CLKDVDR_IRCKEN);
+		} else {
+			/* Using internal PLL for MIR clock */
+			clrbits32(clkdvdr, CLKDVDR_IRCKEN |
+					   CLKDVDR_IRCLK_MASK);
+			setbits32(clkdvdr,
+				CLKDVDR_IRCLK(ir->clock_in / 12 / speed - 1) |
+				CLKDVDR_IRCKEN);
+		}
+		spin_unlock_irqrestore(&clkdvdr_lock, flags);
+
+		/* Set IR1 FIR mode in MPC8610 */
+		setbits32(ircr, IRCR_IR1SEL);
+	} else if (speed) {
+		/* SIR */
+		if (gpio_is_valid(speed_gpio))
+			gpio_set_value(speed_gpio, 0);
+		/* Set IR1 SIR mode in MPC8610 */
+		clrbits32(ircr, IRCR_IR1SEL);
+	}
+}
+
+static struct fsl_ir_op mpc8610_ir_op = {
+	.set_ir_mode = mpc8610_set_ir_mode,
+};
+
+static int mpc8610_init_onboard_transceiver(void)
+{
+	struct device_node *np;
+	int ret;
+
+	if (!pixis_bdcfg0)
+		return -EINVAL;
+
+	np = of_find_compatible_node(NULL, NULL, "vishay,tfdu6102");
+	if (!np)
+		return -ENODEV;
+
+	/*
+	 * Select IR1 in GPIO (GTM2_1 -- GPIO2[18:20]), and enable transceiver.
+	 * Note: actually, this should be done in the firmware, but we support
+	 * old firmwares too.
+	 */
+	setbits32(gpiocr, 0x00020000);
+	clrbits32(gpiocr, 0x00800000);
+	clrbits8(pixis_bdcfg0, PX_BRDCFG0_IRDAEN);
+
+	speed_gpio = of_get_gpio(np, 0);
+	of_node_put(np);
+	if (!gpio_is_valid(speed_gpio))
+		return speed_gpio;
+
+	ret = gpio_request(speed_gpio, "irda-transceiver");
+	if (ret)
+		return ret;
+
+	ret = gpio_direction_output(speed_gpio, 0);
+	if (ret) {
+		gpio_free(speed_gpio);
+		return ret;
+	}
+	return 0;
+}
+
+static void mpc8610_ir_init(void)
+{
+	struct device_node *np;
+	struct device_node *irda;
+	static void __iomem *guts;
+
+	if (!clkdvdr)
+		return;
+
+	irda = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-irda");
+	if (!irda)
+		return;
+	irda->data = &mpc8610_ir_op;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
+	if (!np) {
+		pr_err("%s: can't find global utilities node\n", __func__);
+		goto err;
+	}
+
+	guts = of_iomap(np, 0);
+	of_node_put(np);
+	if (!guts) {
+		pr_err("%s: can't remap global utilities memory\n", __func__);
+		goto err;
+	}
+
+	gpiocr = guts + 0x30;
+	ircr = guts + 0x900;
+
+	if (mpc8610_init_onboard_transceiver()) {
+		pr_warning("%s: failed to initialize on-board transceiver, "
+			   "assuming external tranceiver.\n", __func__);
+	}
+	/* no of_node_put(irda) here -- we're using its ->data */
+	return;
+err:
+	irda->data = NULL;
+	of_node_put(irda);
+}
 
 static struct of_device_id __initdata mpc8610_ids[] = {
 	{ .compatible = "fsl,mpc8610-immr", },
@@ -49,6 +189,8 @@ static struct of_device_id __initdata mpc8610_ids[] = {
 
 static int __init mpc8610_declare_of_platform_devices(void)
 {
+	mpc8610_ir_init();
+
 	/* Without this call, the SSI device driver won't get probed. */
 	of_platform_bus_probe(NULL, mpc8610_ids, NULL);
 
@@ -218,10 +360,6 @@ void mpc8610hpcd_set_gamma_table(int monitor_port, char *gamma_table_base)
 	}
 }
 
-#define PX_BRDCFG0_DVISEL	(1 << 3)
-#define PX_BRDCFG0_DLINK	(1 << 4)
-#define PX_BRDCFG0_DIU_MASK	(PX_BRDCFG0_DVISEL | PX_BRDCFG0_DLINK)
-
 void mpc8610hpcd_set_monitor_port(int monitor_port)
 {
 	static const u8 bdcfg[] = {
@@ -237,19 +375,16 @@ void mpc8610hpcd_set_monitor_port(int monitor_port)
 
 void mpc8610hpcd_set_pixel_clock(unsigned int pixclock)
 {
-	u32 __iomem *clkdvdr;
 	u32 temp;
 	/* variables for pixel clock calcs */
 	ulong  bestval, bestfreq, speed_ccb, minpixclock, maxpixclock;
 	ulong pixval;
 	long err;
 	int i;
+	unsigned long flags;
 
-	clkdvdr = ioremap(get_immrbase() + 0xe0800, sizeof(u32));
-	if (!clkdvdr) {
-		printk(KERN_ERR "Err: can't map clock divider register!\n");
+	if (!clkdvdr)
 		return;
-	}
 
 	/* Pixel Clock configuration */
 	pr_debug("DIU: Bus Frequency = %d\n", get_busfreq());
@@ -296,12 +431,13 @@ void mpc8610hpcd_set_pixel_clock(unsigned int pixclock)
 	pr_debug("DIU error = %ld\n NomPixClk ", err);
 	pr_debug("DIU: Best Freq = %lx\n", bestfreq);
 	/* Modify PXCLK in GUTS CLKDVDR */
+	spin_lock_irqsave(&clkdvdr_lock, flags);
 	pr_debug("DIU: Current value of CLKDVDR = 0x%08x\n", (*clkdvdr));
 	temp = (*clkdvdr) & 0x2000FFFF;
 	*clkdvdr = temp;		/* turn off clock */
 	*clkdvdr = temp | 0x80000000 | (((bestval) & 0x1F) << 16);
 	pr_debug("DIU: Modified value of CLKDVDR = 0x%08x\n", (*clkdvdr));
-	iounmap(clkdvdr);
+	spin_unlock_irqrestore(&clkdvdr_lock, flags);
 }
 
 ssize_t mpc8610hpcd_show_monitor_port(int monitor_port, char *buf)
@@ -354,6 +490,12 @@ static void __init mpc86xx_hpcd_setup_arch(void)
 	diu_ops.set_sysfs_monitor_port	= mpc8610hpcd_set_sysfs_monitor_port;
 #endif
 
+	clkdvdr = ioremap(get_immrbase() + 0xe0800, sizeof(u32));
+	if (!clkdvdr) {
+		printk(KERN_ERR "Err: can't map clock divider register!\n");
+		return;
+	}
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,fpga-pixis");
 	if (np) {
 		of_address_to_resource(np, 0, &r);
-- 
1.5.5.1
