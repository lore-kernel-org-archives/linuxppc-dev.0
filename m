Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DD6C6104792
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2012 15:34:55 +1100 (EST)
Message-ID: <1328243666.19800.4.camel@pasglop>
Subject: [PATCH] powerpc: Rework lazy-interrupt handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 03 Feb 2012 15:34:26 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Anton Blanchard <anton@au1.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current implementation of lazy interrupts handling has some
issues that this tries to address.

Except on iSeries, we don't do the various workarounds we need to
do on re-enable when returning from an interrupt, which can do an
implicit re-enable, and thus we may still lose or get delayed
decrementer or doorbell interrupts.

The current scheme also makes it much harder to handle the external
"edge" interrupts provided by some BookE processors when using the
EPR facility (External Proxy) and the Freescale Hypervisor.

We also hard mask on decrementer interrupts which is sub-optimal.

This is an attempt at fixing it all in one go by reworking the way
we do the lazy interrupt disabling.

The base idea is to replace the "hard_enabled" field with a
"irq_happened" field in which we store a bit mask of what interrupt
occurred while soft-disabled.

When re-enabling, either via arch_local_irq_restore() or when returning
from an interrupt, we can now decide what to do by testing bits in that
field. We then implement re-emitting of the lost interrupts via either
a re-use of the existing exception frame (exception exit case) or via
the creation of a new one from assembly code (arch_local_irq_enable),
without the need to trigger a fake one using set_dec() or similar.

In addition, we no longer hard disable decrementer interrupts that occur
while soft-disabled. We now simply bump the decrementer back to max
(on BookS) or leave it stopped (on BookE) and continue with hard interrupts
enabled, which means that we'll potentially get better sample quality from
performance monitor interrupts.

There are additional refinements that we can do on top of this patch:

 - We could remove the ps3 workaround from arch_local_irq_enable(),
I believe that it should no longer be necessary

 - We should consider hard-enabling when taking timer interrupts rather
than keeping interrupts off until the timer interrupt itself soft-enables

 - The external interrupts no longer soft-enable, so we should consider
hard-enabling instead, again to improve the quality of performance samples

 - We could make "masked" decrementer interrupts act as NMIs to improve
timer-based stochastic sampling

 - There are additional simplifications of the exception entry/exit path
that I've spotted along the way, such as merging fast_exception_return
with the normal code path.

>From there, implementing proper support for EPR should just be a matter
of having its specific masked handler store the values in a little per-cpu
stack and have ppc_md.get_irq() fetch from that stack when it's not empty.

This patch needs a LOT more testing & review than it had so far !!!

Not-signed-off-by-yet: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
---
 arch/powerpc/include/asm/exception-64s.h        |   21 ++-
 arch/powerpc/include/asm/hw_irq.h               |   37 ++++-
 arch/powerpc/include/asm/irqflags.h             |   13 +-
 arch/powerpc/include/asm/paca.h                 |    2 +-
 arch/powerpc/kernel/asm-offsets.c               |    2 +-
 arch/powerpc/kernel/entry_64.S                  |   96 ++++++------
 arch/powerpc/kernel/exceptions-64e.S            |  188 ++++++++++++++++-------
 arch/powerpc/kernel/exceptions-64s.S            |   90 +++++++-----
 arch/powerpc/kernel/head_64.S                   |    9 -
 arch/powerpc/kernel/idle_book3e.S               |    8 +-
 arch/powerpc/kernel/idle_power4.S               |   17 ++-
 arch/powerpc/kernel/idle_power7.S               |   20 ++-
 arch/powerpc/kernel/irq.c                       |  164 +++++++++++++-------
 arch/powerpc/kernel/time.c                      |    3 -
 arch/powerpc/platforms/iseries/Makefile         |    2 +-
 arch/powerpc/platforms/iseries/exception.S      |   11 +-
 arch/powerpc/platforms/iseries/misc.S           |   26 ---
 arch/powerpc/platforms/pseries/processor_idle.c |   24 +++-
 18 files changed, 462 insertions(+), 271 deletions(-)
 delete mode 100644 arch/powerpc/platforms/iseries/misc.S

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 8057f4f..b3f42e9 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -232,23 +232,24 @@ label##_hv:						\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_HV, KVMTEST, vec)
 
-#define __SOFTEN_TEST(h)						\
+#define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	cmpwi	r10,0;							\
+	li	r10,(vec)>>8;						\
 	beq	masked_##h##interrupt
-#define _SOFTEN_TEST(h)	__SOFTEN_TEST(h)
+#define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
 
 #define SOFTEN_TEST_PR(vec)						\
 	KVMTEST_PR(vec);						\
-	_SOFTEN_TEST(EXC_STD)
+	_SOFTEN_TEST(EXC_STD, vec)
 
 #define SOFTEN_TEST_HV(vec)						\
 	KVMTEST(vec);							\
-	_SOFTEN_TEST(EXC_HV)
+	_SOFTEN_TEST(EXC_HV, vec)
 
 #define SOFTEN_TEST_HV_201(vec)						\
 	KVMTEST(vec);							\
-	_SOFTEN_TEST(EXC_STD)
+	_SOFTEN_TEST(EXC_STD, vec)
 
 #define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
 	HMT_MEDIUM;							\
@@ -276,9 +277,9 @@ label##_hv:								\
 #define DISABLE_INTS				\
 	li	r11,0;				\
 	stb	r11,PACASOFTIRQEN(r13);		\
-BEGIN_FW_FTR_SECTION;				\
-	stb	r11,PACAHARDIRQEN(r13);		\
-END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES);	\
+	lbz	r11,PACAIRQHAPPENED(r13);	\
+	ori	r11,r11,PACA_HAPPENED;		\
+	stb	r11,PACAIRQHAPPENED(r13);	\
 	TRACE_DISABLE_INTS;			\
 BEGIN_FW_FTR_SECTION;				\
 	mfmsr	r10;				\
@@ -289,7 +290,9 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #define DISABLE_INTS				\
 	li	r11,0;				\
 	stb	r11,PACASOFTIRQEN(r13);		\
-	stb	r11,PACAHARDIRQEN(r13);		\
+	lbz	r11,PACAIRQHAPPENED(r13);	\
+	ori	r11,r11,PACA_HAPPENED;		\
+	stb	r11,PACAIRQHAPPENED(r13);	\
 	TRACE_DISABLE_INTS
 #endif /* CONFIG_PPC_ISERIES */
 
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index bb712c9..e235e7f 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -10,12 +10,37 @@
 #include <linux/compiler.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
