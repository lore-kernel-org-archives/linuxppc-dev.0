Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4462C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:25:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80DA20895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80DA20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XQRc32NNzF3FM
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 00:25:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XQJt6hzBzF3D5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 00:19:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42XQJt5rhMz9sB5; Sun, 14 Oct 2018 00:19:10 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42XQJt5Mdcz9sBj; Sun, 14 Oct 2018 00:19:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/6] powerpc/64s/hash: Convert SLB miss handlers to C
Date: Sun, 14 Oct 2018 00:18:31 +1100
Message-Id: <20181013131836.26764-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nicholas Piggin <npiggin@gmail.com>

This patch moves SLB miss handlers completely to C, using the standard
exception handler macros to set up the stack and branch to C.

This can be done because the segment containing the kernel stack is
always bolted, so accessing it with relocation on will not cause an
SLB exception.

Arbitrary kernel memory must not be accessed when handling kernel
space SLB misses, so care should be taken there. However user SLB
misses can access any kernel memory, which can be used to move some
fields out of the paca (in later patches).

User SLB misses could quite easily reconcile IRQs and set up a first
class kernel environment and exit via ret_from_except, however that
doesn't seem to be necessary at the moment, so we only do that if a
bad fault is encountered.

[ Credit to Aneesh for bug fixes, error checks, and improvements to
  bad address handling, etc ]

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Disallow tracing for all of slb.c for now.]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/asm-prototypes.h |   2 +
 arch/powerpc/include/asm/exception-64s.h  |   8 -
 arch/powerpc/kernel/exceptions-64s.S      | 202 +++----------
 arch/powerpc/mm/Makefile                  |   4 +-
 arch/powerpc/mm/slb.c                     | 289 +++++++++++--------
 arch/powerpc/mm/slb_low.S                 | 335 ----------------------
 6 files changed, 214 insertions(+), 626 deletions(-)
 delete mode 100644 arch/powerpc/mm/slb_low.S

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 9bc98c239305..2741831482f4 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -77,6 +77,8 @@ void kernel_bad_stack(struct pt_regs *regs);
 void system_reset_exception(struct pt_regs *regs);
 void machine_check_exception(struct pt_regs *regs);
 void emulation_assist_interrupt(struct pt_regs *regs);
+long do_slb_fault(struct pt_regs *regs, unsigned long ea);
+void do_bad_slb_fault(struct pt_regs *regs, unsigned long ea, long err);
 
 /* signals, syscalls and interrupts */
 long sys_swapcontext(struct ucontext __user *old_ctx,
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 403d73898a9a..3b4767ed3ec5 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -60,14 +60,6 @@
  */
 #define MAX_MCE_DEPTH	4
 
-/*
- * EX_LR is only used in EXSLB and where it does not overlap with EX_DAR
- * EX_CCR similarly with DSISR, but being 4 byte registers there is a hole
- * in the save area so it's not necessary to overlap them. Could be used
- * for future savings though if another 4 byte register was to be saved.
- */
-#define EX_LR		EX_DAR
-
 /*
  * EX_R3 is only used by the bad_stack handler. bad_stack reloads and
  * saves DAR from SPRN_DAR, and EX_DAR is not used. So EX_R3 can overlap
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b9239dbf6d59..89d32bb79d5e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -596,28 +596,36 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 
 EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
-	mr	r12,r3	/* save r3 */
-	mfspr	r3,SPRN_DAR
-	mfspr	r11,SPRN_SRR1
-	crset	4*cr6+eq
-	BRANCH_TO_COMMON(r10, slb_miss_common)
+EXCEPTION_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, KVMTEST_PR, 0x380);
 EXC_REAL_END(data_access_slb, 0x380, 0x80)
 
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
-	mr	r12,r3	/* save r3 */
-	mfspr	r3,SPRN_DAR
-	mfspr	r11,SPRN_SRR1
-	crset	4*cr6+eq
-	BRANCH_TO_COMMON(r10, slb_miss_common)
+EXCEPTION_RELON_PROLOG(PACA_EXSLB, data_access_slb_common, EXC_STD, NOTEST, 0x380);
 EXC_VIRT_END(data_access_slb, 0x4380, 0x80)
+
 TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 
+EXC_COMMON_BEGIN(data_access_slb_common)
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXSLB+EX_DAR(r13)
+	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXSLB)
+	ld	r4,PACA_EXSLB+EX_DAR(r13)
+	std	r4,_DAR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	do_slb_fault
+	cmpdi	r3,0
+	bne-	1f
+	b	fast_exception_return
+1:	/* Error case */
+	std	r3,RESULT(r1)
+	bl	save_nvgprs
+	RECONCILE_IRQ_STATE(r10, r11)
+	ld	r4,_DAR(r1)
+	ld	r5,RESULT(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	do_bad_slb_fault
+	b	ret_from_except
+
 
 EXC_REAL(instruction_access, 0x400, 0x80)
 EXC_VIRT(instruction_access, 0x4400, 0x80, 0x400)
@@ -640,160 +648,34 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 
 EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x80)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
