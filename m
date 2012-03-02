Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A04511007D7
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2012 20:36:17 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Fri, 2 Mar 2012 09:29:39 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q229a6K01179872
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2012 20:36:07 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q229a58R026470
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2012 20:36:06 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/12] powerpc: Rework lazy-interrupt handling
Date: Fri,  2 Mar 2012 20:35:22 +1100
Message-Id: <1330680922-6894-13-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
References: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
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

We don't do the various workarounds we need to do when re-enabling
interrupts in some cases such as when returning from an interrupt
and thus we may still lose or get delayed decrementer or doorbell
interrupts.

The current scheme also makes it much harder to handle the external
"edge" interrupts provided by some BookE processors when using the
EPR facility (External Proxy) and the Freescale Hypervisor.

Additionally, we tend to keep interrupts hard disabled in a number
of cases, such as decrementer interrupts, external interrupts, or
when a masked decrementer interrupt is pending. This is sub-optimal.

This is an attempt at fixing it all in one go by reworking the way
we do the lazy interrupt disabling from the ground up.

The base idea is to replace the "hard_enabled" field with a
"irq_happened" field in which we store a bit mask of what interrupt
occurred while soft-disabled.

When re-enabling, either via arch_local_irq_restore() or when returning
from an interrupt, we can now decide what to do by testing bits in that
field.

We then implement replaying of the missed interrupts either by
re-using the existing exception frame (in exception exit case) or via
the creation of a new one from an assembly trampoline (in the
arch_local_irq_enable case).

This removes the need to play with the decrementer to try to create
fake interrupts, among others.

In addition, this adds a few refinements:

 - We no longer  hard disable decrementer interrupts that occur
while soft-disabled. We now simply bump the decrementer back to max
(on BookS) or leave it stopped (on BookE) and continue with hard interrupts
enabled, which means that we'll potentially get better sample quality from
performance monitor interrupts.

 - Timer, decrementer and doorbell interrupts now hard-enable
shortly after removing the source of the interrupt, which means
they no longer run entirely hard disabled. Again, this will improve
perf sample quality.

 - On Book3E 64-bit, we now make the performance monitor interrupt
act as an NMI like Book3S (the necessary C code for that to work
appear to already be present in the FSL perf code, notably calling
nmi_enter instead of irq_enter). (This also fixes a bug where BookE
perfmon interrupts could clobber r14 ... oops)

 - We could make "masked" decrementer interrupts act as NMIs when doing
timer-based perf sampling to improve the sample quality.

Signed-off-by-yet: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2:

- Add hard-enable to decrementer, timer and doorbells
- Fix CR clobber in masked irq handling on BookE
- Make embedded perf interrupt act as an NMI
- Add a PACA_HAPPENED_EE_EDGE for use by FSL if they want
  to retrigger an interrupt without preventing hard-enable

v3:

 - Fix or vs. ori bug on Book3E
 - Fix enabling of interrupts for some exceptions on Book3E

v4:

 - Fix resend of doorbells on return from interrupt on Book3E

v5:

 - Rebased on top of my latest series, which involves some significant
rework of some aspects of the patch.
---
 arch/powerpc/include/asm/exception-64s.h        |   29 ++-
 arch/powerpc/include/asm/hw_irq.h               |   49 +++++-
 arch/powerpc/include/asm/irqflags.h             |   16 --
 arch/powerpc/include/asm/paca.h                 |    2 +-
 arch/powerpc/kernel/asm-offsets.c               |    2 +-
 arch/powerpc/kernel/dbell.c                     |    2 +
 arch/powerpc/kernel/entry_64.S                  |  154 ++++++++++++----
 arch/powerpc/kernel/exceptions-64e.S            |  224 +++++++++++++++--------
 arch/powerpc/kernel/exceptions-64s.S            |  150 ++++++---------
 arch/powerpc/kernel/head_64.S                   |   24 ++-
 arch/powerpc/kernel/idle.c                      |    6 +-
 arch/powerpc/kernel/idle_book3e.S               |   25 +--
 arch/powerpc/kernel/idle_power4.S               |   24 ++-
 arch/powerpc/kernel/idle_power7.S               |   17 ++-
 arch/powerpc/kernel/irq.c                       |  204 +++++++++++++++------
 arch/powerpc/kernel/process.c                   |   26 +++
 arch/powerpc/kernel/time.c                      |    8 +-
 arch/powerpc/platforms/pseries/processor_idle.c |   18 ++-
 arch/powerpc/xmon/xmon.c                        |    4 +-
 19 files changed, 652 insertions(+), 332 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 70354af..3066341 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -232,23 +232,30 @@ label##_hv:						\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_HV, KVMTEST, vec)
 
-#define __SOFTEN_TEST(h)						\
+/* This associate vector numbers with bits in paca->irq_happened */
+#define SOFTEN_VALUE_0x500	PACA_IRQ_EE
+#define SOFTEN_VALUE_0x502	PACA_IRQ_EE
+#define SOFTEN_VALUE_0x900	PACA_IRQ_DEC
+#define SOFTEN_VALUE_0x982	PACA_IRQ_DEC
+
+#define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	cmpwi	r10,0;							\
+	li	r10,SOFTEN_VALUE_##vec;					\
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
@@ -282,18 +289,22 @@ label##_hv:								\
 #ifdef CONFIG_TRACE_IRQFLAGS
 #define DISABLE_INTS				\
 	lbz	r10,PACASOFTIRQEN(r13);		\
-	li	r11,0;				\
+	lbz	r11,PACAIRQHAPPENED(r13);	\
 	cmpwi	cr0,r10,0;			\
-	stb	r11,PACAHARDIRQEN(r13);		\
+	li	r10,0;				\
+	ori	r11,r11,PACA_IRQ_HARD_DIS;	\
+	stb	r11,PACAIRQHAPPENED(r13);	\
 	beq	44f;				\
-	stb	r11,PACASOFTIRQEN(r13);		\
+	stb	r10,PACASOFTIRQEN(r13);		\
 	TRACE_DISABLE_INTS;			\
 44:
 #else
 #define DISABLE_INTS				\
+	lbz	r10,PACAIRQHAPPENED(r13);	\
 	li	r11,0;				\
+	ori	r10,r10,PACA_IRQ_HARD_DIS;	\
 	stb	r11,PACASOFTIRQEN(r13);		\
