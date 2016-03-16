Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ7hS58TZzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 21:56:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/mm: Remove long disabled SLB code
Date: Wed, 16 Mar 2016 21:56:20 +1100
Message-Id: <1458125780-22841-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a bunch of SLB related code in the tree which is there to handle
dynamic VSIDs - but currently it's all disabled at compile time. The
comments say "Keep that around for when we re-implement dynamic VSIDs".

But that was over 10 years ago (commit 3c726f8dee6f ("[PATCH] ppc64:
support 64k pages")). The chance that it would still work unchanged is
minimal, and in the meantime it's confusing to folks browsing/grepping
the code. If we ever want to re-instate it, it's in the git history.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 102 -----------------------------------
 arch/powerpc/mm/slb.c                |   1 -
 arch/powerpc/mm/slb_low.S            |  50 -----------------
 3 files changed, 153 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7716cebf4b8e..e0e1ff463556 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -209,11 +209,6 @@ data_access_slb_pSeries:
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x380)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
-#ifdef __DISABLED__
-	/* Keep that around for when we re-implement dynamic VSIDs */
-	cmpdi	r3,0
-	bge	slb_miss_user_pseries
-#endif /* __DISABLED__ */
 	mfspr	r12,SPRN_SRR1
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
@@ -240,11 +235,6 @@ instruction_access_slb_pSeries:
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x480)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
-#ifdef __DISABLED__
-	/* Keep that around for when we re-implement dynamic VSIDs */
-	cmpdi	r3,0
-	bge	slb_miss_user_pseries
-#endif /* __DISABLED__ */
 	mfspr	r12,SPRN_SRR1
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
@@ -709,34 +699,6 @@ system_reset_fwnmi:
 
 #endif /* CONFIG_PPC_PSERIES */
 
-#ifdef __DISABLED__
-/*
- * This is used for when the SLB miss handler has to go virtual,
- * which doesn't happen for now anymore but will once we re-implement
- * dynamic VSIDs for shared page tables
- */
-slb_miss_user_pseries:
-	std	r10,PACA_EXGEN+EX_R10(r13)
-	std	r11,PACA_EXGEN+EX_R11(r13)
-	std	r12,PACA_EXGEN+EX_R12(r13)
-	GET_SCRATCH0(r10)
-	ld	r11,PACA_EXSLB+EX_R9(r13)
-	ld	r12,PACA_EXSLB+EX_R3(r13)
-	std	r10,PACA_EXGEN+EX_R13(r13)
-	std	r11,PACA_EXGEN+EX_R9(r13)
-	std	r12,PACA_EXGEN+EX_R3(r13)
-	clrrdi	r12,r13,32
-	mfmsr	r10
-	mfspr	r11,SRR0			/* save SRR0 */
-	ori	r12,r12,slb_miss_user_common@l	/* virt addr of handler */
-	ori	r10,r10,MSR_IR|MSR_DR|MSR_RI
-	mtspr	SRR0,r12
-	mfspr	r12,SRR1			/* and SRR1 */
-	mtspr	SRR1,r10
-	rfid
-	b	.				/* prevent spec. execution */
-#endif /* __DISABLED__ */
-
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 kvmppc_skip_interrupt:
 	/*
@@ -1012,70 +974,6 @@ instruction_access_common:
 
 	STD_EXCEPTION_COMMON(0xe20, h_instr_storage, unknown_exception)
 
-/*
- * Here is the common SLB miss user that is used when going to virtual
- * mode for SLB misses, that is currently not used
- */
-#ifdef __DISABLED__
-	.align	7
-	.globl	slb_miss_user_common
-slb_miss_user_common:
-	mflr	r10
-	std	r3,PACA_EXGEN+EX_DAR(r13)
-	stw	r9,PACA_EXGEN+EX_CCR(r13)
-	std	r10,PACA_EXGEN+EX_LR(r13)
-	std	r11,PACA_EXGEN+EX_SRR0(r13)
-	bl	slb_allocate_user
-
-	ld	r10,PACA_EXGEN+EX_LR(r13)
-	ld	r3,PACA_EXGEN+EX_R3(r13)
-	lwz	r9,PACA_EXGEN+EX_CCR(r13)
-	ld	r11,PACA_EXGEN+EX_SRR0(r13)
-	mtlr	r10
-	beq-	slb_miss_fault
-
-	andi.	r10,r12,MSR_RI		/* check for unrecoverable exception */
-	beq-	unrecov_user_slb
-	mfmsr	r10
-
-.machine push
-.machine "power4"
-	mtcrf	0x80,r9
-.machine pop
-
-	clrrdi	r10,r10,2		/* clear RI before setting SRR0/1 */
-	mtmsrd	r10,1
-
-	mtspr	SRR0,r11
-	mtspr	SRR1,r12
-
-	ld	r9,PACA_EXGEN+EX_R9(r13)
-	ld	r10,PACA_EXGEN+EX_R10(r13)
-	ld	r11,PACA_EXGEN+EX_R11(r13)
-	ld	r12,PACA_EXGEN+EX_R12(r13)
-	ld	r13,PACA_EXGEN+EX_R13(r13)
-	rfid
-	b	.
-
-slb_miss_fault:
-	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXGEN)
-	ld	r4,PACA_EXGEN+EX_DAR(r13)
-	li	r5,0
-	std	r4,_DAR(r1)
-	std	r5,_DSISR(r1)
-	b	handle_page_fault
-
-unrecov_user_slb:
-	EXCEPTION_PROLOG_COMMON(0x4200, PACA_EXGEN)
-	RECONCILE_IRQ_STATE(r10, r11)
-	bl	save_nvgprs
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	unrecoverable_exception
-	b	1b
-
-#endif /* __DISABLED__ */
-
-
 	/*
 	 * Machine check is different because we use a different
 	 * save area: PACA_EXMC instead of PACA_EXGEN.
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 825b6873391f..48fc28bab544 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -32,7 +32,6 @@ enum slb_index {
 };
 
 extern void slb_allocate_realmode(unsigned long ea);
-extern void slb_allocate_user(unsigned long ea);
 
 static void slb_allocate(unsigned long ea)
 {
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 736d18b3cefd..d3374004d20d 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -179,56 +179,6 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	li	r11,SLB_VSID_USER	/* flags don't much matter */
 	b	slb_finish_load
 