-	mr	r12,r3	/* save r3 */
-	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
-	mfspr	r11,SPRN_SRR1
-	crclr	4*cr6+eq
-	BRANCH_TO_COMMON(r10, slb_miss_common)
+EXCEPTION_PROLOG(PACA_EXSLB, instruction_access_slb_common, EXC_STD, KVMTEST_PR, 0x480);
 EXC_REAL_END(instruction_access_slb, 0x480, 0x80)
 
 EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x80)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
-	mr	r12,r3	/* save r3 */
-	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
-	mfspr	r11,SPRN_SRR1
-	crclr	4*cr6+eq
-	BRANCH_TO_COMMON(r10, slb_miss_common)
+EXCEPTION_RELON_PROLOG(PACA_EXSLB, instruction_access_slb_common, EXC_STD, NOTEST, 0x480);
 EXC_VIRT_END(instruction_access_slb, 0x4480, 0x80)
-TRAMP_KVM(PACA_EXSLB, 0x480)
-
-
-/*
- * This handler is used by the 0x380 and 0x480 SLB miss interrupts, as well as
- * the virtual mode 0x4380 and 0x4480 interrupts if AIL is enabled.
- */
-EXC_COMMON_BEGIN(slb_miss_common)
-	/*
-	 * r13 points to the PACA, r9 contains the saved CR,
-	 * r12 contains the saved r3,
-	 * r11 contain the saved SRR1, SRR0 is still ready for return
-	 * r3 has the faulting address
-	 * r9 - r13 are saved in paca->exslb.
- 	 * cr6.eq is set for a D-SLB miss, clear for a I-SLB miss
-	 * We assume we aren't going to take any exceptions during this
-	 * procedure.
-	 */
-	mflr	r10
-	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
-	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
-
-	andi.	r9,r11,MSR_PR	// Check for exception from userspace
-	cmpdi	cr4,r9,MSR_PR	// And save the result in CR4 for later
-
-	/*
-	 * Test MSR_RI before calling slb_allocate_realmode, because the
-	 * MSR in r11 gets clobbered. However we still want to allocate
-	 * SLB in case MSR_RI=0, to minimise the risk of getting stuck in
-	 * recursive SLB faults. So use cr5 for this, which is preserved.
-	 */
-	andi.	r11,r11,MSR_RI	/* check for unrecoverable exception */
-	cmpdi	cr5,r11,MSR_RI
-
-	crset	4*cr0+eq
-#ifdef CONFIG_PPC_BOOK3S_64
-BEGIN_MMU_FTR_SECTION
-	bl	slb_allocate
-END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
-#endif
-
-	ld	r10,PACA_EXSLB+EX_LR(r13)
-	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
-	mtlr	r10
-
-	/*
-	 * Large address, check whether we have to allocate new contexts.
-	 */
-	beq-	8f
 
-	bne-	cr5,2f		/* if unrecoverable exception, oops */
-
-	/* All done -- return from exception. */
-
-	bne	cr4,1f		/* returning to kernel */
-
-	mtcrf	0x80,r9
-	mtcrf	0x08,r9		/* MSR[PR] indication is in cr4 */
-	mtcrf	0x04,r9		/* MSR[RI] indication is in cr5 */
-	mtcrf	0x02,r9		/* I/D indication is in cr6 */
-	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
-
-	RESTORE_CTR(r9, PACA_EXSLB)
-	RESTORE_PPR_PACA(PACA_EXSLB, r9)
-	mr	r3,r12
-	ld	r9,PACA_EXSLB+EX_R9(r13)
-	ld	r10,PACA_EXSLB+EX_R10(r13)
-	ld	r11,PACA_EXSLB+EX_R11(r13)
-	ld	r12,PACA_EXSLB+EX_R12(r13)
-	ld	r13,PACA_EXSLB+EX_R13(r13)
-	RFI_TO_USER
-	b	.	/* prevent speculative execution */
-1:
-	mtcrf	0x80,r9
-	mtcrf	0x08,r9		/* MSR[PR] indication is in cr4 */
-	mtcrf	0x04,r9		/* MSR[RI] indication is in cr5 */
-	mtcrf	0x02,r9		/* I/D indication is in cr6 */
-	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
-
-	RESTORE_CTR(r9, PACA_EXSLB)
-	RESTORE_PPR_PACA(PACA_EXSLB, r9)
-	mr	r3,r12
-	ld	r9,PACA_EXSLB+EX_R9(r13)
-	ld	r10,PACA_EXSLB+EX_R10(r13)
-	ld	r11,PACA_EXSLB+EX_R11(r13)
-	ld	r12,PACA_EXSLB+EX_R12(r13)
-	ld	r13,PACA_EXSLB+EX_R13(r13)
-	RFI_TO_KERNEL
-	b	.	/* prevent speculative execution */
-
-
-2:	std     r3,PACA_EXSLB+EX_DAR(r13)
-	mr	r3,r12
-	mfspr	r11,SPRN_SRR0
-	mfspr	r12,SPRN_SRR1
-	LOAD_HANDLER(r10,unrecov_slb)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	mtspr	SPRN_SRR1,r10
-	RFI_TO_KERNEL
-	b	.
-
-8:	std     r3,PACA_EXSLB+EX_DAR(r13)
-	mr	r3,r12
-	mfspr	r11,SPRN_SRR0
-	mfspr	r12,SPRN_SRR1
-	LOAD_HANDLER(r10, large_addr_slb)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	mtspr	SPRN_SRR1,r10
-	RFI_TO_KERNEL
-	b	.
+TRAMP_KVM(PACA_EXSLB, 0x480)
 