-	stb	r11,PACAHARDIRQEN(r13)
+	stb	r10,PACAIRQHAPPENED(r13)
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 /* Exception addition: Keep interrupt state */
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 6c6fa95..6fa8259 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -11,6 +11,27 @@
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 
+#ifdef CONFIG_PPC64
+
+/*
+ * PACA flags in paca->irq_happened.
+ *
+ * This bits are set when interrupts occur while soft-disabled
+ * and allow a proper replay. Additionally, PACA_HARD_DISABLED
+ * is set whenever we manually hard disable.
+ */
+#define PACA_IRQ_HARD_DIS	0x01
+#define PACA_IRQ_DBELL		0x02
+#define PACA_IRQ_EE		0x04
+#define PACA_IRQ_DEC		0x08 /* Or FIT */
+#define PACA_IRQ_EE_EDGE	0x10 /* BookE only */
+
+#endif /* CONFIG_PPC64 */
+
+#ifndef __ASSEMBLY__
+
+extern void __replay_interrupt(unsigned int vector);
+
 extern void timer_interrupt(struct pt_regs *);
 
 #ifdef CONFIG_PPC64
@@ -42,7 +63,6 @@ static inline unsigned long arch_local_irq_disable(void)
 }
 
 extern void arch_local_irq_restore(unsigned long);
