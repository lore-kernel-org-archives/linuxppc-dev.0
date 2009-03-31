Return-Path: <wg@denx.de>
Message-Id: <20090331124035.908249543@denx.de>
Date: Tue, 31 Mar 2009 14:37:32 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/8] powerpc: i2c-mpc: make I2C bus speed configurable
References: <20090331123727.853787299@denx.de>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes the I2C bus speed configurable by using the I2C node
property "clock-frequency". If the property is not defined, the old
fixed clock settings will be used for backward comptibility.

The generic I2C clock properties, especially the CPU-specific source
clock pre-scaler are defined via the OF match table:

  static const struct of_device_id mpc_i2c_of_match[] = {
	{.compatible = "fsl,mpc5200b-i2c",
	 .data = (void *)FSL_I2C_DEV_CLOCK_5200, },
	{.compatible = "fsl,mpc5200-i2c",
	 .data = (void *)FSL_I2C_DEV_CLOCK_5200, },
	{.compatible = "fsl,mpc8313-i2c",
	 .data = (void *)FSL_I2C_DEV_SEPARATE_DFSRR, },
	{.compatible = "fsl,mpc8543-i2c",
	 .data = (void *)(FSL_I2C_DEV_SEPARATE_DFSRR |
			  FSL_I2C_DEV_CLOCK_DIV2), },
	{.compatible = "fsl,mpc8544-i2c",
	 .data = (void *)(FSL_I2C_DEV_SEPARATE_DFSRR |
			  FSL_I2C_DEV_CLOCK_DIV23), },
	/* Backward compatibility */
	{.compatible = "fsl-i2c", },
	{},
  };

The "data" field defines the relevant I2C flags for the comptible CPU.

It used arch-specific tables and functions to determine the proper
Freqency Divider Register (fdr).

Furthermore dev_dbg() and dev_info() are now used to profit from a more
comprehensive output.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   48 ++++++++++++
 arch/powerpc/sysdev/fsl_soc.c                |   90 +++++++++++++++++++++++
 drivers/i2c/busses/i2c-mpc.c                 |  104 +++++++++++++++++++--------
 include/linux/fsl_devices.h                  |    6 +
 4 files changed, 221 insertions(+), 27 deletions(-)

Index: linux-2.6/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6.orig/drivers/i2c/busses/i2c-mpc.c	2009-03-31 13:28:03.000000000 +0200
+++ linux-2.6/drivers/i2c/busses/i2c-mpc.c	2009-03-31 13:38:01.355720989 +0200
@@ -20,12 +20,14 @@
 #include <linux/of_platform.h>
 #include <linux/of_i2c.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/fsl_devices.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 
+#include <sysdev/fsl_soc.h>
+
 #define DRV_NAME "mpc-i2c"
 
 #define MPC_I2C_FDR 	0x04
