Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4RWD23DxzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 16:47:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com,
	alistair@popple.id.au
Subject: [PATCH 1/2] powerpc: Add mask of possible MMU features
Date: Wed, 11 May 2016 16:47:10 +1000
Message-Id: <1462949231-28355-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Follow the example of the cpu feature code, and add a mask of possible
MMU features, MMU_FTRS_POSSIBLE.

This is used in mmu_has_feature(), which allows the possible mask to act
as a shortcut for any features that are not possible, but still allows
the feature bit itself to be defined.

We will use this feature in the next commit to fix a bug with the
recently add MMU_FTR_RADIX.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index d91dc886c90f..a5e37c93700b 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -119,9 +119,21 @@
 DECLARE_PER_CPU(int, next_tlbcam_idx);
 #endif
 
+enum {
+	MMU_FTRS_POSSIBLE = MMU_FTR_HPTE_TABLE | MMU_FTR_TYPE_8xx |
+		MMU_FTR_TYPE_40x | MMU_FTR_TYPE_44x | MMU_FTR_TYPE_FSL_E |
+		MMU_FTR_TYPE_47x | MMU_FTR_USE_HIGH_BATS | MMU_FTR_BIG_PHYS |
+		MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_USE_TLBILX |
+		MMU_FTR_LOCK_BCAST_INVAL | MMU_FTR_NEED_DTLB_SW_LRU |
+		MMU_FTR_USE_TLBRSRV | MMU_FTR_USE_PAIRED_MAS |
+		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
+		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
+		MMU_FTR_1T_SEGMENT | MMU_FTR_RADIX,
+};
+
 static inline int mmu_has_feature(unsigned long feature)
 {
-	return (cur_cpu_spec->mmu_features & feature);
+	return (MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
 }
 
 static inline void mmu_clear_feature(unsigned long feature)
-- 
2.5.0