-extern void iseries_handle_interrupts(void);
 
 static inline void arch_local_irq_enable(void)
 {
@@ -72,12 +92,24 @@ static inline bool arch_irqs_disabled(void)
 #define __hard_irq_disable()	__mtmsrd(local_paca->kernel_msr, 1)
 #endif
 
-#define  hard_irq_disable()			\
-	do {					\
-		__hard_irq_disable();		\
-		get_paca()->soft_enabled = 0;	\
-		get_paca()->hard_enabled = 0;	\
-	} while(0)
+static inline void hard_irq_disable(void)
+{
+	__hard_irq_disable();
+	get_paca()->soft_enabled = 0;
+	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;
+}
+
+/*
+ * This is called by asynchronous interrupts to conditionally
+ * re-enable hard interrupts when soft-disabled after having
+ * cleared the source of the interrupt
+ */
+static inline void may_hard_irq_enable(void)
+{
+	get_paca()->irq_happened &= ~PACA_IRQ_HARD_DIS;
+	if (!(get_paca()->irq_happened & PACA_IRQ_EE))
+		__hard_irq_enable();
+}
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 {
@@ -149,6 +181,8 @@ static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 	return !(regs->msr & MSR_EE);
 }
 
+static inline may_hard_irq_enable(void) { }
+
 #endif /* CONFIG_PPC64 */
 
 #define ARCH_IRQ_INIT_FLAGS	IRQ_NOREQUEST
@@ -159,5 +193,6 @@ static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
  */
 struct irq_chip;
 
+#endif  /* __ASSEMBLY__ */
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_HW_IRQ_H */
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index b0b06d8..76b5aa7 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -38,25 +38,9 @@
  */
 #define TRACE_ENABLE_INTS	TRACE_WITH_FRAME_BUFFER(.trace_hardirqs_on)
 #define TRACE_DISABLE_INTS	TRACE_WITH_FRAME_BUFFER(.trace_hardirqs_off)
-
-#define TRACE_AND_RESTORE_IRQ_PARTIAL(en,skip)		\
-	cmpdi	en,0;					\
-	bne	95f;					\
-	stb	en,PACASOFTIRQEN(r13);			\
-	TRACE_WITH_FRAME_BUFFER(.trace_hardirqs_off)	\
-	b	skip;					\
-95:	TRACE_WITH_FRAME_BUFFER(.trace_hardirqs_on)	\
-	li	en,1;
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
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index 2cc451a..5b25c80 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -37,6 +37,8 @@ void doorbell_exception(struct pt_regs *regs)
 
 	irq_enter();
 
+	may_hard_irq_enable();
+
 	smp_ipi_demux();
 
 	irq_exit();
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index c513beb..545a54d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -583,18 +583,72 @@ _GLOBAL(ret_from_except_lite)
 	bne	do_work
 #endif /* !CONFIG_PREEMPT */
 
+	.globl	fast_exc_return_irq
+fast_exc_return_irq:
 restore:
+	/*
+	 * This is the main kernel exit path, we first check if we
+	 * have to change our interrupt state.
+	 */
 	ld	r5,SOFTE(r1)
-	TRACE_AND_RESTORE_IRQ(r5);
+	lbz	r6,PACASOFTIRQEN(r13)
+	cmpwi	cr1,r5,0
+	cmpw	cr0,r5,r6
+	beq	cr0,4f
+
+	/* We do, handle disable first, which is easy */
+	bne	cr1,3f;
+ 	li	r0,0
+	stb	r0,PACASOFTIRQEN(r13);
+	TRACE_DISABLE_INTS
+	b	4f
 
-	/* extract EE bit and use it to restore paca->hard_enabled */
-	ld	r3,_MSR(r1)
-	rldicl	r4,r3,49,63		/* r0 = (r3 >> 15) & 1 */
-	stb	r4,PACAHARDIRQEN(r13)
+3:	/*
+	 * We are about to soft-enable interrupts (we are hard disabled
+	 * at this point). We check if there's anything that needs to
+	 * be replayed first.
+	 */
+	lbz	r0,PACAIRQHAPPENED(r13)
+	cmpwi	cr0,r0,0
+	bne-	restore_check_irq_replay
+
+	/*
+	 * Get here when nothing happened while soft-disabled, just
+	 * soft-enable and move-on. We will hard-enable as a side
+	 * effect of rfi
+	 */
+restore_no_replay:
+	TRACE_ENABLE_INTS
+	li	r0,1
+	stb	r0,PACASOFTIRQEN(r13);
 
+	/*
+	 * Final return path. BookE is handled in a different file
+	 */
+4:
 #ifdef CONFIG_PPC_BOOK3E
 	b	.exception_return_book3e
 #else
+	/*
+	 * Clear the reservation. If we know the CPU tracks the address of
+	 * the reservation then we can potentially save some cycles and use
+	 * a larx. On POWER6 and POWER7 this is significantly faster.
+	 */
+BEGIN_FTR_SECTION
+	stdcx.	r0,0,r1		/* to clear the reservation */
+FTR_SECTION_ELSE
+	ldarx	r4,0,r1
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
+
+	/*
+	 * Some code path such as load_up_fpu or altivec return directly
+	 * here. They run entirely hard disabled and do not alter the
+	 * interrupt state. They also don't use lwarx/stwcx. and thus
+	 * are known not to leave dangling reservations.
+	 */
+	.globl	fast_exception_return
+fast_exception_return:
+	ld	r3,_MSR(r1)
 	ld	r4,_CTR(r1)
 	ld	r0,_LINK(r1)
 	mtctr	r4
@@ -608,17 +662,6 @@ restore:
 	beq-	unrecov_restore
 
 	/*
-	 * Clear the reservation. If we know the CPU tracks the address of
-	 * the reservation then we can potentially save some cycles and use
-	 * a larx. On POWER6 and POWER7 this is significantly faster.
-	 */
-BEGIN_FTR_SECTION
-	stdcx.	r0,0,r1		/* to clear the reservation */
-FTR_SECTION_ELSE
-	ldarx	r4,0,r1
-ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
-
-	/*
 	 * Clear RI before restoring r13.  If we are returning to
 	 * userspace and we take an exception after restoring r13,
 	 * we end up corrupting the userspace r13 value.
@@ -629,7 +672,8 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	/*
 	 * r13 is our per cpu area, only restore it if we are returning to
-	 * userspace
+	 * userspace the value stored in the stack frame may belong to
+	 * another CPU.
 	 */
 	andi.	r0,r3,MSR_PR
 	beq	1f
@@ -654,6 +698,55 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 #endif /* CONFIG_PPC_BOOK3E */
 
+	/*
+	 * Something did happen, check if a re-emit is needed
+	 * (this also clears paca->irq_happened)
+	 */
+restore_check_irq_replay:
+	/* XXX: We could implement a fast path here where we check
+	 * for irq_happened being just 0x01, in which case we can
+	 * clear it and return. That means that we would potentially
+	 * miss a decrementer having wrapped all the way around.
+	 *
+	 * Still, this might be useful for things like hash_page
+	 */
+	bl	.__check_irq_replay
+	cmpwi	cr0,r3,0
+ 	beq	restore_no_replay
+ 
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
+	*/
+	cmpwi	cr0,r3,0x500
+	bne	1f
+	addi	r3,r1,STACK_FRAME_OVERHEAD;
+ 	bl	.do_IRQ
+	b	.ret_from_except
+1:	cmpwi	cr0,r3,0x900
+	bne	1f
+	addi	r3,r1,STACK_FRAME_OVERHEAD;
+	bl	.timer_interrupt
+	b	.ret_from_except
+#ifdef CONFIG_PPC_BOOK3E
+1:	cmpwi	cr0,r3,0x280
+	bne	1f
+	addi	r3,r1,STACK_FRAME_OVERHEAD;
+	bl	.doorbell_exception
+	b	.ret_from_except
+#endif /* CONFIG_PPC_BOOK3E */
+1:	b	.ret_from_except /* What else to do here ? */
+ 
 do_work:
 #ifdef CONFIG_PREEMPT
 	andi.	r0,r3,MSR_PR	/* Returning to user mode? */
@@ -666,19 +759,12 @@ do_work:
 	crandc	eq,cr1*4+eq,eq
 	bne	restore
 
-	/* Here we are preempting the current task.
-	 *
-	 * Ensure interrupts are soft-disabled. We also properly mark
-	 * the PACA to reflect the fact that they are hard-disabled
-	 * and trace the change
+	/*
+	 * Here we are preempting the current task. We use a little
+	 * wrapper around preempt_schedule_irq() to deal with our
+	 * lazy interrupt state.
 	 */
-	li	r0,0
-	stb	r0,PACASOFTIRQEN(r13)
-	stb	r0,PACAHARDIRQEN(r13)
-	TRACE_DISABLE_INTS
-
-	/* Call the scheduler with soft IRQs off */
-1:	bl	.preempt_schedule_irq
+1:	bl	.preempt_schedule_irq_hard_enable
 
 	/* Hard-disable interrupts again (and update PACA) */
 #ifdef CONFIG_PPC_BOOK3E
@@ -687,8 +773,8 @@ do_work:
 	ld	r10,PACAKMSR(r13) /* Get kernel MSR without EE */
 	mtmsrd	r10,1
 #endif /* CONFIG_PPC_BOOK3E */
-	li	r0,0
-	stb	r0,PACAHARDIRQEN(r13)
+	li	r0,PACA_IRQ_HARD_DIS
+	stb	r0,PACAIRQHAPPENED(r13)
 
 	/* Re-test flags and eventually loop */
 	clrrdi	r9,r1,THREAD_SHIFT
@@ -710,14 +796,12 @@ user_work:
 
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	1f
-	li	r5,1
-	TRACE_AND_RESTORE_IRQ(r5);
+	bl	.restore_interrupts
 	bl	.schedule
 	b	.ret_from_except_lite
 
 1:	bl	.save_nvgprs
-	li	r5,1
-	TRACE_AND_RESTORE_IRQ(r5);
+	bl	.restore_interrupts
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_notify_resume
 	b	.ret_from_except
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 9d437b9..ad37cfc 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -24,6 +24,7 @@
 #include <asm/ptrace.h>
 #include <asm/ppc-opcode.h>
 #include <asm/mmu.h>
+#include <asm/hw_irq.h>
 
 /* XXX This will ultimately add space for a special exception save
  *     structure used to save things like SRR0/SRR1, SPRGs, MAS, etc...
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
+	beq	masked_interrupt_book3e_##n
 
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
@@ -167,20 +164,26 @@
 	std	r0,RESULT(r1);		/* clear regs->result */	    \
 	ints;
 
-/* Variants for the "ints" argument */
+/* Variants for the "ints" argument. This one does nothing when we want
+ * to keep interrupts in their original state
+ */
 #define INTS_KEEP
-#define INTS_DISABLE_SOFT						    \
+
+/* This second version is meant for exceptions that don't immediately
+ * hard-enable. We set a bit in paca->irq_happened to ensure that
+ * a subsequent call to arch_local_irq_restore() will properly
+ * hard-enable and avoid the fast-path
+ */
+#define INTS_DISABLE							    \
 	stb	r0,PACASOFTIRQEN(r13);	/* mark interrupts soft-disabled */ \
-	TRACE_DISABLE_INTS;
-#define INTS_DISABLE_HARD						    \
-	stb	r0,PACAHARDIRQEN(r13); /* and hard disabled */
-#define INTS_DISABLE_ALL						    \
-	INTS_DISABLE_SOFT						    \
-	INTS_DISABLE_HARD
-
-/* This is called by exceptions that used INTS_KEEP (that is did not clear
- * neither soft nor hard IRQ indicators in the PACA. This will restore MSR:EE
- * to it's previous value
+	lbz	r0,PACAIRQHAPPENED(r13);				    \
+	ori	r0,r0,PACA_IRQ_HARD_DIS;				    \
+	stb	r0,PACAIRQHAPPENED(r13);				    \
+	TRACE_DISABLE_INTS
+
+/* This is called by exceptions that used INTS_KEEP (that did not touch
+ * irq indicators in the PACA). This will restore MSR:EE to it's previous
+ * value
  *
  * XXX In the long run, we may want to open-code it in order to separate the
  *     load from the wrtee, thus limiting the latency caused by the dependency
@@ -238,7 +241,7 @@ exc_##n##_bad_stack:							    \
 #define MASKABLE_EXCEPTION(trapnum, label, hdlr, ack)			\
 	START_EXCEPTION(label);						\
 	NORMAL_EXCEPTION_PROLOG(trapnum, PROLOG_ADDITION_MASKABLE)	\
-	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE_ALL)		\
+	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE)		\
 	ack(r8);							\
 	CHECK_NAPPING();						\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
@@ -289,7 +292,7 @@ interrupt_end_book3e:
 /* Critical Input Interrupt */
 	START_EXCEPTION(critical_input);
 	CRIT_EXCEPTION_PROLOG(0x100, PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE_ALL)
+//	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE)
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -300,7 +303,7 @@ interrupt_end_book3e:
 /* Machine Check Interrupt */
 	START_EXCEPTION(machine_check);
 	CRIT_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE_ALL)
