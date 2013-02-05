Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E702B2C02FF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 18:20:30 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/mpc512x: fix sparce warnings for non static
 symbols
Date: Tue,  5 Feb 2013 08:20:17 +0100
Message-Id: <1360048818-3765-2-git-send-email-agust@denx.de>
In-Reply-To: <1360048818-3765-1-git-send-email-agust@denx.de>
References: <1360048818-3765-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix warnings:
symbol 'clockctl' was not declared. Should it be static?
symbol 'rate_clks' was not declared. Should it be static?
symbol 'dev_clks' was not declared. Should it be static?
symbol 'mpc5121_clk_init' was not declared. Should it be static?

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/include/asm/mpc5121.h  |    1 +
 arch/powerpc/platforms/512x/clock.c |    7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc5121.h b/arch/powerpc/include/asm/mpc5121.h
index e700c8b..1b0ce6d 100644
--- a/arch/powerpc/include/asm/mpc5121.h
+++ b/arch/powerpc/include/asm/mpc5121.h
@@ -147,5 +147,6 @@ struct mpc512x_axe_module {
 
 
 int mpc512x_cs_config(int cs, u32 val);
+int __init mpc5121_clk_init(void);
 
 #endif /* __ASM_POWERPC_MPC5121_H__ */
diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index 8a784d4..52d57d2 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -26,6 +26,7 @@
 
 #include <linux/of_platform.h>
 #include <asm/mpc5xxx.h>
+#include <asm/mpc5121.h>
 #include <asm/clk_interface.h>
 
 #undef CLK_DEBUG
@@ -122,7 +123,7 @@ struct mpc512x_clockctl {
 	u32 dccr;		/* DIU Clk Cnfg Reg */
 };
 
-struct mpc512x_clockctl __iomem *clockctl;
+static struct mpc512x_clockctl __iomem *clockctl;
 
 static int mpc5121_clk_enable(struct clk *clk)
 {
@@ -551,7 +552,7 @@ static struct clk ac97_clk = {
 	.calc = ac97_clk_calc,
 };
 
-struct clk *rate_clks[] = {
+static struct clk *rate_clks[] = {
 	&ref_clk,
 	&sys_clk,
 	&diu_clk,
@@ -607,7 +608,7 @@ static void rate_clks_init(void)
  * There are two clk enable registers with 32 enable bits each
  * psc clocks and device clocks are all stored in dev_clks
  */
-struct clk dev_clks[2][32];
+static struct clk dev_clks[2][32];
 
 /*
  * Given a psc number return the dev_clk
-- 
1.7.5.4
