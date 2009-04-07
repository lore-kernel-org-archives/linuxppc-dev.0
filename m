Return-Path: <wg@denx.de>
Message-Id: <20090407082231.500525932@denx.de>
Date: Tue, 07 Apr 2009 10:20:55 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH v3 3/5] i2c: i2c-mpc: make I2C bus speed configurable
References: <20090407082052.477328750@denx.de>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org,
	Ben Dooks <ben-linux@fluff.org>
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
	...
	{.compatible = "fsl,mpc8543-i2c",
	 .data = &(struct fsl_i2c_match_data) {
			.setclock = mpc_i2c_setclock_8xxx,
			.prescaler = 2,
		},
	},

The "data" field defines the relevant I2C setclock function and the
relevant pre-scaler for the I2C source clock frequency.

It uses arch-specific tables and functions to determine resonable
Freqency Divider Register (fdr) values for MPC83xx, MPC85xx, MPC86xx,
MPC5200 and MPC5200B.

The i2c->flags field and the corresponding FSL_I2C_DEV_* definitions
have been removed as they are obsolete.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/i2c/busses/i2c-mpc.c |  262 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 242 insertions(+), 20 deletions(-)

Index: linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6-galak.orig/drivers/i2c/busses/i2c-mpc.c	2009-04-07 10:09:14.012720756 +0200
+++ linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c	2009-04-07 10:09:14.581719146 +0200
@@ -26,6 +26,9 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 
+#include <asm/mpc52xx.h>
+#include <sysdev/fsl_soc.h>
+
 #define DRV_NAME "mpc-i2c"
 
 #define MPC_I2C_FDR   0x04
@@ -56,7 +59,18 @@
 	wait_queue_head_t queue;
 	struct i2c_adapter adap;
 	int irq;
-	u32 flags;
+};
+
+struct mpc_i2c_divider {
+	u16 divider;
+	u16 fdr;	/* including dfsrr */
+};
+
+struct mpc_i2c_match_data {
+	void (*setclock)(struct device_node *node,
+			 struct mpc_i2c *i2c,
+			 u32 clock, u32 prescaler);
+	u32 prescaler;
 };
 
 static inline void writeccr(struct mpc_i2c *i2c, u32 x)
@@ -150,17 +164,180 @@
 	return 0;
 }
 
-static void mpc_i2c_setclock(struct mpc_i2c *i2c)
+#ifdef CONFIG_PPC_52xx
+static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
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
+int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int prescaler)
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
+		div = &mpc_i2c_dividers_52xx[i];
+		/* Old MPC5200 rev A CPUs do not support the high bits */
+		if (div->fdr & 0xc0 && pvr == 0x80822011)
+			continue;
+		if (div->divider >= divider)
+			break;
+	}
+
+	return div ? (int)div->fdr : -EINVAL;
+}
+
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
+#else /* !CONFIG_PPC_52xx */
+static void mpc_i2c_setclock_52xx(struct device_node *node,
+				  struct mpc_i2c *i2c,
+				  u32 clock, u32 prescaler)
+{
+}
+#endif /* CONFIG_PPC_52xx*/
+
+#ifdef CONFIG_FSL_SOC
+static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] = {
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
+u32 mpc_i2c_get_sec_cfg_8xxx(void)
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
+int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock, u32 prescaler)
+{
+	const struct mpc_i2c_divider *div = NULL;
+	u32 divider;
+	int i;
+
+	if (!clock)
+		return -EINVAL;
+
+	/* Determine proper divider value */
+	if (of_device_is_compatible(node, "fsl,mpc8544-i2c"))
+		prescaler = mpc_i2c_get_sec_cfg_8xxx() ? 3 : 2;
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
+	for (i = 0; i < ARRAY_SIZE(mpc_i2c_dividers_8xxx); i++) {
+		div = &mpc_i2c_dividers_8xxx[i];
+		if (div->divider >= divider)
+			break;
+	}
+
+	return div ? (int)div->fdr : -EINVAL;
+}
+
+static void mpc_i2c_setclock_8xxx(struct device_node *node,
+				  struct mpc_i2c *i2c,
+				  u32 clock, u32 prescaler)
+{
+	int fdr = mpc_i2c_get_fdr_8xxx(node, clock, prescaler);
+
+	if (fdr < 0)
+		fdr = 0x1031; /* backward compatibility */
+	writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
+	writeb((fdr >> 8) & 0xff, i2c->base + MPC_I2C_DFSRR);
+	dev_info(i2c->dev, "clock %d Hz (dfsrr=%d fdr=%d)\n",
+		 clock, fdr >> 8, fdr & 0xff);
+}
+
+#else /* !CONFIG_FSL_SOC */
+static void mpc_i2c_setclock_8xxx(struct device_node *node,
+				  struct mpc_i2c *i2c,
+				  u32 clock, u32 prescaler)
 {
-	/* Set clock and filters */
-	if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
-		writeb(0x31, i2c->base + MPC_I2C_FDR);
-		writeb(0x10, i2c->base + MPC_I2C_DFSRR);
-	} else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
-		writeb(0x3f, i2c->base + MPC_I2C_FDR);
-	else
-		writel(0x1031, i2c->base + MPC_I2C_FDR);
 }