+//	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE)
 //	bl	special_reg_save_mc
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
 //	CHECK_NAPPING();
@@ -313,7 +316,7 @@ interrupt_end_book3e:
 	NORMAL_EXCEPTION_PROLOG(0x300, PROLOG_ADDITION_2REGS)
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
-	EXCEPTION_COMMON(0x300, PACA_EXGEN, INTS_DISABLE_ALL)
+	EXCEPTION_COMMON(0x300, PACA_EXGEN, INTS_DISABLE)
 	b	storage_fault_common
 
 /* Instruction Storage Interrupt */
@@ -321,7 +324,7 @@ interrupt_end_book3e:
 	NORMAL_EXCEPTION_PROLOG(0x400, PROLOG_ADDITION_2REGS)
 	li	r15,0
 	mr	r14,r10
-	EXCEPTION_COMMON(0x400, PACA_EXGEN, INTS_DISABLE_ALL)
+	EXCEPTION_COMMON(0x400, PACA_EXGEN, INTS_DISABLE)
 	b	storage_fault_common
 
 /* External Input Interrupt */
@@ -339,12 +342,11 @@ interrupt_end_book3e:
 	START_EXCEPTION(program);
 	NORMAL_EXCEPTION_PROLOG(0x700, PROLOG_ADDITION_1REG)
 	mfspr	r14,SPRN_ESR
-	EXCEPTION_COMMON(0x700, PACA_EXGEN, INTS_DISABLE_SOFT)
+	EXCEPTION_COMMON(0x700, PACA_EXGEN, INTS_DISABLE)
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ld	r14,PACA_EXGEN+EX_R14(r13)
 	bl	.save_nvgprs
-	INTS_RESTORE_HARD
 	bl	.program_check_exception
 	b	.ret_from_except
 
@@ -352,7 +354,7 @@ interrupt_end_book3e:
 	START_EXCEPTION(fp_unavailable);
 	NORMAL_EXCEPTION_PROLOG(0x800, PROLOG_ADDITION_NONE)
 	/* we can probably do a shorter exception entry for that one... */
-	EXCEPTION_COMMON(0x800, PACA_EXGEN, INTS_DISABLE_ALL)
+	EXCEPTION_COMMON(0x800, PACA_EXGEN, INTS_DISABLE)
 	bne	1f			/* if from user, just load it up */
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -371,7 +373,7 @@ interrupt_end_book3e:
 /* Watchdog Timer Interrupt */
 	START_EXCEPTION(watchdog);
 	CRIT_EXCEPTION_PROLOG(0x9f0, PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE_ALL)
+//	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE)
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -390,7 +392,7 @@ interrupt_end_book3e:
 /* Auxiliary Processor Unavailable Interrupt */
 	START_EXCEPTION(ap_unavailable);
 	NORMAL_EXCEPTION_PROLOG(0xf20, PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0xf20, PACA_EXGEN, INTS_DISABLE_ALL)
+	EXCEPTION_COMMON(0xf20, PACA_EXGEN, INTS_DISABLE)
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.unknown_exception
@@ -448,7 +450,7 @@ interrupt_end_book3e:
 	mfspr	r15,SPRN_SPRG_CRIT_SCRATCH
 	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
 	mfspr	r14,SPRN_DBSR
-	EXCEPTION_COMMON(0xd00, PACA_EXCRIT, INTS_DISABLE_ALL)
+	EXCEPTION_COMMON(0xd00, PACA_EXCRIT, INTS_DISABLE)
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mr	r4,r14
@@ -463,7 +465,7 @@ kernel_dbg_exc:
 
 /* Debug exception as a debug interrupt*/
 	START_EXCEPTION(debug_debug);
