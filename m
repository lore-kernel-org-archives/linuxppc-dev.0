Return-Path: <B07421@freescale.com>
Received: from CH1EHSOBE005.bigfish.com (ch1ehsobe004.messaging.microsoft.com
	[216.32.181.184]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DDE8FB6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 07:25:55 +1000 (EST)
Date: Wed, 22 Jun 2011 16:25:42 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH v2] powerpc/book3e-64: use a separate TLB handler when linear
	map is bolted
Message-ID: <20110622212542.GA23089@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On MMUs such as FSL where we can guarantee the entire linear mapping is
bolted, we don't need to worry about linear TLB misses.  If on top of
that we do a full table walk, we get rid of all recursive TLB faults, and
can dispense with some state saving.  This gains a few percent on
TLB-miss-heavy workloads, and around 50% on a benchmark that had a high
rate of virtual page table faults under the normal handler.

While touching the EX_TLB layout, remove EX_TLB_MMUCR0, EX_TLB_SRR0, and
EX_TLB_SRR1 as they're not used.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2:
- Move pgd/kernel_pgd rather than duplicate pgd in extlb. 
- Keep the saved r13 in the scratch SPRG rather than save it to extlb.
- Move rather than duplicate comment about patching the second
  exception instruction.

 arch/powerpc/include/asm/exception-64e.h |   52 +++++---
 arch/powerpc/include/asm/paca.h          |    7 +-
 arch/powerpc/mm/tlb_low_64e.S            |  204 ++++++++++++++++++++++++++++++
 arch/powerpc/mm/tlb_nohash.c             |   35 ++++--
 4 files changed, 264 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index 6d53f31..ac13add 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -48,30 +48,33 @@
 #define EX_R14		(4 * 8)
 #define EX_R15		(5 * 8)
 
-/* The TLB miss exception uses different slots */
+/*
+ * The TLB miss exception uses different slots.
+ *
+ * The bolted variant uses only the first six fields,
+ * which in combination with pgd and kernel_pgd fits in
+ * one 64-byte cache line.
+ */
 
 #define EX_TLB_R10	( 0 * 8)
 #define EX_TLB_R11	( 1 * 8)
-#define EX_TLB_R12	( 2 * 8)
-#define EX_TLB_R13	( 3 * 8)
-#define EX_TLB_R14	( 4 * 8)
-#define EX_TLB_R15	( 5 * 8)
-#define EX_TLB_R16	( 6 * 8)
-#define EX_TLB_CR	( 7 * 8)
+#define EX_TLB_R14	( 2 * 8)
+#define EX_TLB_R15	( 3 * 8)
+#define EX_TLB_R16	( 4 * 8)
+#define EX_TLB_CR	( 5 * 8)
+#define EX_TLB_R12	( 6 * 8)
+#define EX_TLB_R13	( 7 * 8)
 #define EX_TLB_DEAR	( 8 * 8) /* Level 0 and 2 only */
 #define EX_TLB_ESR	( 9 * 8) /* Level 0 and 2 only */
 #define EX_TLB_SRR0	(10 * 8)
 #define EX_TLB_SRR1	(11 * 8)
-#define EX_TLB_MMUCR0	(12 * 8) /* Level 0 */
-#define EX_TLB_MAS1	(12 * 8) /* Level 0 */
-#define EX_TLB_MAS2	(13 * 8) /* Level 0 */
 #ifdef CONFIG_BOOK3E_MMU_TLB_STATS
-#define EX_TLB_R8	(14 * 8)
-#define EX_TLB_R9	(15 * 8)
-#define EX_TLB_LR	(16 * 8)
-#define EX_TLB_SIZE	(17 * 8)
+#define EX_TLB_R8	(12 * 8)
+#define EX_TLB_R9	(13 * 8)
+#define EX_TLB_LR	(14 * 8)
+#define EX_TLB_SIZE	(15 * 8)
 #else
