Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 246F5DDF78
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 07:34:48 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l42LYipZ012657
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 14:34:44 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l42LYhfp015253
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 16:34:44 -0500 (CDT)
Subject: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1178141683.32136.46.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 02 May 2007 16:34:43 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: James.Yang <James.Yang@freescale.com>

Remove CPU_FTR_NEED_COHERENT for MPC7448 (and single-core MPC86xx).
This prevents needlessly setting M=1 when not SMP.

Signed-off-by: James.Yang <James.Yang@freescale.com>
Acked-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/kernel/cputable.c |    2 +-
 include/asm-powerpc/cputable.h |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 9cb24d2..6ef87fb 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -836,7 +836,7 @@ static struct cpu_spec cpu_specs[] = {
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80040000,
 		.cpu_name		= "7448",
-		.cpu_features		= CPU_FTRS_7447A,
+		.cpu_features		= CPU_FTRS_7448,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 4345249..82d595a 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -302,6 +302,12 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
+#define CPU_FTRS_7448	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+	    CPU_FTR_USE_TB | \
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
+	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
+	    CPU_FTR_PPC_LE)
 #define CPU_FTRS_82XX	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)
 #define CPU_FTRS_G2_LE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | \
-- 
1.5.0.3
