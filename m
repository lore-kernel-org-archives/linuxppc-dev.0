Return-Path: <weo@goedel.recco.de>
Received: from bastet.recconet.de (bastet.reccoware.net [87.106.68.206])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 006AFB7CF8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Apr 2010 01:17:57 +1100 (EST)
From: Wolfgang Ocker <weo@reccoware.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] PowerPC/FSL/CPM: Configure clock correctly for SCC
Date: Sat,  3 Apr 2010 16:11:43 +0200
Message-Id: <1270303903-12961-1-git-send-email-weo@reccoware.de>
Cc: Wolfgang Ocker <weo@reccoware.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some board setup functions call cpm1_clk_setup() or cmp2_clk_setup()
to configure the clock source.

If CPM_CLK_RTX has been used for the parameter mode,
the clock has been configured only for TX but not for RX.

With this patch CPM_CLK_RTX configures the clock for both directions
correctly.

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---

v2: Scott Wood encouraged me to include a similar fix for CPM2.

 arch/powerpc/sysdev/cpm1.c |   14 +++++++++++---
 arch/powerpc/sysdev/cpm2.c |   11 ++++++++---
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index a4b41db..786e178 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -485,9 +485,6 @@ int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
 		return -EINVAL;
 	}
 
-	if (reg == &mpc8xx_immr->im_cpm.cp_sicr && mode == CPM_CLK_RX)
-		shift += 3;
-
 	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
 		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
 			bits = clk_map[i][2];
@@ -502,6 +499,17 @@ int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
 
 	bits <<= shift;
 	mask <<= shift;
+
+	if (reg == &mpc8xx_immr->im_cpm.cp_sicr) {
+		if (mode == CPM_CLK_RTX) {
+			bits |= bits << 3;
+			mask |= mask << 3;
+		} else if (mode == CPM_CLK_RX) {
+			bits <<= 3;
+			mask <<= 3;
+		}
+	}
+
 	out_be32(reg, (in_be32(reg) & ~mask) | bits);
 
 	return 0;
diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index eb59272..8dc1e24 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -244,9 +244,6 @@ int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 		return -EINVAL;
 	}
 
-	if (mode == CPM_CLK_RX)
-		shift += 3;
-
 	for (i = 0; i < ARRAY_SIZE(clk_map); i++) {
 		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
 			bits = clk_map[i][2];
@@ -259,6 +256,14 @@ int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
 	bits <<= shift;
 	mask <<= shift;
 
+	if (mode == CPM_CLK_RTX) {
+		bits |= bits << 3;
+		mask |= mask << 3;
+	} else if (mode == CPM_CLK_RX) {
+		bits <<= 3;
+		mask <<= 3;
+	}
+
 	out_be32(reg, (in_be32(reg) & ~mask) | bits);
 
 	cpm2_unmap(im_cpmux);
-- 
1.6.6.1
