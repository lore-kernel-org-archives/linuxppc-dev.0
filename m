Return-Path: <wg@grandegger.com>
Message-ID: <49D36885.9070806@grandegger.com>
Date: Wed, 01 Apr 2009 15:13:41 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH v2] powerpc: i2c-mpc: make I2C bus speed configurable
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss <devicetree-discuss@ozlabs.org>
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
fixed clock settings will be used for backward compatibility.

The generic I2C clock properties, especially the CPU-specific source
clock pre-scaler are defined via the OF match table:

  static const struct of_device_id mpc_i2c_of_match[] = {
	...
	{.compatible = "fsl,mpc8543-i2c",
	 .data = &(struct fsl_i2c_match_data) {
			.setclock = mpc_i2c_setclock_8xxx,
			.prescaler = 2,
		},
	},

The "data" field defines the relevant I2C setclock function and the
relevant prescaler for the I2C source clock frequency.

It uses arch-specific tables and functions to determine resonable
Freqency Divider Register (fdr) values for MPC83xx, MPC85xx, MPC86xx,
MPC5200 and MPC5200B.

The i2c->flags field and the corresponding FSL_I2C_DEV_* definitions
have been removed as they are obsolete.

Furthermore dev_dbg() and dev_info() are now used to profit from a more
comprehensive output.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 Documentation/powerpc/dts-bindings/fsl/i2c.txt |   43 +++++--
 arch/powerpc/include/asm/mpc52xx.h             |   11 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c   |   57 ++++++++++
 arch/powerpc/sysdev/fsl_soc.c                  |   90 ++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h                  |   12 ++
 drivers/i2c/busses/i2c-mpc.c                   |  138 ++++++++++++++++++-------
 include/linux/fsl_devices.h                    |    9 -
 7 files changed, 302 insertions(+), 58 deletions(-)

Index: linux-2.6/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6.orig/drivers/i2c/busses/i2c-mpc.c	2009-03-31 21:29:21.000000000 +0200
+++ linux-2.6/drivers/i2c/busses/i2c-mpc.c	2009-04-01 14:56:43.824970544 +0200
@@ -20,12 +20,15 @@
 #include <linux/of_platform.h>
 #include <linux/of_i2c.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/fsl_devices.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 
+#include <asm/mpc52xx.h>
+#include <sysdev/fsl_soc.h>
+
 #define DRV_NAME "mpc-i2c"
 
 #define MPC_I2C_FDR 	0x04
@@ -50,12 +53,19 @@
 #define CSR_RXAK 0x01
 
 struct mpc_i2c {
+	struct device *dev;
 	void __iomem *base;
 	u32 interrupt;
 	wait_queue_head_t queue;
 	struct i2c_adapter adap;
 	int irq;
-	u32 flags;
+};
+
+struct fsl_i2c_match_data {
+	void (*setclock)(struct device_node *node,
+			 struct mpc_i2c *i2c,
+			 u32 clock, u32 prescaler);
+	u32 prescaler;
 };
 
 static __inline__ void writeccr(struct mpc_i2c *i2c, u32 x)
@@ -105,7 +115,7 @@
 		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
 			schedule();
 			if (time_after(jiffies, orig_jiffies + timeout)) {
-				pr_debug("I2C: timeout\n");
+				dev_dbg(i2c->dev, "timeout\n");
 				writeccr(i2c, 0);
 				result = -EIO;
 				break;
@@ -119,10 +129,10 @@
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
@@ -135,17 +145,17 @@
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
@@ -153,16 +163,30 @@
 	return 0;
 }
 
-static void mpc_i2c_setclock(struct mpc_i2c *i2c)
-{
-	/* Set clock and filters */
-	if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
-		writeb(0x31, i2c->base + MPC_I2C_FDR);
-		writeb(0x10, i2c->base + MPC_I2C_DFSRR);
-	} else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
-		writeb(0x3f, i2c->base + MPC_I2C_FDR);
-	else
-		writel(0x1031, i2c->base + MPC_I2C_FDR);
+static void mpc_i2c_setclock_52xx(struct device_node *node,
+				  struct mpc_i2c *i2c,
+				  u32 clock, u32 prescaler)
+{
+	int fdr = mpc52xx_i2c_get_fdr(node, clock, prescaler);
+
+	if (fdr < 0)
+		fdr = 0x3f; /* backward compatibility */
+	writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
+	dev_info(i2c->dev, "clock %d Hz (fdr=%d)\n", clock, fdr);
+}
+
+static void mpc_i2c_setclock_8xxx(struct device_node *node,
+				  struct mpc_i2c *i2c,
+				  u32 clock, u32 prescaler)
+{
+	int fdr = fsl_i2c_get_fdr(node, clock, prescaler);
+
+	if (fdr < 0)
+		fdr = 0x1031; /* backward compatibility */
+	writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
+	writeb((fdr >> 8) & 0xff, i2c->base + MPC_I2C_DFSRR);
+	dev_info(i2c->dev, "clock %d Hz (dfsrr=%d fdr=%d)\n",
+		 clock, fdr >> 8, fdr & 0xff);
 }
 
 static void mpc_i2c_start(struct mpc_i2c *i2c)
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
@@ -316,13 +341,18 @@
 
 static int __devinit fsl_i2c_probe(struct of_device *op, const struct of_device_id *match)
 {
-	int result = 0;
 	struct mpc_i2c *i2c;
+	const u32 *prop;
+	u32 clock = 0;
+	int result = 0;
+	int plen;
 
 	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
+	i2c->dev = &op->dev; /* for device printouts */
+
 	init_waitqueue_head(&i2c->queue);
 
 	i2c->base = of_iomap(op->node, 0);
@@ -343,14 +373,20 @@
 	}
 
 	if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
-		if (of_get_property(op->node, "dfsrr", NULL))
-			i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
-
-		if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
-		    of_device_is_compatible(op->node, "mpc5200-i2c"))
-			i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
-
-		mpc_i2c_setclock(i2c);
+		prop = of_get_property(op->node, "clock-frequency", &plen);
+		if (prop && plen == sizeof(u32))
+			clock = *prop;
+
+		if (match->data) {
+			struct fsl_i2c_match_data *data =
+				(struct fsl_i2c_match_data *)match->data;
+			data->setclock(op->node, i2c, clock, data->prescaler);
+		} else {
+			/* Backwards compatibility */
+			if (of_get_property(op->node, "dfsrr", NULL))
+				mpc_i2c_setclock_8xxx(op->node, i2c,
+						      clock, 0);
+		}
 	}
 
 	dev_set_drvdata(&op->dev, i2c);
