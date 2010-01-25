Return-Path: <wg@denx.de>
From: Wolfgang Grandegger <wg@grandegger.com>
To: Linux-i2c@vger.kernel.org
Subject: [PATCH 2/3] i2c-mpc: add support for the MPC512x processors from
	Freescale
Date: Mon, 25 Jan 2010 09:27:08 +0100
Message-Id: <1264408029-5290-3-git-send-email-wg@grandegger.com>
In-Reply-To: <1264408029-5290-2-git-send-email-wg@grandegger.com>
References: <1264408029-5290-1-git-send-email-wg@grandegger.com>
	<1264408029-5290-2-git-send-email-wg@grandegger.com>
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

The "setclock" initialization functions have been renamed to "setup"
because I2C interrupts must be enabled for the MPC512x. This requires
to handle "fsl,preserve-clocking" in a slighly different way. Also,
the old settings are now reported calling dev_dbg(). For the MPC512x
the clock setup function of the MPC52xx can be re-used.

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
---
 drivers/i2c/busses/Kconfig   |    9 ++--
 drivers/i2c/busses/i2c-mpc.c |  122 ++++++++++++++++++++++++++++++------------
 2 files changed, 93 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5f318ce..f481f30 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -418,13 +418,14 @@ config I2C_IXP2000
 	  instead.
 
 config I2C_MPC
-	tristate "MPC107/824x/85xx/52xx/86xx"
+	tristate "MPC107/824x/85xx/512x/52xx/86xx"
 	depends on PPC32
 	help
 	  If you say yes to this option, support will be included for the
-	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
-	  MPC85xx/MPC8641 family processors. The driver may also work on 52xx
-	  family processors, though interrupts are known not to work.
+	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245,
+	  MPC85xx/MPC8641 and MPC512x family processors. The driver may
+	  also work on 52xx family processors, though interrupts are known
+	  not to work.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mpc.
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 2cb864e..70c3e5d 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -67,9 +67,8 @@ struct mpc_i2c_divider {
 };
 
 struct mpc_i2c_data {
-	void (*setclock)(struct device_node *node,
-			 struct mpc_i2c *i2c,
-			 u32 clock, u32 prescaler);
+	void (*setup)(struct device_node *node, struct mpc_i2c *i2c,
+		      u32 clock, u32 prescaler);
 	u32 prescaler;
 };
 
@@ -164,7 +163,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 	return 0;
 }
 
-#ifdef CONFIG_PPC_MPC52xx
+#if defined(CONFIG_PPC_MPC52xx) || defined(CONFIG_PPC_MPC512x)
 static const struct __devinitdata mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
 	{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
 	{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
@@ -216,12 +215,18 @@ static int __devinit mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
 	return div ? (int)div->fdr : -EINVAL;
 }
 
-static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
-					    struct mpc_i2c *i2c,
-					    u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
+					 struct mpc_i2c *i2c,
+					 u32 clock, u32 prescaler)
 {
 	int ret, fdr;
 
+	if (clock == -1) {
+		dev_dbg(i2c->dev, "using fdr %d\n",
+			readb(i2c->base + MPC_I2C_FDR));
+		return;	/* preserve clocking */
+	}
+
 	ret = mpc_i2c_get_fdr_52xx(node, clock, prescaler);
 	fdr = (ret >= 0) ? ret : 0x3f; /* backward compatibility */
 
@@ -230,13 +235,50 @@ static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
 	if (ret >= 0)
 		dev_info(i2c->dev, "clock %d Hz (fdr=%d)\n", clock, fdr);
 }
-#else /* !CONFIG_PPC_MPC52xx */
-static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
-					    struct mpc_i2c *i2c,
-					    u32 clock, u32 prescaler)
+#else /* !(CONFIG_PPC_MPC52xx || CONFIG_PPC_MPC512x) */
+static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
+					 struct mpc_i2c *i2c,
+					 u32 clock, u32 prescaler)
+{
+}
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
+
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
 {
 }
-#endif /* CONFIG_PPC_MPC52xx*/
+#endif /* CONFIG_PPC_MPC512x */
 
 #ifdef CONFIG_FSL_SOC
 static const struct __devinitdata mpc_i2c_divider mpc_i2c_dividers_8xxx[] = {
@@ -322,12 +364,19 @@ static int __devinit mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 	return div ? (int)div->fdr : -EINVAL;
 }
 