@@ -50,6 +52,7 @@
 #define CSR_RXAK 0x01
 
 struct mpc_i2c {
+	struct device *dev;
 	void __iomem *base;
 	u32 interrupt;
 	wait_queue_head_t queue;
@@ -105,7 +108,7 @@
 		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
 			schedule();
 			if (time_after(jiffies, orig_jiffies + timeout)) {
-				pr_debug("I2C: timeout\n");
+				dev_dbg(i2c->dev, "timeout\n");
 				writeccr(i2c, 0);
 				result = -EIO;
 				break;
@@ -119,10 +122,10 @@
 			(i2c->interrupt & CSR_MIF), timeout * HZ);
 
 		if (unlikely(result < 0)) {
-			pr_debug("I2C: wait interrupted\n");
+			dev_dbg(i2c->dev, "wait interrupted\n");
 			writeccr(i2c, 0);
 		} else if (unlikely(!(i2c->interrupt & CSR_MIF))) {
-			pr_debug("I2C: wait timeout\n");
+			dev_dbg(i2c->dev, "wait timeout\n");
 			writeccr(i2c, 0);
 			result = -ETIMEDOUT;
 		}
@@ -135,17 +138,17 @@
 		return result;
 
 	if (!(x & CSR_MCF)) {
-		pr_debug("I2C: unfinished\n");
+		dev_dbg(i2c->dev, "unfinished\n");
 		return -EIO;
 	}
 
 	if (x & CSR_MAL) {
-		pr_debug("I2C: MAL\n");
+		dev_dbg(i2c->dev, "MAL\n");
 		return -EIO;
 	}
 
 	if (writing && (x & CSR_RXAK)) {
-		pr_debug("I2C: No RXAK\n");
+		dev_dbg(i2c->dev, "No RXAK\n");
 		/* generate stop */
 		writeccr(i2c, CCR_MEN);
 		return -EIO;
@@ -153,17 +156,38 @@
 	return 0;
 }
 
-static void mpc_i2c_setclock(struct mpc_i2c *i2c)
+static void mpc_i2c_setclock(struct device_node *node,
+			     struct mpc_i2c *i2c, u32 clock)
 {
-	/* Set clock and filters */
-	if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
-		writeb(0x31, i2c->base + MPC_I2C_FDR);
-		writeb(0x10, i2c->base + MPC_I2C_DFSRR);
-	} else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
-		writeb(0x3f, i2c->base + MPC_I2C_FDR);
-	else
-		writel(0x1031, i2c->base + MPC_I2C_FDR);
-}
+	int fdr;
+
+	fdr = fsl_i2c_get_fdr(node, clock, i2c->flags);
+
+	if (i2c->flags & FSL_I2C_DEV_CLOCK_5200) {
+		pr_debug("I2C: old fdr=%d\n", readb(i2c->base + MPC_I2C_FDR));
+		if (fdr < 0)
+			fdr = 0x3f; /* backward compatibility */
+		writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
+		dev_info("clock %d Hz (fdr=%d)\n", clock, fdr);
+	} else {
+		if (fdr < 0)
+			fdr = 0x1031; /* backward compatibility */
+		if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
+			pr_debug("I2C: old dfsrr=%d fdr=%d\n",
+			       readb(i2c->base + MPC_I2C_DFSRR),
+			       readb(i2c->base + MPC_I2C_FDR));
+			writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
+			writeb((fdr >> 8) & 0xff, i2c->base + MPC_I2C_DFSRR);
+			dev_info("clock %d Hz (dfsrr=%d fdr=%d)\n",
+			       clock, fdr >> 8, fdr & 0xff);
+		} else {
+			pr_debug("I2C: old fdr=%d\n",
+				 readl(i2c->base + MPC_I2C_FDR));
+			writel(fdr & 0xffff, i2c->base + MPC_I2C_FDR);
+			dev_info("clock %d Hz (fdr=%d)\n", clock, fdr);
+		}
+	}
+ }
 
 static void mpc_i2c_start(struct mpc_i2c *i2c)
 {
@@ -267,12 +291,12 @@
 	/* Allow bus up to 1s to become not busy */
 	while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
 		if (signal_pending(current)) {
-			pr_debug("I2C: Interrupted\n");
+			dev_dbg(i2c->dev, "interrupted\n");
 			writeccr(i2c, 0);
 			return -EINTR;
 		}
 		if (time_after(jiffies, orig_jiffies + HZ)) {
-			pr_debug("I2C: timeout\n");
+			dev_dbg(i2c->dev, "timeout\n");
 			if (readb(i2c->base + MPC_I2C_SR) ==
 			    (CSR_MCF | CSR_MBB | CSR_RXAK))
 				mpc_i2c_fixup(i2c);
@@ -283,9 +307,10 @@
 
 	for (i = 0; ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
-		pr_debug("Doing %s %d bytes to 0x%02x - %d of %d messages\n",
-			 pmsg->flags & I2C_M_RD ? "read" : "write",
-			 pmsg->len, pmsg->addr, i + 1, num);
+		dev_dbg(i2c->dev,
+			"doing %s %d bytes to 0x%02x - %d of %d messages\n",
+			pmsg->flags & I2C_M_RD ? "read" : "write",
+			pmsg->len, pmsg->addr, i + 1, num);
 		if (pmsg->flags & I2C_M_RD)
 			ret =
 			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
@@ -316,9 +341,12 @@
 
 static int __devinit fsl_i2c_probe(struct of_device *op, const struct of_device_id *match)
 {
-	int result = 0;
 	struct mpc_i2c *i2c;
+	const u32 *prop;
+	u32 clock = 0;
 	int set_clock;
+	int result = 0;
+	int plen;
 
 	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
@@ -328,7 +356,11 @@
 		set_clock = 0;
 	} else {
 		set_clock = 1;
+		prop = of_get_property(op->node, "clock-frequency", &plen);
+		if (prop && plen == sizeof(u32))
+			clock = *prop;
 
+		/* Backwards compatibility */
 		if (of_get_property(op->node, "dfsrr", NULL))
 			i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
 
@@ -356,11 +388,15 @@
 		}
 	}
 
-	if (set_clock)
-		mpc_i2c_setclock(i2c);
+	if (set_clock) {
+		if (match->data)
+			i2c->flags = (u32)match->data;
+		mpc_i2c_setclock(op->node, i2c, clock);
+	}
 
 	dev_set_drvdata(&op->dev, i2c);
 
+	i2c->dev = &op->dev;
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &op->dev;
@@ -402,9 +438,23 @@
 };
 
 static const struct of_device_id mpc_i2c_of_match[] = {
-	{.compatible = "fsl-i2c",},
+	{.compatible = "fsl,mpc5200b-i2c",
+	 .data = (void *)FSL_I2C_DEV_CLOCK_5200, },
+	{.compatible = "fsl,mpc5200-i2c",
+	 .data = (void *)FSL_I2C_DEV_CLOCK_5200, },
+	{.compatible = "fsl,mpc8313-i2c",
+	 .data = (void *)FSL_I2C_DEV_SEPARATE_DFSRR, },
+	{.compatible = "fsl,mpc8543-i2c",
+	 .data = (void *)(FSL_I2C_DEV_SEPARATE_DFSRR |
+			  FSL_I2C_DEV_CLOCK_DIV2), },
+	{.compatible = "fsl,mpc8544-i2c",
+	 .data = (void *)(FSL_I2C_DEV_SEPARATE_DFSRR |
+			  FSL_I2C_DEV_CLOCK_DIV23), },
+	/* Backward compatibility */
+	{.compatible = "fsl-i2c", },
 	{},
 };
+
 MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
 
 
@@ -425,7 +475,7 @@
 
 	rv = of_register_platform_driver(&mpc_i2c_driver);
 	if (rv)
-		printk(KERN_ERR DRV_NAME 
+		printk(KERN_ERR DRV_NAME
 		       " of_register_platform_driver failed (%i)\n", rv);
 	return rv;
 }
Index: linux-2.6/arch/powerpc/sysdev/fsl_soc.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/fsl_soc.c	2009-03-31 13:25:08.000000000 +0200
+++ linux-2.6/arch/powerpc/sysdev/fsl_soc.c	2009-03-31 13:34:40.531721011 +0200
@@ -102,6 +102,96 @@
 }
 EXPORT_SYMBOL(fsl_get_sys_freq);
 