+/*
+ * PACA flags in paca->irq_happened. These flags are set by
+ * oring in the interrupt vector shifted right by 8, so what
+ * we actually have in there is:
+ *
+ * EE  :  0x50x >> 8 = 0x05
+ * DEC :  0x90x >> 8 = 0x09
+ *
+ * The bits we test are thus 0x4 and 0x8 respectively, with bit
+ * 0x1 always set when "something happened".
+ *
+ * Note: That "something happened" bit is important as we set it
+ * when manually hard-disabling. This allows arch_local_irq_restore()
+ * to "know" that it can't just return and has to actually hard
+ * enable.
+ */
+#define PACA_HAPPENED		0x01
+#define PACA_HAPPENED_DBELL	0x02
+#define PACA_HAPPENED_EE	0x04
+#define PACA_HAPPENED_DEC	0x08 /* Or FIT */
+#define PACA_HAPPENED_PERFMON	0x10 /* BookE only */
+
+#ifndef __ASSEMBLY__
 
 extern void timer_interrupt(struct pt_regs *);
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 
+extern void __reemit_interrupt(unsigned int vector);
+
 static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
@@ -42,7 +67,6 @@ static inline unsigned long arch_local_irq_disable(void)
 }
 
 extern void arch_local_irq_restore(unsigned long);
