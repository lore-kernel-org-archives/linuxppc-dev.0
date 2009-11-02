Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id EB6A2B7C04
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 02:17:52 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc512x/clocks: initialize CAN clocks
Date: Mon,  2 Nov 2009 16:17:36 +0100
Message-Id: <1257175056-26093-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1256925231-21917-1-git-send-email-w.sang@pengutronix.de>
References: <1256925231-21917-1-git-send-email-w.sang@pengutronix.de>
Cc: Chen Hongjun <hong-jun.chen@freescale.com>,
	John Rigby <jrigby@freescale.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: John Rigby <jrigby@freescale.com>
Signed-off-by: Chen Hongjun <hong-jun.chen@freescale.com>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---

Should come after the fix for clk_get to be usable for the upcoming CAN driver:
http://patchwork.ozlabs.org/patch/37342/

 arch/powerpc/platforms/512x/clock.c |   74 +++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index 4168457..2d3a5ef 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -50,6 +50,8 @@ struct clk {
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 
+struct clk mscan_clks[4];
+
 static struct clk *mpc5121_clk_get(struct device *dev, const char *id)
 {
 	struct clk *p, *clk = ERR_PTR(-ENOENT);
@@ -119,6 +121,8 @@ struct mpc512x_clockctl {
 	u32 spccr;		/* SPDIF Clk Ctrl Reg */
 	u32 cccr;		/* CFM Clk Ctrl Reg */
 	u32 dccr;		/* DIU Clk Cnfg Reg */
+	/* rev2+ only regs */
+	u32 mccr[4];		/* MSCAN Clk Ctrl Reg 1-4 */
 };
 
 struct mpc512x_clockctl __iomem *clockctl;
@@ -688,6 +692,72 @@ static void psc_clks_init(void)
 	}
 }
 
+
+/*
+ * mscan clock rate calculation
+ */
+static unsigned long mscan_calc_rate(struct device_node *np, int mscannum)
+{
+	unsigned long mscanclk_src, mscanclk_div;
+	u32 *mccr = &clockctl->mccr[mscannum];
+
+	/*
+	 * If the divider is the reset default of all 1's then
+	 * we know u-boot and/or board setup has not
+	 * done anything so set up a sane default
+	 */
+	if (((in_be32(mccr) >> 17) & 0x7fff) == 0x7fff) {
+		/* disable */
+		out_be32(mccr, 0);
+		/* src is sysclk, divider is 4 */
+		out_be32(mccr, (0x3 << 17) | 0x10000);
+	}
+
+	switch ((in_be32(mccr) >> 14) & 0x3) {
+	case 0:
+		mscanclk_src = sys_clk.rate;
+		break;
+	case 1:
+		mscanclk_src = ref_clk.rate;
+		break;
+	case 2:
+		mscanclk_src = psc_mclk_in.rate;
+		break;
+	case 3:
+		mscanclk_src = spdif_txclk.rate;
+		break;
+	}
+
+	mscanclk_src = roundup(mscanclk_src, 1000000);
+	mscanclk_div = ((in_be32(mccr) >> 17) & 0x7fff) + 1;
+	return mscanclk_src / mscanclk_div;
+}
+
+/*
+ * Find all silicon rev2 mscan nodes in device tree and assign a clock
+ * with name "mscan%d_clk" and dev pointing at the device
+ * returned from of_find_device_by_node
+ */
+static void mscan_clks_init(void)
+{
+	struct device_node *np;
+	struct of_device *ofdev;
+	const u32 *cell_index;
+
+	for_each_compatible_node(np, NULL, "fsl,mpc5121-mscan") {
+		cell_index = of_get_property(np, "cell-index", NULL);
+		if (cell_index) {
+			struct clk *clk = &mscan_clks[*cell_index];
+			clk->flags = CLK_HAS_RATE;
+			ofdev = of_find_device_by_node(np);
+			clk->dev = &ofdev->dev;
+			clk->rate = mscan_calc_rate(np, *cell_index);
+			sprintf(clk->name, "mscan%d_clk", *cell_index);
+			clk_register(clk);
+		}
+	}
+}
+
 static struct clk_interface mpc5121_clk_functions = {
 	.clk_get		= mpc5121_clk_get,
 	.clk_enable		= mpc5121_clk_enable,
@@ -719,6 +789,10 @@ mpc5121_clk_init(void)
 	rate_clks_init();
 	psc_clks_init();
 
+	/* Setup per-controller CAN clocks for Rev2 and later */
+	if (((mfspr(SPRN_SVR) >> 4) & 0xF) > 1)
+		mscan_clks_init();
+
 	/* leave clockctl mapped forever */
 	/*iounmap(clockctl); */
 	DEBUG_CLK_DUMP();
-- 
1.6.3.3
