Return-Path: <b04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C551867C7B
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 08:42:57 +1100 (EST)
Received: from az33smr01 (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	kA9LgmYo013398
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Nov 2006 14:42:48 -0700 (MST)
From: timur@freescale.com
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Optimize qe_brg struct to use an array
Date: Thu,  9 Nov 2006 15:42:44 -0600
Message-Id: <11631085643554-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>

The qe_brg structure manually defined each of the 16 BRG registers, which
made any code that used them cumbersome.  This patch replaces the fields
with a single 16-element array.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |    3 +--
 include/asm-powerpc/immap_qe.h  |   17 +----------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index e422322..e3d71e0 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -174,8 +174,7 @@ void qe_setbrg(u32 brg, u32 rate)
 	u32 divisor, tempval;
 	int div16 = 0;
 
-	bp = &qe_immr->brg.brgc1;
-	bp += brg;
+	bp = &qe_immr->brg.brgc[brg];
 
 	divisor = (get_brg_clk() / rate);
 	if (divisor > QE_BRGC_DIVISOR_MAX + 1) {
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index ce12f85..9fdd049 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -136,22 +136,7 @@ struct qe_timers {
 
 /* BRG */
 struct qe_brg {
-	__be32	brgc1;		/* BRG1 configuration register */
-	__be32	brgc2;		/* BRG2 configuration register */
-	__be32	brgc3;		/* BRG3 configuration register */
-	__be32	brgc4;		/* BRG4 configuration register */
-	__be32	brgc5;		/* BRG5 configuration register */
-	__be32	brgc6;		/* BRG6 configuration register */
-	__be32	brgc7;		/* BRG7 configuration register */
-	__be32	brgc8;		/* BRG8 configuration register */
-	__be32	brgc9;		/* BRG9 configuration register */
-	__be32	brgc10;		/* BRG10 configuration register */
-	__be32	brgc11;		/* BRG11 configuration register */
-	__be32	brgc12;		/* BRG12 configuration register */
-	__be32	brgc13;		/* BRG13 configuration register */
-	__be32	brgc14;		/* BRG14 configuration register */
-	__be32	brgc15;		/* BRG15 configuration register */
-	__be32	brgc16;		/* BRG16 configuration register */
+	__be32	brgc[16];	/* BRG configuration registers */
 	u8	res0[0x40];
 } __attribute__ ((packed));
 
-- 
1.4.2.1