-EXC_COMMON_BEGIN(unrecov_slb)
-	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
-	RECONCILE_IRQ_STATE(r10, r11)
+EXC_COMMON_BEGIN(instruction_access_slb_common)
+	EXCEPTION_PROLOG_COMMON(0x480, PACA_EXSLB)
+	ld	r4,_NIP(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	do_slb_fault
+	cmpdi	r3,0
+	bne-	1f
+	b	fast_exception_return
+1:	/* Error case */
+	std	r3,RESULT(r1)
 	bl	save_nvgprs
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	unrecoverable_exception
-	b	1b
-
-EXC_COMMON_BEGIN(large_addr_slb)
-	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXSLB)
 	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r3, PACA_EXSLB+EX_DAR(r13)
-	std	r3, _DAR(r1)
-	beq	cr6, 2f
-	li	r10, 0x481		/* fix trap number for I-SLB miss */
-	std	r10, _TRAP(r1)
-2:	bl	save_nvgprs
-	addi	r3, r1, STACK_FRAME_OVERHEAD
-	bl	slb_miss_large_addr
+	ld	r4,_NIP(r1)
+	ld	r5,RESULT(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	do_bad_slb_fault
 	b	ret_from_except
 
+
 EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x100)
 	.globl hardware_interrupt_hv;
 hardware_interrupt_hv:
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 3c844bdd16c4..ceb352ccbc76 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -7,6 +7,8 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
+CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
+
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
 				   init-common.o mmu_context.o drmem.o
@@ -15,7 +17,7 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
 hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 513c6596140d..76c1a9523049 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -14,6 +14,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 
+#include <asm/asm-prototypes.h>
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
@@ -33,7 +34,7 @@ enum slb_index {
 	KSTACK_INDEX	= 1, /* Kernel stack map */
 };
 
-extern void slb_allocate(unsigned long ea);
+static long slb_allocate_user(struct mm_struct *mm, unsigned long ea);
 
 #define slb_esid_mask(ssize)	\
 	(((ssize) == MMU_SEGSIZE_256M)? ESID_MASK: ESID_MASK_1T)
@@ -44,13 +45,19 @@ static inline unsigned long mk_esid_data(unsigned long ea, int ssize,
 	return (ea & slb_esid_mask(ssize)) | SLB_ESID_V | index;
 }
 
-static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
+static inline unsigned long __mk_vsid_data(unsigned long vsid, int ssize,
 					 unsigned long flags)
 {
-	return (get_kernel_vsid(ea, ssize) << slb_vsid_shift(ssize)) | flags |
+	return (vsid << slb_vsid_shift(ssize)) | flags |
 		((unsigned long) ssize << SLB_VSID_SSIZE_SHIFT);
 }
 
+static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
+					 unsigned long flags)
+{
+	return __mk_vsid_data(get_kernel_vsid(ea, ssize), ssize, flags);
+}
+
 static inline void slb_shadow_update(unsigned long ea, int ssize,
 				     unsigned long flags,
 				     enum slb_index index)
@@ -353,49 +360,19 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	    is_kernel_addr(exec_base))
 		return;
 
-	slb_allocate(pc);
+	slb_allocate_user(mm, pc);
 
 	if (!esids_match(pc, stack))
-		slb_allocate(stack);
+		slb_allocate_user(mm, stack);
 
 	if (!esids_match(pc, exec_base) &&
 	    !esids_match(stack, exec_base))
-		slb_allocate(exec_base);
-}
-
-static inline void patch_slb_encoding(unsigned int *insn_addr,
-				      unsigned int immed)
-{
-
-	/*
-	 * This function patches either an li or a cmpldi instruction with
-	 * a new immediate value. This relies on the fact that both li
-	 * (which is actually addi) and cmpldi both take a 16-bit immediate
-	 * value, and it is situated in the same location in the instruction,
-	 * ie. bits 16-31 (Big endian bit order) or the lower 16 bits.
-	 * The signedness of the immediate operand differs between the two
-	 * instructions however this code is only ever patching a small value,
-	 * much less than 1 << 15, so we can get away with it.
-	 * To patch the value we read the existing instruction, clear the
-	 * immediate value, and or in our new value, then write the instruction
-	 * back.
-	 */
-	unsigned int insn = (*insn_addr & 0xffff0000) | immed;
-	patch_instruction(insn_addr, insn);
+		slb_allocate_user(mm, exec_base);
 }
 
-extern u32 slb_miss_kernel_load_linear[];
-extern u32 slb_miss_kernel_load_io[];
-extern u32 slb_compare_rr_to_size[];
-extern u32 slb_miss_kernel_load_vmemmap[];
-
 void slb_set_size(u16 size)
 {
-	if (mmu_slb_size == size)
-		return;
-
 	mmu_slb_size = size;
-	patch_slb_encoding(slb_compare_rr_to_size, mmu_slb_size);
 }
 
 void slb_initialize(void)