-	DBG_EXCEPTION_PROLOG(0xd00, PROLOG_ADDITION_2REGS)
+	DBG_EXCEPTION_PROLOG(0xd08, PROLOG_ADDITION_2REGS)
 
 	/*
 	 * If there is a single step or branch-taken exception in an
@@ -513,7 +515,7 @@ kernel_dbg_exc:
 	mfspr	r15,SPRN_SPRG_DBG_SCRATCH
 	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
 	mfspr	r14,SPRN_DBSR
-	EXCEPTION_COMMON(0xd00, PACA_EXDBG, INTS_DISABLE_ALL)
+	EXCEPTION_COMMON(0xd08, PACA_EXDBG, INTS_DISABLE)
 	std	r14,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mr	r4,r14
@@ -523,21 +525,20 @@ kernel_dbg_exc:
 	bl	.DebugException
 	b	.ret_from_except
 
-	MASKABLE_EXCEPTION(0x260, perfmon, .performance_monitor_exception, ACK_NONE)
-
-/* Doorbell interrupt */
-	START_EXCEPTION(doorbell)
-	NORMAL_EXCEPTION_PROLOG(0x2070, PROLOG_ADDITION_DOORBELL)
-	EXCEPTION_COMMON(0x2070, PACA_EXGEN, INTS_DISABLE_ALL)
-	CHECK_NAPPING()
+	START_EXCEPTION(perfmon);
+	NORMAL_EXCEPTION_PROLOG(0x260, PROLOG_ADDITION_NONE)
+	EXCEPTION_COMMON(0x260, PACA_EXGEN, INTS_DISABLE)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.doorbell_exception
+	bl	.performance_monitor_exception
 	b	.ret_from_except_lite
 
+/* Doorbell interrupt */
+	MASKABLE_EXCEPTION(0x280, doorbell, .doorbell_exception, ACK_NONE)
+
 /* Doorbell critical Interrupt */
 	START_EXCEPTION(doorbell_crit);
-	CRIT_EXCEPTION_PROLOG(0x2080, PROLOG_ADDITION_NONE)
-//	EXCEPTION_COMMON(0x2080, PACA_EXCRIT, INTS_DISABLE_ALL)
+	CRIT_EXCEPTION_PROLOG(0x2a0, PROLOG_ADDITION_NONE)
+//	EXCEPTION_COMMON(0x2a0, PACA_EXCRIT, INTS_DISABLE)
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -545,36 +546,114 @@ kernel_dbg_exc:
 //	b	ret_from_crit_except
 	b	.
 
+/* Guest Doorbell */
 	MASKABLE_EXCEPTION(0x2c0, guest_doorbell, .unknown_exception, ACK_NONE)
-	MASKABLE_EXCEPTION(0x2e0, guest_doorbell_crit, .unknown_exception, ACK_NONE)
-	MASKABLE_EXCEPTION(0x310, hypercall, .unknown_exception, ACK_NONE)
-	MASKABLE_EXCEPTION(0x320, ehpriv, .unknown_exception, ACK_NONE)
 
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
+masked_interrupt_book3e_0x500:
+	/* XXX When adding support for EPR, use PACA_IRQ_EE_EDGE */
+	li	r11,PACA_IRQ_EE
+	b	masked_interrupt_book3e_full_mask
+
+masked_interrupt_book3e_0x900:
+	ACK_DEC(r11);
+	li	r11,PACA_IRQ_DEC
+	b	masked_interrupt_book3e_no_mask
+masked_interrupt_book3e_0x980:
+	ACK_FIT(r11);
+	li	r11,PACA_IRQ_DEC
+	b	masked_interrupt_book3e_no_mask
+masked_interrupt_book3e_0x280:
+masked_interrupt_book3e_0x2c0:
+	li	r11,PACA_IRQ_DBELL
+	b	masked_interrupt_book3e_no_mask
+
+masked_interrupt_book3e_no_mask:
 	mtcr	r10
