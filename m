Return-Path: <wg@denx.de>
From: Wolfgang Grandegger <wg@grandegger.com>
To: Linux-i2c@vger.kernel.org
Subject: [PATCH v8 3/4] i2c-mpc: add support for the MPC512x processors from
	Freescale
Date: Wed, 17 Feb 2010 11:19:19 +0100
Message-Id: <1266401960-19127-4-git-send-email-wg@grandegger.com>
In-Reply-To: <1266401960-19127-3-git-send-email-wg@grandegger.com>
References: <1266401960-19127-1-git-send-email-wg@grandegger.com>
	<1266401960-19127-2-git-send-email-wg@grandegger.com>
	<1266401960-19127-3-git-send-email-wg@grandegger.com>
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

As I2C interrupts must  be enabled for the MPC512x by the setup function
as well, "fsl,preserve-clocking" is handled in a slighly different way.
Also, the old settings are now reported calling dev_dbg(). For the
MPC512x the clock setup function of the MPC52xx can be re-used.
Furthermore, the Kconfig help has been updated and corrected.

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/i2c/busses/Kconfig   |    7 +--
 drivers/i2c/busses/i2c-mpc.c |   93 +++++++++++++++++++++++++++++++++--------
 2 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5f318ce..5477e41 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -418,13 +418,12 @@ config I2C_IXP2000
 	  instead.
 
 config I2C_MPC
-	tristate "MPC107/824x/85xx/52xx/86xx"
+	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
 	depends on PPC32
 	help
 	  If you say yes to this option, support will be included for the
-	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
-	  MPC85xx/MPC8641 family processors. The driver may also work on 52xx
-	  family processors, though interrupts are known not to work.
+	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
+	  MPC8240, MPC8245, MPC83xx, MPC85xx and MPC8641 family processors.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mpc.
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 370c342..78a15af 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -31,6 +31,9 @@
 
 #define DRV_NAME "mpc-i2c"
 
+#define MPC_I2C_CLOCK_LEGACY   0
+#define MPC_I2C_CLOCK_PRESERVE (~0U)
+
 #define MPC_I2C_FDR   0x04
 #define MPC_I2C_CR    0x08
 #define MPC_I2C_SR    0x0c
@@ -163,7 +166,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 	return 0;
 }
 
