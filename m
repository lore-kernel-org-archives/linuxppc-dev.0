Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CE964B7177
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 19:02:31 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 17 Jun 2009 19:01:53 +1000
Subject: [PATCH] powerpc: Add irqtrace support for 32-bit powerpc
Message-Id: <20090617090231.BCD5EDDDA0@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Based on initial work from: Dale Farnsworth <dale@farnsworth.org>

Add the low level irq tracing hooks for 32-bit powerpc needed
to enable full lockdep functionality.

The approach taken to deal with the code in entry_32.S is that
we don't trace all the transitions of MSR:EE when we just turn
it off to peek at TI_FLAGS without races. Only when we are
calling into C code or returning from exceptions with a state
that have changed from what lockdep thinks.

There's a little bugger though: If we take an exception that
keeps interrupts enabled (such as an alignment exception) while
interrupts are enabled, we will call trace_hardirqs_on() on the
way back spurriously. Not a big deal, but to get rid of it would
require remembering in pt_regs that the exception was one of the
type that kept interrupts enabled which we don't know at this
stage. (Well, we could test all cases for regs->trap but that
sucks too much).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Not very well tested ... got issues with my u-boot on the 440
board and I didn't have much time to test elsewhere. FSL welcome
to test on funky configs. It's likely to still be subtely broken :-)

 arch/powerpc/Kconfig              |    1 
 arch/powerpc/include/asm/hw_irq.h |   20 +++---
 arch/powerpc/kernel/entry_32.S    |  126 ++++++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/setup_32.c    |    2 
 arch/powerpc/kernel/udbg.c        |    1 
 5 files changed, 135 insertions(+), 15 deletions(-)

--- linux-work.orig/arch/powerpc/Kconfig	2009-06-17 16:45:15.000000000 +1000
+++ linux-work/arch/powerpc/Kconfig	2009-06-17 16:45:36.000000000 +1000
@@ -62,7 +62,6 @@ config HAVE_LATENCYTOP_SUPPORT
 
 config TRACE_IRQFLAGS_SUPPORT
 	bool
-	depends on PPC64
 	default y
 
 config LOCKDEP_SUPPORT
Index: linux-work/arch/powerpc/kernel/entry_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/entry_32.S	2009-06-17 16:45:15.000000000 +1000
+++ linux-work/arch/powerpc/kernel/entry_32.S	2009-06-17 18:29:23.000000000 +1000
@@ -191,11 +191,49 @@ transfer_to_handler_cont:
 	mflr	r9
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	lis	r12,reenable_mmu@h
+	ori	r12,r12,reenable_mmu@l
+	mtspr	SPRN_SRR0,r12
+	mtspr	SPRN_SRR1,r10
+	SYNC
+	RFI
+reenable_mmu:				/* re-enable mmu so we can */
+	mfmsr	r10
+	lwz	r12,_MSR(r1)
+	xor	r10,r10,r12
+	andi.	r10,r10,MSR_EE		/* Did EE change? */
+	beq	1f
+
+	/* Save handler and return address into the 2 unused words
+	 * of the STACK_FRAME_OVERHEAD (sneak sneak sneak). Everything
+	 * else can be recovered from the pt_regs except r3 which for
+	 * normal interrupts has been set to pt_regs and for syscalls
+	 * is an argument, so we temporarily use ORIG_GPR3 to save it
+	 */
+	stw	r9,8(r1)
+	stw	r11,12(r1)
+	stw	r3,ORIG_GPR3(r1)
+	bl	trace_hardirqs_off
+	lwz	r0,GPR0(r1)
+	lwz	r3,ORIG_GPR3(r1)
+	lwz	r4,GPR4(r1)
+	lwz	r5,GPR5(r1)
+	lwz	r6,GPR6(r1)
+	lwz	r7,GPR7(r1)
+	lwz	r8,GPR8(r1)
+	lwz	r9,8(r1)
+	lwz	r11,12(r1)
+1:	mtctr	r11
+	mtlr	r9
+	bctr				/* jump to handler */
+#else /* CONFIG_TRACE_IRQFLAGS */
 	mtspr	SPRN_SRR0,r11
 	mtspr	SPRN_SRR1,r10
 	mtlr	r9
 	SYNC
 	RFI				/* jump to handler, enable MMU */
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
 #if defined (CONFIG_6xx) || defined(CONFIG_E500)
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
@@ -251,6 +289,31 @@ _GLOBAL(DoSyscall)
 #ifdef SHOW_SYSCALLS
 	bl	do_show_syscall
 #endif /* SHOW_SYSCALLS */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* Return from syscalls can (and generally will) hard enable