-static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
-					    struct mpc_i2c *i2c,
-					    u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
+					 struct mpc_i2c *i2c,
+					 u32 clock, u32 prescaler)
 {
 	int ret, fdr;
 
+	if (clock == -1) {
+		dev_dbg(i2c->dev, "using dfsrr %d, fdr %d\n",
+			readb(i2c->base + MPC_I2C_DFSRR),
+			readb(i2c->base + MPC_I2C_FDR));
+		return;	/* preserve clocking */
+	}
+
 	ret = mpc_i2c_get_fdr_8xxx(node, clock, prescaler);
 	fdr = (ret >= 0) ? ret : 0x1031; /* backward compatibility */
 
@@ -340,9 +389,9 @@ static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
 }
 
 #else /* !CONFIG_FSL_SOC */
-static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
-					    struct mpc_i2c *i2c,
-					    u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setup_8xxx(struct device_node *node,
+					 struct mpc_i2c *i2c,
+					 u32 clock, u32 prescaler)
 {
 }
 #endif /* CONFIG_FSL_SOC */
@@ -525,21 +574,21 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
 		}
 	}
 
-	if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
+	if (of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
+		clock = -1;
+	} else {
 		prop = of_get_property(op->node, "clock-frequency", &plen);
 		if (prop && plen == sizeof(u32))
 			clock = *prop;
+	}
 
-		if (match->data) {
-			struct mpc_i2c_data *data =
-				(struct mpc_i2c_data *)match->data;
-			data->setclock(op->node, i2c, clock, data->prescaler);
-		} else {
-			/* Backwards compatibility */
-			if (of_get_property(op->node, "dfsrr", NULL))
-				mpc_i2c_setclock_8xxx(op->node, i2c,
-						      clock, 0);
-		}
+	if (match->data) {
+		struct mpc_i2c_data *data = (struct mpc_i2c_data *)match->data;
+		data->setup(op->node, i2c, clock, data->prescaler);
+	} else {
+		/* Backwards compatibility */
+		if (of_get_property(op->node, "dfsrr", NULL))
+			mpc_i2c_setup_8xxx(op->node, i2c, clock, 0);
 	}
 
 	dev_set_drvdata(&op->dev, i2c);
@@ -585,20 +634,24 @@ static int __devexit fsl_i2c_remove(struct of_device *op)
 };
 
 static struct mpc_i2c_data __devinitdata mpc_i2c_data_52xx = {
-	.setclock = mpc_i2c_setclock_52xx,
+	.setup = mpc_i2c_setup_52xx,
+};
+
+static struct mpc_i2c_data __devinitdata mpc_i2c_data_512x = {
+	.setup = mpc_i2c_setup_512x,
 };
 
 static struct mpc_i2c_data __devinitdata mpc_i2c_data_8313 = {
-	.setclock = mpc_i2c_setclock_8xxx,
+	.setup = mpc_i2c_setup_8xxx,
 };
 
 static struct mpc_i2c_data __devinitdata mpc_i2c_data_8543 = {
-	.setclock = mpc_i2c_setclock_8xxx,
+	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 2,
 };
 
 static struct mpc_i2c_data __devinitdata mpc_i2c_data_8544 = {
-	.setclock = mpc_i2c_setclock_8xxx,
+	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 3,
 };
 
@@ -606,6 +659,7 @@ static const struct of_device_id mpc_i2c_of_match[] = {
 	{.compatible = "mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
 	{.compatible = "fsl,mpc5200b-i2c", .data = &mpc_i2c_data_52xx, },
 	{.compatible = "fsl,mpc5200-i2c", .data = &mpc_i2c_data_52xx, },
+	{.compatible = "fsl,mpc5121-i2c", .data = &mpc_i2c_data_512x, },
 	{.compatible = "fsl,mpc8313-i2c", .data = &mpc_i2c_data_8313, },
 	{.compatible = "fsl,mpc8543-i2c", .data = &mpc_i2c_data_8543, },
 	{.compatible = "fsl,mpc8544-i2c", .data = &mpc_i2c_data_8544, },
@@ -648,5 +702,5 @@ module_exit(fsl_i2c_exit);
 
 MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
 MODULE_DESCRIPTION("I2C-Bus adapter for MPC107 bridge and "
-		   "MPC824x/85xx/52xx processors");
+		   "MPC824x/85xx/512x/52xx processors");
 MODULE_LICENSE("GPL");
-- 
1.6.2.5
