Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2D740B7BDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 16:00:04 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:52 +1000
Subject: [PATCH 20/20] powerpc: Remaining 64-bit Book3E support
Message-Id: <20090723060004.1EC06DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This contains all the bits that didn't fit in previous patches :-) This
includes the actual exception handlers assembly, the changes to the
kernel entry, other misc bits and wiring it all up in Kconfig.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/Kconfig                   |    2 
 arch/powerpc/include/asm/hw_irq.h      |    5 
 arch/powerpc/include/asm/smp.h         |    1 
 arch/powerpc/kernel/Makefile           |   10 
 arch/powerpc/kernel/cputable.c         |   27 +
 arch/powerpc/kernel/entry_64.S         |   60 ++
 arch/powerpc/kernel/exceptions-64e.S   |  784 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_64.S          |   68 ++
 arch/powerpc/kernel/setup_64.c         |   19 
 arch/powerpc/mm/Makefile               |    1 
 arch/powerpc/platforms/Kconfig.cputype |   38 +
 arch/powerpc/xmon/xmon.c               |    2 
 12 files changed, 993 insertions(+), 24 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/Makefile	2009-07-23 14:24:46.000000000 +1000
+++ linux-work/arch/powerpc/kernel/Makefile	2009-07-23 14:37:31.000000000 +1000
@@ -33,10 +33,10 @@ obj-y				:= cputable.o ptrace.o syscalls
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
-				   paca.o cpu_setup_ppc970.o \
-				   cpu_setup_pa6t.o \
-				   firmware.o nvram_64.o
+				   paca.o nvram_64.o firmware.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
+obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
@@ -63,8 +63,8 @@ obj-$(CONFIG_MODULES)		+= module.o modul
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
 obj-$(CONFIG_FSL_BOOKE)		+= cpu_setup_fsl_booke.o dbell.o
 
-extra-$(CONFIG_PPC_STD_MMU)	:= head_32.o
-extra-$(CONFIG_PPC64)		:= head_64.o
+extra-y				:= head_$(CONFIG_WORD_SIZE).o
+extra-$(CONFIG_PPC_BOOK3E_32)	:= head_new_booke.o
 extra-$(CONFIG_40x)		:= head_40x.o
 extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
