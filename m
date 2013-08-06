Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BCDAB2C076B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:47:45 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 26/31] [media] fsl-viu: remove now obsolete clock lookup
 name
Date: Tue,  6 Aug 2013 22:44:06 +0200
Message-Id: <1375821851-31609-27-git-send-email-gsi@denx.de>
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
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

after device tree based clock lookup became available, the VIU driver
need no longer use the previous "viu_clk" name but can switch to the
fixed "per" clock name -- adjust the peripheral driver and remove the
clock driver's clkdev registration

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |    1 -
 drivers/media/platform/fsl-viu.c              |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 0e23b45..e5e9cbe 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -656,7 +656,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	/* clkdev registration for compatibility reasons */
 	clk_register_clkdev(clks[MPC512x_CLK_REF], "ref_clk", NULL);
 	clk_register_clkdev(clks[MPC512x_CLK_SYS], "sys_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_VIU], "viu_clk", NULL);
 
 	/* enable some of the clocks here unconditionally because ... */
 	pr_debug("automatically enabling some clocks\n");
diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
index fe9898c..1b1a070 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -1578,7 +1578,7 @@ static int viu_of_probe(struct platform_device *op)
 	}
 
 	/* enable VIU clock */
-	clk = devm_clk_get(&op->dev, "viu_clk");
+	clk = devm_clk_get(&op->dev, "per");
 	if (IS_ERR(clk)) {
 		dev_err(&op->dev, "failed to lookup the clock!\n");
 		ret = PTR_ERR(clk);
-- 
1.7.10.4
