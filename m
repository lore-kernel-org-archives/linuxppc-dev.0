Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BACA42C0471
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:47:13 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 22/31] clk: mpc512x: remove PSC (UART,
 SPI) compat workarounds
Date: Tue,  6 Aug 2013 22:44:02 +0200
Message-Id: <1375821851-31609-23-git-send-email-gsi@denx.de>
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

after the UART and SPI peripheral drivers have switched to device tree
based clock lookup and no longer construct clock names from their PSC
component index, the "psc%d_mclk" alias names have become obsolete --
remove the corresponding clk_register_clkdev() calls

after the UART and SPI peripheral drivers acquire the 'ipg' clock item,
the platform's clock driver need no longer pre-enable it

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 3f559fe..bd704b3 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -500,17 +500,6 @@ static void mpc512x_clk_setup_mclk(struct mclk_setup_data *entry, size_t idx)
 				entry->parent_names_mux1[0],
 				1, 1);
 	}
-
-	/*
-	 * without this "clock device" registration, "simple" lookups in
-	 * the SPI master initialization and serial port setup will fail
-	 *
-	 * those drivers need to get adjusted to lookup their required
-	 * clocks from device tree specs, and device tree nodes need to
-	 * provide the clock specs, before this clkdev registration
-	 * becomes obsolete
-	 */
-	clk_register_clkdev(clks[clks_idx_pub], entry->name_mclk, NULL);
 }
 
 static void mpc512x_clk_setup_clock_tree(int busfreq)
@@ -686,8 +675,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	/* some are not yet acquired by their respective drivers */
 	clk_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console */
 	clk_prepare_enable(clks[MPC512x_CLK_DIU]);	/* display */
-	for (mclk_idx = 0; mclk_idx < ARRAY_SIZE(mclk_psc_data); mclk_idx++)
-		clk_prepare_enable(clks[MPC512x_CLK_PSC0 + mclk_idx]);
 	clk_prepare_enable(clks[MPC512x_CLK_BDLC]);
 	for (mclk_idx = 0; mclk_idx < ARRAY_SIZE(mclk_mscan_data); mclk_idx++)
 		clk_prepare_enable(clks[MPC512x_CLK_MSCAN0_MCLK + mclk_idx]);
-- 
1.7.10.4