+#ifdef CONFIG_I2C_MPC
+static const struct fsl_i2c_divider {
+	u16 divider;
+	u16 fdr;	/* including dfsrr */
+} fsl_i2c_8xxx_dividers[] = {
+	{160, 0x0120}, {192, 0x0121}, {224, 0x0122}, {256, 0x0123},
+	{288, 0x0100}, {320, 0x0101}, {352, 0x0601}, {384, 0x0102},
+	{416, 0x0602}, {448, 0x0126}, {480, 0x0103}, {512, 0x0127},
+	{544, 0x0b03}, {576, 0x0104}, {608, 0x1603}, {640, 0x0105},
+	{672, 0x2003}, {704, 0x0b05}, {736, 0x2b03}, {768, 0x0106},
+	{800, 0x3603}, {832, 0x0b06}, {896, 0x012a}, {960, 0x0107},
+	{1024, 0x012b}, {1088, 0x1607}, {1152, 0x0108}, {1216, 0x2b07},
+	{1280, 0x0109}, {1408, 0x1609}, {1536, 0x010a}, {1664, 0x160a},
+	{1792, 0x012e}, {1920, 0x010b}, {2048, 0x012f}, {2176, 0x2b0b},
+	{2304, 0x010c}, {2560, 0x010d}, {2816, 0x2b0d}, {3072, 0x010e},
+	{3328, 0x2b0e}, {3584, 0x0132}, {3840, 0x010f}, {4096, 0x0133},
+	{4608, 0x0110}, {5120, 0x0111}, {6144, 0x0112}, {7168, 0x0136},
+	{7680, 0x0113}, {8192, 0x0137}, {9216, 0x0114}, {10240, 0x0115},
+	{12288, 0x0116}, {14336, 0x013a}, {15360, 0x0117}, {16384, 0x013b},
+	{18432, 0x0118}, {20480, 0x0119}, {24576, 0x011a}, {28672, 0x013e},
+	{30720, 0x011b}, {32768, 0x013f}, {36864, 0x011c}, {40960, 0x011d},
+	{49152, 0x011e}, {61440, 0x011f}
+};
+
+u32 fsl_i2c_get_sec_cfg(void)
+{
+	struct device_node *node = NULL;
+	u32 __iomem *reg;
+	u32 val = 0;
+
+	node = of_find_node_by_name(NULL, "global-utilities");
+	if (node) {
+		const u32 *prop = of_get_property(node, "reg", NULL);
+		if (prop) {
+			/*
+			 * Map and check POR Device Status Register 2
+			 * (PORDEVSR2) at 0xE0014
+			 */
+			reg = ioremap(get_immrbase() + *prop + 0x14, 0x4);
+			if (!reg)
+				printk(KERN_ERR
+				       "Error: couldn't map PORDEVSR2\n");
+			else
+				val = in_be32(reg);
+			iounmap(reg);
+		}
+	}
+	if (node)
+		of_node_put(node);
+
+	return val;
+}
+
+int fsl_i2c_get_fdr(struct device_node *node, u32 i2c_clock, u32 i2c_flags)
+{
+	const struct fsl_i2c_divider *div = NULL;
+	u32 src_clock, divider;
+	int i;
+
+	if (!i2c_clock)
+		return -EINVAL;
+
+	/* Determine divider value */
+	src_clock = fsl_get_sys_freq();
+	divider =  src_clock / i2c_clock;
+	if (i2c_flags & FSL_I2C_DEV_CLOCK_DIV2)
+		divider /= 2;
+	else if (i2c_flags & FSL_I2C_DEV_CLOCK_DIV3)
+		divider /= 3;
+	else if (i2c_flags & FSL_I2C_DEV_CLOCK_DIV23)
+		divider /= fsl_i2c_get_sec_cfg() ? 3 : 2;
+
+	pr_debug("I2C: src_clock=%d clock=%d flags=%#x divider=%d\n",
+		 src_clock, i2c_clock, i2c_flags, divider);
+
+	/*
+	 * We want to choose an FDR/DFSR that generates an I2C bus speed that
+	 * is equal to or lower than the requested speed.
+	 */
+	for (i = 0; i < ARRAY_SIZE(fsl_i2c_8xxx_dividers); i++) {
+		div = &fsl_i2c_8xxx_dividers[i];
+		if (div->divider >= divider)
+			break;
+	}
+
+	return div ? (int)div->fdr : -EINVAL;
+}
+EXPORT_SYMBOL(fsl_i2c_get_fdr);
+#endif /* CONFIG_I2C_MPC */
+
 #if defined(CONFIG_CPM2) || defined(CONFIG_QUICC_ENGINE) || defined(CONFIG_8xx)
 
 static u32 brgfreq = -1;