@@ -396,9 +432,43 @@
 };
 
 static const struct of_device_id mpc_i2c_of_match[] = {
-	{.compatible = "fsl-i2c",},
+	{.compatible = "mpc5200-i2c",
+	 .data = &(struct fsl_i2c_match_data) {
+			.setclock = mpc_i2c_setclock_52xx,
+		},
+	},
+	{.compatible = "fsl,mpc5200b-i2c",
+	 .data = &(struct fsl_i2c_match_data) {
+			.setclock = mpc_i2c_setclock_52xx,
+		},
+	},
+	{.compatible = "fsl,mpc5200-i2c",
+	 .data = &(struct fsl_i2c_match_data) {
+			.setclock = mpc_i2c_setclock_52xx,
+		},
+	},
+	{.compatible = "fsl,mpc8313-i2c",
+	 .data = &(struct fsl_i2c_match_data) {
+			.setclock = mpc_i2c_setclock_8xxx,
+		},
+	},
+	{.compatible = "fsl,mpc8543-i2c",
+	 .data = &(struct fsl_i2c_match_data) {
+			.setclock = mpc_i2c_setclock_8xxx,
+			.prescaler = 2,
+		},
+	},
+	{.compatible = "fsl,mpc8544-i2c",
+	 .data = &(struct fsl_i2c_match_data) {
+			.setclock = mpc_i2c_setclock_8xxx,
+			.prescaler = 3,
+		},
+	/* Backward compatibility */
+	},
+	{.compatible = "fsl-i2c", },
 	{},
 };
+
 MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
 
 
@@ -419,7 +489,7 @@
 
 	rv = of_register_platform_driver(&mpc_i2c_driver);
 	if (rv)
-		printk(KERN_ERR DRV_NAME 
+		printk(KERN_ERR DRV_NAME
 		       " of_register_platform_driver failed (%i)\n", rv);
 	return rv;
 }
Index: linux-2.6/arch/powerpc/sysdev/fsl_soc.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/fsl_soc.c	2009-03-31 21:27:52.000000000 +0200
+++ linux-2.6/arch/powerpc/sysdev/fsl_soc.c	2009-04-01 12:09:18.796719327 +0200
@@ -39,7 +39,7 @@
 #include <sysdev/fsl_soc.h>
 #include <mm/mmu_decl.h>
 #include <asm/cpm2.h>
-
+#define DEBUG
 extern void init_fcc_ioports(struct fs_platform_info*);
 extern void init_fec_ioports(struct fs_platform_info*);
 extern void init_smc_ioports(struct fs_uart_platform_info*);
