Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14B2DB6FA8
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2012 13:52:42 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Mon, 5 Mar 2012 02:44:40 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q252qQh2229474
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:33 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q252qQ64015878
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:26 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/13] powerpc: Call do_page_fault() with interrupts off
Date: Mon,  5 Mar 2012 13:51:25 +1100
Message-Id: <1330915891-19523-8-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
References: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently turn interrupts back to their previous state before
calling do_page_fault(). This can be annoying when debugging as
a bad fault will potentially have lost some processor state before
getting into the debugger.

We also end up calling some generic code with interrupts enabled
such as notify_page_fault() with interrupts enabled, which could
be unexpected.

This changes our code to behave more like other architectures,
and make the assembly entry code call into do_page_faults() with
interrupts disabled. They are conditionally re-enabled from
within do_page_fault() in the same spot x86 does it.

While there, add the might_sleep() test in the case of a successful
trylock of the mmap semaphore, again like x86.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/hw_irq.h    |   10 +++++
 arch/powerpc/kernel/exceptions-64e.S |    5 +--
 arch/powerpc/kernel/exceptions-64s.S |   61 ++++++++++-----------------------
 arch/powerpc/kernel/head_32.S        |    4 +-
 arch/powerpc/kernel/head_40x.S       |    4 +-
 arch/powerpc/kernel/head_8xx.S       |    4 +-
 arch/powerpc/kernel/head_booke.h     |    4 +-
 arch/powerpc/kernel/head_fsl_booke.S |    2 +-
 arch/powerpc/mm/fault.c              |   11 ++++++
 9 files changed, 51 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index bb712c9..531ba00 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -79,6 +79,11 @@ static inline bool arch_irqs_disabled(void)
 		get_paca()->hard_enabled = 0;	\
 	} while(0)
 
+static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
+{
+	return !regs->softe;
+}
+
 #else /* CONFIG_PPC64 */
 
 #define SET_MSR_EE(x)	mtmsr(x)
@@ -139,6 +144,11 @@ static inline bool arch_irqs_disabled(void)
 
 #define hard_irq_disable()		arch_local_irq_disable()
 
+static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
+{
+	return !(regs->msr & MSR_EE);
+}
+
 #endif /* CONFIG_PPC64 */
 
 #define ARCH_IRQ_INIT_FLAGS	IRQ_NOREQUEST
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 7098302..3de9993 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -313,7 +313,7 @@ interrupt_end_book3e:
 	NORMAL_EXCEPTION_PROLOG(0x300, PROLOG_ADDITION_2REGS)
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
-	EXCEPTION_COMMON(0x300, PACA_EXGEN, INTS_KEEP)
+	EXCEPTION_COMMON(0x300, PACA_EXGEN, INTS_DISABLE_ALL)
 	b	storage_fault_common
 
 /* Instruction Storage Interrupt */
@@ -321,7 +321,7 @@ interrupt_end_book3e:
 	NORMAL_EXCEPTION_PROLOG(0x400, PROLOG_ADDITION_2REGS)
 	li	r15,0
 	mr	r14,r10
-	EXCEPTION_COMMON(0x400, PACA_EXGEN, INTS_KEEP)
+	EXCEPTION_COMMON(0x400, PACA_EXGEN, INTS_DISABLE_ALL)
 	b	storage_fault_common
 
 /* External Input Interrupt */
@@ -590,7 +590,6 @@ storage_fault_common:
 	mr	r5,r15
 	ld	r14,PACA_EXGEN+EX_R14(r13)
 	ld	r15,PACA_EXGEN+EX_R15(r13)
-	INTS_RESTORE_HARD
 	bl	.do_page_fault
 	cmpdi	r3,0
 	bne-	1f
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index bd30fc2..bd7130c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -559,6 +559,7 @@ data_access_common:
 	mfspr	r10,SPRN_DSISR
 	stw	r10,PACA_EXGEN+EX_DSISR(r13)
 	EXCEPTION_PROLOG_COMMON(0x300, PACA_EXGEN)
+	DISABLE_INTS
 	ld	r3,PACA_EXGEN+EX_DAR(r13)
 	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
 	li	r5,0x300
@@ -573,6 +574,7 @@ h_data_storage_common:
         stw     r10,PACA_EXGEN+EX_DSISR(r13)
         EXCEPTION_PROLOG_COMMON(0xe00, PACA_EXGEN)
         bl      .save_nvgprs
