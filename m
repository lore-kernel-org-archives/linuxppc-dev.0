Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E90742C0225
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 22:16:40 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v3 31/31] clk: mpc512x: remove clkdev registration (sys/ref,
 header)
Date: Mon, 22 Jul 2013 14:14:58 +0200
Message-Id: <1374495298-22019-32-git-send-email-gsi@denx.de>
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

remove the last clkdev registration call ("sys_clk" and "ref_clk"
for mscan), as well as the clkdev header inclusion and the "compat
registration" comment

all client lookups for clock items are device tree based now, no
compatibility alias names need to get provided any longer

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 893fbe5..e9451a7 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -673,10 +672,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	/* fixed frequency for AC97, always 24.567MHz */
 	clks[MPC512x_CLK_AC97] = mpc512x_clk_fixed("ac97", 24567000);
 
-	/* clkdev registration for compatibility reasons */
-	clk_register_clkdev(clks[MPC512x_CLK_REF], "ref_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_SYS], "sys_clk", NULL);
-
 	pr_debug("clock tree setup complete\n");
 	freq = clk_get_rate(clks[MPC512x_CLK_E300]);
 	pr_debug("derived PPC freq [%d]\n", freq);
-- 
1.7.10.4
