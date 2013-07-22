Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3AC362C02EF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 22:16:25 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v3 25/31] mtd: mpc5121_nfc: remove now obsolete clock lookup
 name
Date: Mon, 22 Jul 2013 14:14:52 +0200
Message-Id: <1374495298-22019-26-git-send-email-gsi@denx.de>
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

after device tree based clock lookup became available, the NAND flash
driver need no longer use the previous "nfc_clk" name but can switch to
the fixed "per" clock name -- adjust the peripheral driver and remove
the clock driver's clkdev registration

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |    1 -
 drivers/mtd/nand/mpc5121_nfc.c                |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index d0286a5..24e1706 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -677,7 +677,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	clk_register_clkdev(clks[MPC512x_CLK_REF], "ref_clk", NULL);
 	clk_register_clkdev(clks[MPC512x_CLK_SYS], "sys_clk", NULL);
 	clk_register_clkdev(clks[MPC512x_CLK_VIU], "viu_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_NFC], "nfc_clk", NULL);
 
 	pr_debug("clock tree setup complete\n");
 	freq = clk_get_rate(clks[MPC512x_CLK_E300]);
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 9c0b8fe..6a5f851 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -731,7 +731,7 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	of_node_put(rootnode);
 
 	/* Enable NFC clock */
-	clk = devm_clk_get(dev, "nfc_clk");
+	clk = devm_clk_get(dev, "per");
 	if (IS_ERR(clk)) {
 		dev_err(dev, "Unable to acquire NFC clock!\n");
 		retval = PTR_ERR(clk);
-- 
1.7.10.4