@@ -102,6 +102,94 @@
 }
 EXPORT_SYMBOL(fsl_get_sys_freq);
 
+#ifdef CONFIG_I2C_MPC
+static const struct fsl_i2c_8xxx_divider {
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
+				val = in_be32(reg) & 0x00000080; /* sec-cfg */
+			iounmap(reg);
+		}
+	}
+	if (node)
+		of_node_put(node);
+
+	return val;
+}
+
+int fsl_i2c_get_fdr(struct device_node *node, u32 clock, u32 prescaler)
+{
+	const struct fsl_i2c_8xxx_divider *div = NULL;
+	u32 divider;
+	int i;
+
+	if (!clock)
+		return -EINVAL;
+
+	/* Determine proper divider value */
+	if (of_device_is_compatible(node, "fsl,mpc8544-i2c"))
+		prescaler = fsl_i2c_get_sec_cfg() ? 3 : 2;
+	if (!prescaler)
+		prescaler = 1;
+
+	divider = fsl_get_sys_freq() / clock / prescaler;
+
+	pr_debug("I2C: src_clock=%d clock=%d divider=%d\n",
+		 fsl_get_sys_freq(), clock, divider);
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
--- linux-2.6.orig/include/linux/fsl_devices.h	2009-03-31 21:27:52.000000000 +0200
+++ linux-2.6/include/linux/fsl_devices.h	2009-04-01 11:22:36.677719938 +0200
@@ -60,15 +60,6 @@
 #define FSL_GIANFAR_BRD_HAS_PHY_INTR	0x00000001 /* set or use a timer */
 #define FSL_GIANFAR_BRD_IS_REDUCED	0x00000002 /* Set if RGMII, RMII */
 
-struct fsl_i2c_platform_data {
-	/* device specific information */
-	u32	device_flags;
-};
-
-/* Flags related to I2C device features */
-#define FSL_I2C_DEV_SEPARATE_DFSRR	0x00000001
-#define FSL_I2C_DEV_CLOCK_5200		0x00000002
-
 enum fsl_usb2_operating_modes {
 	FSL_USB2_MPH_HOST,
 	FSL_USB2_DR_HOST,
Index: linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c	2009-03-31 21:27:52.000000000 +0200
+++ linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c	2009-04-01 12:05:33.945719636 +0200
@@ -225,3 +225,60 @@
 
 	while (1);
 }
+
+/**
+ * fsl_i2c_get_fdr: get calculate and return I2 frequency divider register
+ */
+static const struct mpc52xx_i2c_divider {
+	u16 divider;
+	u16 fdr;	/* including dfsrr */
+} mpc52xx_i2c_dividers[] = {
+	{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
+	{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
+	{36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
+	{52, 0x63}, {56, 0x29}, {60, 0x41}, {64, 0x2a},
+	{68, 0x07}, {72, 0x2b}, {80, 0x2c}, {88, 0x09},
+	{96, 0x2d}, {104, 0x0a}, {112, 0x2e}, {120, 0x81},
+	{128, 0x2f}, {136, 0x47}, {144, 0x0c}, {160, 0x30},
+	{176, 0x49}, {192, 0x31}, {208, 0x4a}, {224, 0x32},
+	{240, 0x0f}, {256, 0x33}, {272, 0x87}, {288, 0x10},
+	{320, 0x34}, {352, 0x89}, {384, 0x35}, {416, 0x8a},
+	{448, 0x36}, {480, 0x13}, {512, 0x37}, {576, 0x14},
+	{640, 0x38}, {768, 0x39}, {896, 0x3a}, {960, 0x17},
+	{1024, 0x3b}, {1152, 0x18}, {1280, 0x3c}, {1536, 0x3d},
+	{1792, 0x3e}, {1920, 0x1b}, {2048, 0x3f}, {2304, 0x1c},
+	{2560, 0x1d}, {3072, 0x1e}, {3584, 0x7e}, {3840, 0x1f},
+	{4096, 0x7f}, {4608, 0x5c}, {5120, 0x5d}, {6144, 0x5e},
+	{7168, 0xbe}, {7680, 0x5f}, {8192, 0xbf}, {9216, 0x9c},
+	{10240, 0x9d}, {12288, 0x9e}, {15360, 0x9f}
+};
+
+int mpc52xx_i2c_get_fdr(struct device_node *node, u32 clock, int prescaler)
+{
+	const struct mpc52xx_i2c_divider *div = NULL;
+	unsigned int pvr = mfspr(SPRN_PVR);
+	u32 divider;
+	int i;
+
+	if (!clock)
+		return -EINVAL;
+
+	/* Determine divider value */
+	divider = mpc52xx_find_ipb_freq(node) / clock;
+
+	/*
+	 * We want to choose an FDR/DFSR that generates an I2C bus speed that
+	 * is equal to or lower than the requested speed.
+	 */
+	for (i = 0; i < ARRAY_SIZE(mpc52xx_i2c_dividers); i++) {
+		div = &mpc52xx_i2c_dividers[i];
+		/* Old MPC5200 rev A CPUs do not support the high bits */
+		if (div->fdr & 0xc0 && pvr == 0x80822011)
+			continue;
+		if (div->divider >= divider)
+			break;
+	}
+
+	return div ? (int)div->fdr : -EINVAL;
+}
+EXPORT_SYMBOL(mpc52xx_i2c_get_fdr);
Index: linux-2.6/arch/powerpc/include/asm/mpc52xx.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/mpc52xx.h	2009-03-17 10:28:10.000000000 +0100
+++ linux-2.6/arch/powerpc/include/asm/mpc52xx.h	2009-04-01 12:30:00.389718130 +0200
@@ -287,6 +287,17 @@
 static inline void mpc52xx_setup_pci(void) { }
 #endif
 
+#ifdef CONFIG_PPC_MPC52xx
+extern int mpc52xx_i2c_get_fdr(struct device_node *node,
+			       u32 clock, int prescaler);
+#else
+static inline int mpc52xx_i2c_get_fdr(struct device_node *node,
+				      u32 clock, u32 prescaler)
+{
+	return -EINVAL;
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_PM
Index: linux-2.6/Documentation/powerpc/dts-bindings/fsl/i2c.txt
===================================================================
--- linux-2.6.orig/Documentation/powerpc/dts-bindings/fsl/i2c.txt	2009-03-31 21:35:51.000000000 +0200
+++ linux-2.6/Documentation/powerpc/dts-bindings/fsl/i2c.txt	2009-04-01 12:27:51.962721274 +0200
@@ -7,8 +7,10 @@
 
 Recommended properties :
 
- - compatible : Should be "fsl-i2c" for parts compatible with
-   Freescale I2C specifications.
+ - compatible : compatibility list with 2 entries, the first should
+   be "fsl,CHIP-i2c" where CHIP is the name of a compatible processor,
+   e.g. mpc8313, mpc8443, mpc8444 or mpc5200b. The second should be
+   "fsl-i2c".
  - interrupts : <a b> where a is the interrupt number and b is a
    field that represents an encoding of the sense and level
    information for the interrupt.  This should be encoded based on
@@ -16,19 +18,32 @@
    controller you have.
  - interrupt-parent : the phandle for the interrupt controller that
    services interrupts for this device.
- - dfsrr : boolean; if defined, indicates that this I2C device has
-   a digital filter sampling rate register
- - fsl5200-clocking : boolean; if defined, indicated that this device
-   uses the FSL 5200 clocking mechanism.
  - fsl,preserve-clocking : boolean; if defined, the clock settings
    from the bootloader are preserved (not touched).
+ - clock-frequency : desired I2C bus clock frequency in Hz.
 
-Example :
-	i2c@3000 {
-		interrupt-parent = <40000>;
-		interrupts = <1b 3>;
-		reg = <3000 18>;
-		device_type = "i2c";
-		compatible  = "fsl-i2c";
-		dfsrr;
+Examples :
+
+	i2c@3d00 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+		cell-index = <0>;
+		reg = <0x3d00 0x40>;
+		interrupts = <2 15 0>;
+		interrupt-parent = <&mpc5200_pic>;
+		fsl,preserve-clocking;
+	};
+
+	i2c@3100 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cell-index = <1>;
+		compatible = "fsl,mpc8544-i2c", "fsl-i2c";
+		reg = <0x3100 0x100>;
+		interrupts = <43 2>;
+		interrupt-parent = <&mpic>;
+		clock-frequency = <400000>;
 	};
+
+
Index: linux-2.6/arch/powerpc/sysdev/fsl_soc.h
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/fsl_soc.h	2009-04-01 14:28:43.000000000 +0200
+++ linux-2.6/arch/powerpc/sysdev/fsl_soc.h	2009-04-01 14:29:10.629721056 +0200
@@ -14,6 +14,18 @@
 #endif
 extern u32 fsl_get_sys_freq(void);
 
+
+#ifdef CONFIG_FSL_SOC
+extern int fsl_i2c_get_fdr(struct device_node *node,
+			   u32 clock, u32 divider);
+#else
+static inline int fsl_i2c_get_fdr(struct device_node *node,
+				  u32 clock, u32 prescaler)
+{
+	return -EINVAL;
+}
+#endif
+
 struct spi_board_info;
 struct device_node;
 