Index: linux-work/arch/powerpc/kernel/exceptions-64e.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/kernel/exceptions-64e.S	2009-07-23 14:37:31.000000000 +1000
@@ -0,0 +1,784 @@
+/*
+ *  Boot code and exception vectors for Book3E processors
+ *
+ *  Copyright (C) 2007 Ben. Herrenschmidt (benh@kernel.crashing.org), IBM Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/threads.h>
+#include <asm/reg.h>
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/cputable.h>
+#include <asm/setup.h>
+#include <asm/thread_info.h>
+#include <asm/reg.h>
+#include <asm/exception-64e.h>
+#include <asm/bug.h>
+#include <asm/irqflags.h>
+#include <asm/ptrace.h>
+#include <asm/ppc-opcode.h>
+#include <asm/mmu.h>
+
+/* XXX This will ultimately add space for a special exception save
+ *     structure used to save things like SRR0/SRR1, SPRGs, MAS, etc...
+ *     when taking special interrupts. For now we don't support that,
+ *     special interrupts from within a non-standard level will probably
+ *     blow you up
+ */
+#define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
+
+/* Exception prolog code for all exceptions */
+#define EXCEPTION_PROLOG(n, type, addition)				    \
+	mtspr	SPRN_SPRG_##type##_SCRATCH,r13;	/* get spare registers */   \
+	mfspr	r13,SPRN_SPRG_PACA;	/* get PACA */			    \
+	std	r10,PACA_EX##type+EX_R10(r13);				    \
+	std	r11,PACA_EX##type+EX_R11(r13);				    \
+	mfcr	r10;			/* save CR */			    \
+	addition;			/* additional code for that exc. */ \
+	std	r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */  \
+	stw	r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \
+	mfspr	r11,SPRN_##type##_SRR1;/* what are we coming from */	    \
+	type##_SET_KSTACK;		/* get special stack if necessary */\
+	andi.	r10,r11,MSR_PR;		/* save stack pointer */	    \
+	beq	1f;			/* branch around if supervisor */   \
+	ld	r1,PACAKSAVE(r13);	/* get kernel stack coming from usr */\
+1:	cmpdi	cr1,r1,0;		/* check if SP makes sense */	    \
+	bge-	cr1,exc_##n##_bad_stack;/* bad stack (TODO: out of line) */ \
+	mfspr	r10,SPRN_##type##_SRR0;	/* read SRR0 before touching stack */
+
+/* Exception type-specific macros */
+#define	GEN_SET_KSTACK							    \
+	subi	r1,r1,INT_FRAME_SIZE;	/* alloc frame on kernel stack */
+#define SPRN_GEN_SRR0	SPRN_SRR0
+#define SPRN_GEN_SRR1	SPRN_SRR1
+
+#define CRIT_SET_KSTACK						            \
+	ld	r1,PACA_CRIT_STACK(r13);				    \
+	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+#define SPRN_CRIT_SRR0	SPRN_CSRR0
+#define SPRN_CRIT_SRR1	SPRN_CSRR1
+
+#define DBG_SET_KSTACK						            \
+	ld	r1,PACA_DBG_STACK(r13);					    \
+	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+#define SPRN_DBG_SRR0	SPRN_DSRR0
+#define SPRN_DBG_SRR1	SPRN_DSRR1
+
+#define MC_SET_KSTACK						            \
+	ld	r1,PACA_MC_STACK(r13);					    \
+	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+#define SPRN_MC_SRR0	SPRN_MCSRR0
+#define SPRN_MC_SRR1	SPRN_MCSRR1
+
+#define NORMAL_EXCEPTION_PROLOG(n, addition)				    \
+	EXCEPTION_PROLOG(n, GEN, addition##_GEN)
+
+#define CRIT_EXCEPTION_PROLOG(n, addition)				    \
+	EXCEPTION_PROLOG(n, CRIT, addition##_CRIT)
+
+#define DBG_EXCEPTION_PROLOG(n, addition)				    \
+	EXCEPTION_PROLOG(n, DBG, addition##_DBG)
+
+#define MC_EXCEPTION_PROLOG(n, addition)				    \
+	EXCEPTION_PROLOG(n, MC, addition##_MC)
+
+
+/* Variants of the "addition" argument for the prolog
+ */
+#define PROLOG_ADDITION_NONE_GEN
+#define PROLOG_ADDITION_NONE_CRIT
+#define PROLOG_ADDITION_NONE_DBG
+#define PROLOG_ADDITION_NONE_MC
+
+#define PROLOG_ADDITION_MASKABLE_GEN					    \
+	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
+	cmpwi	cr0,r11,0;		/* yes -> go out of line */	    \
+	beq	masked_interrupt_book3e;
+
+#define PROLOG_ADDITION_2REGS_GEN					    \
+	std	r14,PACA_EXGEN+EX_R14(r13);				    \
+	std	r15,PACA_EXGEN+EX_R15(r13)
+
+#define PROLOG_ADDITION_1REG_GEN					    \
+	std	r14,PACA_EXGEN+EX_R14(r13);
+
+#define PROLOG_ADDITION_2REGS_CRIT					    \
+	std	r14,PACA_EXCRIT+EX_R14(r13);				    \
+	std	r15,PACA_EXCRIT+EX_R15(r13)
+
+#define PROLOG_ADDITION_2REGS_DBG					    \
+	std	r14,PACA_EXDBG+EX_R14(r13);				    \
+	std	r15,PACA_EXDBG+EX_R15(r13)
+
+#define PROLOG_ADDITION_2REGS_MC					    \
+	std	r14,PACA_EXMC+EX_R14(r13);				    \
+	std	r15,PACA_EXMC+EX_R15(r13)
+
+/* Core exception code for all exceptions except TLB misses.
+ * XXX: Needs to make SPRN_SPRG_GEN depend on exception type
+ */
+#define EXCEPTION_COMMON(n, excf, ints)					    \
+	std	r0,GPR0(r1);		/* save r0 in stackframe */	    \
+	std	r2,GPR2(r1);		/* save r2 in stackframe */	    \
+	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe */    \
+	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe */	    \
+	std	r9,GPR9(r1);		/* save r9 in stackframe */	    \
+	std	r10,_NIP(r1);		/* save SRR0 to stackframe */	    \
+	std	r11,_MSR(r1);		/* save SRR1 to stackframe */	    \
+	ACCOUNT_CPU_USER_ENTRY(r10,r11);/* accounting (uses cr0+eq) */	    \
+	ld	r3,excf+EX_R10(r13);	/* get back r10 */		    \
+	ld	r4,excf+EX_R11(r13);	/* get back r11 */		    \
+	mfspr	r5,SPRN_SPRG_GEN_SCRATCH;/* get back r13 */		    \
+	std	r12,GPR12(r1);		/* save r12 in stackframe */	    \
+	ld	r2,PACATOC(r13);	/* get kernel TOC into r2 */	    \
+	mflr	r6;			/* save LR in stackframe */	    \
+	mfctr	r7;			/* save CTR in stackframe */	    \
+	mfspr	r8,SPRN_XER;		/* save XER in stackframe */	    \
+	ld	r9,excf+EX_R1(r13);	/* load orig r1 back from PACA */   \
+	lwz	r10,excf+EX_CR(r13);	/* load orig CR back from PACA	*/  \
+	lbz	r11,PACASOFTIRQEN(r13);	/* get current IRQ softe */	    \
+	ld	r12,exception_marker@toc(r2);				    \
+	li	r0,0;							    \
+	std	r3,GPR10(r1);		/* save r10 to stackframe */	    \
+	std	r4,GPR11(r1);		/* save r11 to stackframe */	    \
+	std	r5,GPR13(r1);		/* save it to stackframe */	    \
+	std	r6,_LINK(r1);						    \
+	std	r7,_CTR(r1);						    \
+	std	r8,_XER(r1);						    \
+	li	r3,(n)+1;		/* indicate partial regs in trap */ \
+	std	r9,0(r1);		/* store stack frame back link */   \
+	std	r10,_CCR(r1);		/* store orig CR in stackframe */   \
+	std	r9,GPR1(r1);		/* store stack frame back link */   \
+	std	r11,SOFTE(r1);		/* and save it to stackframe */     \
+	std	r12,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame */	    \
+	std	r3,_TRAP(r1);		/* set trap number		*/  \
+	std	r0,RESULT(r1);		/* clear regs->result */	    \
+	ints;
+
+/* Variants for the "ints" argument */
+#define INTS_KEEP
+#define INTS_DISABLE_SOFT						    \
+	stb	r0,PACASOFTIRQEN(r13);	/* mark interrupts soft-disabled */ \
+	TRACE_DISABLE_INTS;
+#define INTS_DISABLE_HARD						    \
+	stb	r0,PACAHARDIRQEN(r13); /* and hard disabled */
+#define INTS_DISABLE_ALL						    \
+	INTS_DISABLE_SOFT						    \
+	INTS_DISABLE_HARD
+
+/* This is called by exceptions that used INTS_KEEP (that is did not clear
+ * neither soft nor hard IRQ indicators in the PACA. This will restore MSR:EE
+ * to it's previous value
+ *
+ * XXX In the long run, we may want to open-code it in order to separate the
+ *     load from the wrtee, thus limiting the latency caused by the dependency
+ *     but at this point, I'll favor code clarity until we have a near to final
+ *     implementation
+ */
+#define INTS_RESTORE_HARD						    \
+	ld	r11,_MSR(r1);						    \
+	wrtee	r11;
+
+/* XXX FIXME: Restore r14/r15 when necessary */
+#define BAD_STACK_TRAMPOLINE(n)						    \
+exc_##n##_bad_stack:							    \
+	li	r1,(n);			/* get exception number */	    \
+	sth	r1,PACA_TRAP_SAVE(r13);	/* store trap */		    \
+	b	bad_stack_book3e;	/* bad stack error */
+
+#define	EXCEPTION_STUB(loc, label)					\
+	. = interrupt_base_book3e + loc;				\
+	nop;	/* To make debug interrupts happy */			\
+	b	exc_##label##_book3e;
+
+#define ACK_NONE(r)
+#define ACK_DEC(r)							\
+	lis	r,TSR_DIS@h;						\
+	mtspr	SPRN_TSR,r
+#define ACK_FIT(r)							\
+	lis	r,TSR_FIS@h;						\
+	mtspr	SPRN_TSR,r
+
+#define MASKABLE_EXCEPTION(trapnum, label, hdlr, ack)			\
+	START_EXCEPTION(label);						\
+	NORMAL_EXCEPTION_PROLOG(trapnum, PROLOG_ADDITION_MASKABLE)	\
+	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE_ALL)		\
+	ack(r8);							\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
+	bl	hdlr;							\
+	b	.ret_from_except_lite;
+
+/* This value is used to mark exception frames on the stack. */
+	.section	".toc","aw"
+exception_marker:
+	.tc	ID_EXC_MARKER[TC],STACK_FRAME_REGS_MARKER
+
+
+/*
+ * And here we have the exception vectors !
+ */
+
+	.text
+	.balign	0x1000
+	.globl interrupt_base_book3e
+interrupt_base_book3e:					/* fake trap */
+	/* Note: If real debug exceptions are supported by the HW, the vector
+	 * below will have to be patched up to point to an appropriate handler
+	 */
+	EXCEPTION_STUB(0x000, machine_check)		/* 0x0200 */
+	EXCEPTION_STUB(0x020, critical_input)		/* 0x0580 */
+	EXCEPTION_STUB(0x040, debug_crit)		/* 0x0d00 */
+	EXCEPTION_STUB(0x060, data_storage)		/* 0x0300 */
+	EXCEPTION_STUB(0x080, instruction_storage)	/* 0x0400 */
+	EXCEPTION_STUB(0x0a0, external_input)		/* 0x0500 */
+	EXCEPTION_STUB(0x0c0, alignment)		/* 0x0600 */
+	EXCEPTION_STUB(0x0e0, program)			/* 0x0700 */
+	EXCEPTION_STUB(0x100, fp_unavailable)		/* 0x0800 */
+	EXCEPTION_STUB(0x120, system_call)		/* 0x0c00 */
+	EXCEPTION_STUB(0x140, ap_unavailable)		/* 0x0f20 */
+	EXCEPTION_STUB(0x160, decrementer)		/* 0x0900 */
+	EXCEPTION_STUB(0x180, fixed_interval)		/* 0x0980 */
+	EXCEPTION_STUB(0x1a0, watchdog)			/* 0x09f0 */
+	EXCEPTION_STUB(0x1c0, data_tlb_miss)
+	EXCEPTION_STUB(0x1e0, instruction_tlb_miss)
+
+#if 0
+	EXCEPTION_STUB(0x280, processor_doorbell)
+	EXCEPTION_STUB(0x220, processor_doorbell_crit)
+#endif
+	.globl interrupt_end_book3e
+interrupt_end_book3e:
+
+/* Critical Input Interrupt */
+	START_EXCEPTION(critical_input);
+	CRIT_EXCEPTION_PROLOG(0x100, PROLOG_ADDITION_NONE)
+//	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE_ALL)
+//	bl	special_reg_save_crit
+//	addi	r3,r1,STACK_FRAME_OVERHEAD
+//	bl	.critical_exception
+//	b	ret_from_crit_except
+	b	.
+
+/* Machine Check Interrupt */
+	START_EXCEPTION(machine_check);
+	CRIT_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
+//	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE_ALL)
+//	bl	special_reg_save_mc
+//	addi	r3,r1,STACK_FRAME_OVERHEAD
+//	bl	.machine_check_exception
+//	b	ret_from_mc_except
+	b	.
+
+/* Data Storage Interrupt */
+	START_EXCEPTION(data_storage)
+	NORMAL_EXCEPTION_PROLOG(0x300, PROLOG_ADDITION_2REGS)
+	mfspr	r14,SPRN_DEAR
+	mfspr	r15,SPRN_ESR
+	EXCEPTION_COMMON(0x300, PACA_EXGEN, INTS_KEEP)
+	b	storage_fault_common
+
+/* Instruction Storage Interrupt */
+	START_EXCEPTION(instruction_storage);
+	NORMAL_EXCEPTION_PROLOG(0x400, PROLOG_ADDITION_2REGS)
+	li	r15,0
+	mr	r14,r10
+	EXCEPTION_COMMON(0x400, PACA_EXGEN, INTS_KEEP)
+	b	storage_fault_common
+
+/* External Input Interrupt */
+	MASKABLE_EXCEPTION(0x500, external_input, .do_IRQ, ACK_NONE)
+
+/* Alignment */
+	START_EXCEPTION(alignment);
+	NORMAL_EXCEPTION_PROLOG(0x600, PROLOG_ADDITION_2REGS)
+	mfspr	r14,SPRN_DEAR
+	mfspr	r15,SPRN_ESR
+	EXCEPTION_COMMON(0x600, PACA_EXGEN, INTS_KEEP)
+	b	alignment_more	/* no room, go out of line */
+
+/* Program Interrupt */
+	START_EXCEPTION(program);
+	NORMAL_EXCEPTION_PROLOG(0x700, PROLOG_ADDITION_1REG)
+	mfspr	r14,SPRN_ESR
+	EXCEPTION_COMMON(0x700, PACA_EXGEN, INTS_DISABLE_SOFT)
+	std	r14,_DSISR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	ld	r14,PACA_EXGEN+EX_R14(r13)
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.program_check_exception
+	b	.ret_from_except
+
+/* Floating Point Unavailable Interrupt */
+	START_EXCEPTION(fp_unavailable);
+	NORMAL_EXCEPTION_PROLOG(0x800, PROLOG_ADDITION_NONE)
+	/* we can probably do a shorter exception entry for that one... */
+	EXCEPTION_COMMON(0x800, PACA_EXGEN, INTS_KEEP)
+	bne	1f			/* if from user, just load it up */
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	INTS_RESTORE_HARD
+	bl	.kernel_fp_unavailable_exception
+	BUG_OPCODE
+1:	ld	r12,_MSR(r1)
+	bl	.load_up_fpu
+	b	fast_exception_return
+
+/* Decrementer Interrupt */
+	MASKABLE_EXCEPTION(0x900, decrementer, .timer_interrupt, ACK_DEC)
+
+/* Fixed Interval Timer Interrupt */
+	MASKABLE_EXCEPTION(0x980, fixed_interval, .unknown_exception, ACK_FIT)
+
+/* Watchdog Timer Interrupt */
+	START_EXCEPTION(watchdog);
+	CRIT_EXCEPTION_PROLOG(0x9f0, PROLOG_ADDITION_NONE)
+//	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE_ALL)
+//	bl	special_reg_save_crit
+//	addi	r3,r1,STACK_FRAME_OVERHEAD
+//	bl	.unknown_exception
+//	b	ret_from_crit_except
+	b	.
+
+/* System Call Interrupt */
+	START_EXCEPTION(system_call)
+	mr	r9,r13			/* keep a copy of userland r13 */
+	mfspr	r11,SPRN_SRR0		/* get return address */
+	mfspr	r12,SPRN_SRR1		/* get previous MSR */
+	mfspr	r13,SPRN_SPRG_PACA	/* get our PACA */
+	b	system_call_common
+
+/* Auxillary Processor Unavailable Interrupt */
+	START_EXCEPTION(ap_unavailable);
+	NORMAL_EXCEPTION_PROLOG(0xf20, PROLOG_ADDITION_NONE)
+	EXCEPTION_COMMON(0xf20, PACA_EXGEN, INTS_KEEP)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.unknown_exception
+	b	.ret_from_except
+
+/* Debug exception as a critical interrupt*/
+	START_EXCEPTION(debug_crit);
+	CRIT_EXCEPTION_PROLOG(0xd00, PROLOG_ADDITION_2REGS)
+
+	/*
+	 * If there is a single step or branch-taken exception in an
+	 * exception entry sequence, it was probably meant to apply to
+	 * the code where the exception occurred (since exception entry
+	 * doesn't turn off DE automatically).  We simulate the effect
+	 * of turning off DE on entry to an exception handler by turning
+	 * off DE in the CSRR1 value and clearing the debug status.
+	 */
+
+	mfspr	r14,SPRN_DBSR		/* check single-step/branch taken */
+	andis.	r15,r14,DBSR_IC@h
+	beq+	1f
+
+	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
+	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
+	cmpld	cr0,r10,r14
+	cmpld	cr1,r10,r15
+	blt+	cr0,1f
+	bge+	cr1,1f
+
+	/* here it looks like we got an inappropriate debug exception. */
+	lis	r14,DBSR_IC@h		/* clear the IC event */
+	rlwinm	r11,r11,0,~MSR_DE	/* clear DE in the CSRR1 value */
+	mtspr	SPRN_DBSR,r14
+	mtspr	SPRN_CSRR1,r11
+	lwz	r10,PACA_EXCRIT+EX_CR(r13)	/* restore registers */
+	ld	r1,PACA_EXCRIT+EX_R1(r13)
+	ld	r14,PACA_EXCRIT+EX_R14(r13)
+	ld	r15,PACA_EXCRIT+EX_R15(r13)
+	mtcr	r10
+	ld	r10,PACA_EXCRIT+EX_R10(r13)	/* restore registers */
+	ld	r11,PACA_EXCRIT+EX_R11(r13)
+	mfspr	r13,SPRN_SPRG_CRIT_SCRATCH
+	rfci
+
+	/* Normal debug exception */
+	/* XXX We only handle coming from userspace for now since we can't
+	 *     quite save properly an interrupted kernel state yet
+	 */
+1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
+	beq	kernel_dbg_exc;		/* if from kernel mode */
+
+	/* Now we mash up things to make it look like we are coming on a
+	 * normal exception
+	 */
+	mfspr	r15,SPRN_SPRG_CRIT_SCRATCH
+	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
+	mfspr	r14,SPRN_DBSR
+	EXCEPTION_COMMON(0xd00, PACA_EXCRIT, INTS_DISABLE_ALL)
+	std	r14,_DSISR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	mr	r4,r14
+	ld	r14,PACA_EXCRIT+EX_R14(r13)
+	ld	r15,PACA_EXCRIT+EX_R15(r13)
+	bl	.save_nvgprs
+	bl	.DebugException
+	b	.ret_from_except
+
+kernel_dbg_exc:
+	b	.	/* NYI */
+
+
+/*
+ * An interrupt came in while soft-disabled; clear EE in SRR1,
+ * clear paca->hard_enabled and return.
+ */
+masked_interrupt_book3e:
+	mtcr	r10
+	stb	r11,PACAHARDIRQEN(r13)
+	mfspr	r10,SPRN_SRR1
+	rldicl	r11,r10,48,1		/* clear MSR_EE */
+	rotldi	r10,r11,16
+	mtspr	SPRN_SRR1,r10
+	ld	r10,PACA_EXGEN+EX_R10(r13);	/* restore registers */
+	ld	r11,PACA_EXGEN+EX_R11(r13);
+	mfspr	r13,SPRN_SPRG_GEN_SCRATCH;
+	rfi
+	b	.
+
+/*
+ * This is called from 0x300 and 0x400 handlers after the prologs with
+ * r14 and r15 containing the fault address and error code, with the
+ * original values stashed away in the PACA
+ */
+storage_fault_common:
+	std	r14,_DAR(r1)
+	std	r15,_DSISR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	mr	r4,r14
+	mr	r5,r15
+	ld	r14,PACA_EXGEN+EX_R14(r13)
+	ld	r15,PACA_EXGEN+EX_R15(r13)
+	INTS_RESTORE_HARD
+	bl	.do_page_fault
+	cmpdi	r3,0
+	bne-	1f
+	b	.ret_from_except_lite
+1:	bl	.save_nvgprs
+	mr	r5,r3
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	ld	r4,_DAR(r1)
+	bl	.bad_page_fault
+	b	.ret_from_except
+
+/*
+ * Alignment exception doesn't fit entirely in the 0x100 bytes so it
+ * continues here.
+ */
+alignment_more:
+	std	r14,_DAR(r1)
+	std	r15,_DSISR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	ld	r14,PACA_EXGEN+EX_R14(r13)
+	ld	r15,PACA_EXGEN+EX_R15(r13)
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.alignment_exception
+	b	.ret_from_except
+
+/*
+ * We branch here from entry_64.S for the last stage of the exception
+ * return code path. MSR:EE is expected to be off at that point
+ */
+_GLOBAL(exception_return_book3e)
+	b	1f
+
+/* This is the return from load_up_fpu fast path which could do with
+ * less GPR restores in fact, but for now we have a single return path
+ */
+	.globl fast_exception_return
+fast_exception_return:
+	wrteei	0
+1:	mr	r0,r13
+	ld	r10,_MSR(r1)
+	REST_4GPRS(2, r1)
+	andi.	r6,r10,MSR_PR
+	REST_2GPRS(6, r1)
+	beq	1f
+	ACCOUNT_CPU_USER_EXIT(r10, r11)
+	ld	r0,GPR13(r1)
+
+1:	stdcx.	r0,0,r1		/* to clear the reservation */
+
+	ld	r8,_CCR(r1)
+	ld	r9,_LINK(r1)
+	ld	r10,_CTR(r1)
+	ld	r11,_XER(r1)
+	mtcr	r8
+	mtlr	r9
+	mtctr	r10
+	mtxer	r11
+	REST_2GPRS(8, r1)
+	ld	r10,GPR10(r1)
+	ld	r11,GPR11(r1)
+	ld	r12,GPR12(r1)
+	mtspr	SPRN_SPRG_GEN_SCRATCH,r0
+
+	std	r10,PACA_EXGEN+EX_R10(r13);
+	std	r11,PACA_EXGEN+EX_R11(r13);
+	ld	r10,_NIP(r1)
+	ld	r11,_MSR(r1)
+	ld	r0,GPR0(r1)
+	ld	r1,GPR1(r1)
+	mtspr	SPRN_SRR0,r10
+	mtspr	SPRN_SRR1,r11
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	ld	r11,PACA_EXGEN+EX_R11(r13)
+	mfspr	r13,SPRN_SPRG_GEN_SCRATCH
+	rfi
+
+/*
+ * Trampolines used when spotting a bad kernel stack pointer in
+ * the exception entry code.
+ *
+ * TODO: move some bits like SRR0 read to trampoline, pass PACA
+ * index around, etc... to handle crit & mcheck
+ */
+BAD_STACK_TRAMPOLINE(0x000)
+BAD_STACK_TRAMPOLINE(0x100)
+BAD_STACK_TRAMPOLINE(0x200)
+BAD_STACK_TRAMPOLINE(0x300)
+BAD_STACK_TRAMPOLINE(0x400)
+BAD_STACK_TRAMPOLINE(0x500)
+BAD_STACK_TRAMPOLINE(0x600)
+BAD_STACK_TRAMPOLINE(0x700)
+BAD_STACK_TRAMPOLINE(0x800)
+BAD_STACK_TRAMPOLINE(0x900)
+BAD_STACK_TRAMPOLINE(0x980)
+BAD_STACK_TRAMPOLINE(0x9f0)
+BAD_STACK_TRAMPOLINE(0xa00)
+BAD_STACK_TRAMPOLINE(0xb00)
+BAD_STACK_TRAMPOLINE(0xc00)
+BAD_STACK_TRAMPOLINE(0xd00)
+BAD_STACK_TRAMPOLINE(0xe00)
+BAD_STACK_TRAMPOLINE(0xf00)
+BAD_STACK_TRAMPOLINE(0xf20)
+
+	.globl	bad_stack_book3e
+bad_stack_book3e:
+	/* XXX: Needs to make SPRN_SPRG_GEN depend on exception type */
+	mfspr	r10,SPRN_SRR0;		  /* read SRR0 before touching stack */
+	ld	r1,PACAEMERGSP(r13)
+	subi	r1,r1,64+INT_FRAME_SIZE
+	std	r10,_NIP(r1)
+	std	r11,_MSR(r1)
+	ld	r10,PACA_EXGEN+EX_R1(r13) /* FIXME for crit & mcheck */
+	lwz	r11,PACA_EXGEN+EX_CR(r13) /* FIXME for crit & mcheck */
+	std	r10,GPR1(r1)
+	std	r11,_CCR(r1)
+	mfspr	r10,SPRN_DEAR
+	mfspr	r11,SPRN_ESR
+	std	r10,_DAR(r1)
+	std	r11,_DSISR(r1)
+	std	r0,GPR0(r1);		/* save r0 in stackframe */	    \
+	std	r2,GPR2(r1);		/* save r2 in stackframe */	    \
+	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe */    \
+	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe */	    \
+	std	r9,GPR9(r1);		/* save r9 in stackframe */	    \
+	ld	r3,PACA_EXGEN+EX_R10(r13);/* get back r10 */		    \
+	ld	r4,PACA_EXGEN+EX_R11(r13);/* get back r11 */		    \
+	mfspr	r5,SPRN_SPRG_GEN_SCRATCH;/* get back r13 XXX can be wrong */ \
+	std	r3,GPR10(r1);		/* save r10 to stackframe */	    \
+	std	r4,GPR11(r1);		/* save r11 to stackframe */	    \
+	std	r12,GPR12(r1);		/* save r12 in stackframe */	    \
+	std	r5,GPR13(r1);		/* save it to stackframe */	    \
+	mflr	r10
+	mfctr	r11
+	mfxer	r12
+	std	r10,_LINK(r1)
+	std	r11,_CTR(r1)
+	std	r12,_XER(r1)
+	SAVE_10GPRS(14,r1)
+	SAVE_8GPRS(24,r1)
+	lhz	r12,PACA_TRAP_SAVE(r13)
+	std	r12,_TRAP(r1)
+	addi	r11,r1,INT_FRAME_SIZE
+	std	r11,0(r1)
+	li	r12,0
+	std	r12,0(r11)
+	ld	r2,PACATOC(r13)
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.kernel_bad_stack
+	b	1b
+
+/*
+ * Setup the initial TLB for a core. This current implementation
+ * assume that whatever we are running off will not conflict with
+ * the new mapping at PAGE_OFFSET.
+ * We also make various assumptions about the processor we run on,
+ * this might have to be made more flexible based on the content
+ * of MMUCFG and friends.
+ */
+_GLOBAL(initial_tlb_book3e)
+
+	/* Setup MAS 0,1,2,3 and 7 for tlbwe of a 1G entry that maps the
+	 * kernel linear mapping. We also set MAS8 once for all here though
+	 * that will have to be made dependent on whether we are running under
+	 * a hypervisor I suppose.
+	 */
+	li	r3,MAS0_HES | MAS0_WQ_ALLWAYS
+	mtspr	SPRN_MAS0,r3
+	lis	r3,(MAS1_VALID | MAS1_IPROT)@h
+	ori	r3,r3,BOOK3E_PAGESZ_1GB << MAS1_TSIZE_SHIFT
+	mtspr	SPRN_MAS1,r3
+	LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET | MAS2_M)
+	mtspr	SPRN_MAS2,r3
+	li	r3,MAS3_SR | MAS3_SW | MAS3_SX
+	mtspr	SPRN_MAS7_MAS3,r3
+	li	r3,0
+	mtspr	SPRN_MAS8,r3
+
+	/* Write the TLB entry */
+	tlbwe
+
+	/* Now we branch the new virtual address mapped by this entry */
+	LOAD_REG_IMMEDIATE(r3,1f)
+	mtctr	r3
+	bctr
+
+1:	/* We are now running at PAGE_OFFSET, clean the TLB of everything
+	 * else (XXX we should scan for bolted crap from the firmware too)
+	 */
+	PPC_TLBILX(0,0,0)
+	sync
+	isync
+
+	/* We translate LR and return */
+	mflr	r3
+	tovirt(r3,r3)
+	mtlr	r3
+	blr
+
+/*
+ * Main entry (boot CPU, thread 0)
+ *
+ * We enter here from head_64.S, possibly after the prom_init trampoline
+ * with r3 and r4 already saved to r31 and 30 respectively and in 64 bits
+ * mode. Anything else is as it was left by the bootloader
+ *
+ * Initial requirements of this port:
+ *
+ * - Kernel loaded at 0 physical
+ * - A good lump of memory mapped 0:0 by UTLB entry 0
+ * - MSR:IS & MSR:DS set to 0
+ *
+ * Note that some of the above requirements will be relaxed in the future
+ * as the kernel becomes smarter at dealing with different initial conditions
+ * but for now you have to be careful
+ */
+_GLOBAL(start_initialization_book3e)
+	mflr	r28
+
+	/* First, we need to setup some initial TLBs to map the kernel
+	 * text, data and bss at PAGE_OFFSET. We don't have a real mode
+	 * and always use AS 0, so we just set it up to match our link
+	 * address and never use 0 based addresses.
+	 */
+	bl	.initial_tlb_book3e
+
+	/* Init global core bits */
+	bl	.init_core_book3e
+
+	/* Init per-thread bits */
+	bl	.init_thread_book3e
+
+	/* Return to common init code */
+	tovirt(r28,r28)
+	mtlr	r28
+	blr
+
+
+/*
+ * Secondary core/processor entry
+ *
+ * This is entered for thread 0 of a secondary core, all other threads
+ * are expected to be stopped. It's similar to start_initialization_book3e
+ * except that it's generally entered from the holding loop in head_64.S
+ * after CPUs have been gathered by Open Firmware.
+ *
+ * We assume we are in 32 bits mode running with whatever TLB entry was
+ * set for us by the firmware or POR engine.
+ */
+_GLOBAL(book3e_secondary_core_init_tlb_set)
+	li	r4,1
+	b	.generic_secondary_smp_init
+
+_GLOBAL(book3e_secondary_core_init)
+	mflr	r28
+
+	/* Do we need to setup initial TLB entry ? */
+	cmplwi	r4,0
+	bne	2f
+
+	/* Setup TLB for this core */
+	bl	.initial_tlb_book3e
+
+	/* We can return from the above running at a different
+	 * address, so recalculate r2 (TOC)
+	 */
+	bl	.relative_toc
+
+	/* Init global core bits */
+2:	bl	.init_core_book3e
+
+	/* Init per-thread bits */
+3:	bl	.init_thread_book3e
+
+	/* Return to common init code at proper virtual address.
+	 *
+	 * Due to various previous assumptions, we know we entered this
+	 * function at either the final PAGE_OFFSET mapping or using a
+	 * 1:1 mapping at 0, so we don't bother doing a complicated check
+	 * here, we just ensure the return address has the right top bits.
+	 *
+	 * Note that if we ever want to be smarter about where we can be
+	 * started from, we have to be careful that by the time we reach
+	 * the code below we may already be running at a different location
+	 * than the one we were called from since initial_tlb_book3e can
+	 * have moved us already.
+	 */
+	cmpdi	cr0,r28,0
+	blt	1f
+	lis	r3,PAGE_OFFSET@highest
+	sldi	r3,r3,32
+	or	r28,r28,r3
+1:	mtlr	r28
+	blr
+
+_GLOBAL(book3e_secondary_thread_init)
+	mflr	r28
+	b	3b
+
+_STATIC(init_core_book3e)
+	/* Establish the interrupt vector base */
+	LOAD_REG_IMMEDIATE(r3, interrupt_base_book3e)
+	mtspr	SPRN_IVPR,r3
+	sync
+	blr
+
+_STATIC(init_thread_book3e)
+	lis	r3,(SPRN_EPCR_ICM | SPRN_EPCR_GICM)@h
+	mtspr	SPRN_EPCR,r3
+
+	/* Make sure interrupts are off */
+	wrteei	0
+
+	/* disable watchdog and FIT and enable DEC interrupts */
+	lis	r3,TCR_DIE@h
+	mtspr	SPRN_TCR,r3
+
+	blr
+
+
+
Index: linux-work/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_64.S	2009-07-23 14:24:46.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_64.S	2009-07-23 14:37:31.000000000 +1000
@@ -121,10 +121,11 @@ __run_at_load:
  */
 	.globl	__secondary_hold
 __secondary_hold:
+#ifndef CONFIG_PPC_BOOK3E
 	mfmsr	r24
 	ori	r24,r24,MSR_RI
 	mtmsrd	r24			/* RI on */
-
+#endif
 	/* Grab our physical cpu number */
 	mr	r24,r3
 
@@ -143,6 +144,7 @@ __secondary_hold:
 	ld	r4,0(r4)		/* deref function descriptor */
 	mtctr	r4
 	mr	r3,r24
+	li	r4,0
 	bctr
 #else
 	BUG_OPCODE
@@ -163,21 +165,49 @@ exception_marker:
 #include "exceptions-64s.S"
 #endif
 
+_GLOBAL(generic_secondary_thread_init)
+	mr	r24,r3
+
+	/* turn on 64-bit mode */
+	bl	.enable_64b_mode
+
+	/* get a valid TOC pointer, wherever we're mapped at */
+	bl	.relative_toc
+
+#ifdef CONFIG_PPC_BOOK3E
+	/* Book3E initialization */
+	mr	r3,r24
+	bl	.book3e_secondary_thread_init
+#endif
+	b	generic_secondary_common_init
 
 /*
  * On pSeries and most other platforms, secondary processors spin
  * in the following code.
  * At entry, r3 = this processor's number (physical cpu id)
+ *
+ * On Book3E, r4 = 1 to indicate that the initial TLB entry for
+ * this core already exists (setup via some other mechanism such
+ * as SCOM before entry).
  */
 _GLOBAL(generic_secondary_smp_init)
 	mr	r24,r3
-	
+	mr	r25,r4
+
 	/* turn on 64-bit mode */
 	bl	.enable_64b_mode
 
-	/* get the TOC pointer (real address) */
+	/* get a valid TOC pointer, wherever we're mapped at */
 	bl	.relative_toc
 
+#ifdef CONFIG_PPC_BOOK3E
+	/* Book3E initialization */
+	mr	r3,r24
+	mr	r4,r25
+	bl	.book3e_secondary_core_init
+#endif
+
+generic_secondary_common_init:
 	/* Set up a paca value for this processor. Since we have the
 	 * physical cpu id in r24, we need to search the pacas to find
 	 * which logical id maps to our physical one.
@@ -196,6 +226,11 @@ _GLOBAL(generic_secondary_smp_init)
 	b	.kexec_wait		/* next kernel might do better	 */
 
 2:	mtspr	SPRN_SPRG_PACA,r13	/* Save vaddr of paca in an SPRG */
+#ifdef CONFIG_PPC_BOOK3E
+	addi	r12,r13,PACA_EXTLB	/* and TLB exc frame in another  */
+	mtspr	SPRN_SPRG_TLB_EXFRAME,r12
+#endif
+
 	/* From now on, r24 is expected to be logical cpuid */
 	mr	r24,r5
 3:	HMT_LOW
@@ -231,6 +266,7 @@ _GLOBAL(generic_secondary_smp_init)
  * Turn the MMU off.
  * Assumes we're mapped EA == RA if the MMU is on.
  */
+#ifdef CONFIG_PPC_BOOK3S
 _STATIC(__mmu_off)
 	mfmsr	r3
 	andi.	r0,r3,MSR_IR|MSR_DR
@@ -242,6 +278,7 @@ _STATIC(__mmu_off)
 	sync
 	rfid
 	b	.	/* prevent speculative execution */
+#endif
 
 
 /*
@@ -279,6 +316,10 @@ _GLOBAL(__start_initialization_multiplat
 	mr	r31,r3
 	mr	r30,r4
 
+#ifdef CONFIG_PPC_BOOK3E
+	bl	.start_initialization_book3e
+	b	.__after_prom_start
+#else
 	/* Setup some critical 970 SPRs before switching MMU off */
 	mfspr	r0,SPRN_PVR
 	srwi	r0,r0,16
@@ -296,6 +337,7 @@ _GLOBAL(__start_initialization_multiplat
 	/* Switch off MMU if not already off */
 	bl	.__mmu_off
 	b	.__after_prom_start
+#endif /* CONFIG_PPC_BOOK3E */
 
 _INIT_STATIC(__boot_from_prom)
 #ifdef CONFIG_PPC_OF_BOOT_TRAMPOLINE
@@ -358,10 +400,16 @@ _STATIC(__after_prom_start)
  * Note: This process overwrites the OF exception vectors.
  */
 	li	r3,0			/* target addr */
+#ifdef CONFIG_PPC_BOOK3E
+	tovirt(r3,r3)			/* on booke, we already run at PAGE_OFFSET */
+#endif
 	mr.	r4,r26			/* In some cases the loader may  */
 	beq	9f			/* have already put us at zero */
 	li	r6,0x100		/* Start offset, the first 0x100 */
 					/* bytes were copied earlier.	 */
+#ifdef CONFIG_PPC_BOOK3E
+	tovirt(r6,r6)			/* on booke, we already run at PAGE_OFFSET */
+#endif
 
 #ifdef CONFIG_CRASH_DUMP
 /*
@@ -507,6 +555,9 @@ _GLOBAL(pmac_secondary_start)
  *   r13       = paca virtual address
  *   SPRG_PACA = paca virtual address
  */
+	.section ".text";
+	.align 2 ;
+
 	.globl	__secondary_start
 __secondary_start:
 	/* Set thread priority to MEDIUM */
@@ -543,7 +594,7 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISER
 
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
-	rfid
+	RFI
 	b	.	/* prevent speculative execution */
 
 /* 
@@ -564,11 +615,16 @@ _GLOBAL(start_secondary_prolog)
  */
 _GLOBAL(enable_64b_mode)
 	mfmsr	r11			/* grab the current MSR */
+#ifdef CONFIG_PPC_BOOK3E
+	oris	r11,r11,0x8000		/* CM bit set, we'll set ICM later */
+	mtmsr	r11
+#else /* CONFIG_PPC_BOOK3E */
 	li	r12,(MSR_SF | MSR_ISF)@highest
 	sldi	r12,r12,48
 	or	r11,r11,r12
 	mtmsrd	r11
 	isync
+#endif
 	blr
 
 /*
@@ -612,9 +668,11 @@ _INIT_STATIC(start_here_multiplatform)
 	bdnz	3b
 4:
 
+#ifndef CONFIG_PPC_BOOK3E
 	mfmsr	r6
 	ori	r6,r6,MSR_RI
 	mtmsrd	r6			/* RI on */
+#endif
 
 #ifdef CONFIG_RELOCATABLE
 	/* Save the physical address we're running at in kernstart_addr */
@@ -647,7 +705,7 @@ _INIT_STATIC(start_here_multiplatform)
 	ld	r4,PACAKMSR(r13)
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
-	rfid
+	RFI
 	b	.	/* prevent speculative execution */
 	
 	/* This is where all platforms converge execution */
Index: linux-work/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/entry_64.S	2009-07-23 14:24:46.000000000 +1000
+++ linux-work/arch/powerpc/kernel/entry_64.S	2009-07-23 14:37:31.000000000 +1000
@@ -120,9 +120,15 @@ BEGIN_FW_FTR_SECTION
 2:
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif /* CONFIG_PPC_ISERIES */
+
+	/* Hard enable interrupts */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	1
+#else
 	mfmsr	r11
 	ori	r11,r11,MSR_EE
 	mtmsrd	r11,1
+#endif /* CONFIG_PPC_BOOK3E */
 
 #ifdef SHOW_SYSCALLS
 	bl	.do_show_syscall
@@ -168,15 +174,25 @@ syscall_exit:
 #endif
 	clrrdi	r12,r1,THREAD_SHIFT
 
-	/* disable interrupts so current_thread_info()->flags can't change,
-	   and so that we don't get interrupted after loading SRR0/1. */
 	ld	r8,_MSR(r1)
+#ifdef CONFIG_PPC_BOOK3S
+	/* No MSR:RI on BookE */
 	andi.	r10,r8,MSR_RI
 	beq-	unrecov_restore
+#endif
+
+	/* Disable interrupts so current_thread_info()->flags can't change,
+	 * and so that we don't get interrupted after loading SRR0/1.
+	 */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	0
+#else
 	mfmsr	r10
 	rldicl	r10,r10,48,1
 	rotldi	r10,r10,16
 	mtmsrd	r10,1
+#endif /* CONFIG_PPC_BOOK3E */
+
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-_LAST_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
@@ -194,9 +210,13 @@ syscall_error_cont:
 	 * userspace and we take an exception after restoring r13,
 	 * we end up corrupting the userspace r13 value.
 	 */
+#ifdef CONFIG_PPC_BOOK3S
+	/* No MSR:RI on BookE */
 	li	r12,MSR_RI
 	andc	r11,r10,r12
 	mtmsrd	r11,1			/* clear MSR.RI */
+#endif /* CONFIG_PPC_BOOK3S */
+
 	beq-	1f
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
@@ -206,7 +226,7 @@ syscall_error_cont:
 	mtcr	r5
 	mtspr	SPRN_SRR0,r7
 	mtspr	SPRN_SRR1,r8
-	rfid
+	RFI
 	b	.	/* prevent speculative execution */
 
 syscall_error:	
@@ -276,9 +296,13 @@ syscall_exit_work:
 	beq	.ret_from_except_lite
 
 	/* Re-enable interrupts */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	1
+#else
 	mfmsr	r10
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1
+#endif /* CONFIG_PPC_BOOK3E */
 
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -380,7 +404,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	and.	r0,r0,r22
 	beq+	1f
 	andc	r22,r22,r0
-	mtmsrd	r22
+	MTMSRD(r22)
 	isync
 1:	std	r20,_NIP(r1)
 	mfcr	r23
@@ -399,6 +423,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	std	r6,PACACURRENT(r13)	/* Set new 'current' */
 
 	ld	r8,KSP(r4)	/* new stack pointer */
+#ifdef CONFIG_PPC_BOOK3S
 BEGIN_FTR_SECTION
   BEGIN_FTR_SECTION_NESTED(95)
 	clrrdi	r6,r8,28	/* get its ESID */
@@ -445,8 +470,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT
 	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
 	slbmte	r7,r0
 	isync
-
 2:
+#endif /* !CONFIG_PPC_BOOK3S */
+
 	clrrdi	r7,r8,THREAD_SHIFT	/* base of new stack */
 	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
 	   because we don't need to leave the 288-byte ABI gap at the
@@ -490,10 +516,14 @@ _GLOBAL(ret_from_except_lite)
 	 * can't change between when we test it and when we return
 	 * from the interrupt.
 	 */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	0
+#else
 	mfmsr	r10		/* Get current interrupt state */
 	rldicl	r9,r10,48,1	/* clear MSR_EE */
 	rotldi	r9,r9,16
 	mtmsrd	r9,1		/* Update machine state */
+#endif /* CONFIG_PPC_BOOK3E */
 
 #ifdef CONFIG_PREEMPT
 	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
@@ -540,6 +570,9 @@ ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_
 	rldicl	r4,r3,49,63		/* r0 = (r3 >> 15) & 1 */
 	stb	r4,PACAHARDIRQEN(r13)
 
+#ifdef CONFIG_PPC_BOOK3E
+	b	.exception_return_book3e
+#else
 	ld	r4,_CTR(r1)
 	ld	r0,_LINK(r1)
 	mtctr	r4
@@ -588,6 +621,8 @@ ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_
 	rfid
 	b	.	/* prevent speculative execution */
 
+#endif /* CONFIG_PPC_BOOK3E */
+
 iseries_check_pending_irqs:
 #ifdef CONFIG_PPC_ISERIES
 	ld	r5,SOFTE(r1)
@@ -638,6 +673,11 @@ do_work:
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13)
 	stb	r0,PACAHARDIRQEN(r13)
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	1
+	bl	.preempt_schedule
+	wrteei	0
+#else
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1		/* reenable interrupts */
 	bl	.preempt_schedule
@@ -646,6 +686,7 @@ do_work:
 	rldicl	r10,r10,48,1	/* disable interrupts again */
 	rotldi	r10,r10,16
 	mtmsrd	r10,1
+#endif /* CONFIG_PPC_BOOK3E */
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne	1b
@@ -654,8 +695,12 @@ do_work:
 user_work:
 #endif
 	/* Enable interrupts */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	1
+#else
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1
+#endif /* CONFIG_PPC_BOOK3E */
 
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	1f
@@ -837,6 +882,10 @@ _GLOBAL(enter_prom)
 
 	/* Switch MSR to 32 bits mode
 	 */
+#ifdef CONFIG_PPC_BOOK3E
+	rlwinm	r11,r11,0,1,31
+	mtmsr	r11
+#else /* CONFIG_PPC_BOOK3E */
         mfmsr   r11
         li      r12,1
         rldicr  r12,r12,MSR_SF_LG,(63-MSR_SF_LG)
@@ -845,6 +894,7 @@ _GLOBAL(enter_prom)
         rldicr  r12,r12,MSR_ISF_LG,(63-MSR_ISF_LG)
         andc    r11,r11,r12
         mtmsrd  r11
+#endif /* CONFIG_PPC_BOOK3E */
         isync
 
 	/* Enter PROM here... */
Index: linux-work/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cputable.c	2009-07-23 14:24:46.000000000 +1000
+++ linux-work/arch/powerpc/kernel/cputable.c	2009-07-23 14:37:31.000000000 +1000
@@ -93,7 +93,7 @@ extern void __restore_cpu_power7(void);
 				 PPC_FEATURE_BOOKE)
 
 static struct cpu_spec __initdata cpu_specs[] = {
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_BOOK3S_64
 	{	/* Power3 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00400000,
@@ -508,7 +508,30 @@ static struct cpu_spec __initdata cpu_sp
 		.machine_check		= machine_check_generic,
 		.platform		= "power4",
 	}
-#endif	/* CONFIG_PPC64 */
+#endif	/* CONFIG_PPC_BOOK3S_64 */
+#ifdef CONFIG_PPC_BOOK3E_64
+	{	/* This is a default entry to get going, to be replaced by
+		 * a real one at some stage
+		 */
+#define CPU_FTRS_BASE_BOOK3E	(CPU_FTR_USE_TB | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_SMT | \
+	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
+		.pvr_mask		= 0x00000000,
+		.pvr_value		= 0x00000000,
+		.cpu_name		= "Book3E",
+		.cpu_features		= CPU_FTRS_BASE_BOOK3E,
+		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_TYPE_3E | MMU_FTR_USE_TLBILX |
+					  MMU_FTR_USE_TLBIVAX_BCAST |
+					  MMU_FTR_LOCK_BCAST_INVAL,
+		.icache_bsize		= 64,
+		.dcache_bsize		= 64,
+		.num_pmcs		= 0,
+		.machine_check		= machine_check_generic,
+		.platform		= "power6",
+	},
+#endif
+
 #ifdef CONFIG_PPC32
 #if CLASSIC_PPC
 	{	/* 601 */
Index: linux-work/arch/powerpc/mm/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/mm/Makefile	2009-07-23 14:24:46.000000000 +1000
+++ linux-work/arch/powerpc/mm/Makefile	2009-07-23 14:37:31.000000000 +1000
@@ -13,6 +13,7 @@ obj-y				:= fault.o mem.o pgtable.o gup.
 				   pgtable_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
+obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(CONFIG_WORD_SIZE)e.o
 obj-$(CONFIG_PPC64)		+= mmap_64.o
 hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_STD_MMU_64)	+= hash_utils_64.o \
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2009-07-23 14:35:39.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2009-07-23 14:37:31.000000000 +1000
@@ -454,6 +454,24 @@ static void __init irqstack_early_init(v
 #define irqstack_early_init()
 #endif
 
+#ifdef CONFIG_PPC_BOOK3E
+static void __init exc_lvl_early_init(void)
+{
+	unsigned int i;
+
+	for_each_possible_cpu(i) {
+		critirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
+		dbgirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
+		mcheckirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
+	}
+}
+#else
+#define exc_lvl_early_init()
+#endif
+
 /*
  * Stack space used when we detect a bad kernel stack pointer, and
  * early in SMP boots before relocation is enabled.
@@ -513,6 +531,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = klimit;
 	
 	irqstack_early_init();
+	exc_lvl_early_init();
 	emergency_stack_init();
 
 #ifdef CONFIG_PPC_STD_MMU_64
Index: linux-work/arch/powerpc/include/asm/hw_irq.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/hw_irq.h	2009-07-23 14:24:47.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/hw_irq.h	2009-07-23 14:37:31.000000000 +1000
@@ -49,8 +49,13 @@ extern void iseries_handle_interrupts(vo
 #define raw_irqs_disabled()		(local_get_flags() == 0)
 #define raw_irqs_disabled_flags(flags)	((flags) == 0)
 
+#ifdef CONFIG_PPC_BOOK3E
+#define __hard_irq_enable()	__asm__ __volatile__("wrteei 1": : :"memory");
+#define __hard_irq_disable()	__asm__ __volatile__("wrteei 0": : :"memory");
+#else
 #define __hard_irq_enable()	__mtmsrd(mfmsr() | MSR_EE, 1)
 #define __hard_irq_disable()	__mtmsrd(mfmsr() & ~MSR_EE, 1)
+#endif
 
 #define  hard_irq_disable()			\
 	do {					\
Index: linux-work/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-work.orig/arch/powerpc/xmon/xmon.c	2009-07-23 14:24:47.000000000 +1000
+++ linux-work/arch/powerpc/xmon/xmon.c	2009-07-23 14:37:31.000000000 +1000
@@ -2570,7 +2570,7 @@ static void xmon_print_symbol(unsigned l
 	printf("%s", after);
 }
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_BOOK3S_64
 static void dump_slb(void)
 {
 	int i;
Index: linux-work/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-work.orig/arch/powerpc/platforms/Kconfig.cputype	2009-07-23 14:24:47.000000000 +1000
+++ linux-work/arch/powerpc/platforms/Kconfig.cputype	2009-07-23 14:37:31.000000000 +1000
@@ -57,15 +57,35 @@ config E200
 
 endchoice
 
-config PPC_BOOK3S_64
-	def_bool y
+choice
+	prompt "Processor Type"
 	depends on PPC64
+	help
+	  There are two families of 64 bit PowerPC chips supported.
+	  The most common ones are the desktop and server CPUs
+	  (POWER3, RS64, POWER4, POWER5, POWER5+, POWER6, ...)
+
+	  The other are the "embedded" processors compliant with the
+	  "Book 3E" variant of the architecture
+
+config PPC_BOOK3S_64
+	bool "Server processors"
 	select PPC_FPU
 
+config PPC_BOOK3E_64
+	bool "Embedded processors"
+	select PPC_FPU # Make it a choice ?
+
+endchoice
+
 config PPC_BOOK3S
 	def_bool y
 	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64
 
+config PPC_BOOK3E
+	def_bool y
+	depends on PPC_BOOK3E_64
+
 config POWER4_ONLY
 	bool "Optimize for POWER4"
 	depends on PPC64 && PPC_BOOK3S
@@ -125,7 +145,7 @@ config 4xx
 
 config BOOKE
 	bool
-	depends on E200 || E500 || 44x
+	depends on E200 || E500 || 44x || PPC_BOOK3E
 	default y
 
 config FSL_BOOKE
@@ -223,9 +243,17 @@ config PPC_MMU_NOHASH
 	def_bool y
 	depends on !PPC_STD_MMU
 
+config PPC_MMU_NOHASH_32
+	def_bool y
+	depends on PPC_MMU_NOHASH && PPC32
+
+config PPC_MMU_NOHASH_64
+	def_bool y
+	depends on PPC_MMU_NOHASH && PPC64
+
 config PPC_BOOK3E_MMU
 	def_bool y
-	depends on FSL_BOOKE
+	depends on FSL_BOOKE || PPC_BOOK3E
 
 config PPC_MM_SLICES
 	bool
@@ -257,7 +285,7 @@ config PPC_PERF_CTRS
          This enables the powerpc-specific perf_counter back-end.
 
 config SMP
-	depends on PPC_STD_MMU || FSL_BOOKE
+	depends on PPC_BOOK3S || PPC_BOOK3E || FSL_BOOKE
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
Index: linux-work/arch/powerpc/include/asm/smp.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/smp.h	2009-07-23 14:24:47.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/smp.h	2009-07-23 14:37:31.000000000 +1000
@@ -149,6 +149,7 @@ extern void arch_send_call_function_sing
 extern void arch_send_call_function_ipi(cpumask_t mask);
 
 #ifdef CONFIG_PPC64
+extern void generic_secondary_thread_init(void);
 extern void generic_secondary_smp_init(void);
 extern unsigned long __secondary_hold_spinloop;
 #endif /* CONFIG_PPC64 */
Index: linux-work/arch/powerpc/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/Kconfig	2009-07-23 14:24:47.000000000 +1000
+++ linux-work/arch/powerpc/Kconfig	2009-07-23 14:37:31.000000000 +1000
@@ -472,7 +472,7 @@ config PPC_16K_PAGES
 	bool "16k page size" if 44x
 
 config PPC_64K_PAGES
-	bool "64k page size" if 44x || PPC_STD_MMU_64
+	bool "64k page size" if 44x || PPC_STD_MMU_64 || PPC_BOOK3E_64
 	select PPC_HAS_HASH_64K if PPC_STD_MMU_64
 
 config PPC_256K_PAGES
