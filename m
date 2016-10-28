Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4vJD42jczDvMy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 17:39:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64: Used named initialisers for ibm_pa_features
Date: Fri, 28 Oct 2016 17:39:53 +1100
Message-Id: <1477636793-32760-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ibm_pa_features array consists of structures that describe which bit
and byte in the ibm,pa-features property toggles one or more flags in
either the CPU, MMU, or user visible feature flags.

Each one consists of 7 values, which are all unsigned long, int or char,
meaning the compiler gives us no warning if we assign the wrong values
to the wrong elements. In fact we have had a bug here in the past, where
we were setting incorrect bits, see commit 6997e57d693b ("powerpc:
scan_features() updates incorrect bits for REAL_LE").

So switch to using named initialisers for the structure elements, to
reduce the likelihood of future bugs, and hopefully improve readability
also.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)


I've tested this but I would appreciate if someone can verify I didn't typo
anything when transcribing it.

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index b0245bed6f54..a7b87b6b4ef4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -156,21 +156,22 @@ static struct ibm_pa_feature {
 	unsigned char	pabit;		/* bit number (big-endian) */
 	unsigned char	invert;		/* if 1, pa bit set => clear feature */
 } ibm_pa_features[] __initdata = {
-	{0, 0, PPC_FEATURE_HAS_MMU, 0,		0, 0, 0},
-	{0, 0, PPC_FEATURE_HAS_FPU, 0,		0, 1, 0},
-	{CPU_FTR_CTRL, 0, 0, 0,			0, 3, 0},
-	{CPU_FTR_NOEXECUTE, 0, 0, 0,		0, 6, 0},
-	{CPU_FTR_NODSISRALIGN, 0, 0, 0,		1, 1, 1},
-	{0, MMU_FTR_CI_LARGE_PAGE, 0, 0,		1, 2, 0},
-	{CPU_FTR_REAL_LE, 0, PPC_FEATURE_TRUE_LE, 0, 5, 0, 0},
+	{ .pabyte = 0,  .pabit = 0, .cpu_user_ftrs = PPC_FEATURE_HAS_MMU },
+	{ .pabyte = 0,  .pabit = 1, .cpu_user_ftrs = PPC_FEATURE_HAS_FPU },
+	{ .pabyte = 0,  .pabit = 3, .cpu_features  = CPU_FTR_CTRL },
+	{ .pabyte = 0,  .pabit = 6, .cpu_features  = CPU_FTR_NOEXECUTE },
+	{ .pabyte = 1,  .pabit = 2, .mmu_features  = MMU_FTR_CI_LARGE_PAGE },
+	{ .pabyte = 40, .pabit = 0, .mmu_features  = MMU_FTR_TYPE_RADIX },
+	{ .pabyte = 1,  .pabit = 1, .invert = 1, .cpu_features = CPU_FTR_NODSISRALIGN },
+	{ .pabyte = 5,  .pabit = 0, .cpu_features  = CPU_FTR_REAL_LE,
+				    .cpu_user_ftrs = PPC_FEATURE_TRUE_LE },
 	/*
 	 * If the kernel doesn't support TM (ie CONFIG_PPC_TRANSACTIONAL_MEM=n),
 	 * we don't want to turn on TM here, so we use the *_COMP versions
 	 * which are 0 if the kernel doesn't support TM.
 	 */
-	{CPU_FTR_TM_COMP, 0, 0,
-	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
-	{0, MMU_FTR_TYPE_RADIX, 0, 0,		40, 0, 0},
+	{ .pabyte = 22, .pabit = 0, .cpu_features = CPU_FTR_TM_COMP,
+	  .cpu_user_ftrs2 = PPC_FEATURE2_HTM_COMP | PPC_FEATURE2_HTM_NOSC_COMP },
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,
-- 
2.7.4
