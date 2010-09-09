Return-Path: <timur@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139]) by ozlabs.org (Postfix) with ESMTP id 16D31B70CC
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 04:40:29 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, yorksun@freescale.com,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 2/2] powerpc/85xx: add DIU support to the Freecale P1022DS
	reference board
Date: Thu, 9 Sep 2010 13:39:57 -0500
Message-ID: <1284057597-17126-2-git-send-email-timur@freescale.com>
In-Reply-To: <1284057597-17126-1-git-send-email-timur@freescale.com>
References: <1284057597-17126-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Freescale P1022DS has an on-chip video controller called the DIU, and a
driver for this device already exists.  Update the platform file for the
P1022DS reference board to enable the driver, and update the defconfig for
Freescale MPC85xx boards to add the driver.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

The following patch is a pre-requisite for this patch:

	powerpc/85xx: add ngPIXIS FPGA device tree node to the P1022DS board

 arch/powerpc/configs/mpc85xx_defconfig     |    3 +
 arch/powerpc/configs/mpc85xx_smp_defconfig |    3 +
 arch/powerpc/platforms/85xx/p1022_ds.c     |  213 +++++++++++++++++++++++++++-
 3 files changed, 217 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index c3b113b..3aeb594 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -124,6 +124,9 @@ CONFIG_I2C_CPM=m
 CONFIG_I2C_MPC=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=y
+CONFIG_FB=y
+CONFIG_FB_FSL_DIU=y
+# CONFIG_VGA_CONSOLE is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index a075da2..d62c801 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -126,6 +126,9 @@ CONFIG_I2C_CPM=m
 CONFIG_I2C_MPC=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=y
+CONFIG_FB=y
+CONFIG_FB_FSL_DIU=y
+# CONFIG_VGA_CONSOLE is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 34e0090..3340071 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -8,7 +8,6 @@
  * Copyright 2010 Freescale Semiconductor, Inc.
  *
  * This file is taken from the Freescale P1022DS BSP, with modifications:
- * 1) No DIU support (pending rewrite of DIU code)
  * 2) No AMP support
  * 3) No PCI endpoint support
  *
@@ -17,15 +16,216 @@
  * kind, whether express or implied.
  */
 
+#define DEBUG
+
 #include <linux/pci.h>
 #include <linux/of_platform.h>
 #include <linux/memblock.h>
