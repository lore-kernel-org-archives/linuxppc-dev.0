Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v2 18/24] i2c: mpc: OF clock lookup for MPC512x
Date: Thu, 18 Jul 2013 22:20:52 +0200
Message-Id: <1374178858-8683-4-git-send-email-gsi@denx.de>
In-Reply-To: <1374166855-7280-1-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

make the MPC I2C driver prepare and enable the peripheral clock
('per' for register access) in the MPC512x setup routine,
make this clock setup non-fatal to allow for a migration period,
remove the pre-enabling hack in the platform's clock driver

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |    1 -
 drivers/i2c/busses/i2c-mpc.c                  |    9 +++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index b8963b7..49c52bc 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -692,7 +692,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	/* some are not yet acquired by their respective drivers */
 	clk_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console */
 	clk_prepare_enable(clks[MPC512x_CLK_FEC]);	/* network, NFS */
-	clk_prepare_enable(clks[MPC512x_CLK_I2C]);
 	/*
 	 * some have their individual clock subtree with separate clock
 	 * items and their individual enable counters, yet share a
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 7607dc0..13d6822 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -21,6 +21,7 @@
 #include <linux/of_i2c.h>
 #include <linux/slab.h>
 
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/fsl_devices.h>
 #include <linux/i2c.h>
@@ -264,11 +265,19 @@ static void mpc_i2c_setup_512x(struct device_node *node,
 					 struct mpc_i2c *i2c,
 					 u32 clock, u32 prescaler)
 {
+	struct clk *clk;
 	struct device_node *node_ctrl;
 	void __iomem *ctrl;
 	const u32 *pval;
 	u32 idx;
 
+	/* enable clock for the I2C peripheral (non fatal) */
+	clk = of_clk_get_by_name(node, "per");
+	if (!IS_ERR(clk)) {
+		clk_prepare_enable(clk);
+		clk_put(clk);
+	}
+
 	/* Enable I2C interrupts for mpc5121 */
 	node_ctrl = of_find_compatible_node(NULL, NULL,
 					    "fsl,mpc5121-i2c-ctrl");
-- 
1.7.10.4
