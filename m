Return-Path: <wg@denx.de>
From: Wolfgang Grandegger <wg@grandegger.com>
To: Linux-i2c@vger.kernel.org
Subject: [PATCH v8 1/4] i2c-mpc: use __devinit[data] for initialization
	functions and data
Date: Wed, 17 Feb 2010 11:19:17 +0100
Message-Id: <1266401960-19127-2-git-send-email-wg@grandegger.com>
In-Reply-To: <1266401960-19127-1-git-send-email-wg@grandegger.com>
References: <1266401960-19127-1-git-send-email-wg@grandegger.com>
Cc: Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wolfgang Grandegger <wg@denx.de>

"__devinit[data]" has not yet been used for all initialization functions
and data. To avoid truncating lines, the struct "mpc_i2c_match_data" has
been renamed to "mpc_i2c_data", which is even the better name.

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
Tested-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/i2c/busses/i2c-mpc.c |   99 +++++++++++++++++++----------------------
 1 files changed, 46 insertions(+), 53 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index f627001..2f74d9b 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -66,7 +66,7 @@ struct mpc_i2c_divider {
 	u16 fdr;	/* including dfsrr */
 };
 
-struct mpc_i2c_match_data {
+struct mpc_i2c_data {
 	void (*setclock)(struct device_node *node,
 			 struct mpc_i2c *i2c,
 			 u32 clock, u32 prescaler);
@@ -165,7 +165,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 }
 
 #ifdef CONFIG_PPC_MPC52xx
-static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
+static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] __devinitconst = {
 	{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
 	{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
 	{36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
@@ -186,7 +186,8 @@ static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
 	{10240, 0x9d}, {12288, 0x9e}, {15360, 0x9f}
 };
 
-int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int prescaler)
+static int __devinit mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
+					  int prescaler)
 {
 	const struct mpc_i2c_divider *div = NULL;
 	unsigned int pvr = mfspr(SPRN_PVR);
@@ -215,9 +216,9 @@ int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int prescaler)
 	return div ? (int)div->fdr : -EINVAL;
 }
 
-static void mpc_i2c_setclock_52xx(struct device_node *node,
-				  struct mpc_i2c *i2c,
-				  u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
+					    struct mpc_i2c *i2c,
+					    u32 clock, u32 prescaler)
 {
 	int ret, fdr;
 
@@ -230,15 +231,15 @@ static void mpc_i2c_setclock_52xx(struct device_node *node,
 		dev_info(i2c->dev, "clock %d Hz (fdr=%d)\n", clock, fdr);
 }
 #else /* !CONFIG_PPC_MPC52xx */
-static void mpc_i2c_setclock_52xx(struct device_node *node,
-				  struct mpc_i2c *i2c,
-				  u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
+					    struct mpc_i2c *i2c,
+					    u32 clock, u32 prescaler)
 {
 }
 #endif /* CONFIG_PPC_MPC52xx*/
 
 #ifdef CONFIG_FSL_SOC
-static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] = {
+static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] __devinitconst = {
 	{160, 0x0120}, {192, 0x0121}, {224, 0x0122}, {256, 0x0123},
 	{288, 0x0100}, {320, 0x0101}, {352, 0x0601}, {384, 0x0102},
 	{416, 0x0602}, {448, 0x0126}, {480, 0x0103}, {512, 0x0127},
@@ -258,7 +259,7 @@ static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] = {
 	{49152, 0x011e}, {61440, 0x011f}
 };
 
-u32 mpc_i2c_get_sec_cfg_8xxx(void)
+static u32 __devinit mpc_i2c_get_sec_cfg_8xxx(void)
 {
 	struct device_node *node = NULL;
 	u32 __iomem *reg;
@@ -287,7 +288,8 @@ u32 mpc_i2c_get_sec_cfg_8xxx(void)
 	return val;
 }
 