+	 * interrupts. You aren't supposed to call a syscall with
+	 * interrupts disabled in the first place. However, to ensure
+	 * that we get it right vs. lockdep if it happens, we force
+	 * that hard enable here with appropriate tracing if we see
+	 * that we have been called with interrupts off
+	 */
+	mfmsr	r11
+	andi.	r12,r11,MSR_EE
+	bne+	1f
+	/* We came in with interrupts disabled, we enable them now */
+	bl	trace_hardirqs_on
+	mfmsr	r11
+	lwz	r0,GPR0(r1)
+	lwz	r3,GPR3(r1)
+	lwz	r4,GPR4(r1)
+	ori	r11,r11,MSR_EE
+	lwz	r5,GPR5(r1)
+	lwz	r6,GPR6(r1)
+	lwz	r7,GPR7(r1)
+	lwz	r8,GPR8(r1)
+	mtmsr	r11
+1:
+#endif /* CONFIG_TRACE_IRQFLAGS */
 	rlwinm	r10,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
 	lwz	r11,TI_FLAGS(r10)
 	andi.	r11,r11,_TIF_SYSCALL_T_OR_A
@@ -275,6 +338,7 @@ ret_from_syscall:
 	rlwinm	r12,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
 	/* disable interrupts so current_thread_info()->flags can't change */
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
+	/* Note: We don't bother telling lockdep about it */
 	SYNC
 	MTMSRD(r10)
 	lwz	r9,TI_FLAGS(r12)
@@ -288,6 +352,19 @@ ret_from_syscall:
 	oris	r11,r11,0x1000	/* Set SO bit in CR */
 	stw	r11,_CCR(r1)
 syscall_exit_cont:
+	lwz	r8,_MSR(r1)
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* If we are going to return from the syscall with interrupts
+	 * off, we trace that here. It shouldn't happen though but we
+	 * want to catch the bugger if it does right ?
+	 */
+	andi.	r10,r8,MSR_EE
+	bne+	1f
+	stw	r3,GPR3(r1)
+	bl      trace_hardirqs_off
+	lwz	r3,GPR3(r1)
+1:
+#endif /* CONFIG_TRACE_IRQFLAGS */
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 	/* If the process has its own DBCR0 value, load it up.  The internal
 	   debug mode bit tells us that dbcr0 should be loaded. */
@@ -311,7 +388,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRE
 	mtlr	r4
 	mtcr	r5
 	lwz	r7,_NIP(r1)
-	lwz	r8,_MSR(r1)
 	FIX_SRR1(r8, r0)
 	lwz	r2,GPR2(r1)
 	lwz	r1,GPR1(r1)
@@ -394,7 +470,9 @@ syscall_exit_work:
 	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
 	beq	ret_from_except
 
-	/* Re-enable interrupts */
+	/* Re-enable interrupts. There is no need to trace that with
+	 * lockdep as we are supposed to have IRQs on at this point
+	 */
 	ori	r10,r10,MSR_EE
 	SYNC
 	MTMSRD(r10)
@@ -705,6 +783,7 @@ ret_from_except:
 	/* Hard-disable interrupts so that current_thread_info()->flags
 	 * can't change between when we test it and when we return
 	 * from the interrupt. */
+	/* Note: We don't bother telling lockdep about it */
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC			/* Some chip revs have problems here... */
 	MTMSRD(r10)		/* disable interrupts */
@@ -744,11 +823,24 @@ resume_kernel:
 	beq+	restore
 	andi.	r0,r3,MSR_EE	/* interrupts off? */
 	beq	restore		/* don't schedule if so */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* Lockdep thinks irqs are enabled, we need to call
+	 * preempt_schedule_irq with IRQs off, so we inform lockdep
+	 * now that we -did- turn them off already
+	 */
+	bl	trace_hardirqs_off
+#endif
 1:	bl	preempt_schedule_irq
 	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r3,TI_FLAGS(r9)
 	andi.	r0,r3,_TIF_NEED_RESCHED
 	bne-	1b
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* And now, to properly rebalance the above, we tell lockdep they
+	 * are being turned back on, which will happen when we return
+	 */
+	bl	trace_hardirqs_on
+#endif
 #else
 resume_kernel:
 #endif /* CONFIG_PREEMPT */
@@ -781,8 +873,28 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1			/* to clear the reservation */
 
-#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	lwz	r9,_MSR(r1)
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* Lockdep doesn't know about the fact that IRQs are temporarily turned
+	 * off in this assembly code while peeking at TI_FLAGS() and such. However
+	 * we need to inform it if the exception turned interrupts off, and we
+	 * are about to trun them back on.
+	 *
+	 * The problem here sadly is that we don't know whether the exceptions was
+	 * one that turned interrupts off or not. So we always tell lockdep about
+	 * turning them on here when we go back to wherever we came from with EE
+	 * on, even if that may meen some redudant calls being tracked. Maybe later
+	 * we could encode what the exception did somewhere or test the exception
+	 * type in the pt_regs but that sounds overkill
+	 */
+	andi.	r10,r9,MSR_EE
+	beq	1f
+	bl	trace_hardirqs_on
+	lwz	r9,_MSR(r1)
+1:
+#endif /* CONFIG_TRACE_IRQFLAGS */
+
+#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	andi.	r10,r9,MSR_RI		/* check if this exception occurred */
 	beql	nonrecoverable		/* at a bad place (MSR:RI = 0) */
 