-
+#include <asm/div64.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
+#include <asm/fsl_guts.h>
+
+#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
+
+/*
+ * Board-specific initialization of the DIU.  This code should probably be
+ * executed when the DIU is opened, rather than in arch code, but the DIU
+ * driver does not have a mechanism for this (yet).
+ *
+ * This is especially problematic on the P1022DS because the local bus (eLBC)
+ * and the DIU video signals share the same pins, which means that enabling the
+ * DIU will disable access to NOR flash.
+ */
+
+/* DIU Pixel Clock bits of the CLKDVDR Global Utilities register */
+#define CLKDVDR_PXCKEN		0x80000000
+#define CLKDVDR_PXCKINV		0x10000000
+#define CLKDVDR_PXCKDLY		0x06000000
+#define CLKDVDR_PXCLK_MASK	0x00FF0000
+
+/* Some ngPIXIS register definitions */
+#define PX_BRDCFG1_DVIEN	0x80
+#define PX_BRDCFG1_DFPEN	0x40
+#define PX_BRDCFG1_BACKLIGHT	0x20
+#define PX_BRDCFG1_DDCEN	0x10
+
+/*
+ * DIU Area Descriptor
+ *
+ * Note that we need to byte-swap the value before it's written to the AD
+ * register.  So even though the registers don't look like they're in the same
+ * bit positions as they are on the MPC8610, the same value is written to the
+ * AD register on the MPC8610 and on the P1022.
+ */
+#define AD_BYTE_F		0x10000000
+#define AD_ALPHA_C_MASK		0x0E000000
+#define AD_ALPHA_C_SHIFT	25
+#define AD_BLUE_C_MASK		0x01800000
+#define AD_BLUE_C_SHIFT		23
+#define AD_GREEN_C_MASK		0x00600000
+#define AD_GREEN_C_SHIFT	21
+#define AD_RED_C_MASK		0x00180000
+#define AD_RED_C_SHIFT		19
+#define AD_PALETTE		0x00040000
+#define AD_PIXEL_S_MASK		0x00030000
+#define AD_PIXEL_S_SHIFT	16
+#define AD_COMP_3_MASK		0x0000F000
+#define AD_COMP_3_SHIFT		12
+#define AD_COMP_2_MASK		0x00000F00
+#define AD_COMP_2_SHIFT		8
+#define AD_COMP_1_MASK		0x000000F0
+#define AD_COMP_1_SHIFT		4
+#define AD_COMP_0_MASK		0x0000000F
+#define AD_COMP_0_SHIFT		0
+
+#define MAKE_AD(alpha, red, blue, green, size, c0, c1, c2, c3) \
+	cpu_to_le32(AD_BYTE_F | (alpha << AD_ALPHA_C_SHIFT) | \
+	(blue << AD_BLUE_C_SHIFT) | (green << AD_GREEN_C_SHIFT) | \
+	(red << AD_RED_C_SHIFT) | (c3 << AD_COMP_3_SHIFT) | \
+	(c2 << AD_COMP_2_SHIFT) | (c1 << AD_COMP_1_SHIFT) | \
+	(c0 << AD_COMP_0_SHIFT) | (size << AD_PIXEL_S_SHIFT))
+
+/**
+ * p1022ds_get_pixel_format: return the Area Descriptor for a given pixel depth
+ *
+ * The Area Descriptor is a 32-bit value that determine which bits in each
+ * pixel are to be used for each color.
+ */
+static unsigned int p1022ds_get_pixel_format(unsigned int bits_per_pixel,
+	int monitor_port)
+{
+	switch (bits_per_pixel) {
+	case 32:
+		/* 0x88883316 */
+		return MAKE_AD(3, 2, 0, 1, 3, 8, 8, 8, 8);
+	case 24:
+		/* 0x88082219 */
+		return MAKE_AD(4, 0, 1, 2, 2, 0, 8, 8, 8);
+	case 16:
+		/* 0x65053118 */
+		return MAKE_AD(4, 2, 1, 0, 1, 5, 6, 5, 0);
+	default:
+		pr_err("fsl-diu: unsupported pixel depth %u\n", bits_per_pixel);
+		return 0;
+	}
+}
+
+/**
+ * p1022ds_set_gamma_table: update the gamma table, if necessary
+ *
+ * On some boards, the gamma table for some ports may need to be modified.
+ * This is not the case on the P1022DS, so we do nothing.
+*/
+static void p1022ds_set_gamma_table(int monitor_port, char *gamma_table_base)
+{
+}
+
+/**
+ * p1022ds_set_monitor_port: switch the output to a different monitor port
+ *
+ */
+static void p1022ds_set_monitor_port(int monitor_port)
+{
+	struct device_node *pixis_node;
+	u8 __iomem *brdcfg1;
+
+	pixis_node = of_find_compatible_node(NULL, NULL, "fsl,fpga-pixis");
+	if (!pixis_node) {
+		pr_err("p1022ds: missing ngPIXIS node\n");
+		return;
+	}
+
+	brdcfg1 = of_iomap(pixis_node, 0);
+	if (!brdcfg1) {
+		pr_err("p1022ds: could not map ngPIXIS registers\n");
+		return;
+	}
+	brdcfg1 += 9;	/* BRDCFG1 is at offset 9 in the ngPIXIS */
+
+	switch (monitor_port) {
+	case 0: /* DVI */
+		/* Enable the DVI port, disable the DFP and the backlight */
+		clrsetbits_8(brdcfg1, PX_BRDCFG1_DFPEN | PX_BRDCFG1_BACKLIGHT,
+			     PX_BRDCFG1_DVIEN);
+		break;
+	case 1: /* Single link LVDS */
+		/* Enable the DFP port, disable the DVI and the backlight */
+		clrsetbits_8(brdcfg1, PX_BRDCFG1_DVIEN | PX_BRDCFG1_BACKLIGHT,
+			     PX_BRDCFG1_DFPEN);
+		break;
+	default:
+		pr_err("p1022ds: unsupported monitor port %i\n", monitor_port);
+	}
+}
+
+/**
+ * p1022ds_set_pixel_clock: program the DIU's clock
+ *
+ * @pixclock: the wavelength, in picoseconds, of the clock
+ */
+void p1022ds_set_pixel_clock(unsigned int pixclock)
+{
+	struct device_node *guts_np = NULL;
+	struct ccsr_guts_85xx __iomem *guts;
+	unsigned long freq;
+	u64 temp;
+	u32 pxclk;
+
+	/* Map the global utilities registers. */
+	guts_np = of_find_compatible_node(NULL, NULL, "fsl,p1022-guts");
+	if (!guts_np) {
+		pr_err("p1022ds: missing global utilties device node\n");
+		return;
+	}
+
+	guts = of_iomap(guts_np, 0);
+	of_node_put(guts_np);
+	if (!guts) {
+		pr_err("p1022ds: could not map global utilties device\n");
+		return;
+	}
+
+	/* Convert pixclock from a wavelength to a frequency */
+	temp = 1000000000000ULL;
+	do_div(temp, pixclock);
+	freq = temp;
+
+	/* pixclk is the ratio of the platform clock to the pixel clock */
+	pxclk = DIV_ROUND_CLOSEST(fsl_get_sys_freq(), freq);
+
+	/* Disable the pixel clock, and set it to non-inverted and no delay */
+	clrbits32(&guts->clkdvdr,
+		  CLKDVDR_PXCKEN | CLKDVDR_PXCKDLY | CLKDVDR_PXCLK_MASK);
+
+	/* Enable the clock and set the pxclk */
+	setbits32(&guts->clkdvdr, CLKDVDR_PXCKEN | (pxclk << 16));
+}
+
+/**
+ * p1022ds_show_monitor_port: show the current monitor
+ *
+ * This function returns a string indicating whether the current monitor is
+ * set to DVI or LVDS.
+ */
+ssize_t p1022ds_show_monitor_port(int monitor_port, char *buf)
+{
+	return sprintf(buf, "%c0 - DVI\n%c1 - Single link LVDS\n",
+		monitor_port == 0 ? '*' : ' ', monitor_port == 1 ? '*' : ' ');
+}
+
+/**
+ * p1022ds_set_sysfs_monitor_port: set the monitor port for sysfs
+ */
+int p1022ds_set_sysfs_monitor_port(int val)
+{
+	return val < 2 ? val : 0;
+}
+
+#endif
 
 void __init p1022_ds_pic_init(void)
 {
@@ -92,6 +292,15 @@ static void __init p1022_ds_setup_arch(void)
 	}
 #endif
 
+#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
+	diu_ops.get_pixel_format	= p1022ds_get_pixel_format;
+	diu_ops.set_gamma_table		= p1022ds_set_gamma_table;
+	diu_ops.set_monitor_port	= p1022ds_set_monitor_port;
+	diu_ops.set_pixel_clock		= p1022ds_set_pixel_clock;
+	diu_ops.show_monitor_port	= p1022ds_show_monitor_port;
+	diu_ops.set_sysfs_monitor_port	= p1022ds_set_sysfs_monitor_port;
+#endif
+
 #ifdef CONFIG_SMP
 	mpc85xx_smp_init();
 #endif
-- 
1.7.2.2