+	DISABLE_INTS
         addi    r3,r1,STACK_FRAME_OVERHEAD
         bl      .unknown_exception
         b       .ret_from_except
@@ -581,6 +583,11 @@ h_data_storage_common:
 	.globl instruction_access_common
 instruction_access_common:
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
+	DISABLE_INTS
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* Restore r12 clobbered by DISABLE_INTS */
+	ld	r12,_MSR(r1)
+#endif
 	ld	r3,_NIP(r1)
 	andis.	r4,r12,0x5820
 	li	r5,0x400
@@ -884,24 +891,6 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
 	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
 	bne	77f			/* then don't call hash_page now */
-
-	/* We run with interrupts both soft and hard disabled */
-	DISABLE_INTS
-
-	/*
-	 * Currently, trace_hardirqs_off() will be called by DISABLE_INTS
-	 * and will clobber volatile registers when irq tracing is enabled
-	 * so we need to reload them. It may be possible to be smarter here
-	 * and move the irq tracing elsewhere but let's keep it simple for
-	 * now
-	 */
-#ifdef CONFIG_TRACE_IRQFLAGS
-	ld	r3,_DAR(r1)
-	ld	r4,_DSISR(r1)
-	ld	r5,_TRAP(r1)
-	ld	r12,_MSR(r1)
-	clrrdi	r5,r5,4
-#endif /* CONFIG_TRACE_IRQFLAGS */
 	/*
 	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
 	 * accessing a userspace segment (even from the kernel). We assume
@@ -931,36 +920,16 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 	beq	fast_exc_return_irq	/* Return from exception on success */
 
 	/* For a hash failure, we don't bother re-enabling interrupts */
-	ble-	12f
-
-	/*
-	 * hash_page couldn't handle it, set soft interrupt enable back
-	 * to what it was before the trap.  Note that .arch_local_irq_restore
-	 * handles any interrupts pending at this point.
-	 */
-	ld	r3,SOFTE(r1)
-	TRACE_AND_RESTORE_IRQ_PARTIAL(r3, 11f)
-	bl	.arch_local_irq_restore
-	b	11f
-
-/* We have a data breakpoint exception - handle it */
-handle_dabr_fault:
-	bl	.save_nvgprs
-	ld      r4,_DAR(r1)
-	ld      r5,_DSISR(r1)
-	addi    r3,r1,STACK_FRAME_OVERHEAD
-	bl      .do_dabr
-	b       .ret_from_except_lite
+	ble-	13f
 
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:
-	ENABLE_INTS
 11:	ld	r4,_DAR(r1)
 	ld	r5,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_page_fault
 	cmpdi	r3,0
-	beq+	13f
+	beq+	12f
 	bl	.save_nvgprs
 	mr	r5,r3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -968,12 +937,20 @@ handle_page_fault:
 	bl	.bad_page_fault
 	b	.ret_from_except
 
-13:	b	.ret_from_except_lite
+/* We have a data breakpoint exception - handle it */
+handle_dabr_fault:
+	bl	.save_nvgprs
+	ld      r4,_DAR(r1)
+	ld      r5,_DSISR(r1)
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	bl      .do_dabr
+12:	b       .ret_from_except_lite
+
 
 /* We have a page fault that hash_page could handle but HV refused
  * the PTE insertion
  */
-12:	bl	.save_nvgprs
+13:	bl	.save_nvgprs
 	mr	r5,r3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ld	r4,_DAR(r1)
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 0654dba..dc0488b 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -395,7 +395,7 @@ DataAccess:
 	bl	hash_page
 1:	lwz	r5,_DSISR(r11)		/* get DSISR value */
 	mfspr	r4,SPRN_DAR
-	EXC_XFER_EE_LITE(0x300, handle_page_fault)
+	EXC_XFER_LITE(0x300, handle_page_fault)
 
 
 /* Instruction access exception. */
@@ -410,7 +410,7 @@ InstructionAccess:
 	bl	hash_page
 1:	mr	r4,r12
 	mr	r5,r9
