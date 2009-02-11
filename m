Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB52FDDDA3
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 17:13:31 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1B6DRf4018095
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 00:13:27 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Add support for tlbilx instructions
Date: Wed, 11 Feb 2009 00:13:27 -0600
Message-Id: <1234332807-8182-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The e500mc core supports the new tlbilx instructions that do core
local invalidates and also provide us the ability to take down
all TLB entries matching a given PID.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

(depends on the powerpc: Unify opcode definitions and support patch)

 arch/powerpc/include/asm/mmu.h   |    4 +-
 arch/powerpc/kernel/cputable.c   |    3 +-
 arch/powerpc/mm/tlb_nohash_low.S |   44 +++++++++++++++++++++++++++++++------
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 6e76399..608a0b2 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -36,9 +36,9 @@
  */
 #define MMU_FTR_USE_TLBIVAX_BCAST	ASM_CONST(0x00040000)
 
-/* Enable use of tlbilx invalidate-by-PID variant.
+/* Enable use of tlbilx invalidate instructions.
  */
-#define MMU_FTR_USE_TLBILX_PID		ASM_CONST(0x00080000)
+#define MMU_FTR_USE_TLBILX		ASM_CONST(0x00080000)
 
 /* This indicates that the processor cannot handle multiple outstanding
  * broadcast tlbivax or tlbsync. This makes the code use a spinlock
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 9fdf1b8..d68f343 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1740,7 +1740,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "e500mc",
 		.cpu_features		= CPU_FTRS_E500MC,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
-		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
+			MMU_FTR_USE_TLBILX,
 		.icache_bsize		= 64,
 		.dcache_bsize		= 64,
 		.num_pmcs		= 4,
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index f900a39..342327c 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -118,25 +118,50 @@ _GLOBAL(_tlbil_pid)
 
 #elif defined(CONFIG_FSL_BOOKE)
 /*
- * FSL BookE implementations. Currently _pid and _all are the
- * same. This will change when tlbilx is actually supported and
- * performs invalidate-by-PID. This change will be driven by
- * mmu_features conditional
+ * FSL BookE implementations.
+ *
+ * Since feature sections are using _SECTION_ELSE we need
+ * to have the larger code path before the _SECTION_ELSE
  */
 
+#define MMUCSR0_TLBFI	(MMUCSR0_TLB0FI | MMUCSR0_TLB1FI | \
+			 MMUCSR0_TLB2FI | MMUCSR0_TLB3FI)
 /*
  * Flush MMU TLB on the local processor
  */
-_GLOBAL(_tlbil_pid)
 _GLOBAL(_tlbil_all)
-#define MMUCSR0_TLBFI	(MMUCSR0_TLB0FI | MMUCSR0_TLB1FI | \
-			 MMUCSR0_TLB2FI | MMUCSR0_TLB3FI)
+BEGIN_MMU_FTR_SECTION
+	li	r3,(MMUCSR0_TLBFI)@l
+	mtspr	SPRN_MMUCSR0, r3
+1:
+	mfspr	r3,SPRN_MMUCSR0
+	andi.	r3,r3,MMUCSR0_TLBFI@l
+	bne	1b
+MMU_FTR_SECTION_ELSE
+	PPC_TLBILX_ALL(0,0)
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_TLBILX)
+	msync
+	isync
+	blr
+
+_GLOBAL(_tlbil_pid)
+BEGIN_MMU_FTR_SECTION
+	slwi	r3,r3,16
+	mfmsr	r10
+	wrteei	0
+	mfspr	r4,SPRN_MAS6	/* save MAS6 */
+	mtspr	SPRN_MAS6,r3
+	PPC_TLBILX_PID(0,0)
+	mtspr	SPRN_MAS6,r4	/* restore MAS6 */
+	wrtee	r10
+MMU_FTR_SECTION_ELSE
 	li	r3,(MMUCSR0_TLBFI)@l
 	mtspr	SPRN_MMUCSR0, r3
 1:
 	mfspr	r3,SPRN_MMUCSR0
 	andi.	r3,r3,MMUCSR0_TLBFI@l
 	bne	1b
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBILX)
 	msync
 	isync
 	blr
@@ -149,7 +174,9 @@ _GLOBAL(_tlbil_va)
 	mfmsr	r10
 	wrteei	0
 	slwi	r4,r4,16
+	ori	r4,r4,(MAS6_ISIZE(BOOKE_PAGESZ_4K))@l
 	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
+BEGIN_MMU_FTR_SECTION
 	tlbsx	0,r3
 	mfspr	r4,SPRN_MAS1		/* check valid */
 	andis.	r3,r4,MAS1_VALID@h
@@ -157,6 +184,9 @@ _GLOBAL(_tlbil_va)
 	rlwinm	r4,r4,0,1,31
 	mtspr	SPRN_MAS1,r4
 	tlbwe
+MMU_FTR_SECTION_ELSE
+	PPC_TLBILX_VA(0,r3)
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_TLBILX)
 	msync
 	isync
 1:	wrtee	r10
-- 
1.5.6.6
