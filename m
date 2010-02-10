Return-Path: <wg@denx.de>
From: Wolfgang Grandegger <wg@grandegger.com>
To: Linux-i2c@vger.kernel.org
Subject: [PATCH v7 2/4] i2c-mpc: rename "setclock" initialization functions to
	"setup"
Date: Wed, 10 Feb 2010 15:55:09 +0100
Message-Id: <1265813711-16794-3-git-send-email-wg@grandegger.com>
In-Reply-To: <1265813711-16794-2-git-send-email-wg@grandegger.com>
References: <1265813711-16794-1-git-send-email-wg@grandegger.com>
	<1265813711-16794-2-git-send-email-wg@grandegger.com>
Cc: Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wolfgang Grandegger <wg@denx.de>

To prepare  support for the MPC512x processors from Freescale the
"setclock" initialization functions have been renamed to "setup"
because I2C interrupts must be enabled for the MPC512x by this
function as well.

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
---
 drivers/i2c/busses/i2c-mpc.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 9f0e203..370c342 100644
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
 
@@ -216,9 +215,9 @@ static int __devinit mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock,
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
 
@@ -231,9 +230,9 @@ static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
 		dev_info(i2c->dev, "clock %d Hz (fdr=%d)\n", clock, fdr);
 }
 #else /* !CONFIG_PPC_MPC52xx */
-static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
-					    struct mpc_i2c *i2c,
-					    u32 clock, u32 prescaler)
+static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
+					 struct mpc_i2c *i2c,
+					 u32 clock, u32 prescaler)
 {
 }
 #endif /* CONFIG_PPC_MPC52xx*/
@@ -322,9 +321,9 @@ static int __devinit mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
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
 
@@ -340,9 +339,9 @@ static void __devinit mpc_i2c_setclock_8xxx(struct device_node *node,
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
@@ -533,12 +532,11 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
 		if (match->data) {
 			struct mpc_i2c_data *data =
 				(struct mpc_i2c_data *)match->data;
-			data->setclock(op->node, i2c, clock, data->prescaler);
+			data->setup(op->node, i2c, clock, data->prescaler);
 		} else {
 			/* Backwards compatibility */
 			if (of_get_property(op->node, "dfsrr", NULL))
-				mpc_i2c_setclock_8xxx(op->node, i2c,
-						      clock, 0);
+				mpc_i2c_setup_8xxx(op->node, i2c, clock, 0);
 		}
 	}
 
-- 
1.6.2.5