-#define EX_TLB_SIZE	(14 * 8)
+#define EX_TLB_SIZE	(12 * 8)
 #endif
 
 #define	START_EXCEPTION(label)						\
@@ -168,6 +171,16 @@ exc_##label##_book3e:
 	ld	r9,EX_TLB_R9(r12);					    \
 	ld	r8,EX_TLB_R8(r12);					    \
 	mtlr	r16;
+#define TLB_MISS_PROLOG_STATS_BOLTED						    \
+	mflr	r10;							    \
+	std	r8,PACA_EXTLB+EX_TLB_R8(r13);				    \
+	std	r9,PACA_EXTLB+EX_TLB_R9(r13);				    \
+	std	r10,PACA_EXTLB+EX_TLB_LR(r13);
+#define TLB_MISS_RESTORE_STATS_BOLTED					            \
+	ld	r16,PACA_EXTLB+EX_TLB_LR(r13);				    \
+	ld	r9,PACA_EXTLB+EX_TLB_R9(r13);				    \
+	ld	r8,PACA_EXTLB+EX_TLB_R8(r13);				    \
+	mtlr	r16;
 #define TLB_MISS_STATS_D(name)						    \
 	addi	r9,r13,MMSTAT_DSTATS+name;				    \
 	bl	.tlb_stat_inc;
@@ -183,17 +196,20 @@ exc_##label##_book3e:
 61:	addi	r9,r13,MMSTAT_ISTATS+name;				    \
 62:	bl	.tlb_stat_inc;
 #define TLB_MISS_STATS_SAVE_INFO					    \
-	std	r14,EX_TLB_ESR(r12);	/* save ESR */			    \
-
-
+	std	r14,EX_TLB_ESR(r12);	/* save ESR */
+#define TLB_MISS_STATS_SAVE_INFO_BOLTED					    \
+	std	r14,PACA_EXTLB+EX_TLB_ESR(r13);	/* save ESR */
 #else
 #define TLB_MISS_PROLOG_STATS
 #define TLB_MISS_RESTORE_STATS
+#define TLB_MISS_PROLOG_STATS_BOLTED
+#define TLB_MISS_RESTORE_STATS_BOLTED
 #define TLB_MISS_STATS_D(name)
 #define TLB_MISS_STATS_I(name)
 #define TLB_MISS_STATS_X(name)
 #define TLB_MISS_STATS_Y(name)
 #define TLB_MISS_STATS_SAVE_INFO
