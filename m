Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 53ED91007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 23:50:24 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mpc512x: add clock structure for Video-IN (VIU) unit
Date: Fri, 23 Jul 2010 15:50:18 +0200
Message-Id: <1279893018-24155-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>,
	Hongjun Chen <hong-jun.chen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allows using clk_get()/clk_enable()/clk_disable() for VIU
clock in the v4l2 video driver.

Signed-off-by: Hongjun Chen <hong-jun.chen@freescale.com>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/512x/clock.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index 4c42246..e1c5cd6 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -292,6 +292,15 @@ static void diu_clk_calc(struct clk *clk)
 	clk->rate = rate;
 }
 
+static void viu_clk_calc(struct clk *clk)
+{
+	unsigned long rate;
+
+	rate = sys_clk.rate;
+	rate /= 2;
+	clk->rate = rate;
+}
+
 static void half_clk_calc(struct clk *clk)
 {
 	clk->rate = clk->parent->rate / 2;
@@ -412,6 +421,14 @@ static struct clk diu_clk = {
 	.calc = diu_clk_calc,
 };
 
+static struct clk viu_clk = {
+	.name = "viu_clk",
+	.flags = CLK_HAS_CTRL,
+	.reg = 1,
+	.bit = 18,
+	.calc = viu_clk_calc,
+};
+
 static struct clk axe_clk = {
 	.name = "axe_clk",
 	.flags = CLK_HAS_CTRL,
@@ -535,6 +552,7 @@ struct clk *rate_clks[] = {
 	&ref_clk,
 	&sys_clk,
 	&diu_clk,
+	&viu_clk,
 	&csb_clk,
 	&e300_clk,
 	&ips_clk,
-- 
1.7.0.4
