Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B9B0B2C02C4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 22:16:28 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v3 27/31] net: can: mscan: add common clock support for mpc512x
Date: Mon, 22 Jul 2013 14:14:54 +0200
Message-Id: <1374495298-22019-28-git-send-email-gsi@denx.de>
In-Reply-To: <1374495298-22019-1-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
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

implement a .get_clock() callback for the MPC512x platform which uses
the common clock infrastructure (eliminating direct access to the clock
control registers from within the CAN network driver), and provide the
corresponding .put_clock() callback to release resources after use

keep the previous implementation of MPC512x support in place during
migration, since common clock support is optional

this change is neutral to the MPC5200 platform

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c |  169 +++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index e59b3a3..4897929 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -109,6 +109,167 @@ static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
 #endif /* CONFIG_PPC_MPC52xx */
 
 #ifdef CONFIG_PPC_MPC512x
+
+#if IS_ENABLED(CONFIG_COMMON_CLK)
+
+static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
+				 const char *clock_source, int *mscan_clksrc)
+{
+	struct device_node *np;
+	u32 clockdiv;
+	enum {
+		CLK_FROM_AUTO,
+		CLK_FROM_IPS,
+		CLK_FROM_SYS,
+		CLK_FROM_REF,
+	} clk_from;
+	struct clk *clk_in, *clk_can;
+	unsigned long freq_calc;
+	struct mscan_priv *priv;
+
+	/* the caller passed in the clock source spec that was read from
+	 * the device tree, get the optional clock divider as well
+	 */
+	np = ofdev->dev.of_node;
+	clockdiv = 1;
+	of_property_read_u32(np, "fsl,mscan-clock-divider", &clockdiv);
+	dev_dbg(&ofdev->dev, "device tree specs: clk src[%s] div[%d]\n",
+		clock_source ? clock_source : "<NULL>", clockdiv);
+
+	/* when clock-source is 'ip', the CANCTL1[CLKSRC] bit needs to
+	 * get set, and the 'ips' clock is the input to the MSCAN
+	 * component
+	 *
+	 * for clock-source values of 'ref' or 'sys' the CANCTL1[CLKSRC]
+	 * bit needs to get cleared, an optional clock-divider may have
+	 * been specified (the default value is 1), the appropriate
+	 * MSCAN related MCLK is the input to the MSCAN component
+	 *
+	 * in the absence of a clock-source spec, first an optimal clock
+	 * gets determined based on the 'sys' clock, if that fails the
+	 * 'ref' clock is used
+	 */
+	clk_from = CLK_FROM_AUTO;
+	if (clock_source) {
+		/* interpret the device tree's spec for the clock source */
+		if (!strcmp(clock_source, "ip"))
+			clk_from = CLK_FROM_IPS;
+		else if (!strcmp(clock_source, "sys"))
+			clk_from = CLK_FROM_SYS;
+		else if (!strcmp(clock_source, "ref"))
+			clk_from = CLK_FROM_REF;
+		else
+			goto err_invalid;
+		dev_dbg(&ofdev->dev, "got a clk source spec[%d]\n", clk_from);
+	}
+	if (clk_from == CLK_FROM_AUTO) {
+		/* no spec so far, try the 'sys' clock; round to the
+		 * next MHz and see if we can get a multiple of 16MHz
+		 */
+		dev_dbg(&ofdev->dev, "no clk source spec, trying SYS\n");
+		clk_in = devm_clk_get(&ofdev->dev, "sys");
+		if (IS_ERR(clk_in))
+			goto err_notavail;
+		freq_calc = clk_get_rate(clk_in);
+		freq_calc +=  499999;
+		freq_calc /= 1000000;
+		freq_calc *= 1000000;
+		if ((freq_calc % 16000000) == 0) {
+			clk_from = CLK_FROM_SYS;
+			clockdiv = freq_calc / 16000000;
+			dev_dbg(&ofdev->dev,
+				"clk fit, sys[%lu] div[%d] freq[%lu]\n",
+				freq_calc, clockdiv, freq_calc / clockdiv);
+		}
+	}
+	if (clk_from == CLK_FROM_AUTO) {
+		/* no spec so far, use the 'ref' clock */
+		dev_dbg(&ofdev->dev, "no clk source spec, trying REF\n");
+		clk_in = devm_clk_get(&ofdev->dev, "ref");
+		if (IS_ERR(clk_in))
+			goto err_notavail;
+		clk_from = CLK_FROM_REF;
+		freq_calc = clk_get_rate(clk_in);
+		dev_dbg(&ofdev->dev,
+			"clk fit, ref[%lu] (no div) freq[%lu]\n",
+			freq_calc, freq_calc);
+	}
+
+	/* select IPS or MCLK as the MSCAN input (returned to the caller),
+	 * setup the MCLK mux source and rate if applicable, apply the
+	 * optionally specified or derived above divider, and determine
+	 * the actual resulting clock rate to return to the caller
+	 */
+	switch (clk_from) {
+	case CLK_FROM_IPS:
+		clk_can = devm_clk_get(&ofdev->dev, "ips");
+		if (IS_ERR(clk_can))
+			goto err_notavail;
+		if (clk_prepare(clk_can)) {
+			devm_clk_put(&ofdev->dev, clk_can);
+			goto err_notavail;
+		}
+		priv = netdev_priv(dev_get_drvdata(&ofdev->dev));
+		priv->clk_can = clk_can;
+		freq_calc = clk_get_rate(clk_can);
+		*mscan_clksrc = MSCAN_CLKSRC_IPS;
+		dev_dbg(&ofdev->dev, "clk from IPS, clksrc[%d] freq[%lu]\n",
+			*mscan_clksrc, freq_calc);
+		break;
+	case CLK_FROM_SYS:
+	case CLK_FROM_REF:
+		clk_can = devm_clk_get(&ofdev->dev, "mclk");
+		if (IS_ERR(clk_can))
+			goto err_notavail;
+		if (clk_prepare(clk_can)) {
+			devm_clk_put(&ofdev->dev, clk_can);
+			goto err_notavail;
+		}
+		priv = netdev_priv(dev_get_drvdata(&ofdev->dev));
+		priv->clk_can = clk_can;
+		if (clk_from == CLK_FROM_SYS)
+			clk_in = devm_clk_get(&ofdev->dev, "sys");
+		if (clk_from == CLK_FROM_REF)
+			clk_in = devm_clk_get(&ofdev->dev, "ref");
+		if (IS_ERR(clk_in))
+			goto err_notavail;
+		clk_set_parent(clk_can, clk_in);
+		freq_calc = clk_get_rate(clk_in);
+		freq_calc /= clockdiv;
+		clk_set_rate(clk_can, freq_calc);
+		freq_calc = clk_get_rate(clk_can);
+		*mscan_clksrc = MSCAN_CLKSRC_BUS;
+		dev_dbg(&ofdev->dev, "clk from MCLK, clksrc[%d] freq[%lu]\n",
+			*mscan_clksrc, freq_calc);
+		break;
+	default:
+		goto err_invalid;
+	}
+
+	return freq_calc;
+
+err_invalid:
+	dev_err(&ofdev->dev, "invalid clock source specification\n");
+	return 0;
+
+err_notavail:
+	dev_err(&ofdev->dev, "cannot acquire or setup clock source\n");
+	return 0;
+}
+
+static void mpc512x_can_put_clock(struct platform_device *ofdev)
+{
+	struct mscan_priv *priv;
+
+	priv = netdev_priv(dev_get_drvdata(&ofdev->dev));
+	if (priv->clk_can) {
+		clk_unprepare(priv->clk_can);
+		devm_clk_put(&ofdev->dev, priv->clk_can);
+	}
+}
+
+#else	/* COMMON_CLK */
+
 struct mpc512x_clockctl {
 	u32 spmr;		/* System PLL Mode Reg */
 	u32 sccr[2];		/* System Clk Ctrl Reg 1 & 2 */
@@ -239,12 +400,18 @@ exit_put:
 	of_node_put(np_clock);
 	return freq;
 }
+
+#define mpc512x_can_put_clock NULL
+
+#endif	/* COMMON_CLK */
+
 #else /* !CONFIG_PPC_MPC512x */
 static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
 				 const char *clock_name, int *mscan_clksrc)
 {
 	return 0;
 }
+#define mpc512x_can_put_clock NULL
 #endif /* CONFIG_PPC_MPC512x */
 
 static const struct of_device_id mpc5xxx_can_table[];
@@ -386,11 +553,13 @@ static int mpc5xxx_can_resume(struct platform_device *ofdev)
 static const struct mpc5xxx_can_data mpc5200_can_data = {
 	.type = MSCAN_TYPE_MPC5200,
 	.get_clock = mpc52xx_can_get_clock,
+	/* .put_clock not applicable */
 };
 
 static const struct mpc5xxx_can_data mpc5121_can_data = {
 	.type = MSCAN_TYPE_MPC5121,
 	.get_clock = mpc512x_can_get_clock,
+	.put_clock = mpc512x_can_put_clock,
 };
 
 static const struct of_device_id mpc5xxx_can_table[] = {
-- 
1.7.10.4