Index: linux-2.6/include/linux/fsl_devices.h
===================================================================
--- linux-2.6.orig/include/linux/fsl_devices.h	2009-03-31 13:25:08.000000000 +0200
+++ linux-2.6/include/linux/fsl_devices.h	2009-03-31 13:28:54.305720748 +0200
@@ -68,6 +68,12 @@
 /* Flags related to I2C device features */
 #define FSL_I2C_DEV_SEPARATE_DFSRR	0x00000001
 #define FSL_I2C_DEV_CLOCK_5200		0x00000002
+#define FSL_I2C_DEV_CLOCK_DIV2		0x00000004
+#define FSL_I2C_DEV_CLOCK_DIV3		0x00000008
+#define FSL_I2C_DEV_CLOCK_DIV23		0x00000010
+
+extern int fsl_i2c_get_fdr(struct device_node *node,
+			   u32 i2c_clock, u32 i2c_flags);
 
 enum fsl_usb2_operating_modes {
 	FSL_USB2_MPH_HOST,
Index: linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c	2009-03-31 13:25:08.000000000 +0200
+++ linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c	2009-03-31 13:28:54.309718526 +0200
@@ -225,3 +225,51 @@
 
 	while (1);
 }
+
+/**
+ * fsl_i2c_get_fdr: get calculate and return I2 frequency divider register
+ */
+static const struct mpc52xx_i2c_divider {
+	u16 divider;
+	u16 fdr;	/* including dfsrr */
+} mpc52xx_i2_dividers[] = {
+	{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
+	{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
+	{36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
+	{56, 0x29}, {64, 0x2a}, {68, 0x07}, {72, 0x2b},
+	{80, 0x2c}, {88, 0x09}, {96, 0x2d}, {104, 0x0a},
+	{112, 0x2e}, {128, 0x2f}, {144, 0x0c}, {160, 0x30},
+	{192, 0x31}, {224, 0x32}, {240, 0x0f}, {256, 0x33},
+	{288, 0x10}, {320, 0x34}, {384, 0x35}, {448, 0x36},
+	{480, 0x13}, {512, 0x37}, {576, 0x14}, {640, 0x38},
+	{768, 0x39}, {896, 0x3a}, {960, 0x17}, {1024, 0x3b},
+	{1152, 0x18}, {1280, 0x3c}, {1536, 0x3d}, {1792, 0x3e},
+	{1920, 0x1b}, {2048, 0x3f}, {2304, 0x1c}, {2560, 0x1d},
+	{3072, 0x1e}, {3840, 0x1f}
+};
+
+int fsl_i2c_get_fdr(struct device_node *node, u32 i2c_clock, u32 i2c_flags)
+{
+	const struct fsl_i2c_divider *div = NULL;
+	u32 divider;
+	int i;
+
+	if (!i2c_clock)
+		return -EINVAL;
+
+	/* Determine divider value */
+	divider = mpc52xx_find_ipb_freq(node) / i2c_clock;
+
+	/*
+	 * We want to choose an FDR/DFSR that generates an I2C bus speed that
+	 * is equal to or lower than the requested speed.
+	 */
+	for (i = 0; i < ARRAY_SIZE(fsl_i2c_8xxx_dividers); i++) {
+		div = &fsl_i2c_8xxx_dividers[i];
+		if (div->divider >= divider)
+			break;
+	}
+
+	return div ? (int)div->fdr : -EINVAL;
+}
+EXPORT_SYMBOL(fsl_i2c_get_fdr);