-masked_interrupt_book3e_common:
-	stb	r11,PACAHARDIRQEN(r13)
+	lbz	r10,PACAIRQHAPPENED(r13)
+	or	r10,r10,r11
+	stb	r10,PACAIRQHAPPENED(r13)
+	b	1f
+masked_interrupt_book3e_full_mask:
+	mtcr	r10
+	lbz	r10,PACAIRQHAPPENED(r13)
+	or	r10,r10,r11
+	stb	r10,PACAIRQHAPPENED(r13)
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
+/*
+ * Called from arch_local_irq_enable when an interrupt needs
+ * to be resent. r3 contains either 0x500,0x900,0x260 or 0x280
+ * to indicate the kind of interrupt. MSR:EE is already off.
+ * We generate a stackframe like if a real interrupt had happened.
+ *
+ * Note: While MSR:EE is off, we need to make sure that _MSR
+ * in the generated frame has EE set to 1 or the exception
+ * handler will not properly re-enable them.
+ */
+_GLOBAL(__replay_interrupt)
+	/* We are going to jump to the exception common code which
+	 * will retrieve various register values from the PACA which
+	 * we don't give a damn about.
+	 */
+	mflr	r10
+	mfmsr	r11
+	mfcr	r4
+	mtspr	SPRN_SPRG_GEN_SCRATCH,r13;
+	std	r1,PACA_EXGEN+EX_R1(r13);
+	stw	r4,PACA_EXGEN+EX_CR(r13);
+	ori	r11,r11,MSR_EE
+	subi	r1,r1,INT_FRAME_SIZE;
+	cmpwi	cr0,r3,0x500
+	beq	exc_0x500_common
+	cmpwi	cr0,r3,0x900
+	beq	exc_0x900_common
+	cmpwi	cr0,r3,0x280
+	beq	exc_0x280_common
+	blr
+
 
 /*
  * This is called from 0x300 and 0x400 handlers after the prologs with
@@ -677,6 +756,8 @@ BAD_STACK_TRAMPOLINE(0x000)
 BAD_STACK_TRAMPOLINE(0x100)
 BAD_STACK_TRAMPOLINE(0x200)
 BAD_STACK_TRAMPOLINE(0x260)
+BAD_STACK_TRAMPOLINE(0x280)
+BAD_STACK_TRAMPOLINE(0x2a0)
 BAD_STACK_TRAMPOLINE(0x2c0)
 BAD_STACK_TRAMPOLINE(0x2e0)
 BAD_STACK_TRAMPOLINE(0x300)
@@ -694,11 +775,10 @@ BAD_STACK_TRAMPOLINE(0xa00)
 BAD_STACK_TRAMPOLINE(0xb00)
 BAD_STACK_TRAMPOLINE(0xc00)
 BAD_STACK_TRAMPOLINE(0xd00)
+BAD_STACK_TRAMPOLINE(0xd08)
 BAD_STACK_TRAMPOLINE(0xe00)
 BAD_STACK_TRAMPOLINE(0xf00)
 BAD_STACK_TRAMPOLINE(0xf20)
-BAD_STACK_TRAMPOLINE(0x2070)
-BAD_STACK_TRAMPOLINE(0x2080)
 
 	.globl	bad_stack_book3e
 bad_stack_book3e:
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 880f360..74aadf5 100644
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
+ * and return, else we hard disable and return. This is called with
+ * r10 containing the value to OR to the paca field.
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
+#define MASKED_INTERRUPT(_H)				\
+masked_##_H##interrupt:					\
+	std	r11,PACA_EXGEN+EX_R11(r13);		\
+	lbz	r11,PACAIRQHAPPENED(r13);		\
+	or	r11,r11,r10;				\
+	stb	r11,PACAIRQHAPPENED(r13);		\
+	andi.	r10,r10,PACA_IRQ_DEC;			\
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
-	b	.
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
+_GLOBAL(__replay_interrupt)
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
@@ -795,7 +822,8 @@ vsx_unavailable_common:
 	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
 #ifdef CONFIG_VSX
 BEGIN_FTR_SECTION
-	bne	.load_up_vsx
+	beq	1f
+	b	.load_up_vsx
 1:
 END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
@@ -810,65 +838,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 __end_handlers:
 
 /*
- * Return from an exception with minimal checks.
- * The caller is assumed to have done EXCEPTION_PROLOG_COMMON.
- * If interrupts have been enabled, or anything has been
- * done that might have changed the scheduling status of
- * any task or sent any task a signal, you should use
- * ret_from_except or ret_from_except_lite instead of this.
- */
-fast_exc_return_irq:			/* restores irq state too */
-	ld	r3,SOFTE(r1)
-	TRACE_AND_RESTORE_IRQ(r3);
-	ld	r12,_MSR(r1)
-	rldicl	r4,r12,49,63		/* get MSR_EE to LSB */
-	stb	r4,PACAHARDIRQEN(r13)	/* restore paca->hard_enabled */
-	b	1f
-
-	.globl	fast_exception_return
-fast_exception_return:
-	ld	r12,_MSR(r1)
-1:	ld	r11,_NIP(r1)
-	andi.	r3,r12,MSR_RI		/* check if RI is set */
-	beq-	unrecov_fer
-
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	andi.	r3,r12,MSR_PR
-	beq	2f
-	ACCOUNT_CPU_USER_EXIT(r3, r4)
-2:
-#endif
-
-	ld	r3,_CCR(r1)
-	ld	r4,_LINK(r1)
-	ld	r5,_CTR(r1)
-	ld	r6,_XER(r1)
-	mtcr	r3
-	mtlr	r4
-	mtctr	r5
-	mtxer	r6
-	REST_GPR(0, r1)
-	REST_8GPRS(2, r1)
-
-	ld	r10,PACAKMSR(r13)
-	clrrdi	r10,r10,2		/* clear RI */
-	mtmsrd	r10,1
-
-	mtspr	SPRN_SRR1,r12
-	mtspr	SPRN_SRR0,r11
-	REST_4GPRS(10, r1)
-	ld	r1,GPR1(r1)
-	rfid
-	b	.	/* prevent speculative execution */
-
-unrecov_fer:
-	bl	.save_nvgprs
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.unrecoverable_exception
-	b	1b
-
-
-/*
  * Hash table stuff
  */
 	.align	7
@@ -907,19 +876,16 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 	 * r4 contains the required access permissions
 	 * r5 contains the trap number
 	 *
-	 * at return r3 = 0 for success
+	 * at return r3 = 0 for success, 1 for page fault, negative for error
 	 */
 	bl	.hash_page		/* build HPTE if possible */
 	cmpdi	r3,0			/* see if hash_page succeeded */
 
-	/*
-	 * Here we have interrupts hard-disabled, so it is sufficient
-	 * to restore paca->{soft,hard}_enable and get out.
-	 */
+	/* Success */
 	beq	fast_exc_return_irq	/* Return from exception on success */
 
-	/* For a hash failure, we don't bother re-enabling interrupts */
-	ble-	13f
+	/* Error */
+	blt-	13f
 
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 40759fb..58bddee 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -38,6 +38,7 @@
 #include <asm/irqflags.h>
 #include <asm/kvm_book3s_asm.h>
 #include <asm/ptrace.h>
+#include <asm/hw_irq.h>
 
 /* The physical memory is laid out such that the secondary processor
  * spin code sits at 0x0000...0x00ff. On server, the vectors follow
@@ -550,7 +551,8 @@ _GLOBAL(pmac_secondary_start)
 	 */
 	li	r0,0
 	stb	r0,PACASOFTIRQEN(r13)
-	stb	r0,PACAHARDIRQEN(r13)
+	li	r0,PACA_IRQ_HARD_DIS
+	stb	r0,PACAIRQHAPPENED(r13)
 
 	/* Create a temp kernel stack for use before relocation is on.	*/
 	ld	r1,PACAEMERGSP(r13)
@@ -601,9 +603,12 @@ __secondary_start:
 	li	r7,0
 	mtlr	r7
 
-	/* Mark interrupts both hard and soft disabled */
-	stb	r7,PACAHARDIRQEN(r13)
+	/* Mark interrupts soft and hard disabled (they might be enabled
+	 * in the PACA when doing hotplug)
+	 */
 	stb	r7,PACASOFTIRQEN(r13)
+	li	r0,PACA_IRQ_HARD_DIS
+	stb	r0,PACAIRQHAPPENED(r13)
 
 	/* enable MMU and jump to start_secondary */
 	LOAD_REG_ADDR(r3, .start_secondary_prolog)
@@ -750,13 +755,18 @@ _INIT_GLOBAL(start_here_common)
 	/* Load the TOC (virtual address) */
 	ld	r2,PACATOC(r13)
 
+	/* Do more system initializations in virtual mode */
 	bl	.setup_system
 
