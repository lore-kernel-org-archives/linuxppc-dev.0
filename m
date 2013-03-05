Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DC91C2C0324
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Mar 2013 10:16:04 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r25NG2pP024136
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Mar 2013 17:16:02 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] powerpc/fsl-booke: Support detection of page sizes on
Date: Tue,  5 Mar 2013 17:15:55 -0600
Message-Id: <1362525360-23136-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
References: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The e6500 core used on T4240 and B4860 SoCs from FSL implements MMUv2 of
the Power Book-E Architecture.  However there are some minor differences
between it and other Book-E implementations.

Add support to parse SPRN_TLB1PS for the variable page sizes supported.
In the future this should be expanded for more page sizes supported on
e6500 as well as other MMU features.

This patch is based on code from Scott Wood.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/tlb_nohash.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index df32a83..6888cad 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -414,9 +414,9 @@ static void setup_page_sizes(void)
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
 	unsigned int mmucfg = mfspr(SPRN_MMUCFG);
+	int fsl_mmu = mmu_has_feature(MMU_FTR_TYPE_FSL_E);
 
-	if (((mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V1) &&
-		(mmu_has_feature(MMU_FTR_TYPE_FSL_E))) {
+	if (fsl_mmu && (mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V1) {
 		unsigned int tlb1cfg = mfspr(SPRN_TLB1CFG);
 		unsigned int min_pg, max_pg;
 
@@ -442,6 +442,20 @@ static void setup_page_sizes(void)
 
 		goto no_indirect;
 	}
+
+	if (fsl_mmu && (mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2) {
+		u32 tlb1ps = mfspr(SPRN_TLB1PS);
+
+		for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
+			struct mmu_psize_def *def = &mmu_psize_defs[psize];
+
+			if (tlb1ps & (1U << (def->shift - 10))) {
+				def->flags |= MMU_PAGE_SIZE_DIRECT;
+			}
+		}
+
+		goto no_indirect;
+	}
 #endif
 
 	tlb0cfg = mfspr(SPRN_TLB0CFG);
-- 
1.7.9.7