-#ifdef CONFIG_PPC_MPC52xx
+#if defined(CONFIG_PPC_MPC52xx) || defined(CONFIG_PPC_MPC512x)
 static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] __devinitconst = {
 	{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
 	{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
@@ -193,7 +196,7 @@ static int __devinit mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
 	u32 divider;
 	int i;
 
-	if (!clock)
+	if (clock == MPC_I2C_CLOCK_LEGACY)
 		return -EINVAL;
 
 	/* Determine divider value */
@@ -221,6 +224,12 @@ static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
 {
 	int ret, fdr;
 
+	if (clock == MPC_I2C_CLOCK_PRESERVE) {
+		dev_dbg(i2c->dev, "using fdr %d\n",
+			readb(i2c->base + MPC_I2C_FDR));
+		return;
+	}
+
 	ret = mpc_i2c_get_fdr_52xx(node, clock, prescaler);
 	fdr = (ret >= 0) ? ret : 0x3f; /* backward compatibility */
 
@@ -229,13 +238,49 @@ static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
 	if (ret >= 0)
 		dev_info(i2c->dev, "clock %d Hz (fdr=%d)\n", clock, fdr);
 }
-#else /* !CONFIG_PPC_MPC52xx */
+#else /* !(CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x) */
 static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
 }
-#endif /* CONFIG_PPC_MPC52xx*/
+#endif /* CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x */
+
+#ifdef CONFIG_PPC_MPC512x
+static void __devinit mpc_i2c_setup_512x(struct device_node *node,
+					 struct mpc_i2c *i2c,
+					 u32 clock, u32 prescaler)
+{
+	struct device_node *node_ctrl;
+	void __iomem *ctrl;
+	const u32 *pval;
+	u32 idx;
+
+	/* Enable I2C interrupts for mpc5121 */
+	node_ctrl = of_find_compatible_node(NULL, NULL,
+					    "fsl,mpc5121-i2c-ctrl");
+	if (node_ctrl) {
+		ctrl = of_iomap(node_ctrl, 0);
+		if (ctrl) {
+			/* Interrupt enable bits for i2c-0/1/2: bit 24/26/28 */
+			pval = of_get_property(node, "reg", NULL);
+			idx = (*pval & 0xff) / 0x20;
+			setbits32(ctrl, 1 << (24 + idx * 2));
+			iounmap(ctrl);
+		}
+		of_node_put(node_ctrl);
+	}
+
+	/* The clock setup for the 52xx works also fine for the 512x */
+	mpc_i2c_setup_52xx(node, i2c, clock, prescaler);
+}
+#else /* CONFIG_PPC_MPC512x */
+static void __devinit mpc_i2c_setup_512x(struct device_node *node,
+					 struct mpc_i2c *i2c,
+					 u32 clock, u32 prescaler)
+{
+}
+#endif /* CONFIG_PPC_MPC512x */
 
 #ifdef CONFIG_FSL_SOC
 static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] __devinitconst = {
@@ -294,7 +339,7 @@ static int __devinit mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 	u32 divider;
 	int i;
 
-	if (!clock)
+	if (clock == MPC_I2C_CLOCK_LEGACY)
 		return -EINVAL;
 
 	/* Determine proper divider value */
@@ -327,6 +372,13 @@ static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
 {
 	int ret, fdr;
 
+	if (clock == MPC_I2C_CLOCK_PRESERVE) {
+		dev_dbg(i2c->dev, "using dfsrr %d, fdr %d\n",
+			readb(i2c->base + MPC_I2C_DFSRR),
+			readb(i2c->base + MPC_I2C_FDR));
+		return;
+	}
+
 	ret = mpc_i2c_get_fdr_8xxx(node, clock, prescaler);
 	fdr = (ret >= 0) ? ret : 0x1031; /* backward compatibility */
 
@@ -495,7 +547,7 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
 {
 	struct mpc_i2c *i2c;
 	const u32 *prop;
-	u32 clock = 0;
+	u32 clock = MPC_I2C_CLOCK_LEGACY;
 	int result = 0;
 	int plen;
 
@@ -524,20 +576,21 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
 		}
 	}
 
-	if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
+	if (of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
+		clock = MPC_I2C_CLOCK_PRESERVE;
+	} else {
 		prop = of_get_property(op->node, "clock-frequency", &plen);
 		if (prop && plen == sizeof(u32))
 			clock = *prop;
+	}
 
-		if (match->data) {
-			struct mpc_i2c_data *data =
-				(struct mpc_i2c_data *)match->data;
-			data->setup(op->node, i2c, clock, data->prescaler);
-		} else {
-			/* Backwards compatibility */
-			if (of_get_property(op->node, "dfsrr", NULL))
-				mpc_i2c_setup_8xxx(op->node, i2c, clock, 0);
-		}
+	if (match->data) {
+		struct mpc_i2c_data *data = match->data;
+		data->setup(op->node, i2c, clock, data->prescaler);
+	} else {
+		/* Backwards compatibility */
+		if (of_get_property(op->node, "dfsrr", NULL))
+			mpc_i2c_setup_8xxx(op->node, i2c, clock, 0);
 	}
 
 	dev_set_drvdata(&op->dev, i2c);
@@ -582,6 +635,10 @@ static int __devexit fsl_i2c_remove(struct of_device *op)
 	return 0;
 };
 
+static struct mpc_i2c_data mpc_i2c_data_512x __devinitdata = {
+	.setup = mpc_i2c_setup_512x,
+};
+
 static struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
 	.setup = mpc_i2c_setup_52xx,
 };
@@ -604,6 +661,7 @@ static const struct of_device_id mpc_i2c_of_match[] = {
 	{.compatible = "mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
 	{.compatible = "fsl,mpc5200b-i2c", .data = &mpc_i2c_data_52xx, },
 	{.compatible = "fsl,mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
+	{.compatible = "fsl,mpc5121-i2c", .data = &mpc_i2c_data_512x, },
 	{.compatible = "fsl,mpc8313-i2c", .data = &mpc_i2c_data_8313, },
 	{.compatible = "fsl,mpc8543-i2c", .data = &mpc_i2c_data_8543, },
 	{.compatible = "fsl,mpc8544-i2c", .data = &mpc_i2c_data_8544, },
@@ -613,7 +671,6 @@ static const struct of_device_id mpc_i2c_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
 
-
 /* Structure for a device driver */
 static struct of_platform_driver mpc_i2c_driver = {
 	.match_table	= mpc_i2c_of_match,
@@ -646,5 +703,5 @@ module_exit(fsl_i2c_exit);
 
 MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
 MODULE_DESCRIPTION("I2C-Bus adapter for MPC107 bridge and "
-		   "MPC824x/85xx/52xx processors");
+		   "MPC824x/83xx/85xx/86xx/512x/52xx processors");
 MODULE_LICENSE("GPL");
-- 
1.6.2.5
