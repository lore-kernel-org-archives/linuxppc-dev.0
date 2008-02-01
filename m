Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 349A5DDEB7
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 06:50:56 +1100 (EST)
Date: Fri, 1 Feb 2008 12:50:40 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <20080201195040.GA8950@farnsworth.org>
MIME-Version: 1.0
Subject: [RFC/PATCH] powerpc: Add irqtrace support to 32-bit powerpc
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the low level irq tracing hooks for 32-bit powerpc.
This patch applies on top of Benjamin Herrenschmidt's patch that
provides similar support for 64-bit powerpc.  See
<http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044361.html>

It seems to work on my prpmc2800 board with a ppc7447.

Dale Farnsworth <dale@farnsworth.org>
---

 arch/powerpc/Kconfig           |    1 -
 arch/powerpc/kernel/entry_32.S |   80 ++++++++++++++++++++++++++++-
 arch/powerpc/kernel/setup_32.c |    2 +
 include/asm-powerpc/hw_irq.h   |   20 ++++----
 include/asm-powerpc/system.h   |    3 +-
 5 files changed, 90 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c313e68..933e98b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -52,7 +52,6 @@ config STACKTRACE_SUPPORT
 
 config TRACE_IRQFLAGS_SUPPORT
 	bool
-	depends on PPC64
 	default y
 
 config LOCKDEP_SUPPORT
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 69a91bd..f7d2c75 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -144,6 +144,37 @@ transfer_to_handler:
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
 3:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	lis	r11,reenable_mmu@h
+	ori	r11,r11,reenable_mmu@l
+	mtspr	SPRN_SRR0,r11
+	mtspr	SPRN_SRR1,r10
+	SYNC
+	RFI
+reenable_mmu:				/* re-enable mmu so we can */
+	mflr	r9			/* call C code, if necessary */
+	mfmsr	r10
+	lwz	r11,_MSR(r1)
+	xor	r10,r10,r11
+	andi.	r10,r10,MSR_EE
+	beq	1f
+	stwu	r1,-16(r1)
+	stw	r9,20(r1)
+	stw	r3,12(r1)
+	bl      trace_hardirqs_off
+	lwz	r3,12(r1)
+	lwz	r9,20(r1)
+	addi	r1,r1,16
+	REST_GPR(4,r1)
+	REST_4GPRS(5,r1)
+1:
+	tovirt(r9,r9)
+	lwz	r11,0(r9)		/* virtual address of handler */
+	lwz	r9,4(r9)		/* where to go when done */
+	mtctr	r11
+	mtlr	r9
+	bctr				/* jump to handler */
+#else /* CONFIG_TRACE_IRQFLAGS */
 	mflr	r9
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
@@ -152,6 +183,7 @@ transfer_to_handler_cont:
 	mtlr	r9
 	SYNC
 	RFI				/* jump to handler, enable MMU */
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
 #ifdef CONFIG_6xx
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
@@ -220,12 +252,20 @@ ret_from_syscall:
 #ifdef SHOW_SYSCALLS
 	bl	do_show_syscall_exit
 #endif
-	mr	r6,r3
 	rlwinm	r12,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
 	/* disable interrupts so current_thread_info()->flags can't change */
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	SYNC
 	MTMSRD(r10)
+#ifdef CONFIG_TRACE_IRQFLAGS
+	stwu	r1,-16(r1)
+	stw	r3,12(r1)
+	bl      trace_hardirqs_off
+	lwz	r3,12(r1)
+	addi	r1,r1,16
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+#endif
+	mr	r6,r3
 	lwz	r9,TI_FLAGS(r12)
 	li	r8,-_LAST_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
@@ -237,6 +277,13 @@ ret_from_syscall:
 	oris	r11,r11,0x1000	/* Set SO bit in CR */
 	stw	r11,_CCR(r1)
 syscall_exit_cont:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	stwu	r1,-16(r1)
+	stw	r3,12(r1)
+	bl      trace_hardirqs_on
+	lwz	r3,12(r1)
+	addi	r1,r1,16
+#endif
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 	/* If the process has its own DBCR0 value, load it up.  The single
 	   step bit tells us that dbcr0 should be loaded. */