-	/* Load up the kernel context */
-5:	li	r5,0
-	stb	r5,PACASOFTIRQEN(r13)	/* Soft Disabled */
-	stb	r5,PACAHARDIRQEN(r13)	/* Hard Disabled on others */
+	/* Mark interrupts soft and hard disabled (they might be enabled
+	 * in the PACA when doing hotplug)
+	 */
+	li	r0,0
+	stb	r0,PACASOFTIRQEN(r13)
+	li	r0,PACA_IRQ_HARD_DIS
+	stb	r0,PACAIRQHAPPENED(r13)
 
+	/* Generic kernel entry */
 	bl	.start_kernel
 
 	/* Not reached */
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 0a48bf5..8f7a2b6 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -84,7 +84,11 @@ void cpu_idle(void)
 
 				start_critical_timings();
 
-				local_irq_enable();
+				/* Some power_save functions return with
+				 * interrupts enabled, some don't.
+				 */
+				if (irqs_disabled())
+					local_irq_enable();
 				set_thread_flag(TIF_POLLING_NRFLAG);
 
 			} else {
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index 16c002d..ff007b5 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -29,43 +29,30 @@ _GLOBAL(book3e_idle)
 	wrteei	0
 
 	/* Now check if an interrupt came in while we were soft disabled
-	 * since we may otherwise lose it (doorbells etc...). We know
-	 * that since PACAHARDIRQEN will have been cleared in that case.
+	 * since we may otherwise lose it (doorbells etc...).
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
 #ifdef CONFIG_TRACE_IRQFLAGS
 	stdu    r1,-128(r1)
 	bl	.trace_hardirqs_on
+	addi    r1,r1,128
 #endif
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13)
-	stb	r0,PACAHARDIRQEN(r13)
 	
 	/* Interrupts will make use return to LR, so get something we want
 	 * in there
 	 */
 	bl	1f
 
-	/* Hard disable interrupts again */
-	wrteei	0
-
-	/* Mark them off again in the PACA as well */
-	li	r0,0
-	stb	r0,PACASOFTIRQEN(r13)
-	stb	r0,PACAHARDIRQEN(r13)
-
-	/* Tell lockdep about it */
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	.trace_hardirqs_off
-	addi    r1,r1,128
-#endif
+	/* And return (interrupts are on) */
 	ld	r0,16(r1)
 	mtlr	r0
 	blr
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index ba31954..d8cdba4c2 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -14,6 +14,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/irqflags.h>
 
 #undef DEBUG
 
@@ -29,14 +30,31 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	cmpwi	0,r4,0
 	beqlr
 
-	/* Go to NAP now */
+	/* Hard disable interrupts */
 	mfmsr	r7
 	rldicl	r0,r7,48,1
 	rotldi	r0,r0,16
-	mtmsrd	r0,1			/* hard-disable interrupts */
+	mtmsrd	r0,1
+
+	/* Check if something happened while soft-disabled */
+	lbz	r0,PACAIRQHAPPENED(r13)
+	cmpwi	cr0,r0,0
+	bnelr
+
+	/* Soft-enable interrupts */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	mflr	r0
+	std	r0,16(r1)
+	stdu    r1,-128(r1)
+	bl	.trace_hardirqs_on
+	addi    r1,r1,128
+	ld	r0,16(r1)
+	mtlr	r0
+#endif /* CONFIG_TRACE_IRQFLAGS */
+
+	TRACE_ENABLE_INTS
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
-	stb	r0,PACAHARDIRQEN(r13)
 BEGIN_FTR_SECTION
 	DSSALL
 	sync
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index fcdff19..24a8313 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -1,5 +1,5 @@
 /*
- *  This file contains the power_save function for 970-family CPUs.
+ *  This file contains the power_save function for Power7 CPUs.
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -51,9 +51,18 @@ _GLOBAL(power7_idle)
 	rldicl	r9,r9,48,1
 	rotldi	r9,r9,16
 	mtmsrd	r9,1			/* hard-disable interrupts */
-	li	r0,0
-	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
-	stb	r0,PACAHARDIRQEN(r13)
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
+	/* We haven't lost state ... yet */
+1:	li	r0,0
 	stb	r0,PACA_NAPSTATELOST(r13)
 
 	/* Continue saving state */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 01e2877..0d56737 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -99,14 +99,14 @@ EXPORT_SYMBOL(irq_desc);
 
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
@@ -115,88 +115,167 @@ static inline notrace void set_soft_enabled(unsigned long enable)
 	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
 }
 
