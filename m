Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KKfG4k95zF3F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:10:46 +1000 (AEST)
Message-Id: <7e4ec9da90f1a2939fc3be71e86e5910133dd9f6.1537877134.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537877134.git.christophe.leroy@c-s.fr>
References: <cover.1537877134.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 3/9] powerpc: clear redundancies in asm-offset.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Sep 2018 12:10:41 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to be able to include asm-offset.h in smp.h for PPC32,
all definitions which are conflicting with C need new names.

TASK_SIZE is nowhere used in asm.

PPC_DBELL_SERVER_SERVER and PPC_DBELL_SERVER_MSGTYPE are only
needed on PPC64 in asm.

MAS0 ... MAS7 conflict with 'struct tlbcam' fields.

NSEC_PER_SEC, PGD_TABLE_SIZE, PGD_T_LOG2 and PTE_T_LOG2
conflict with themselves.

This patch:
- Removes TASK_SIZE
- Encloses PPC_DBELL_SERVER_... in #ifdef CONFIG_PPC64
- Adds ASM_PTE_SHIFT as its definition uses PTE_T_LOG2
- Adds ASM_PGDIR_SHIFT as its definition uses PGD_T_LOG2
- Prefixes all other with ASM_

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-44x.h        |  8 ++++----
 arch/powerpc/kernel/asm-offsets.c         | 27 +++++++++++++++------------
 arch/powerpc/kernel/entry_32.S            | 22 +++++++++++-----------
 arch/powerpc/kernel/head_32.S             |  2 +-
 arch/powerpc/kernel/head_40x.S            |  2 +-
 arch/powerpc/kernel/head_44x.S            |  2 +-
 arch/powerpc/kernel/head_64.S             |  2 +-
 arch/powerpc/kernel/head_8xx.S            |  2 +-
 arch/powerpc/kernel/head_fsl_booke.S      |  2 +-
 arch/powerpc/kernel/vdso32/gettimeofday.S |  4 ++--
 10 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
index 295b3dbb2698..c9a355944f9e 100644
--- a/arch/powerpc/include/asm/mmu-44x.h
+++ b/arch/powerpc/include/asm/mmu-44x.h
@@ -145,9 +145,9 @@ typedef struct {
 
 #define mmu_linear_psize	MMU_PAGE_256M
 
-#define PPC44x_PGD_OFF_SHIFT	(32 - PGDIR_SHIFT + PGD_T_LOG2)
-#define PPC44x_PGD_OFF_MASK_BIT	(PGDIR_SHIFT - PGD_T_LOG2)
-#define PPC44x_PTE_ADD_SHIFT	(32 - PGDIR_SHIFT + PTE_SHIFT + PTE_T_LOG2)
-#define PPC44x_PTE_ADD_MASK_BIT	(32 - PTE_T_LOG2 - PTE_SHIFT)
+#define PPC44x_PGD_OFF_SHIFT	(32 - ASM_PGDIR_SHIFT + ASM_PGD_T_LOG2)
+#define PPC44x_PGD_OFF_MASK_BIT	(ASM_PGDIR_SHIFT - ASM_PGD_T_LOG2)
+#define PPC44x_PTE_ADD_SHIFT	(32 - ASM_PGDIR_SHIFT + ASM_PTE_SHIFT + ASM_PTE_T_LOG2)
+#define PPC44x_PTE_ADD_MASK_BIT	(32 - ASM_PTE_T_LOG2 - ASM_PTE_SHIFT)
 
 #endif /* _ASM_POWERPC_MMU_44X_H_ */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index d1f161e48945..3c649a6529eb 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -322,14 +322,14 @@ int main(void)
 #if defined(CONFIG_PPC32)
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 	DEFINE(EXC_LVL_SIZE, STACK_EXC_LVL_FRAME_SIZE);
-	DEFINE(MAS0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas0));
+	DEFINE(ASM_MAS0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas0));
 	/* we overload MMUCR for 44x on MAS0 since they are mutually exclusive */
 	DEFINE(MMUCR, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas0));
