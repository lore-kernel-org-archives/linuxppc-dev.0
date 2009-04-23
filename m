Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1198DE10E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 23:53:17 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n3NDrEWP001837
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 08:53:14 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Revert "powerpc: Add support for early tlbilx opcode"
Date: Thu, 23 Apr 2009 08:53:13 -0500
Message-Id: <1240494793-17015-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This reverts commit e9965577406a2148ade97b5e0ce7c448b4ba4ef6.  Our HW
guys were able to fix this so it never sees the light of day.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu.h        |    6 ------
 arch/powerpc/include/asm/ppc-opcode.h |   11 +----------
 arch/powerpc/kernel/cputable.c        |    2 +-
 arch/powerpc/mm/tlb_nohash_low.S      |   14 +-------------
 4 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 86d2366..cbf1543 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -52,12 +52,6 @@
  */
 #define MMU_FTR_NEED_DTLB_SW_LRU	ASM_CONST(0x00200000)
 
-/* This indicates that the processor uses the wrong opcode for tlbilx
- * instructions.  During the ISA 2.06 development the opcode for tlbilx
- * changed and some early implementations used to old opcode
- */
-#define MMU_FTR_TLBILX_EARLY_OPCODE	ASM_CONST(0x00400000)
-
 #ifndef __ASSEMBLY__
 #include <asm/cputable.h>
 
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index ef4da37..640ccbb 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -44,7 +44,6 @@
 #define PPC_INST_STSWI			0x7c0005aa
 #define PPC_INST_STSWX			0x7c00052a
 #define PPC_INST_TLBILX			0x7c000024
-#define PPC_INST_TLBILX_EARLY		0x7c000626
 #define PPC_INST_WAIT			0x7c00007c
 
 /* macros to insert fields into opcodes */
@@ -64,18 +63,10 @@
 #define PPC_RFDI		stringify_in_c(.long PPC_INST_RFDI)
 #define PPC_RFMCI		stringify_in_c(.long PPC_INST_RFMCI)
 #define PPC_TLBILX(t, a, b)	stringify_in_c(.long PPC_INST_TLBILX | \
-					__PPC_T_TLB(t) | \
-					__PPC_RA(a) | __PPC_RB(b))
+					__PPC_T_TLB(t) | __PPC_RA(a) | __PPC_RB(b))
 #define PPC_TLBILX_ALL(a, b)	PPC_TLBILX(0, a, b)
 #define PPC_TLBILX_PID(a, b)	PPC_TLBILX(1, a, b)
 #define PPC_TLBILX_VA(a, b)	PPC_TLBILX(3, a, b)
-
-#define PPC_TLBILX_EARLY(t, a, b) stringify_in_c(.long PPC_INST_TLBILX_EARLY | \
-						__PPC_T_TLB(t) | \
-						__PPC_RA(a) | __PPC_RB(b))
-#define PPC_TLBILX_ALL_EARLY(a, b)	PPC_TLBILX_EARLY(0, a, b)
-#define PPC_TLBILX_PID_EARLY(a, b)	PPC_TLBILX_EARLY(1, a, b)
-#define PPC_TLBILX_VA_EARLY(a, b)	PPC_TLBILX_EARLY(3, a, b)
 #define PPC_WAIT(w)		stringify_in_c(.long PPC_INST_WAIT | \
 					__PPC_WC(w))
 
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 57db50f..cd1b687 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1766,7 +1766,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_E500MC,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
-			MMU_FTR_USE_TLBILX | MMU_FTR_TLBILX_EARLY_OPCODE,
+			MMU_FTR_USE_TLBILX,
 		.icache_bsize		= 64,
 		.dcache_bsize		= 64,
 		.num_pmcs		= 4,
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index 45fed36..788b87c 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -138,11 +138,7 @@ BEGIN_MMU_FTR_SECTION
 	andi.	r3,r3,MMUCSR0_TLBFI@l
 	bne	1b
 MMU_FTR_SECTION_ELSE
-  BEGIN_MMU_FTR_SECTION_NESTED(96)
-	PPC_TLBILX_ALL(0,r3)
-  MMU_FTR_SECTION_ELSE_NESTED(96)
-	PPC_TLBILX_ALL_EARLY(0,r3)
-  ALT_MMU_FTR_SECTION_END_NESTED_IFCLR(MMU_FTR_TLBILX_EARLY_OPCODE, 96)
+	PPC_TLBILX_ALL(0,0)
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_TLBILX)
 	msync
 	isync
@@ -155,11 +151,7 @@ BEGIN_MMU_FTR_SECTION
 	wrteei	0
 	mfspr	r4,SPRN_MAS6	/* save MAS6 */
 	mtspr	SPRN_MAS6,r3
-  BEGIN_MMU_FTR_SECTION_NESTED(96)
 	PPC_TLBILX_PID(0,0)
-  MMU_FTR_SECTION_ELSE_NESTED(96)
-	PPC_TLBILX_PID_EARLY(0,0)
-  ALT_MMU_FTR_SECTION_END_NESTED_IFCLR(MMU_FTR_TLBILX_EARLY_OPCODE, 96)
 	mtspr	SPRN_MAS6,r4	/* restore MAS6 */
 	wrtee	r10
 MMU_FTR_SECTION_ELSE
@@ -193,11 +185,7 @@ BEGIN_MMU_FTR_SECTION
 	mtspr	SPRN_MAS1,r4
 	tlbwe
 MMU_FTR_SECTION_ELSE
-  BEGIN_MMU_FTR_SECTION_NESTED(96)
 	PPC_TLBILX_VA(0,r3)
-  MMU_FTR_SECTION_ELSE_NESTED(96)
-	PPC_TLBILX_VA_EARLY(0,r3)
-  ALT_MMU_FTR_SECTION_END_NESTED_IFCLR(MMU_FTR_TLBILX_EARLY_OPCODE, 96)
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_TLBILX)
 	msync
 	isync
-- 
1.6.0.6