-extern void iseries_handle_interrupts(void);
 
 static inline void arch_local_irq_enable(void)
 {
@@ -72,11 +96,11 @@ static inline bool arch_irqs_disabled(void)
 #define __hard_irq_disable()	__mtmsrd(mfmsr() & ~MSR_EE, 1)
 #endif
 
-#define  hard_irq_disable()			\
-	do {					\
-		__hard_irq_disable();		\
-		get_paca()->soft_enabled = 0;	\
-		get_paca()->hard_enabled = 0;	\
+#define  hard_irq_disable()					\
+	do {							\
+		__hard_irq_disable();				\
+		get_paca()->soft_enabled = 0;			\
+		get_paca()->irq_happened |= PACA_HAPPENED;	\
 	} while(0)
 
 #else /* CONFIG_PPC64 */
@@ -149,5 +173,6 @@ static inline bool arch_irqs_disabled(void)
  */
 struct irq_chip;
 
+#endif  /* __ASSEMBLY__ */
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_HW_IRQ_H */
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index b0b06d8..4bfbf0a 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -47,16 +47,15 @@
 	b	skip;					\
 95:	TRACE_WITH_FRAME_BUFFER(.trace_hardirqs_on)	\
 	li	en,1;
-#define TRACE_AND_RESTORE_IRQ(en)		\
-	TRACE_AND_RESTORE_IRQ_PARTIAL(en,96f);	\
-	stb	en,PACASOFTIRQEN(r13);		\
-96:
 #else
 #define TRACE_ENABLE_INTS
 #define TRACE_DISABLE_INTS
-#define TRACE_AND_RESTORE_IRQ_PARTIAL(en,skip)
-#define TRACE_AND_RESTORE_IRQ(en)		\
-	stb	en,PACASOFTIRQEN(r13)
+#define TRACE_AND_RESTORE_IRQ_PARTIAL(en,skip)		\
+	cmpdi	en,0;					\
+	bne	95f;					\
+	stb	en,PACASOFTIRQEN(r13);			\
+	b	skip;					\
+95:
 #endif
 #endif
 
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 269c05a..daf813f 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -132,7 +132,7 @@ struct paca_struct {
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
 	u8 soft_enabled;		/* irq soft-enable flag */
-	u8 hard_enabled;		/* set if irqs are enabled in MSR */
+	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
 	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 04caee7..cdd0d26 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -147,7 +147,7 @@ int main(void)
 	DEFINE(PACAKBASE, offsetof(struct paca_struct, kernelbase));
 	DEFINE(PACAKMSR, offsetof(struct paca_struct, kernel_msr));
 	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_enabled));
-	DEFINE(PACAHARDIRQEN, offsetof(struct paca_struct, hard_enabled));
+	DEFINE(PACAIRQHAPPENED, offsetof(struct paca_struct, irq_happened));
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
 #ifdef CONFIG_PPC_MM_SLICES
 	DEFINE(PACALOWSLICESPSIZE, offsetof(struct paca_struct,
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d834425..b93d84a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -31,6 +31,7 @@
 #include <asm/bug.h>
 #include <asm/ptrace.h>
 #include <asm/irqflags.h>
+#include <asm/hw_irq.h>
 #include <asm/ftrace.h>
 
 /*
@@ -125,19 +126,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #endif /* CONFIG_TRACE_IRQFLAGS */
 	li	r10,1
 	stb	r10,PACASOFTIRQEN(r13)
-	stb	r10,PACAHARDIRQEN(r13)
 	std	r10,SOFTE(r1)
-#ifdef CONFIG_PPC_ISERIES
-BEGIN_FW_FTR_SECTION
-	/* Hack for handling interrupts when soft-enabling on iSeries */
-	cmpdi	cr1,r0,0x5555		/* syscall 0x5555 */
-	andi.	r10,r12,MSR_PR		/* from kernel */
-	crand	4*cr0+eq,4*cr1+eq,4*cr0+eq
-	bne	2f
-	b	hardware_interrupt_entry
-2:
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif /* CONFIG_PPC_ISERIES */
 
 	/* Hard enable interrupts */
 #ifdef CONFIG_PPC_BOOK3E
@@ -593,23 +582,33 @@ _GLOBAL(ret_from_except_lite)
 	bne	do_work
 #endif
 
+_GLOBAL(fast_exception_return_irq)
 restore:
-BEGIN_FW_FTR_SECTION
 	ld	r5,SOFTE(r1)
-FW_FTR_SECTION_ELSE
-	b	.Liseries_check_pending_irqs
-ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_ISERIES)
-2:
-	TRACE_AND_RESTORE_IRQ(r5);
+	TRACE_AND_RESTORE_IRQ_PARTIAL(r5, 3f);
 
-	/* extract EE bit and use it to restore paca->hard_enabled */
-	ld	r3,_MSR(r1)
-	rldicl	r4,r3,49,63		/* r0 = (r3 >> 15) & 1 */
-	stb	r4,PACAHARDIRQEN(r13)
+	/*
+	 * We are about to soft-enable interrupts (we are hard disabled
+	 * at this point). We check if there's anything that needs to
+	 * be replayed first
+	 */
+	lbz	r0,PACAIRQHAPPENED(r13)
+	cmpwi	cr0,r0,0
+	bne-	4f
+
+	/*
+	 * Get here when nothing happened while soft-disabled, just
+	 * soft-enable and move-on. We will hard-enable as a side
+	 * effect of rfi
+	 */
+2:	li	r0,1
+	stb	r0,PACASOFTIRQEN(r13);
+3:
 
 #ifdef CONFIG_PPC_BOOK3E
 	b	.exception_return_book3e
 #else
+	ld	r3,_MSR(r1)
 	ld	r4,_CTR(r1)
 	ld	r0,_LINK(r1)
 	mtctr	r4
@@ -644,7 +643,8 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	/*
 	 * r13 is our per cpu area, only restore it if we are returning to
-	 * userspace
+	 * userspace the value stored in the stack frame may belong to
+	 * another CPU.
 	 */
 	andi.	r0,r3,MSR_PR
 	beq	1f
@@ -669,29 +669,36 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 #endif /* CONFIG_PPC_BOOK3E */
 
-.Liseries_check_pending_irqs:
-#ifdef CONFIG_PPC_ISERIES
-	ld	r5,SOFTE(r1)
-	cmpdi	0,r5,0
+	/*
+	 * Something did happen, check if a re-emit is needed
+	 * (this also clears paca->irq_happened)
+	 */
+4:	bl	.__check_irq_reemit
+	cmpwi	cr0,r3,0
 	beq	2b
-	/* Check for pending interrupts (iSeries) */
-	ld	r3,PACALPPACAPTR(r13)
-	ld	r3,LPPACAANYINT(r3)
-	cmpdi	r3,0
-	beq+	2b			/* skip do_IRQ if no interrupts */
 
-	li	r3,0
-	stb	r3,PACASOFTIRQEN(r13)	/* ensure we are soft-disabled */
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	.trace_hardirqs_off
-	mfmsr	r10
-#endif
-	ori	r10,r10,MSR_EE
-	mtmsrd	r10			/* hard-enable again */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
+	/*
+	 * We need to re-emit an interrupt. We do so by re-using our
+	 * existing exception frame. We first change the trap value,
+	 * but we need to ensure we preserve the low nibble of it
+	 */
+	ld	r4,_TRAP(r1)
+	clrldi	r4,r4,60
+	or	r4,r4,r3
+	std	r4,_TRAP(r1)
+
+	/*
+	 * Then find the right handler and call it. Interrupts are
+	 * still soft-disabled and we keep them that way.
+	 */
+	cmpwi	cr0,r3,0x500
+	bne	1f
+	addi	r3,r1,STACK_FRAME_OVERHEAD;
+	bl	.timer_interrupt
+	b	.ret_from_except
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD;
 	bl	.do_IRQ
-	b	.ret_from_except_lite		/* loop back and handle more */
-#endif
+	b	.ret_from_except
 
 do_work:
 #ifdef CONFIG_PREEMPT
@@ -713,7 +720,6 @@ do_work:
 	 */
 	li	r0,0
 	stb	r0,PACASOFTIRQEN(r13)
-	stb	r0,PACAHARDIRQEN(r13)
 	TRACE_DISABLE_INTS
 
 	/* Call the scheduler with soft IRQs off */
@@ -728,8 +734,6 @@ do_work:
 	rotldi	r10,r10,16
 	mtmsrd	r10,1
 #endif /* CONFIG_PPC_BOOK3E */
-	li	r0,0
-	stb	r0,PACAHARDIRQEN(r13)
 
 	/* Re-test flags and eventually loop */
 	clrrdi	r9,r1,THREAD_SHIFT
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 429983c..04f83d3 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -21,6 +21,7 @@
 #include <asm/exception-64e.h>
 #include <asm/bug.h>
 #include <asm/irqflags.h>
+#include <asm/hw_irq.h>
 #include <asm/ptrace.h>
 #include <asm/ppc-opcode.h>
 #include <asm/mmu.h>
@@ -77,59 +78,55 @@
 #define SPRN_MC_SRR1	SPRN_MCSRR1
 
 #define NORMAL_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, GEN, addition##_GEN)
+	EXCEPTION_PROLOG(n, GEN, addition##_GEN(n))
 
 #define CRIT_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, CRIT, addition##_CRIT)
+	EXCEPTION_PROLOG(n, CRIT, addition##_CRIT(n))
 
 #define DBG_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, DBG, addition##_DBG)
+	EXCEPTION_PROLOG(n, DBG, addition##_DBG(n))
 
 #define MC_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, MC, addition##_MC)
+	EXCEPTION_PROLOG(n, MC, addition##_MC(n))
 
 
 /* Variants of the "addition" argument for the prolog
  */
-#define PROLOG_ADDITION_NONE_GEN
-#define PROLOG_ADDITION_NONE_CRIT
-#define PROLOG_ADDITION_NONE_DBG
-#define PROLOG_ADDITION_NONE_MC
+#define PROLOG_ADDITION_NONE_GEN(n)
+#define PROLOG_ADDITION_NONE_CRIT(n)
+#define PROLOG_ADDITION_NONE_DBG(n)
+#define PROLOG_ADDITION_NONE_MC(n)
 
-#define PROLOG_ADDITION_MASKABLE_GEN					    \
+#define PROLOG_ADDITION_MASKABLE_GEN(n)					    \
 	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
 	cmpwi	cr0,r11,0;		/* yes -> go out of line */	    \
-	beq	masked_interrupt_book3e;
+	beq	masked_interrupt_book3e_##n;
 
-#define PROLOG_ADDITION_2REGS_GEN					    \
+#define PROLOG_ADDITION_2REGS_GEN(n)					    \
 	std	r14,PACA_EXGEN+EX_R14(r13);				    \
 	std	r15,PACA_EXGEN+EX_R15(r13)
 
-#define PROLOG_ADDITION_1REG_GEN					    \
+#define PROLOG_ADDITION_1REG_GEN(n)					    \
 	std	r14,PACA_EXGEN+EX_R14(r13);
 
-#define PROLOG_ADDITION_2REGS_CRIT					    \
+#define PROLOG_ADDITION_2REGS_CRIT(n)					    \
 	std	r14,PACA_EXCRIT+EX_R14(r13);				    \
 	std	r15,PACA_EXCRIT+EX_R15(r13)
 
-#define PROLOG_ADDITION_2REGS_DBG					    \
+#define PROLOG_ADDITION_2REGS_DBG(n)					    \
 	std	r14,PACA_EXDBG+EX_R14(r13);				    \
 	std	r15,PACA_EXDBG+EX_R15(r13)
 
-#define PROLOG_ADDITION_2REGS_MC					    \
+#define PROLOG_ADDITION_2REGS_MC(n)					    \
 	std	r14,PACA_EXMC+EX_R14(r13);				    \
 	std	r15,PACA_EXMC+EX_R15(r13)
 
-#define PROLOG_ADDITION_DOORBELL_GEN					    \
-	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
-	cmpwi	cr0,r11,0;		/* yes -> go out of line */	    \
-	beq	masked_doorbell_book3e
-
 
 /* Core exception code for all exceptions except TLB misses.
  * XXX: Needs to make SPRN_SPRG_GEN depend on exception type
  */
 #define EXCEPTION_COMMON(n, excf, ints)					    \
+exc_##n##_common:							    \
 	std	r0,GPR0(r1);		/* save r0 in stackframe */	    \
 	std	r2,GPR2(r1);		/* save r2 in stackframe */	    \
 	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe */    \
@@ -169,14 +166,12 @@
 
 /* Variants for the "ints" argument */
 #define INTS_KEEP
-#define INTS_DISABLE_SOFT						    \
+#define INTS_DISABLE							    \
 	stb	r0,PACASOFTIRQEN(r13);	/* mark interrupts soft-disabled */ \
+	lbz	r0,PACAIRQHAPPENED(r13);				    \
+	ori	r0,r0,PACA_HAPPENED;					    \
+	stb	r0,PACAIRQHAPPENED(r13);				    \
 	TRACE_DISABLE_INTS;
-#define INTS_DISABLE_HARD						    \
-	stb	r0,PACAHARDIRQEN(r13); /* and hard disabled */
-#define INTS_DISABLE_ALL						    \
-	INTS_DISABLE_SOFT						    \
-	INTS_DISABLE_HARD
 
 /* This is called by exceptions that used INTS_KEEP (that is did not clear
  * neither soft nor hard IRQ indicators in the PACA. This will restore MSR:EE
@@ -238,7 +233,7 @@ exc_##n##_bad_stack:							    \
 #define MASKABLE_EXCEPTION(trapnum, label, hdlr, ack)			\
 	START_EXCEPTION(label);						\
 	NORMAL_EXCEPTION_PROLOG(trapnum, PROLOG_ADDITION_MASKABLE)	\
-	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE_ALL)		\
+	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE)		\
 	ack(r8);							\
 	CHECK_NAPPING();						\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
@@ -289,7 +284,7 @@ interrupt_end_book3e:
 /* Critical Input Interrupt */
 	START_EXCEPTION(critical_input);
 	CRIT_EXCEPTION_PROLOG(0x100, PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE_ALL)
+//	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE)
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -300,7 +295,7 @@ interrupt_end_book3e:
 /* Machine Check Interrupt */
 	START_EXCEPTION(machine_check);
 	CRIT_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE_ALL)
+//	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE)
 //	bl	special_reg_save_mc
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
 //	CHECK_NAPPING();
@@ -339,7 +334,7 @@ interrupt_end_book3e:
 	START_EXCEPTION(program);
 	NORMAL_EXCEPTION_PROLOG(0x700, PROLOG_ADDITION_1REG)
 	mfspr	r14,SPRN_ESR
-	EXCEPTION_COMMON(0x700, PACA_EXGEN, INTS_DISABLE_SOFT)
+	EXCEPTION_COMMON(0x700, PACA_EXGEN, INTS_DISABLE)
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ld	r14,PACA_EXGEN+EX_R14(r13)
@@ -372,7 +367,7 @@ interrupt_end_book3e:
 /* Watchdog Timer Interrupt */
 	START_EXCEPTION(watchdog);
 	CRIT_EXCEPTION_PROLOG(0x9f0, PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE_ALL)
+//	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE)
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -450,7 +445,7 @@ interrupt_end_book3e:
 	mfspr	r15,SPRN_SPRG_CRIT_SCRATCH
 	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
 	mfspr	r14,SPRN_DBSR
-	EXCEPTION_COMMON(0xd00, PACA_EXCRIT, INTS_DISABLE_ALL)
+	EXCEPTION_COMMON(0xd00, PACA_EXCRIT, INTS_DISABLE)
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mr	r4,r14
@@ -515,7 +510,7 @@ kernel_dbg_exc:
 	mfspr	r15,SPRN_SPRG_DBG_SCRATCH
 	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
 	mfspr	r14,SPRN_DBSR
-	EXCEPTION_COMMON(0xd00, PACA_EXDBG, INTS_DISABLE_ALL)
+	EXCEPTION_COMMON(0xd08, PACA_EXDBG, INTS_DISABLE)
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mr	r4,r14
@@ -528,18 +523,12 @@ kernel_dbg_exc:
 	MASKABLE_EXCEPTION(0x260, perfmon, .performance_monitor_exception, ACK_NONE)
 
 /* Doorbell interrupt */
-	START_EXCEPTION(doorbell)
-	NORMAL_EXCEPTION_PROLOG(0x2070, PROLOG_ADDITION_DOORBELL)
-	EXCEPTION_COMMON(0x2070, PACA_EXGEN, INTS_DISABLE_ALL)
-	CHECK_NAPPING()
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.doorbell_exception
-	b	.ret_from_except_lite
+	MASKABLE_EXCEPTION(0x280, doorbell, .doorbell_exception, ACK_NONE)
 
 /* Doorbell critical Interrupt */
 	START_EXCEPTION(doorbell_crit);
-	CRIT_EXCEPTION_PROLOG(0x2080, PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x2080, PACA_EXCRIT, INTS_DISABLE_ALL)
+	CRIT_EXCEPTION_PROLOG(0x2a0, PROLOG_ADDITION_NONE)
+//	EXCEPTION_COMMON(0x280, PACA_EXCRIT, INTS_DISABLE)
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -547,38 +536,119 @@ kernel_dbg_exc:
 //	b	ret_from_crit_except
 	b	.
 
+/* Guest Doorbell */
 	MASKABLE_EXCEPTION(0x2c0, guest_doorbell, .unknown_exception, ACK_NONE)
-	MASKABLE_EXCEPTION(0x2e0, guest_doorbell_crit, .unknown_exception, ACK_NONE)
-	MASKABLE_EXCEPTION(0x310, hypercall, .unknown_exception, ACK_NONE)
-	MASKABLE_EXCEPTION(0x320, ehpriv, .unknown_exception, ACK_NONE)
+
+/* Guest Doorbell critical Interrupt */
+	START_EXCEPTION(guest_doorbell_crit);
+	CRIT_EXCEPTION_PROLOG(0x2e0, PROLOG_ADDITION_NONE)
+//	EXCEPTION_COMMON(0x2e0, PACA_EXCRIT, INTS_DISABLE)
+//	bl	special_reg_save_crit
+//	CHECK_NAPPING();
+//	addi	r3,r1,STACK_FRAME_OVERHEAD
+//	bl	.guest_doorbell_critical_exception
+//	b	ret_from_crit_except
+	b	.
+
+/* Hypervisor call */
+	START_EXCEPTION(hypercall);
+	NORMAL_EXCEPTION_PROLOG(0x310, PROLOG_ADDITION_NONE)
+	EXCEPTION_COMMON(0x310, PACA_EXGEN, INTS_KEEP)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.unknown_exception
+	b	.ret_from_except
+
+/* Embedded Hypervisor priviledged  */
+	START_EXCEPTION(ehpriv);
+	NORMAL_EXCEPTION_PROLOG(0x320, PROLOG_ADDITION_NONE)
+	EXCEPTION_COMMON(0x320, PACA_EXGEN, INTS_KEEP)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.unknown_exception
+	b	.ret_from_except
 
 
 /*
- * An interrupt came in while soft-disabled; clear EE in SRR1,
- * clear paca->hard_enabled and return.
+ * An interrupt came in while soft-disabled; We mark paca->irq_happened
+ * accordingly and if the interrupt is level sensitive, we hard disable
  */
-masked_doorbell_book3e:
-	mtcr	r10
-	/* Resend the doorbell to fire again when ints enabled */
-	mfspr	r10,SPRN_PIR
-	PPC_MSGSND(r10)
-	b	masked_interrupt_book3e_common
 
-masked_interrupt_book3e:
-	mtcr	r10
-masked_interrupt_book3e_common:
-	stb	r11,PACAHARDIRQEN(r13)
+masked_interrupt_book3e_0x500:
+	li	r10,PACA_HAPPENED_EE
+	b	masked_interrupt_book3e_full_mask
+masked_interrupt_book3e_0x260:
+	li	r10,PACA_HAPPENED_PERFMON
+	b	masked_interrupt_book3e_full_mask
+
+masked_interrupt_book3e_0x900:
+	ACK_DEC(r10);
+	li	r10,PACA_HAPPENED_DEC
+	b	masked_interrupt_book3e_no_mask
+masked_interrupt_book3e_0x980:
+	ACK_FIT(r10);
+	li	r10,PACA_HAPPENED_DEC
+	b	masked_interrupt_book3e_no_mask
+masked_interrupt_book3e_0x280:
+masked_interrupt_book3e_0x2c0:
+	li	r10,PACA_HAPPENED_DBELL
+	b	masked_interrupt_book3e_no_mask
+
+masked_interrupt_book3e_no_mask:
+	lbz	r11,PACAIRQHAPPENED(r13)
+	ori	r11,r11,r10
+	stb	r11,PACAIRQHAPPENED(r13)
+	b	1f
+masked_interrupt_book3e_full_mask:
+	lbz	r11,PACAIRQHAPPENED(r13)
+	ori	r11,r11,r10
+	stb	r11,PACAIRQHAPPENED(r13)
 	mfspr	r10,SPRN_SRR1
 	rldicl	r11,r10,48,1		/* clear MSR_EE */
 	rotldi	r10,r11,16
 	mtspr	SPRN_SRR1,r10
-	ld	r10,PACA_EXGEN+EX_R10(r13);	/* restore registers */
+1:	ld	r10,PACA_EXGEN+EX_R10(r13);
 	ld	r11,PACA_EXGEN+EX_R11(r13);
 	mfspr	r13,SPRN_SPRG_GEN_SCRATCH;
 	rfi
 	b	.
 
 /*
+ * Called from arch_local_irq_enable when an interrupt needs
+ * to be resent. r3 contains either 0x500,0x900,0x260 or 0x280
+ * to indicate the kind of interrupt. MSR:EE is already off.
+ * We generate a stackframe like if a real interrupt had happened.
+ *
+ * Note: While MSR:EE is off, we need to make sure that _MSR
+ * in the generated frame has EE set to 1 or the exception
+ * handler will not properly re-enable them.
+ */
+_GLOBAL(__reemit_interrupt)
+	/* We are going to jump to the exception common code which
+	 * will retrieve various register values from the PACA which
+	 * we don't give a damn about.
+	 */
+	mflr	r10
+	mfmsr	r11
+	mfcr	r4;
+	mtspr	SPRN_SPRG_GEN_SCRATCH,r13;
+	std	r1,PACA_EXGEN+EX_R1(r13);
+	stw	r4,PACA_EXGEN+EX_CR(r13);
+	ori	r11,r11,MSR_EE
+	subi	r1,r1,INT_FRAME_SIZE;
+	cmpwi	cr0,r3,0x500
+	beq	exc_0x500_common
+	cmpwi	cr0,r3,0x900
+	beq+	exc_0x900_common
+	cmpwi	cr0,r3,0x260
+	beq+	exc_0x260_common
+	cmpwi	cr0,r3,0x280
+	beq+	exc_0x280_common
+	blr
+
+/*
  * This is called from 0x300 and 0x400 handlers after the prologs with
  * r14 and r15 containing the fault address and error code, with the
  * original values stashed away in the PACA
@@ -680,6 +750,8 @@ BAD_STACK_TRAMPOLINE(0x000)
 BAD_STACK_TRAMPOLINE(0x100)
 BAD_STACK_TRAMPOLINE(0x200)
 BAD_STACK_TRAMPOLINE(0x260)
+BAD_STACK_TRAMPOLINE(0x280)
+BAD_STACK_TRAMPOLINE(0x2a0)
 BAD_STACK_TRAMPOLINE(0x2c0)
 BAD_STACK_TRAMPOLINE(0x2e0)
 BAD_STACK_TRAMPOLINE(0x300)
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d4be7bb..896eea8 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -12,6 +12,7 @@
  *
  */
 
+#include <asm/hw_irq.h>
 #include <asm/exception-64s.h>
 #include <asm/ptrace.h>
 
@@ -356,34 +357,60 @@ do_stab_bolted_pSeries:
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf40)
 
 /*
- * An interrupt came in while soft-disabled; clear EE in SRR1,
- * clear paca->hard_enabled and return.
+ * An interrupt came in while soft-disabled. We set paca->irq_happened,
+ * then, if it was a decrementer interrupt, we bump the dec to max and
+ * and return, else we hard disable and return.
  */
-masked_interrupt:
-	stb	r10,PACAHARDIRQEN(r13)
-	mtcrf	0x80,r9
-	ld	r9,PACA_EXGEN+EX_R9(r13)
-	mfspr	r10,SPRN_SRR1
-	rldicl	r10,r10,48,1		/* clear MSR_EE */
-	rotldi	r10,r10,16
-	mtspr	SPRN_SRR1,r10
-	ld	r10,PACA_EXGEN+EX_R10(r13)
-	GET_SCRATCH0(r13)
-	rfid
-	b	.
 
-masked_Hinterrupt:
-	stb	r10,PACAHARDIRQEN(r13)
-	mtcrf	0x80,r9
-	ld	r9,PACA_EXGEN+EX_R9(r13)
-	mfspr	r10,SPRN_HSRR1
-	rldicl	r10,r10,48,1		/* clear MSR_EE */
-	rotldi	r10,r10,16
-	mtspr	SPRN_HSRR1,r10
-	ld	r10,PACA_EXGEN+EX_R10(r13)
-	GET_SCRATCH0(r13)
-	hrfid
+#define MASKED_INTERRUPT(_H)				\
+masked_##_H##interrupt:					\
+	std	r11,PACA_EXGEN+EX_R11(r13);		\
+	lbz	r11,PACAIRQHAPPENED(r13);		\
+	or	r11,r11,r10;				\
+	stb	r11,PACAIRQHAPPENED(r13);		\
+	andi.	r10,r10,PACA_HAPPENED_DEC;		\
+	beq	1f;					\
+	lis	r10,0x7fff;				\
+	ori	r10,r10,0xffff;				\
+	mtspr	SPRN_DEC,r10;				\
+	b	2f;					\
+1:	mfspr	r10,SPRN_##_H##SRR1;			\
+	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
+	rotldi	r10,r10,16;				\
+	mtspr	SPRN_##_H##SRR1,r10;			\
+2:	mtcrf	0x80,r9;				\
+	ld	r9,PACA_EXGEN+EX_R9(r13);		\
+	ld	r10,PACA_EXGEN+EX_R10(r13);		\
+	ld	r11,PACA_EXGEN+EX_R11(r13);		\
+	GET_SCRATCH0(r13);				\
+	##_H##rfid;					\
 	b	.
+	
+	MASKED_INTERRUPT()
+	MASKED_INTERRUPT(H)
+
+/*
+ * Called from arch_local_irq_enable when an interrupt needs
+ * to be resent. r3 contains 0x500 or 0x900 to indicate which
+ * kind of interrupt. MSR:EE is already off. We generate a
+ * stackframe like if a real interrupt had happened.
+ *
+ * Note: While MSR:EE is off, we need to make sure that _MSR
+ * in the generated frame has EE set to 1 or the exception
+ * handler will not properly re-enable them.
+ */
+_GLOBAL(__reemit_interrupt)
+	/* We are going to jump to the exception common code which
+	 * will retrieve various register values from the PACA which
+	 * we don't give a damn about, so we don't bother storing them.
+	 */
+	mfmsr	r12
+	mflr	r11
+	mfcr	r9
+	ori	r12,r12,MSR_EE
+	andi.	r3,r3,0x0800
+	bne	decrementer_common
+	b	hardware_interrupt_common
 
 #ifdef CONFIG_PPC_PSERIES
 /*
@@ -838,18 +865,10 @@ __end_handlers:
  * any task or sent any task a signal, you should use
  * ret_from_except or ret_from_except_lite instead of this.
  */
-fast_exc_return_irq:			/* restores irq state too */
-	ld	r3,SOFTE(r1)
-	TRACE_AND_RESTORE_IRQ(r3);
-	ld	r12,_MSR(r1)
-	rldicl	r4,r12,49,63		/* get MSR_EE to LSB */
-	stb	r4,PACAHARDIRQEN(r13)	/* restore paca->hard_enabled */
-	b	1f
-
 	.globl	fast_exception_return
 fast_exception_return:
 	ld	r12,_MSR(r1)
-1:	ld	r11,_NIP(r1)
+	ld	r11,_NIP(r1)
 	andi.	r3,r12,MSR_RI		/* check if RI is set */
 	beq-	unrecov_fer
 
@@ -973,7 +992,7 @@ BEGIN_FW_FTR_SECTION
 	 * Here we have interrupts hard-disabled, so it is sufficient
 	 * to restore paca->{soft,hard}_enable and get out.
 	 */
-	beq	fast_exc_return_irq	/* Return from exception on success */
+	beq	14f
 END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
 
 	/* For a hash failure, we don't bother re-enabling interrupts */
@@ -1015,6 +1034,7 @@ handle_page_fault:
 	b	.ret_from_except
 
 13:	b	.ret_from_except_lite
+14:	b	.fast_exception_return_irq
 
 /* We have a page fault that hash_page could handle but HV refused
  * the PTE insertion
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 06c7251..ffe08a6 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -564,7 +564,6 @@ _GLOBAL(pmac_secondary_start)
 	 */
 	li	r0,0
 	stb	r0,PACASOFTIRQEN(r13)
-	stb	r0,PACAHARDIRQEN(r13)
 
 	/* Create a temp kernel stack for use before relocation is on.	*/
 	ld	r1,PACAEMERGSP(r13)
@@ -621,13 +620,8 @@ __secondary_start:
 #ifdef CONFIG_PPC_ISERIES
 BEGIN_FW_FTR_SECTION
 	ori	r4,r4,MSR_EE
-	li	r8,1
-	stb	r8,PACAHARDIRQEN(r13)
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
-BEGIN_FW_FTR_SECTION
-	stb	r7,PACAHARDIRQEN(r13)
-END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
 	stb	r7,PACASOFTIRQEN(r13)
 
 	mtspr	SPRN_SRR0,r3
@@ -782,11 +776,8 @@ BEGIN_FW_FTR_SECTION
 	mfmsr	r5
 	ori	r5,r5,MSR_EE		/* Hard Enabled on iSeries*/
 	mtmsrd	r5
-	li	r5,1
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
-	stb	r5,PACAHARDIRQEN(r13)	/* Hard Disabled on others */
-
 	bl	.start_kernel
 
 	/* Not reached */
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index 16c002d..b1199f8 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -32,11 +32,11 @@ _GLOBAL(book3e_idle)
 	 * since we may otherwise lose it (doorbells etc...). We know
 	 * that since PACAHARDIRQEN will have been cleared in that case.
 	 */
-	lbz	r3,PACAHARDIRQEN(r13)
+	lbz	r3,PACAIRQHAPPENED(r13)
 	cmpwi	cr0,r3,0
-	beqlr
+	bnelr
 
-	/* Now we are going to mark ourselves as soft and hard enables in
+	/* Now we are going to mark ourselves as soft and hard enabled in
 	 * order to be able to take interrupts while asleep. We inform lockdep
 	 * of that. We don't actually turn interrupts on just yet tho.
 	 */
@@ -46,7 +46,6 @@ _GLOBAL(book3e_idle)
 #endif
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13)
-	stb	r0,PACAHARDIRQEN(r13)
 	
 	/* Interrupts will make use return to LR, so get something we want
 	 * in there
@@ -59,7 +58,6 @@ _GLOBAL(book3e_idle)
 	/* Mark them off again in the PACA as well */
 	li	r0,0
 	stb	r0,PACASOFTIRQEN(r13)
-	stb	r0,PACAHARDIRQEN(r13)
 
 	/* Tell lockdep about it */
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index ba31954..c30af92 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -29,14 +29,27 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	cmpwi	0,r4,0
 	beqlr
 
-	/* Go to NAP now */
+	/* Hard disable */
 	mfmsr	r7
 	rldicl	r0,r7,48,1
 	rotldi	r0,r0,16
 	mtmsrd	r0,1			/* hard-disable interrupts */
+
+	/* Check if something happened while soft-disabled */
+	lbz	r0,PACAIRQHAPPENED(r13)
+	cmpwi	cr0,r0,0
+	bnelr
+
+	/*
+	 * Here we mark ourselves soft-enabled. We should probably
+	 * tell lockdep about it, but the interrupt will re-disable
+	 * immediately so it shouldn't be a big issue. If it becomes
+	 * one, then we should implement things the way we do on
+	 * book3e.
+	 */
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
-	stb	r0,PACAHARDIRQEN(r13)
+
 BEGIN_FTR_SECTION
 	DSSALL
 	sync
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index fcdff19..61f8cac 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -1,5 +1,5 @@
 /*
- *  This file contains the power_save function for 970-family CPUs.
+ *  This file contains the power_save function for Power7 CPUs
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -51,9 +51,23 @@ _GLOBAL(power7_idle)
 	rldicl	r9,r9,48,1
 	rotldi	r9,r9,16
 	mtmsrd	r9,1			/* hard-disable interrupts */
-	li	r0,0
+
+	/* Check if something happened while soft-disabled */
+	lbz	r0,PACAIRQHAPPENED(r13)
+	cmpwi	cr0,r0,0
+	beq	1f
+	addi	r1,r1,INT_FRAME_SIZE
+	ld	r0,16(r1)
+	mtlr	r0
+	blr
+
+	/*
+	 * Here we mark ourselves soft-diasbled (we should already be
+	 * actually...). The interrupt is only going to happen after
+	 * we return to the caller and it does a local_irq_enable()
+	 */
+1:	li	r0,0
 	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
-	stb	r0,PACAHARDIRQEN(r13)
 	stb	r0,PACA_NAPSTATELOST(r13)
 
 	/* Continue saving state */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 701d4ac..97d3062 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -72,6 +72,7 @@
 #include <asm/paca.h>
 #include <asm/firmware.h>
 #include <asm/lv1call.h>
+#include <asm/irqflags.h>
 #endif
 #define CREATE_TRACE_POINTS
 #include <asm/trace.h>
@@ -99,14 +100,14 @@ EXPORT_SYMBOL(irq_desc);
 
 int distribute_irqs = 1;
 
-static inline notrace unsigned long get_hard_enabled(void)
+static inline notrace unsigned long get_irq_happened(void)
 {
-	unsigned long enabled;
+	unsigned long happened;
 
 	__asm__ __volatile__("lbz %0,%1(13)"
-	: "=r" (enabled) : "i" (offsetof(struct paca_struct, hard_enabled)));
+	: "=r" (happened) : "i" (offsetof(struct paca_struct, irq_happened)));
 
-	return enabled;
+	return happened;
 }
 
 static inline notrace void set_soft_enabled(unsigned long enable)
@@ -115,81 +116,136 @@ static inline notrace void set_soft_enabled(unsigned long enable)
 	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
 }
 
-static inline notrace void decrementer_check_overflow(void)
+static inline int decrementer_check_overflow(void)
 {
 	u64 now = get_tb_or_rtc();
 	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
 
-	if (now >= *next_tb)
-		set_dec(1);
+	return now >= *next_tb;
 }
 
-notrace void arch_local_irq_restore(unsigned long en)
+/* This is called whenever we are re-enabling interrupts
+ * and returns either 0 (nothing to do) or 500/900 if there's
+ * either an EE or a DEC to generate.
+ *
+ * This is called in two contexts: From arch_local_irq_restore()
+ * before soft-enabling interrupts, and from the exception exit
+ * path when returning from an interrupt from a soft-disabled to
+ * a soft enabled context. In both case we have interrupts hard
+ * disabled.
+ *
+ * We take care of only clearing the bits we handled in the
+ * PACA irq_happened field since we can only re-emit one at a
+ * time and we don't want to "lose" one.
+ */
+notrace unsigned int __check_irq_reemit(void)
 {
 	/*
-	 * get_paca()->soft_enabled = en;
-	 * Is it ever valid to use local_irq_restore(0) when soft_enabled is 1?
-	 * That was allowed before, and in such a case we do need to take care
-	 * that gcc will set soft_enabled directly via r13, not choose to use
-	 * an intermediate register, lest we're preempted to a different cpu.
+	 * We use local_paca rather than get_paca() to avoid all
+	 * the debug_smp_processor_id() business in this low level
+	 * function
 	 */
-	set_soft_enabled(en);
-	if (!en)
-		return;
+	unsigned char happened = local_paca->irq_happened;
+
+	/* Clear bit 0 which we wouldn't clear otherwise */
+	local_paca->irq_happened &= ~1;
 
-#ifdef CONFIG_PPC_STD_MMU_64
-	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		/*
-		 * Do we need to disable preemption here?  Not really: in the
-		 * unlikely event that we're preempted to a different cpu in
-		 * between getting r13, loading its lppaca_ptr, and loading
-		 * its any_int, we might call iseries_handle_interrupts without
-		 * an interrupt pending on the new cpu, but that's no disaster,
-		 * is it?  And the business of preempting us off the old cpu
-		 * would itself involve a local_irq_restore which handles the
-		 * interrupt to that cpu.
-		 *
-		 * But use "local_paca->lppaca_ptr" instead of "get_lppaca()"
-		 * to avoid any preemption checking added into get_paca().
-		 */
-		if (local_paca->lppaca_ptr->int_dword.any_int)
-			iseries_handle_interrupts();
+	/*
+	 * Force the delivery of pending soft-disabled interrupts on PS3.
+	 * Any HV call will have this side effect.
+	 */
+	if (firmware_has_feature(FW_FEATURE_PS3_LV1)) {
+		u64 tmp, tmp2;
+		lv1_get_version_info(&tmp, &tmp2);
 	}
-#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	/*
-	 * if (get_paca()->hard_enabled) return;
-	 * But again we need to take care that gcc gets hard_enabled directly
-	 * via r13, not choose to use an intermediate register, lest we're
-	 * preempted to a different cpu in between the two instructions.
+	 * We may have missed a decrementer interrupt. We check the
+	 * decrementer itself rather than the paca irq_happened field
+	 * in case we also had a rollover while hard disabled
 	 */
-	if (get_hard_enabled())
-		return;
+	local_paca->irq_happened &= ~PACA_HAPPENED_DEC;
+	if (decrementer_check_overflow())
+		return 0x900;
+
+	/* Finally check if an external interrupt happened */
+	local_paca->irq_happened &= ~PACA_HAPPENED_EE;
+	if (happened & PACA_HAPPENED_EE)
+		return 0x500;
+
+#ifdef CONFIG_PPC_BOOK3E
+	local_paca->irq_happened &= ~PACA_HAPPENED_PERFMON;
+	if (happened & PACA_HAPPENED_PERFMON)
+		return 0x260;
+
+	local_paca->irq_happened &= ~PACA_HAPPENED_DBELL;
+	if (happened & PACA_HAPPENED_DBELL)
+		return 0x280;
+#endif /* CONFIG_PPC_BOOK3E */
+
+	/* There should be nothing left ! */
+	BUG_ON(local_paca->irq_happened != 0);
 
+	return 0;
+}
+
+notrace void arch_local_irq_restore(unsigned long en)
+{
+	unsigned int reemit;
+
+	/* Write the new soft-enabled value */
+	set_soft_enabled(en);
+	if (!en)
+		return;
 	/*
-	 * Need to hard-enable interrupts here.  Since currently disabled,
-	 * no need to take further asm precautions against preemption; but
-	 * use local_paca instead of get_paca() to avoid preemption checking.
+	 * From this point onward, we can take interrupts, preempt,
+	 * etc... unless we got hard-disabled. We check if an event
+	 * happened. If none happened, we know we can just return.
+	 *
+	 * We may have preempted before the check below, in which case
+	 * we are checking the "new" CPU instead of the old one. This
+	 * is only a problem if an event happened on the "old" CPU.
+	 *
+	 * External interrupt events on non-iseries will have caused
+	 * interrupts to be hard-disabled, so there is no problem, we
+	 * cannot have preempted.
+	 *
+	 * That leaves us with EEs on iSeries or decrementer interrupts,
+	 * which I decided to safely ignore. The preemption would have
+	 * itself been the result of an interrupt, upon which return we
+	 * will have checked for pending events on the old CPU.
 	 */
-	local_paca->hard_enabled = en;
+	if (!get_irq_happened())
+		return;
+	/*
+	 * We need to hard disable to get a trusted value from
+	 * __check_irq_reemit(). We also need to soft-disable
+	 * again to avoid warnings in there due to the use of
+	 * per-cpu variables.
+	 */
+	__hard_irq_disable();
+	set_soft_enabled(0);
 
 	/*
-	 * Trigger the decrementer if we have a pending event. Some processors
-	 * only trigger on edge transitions of the sign bit. We might also
-	 * have disabled interrupts long enough that the decrementer wrapped
-	 * to positive.
+	 * Check if anything needs to be re-emitted. We haven't
+	 * soft-enabled yet to avoid warnings in decrementer_check_overflow
+	 * accessing per-cpu variables
 	 */
-	decrementer_check_overflow();
+	reemit = __check_irq_reemit();
+
+	/* We can soft-enable now */
+	set_soft_enabled(1);
 
 	/*
-	 * Force the delivery of pending soft-disabled interrupts on PS3.
-	 * Any HV call will have this side effect.
+	 * And re-emit if we have to. This will return with interrupts
+	 * hard-enabled.
 	 */
-	if (firmware_has_feature(FW_FEATURE_PS3_LV1)) {
-		u64 tmp, tmp2;
-		lv1_get_version_info(&tmp, &tmp2);
+	if (reemit) {
+		__reemit_interrupt(reemit);
+		return;
 	}
 
+	/* Finally, let's ensure we are hard enabled */
 	__hard_irq_enable();
 }
 EXPORT_SYMBOL(arch_local_irq_restore);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 567dd7c..61b7e17 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -259,7 +259,6 @@ void accumulate_stolen_time(void)
 	u64 sst, ust;
 
 	u8 save_soft_enabled = local_paca->soft_enabled;
-	u8 save_hard_enabled = local_paca->hard_enabled;
 
 	/* We are called early in the exception entry, before
 	 * soft/hard_enabled are sync'ed to the expected state
@@ -268,7 +267,6 @@ void accumulate_stolen_time(void)
 	 * complain
 	 */
 	local_paca->soft_enabled = 0;
-	local_paca->hard_enabled = 0;
 
 	sst = scan_dispatch_log(local_paca->starttime_user);
 	ust = scan_dispatch_log(local_paca->starttime);
@@ -277,7 +275,6 @@ void accumulate_stolen_time(void)
 	local_paca->stolen_time += ust + sst;
 
 	local_paca->soft_enabled = save_soft_enabled;
-	local_paca->hard_enabled = save_hard_enabled;
 }
 
 static inline u64 calculate_stolen_time(u64 stop_tb)
diff --git a/arch/powerpc/platforms/iseries/Makefile b/arch/powerpc/platforms/iseries/Makefile
index a7602b1..7208589 100644
--- a/arch/powerpc/platforms/iseries/Makefile
+++ b/arch/powerpc/platforms/iseries/Makefile
@@ -2,7 +2,7 @@ ccflags-y	:= -mno-minimal-toc
 
 obj-y += exception.o
 obj-y += hvlog.o hvlpconfig.o lpardata.o setup.o dt.o mf.o lpevents.o \
-	hvcall.o proc.o htab.o iommu.o misc.o irq.o
+	hvcall.o proc.o htab.o iommu.o irq.o
 obj-$(CONFIG_PCI) += pci.o
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_VIOPATH) += viopath.o vio.o
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index f519ee1..06cafb6 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -32,6 +32,7 @@
 #include <asm/ptrace.h>
 #include <asm/cputable.h>
 #include <asm/mmu.h>