-int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock, u32 prescaler)
+static int __devinit mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
+					  u32 prescaler)
 {
 	const struct mpc_i2c_divider *div = NULL;
 	u32 divider;
@@ -320,9 +322,9 @@ int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock, u32 prescaler)
 	return div ? (int)div->fdr : -EINVAL;
 }
 
-static void mpc_i2c_setclock_8xxx(struct device_node *node,
-				  struct mpc_i2c *i2c,
-				  u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
+					    struct mpc_i2c *i2c,
+					    u32 clock, u32 prescaler)
 {
 	int ret, fdr;
 
@@ -338,9 +340,9 @@ static void mpc_i2c_setclock_8xxx(struct device_node *node,
 }
 
 #else /* !CONFIG_FSL_SOC */
-static void mpc_i2c_setclock_8xxx(struct device_node *node,
-				  struct mpc_i2c *i2c,
-				  u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
+					    struct mpc_i2c *i2c,
+					    u32 clock, u32 prescaler)
 {
 }
 #endif /* CONFIG_FSL_SOC */
@@ -529,8 +531,8 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
 			clock = *prop;
 
 		if (match->data) {
-			struct mpc_i2c_match_data *data =
-				(struct mpc_i2c_match_data *)match->data;
+			struct mpc_i2c_data *data =
+				(struct mpc_i2c_data *)match->data;
 			data->setclock(op->node, i2c, clock, data->prescaler);
 		} else {
 			/* Backwards compatibility */
@@ -582,44 +584,35 @@ static int __devexit fsl_i2c_remove(struct of_device *op)
 	return 0;
 };
 
+static struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
+	.setclock = mpc_i2c_setclock_52xx,
+};
+
+static struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata = {
+	.setclock = mpc_i2c_setclock_8xxx,
+};
+
+static struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata = {
+	.setclock = mpc_i2c_setclock_8xxx,
+	.prescaler = 2,
+};
+
+static struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata = {
+	.setclock = mpc_i2c_setclock_8xxx,
+	.prescaler = 3,
+};
+
 static const struct of_device_id mpc_i2c_of_match[] = {
-	{.compatible = "mpc5200-i2c",
-	 .data = &(struct mpc_i2c_match_data) {
-			.setclock = mpc_i2c_setclock_52xx,
-		},
-	},
-	{.compatible = "fsl,mpc5200b-i2c",
-	 .data = &(struct mpc_i2c_match_data) {
-			.setclock = mpc_i2c_setclock_52xx,
-		},
-	},
-	{.compatible = "fsl,mpc5200-i2c",
-	 .data = &(struct mpc_i2c_match_data) {
-			.setclock = mpc_i2c_setclock_52xx,
-		},
-	},
-	{.compatible = "fsl,mpc8313-i2c",
-	 .data = &(struct mpc_i2c_match_data) {
-			.setclock = mpc_i2c_setclock_8xxx,
-		},
-	},
-	{.compatible = "fsl,mpc8543-i2c",
-	 .data = &(struct mpc_i2c_match_data) {
-			.setclock = mpc_i2c_setclock_8xxx,
-			.prescaler = 2,
-		},
-	},
-	{.compatible = "fsl,mpc8544-i2c",
-	 .data = &(struct mpc_i2c_match_data) {
-			.setclock = mpc_i2c_setclock_8xxx,
-			.prescaler = 3,
-		},
+	{.compatible = "mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
+	{.compatible = "fsl,mpc5200b-i2c", .data = &mpc_i2c_data_52xx, },
+	{.compatible = "fsl,mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
+	{.compatible = "fsl,mpc8313-i2c", .data = &mpc_i2c_data_8313, },
+	{.compatible = "fsl,mpc8543-i2c", .data = &mpc_i2c_data_8543, },
+	{.compatible = "fsl,mpc8544-i2c", .data = &mpc_i2c_data_8544, },
 	/* Backward compatibility */
-	},
 	{.compatible = "fsl-i2c", },
 	{},
 };
-
 MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
 
 
-- 
1.6.2.5