+#define TLB_MISS_STATS_SAVE_INFO_BOLTED
 #endif
 
 #define SET_IVOR(vector_number, vector_offset)	\
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 7412676..c1f65f5 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -103,11 +103,12 @@ struct paca_struct {
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
 #ifdef CONFIG_PPC_BOOK3E
-	pgd_t *pgd;			/* Current PGD */
-	pgd_t *kernel_pgd;		/* Kernel PGD */
 	u64 exgen[8] __attribute__((aligned(0x80)));
+	/* Keep pgd in the same cacheline as the start of extlb */
+	pgd_t *pgd __attribute__((aligned(0x80))); /* Current PGD */
+	pgd_t *kernel_pgd;		/* Kernel PGD */
 	/* We can have up to 3 levels of reentrancy in the TLB miss handler */
-	u64 extlb[3][EX_TLB_SIZE / sizeof(u64)] __attribute__((aligned(0x80)));
+	u64 extlb[3][EX_TLB_SIZE / sizeof(u64)];
 	u64 exmc[8];		/* used for machine checks */
 	u64 excrit[8];		/* used for crit interrupts */
 	u64 exdbg[8];		/* used for debug interrupts */
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index af08922..d464841 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -30,6 +30,210 @@
 #define VPTE_PGD_SHIFT	(VPTE_PUD_SHIFT + PUD_INDEX_SIZE)
 #define VPTE_INDEX_SIZE (VPTE_PGD_SHIFT + PGD_INDEX_SIZE)
 
+/**********************************************************************
+ *                                                                    *
+ * TLB miss handling for Book3E with a bolted linear mapping          *
+ * No virtual page table, no nested TLB misses                        *
+ *                                                                    *
+ **********************************************************************/
+
+.macro tlb_prolog_bolted addr
+	mtspr	SPRN_SPRG_TLB_SCRATCH,r13
+	mfspr	r13,SPRN_SPRG_PACA
+	std	r10,PACA_EXTLB+EX_TLB_R10(r13)
+	mfcr	r10
+	std	r11,PACA_EXTLB+EX_TLB_R11(r13)
+	std	r16,PACA_EXTLB+EX_TLB_R16(r13)
+	mfspr	r16,\addr		/* get faulting address */
+	std	r14,PACA_EXTLB+EX_TLB_R14(r13)
+	ld	r14,PACAPGD(r13)
+	std	r15,PACA_EXTLB+EX_TLB_R15(r13)
+	std	r10,PACA_EXTLB+EX_TLB_CR(r13)
+	TLB_MISS_PROLOG_STATS_BOLTED
+.endm
+
+.macro tlb_epilog_bolted
+	ld	r14,PACA_EXTLB+EX_TLB_CR(r13)
+	ld	r10,PACA_EXTLB+EX_TLB_R10(r13)
+	ld	r11,PACA_EXTLB+EX_TLB_R11(r13)
+	mtcr	r14
+	ld	r14,PACA_EXTLB+EX_TLB_R14(r13)
+	ld	r15,PACA_EXTLB+EX_TLB_R15(r13)
+	TLB_MISS_RESTORE_STATS_BOLTED
+	ld	r16,PACA_EXTLB+EX_TLB_R16(r13)
+	mfspr	r13,SPRN_SPRG_TLB_SCRATCH
+.endm
+
+/* Data TLB miss */
+	START_EXCEPTION(data_tlb_miss_bolted)
+	tlb_prolog_bolted SPRN_DEAR
+
+	/* We need _PAGE_PRESENT and  _PAGE_ACCESSED set */
+
+	/* We do the user/kernel test for the PID here along with the RW test
+	 */
+	/* We pre-test some combination of permissions to avoid double
+	 * faults:
+	 *
+	 * We move the ESR:ST bit into the position of _PAGE_BAP_SW in the PTE
+	 * ESR_ST   is 0x00800000
+	 * _PAGE_BAP_SW is 0x00000010
+	 * So the shift is >> 19. This tests for supervisor writeability.
+	 * If the page happens to be supervisor writeable and not user
+	 * writeable, we will take a new fault later, but that should be
+	 * a rare enough case.
+	 *
+	 * We also move ESR_ST in _PAGE_DIRTY position
+	 * _PAGE_DIRTY is 0x00001000 so the shift is >> 11
+	 *
+	 * MAS1 is preset for all we need except for TID that needs to
+	 * be cleared for kernel translations
+	 */
+
+	mfspr	r11,SPRN_ESR
+
+	srdi	r15,r16,60		/* get region */
+	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
+	bne-	dtlb_miss_fault_bolted
+
+	rlwinm	r10,r11,32-19,27,27
+	rlwimi	r10,r11,32-16,19,19
+	cmpwi	r15,0
+	ori	r10,r10,_PAGE_PRESENT
+	oris	r11,r10,_PAGE_ACCESSED@h
+
+	TLB_MISS_STATS_SAVE_INFO_BOLTED
+	bne	tlb_miss_kernel_bolted
+
+tlb_miss_common_bolted:
+/*
+ * This is the guts of the TLB miss handler for bolted-linear.
+ * We are entered with:
+ *
+ * r16 = faulting address
+ * r15 = crap (free to use)
+ * r14 = page table base
+ * r13 = PACA
+ * r11 = PTE permission mask
+ * r10 = crap (free to use)
+ */
+	rldicl	r15,r16,64-PGDIR_SHIFT+3,64-PGD_INDEX_SIZE-3
+	cmpldi	cr0,r14,0
+	clrrdi	r15,r15,3
+	beq	tlb_miss_fault_bolted
+
+BEGIN_MMU_FTR_SECTION
+	/* Set the TLB reservation and search for existing entry. Then load
+	 * the entry.
+	 */
+	PPC_TLBSRX_DOT(0,r16)
+	ldx	r14,r14,r15
+	beq	normal_tlb_miss_done
+MMU_FTR_SECTION_ELSE
+	ldx	r14,r14,r15
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
+
+	rldicl	r15,r16,64-PUD_SHIFT+3,64-PUD_INDEX_SIZE-3
+	clrrdi	r15,r15,3
+
+	cmpldi	cr0,r14,0
+	beq	tlb_miss_fault_bolted
+
+	ldx	r14,r14,r15
+
+	rldicl	r15,r16,64-PMD_SHIFT+3,64-PMD_INDEX_SIZE-3
+	clrrdi	r15,r15,3
+
+	cmpldi	cr0,r14,0
+	beq	tlb_miss_fault_bolted
+
+	ldx	r14,r14,r15
+
+	rldicl	r15,r16,64-PAGE_SHIFT+3,64-PTE_INDEX_SIZE-3
+	clrrdi	r15,r15,3
+
+	cmpldi	cr0,r14,0
+	beq	tlb_miss_fault_bolted
+
+	ldx	r14,r14,r15
+
+	/* Check if required permissions are met */
+	andc.	r15,r11,r14
+	rldicr	r15,r14,64-(PTE_RPN_SHIFT-PAGE_SHIFT),63-PAGE_SHIFT
+	bne-	tlb_miss_fault_bolted
+
+	/* Now we build the MAS:
+	 *
+	 * MAS 0   :	Fully setup with defaults in MAS4 and TLBnCFG
+	 * MAS 1   :	Almost fully setup
+	 *               - PID already updated by caller if necessary
+	 *               - TSIZE need change if !base page size, not
+	 *                 yet implemented for now
+	 * MAS 2   :	Defaults not useful, need to be redone
+	 * MAS 3+7 :	Needs to be done
+	 */
+	clrrdi	r11,r16,12		/* Clear low crap in EA */
+	clrldi	r15,r15,12		/* Clear crap at the top */
+	rlwimi	r11,r14,32-19,27,31	/* Insert WIMGE */
+	rlwimi	r15,r14,32-8,22,25	/* Move in U bits */
+	mtspr	SPRN_MAS2,r11
+	andi.	r11,r14,_PAGE_DIRTY
+	rlwimi	r15,r14,32-2,26,31	/* Move in BAP bits */
+
+	/* Mask out SW and UW if !DIRTY (XXX optimize this !) */
+	bne	1f
+	li	r11,MAS3_SW|MAS3_UW
+	andc	r15,r15,r11
+1:
+	mtspr	SPRN_MAS7_MAS3,r15
+	tlbwe
+
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_NORM_OK)
+	tlb_epilog_bolted
+	rfi
+
+itlb_miss_kernel_bolted:
+	li	r11,_PAGE_PRESENT|_PAGE_BAP_SX	/* Base perm */
+	oris	r11,r11,_PAGE_ACCESSED@h
+tlb_miss_kernel_bolted:
+	mfspr	r10,SPRN_MAS1
+	ld	r14,PACA_KERNELPGD(r13)
+	cmpldi	cr0,r15,8		/* Check for vmalloc region */
+	rlwinm	r10,r10,0,16,1		/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+	beq+	tlb_miss_common_bolted
+
+tlb_miss_fault_bolted:
+	/* We need to check if it was an instruction miss */
+	andi.	r10,r11,_PAGE_EXEC|_PAGE_BAP_SX
+	bne	itlb_miss_fault_bolted
+dtlb_miss_fault_bolted:
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_NORM_FAULT)
+	tlb_epilog_bolted
+	b	exc_data_storage_book3e
+itlb_miss_fault_bolted:
+	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_NORM_FAULT)
+	tlb_epilog_bolted
+	b	exc_instruction_storage_book3e
+
+/* Instruction TLB miss */
+	START_EXCEPTION(instruction_tlb_miss_bolted)
+	tlb_prolog_bolted SPRN_SRR0
+
+	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
+	srdi	r15,r16,60		/* get region */
+	TLB_MISS_STATS_SAVE_INFO_BOLTED
+	bne-	itlb_miss_fault_bolted
+
+	li	r11,_PAGE_PRESENT|_PAGE_EXEC	/* Base perm */
+
+	/* We do the user/kernel test for the PID here along with the RW test
+	 */
+
+	cmpldi	cr0,r15,0			/* Check for user region */
+	oris	r11,r11,_PAGE_ACCESSED@h
+	beq	tlb_miss_common_bolted
+	b	itlb_miss_kernel_bolted
 
 /**********************************************************************
  *                                                                    *
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 5693499..3722185 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -443,14 +443,27 @@ static void setup_page_sizes(void)
 	}
 }
 
-static void setup_mmu_htw(void)
+static void __patch_exception(int exc, unsigned long addr)
 {
 	extern unsigned int interrupt_base_book3e;
-	extern unsigned int exc_data_tlb_miss_htw_book3e;
-	extern unsigned int exc_instruction_tlb_miss_htw_book3e;
+ 	unsigned int *ibase = &interrupt_base_book3e;
+ 
+	/* Our exceptions vectors start with a NOP and -then- a branch
+	 * to deal with single stepping from userspace which stops on
+	 * the second instruction. Thus we need to patch the second
+	 * instruction of the exception, not the first one
+	 */
+
+	patch_branch(ibase + (exc / 4) + 1, addr, 0);
+}
 