+#include <asm/hw_irq.h>
 
 #include "exception.h"
 
@@ -261,16 +262,20 @@ system_call_iSeries:
 
 decrementer_iSeries_masked:
 	/* We may not have a valid TOC pointer in here. */
-	li	r11,1
+	li	r11,PACA_HAPPENED_DEC
 	ld	r12,PACALPPACAPTR(r13)
 	stb	r11,LPPACADECRINT(r12)
 	li	r12,-1
 	clrldi	r12,r12,33	/* set DEC to 0x7fffffff */
 	mtspr	SPRN_DEC,r12
-	/* fall through */
+	b	1f
 
 hardware_interrupt_iSeries_masked:
-	mtcrf	0x80,r9		/* Restore regs */
+	li	r11,PACA_HAPPENED_EE
+1:	mtcrf	0x80,r9		/* Restore regs */
+	lbz	r10,PACAIRQHAPPENED(r13)
+	ori	r11,r10,r11
+	stb	r11,PACAIRQHAPPENED(r13)
 	ld	r12,PACALPPACAPTR(r13)
 	ld	r11,LPPACASRR0(r12)
 	ld	r12,LPPACASRR1(r12)
diff --git a/arch/powerpc/platforms/iseries/misc.S b/arch/powerpc/platforms/iseries/misc.S
deleted file mode 100644
index 2c6ff0f..0000000
--- a/arch/powerpc/platforms/iseries/misc.S
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * This file contains miscellaneous low-level functions.
- *    Copyright (C) 1995-2005 IBM Corp
- *
- * Largely rewritten by Cort Dougan (cort@cs.nmt.edu)
- * and Paul Mackerras.
- * Adapted for iSeries by Mike Corrigan (mikejc@us.ibm.com)
- * PPC64 updates by Dave Engebretsen (engebret@us.ibm.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <asm/processor.h>
-#include <asm/asm-offsets.h>
-#include <asm/ppc_asm.h>
-
-	.text
-
-/* Handle pending interrupts in interrupt context */
-_GLOBAL(iseries_handle_interrupts)
-	li	r0,0x5555
-	sc
-	blr
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index 085fd3f..019a529 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -96,6 +96,25 @@ out:
 	return index;
 }
 
+static int check_and_cede_processor(void)
+{
+	/*
+	 * Interrupts are soft-disabled at this point,
+	 * but not hard disabled. So an interrupt might have
+	 * occurred before entering NAP, and would be potentially
+	 * lost (edge events, decrementer events, etc...) unless
+	 * we first hard disable then check.
+	 *
+	 * We must use the low level __hard_irq_disable() and not
+	 * hard_irq_disable() as the later will set a bit in
+	 * paca->irq_happened (to force re-enable later) which we
+	 * don't need nor want here.
+	 */
+	__hard_irq_disable();
+	if (get_paca()->irq_happened == 0)
+		cede_processor();
+}
+
 static int dedicated_cede_loop(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
@@ -108,7 +127,8 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 
 	ppc64_runlatch_off();
 	HMT_medium();
-	cede_processor();
+
+	check_and_cede_processor();
 
 	get_lppaca()->donate_dedicated_cpu = 0;
 	dev->last_residency =
@@ -132,7 +152,7 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 	 * processor. When returning here, external interrupts
 	 * are enabled.
 	 */
-	cede_processor();
+	check_and_cede_processor();
 
 	dev->last_residency =
 		(int)idle_loop_epilog(in_purr, kt_before);