@@ -337,7 +384,10 @@ syscall_exit_work:
 4:	/* Anything which requires enabling interrupts? */
 	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
 	beq	ret_from_except
-
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl      trace_hardirqs_on
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+#endif
 	/* Re-enable interrupts */
 	ori	r10,r10,MSR_EE
 	SYNC
@@ -646,13 +696,22 @@ ret_from_except_full:
 
 	.globl	ret_from_except
 ret_from_except:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	mfmsr	r3
+#endif
 	/* Hard-disable interrupts so that current_thread_info()->flags
 	 * can't change between when we test it and when we return
 	 * from the interrupt. */
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC			/* Some chip revs have problems here... */
 	MTMSRD(r10)		/* disable interrupts */
-
+#ifdef CONFIG_TRACE_IRQFLAGS
+	andi.	r3,r3,MSR_EE
+	beq	1f			/* verified */
+	bl	trace_hardirqs_off
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+1:
+#endif
 	lwz	r3,_MSR(r1)	/* Returning to user mode? */
 	andi.	r0,r3,MSR_PR
 	beq	resume_kernel
@@ -709,6 +768,9 @@ restore:
 	stw	r6,icache_44x_need_flush@l(r4)
 1:
 #endif  /* CONFIG_44x */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_on
+#endif
 	lwz	r0,GPR0(r1)
 	lwz	r2,GPR2(r1)
 	REST_4GPRS(3, r1)
@@ -900,6 +962,10 @@ do_work:			/* r10 contains MSR_KERNEL here */
 	beq	do_user_signal
 
 do_resched:			/* r10 contains MSR_KERNEL here */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_on
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+#endif
 	ori	r10,r10,MSR_EE
 	SYNC
 	MTMSRD(r10)		/* hard-enable interrupts */
@@ -908,6 +974,10 @@ recheck:
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+#endif
 	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r9,TI_FLAGS(r9)
 	andi.	r0,r9,_TIF_NEED_RESCHED
@@ -915,6 +985,10 @@ recheck:
 	andi.	r0,r9,_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK
 	beq	restore_user
 do_user_signal:			/* r10 contains MSR_KERNEL here */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_on
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+#endif
 	ori	r10,r10,MSR_EE
 	SYNC
 	MTMSRD(r10)		/* hard-enable interrupts */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index cd870a8..725dd18 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -120,6 +120,8 @@ unsigned long __init early_init(unsigned long dt_ptr)
  */
 void __init machine_init(unsigned long dt_ptr, unsigned long phys)
 {
+	lockdep_init();
+
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
diff --git a/include/asm-powerpc/hw_irq.h b/include/asm-powerpc/hw_irq.h
index ad8c9f7..a5f347a 100644
--- a/include/asm-powerpc/hw_irq.h
+++ b/include/asm-powerpc/hw_irq.h
@@ -63,13 +63,13 @@ extern void iseries_handle_interrupts(void);
 
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
@@ -81,7 +81,7 @@ static inline void local_irq_disable(void)
 #endif
 }
 
-static inline void local_irq_enable(void)
+static inline void raw_local_irq_enable(void)
 {
 #ifdef CONFIG_BOOKE
 	__asm__ __volatile__("wrteei 1": : :"memory");
@@ -93,7 +93,7 @@ static inline void local_irq_enable(void)
 #endif
 }
 
-static inline void local_irq_save_ptr(unsigned long *flags)
+static inline void raw_local_irq_save_ptr(unsigned long *flags)
 {
 	unsigned long msr;
 	msr = mfmsr();
@@ -106,12 +106,12 @@ static inline void local_irq_save_ptr(unsigned long *flags)
 	__asm__ __volatile__("": : :"memory");
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
 
 #endif /* CONFIG_PPC64 */
 
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index 87be8c3..b8024b9 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -5,8 +5,7 @@
 #define _ASM_POWERPC_SYSTEM_H
 
 #include <linux/kernel.h>
-
-#include <asm/hw_irq.h>
+#include <linux/irqflags.h>
 
 /*
  * Memory barrier.
-- 
1.5.3.4
