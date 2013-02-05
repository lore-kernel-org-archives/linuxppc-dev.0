Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1B4C92C02EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 18:20:29 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/mpc512x: fix noderef sparse warnings
Date: Tue,  5 Feb 2013 08:20:16 +0100
Message-Id: <1360048818-3765-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix:
warning: dereference of noderef expression

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/512x/clock.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index 7937361..8a784d4 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -184,7 +184,7 @@ static unsigned long spmf_mult(void)
 		36, 40, 44, 48,
 		52, 56, 60, 64
 	};
-	int spmf = (clockctl->spmr >> 24) & 0xf;
+	int spmf = (in_be32(&clockctl->spmr) >> 24) & 0xf;
 	return spmf_to_mult[spmf];
 }
 
@@ -206,7 +206,7 @@ static unsigned long sysdiv_div_x_2(void)
 		52, 56, 58, 62,
 		60, 64, 66,
 	};
-	int sysdiv = (clockctl->scfr2 >> 26) & 0x3f;
+	int sysdiv = (in_be32(&clockctl->scfr2) >> 26) & 0x3f;
 	return sysdiv_to_div_x_2[sysdiv];
 }
 
@@ -230,7 +230,7 @@ static unsigned long sys_to_ref(unsigned long rate)
 
 static long ips_to_ref(unsigned long rate)
 {
-	int ips_div = (clockctl->scfr1 >> 23) & 0x7;
+	int ips_div = (in_be32(&clockctl->scfr1) >> 23) & 0x7;
 
 	rate *= ips_div;	/* csb_clk = ips_clk * ips_div */
 	rate *= 2;		/* sys_clk = csb_clk * 2 */
@@ -284,7 +284,7 @@ static struct clk sys_clk = {
 
 static void diu_clk_calc(struct clk *clk)
 {
-	int diudiv_x_2 = clockctl->scfr1 & 0xff;
+	int diudiv_x_2 = in_be32(&clockctl->scfr1) & 0xff;
 	unsigned long rate;
 
 	rate = sys_clk.rate;
@@ -311,7 +311,7 @@ static void half_clk_calc(struct clk *clk)
 
 static void generic_div_clk_calc(struct clk *clk)
 {
-	int div = (clockctl->scfr1 >> clk->div_shift) & 0x7;
+	int div = (in_be32(&clockctl->scfr1) >> clk->div_shift) & 0x7;
 
 	clk->rate = clk->parent->rate / div;
 }
@@ -329,7 +329,7 @@ static struct clk csb_clk = {
 
 static void e300_clk_calc(struct clk *clk)
 {
-	int spmf = (clockctl->spmr >> 16) & 0xf;
+	int spmf = (in_be32(&clockctl->spmr) >> 16) & 0xf;
 	int ratex2 = clk->parent->rate * spmf;
 
 	clk->rate = ratex2 / 2;
@@ -648,12 +648,12 @@ static void psc_calc_rate(struct clk *clk, int pscnum, struct device_node *np)
 	out_be32(&clockctl->pccr[pscnum], 0x00020000);
 	out_be32(&clockctl->pccr[pscnum], 0x00030000);
 
-	if (clockctl->pccr[pscnum] & 0x80) {
+	if (in_be32(&clockctl->pccr[pscnum]) & 0x80) {
 		clk->rate = spdif_rxclk.rate;
 		return;
 	}
 
-	switch ((clockctl->pccr[pscnum] >> 14) & 0x3) {
+	switch ((in_be32(&clockctl->pccr[pscnum]) >> 14) & 0x3) {
 	case 0:
 		mclk_src = sys_clk.rate;
 		break;
@@ -668,7 +668,7 @@ static void psc_calc_rate(struct clk *clk, int pscnum, struct device_node *np)
 		break;
 	}
 
-	mclk_div = ((clockctl->pccr[pscnum] >> 17) & 0x7fff) + 1;
+	mclk_div = ((in_be32(&clockctl->pccr[pscnum]) >> 17) & 0x7fff) + 1;
 	clk->rate = mclk_src / mclk_div;
 }
 
-- 
1.7.5.4