@@ -805,7 +917,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRE
 	MTMSRD(r10)		/* clear the RI bit */
 	.globl exc_exit_restart
 exc_exit_restart:
-	lwz	r9,_MSR(r1)
 	lwz	r12,_NIP(r1)
 	FIX_SRR1(r9,r10)
 	mtspr	SPRN_SRR0,r12
@@ -1035,11 +1146,18 @@ do_work:			/* r10 contains MSR_KERNEL he
 	beq	do_user_signal
 
 do_resched:			/* r10 contains MSR_KERNEL here */
+	/* Note: We don't need to inform lockdep that we are enabling
+	 * interrupts here. As far as it knows, they are already enabled
+	 */
 	ori	r10,r10,MSR_EE
 	SYNC
 	MTMSRD(r10)		/* hard-enable interrupts */
 	bl	schedule
 recheck:
+	/* Note: And we don't tell it we are disabling them again
+	 * neither. Those disable/enable cycles used to peek at
+	 * TI_FLAGS aren't advertised.
+	 */
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
Index: linux-work/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_32.c	2009-06-17 16:45:15.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_32.c	2009-06-17 18:29:37.000000000 +1000
@@ -119,6 +119,8 @@ notrace unsigned long __init early_init(
  */
 notrace void __init machine_init(unsigned long dt_ptr)
 {
+	lockdep_init();
+
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
Index: linux-work/arch/powerpc/include/asm/hw_irq.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/hw_irq.h	2009-06-17 16:45:15.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/hw_irq.h	2009-06-17 16:45:36.000000000 +1000
@@ -68,13 +68,13 @@ static inline int irqs_disabled_flags(un
 
 #if defined(CONFIG_BOOKE)
 #define SET_MSR_EE(x)	mtmsr(x)
-#define local_irq_restore(flags)	__asm__ __volatile__("wrtee %0" : : "r" (flags) : "memory")
+#define raw_local_irq_restore(flags)	__asm__ __volatile__("wrtee %0" : : "r" (flags) : "memory")
 #else
 #define SET_MSR_EE(x)	mtmsr(x)
-#define local_irq_restore(flags)	mtmsr(flags)
+#define raw_local_irq_restore(flags)	mtmsr(flags)
 #endif
 
-static inline void local_irq_disable(void)
+static inline void raw_local_irq_disable(void)
 {
 #ifdef CONFIG_BOOKE
 	__asm__ __volatile__("wrteei 0": : :"memory");
@@ -86,7 +86,7 @@ static inline void local_irq_disable(voi
 #endif
 }
 
-static inline void local_irq_enable(void)
+static inline void raw_local_irq_enable(void)
 {
 #ifdef CONFIG_BOOKE
 	__asm__ __volatile__("wrteei 1": : :"memory");
@@ -98,7 +98,7 @@ static inline void local_irq_enable(void
 #endif
 }
 
-static inline void local_irq_save_ptr(unsigned long *flags)
+static inline void raw_local_irq_save_ptr(unsigned long *flags)
 {
 	unsigned long msr;
 	msr = mfmsr();
@@ -110,12 +110,12 @@ static inline void local_irq_save_ptr(un
 #endif
 }
 
-#define local_save_flags(flags)	((flags) = mfmsr())
-#define local_irq_save(flags)	local_irq_save_ptr(&flags)
-#define irqs_disabled()		((mfmsr() & MSR_EE) == 0)
+#define raw_local_save_flags(flags)	((flags) = mfmsr())
+#define raw_local_irq_save(flags)	raw_local_irq_save_ptr(&flags)
+#define raw_irqs_disabled()		((mfmsr() & MSR_EE) == 0)
+#define raw_irqs_disabled_flags(flags)	(((flags) & MSR_EE) == 0)
 
-#define hard_irq_enable()	local_irq_enable()
-#define hard_irq_disable()	local_irq_disable()
+#define hard_irq_disable()		raw_local_irq_disable()
 
 static inline int irqs_disabled_flags(unsigned long flags)
 {
Index: linux-work/arch/powerpc/kernel/udbg.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/udbg.c	2009-06-17 17:14:41.000000000 +1000
+++ linux-work/arch/powerpc/kernel/udbg.c	2009-06-17 17:14:43.000000000 +1000
@@ -65,6 +65,7 @@ void __init udbg_early_init(void)
 #ifdef CONFIG_PPC_EARLY_DEBUG
 	console_loglevel = 10;
 #endif
+	register_early_udbg_console();
 }
 
 /* udbg library, used by xmon et al */