-static inline notrace void decrementer_check_overflow(void)
+static inline notrace int decrementer_check_overflow(void)
 {
-	u64 now = get_tb_or_rtc();
-	u64 *next_tb;
-
-	preempt_disable();
-	next_tb = &__get_cpu_var(decrementers_next_tb);
-
+ 	u64 now = get_tb_or_rtc();
+ 	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
+ 
 	if (now >= *next_tb)
 		set_dec(1);
-	preempt_enable();
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
+notrace unsigned int __check_irq_replay(void)
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
+	/* Clear bit 0 which we wouldn't clear otherwise */
+	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
+
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
+	 */
+	local_paca->irq_happened &= ~PACA_IRQ_DEC;
+	if (decrementer_check_overflow())
+		return 0x900;
+
+	/* Finally check if an external interrupt happened */
+	local_paca->irq_happened &= ~PACA_IRQ_EE;
+	if (happened & PACA_IRQ_EE)
+		return 0x500;
+
+#ifdef CONFIG_PPC_BOOK3E
+	/* Finally check if an EPR external interrupt happened
+	 * this bit is typically set if we need to handle another
+	 * "edge" interrupt from within the MPIC "EPR" handler
+	 */
+	local_paca->irq_happened &= ~PACA_IRQ_EE_EDGE;
+	if (happened & PACA_IRQ_EE_EDGE)
+		return 0x500;
+
+	local_paca->irq_happened &= ~PACA_IRQ_DBELL;
+	if (happened & PACA_IRQ_DBELL)
+		return 0x280;
+#endif /* CONFIG_PPC_BOOK3E */
+
+	/* There should be nothing left ! */
+	BUG_ON(local_paca->irq_happened != 0);
+
+	return 0;
+}
+
+notrace void arch_local_irq_restore(unsigned long en)
+{
+	unsigned char irq_happened;
+	unsigned int replay;
+
+	/* Write the new soft-enabled value */
+	set_soft_enabled(en);
+	if (!en)
+		return;
+	/*
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
-	if (get_hard_enabled())
+	irq_happened = get_irq_happened();
+	if (!irq_happened)
 		return;
 
 	/*
-	 * Need to hard-enable interrupts here.  Since currently disabled,
-	 * no need to take further asm precautions against preemption; but
-	 * use local_paca instead of get_paca() to avoid preemption checking.
+	 * We need to hard disable to get a trusted value from
+	 * __check_irq_replay(). We also need to soft-disable
+	 * again to avoid warnings in there due to the use of
+	 * per-cpu variables.
+	 *
+	 * We know that if the value in irq_happened is exactly 0x01
+	 * then we are already hard disabled (there are other less
+	 * common cases that we'll ignore for now), so we skip the
+	 * (expensive) mtmsrd.
 	 */
-	local_paca->hard_enabled = en;
+	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
+		__hard_irq_disable();
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
+	replay = __check_irq_replay();
+
+	/* We can soft-enable now */
+	set_soft_enabled(1);
 
 	/*
-	 * Force the delivery of pending soft-disabled interrupts on PS3.
-	 * Any HV call will have this side effect.
+	 * And replay if we have to. This will return with interrupts
+	 * hard-enabled.
 	 */
-	if (firmware_has_feature(FW_FEATURE_PS3_LV1)) {
-		u64 tmp, tmp2;
-		lv1_get_version_info(&tmp, &tmp2);
+	if (replay) {
+		__replay_interrupt(replay);
+		return;
 	}
 
+	/* Finally, let's ensure we are hard enabled */
 	__hard_irq_enable();
 }
 EXPORT_SYMBOL(arch_local_irq_restore);
+
+/*
+ * This is specifically called by assembly code to re-enable interrupts
+ * if they are currently disabled. This is typically called before
+ * schedule() or do_signal() when returning to userspace. We do it
+ * in C to avoid the burden of dealing with lockdep etc...
+ */
+void restore_interrupts(void)
+{
+	if (irqs_disabled())
+		local_irq_enable();
+}
+
 #endif /* CONFIG_PPC64 */
 
 int arch_show_interrupts(struct seq_file *p, int prec)
@@ -364,8 +443,17 @@ void do_IRQ(struct pt_regs *regs)
 
 	check_stack_overflow();
 
+	/*
+	 * Query the platform PIC for the interrupt & ack it.
+	 *
+	 * This will typically lower the interrupt line to the CPU
+	 */
 	irq = ppc_md.get_irq();
 
+	/* We can hard enable interrupts now */
+	may_hard_irq_enable();
+
+	/* And finally process it */
 	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE)
 		handle_one_irq(irq);
 	else if (irq != NO_IRQ_IGNORE)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bf80a1d..b215b52 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -647,6 +647,9 @@ void show_regs(struct pt_regs * regs)
 	printk("MSR: "REG" ", regs->msr);
 	printbits(regs->msr, msr_bits);
 	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
+#ifdef CONFIG_PPC64
+	printk("SOFTE: %ld\n", regs->softe);
+#endif
 	trap = TRAP(regs);
 	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
 		printk("CFAR: "REG"\n", regs->orig_gpr3);
@@ -1332,3 +1335,26 @@ unsigned long randomize_et_dyn(unsigned long base)
 
 	return ret;
 }
+
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_PP64)
+/*
+ * This is called from assembly in a state where irqs are hard
+ * disabled (but potentially not marked as such in the PACA)
+ * and may or may not be soft-disabled depending on what we
+ * are returning from.
+ *
+ * We sanitize our interrupt state and preempt
+ */
+void preempt_schedule_irq_hard_enable(void)
+{
+	/* Ensure we are soft-disabled */
+	if (!irqs_disabled())
+		local_irq_disable();
+
+	/* Check if we can hard enable interrupts */
+	may_hard_enable_irq();
+
+	/* Schedule */
+	preempt_schedule_irq();
+}
+#endif /* defined(CONFIG_PREEMPT) && defined(CONFIG_PP64) */
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 567dd7c..f81c81b 100644
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
@@ -580,6 +577,11 @@ void timer_interrupt(struct pt_regs * regs)
 	if (!cpu_online(smp_processor_id()))
 		return;
 
+	/* Conditionally hard-enable interrupts now that the DEC has been
+	 * bumped to its maximum value
+	 */
+	may_hard_irq_enable();
+
 	trace_timer_interrupt_entry(regs);
 
 	__get_cpu_var(irq_stat).timer_irqs++;
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index 085fd3f..a12e95a 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -96,6 +96,20 @@ out:
 	return index;
 }
 
+static void check_and_cede_processor(void)
+{
+	/*
+	 * Interrupts are soft-disabled at this point,
+	 * but not hard disabled. So an interrupt might have
+	 * occurred before entering NAP, and would be potentially
+	 * lost (edge events, decrementer events, etc...) unless
+	 * we first hard disable then check.
+	 */
+	hard_irq_disable();
+	if (get_paca()->irq_happened == 0)
+		cede_processor();
+}
+
 static int dedicated_cede_loop(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
@@ -108,7 +122,7 @@ static int dedicated_cede_loop(struct cpuidle_device *dev,
 
 	ppc64_runlatch_off();
 	HMT_medium();
-	cede_processor();
+	check_and_cede_processor();
 
 	get_lppaca()->donate_dedicated_cpu = 0;
 	dev->last_residency =
@@ -132,7 +146,7 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 	 * processor. When returning here, external interrupts
 	 * are enabled.
 	 */
-	cede_processor();
+	check_and_cede_processor();
 
 	dev->last_residency =
 		(int)idle_loop_epilog(in_purr, kt_before);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 63846eb..974a47b 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1437,8 +1437,8 @@ static void excprint(struct pt_regs *fp)
 
 	printf("  current = 0x%lx\n", current);
 #ifdef CONFIG_PPC64
-	printf("  paca    = 0x%lx\t softe: %d\t harde: %d\n",
-	       local_paca, local_paca->soft_enabled, local_paca->hard_enabled);
+	printf("  paca    = 0x%lx\t softe: %d\t irq_happened: 0x%02x\n",
+	       local_paca, local_paca->soft_enabled, local_paca->irq_happened);
 #endif
 	if (current) {
 		printf("    pid   = %ld, comm = %s\n",
-- 
1.7.9