-	DEFINE(MAS1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas1));
-	DEFINE(MAS2, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas2));
-	DEFINE(MAS3, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas3));
-	DEFINE(MAS6, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas6));
-	DEFINE(MAS7, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas7));
+	DEFINE(ASM_MAS1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas1));
+	DEFINE(ASM_MAS2, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas2));
+	DEFINE(ASM_MAS3, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas3));
+	DEFINE(ASM_MAS6, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas6));
+	DEFINE(ASM_MAS7, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas7));
 	DEFINE(_SRR0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, srr0));
 	DEFINE(_SRR1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, srr1));
 	DEFINE(_CSRR0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, csrr0));
@@ -354,7 +354,6 @@ int main(void)
 	OFFSET(pbe_next, pbe, next);
 
 #ifndef CONFIG_PPC64
-	DEFINE(TASK_SIZE, TASK_SIZE);
 	DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28);
 #endif /* ! CONFIG_PPC64 */
 
@@ -399,7 +398,7 @@ int main(void)
 	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
 	DEFINE(CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
 	DEFINE(CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
-	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
+	DEFINE(ASM_NSEC_PER_SEC, NSEC_PER_SEC);
 	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
 
 #ifdef CONFIG_BUG
@@ -407,9 +406,9 @@ int main(void)
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
-	DEFINE(PGD_TABLE_SIZE, (sizeof(pgd_t) << max(RADIX_PGD_INDEX_SIZE, H_PGD_INDEX_SIZE)));
+	DEFINE(ASM_PGD_TABLE_SIZE, (sizeof(pgd_t) << max(RADIX_PGD_INDEX_SIZE, H_PGD_INDEX_SIZE)));
 #else
-	DEFINE(PGD_TABLE_SIZE, PGD_TABLE_SIZE);
+	DEFINE(ASM_PGD_TABLE_SIZE, PGD_TABLE_SIZE);
 #endif
 	DEFINE(PTE_SIZE, sizeof(pte_t));
 
@@ -710,8 +709,10 @@ int main(void)
 #endif
 
 #ifdef CONFIG_44x
-	DEFINE(PGD_T_LOG2, PGD_T_LOG2);
-	DEFINE(PTE_T_LOG2, PTE_T_LOG2);
+	DEFINE(ASM_PGD_T_LOG2, PGD_T_LOG2);
+	DEFINE(ASM_PTE_T_LOG2, PTE_T_LOG2);
+	DEFINE(ASM_PTE_SHIFT, PTE_SHIFT);
+	DEFINE(ASM_PGDIR_SHIFT, PGDIR_SHIFT);
 #endif
 #ifdef CONFIG_PPC_FSL_BOOK3E
 	DEFINE(TLBCAM_SIZE, sizeof(struct tlbcam));
@@ -769,8 +770,10 @@ int main(void)
 	STOP_SPR(STOP_MMCRA, mmcra);
 #endif
 
+#ifdef CONFIG_PPC64
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
 	DEFINE(PPC_DBELL_MSGTYPE, PPC_DBELL_MSGTYPE);
+#endif
 
 #ifdef CONFIG_PPC_8xx
 	DEFINE(VIRT_IMMR_BASE, (u64)__fix_to_virt(FIX_IMMR_BASE));
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 12c0721f65ea..83f3d3e977a9 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -74,18 +74,18 @@ debug_transfer_to_handler:
 crit_transfer_to_handler:
 #ifdef CONFIG_PPC_BOOK3E_MMU
 	mfspr	r0,SPRN_MAS0
-	stw	r0,MAS0(r11)
+	stw	r0,ASM_MAS0(r11)
 	mfspr	r0,SPRN_MAS1
-	stw	r0,MAS1(r11)
+	stw	r0,ASM_MAS1(r11)
 	mfspr	r0,SPRN_MAS2
-	stw	r0,MAS2(r11)
+	stw	r0,ASM_MAS2(r11)
 	mfspr	r0,SPRN_MAS3
-	stw	r0,MAS3(r11)
+	stw	r0,ASM_MAS3(r11)
 	mfspr	r0,SPRN_MAS6
-	stw	r0,MAS6(r11)
+	stw	r0,ASM_MAS6(r11)
 #ifdef CONFIG_PHYS_64BIT
 	mfspr	r0,SPRN_MAS7
-	stw	r0,MAS7(r11)
+	stw	r0,ASM_MAS7(r11)
 #endif /* CONFIG_PHYS_64BIT */
 #endif /* CONFIG_PPC_BOOK3E_MMU */
 #ifdef CONFIG_44x
@@ -1115,13 +1115,13 @@ exc_exit_restart_end:
 #define	RESTORE_MAS7
 #endif /* CONFIG_PHYS_64BIT */
 #define RESTORE_MMU_REGS						\
-	lwz	r9,MAS0(r1);						\
-	lwz	r10,MAS1(r1);						\
-	lwz	r11,MAS2(r1);						\
+	lwz	r9,ASM_MAS0(r1);						\
+	lwz	r10,ASM_MAS1(r1);						\
+	lwz	r11,ASM_MAS2(r1);						\
 	mtspr	SPRN_MAS0,r9;						\
-	lwz	r9,MAS3(r1);						\
+	lwz	r9,ASM_MAS3(r1);						\
 	mtspr	SPRN_MAS1,r10;						\
-	lwz	r10,MAS6(r1);						\
+	lwz	r10,ASM_MAS6(r1);						\
 	mtspr	SPRN_MAS2,r11;						\
 	mtspr	SPRN_MAS3,r9;						\
 	mtspr	SPRN_MAS6,r10;						\
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index dbb096c32332..0c380c7ab82c 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1273,7 +1273,7 @@ EXPORT_SYMBOL(empty_zero_page)
 
 	.globl	swapper_pg_dir
 swapper_pg_dir:
-	.space	PGD_TABLE_SIZE
+	.space	ASM_PGD_TABLE_SIZE
 
 /* Room for two PTE pointers, usually the kernel and current user pointers
  * to their respective root page table.
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 3088c9f29f5e..bc44775c442c 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -976,7 +976,7 @@ empty_zero_page:
 EXPORT_SYMBOL(empty_zero_page)
 	.globl	swapper_pg_dir
 swapper_pg_dir:
-	.space	PGD_TABLE_SIZE
+	.space	ASM_PGD_TABLE_SIZE
 
 /* Room for two PTE pointers, usually the kernel and current user pointers
  * to their respective root page table.
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 37e4a7cf0065..612c0d42ce1c 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1262,7 +1262,7 @@ EXPORT_SYMBOL(empty_zero_page)
  */
 	.globl	swapper_pg_dir
 swapper_pg_dir:
-	.space	PGD_TABLE_SIZE
+	.space	ASM_PGD_TABLE_SIZE
 
 /*
  * Room for two PTE pointers, usually the kernel and current user pointers
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4898e9491a1c..cf9437aafe58 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1015,7 +1015,7 @@ start_here_common:
 
 	.globl	swapper_pg_dir
 swapper_pg_dir:
-	.space	PGD_TABLE_SIZE
+	.space	ASM_PGD_TABLE_SIZE
 
 	.globl	empty_zero_page
 empty_zero_page:
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index e56e36aa2b3d..561e441c883d 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -1041,7 +1041,7 @@ EXPORT_SYMBOL(empty_zero_page)
 
 	.globl	swapper_pg_dir
 swapper_pg_dir:
-	.space	PGD_TABLE_SIZE
+	.space	ASM_PGD_TABLE_SIZE
 
 /* Room for two PTE table poiners, usually the kernel and current user
  * pointer to their respective root page table (pgdir).
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 35d35067acf7..611426977693 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1228,7 +1228,7 @@ empty_zero_page:
 EXPORT_SYMBOL(empty_zero_page)
 	.globl	swapper_pg_dir
 swapper_pg_dir:
-	.space	PGD_TABLE_SIZE
+	.space	ASM_PGD_TABLE_SIZE
 
 /*
  * Room for two PTE pointers, usually the kernel and current user pointers
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 1e0bc5955a40..cd77c6f22f8f 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -82,8 +82,8 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	mr	r11,r4			/* r11 saves tp */
 	bl	__get_datapage@local	/* get data page */
 	mr	r9,r3			/* datapage ptr in r9 */
-	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
-	ori	r7,r7,NSEC_PER_SEC@l
+	lis	r7,ASM_NSEC_PER_SEC@h	/* want nanoseconds */
+	ori	r7,r7,ASM_NSEC_PER_SEC@l
 50:	bl	__do_get_tspec@local	/* get sec/nsec from tb & kernel */
 	bne	cr1,80f			/* not monotonic -> all done */
 
-- 
2.13.3