@@ -417,19 +394,9 @@ void slb_initialize(void)
 #endif
 	if (!slb_encoding_inited) {
 		slb_encoding_inited = 1;
-		patch_slb_encoding(slb_miss_kernel_load_linear,
-				   SLB_VSID_KERNEL | linear_llp);
-		patch_slb_encoding(slb_miss_kernel_load_io,
-				   SLB_VSID_KERNEL | io_llp);
-		patch_slb_encoding(slb_compare_rr_to_size,
-				   mmu_slb_size);
-
 		pr_devel("SLB: linear  LLP = %04lx\n", linear_llp);
 		pr_devel("SLB: io      LLP = %04lx\n", io_llp);
-
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-		patch_slb_encoding(slb_miss_kernel_load_vmemmap,
-				   SLB_VSID_KERNEL | vmemmap_llp);
 		pr_devel("SLB: vmemmap LLP = %04lx\n", vmemmap_llp);
 #endif
 	}
@@ -458,125 +425,203 @@ void slb_initialize(void)
 	asm volatile("isync":::"memory");
 }
 
-static void insert_slb_entry(unsigned long vsid, unsigned long ea,
-			     int bpsize, int ssize)
+static void slb_cache_update(unsigned long esid_data)
 {
-	unsigned long flags, vsid_data, esid_data;
-	enum slb_index index;
 	int slb_cache_index;
 
 	if (cpu_has_feature(CPU_FTR_ARCH_300))
 		return; /* ISAv3.0B and later does not use slb_cache */
 
 	/*
-	 * We are irq disabled, hence should be safe to access PACA.
+	 * Now update slb cache entries
 	 */
-	VM_WARN_ON(!irqs_disabled());
+	slb_cache_index = local_paca->slb_cache_ptr;
+	if (slb_cache_index < SLB_CACHE_ENTRIES) {
+		/*
+		 * We have space in slb cache for optimized switch_slb().
+		 * Top 36 bits from esid_data as per ISA
+		 */
+		local_paca->slb_cache[slb_cache_index++] = esid_data >> 28;
+		local_paca->slb_cache_ptr++;
+	} else {
+		/*
+		 * Our cache is full and the current cache content strictly
+		 * doesn't indicate the active SLB conents. Bump the ptr
+		 * so that switch_slb() will ignore the cache.
+		 */
+		local_paca->slb_cache_ptr = SLB_CACHE_ENTRIES + 1;
+	}
+}
 
-	/*
-	 * We can't take a PMU exception in the following code, so hard
-	 * disable interrupts.
-	 */
-	hard_irq_disable();
+static enum slb_index alloc_slb_index(void)
+{
+	enum slb_index index;
 
+	/* round-robin replacement of slb starting at SLB_NUM_BOLTED. */
 	index = get_paca()->stab_rr;
-
-	/*
-	 * simple round-robin replacement of slb starting at SLB_NUM_BOLTED.
-	 */
 	if (index < (mmu_slb_size - 1))
 		index++;
 	else
 		index = SLB_NUM_BOLTED;
-
 	get_paca()->stab_rr = index;
 
-	flags = SLB_VSID_USER | mmu_psize_defs[bpsize].sllp;
-	vsid_data = (vsid << slb_vsid_shift(ssize)) | flags |
-		    ((unsigned long) ssize << SLB_VSID_SSIZE_SHIFT);
+	return index;
+}
+
+static long slb_insert_entry(unsigned long ea, unsigned long context,
+				unsigned long flags, int ssize, bool kernel)
+{
+	unsigned long vsid;
+	unsigned long vsid_data, esid_data;
+	enum slb_index index;
+
+	vsid = get_vsid(context, ea, ssize);
+	if (!vsid)
+		return -EFAULT;
+
+	/*
+	 * There must not be a kernel SLB fault in alloc_slb_index or before
+	 * slbmte here or the allocation bitmaps could get out of whack with
+	 * the SLB.
+	 *
+	 * User SLB faults or preloads take this path which might get inlined
+	 * into the caller, so add compiler barriers here to ensure unsafe
+	 * memory accesses do not come between.
+	 */
+	barrier();
+
+	index = alloc_slb_index();
+
+	vsid_data = __mk_vsid_data(vsid, ssize, flags);
 	esid_data = mk_esid_data(ea, ssize, index);
 
 	/*
 	 * No need for an isync before or after this slbmte. The exception
 	 * we enter with and the rfid we exit with are context synchronizing.
-	 * Also we only handle user segments here.
+	 * User preloads should add isync afterwards in case the kernel
+	 * accesses user memory before it returns to userspace with rfid.
 	 */
-	asm volatile("slbmte %0, %1" : : "r" (vsid_data), "r" (esid_data)
-		     : "memory");
+	asm volatile("slbmte %0, %1" : : "r" (vsid_data), "r" (esid_data));
 
-	/*
-	 * Now update slb cache entries
-	 */
-	slb_cache_index = get_paca()->slb_cache_ptr;
-	if (slb_cache_index < SLB_CACHE_ENTRIES) {
-		/*
-		 * We have space in slb cache for optimized switch_slb().
-		 * Top 36 bits from esid_data as per ISA
-		 */
-		get_paca()->slb_cache[slb_cache_index++] = esid_data >> 28;
-		get_paca()->slb_cache_ptr++;
+	barrier();
+
+	if (!kernel)
+		slb_cache_update(esid_data);
+
+	return 0;
+}
+
+static long slb_allocate_kernel(unsigned long ea, unsigned long id)
+{
+	unsigned long context;
+	unsigned long flags;
+	int ssize;
+
+	if ((ea & ~REGION_MASK) >= (1ULL << MAX_EA_BITS_PER_CONTEXT))
+		return -EFAULT;
+
+	if (id == KERNEL_REGION_ID) {
+		flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_linear_psize].sllp;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	} else if (id == VMEMMAP_REGION_ID) {
+		flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmemmap_psize].sllp;
+#endif
+	} else if (id == VMALLOC_REGION_ID) {
+		if (ea < H_VMALLOC_END)
+			flags = get_paca()->vmalloc_sllp;
+		else
+			flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_io_psize].sllp;
 	} else {
-		/*
-		 * Our cache is full and the current cache content strictly
-		 * doesn't indicate the active SLB conents. Bump the ptr
-		 * so that switch_slb() will ignore the cache.
-		 */
-		get_paca()->slb_cache_ptr = SLB_CACHE_ENTRIES + 1;
+		return -EFAULT;
 	}