-	unsigned int *ibase = &interrupt_base_book3e;
+#define patch_exception(exc, name) do { \
+	extern unsigned int name; \
+	__patch_exception((exc), (unsigned long)&name); \
+} while (0)
 
+static void setup_mmu_htw(void)
+{
 	/* Check if HW tablewalk is present, and if yes, enable it by:
 	 *
 	 * - patching the TLB miss handlers to branch to the
@@ -462,15 +475,8 @@ static void setup_mmu_htw(void)
 
 	if ((tlb0cfg & TLBnCFG_IND) &&
 	    (tlb0cfg & TLBnCFG_PT)) {
-		/* Our exceptions vectors start with a NOP and -then- a branch
-		 * to deal with single stepping from userspace which stops on
-		 * the second instruction. Thus we need to patch the second
-		 * instruction of the exception, not the first one
-		 */
-		patch_branch(ibase + (0x1c0 / 4) + 1,
-			     (unsigned long)&exc_data_tlb_miss_htw_book3e, 0);
-		patch_branch(ibase + (0x1e0 / 4) + 1,
-			     (unsigned long)&exc_instruction_tlb_miss_htw_book3e, 0);
+		patch_exception(0x1c0, exc_data_tlb_miss_htw_book3e);
+		patch_exception(0x1e0, exc_instruction_tlb_miss_htw_book3e);
 		book3e_htw_enabled = 1;
 	}
 	pr_info("MMU: Book3E HW tablewalk %s\n",
@@ -549,6 +555,9 @@ static void __early_init_mmu(int boot_cpu)
 		/* limit memory so we dont have linear faults */
 		memblock_enforce_memory_limit(linear_map_top);
 		memblock_analyze();
+
+		patch_exception(0x1c0, exc_data_tlb_miss_bolted_book3e);
+		patch_exception(0x1e0, exc_instruction_tlb_miss_bolted_book3e);
 	}
 #endif
 
-- 
1.7.4.1
