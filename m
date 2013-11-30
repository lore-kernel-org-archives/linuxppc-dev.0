Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 604022C038F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 09:52:23 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v6 15/17] net: can: mscan: remove non-CCF code for MPC512x
Date: Sat, 30 Nov 2013 23:51:35 +0100
Message-Id: <1385851897-23475-16-git-send-email-gsi@denx.de>
In-Reply-To: <1385851897-23475-1-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>,
 linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Scott Wood <scottwood@freescale.com>, Wolfgang Grandegger <wg@grandegger.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

transition to the common clock framework has completed and the PPC_CLOCK
is no longer available for the MPC512x platform, remove the now obsolete
code path of the mpc5xxx mscan driver which accessed clock control module
registers directly

Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c |  141 -----------------------------------
 1 file changed, 141 deletions(-)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index f48f1297ff30..6b0c9958d824 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -109,9 +109,6 @@ static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
 #endif /* CONFIG_PPC_MPC52xx */
 
 #ifdef CONFIG_PPC_MPC512x
-
-#if IS_ENABLED(CONFIG_COMMON_CLK)
-
 static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
 				 const char *clock_source, int *mscan_clksrc)
 {
@@ -277,144 +274,6 @@ static void mpc512x_can_put_clock(struct platform_device *ofdev)
 	if (priv->clk_ipg)
 		clk_disable_unprepare(priv->clk_ipg);
 }
-
-#else	/* COMMON_CLK */
-
-struct mpc512x_clockctl {
-	u32 spmr;		/* System PLL Mode Reg */
-	u32 sccr[2];		/* System Clk Ctrl Reg 1 & 2 */
-	u32 scfr1;		/* System Clk Freq Reg 1 */
-	u32 scfr2;		/* System Clk Freq Reg 2 */
-	u32 reserved;
-	u32 bcr;		/* Bread Crumb Reg */
-	u32 pccr[12];		/* PSC Clk Ctrl Reg 0-11 */
-	u32 spccr;		/* SPDIF Clk Ctrl Reg */
-	u32 cccr;		/* CFM Clk Ctrl Reg */
-	u32 dccr;		/* DIU Clk Cnfg Reg */
-	u32 mccr[4];		/* MSCAN Clk Ctrl Reg 1-3 */
-};
-
-static struct of_device_id mpc512x_clock_ids[] = {
-	{ .compatible = "fsl,mpc5121-clock", },
-	{}
-};
-
-static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
-				 const char *clock_name, int *mscan_clksrc)
-{
-	struct mpc512x_clockctl __iomem *clockctl;
-	struct device_node *np_clock;
-	struct clk *sys_clk, *ref_clk;
-	int plen, clockidx, clocksrc = -1;
-	u32 sys_freq, val, clockdiv = 1, freq = 0;
-	const u32 *pval;
-
-	np_clock = of_find_matching_node(NULL, mpc512x_clock_ids);
-	if (!np_clock) {
-		dev_err(&ofdev->dev, "couldn't find clock node\n");
-		return 0;
-	}
-	clockctl = of_iomap(np_clock, 0);
-	if (!clockctl) {
-		dev_err(&ofdev->dev, "couldn't map clock registers\n");
-		goto exit_put;
-	}
-
-	/* Determine the MSCAN device index from the peripheral's
-	 * physical address. Register address offsets against the
-	 * IMMR base are:  0x1300, 0x1380, 0x2300, 0x2380
-	 */
-	pval = of_get_property(ofdev->dev.of_node, "reg", &plen);
-	BUG_ON(!pval || plen < sizeof(*pval));
-	clockidx = (*pval & 0x80) ? 1 : 0;
-	if (*pval & 0x2000)
-		clockidx += 2;
-
-	/*
-	 * Clock source and divider selection: 3 different clock sources
-	 * can be selected: "ip", "ref" or "sys". For the latter two, a
-	 * clock divider can be defined as well. If the clock source is
-	 * not specified by the device tree, we first try to find an
-	 * optimal CAN source clock based on the system clock. If that
-	 * is not posslible, the reference clock will be used.
-	 */
-	if (clock_name && !strcmp(clock_name, "ip")) {
-		*mscan_clksrc = MSCAN_CLKSRC_IPS;
-		freq = mpc5xxx_get_bus_frequency(ofdev->dev.of_node);
-	} else {
-		*mscan_clksrc = MSCAN_CLKSRC_BUS;
-
-		pval = of_get_property(ofdev->dev.of_node,
-				       "fsl,mscan-clock-divider", &plen);
-		if (pval && plen == sizeof(*pval))
-			clockdiv = *pval;
-		if (!clockdiv)
-			clockdiv = 1;
-
-		if (!clock_name || !strcmp(clock_name, "sys")) {
-			sys_clk = devm_clk_get(&ofdev->dev, "sys_clk");
-			if (IS_ERR(sys_clk)) {
-				dev_err(&ofdev->dev, "couldn't get sys_clk\n");
-				goto exit_unmap;
-			}
-			/* Get and round up/down sys clock rate */
-			sys_freq = 1000000 *
-				((clk_get_rate(sys_clk) + 499999) / 1000000);
-
-			if (!clock_name) {
-				/* A multiple of 16 MHz would be optimal */
-				if ((sys_freq % 16000000) == 0) {
-					clocksrc = 0;
-					clockdiv = sys_freq / 16000000;
-					freq = sys_freq / clockdiv;
-				}
-			} else {
-				clocksrc = 0;
-				freq = sys_freq / clockdiv;
-			}
-		}
-
-		if (clocksrc < 0) {
-			ref_clk = devm_clk_get(&ofdev->dev, "ref_clk");
-			if (IS_ERR(ref_clk)) {
-				dev_err(&ofdev->dev, "couldn't get ref_clk\n");
-				goto exit_unmap;
-			}
-			clocksrc = 1;
-			freq = clk_get_rate(ref_clk) / clockdiv;
-		}
-	}
-
-	/* Disable clock */
-	out_be32(&clockctl->mccr[clockidx], 0x0);
-	if (clocksrc >= 0) {
-		/* Set source and divider */
-		val = (clocksrc << 14) | ((clockdiv - 1) << 17);
-		out_be32(&clockctl->mccr[clockidx], val);
-		/* Enable clock */
-		out_be32(&clockctl->mccr[clockidx], val | 0x10000);
-	}
-
-	/* Enable MSCAN clock domain */
-	val = in_be32(&clockctl->sccr[1]);
-	if (!(val & (1 << 25)))
-		out_be32(&clockctl->sccr[1], val | (1 << 25));
-
-	dev_dbg(&ofdev->dev, "using '%s' with frequency divider %d\n",
-		*mscan_clksrc == MSCAN_CLKSRC_IPS ? "ips_clk" :
-		clocksrc == 1 ? "ref_clk" : "sys_clk", clockdiv);
-
-exit_unmap:
-	iounmap(clockctl);
-exit_put:
-	of_node_put(np_clock);
-	return freq;
-}
-
-#define mpc512x_can_put_clock NULL
-
-#endif	/* COMMON_CLK */
-
 #else /* !CONFIG_PPC_MPC512x */
 static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
 				 const char *clock_name, int *mscan_clksrc)
-- 
1.7.10.4