+
+	ssize = MMU_SEGSIZE_1T;
+	if (!mmu_has_feature(MMU_FTR_1T_SEGMENT))
+		ssize = MMU_SEGSIZE_256M;
+
+	context = id - KERNEL_REGION_CONTEXT_OFFSET;
+
+	return slb_insert_entry(ea, context, flags, ssize, true);
 }
 
-static void handle_multi_context_slb_miss(int context_id, unsigned long ea)
+static long slb_allocate_user(struct mm_struct *mm, unsigned long ea)
 {
-	struct mm_struct *mm = current->mm;
-	unsigned long vsid;
+	unsigned long context;
+	unsigned long flags;
 	int bpsize;
+	int ssize;
 
 	/*
-	 * We are always above 1TB, hence use high user segment size.
+	 * consider this as bad access if we take a SLB miss
+	 * on an address above addr limit.
 	 */
-	vsid = get_vsid(context_id, ea, mmu_highuser_ssize);
+	if (ea >= mm->context.slb_addr_limit)
+		return -EFAULT;
+
+	context = get_ea_context(&mm->context, ea);
+	if (!context)
+		return -EFAULT;
+
+	if (unlikely(ea >= H_PGTABLE_RANGE)) {
+		WARN_ON(1);
+		return -EFAULT;
+	}
+
+	ssize = user_segment_size(ea);
+
 	bpsize = get_slice_psize(mm, ea);
-	insert_slb_entry(vsid, ea, bpsize, mmu_highuser_ssize);
+	flags = SLB_VSID_USER | mmu_psize_defs[bpsize].sllp;
+
+	return slb_insert_entry(ea, context, flags, ssize, false);
 }
 
-void slb_miss_large_addr(struct pt_regs *regs)
+long do_slb_fault(struct pt_regs *regs, unsigned long ea)
 {
-	enum ctx_state prev_state = exception_enter();
-	unsigned long ea = regs->dar;
-	int context;
+	unsigned long id = REGION_ID(ea);
 
-	if (REGION_ID(ea) != USER_REGION_ID)
-		goto slb_bad_addr;
+	/* IRQs are not reconciled here, so can't check irqs_disabled */
+	VM_WARN_ON(mfmsr() & MSR_EE);
 
-	/*
-	 * Are we beyound what the page table layout supports ?
-	 */
-	if ((ea & ~REGION_MASK) >= H_PGTABLE_RANGE)
-		goto slb_bad_addr;
-
-	/* Lower address should have been handled by asm code */
-	if (ea < (1UL << MAX_EA_BITS_PER_CONTEXT))
-		goto slb_bad_addr;
+	if (unlikely(!(regs->msr & MSR_RI)))
+		return -EINVAL;
 
 	/*
-	 * consider this as bad access if we take a SLB miss
-	 * on an address above addr limit.
+	 * SLB kernel faults must be very careful not to touch anything
+	 * that is not bolted. E.g., PACA and global variables are okay,
+	 * mm->context stuff is not.
+	 *
+	 * SLB user faults can access all of kernel memory, but must be
+	 * careful not to touch things like IRQ state because it is not
+	 * "reconciled" here. The difficulty is that we must use
+	 * fast_exception_return to return from kernel SLB faults without
+	 * looking at possible non-bolted memory. We could test user vs
+	 * kernel faults in the interrupt handler asm and do a full fault,
+	 * reconcile, ret_from_except for user faults which would make them
+	 * first class kernel code. But for performance it's probably nicer
+	 * if they go via fast_exception_return too.
 	 */
-	if (ea >= current->mm->context.slb_addr_limit)
-		goto slb_bad_addr;
+	if (id >= KERNEL_REGION_ID) {
+		return slb_allocate_kernel(ea, id);
+	} else {
+		struct mm_struct *mm = current->mm;
 
-	context = get_ea_context(&current->mm->context, ea);
-	if (!context)
-		goto slb_bad_addr;
+		if (unlikely(!mm))
+			return -EFAULT;
 
-	handle_multi_context_slb_miss(context, ea);
-	exception_exit(prev_state);
-	return;
+		return slb_allocate_user(mm, ea);
+	}
+}
 