-	EXC_XFER_EE_LITE(0x400, handle_page_fault)
+	EXC_XFER_LITE(0x400, handle_page_fault)
 
 /* External interrupt */
 	EXCEPTION(0x500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 872a6af..4989661 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -394,7 +394,7 @@ label:
 	NORMAL_EXCEPTION_PROLOG
 	mr	r4,r12			/* Pass SRR0 as arg2 */
 	li	r5,0			/* Pass zero as arg3 */
-	EXC_XFER_EE_LITE(0x400, handle_page_fault)
+	EXC_XFER_LITE(0x400, handle_page_fault)
 
 /* 0x0500 - External Interrupt Exception */
 	EXCEPTION(0x0500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)
@@ -747,7 +747,7 @@ DataAccess:
 	mfspr	r5,SPRN_ESR		/* Grab the ESR, save it, pass arg3 */
 	stw	r5,_ESR(r11)
 	mfspr	r4,SPRN_DEAR		/* Grab the DEAR, save it, pass arg2 */
-	EXC_XFER_EE_LITE(0x300, handle_page_fault)
+	EXC_XFER_LITE(0x300, handle_page_fault)
 
 /* Other PowerPC processors, namely those derived from the 6xx-series
  * have vectors from 0x2100 through 0x2F00 defined, but marked as reserved.
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index b68cb17..b2a5860 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -220,7 +220,7 @@ DataAccess:
 	mfspr	r4,SPRN_DAR
 	li	r10,0x00f0
 	mtspr	SPRN_DAR,r10	/* Tag DAR, to be used in DTLB Error */
-	EXC_XFER_EE_LITE(0x300, handle_page_fault)
+	EXC_XFER_LITE(0x300, handle_page_fault)
 
 /* Instruction access exception.
  * This is "never generated" by the MPC8xx.  We jump to it for other
@@ -231,7 +231,7 @@ InstructionAccess:
 	EXCEPTION_PROLOG
 	mr	r4,r12
 	mr	r5,r9
-	EXC_XFER_EE_LITE(0x400, handle_page_fault)
+	EXC_XFER_LITE(0x400, handle_page_fault)
 
 /* External interrupt */
 	EXCEPTION(0x500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index fc921bf..0e41753 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -359,7 +359,7 @@ label:
 	mfspr	r5,SPRN_ESR;		/* Grab the ESR and save it */	      \
 	stw	r5,_ESR(r11);						      \
 	mfspr	r4,SPRN_DEAR;		/* Grab the DEAR */		      \
-	EXC_XFER_EE_LITE(0x0300, handle_page_fault)
+	EXC_XFER_LITE(0x0300, handle_page_fault)
 
 #define INSTRUCTION_STORAGE_EXCEPTION					      \
 	START_EXCEPTION(InstructionStorage)				      \
@@ -368,7 +368,7 @@ label:
 	stw	r5,_ESR(r11);						      \
 	mr      r4,r12;                 /* Pass SRR0 as arg2 */		      \
 	li      r5,0;                   /* Pass zero as arg3 */		      \
-	EXC_XFER_EE_LITE(0x0400, handle_page_fault)
+	EXC_XFER_LITE(0x0400, handle_page_fault)
 
 #define ALIGNMENT_EXCEPTION						      \
 	START_EXCEPTION(Alignment)					      \
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index d5d78c4..28e6259 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -319,7 +319,7 @@ interrupt_base:
 	mfspr	r4,SPRN_DEAR		/* Grab the DEAR, save it, pass arg2 */
 	andis.	r10,r5,(ESR_ILK|ESR_DLK)@h
 	bne	1f
-	EXC_XFER_EE_LITE(0x0300, handle_page_fault)
+	EXC_XFER_LITE(0x0300, handle_page_fault)
 1:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0x0300, CacheLockingException)
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 2f0d1b0..7e89006 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -179,6 +179,10 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 #endif
 
+	/* We restore the interrupt state now */
+	if (!arch_irq_disabled_regs(regs))
+		local_irq_enable();
+
 	if (in_atomic() || mm == NULL) {
 		if (!user_mode(regs))
 			return SIGSEGV;
@@ -213,6 +217,13 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 			goto bad_area_nosemaphore;
 
 		down_read(&mm->mmap_sem);
+	} else {
+		/*
+		 * The above down_read_trylock() might have succeeded in
+		 * which case we'll have missed the might_sleep() from
+		 * down_read():
+		 */
+		might_sleep();
 	}
 
 	vma = find_vma(mm, address);
-- 
1.7.9
