Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v1 16/24] clk: mpc512x: remove now obsolete clkdev registration
Date: Tue, 16 Jul 2013 08:05:04 +0200
Message-Id: <1373954707-23909-1-git-send-email-gsi@denx.de>
In-Reply-To: <1373914074-20889-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
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

after the PSC drivers for UART and SPI mode got converted to device tree
based clock lookup, the former MCLK name which depends on the PSC index
isn't needed any longer -- remove the clk_register_clkdev() invocation

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index f31f895..31707b5 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -529,16 +529,6 @@ static void mpc512x_clk_setup_mclk(struct mclk_setup_data *entry)
 				entry->name_mclk,
 				entry->name_mux1, 1, 1);
 	}
-
-	/*
-	 * without this "clock device" registration, "simple" lookups in
-	 * the SPI master initialization and serial port setup will fail
-	 *
-	 * those drivers need to get adjusted to lookup their required
-	 * clocks from OF specs, before this clkdev registration becomes
-	 * obsolete
-	 */
-	clk_register_clkdev(clks[clks_idx_pub], entry->name_mclk, NULL);
 }
 
 static void mpc512x_clk_setup_mclks(struct mclk_setup_data *table, size_t count)
-- 
1.7.10.4
