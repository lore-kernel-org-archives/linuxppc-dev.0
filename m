Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ABE1C2C0322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 09:52:22 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>,
 Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: [PATCH v1 2/4] powerpc/512x: clk: enforce even SDHC divider values
Date: Tue, 10 Dec 2013 14:11:35 +0100
Message-Id: <1386681097-14126-3-git-send-email-gsi@denx.de>
In-Reply-To: <1386681097-14126-1-git-send-email-gsi@denx.de>
References: <1386681097-14126-1-git-send-email-gsi@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, Gerhard Sittig <gsi@denx.de>,
 Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

the SDHC clock is derived from CSB with a fractional divider which can
address "quarters"; the implementation multiplies CSB by 4 and divides
it by the (integer) divider value

a bug in the clock domain synchronisation requires that only even
divider values get setup; we achieve this by
- multiplying CSB by 2 only instead of 4
- registering with CCF the divider's bit field without bit0
- the divider's lowest bit remains clear as this is the reset value
  and later operations won't touch it

this change keeps fully utilizing common clock primitives (needs no
additional support logic, and avoids an excessive divider table) and
satisfies the hardware's constraint of only supporting even divider
values

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 079eb1137260..b5190fcb81bb 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -560,9 +560,21 @@ static void mpc512x_clk_setup_clock_tree(struct device_node *np, int busfreq)
 	/* now setup anything below SYS and CSB and IPS */
 
 	clks[MPC512x_CLK_DDR_UG] = mpc512x_clk_factor("ddr-ug", "sys", 1, 2);
-	clks[MPC512x_CLK_SDHC_x4] = mpc512x_clk_factor("sdhc-x4", "csb", 4, 1);
+
+	/*
+	 * the Reference Manual discusses that for SDHC only even divide
+	 * ratios are supported because clock domain synchronization
+	 * between 'per' and 'ipg' is broken;
+	 * keep the divider's bit 0 cleared (per reset value), and only
+	 * allow to setup the divider's bits 7:1, which results in that
+	 * only even divide ratios can get configured upon rate changes;
+	 * keep the "x4" name because this bit shift hack is an internal
+	 * implementation detail, the "fractional divider with quarters"
+	 * semantics remains
+	 */
+	clks[MPC512x_CLK_SDHC_x4] = mpc512x_clk_factor("sdhc-x4", "csb", 2, 1);
 	clks[MPC512x_CLK_SDHC_UG] = mpc512x_clk_divider("sdhc-ug", "sdhc-x4", 0,
-							&clkregs->scfr2, 0, 8,
+							&clkregs->scfr2, 1, 7,
 							CLK_DIVIDER_ONE_BASED);
 	clks[MPC512x_CLK_DIU_x4] = mpc512x_clk_factor("diu-x4", "csb", 4, 1);
 	clks[MPC512x_CLK_DIU_UG] = mpc512x_clk_divider("diu-ug", "diu-x4", 0,
-- 
1.7.10.4
