Return-Path: <weo@goedel.recco.de>
Received: from bastet.recconet.de (bastet.reccoware.net [87.106.68.206])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A283B7C98
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 01:44:52 +1100 (EST)
Received: from trinity.recco.de (trinity.intern.recconet.de [192.168.11.241])
	by bastet.recconet.de (8.13.8/8.13.8/Recconet-2009080201) with ESMTP
	id o2TEaKvc010500
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 16:36:21 +0200
Received: from goedel.recco.de (goedel.recco.de [172.16.135.106])
	by trinity.recco.de (8.13.8/8.13.8/Reccoware-2009080201) with ESMTP id
	o2TEaKwo011346
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 16:36:20 +0200
Received: from goedel.recco.de (localhost [127.0.0.1])
	by goedel.recco.de (8.14.3/8.14.3/Reccoware-2010031901) with ESMTP id
	o2TEaKhk026113
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 16:36:20 +0200
Received: (from weo@localhost)
	by goedel.recco.de (8.14.3/8.14.3/Submit) id o2TEaJd2026111
	for linuxppc-dev@ozlabs.org; Mon, 29 Mar 2010 16:36:19 +0200
Message-Id: <201003291436.o2TEaJd2026111@goedel.recco.de>
From: Wolfgang Ocker <weo@reccoware.de>
Date: Mon, 29 Mar 2010 15:22:14 +0200
Subject: [PATCH] PowerPC/FSL/CPM1: Configure clock correctly for SCC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The board setup functions call cpm1_clk_setup() to configure the clock
source.

If CPM_CLK_RTX has been used for the parameter mode,
the clock has been configured only for TX but not for RX.

Now CPM_CLK_RTX configures the clock for both directions correctly.

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---
 arch/powerpc/sysdev/cpm1.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

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
-- 
1.6.6.1