-slb_bad_addr:
-	if (user_mode(regs))
-		_exception(SIGSEGV, regs, SEGV_BNDERR, ea);
-	else
-		bad_page_fault(regs, ea, SIGSEGV);
-	exception_exit(prev_state);
+void do_bad_slb_fault(struct pt_regs *regs, unsigned long ea, long err)
+{
+	if (err == -EFAULT) {
+		if (user_mode(regs))
+			_exception(SIGSEGV, regs, SEGV_BNDERR, ea);
+		else
+			bad_page_fault(regs, ea, SIGSEGV);
+	} else if (err == -EINVAL) {
+		unrecoverable_exception(regs);
+	} else {
+		BUG();
+	}
 }
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
deleted file mode 100644
index 4d2e921d696e..000000000000
--- a/arch/powerpc/mm/slb_low.S
+++ /dev/null
@@ -1,335 +0,0 @@
-/*
- * Low-level SLB routines
- *
- * Copyright (C) 2004 David Gibson <dwg@au.ibm.com>, IBM
- *
- * Based on earlier C version:
- * Dave Engebretsen and Mike Corrigan {engebret|mikejc}@us.ibm.com
- *    Copyright (c) 2001 Dave Engebretsen
- * Copyright (C) 2002 Anton Blanchard <anton@au.ibm.com>, IBM
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-
-#include <asm/processor.h>
-#include <asm/ppc_asm.h>
-#include <asm/asm-offsets.h>
-#include <asm/cputable.h>
-#include <asm/page.h>
-#include <asm/mmu.h>
-#include <asm/pgtable.h>
-#include <asm/firmware.h>
-#include <asm/feature-fixups.h>
-
-/*
- * This macro generates asm code to compute the VSID scramble
- * function.  Used in slb_allocate() and do_stab_bolted.  The function
- * computed is: (protovsid*VSID_MULTIPLIER) % VSID_MODULUS
- *
- *	rt = register containing the proto-VSID and into which the
- *		VSID will be stored
- *	rx = scratch register (clobbered)
- *	rf = flags
- *
- *	- rt and rx must be different registers
- *	- The answer will end up in the low VSID_BITS bits of rt.  The higher
- *	  bits may contain other garbage, so you may need to mask the
- *	  result.
- */
-#define ASM_VSID_SCRAMBLE(rt, rx, rf, size)				\
-	lis	rx,VSID_MULTIPLIER_##size@h;				\
-	ori	rx,rx,VSID_MULTIPLIER_##size@l;				\
-	mulld	rt,rt,rx;		/* rt = rt * MULTIPLIER */	\
-/*									\
- * powermac get slb fault before feature fixup, so make 65 bit part     \
- * the default part of feature fixup					\
- */									\
-BEGIN_MMU_FTR_SECTION							\
-	srdi	rx,rt,VSID_BITS_65_##size;				\
-	clrldi	rt,rt,(64-VSID_BITS_65_##size);				\
-	add	rt,rt,rx;						\
-	addi	rx,rt,1;						\
-	srdi	rx,rx,VSID_BITS_65_##size;				\
-	add	rt,rt,rx;						\
-	rldimi	rf,rt,SLB_VSID_SHIFT_##size,(64 - (SLB_VSID_SHIFT_##size + VSID_BITS_65_##size)); \
-MMU_FTR_SECTION_ELSE							\
-	srdi	rx,rt,VSID_BITS_##size;					\
-	clrldi	rt,rt,(64-VSID_BITS_##size);				\
-	add	rt,rt,rx;		/* add high and low bits */	\
-	addi	rx,rt,1;						\
-	srdi	rx,rx,VSID_BITS_##size;	/* extract 2^VSID_BITS bit */	\
-	add	rt,rt,rx;						\
-	rldimi	rf,rt,SLB_VSID_SHIFT_##size,(64 - (SLB_VSID_SHIFT_##size + VSID_BITS_##size)); \
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_68_BIT_VA)
-
-
-/* void slb_allocate(unsigned long ea);
- *
- * Create an SLB entry for the given EA (user or kernel).
- * 	r3 = faulting address, r13 = PACA
- *	r9, r10, r11 are clobbered by this function
- *	r3 is preserved.
- * No other registers are examined or changed.
- */
-_GLOBAL(slb_allocate)
-	/*
-	 * Check if the address falls within the range of the first context, or
-	 * if we may need to handle multi context. For the first context we
-	 * allocate the slb entry via the fast path below. For large address we
-	 * branch out to C-code and see if additional contexts have been
-	 * allocated.
-	 * The test here is:
-	 *   (ea & ~REGION_MASK) >= (1ull << MAX_EA_BITS_PER_CONTEXT)
-	 */
-	rldicr. r9,r3,4,(63 - MAX_EA_BITS_PER_CONTEXT - 4)
-	bne-	8f
-
-	srdi	r9,r3,60		/* get region */
-	srdi	r10,r3,SID_SHIFT	/* get esid */
-	cmpldi	cr7,r9,0xc		/* cmp PAGE_OFFSET for later use */
-
-	/* r3 = address, r10 = esid, cr7 = <> PAGE_OFFSET */
-	blt	cr7,0f			/* user or kernel? */
-
-	/* Check if hitting the linear mapping or some other kernel space
-	*/
-	bne	cr7,1f
-
-	/* Linear mapping encoding bits, the "li" instruction below will
-	 * be patched by the kernel at boot
-	 */
-.globl slb_miss_kernel_load_linear
-slb_miss_kernel_load_linear:
-	li	r11,0
-	/*
-	 * context = (ea >> 60) - (0xc - 1)
-	 * r9 = region id.
-	 */
-	subi	r9,r9,KERNEL_REGION_CONTEXT_OFFSET
-
-BEGIN_FTR_SECTION
-	b	.Lslb_finish_load
-END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
-	b	.Lslb_finish_load_1T
-
-1:
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-	cmpldi	cr0,r9,0xf
-	bne	1f
-/* Check virtual memmap region. To be patched at kernel boot */
-.globl slb_miss_kernel_load_vmemmap
-slb_miss_kernel_load_vmemmap:
-	li	r11,0
-	b	6f
-1:
-#endif /* CONFIG_SPARSEMEM_VMEMMAP */
-
-	/*
-	 * r10 contains the ESID, which is the original faulting EA shifted
-	 * right by 28 bits. We need to compare that with (H_VMALLOC_END >> 28)
-	 * which is 0xd00038000. That can't be used as an immediate, even if we
-	 * ignored the 0xd, so we have to load it into a register, and we only
-	 * have one register free. So we must load all of (H_VMALLOC_END >> 28)
-	 * into a register and compare ESID against that.
-	 */
-	lis	r11,(H_VMALLOC_END >> 32)@h	// r11 = 0xffffffffd0000000
-	ori	r11,r11,(H_VMALLOC_END >> 32)@l	// r11 = 0xffffffffd0003800
-	// Rotate left 4, then mask with 0xffffffff0
-	rldic	r11,r11,4,28			// r11 = 0xd00038000
-	cmpld	r10,r11				// if r10 >= r11
-	bge	5f				//   goto io_mapping
-
-	/*
-	 * vmalloc mapping gets the encoding from the PACA as the mapping
-	 * can be demoted from 64K -> 4K dynamically on some machines.
-	 */
-	lhz	r11,PACAVMALLOCSLLP(r13)
-	b	6f
-5:
-	/* IO mapping */
-.globl slb_miss_kernel_load_io
-slb_miss_kernel_load_io:
-	li	r11,0
-6:
-	/*
-	 * context = (ea >> 60) - (0xc - 1)
-	 * r9 = region id.
-	 */
-	subi	r9,r9,KERNEL_REGION_CONTEXT_OFFSET
-
-BEGIN_FTR_SECTION
-	b	.Lslb_finish_load
-END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
-	b	.Lslb_finish_load_1T
-
-0:	/*
-	 * For userspace addresses, make sure this is region 0.
-	 */
-	cmpdi	r9, 0
-	bne-	8f
-        /*
-         * user space make sure we are within the allowed limit
-	 */
-	ld	r11,PACA_SLB_ADDR_LIMIT(r13)
-	cmpld	r3,r11
-	bge-	8f
-
-	/* when using slices, we extract the psize off the slice bitmaps
-	 * and then we need to get the sllp encoding off the mmu_psize_defs
-	 * array.
-	 *
-	 * XXX This is a bit inefficient especially for the normal case,
-	 * so we should try to implement a fast path for the standard page
-	 * size using the old sllp value so we avoid the array. We cannot
-	 * really do dynamic patching unfortunately as processes might flip
-	 * between 4k and 64k standard page size
-	 */
-#ifdef CONFIG_PPC_MM_SLICES
-	/* r10 have esid */
-	cmpldi	r10,16
-	/* below SLICE_LOW_TOP */
-	blt	5f
-	/*
-	 * Handle hpsizes,
-	 * r9 is get_paca()->context.high_slices_psize[index], r11 is mask_index
-	 */
-	srdi    r11,r10,(SLICE_HIGH_SHIFT - SLICE_LOW_SHIFT + 1) /* index */
-	addi	r9,r11,PACAHIGHSLICEPSIZE
-	lbzx	r9,r13,r9		/* r9 is hpsizes[r11] */
-	/* r11 = (r10 >> (SLICE_HIGH_SHIFT - SLICE_LOW_SHIFT)) & 0x1 */
-	rldicl	r11,r10,(64 - (SLICE_HIGH_SHIFT - SLICE_LOW_SHIFT)),63
-	b	6f
-
-5:
-	/*
-	 * Handle lpsizes
-	 * r9 is get_paca()->context.low_slices_psize[index], r11 is mask_index
-	 */
-	srdi    r11,r10,1 /* index */
-	addi	r9,r11,PACALOWSLICESPSIZE
-	lbzx	r9,r13,r9		/* r9 is lpsizes[r11] */
-	rldicl	r11,r10,0,63		/* r11 = r10 & 0x1 */
-6:
-	sldi	r11,r11,2  /* index * 4 */
-	/* Extract the psize and multiply to get an array offset */
-	srd	r9,r9,r11
-	andi.	r9,r9,0xf
-	mulli	r9,r9,MMUPSIZEDEFSIZE
-
-	/* Now get to the array and obtain the sllp
-	 */
-	ld	r11,PACATOC(r13)
-	ld	r11,mmu_psize_defs@got(r11)
-	add	r11,r11,r9
-	ld	r11,MMUPSIZESLLP(r11)
-	ori	r11,r11,SLB_VSID_USER
-#else
-	/* paca context sllp already contains the SLB_VSID_USER bits */
-	lhz	r11,PACACONTEXTSLLP(r13)
-#endif /* CONFIG_PPC_MM_SLICES */
-
-	ld	r9,PACACONTEXTID(r13)
-BEGIN_FTR_SECTION
-	cmpldi	r10,0x1000
-	bge	.Lslb_finish_load_1T
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	b	.Lslb_finish_load
-
-8:	/* invalid EA - return an error indication */
-	crset	4*cr0+eq		/* indicate failure */
-	blr
-
-/*
- * Finish loading of an SLB entry and return
- *
- * r3 = EA, r9 = context, r10 = ESID, r11 = flags, clobbers r9, cr7 = <> PAGE_OFFSET
- */
-.Lslb_finish_load:
-	rldimi  r10,r9,ESID_BITS,0
-	ASM_VSID_SCRAMBLE(r10,r9,r11,256M)
-	/* r3 = EA, r11 = VSID data */
-	/*
-	 * Find a slot, round robin. Previously we tried to find a
-	 * free slot first but that took too long. Unfortunately we
-	 * dont have any LRU information to help us choose a slot.
-	 */
-
-	mr	r9,r3
-
-	/* slb_finish_load_1T continues here. r9=EA with non-ESID bits clear */
-7:	ld	r10,PACASTABRR(r13)
-	addi	r10,r10,1
-	/* This gets soft patched on boot. */
-.globl slb_compare_rr_to_size
-slb_compare_rr_to_size:
-	cmpldi	r10,0
-
-	blt+	4f
-	li	r10,SLB_NUM_BOLTED
-
-4:
-	std	r10,PACASTABRR(r13)
-
-3:
-	rldimi	r9,r10,0,36		/* r9  = EA[0:35] | entry */
-	oris	r10,r9,SLB_ESID_V@h	/* r10 = r9 | SLB_ESID_V */
-
-	/* r9 = ESID data, r11 = VSID data */
-
-	/*
-	 * No need for an isync before or after this slbmte. The exception
-	 * we enter with and the rfid we exit with are context synchronizing.
-	 */
-	slbmte	r11,r10
-
-	/* we're done for kernel addresses */
-	crclr	4*cr0+eq		/* set result to "success" */
-	bgelr	cr7
-
-	/* Update the slb cache */
-	lhz	r9,PACASLBCACHEPTR(r13)	/* offset = paca->slb_cache_ptr */
-	cmpldi	r9,SLB_CACHE_ENTRIES
-	bge	1f
-
-	/* still room in the slb cache */
-	sldi	r11,r9,2		/* r11 = offset * sizeof(u32) */
-	srdi    r10,r10,28		/* get the 36 bits of the ESID */
-	add	r11,r11,r13		/* r11 = (u32 *)paca + offset */
-	stw	r10,PACASLBCACHE(r11)	/* paca->slb_cache[offset] = esid */
-	addi	r9,r9,1			/* offset++ */
-	b	2f
-1:					/* offset >= SLB_CACHE_ENTRIES */
-	li	r9,SLB_CACHE_ENTRIES+1
-2:
-	sth	r9,PACASLBCACHEPTR(r13)	/* paca->slb_cache_ptr = offset */
-	crclr	4*cr0+eq		/* set result to "success" */
-	blr
-
-/*
- * Finish loading of a 1T SLB entry (for the kernel linear mapping) and return.
- *
- * r3 = EA, r9 = context, r10 = ESID(256MB), r11 = flags, clobbers r9
- */
-.Lslb_finish_load_1T:
-	srdi	r10,r10,(SID_SHIFT_1T - SID_SHIFT)	/* get 1T ESID */
-	rldimi  r10,r9,ESID_BITS_1T,0
-	ASM_VSID_SCRAMBLE(r10,r9,r11,1T)
-
-	li	r10,MMU_SEGSIZE_1T
-	rldimi	r11,r10,SLB_VSID_SSIZE_SHIFT,0	/* insert segment size */
-
-	/* r3 = EA, r11 = VSID data */
-	clrrdi	r9,r3,SID_SHIFT_1T	/* clear out non-ESID bits */
-	b	7b
-
-
-_ASM_NOKPROBE_SYMBOL(slb_allocate)
-_ASM_NOKPROBE_SYMBOL(slb_miss_kernel_load_linear)
-_ASM_NOKPROBE_SYMBOL(slb_miss_kernel_load_io)
-_ASM_NOKPROBE_SYMBOL(slb_compare_rr_to_size)
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-_ASM_NOKPROBE_SYMBOL(slb_miss_kernel_load_vmemmap)
-#endif
-- 
2.17.1