+#endif /* CONFIG_FSL_SOC */
 
 static void mpc_i2c_start(struct mpc_i2c *i2c)
 {
@@ -315,8 +492,11 @@
 static int __devinit fsl_i2c_probe(struct of_device *op,
 				   const struct of_device_id *match)
 {
-	int result = 0;
 	struct mpc_i2c *i2c;
+	const u32 *prop;
+	u32 clock = 0;
+	int result = 0;
+	int plen;
 
 	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
@@ -324,13 +504,6 @@
 
 	i2c->dev = &op->dev; /* for debug and error output */
 
-	if (of_get_property(op->node, "dfsrr", NULL))
-		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
-
-	if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
-			of_device_is_compatible(op->node, "mpc5200-i2c"))
-		i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
-
 	init_waitqueue_head(&i2c->queue);
 
 	i2c->base = of_iomap(op->node, 0);
@@ -350,7 +523,22 @@
 		}
 	}
 
-	mpc_i2c_setclock(i2c);
+	if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
+		prop = of_get_property(op->node, "clock-frequency", &plen);
+		if (prop && plen == sizeof(u32))
+			clock = *prop;
+
+		if (match->data) {
+			struct mpc_i2c_match_data *data =
+				(struct mpc_i2c_match_data *)match->data;
+			data->setclock(op->node, i2c, clock, data->prescaler);
+		} else {
+			/* Backwards compatibility */
+			if (of_get_property(op->node, "dfsrr", NULL))
+				mpc_i2c_setclock_8xxx(op->node, i2c,
+						      clock, 0);
+		}
+	}
 
 	dev_set_drvdata(&op->dev, i2c);
 
@@ -395,9 +583,43 @@
 };
 
 static const struct of_device_id mpc_i2c_of_match[] = {
-	{.compatible = "fsl-i2c",},
+	{.compatible = "mpc5200-i2c",
+	 .data = &(struct mpc_i2c_match_data) {
+			.setclock = mpc_i2c_setclock_52xx,
+		},
+	},
+	{.compatible = "fsl,mpc5200b-i2c",
+	 .data = &(struct mpc_i2c_match_data) {
+			.setclock = mpc_i2c_setclock_52xx,
+		},
+	},
+	{.compatible = "fsl,mpc5200-i2c",
+	 .data = &(struct mpc_i2c_match_data) {
+			.setclock = mpc_i2c_setclock_52xx,
+		},
+	},
+	{.compatible = "fsl,mpc8313-i2c",
+	 .data = &(struct mpc_i2c_match_data) {
+			.setclock = mpc_i2c_setclock_8xxx,
+		},
+	},
+	{.compatible = "fsl,mpc8543-i2c",
+	 .data = &(struct mpc_i2c_match_data) {
+			.setclock = mpc_i2c_setclock_8xxx,
+			.prescaler = 2,
+		},
+	},
+	{.compatible = "fsl,mpc8544-i2c",
+	 .data = &(struct mpc_i2c_match_data) {
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
 
 
