Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09B381A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 17:10:49 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Clean up MMU_FTRS_A2 and MMU_FTR_TYPE_3E
Date: Tue,  8 Jul 2014 17:10:45 +1000
Message-Id: <1404803445-6894-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In fb5a515704d7 "powerpc: Remove platforms/wsp and associated pieces",
we removed the last user of MMU_FTRS_A2. So remove it.

MMU_FTRS_A2 was the last user of MMU_FTR_TYPE_3E, so remove it also.
This leaves some unreachable code in mmu_context_nohash.c, so remove
that also.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu.h       | 10 +---------
 arch/powerpc/mm/mmu_context_nohash.c | 12 +-----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index f8d1d6dcf7db..e61f24ed4e65 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -19,8 +19,7 @@
 #define MMU_FTR_TYPE_40x		ASM_CONST(0x00000004)
 #define MMU_FTR_TYPE_44x		ASM_CONST(0x00000008)
 #define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
-#define MMU_FTR_TYPE_3E			ASM_CONST(0x00000020)
-#define MMU_FTR_TYPE_47x		ASM_CONST(0x00000040)
+#define MMU_FTR_TYPE_47x		ASM_CONST(0x00000020)
 
 /*
  * This is individual features
@@ -106,13 +105,6 @@
 				MMU_FTR_CI_LARGE_PAGE
 #define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
 				MMU_FTR_CI_LARGE_PAGE | MMU_FTR_NO_SLBIE_B
-#define MMU_FTRS_A2		MMU_FTR_TYPE_3E | MMU_FTR_USE_TLBILX | \
-				MMU_FTR_USE_TLBIVAX_BCAST | \
-				MMU_FTR_LOCK_BCAST_INVAL | \
-				MMU_FTR_USE_TLBRSRV | \
-				MMU_FTR_USE_PAIRED_MAS | \
-				MMU_FTR_TLBIEL | \
-				MMU_FTR_16M_PAGE
 #ifndef __ASSEMBLY__
 #include <asm/cputable.h>
 
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index af3d78e19302..928ebe79668b 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -410,17 +410,7 @@ void __init mmu_context_init(void)
 	} else if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
 		first_context = 1;
 		last_context = 65535;
-	} else
-#ifdef CONFIG_PPC_BOOK3E_MMU
-	if (mmu_has_feature(MMU_FTR_TYPE_3E)) {
-		u32 mmucfg = mfspr(SPRN_MMUCFG);
-		u32 pid_bits = (mmucfg & MMUCFG_PIDSIZE_MASK)
-				>> MMUCFG_PIDSIZE_SHIFT;
-		first_context = 1;
-		last_context = (1UL << (pid_bits + 1)) - 1;
-	} else
-#endif
-	{
+	} else {
 		first_context = 1;
 		last_context = 255;
 	}
-- 
1.9.1