-#ifdef __DISABLED__
-
-/* void slb_allocate_user(unsigned long ea);
- *
- * Create an SLB entry for the given EA (user or kernel).
- * 	r3 = faulting address, r13 = PACA
- *	r9, r10, r11 are clobbered by this function
- * No other registers are examined or changed.
- *
- * It is called with translation enabled in order to be able to walk the
- * page tables. This is not currently used.
- */
-_GLOBAL(slb_allocate_user)
-	/* r3 = faulting address */
-	srdi	r10,r3,28		/* get esid */
-
-	crset	4*cr7+lt		/* set "user" flag for later */
-
-	/* check if we fit in the range covered by the pagetables*/
-	srdi.	r9,r3,PGTABLE_EADDR_SIZE
-	crnot	4*cr0+eq,4*cr0+eq
-	beqlr
-
-	/* now we need to get to the page tables in order to get the page
-	 * size encoding from the PMD. In the future, we'll be able to deal
-	 * with 1T segments too by getting the encoding from the PGD instead
-	 */
-	ld	r9,PACAPGDIR(r13)
-	cmpldi	cr0,r9,0
-	beqlr
-	rlwinm	r11,r10,8,25,28
-	ldx	r9,r9,r11		/* get pgd_t */
-	cmpldi	cr0,r9,0
-	beqlr
-	rlwinm	r11,r10,3,17,28
-	ldx	r9,r9,r11		/* get pmd_t */
-	cmpldi	cr0,r9,0
-	beqlr
-
-	/* build vsid flags */
-	andi.	r11,r9,SLB_VSID_LLP
-	ori	r11,r11,SLB_VSID_USER
-
-	/* get context to calculate proto-VSID */
-	ld	r9,PACACONTEXTID(r13)
-	/* fall through slb_finish_load */
-
-#endif /* __DISABLED__ */
-
-
 /*
  * Finish loading of an SLB entry and return
  *
-- 
2.5.0
