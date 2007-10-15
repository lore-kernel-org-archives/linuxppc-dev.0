Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Oct 2007 17:28:18 +1000
Subject: [RFC/PATCH 2/2] powerpc: irqtrace support to 64-bit powerpc
In-Reply-To: <1192433296.924212.737979117370.qpush@grosgo>
Message-Id: <20071015072826.2D541DDE16@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the low level irq tracing hooks to the powerpc architecture
needed to enable full lockdep functionality

Some rework from Johannes initial version, removing the asm trampoline that
isn't needed (thus improving perfs) and fixing a couple of bugs such as
incorrect initial preempt_count on the softirq alternate stack.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---

 arch/powerpc/Kconfig            |    9 +++++
 arch/powerpc/kernel/entry_64.S  |   27 +++++++++++++++
 arch/powerpc/kernel/head_64.S   |   68 +++++++++++++++++++++++++++++-----------
 arch/powerpc/kernel/irq.c       |   17 ++++++++--
 arch/powerpc/kernel/ppc_ksyms.c |    4 --
 arch/powerpc/kernel/setup_64.c  |    6 +++
 include/asm-powerpc/exception.h |    7 ++--
 include/asm-powerpc/hw_irq.h    |   13 ++++---
 include/asm-powerpc/irqflags.h  |   23 ++++++-------
 include/asm-powerpc/rwsem.h     |   34 +++++++++++++++-----
 include/asm-powerpc/spinlock.h  |    1 
 11 files changed, 155 insertions(+), 54 deletions(-)

Index: linux-work/arch/powerpc/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/Kconfig	2007-10-15 17:10:11.000000000 +1000
+++ linux-work/arch/powerpc/Kconfig	2007-10-15 17:11:09.000000000 +1000
@@ -50,6 +50,15 @@ config STACKTRACE_SUPPORT
 	bool
 	default y
 
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	depends on PPC64
+	default y
+
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
Index: linux-work/arch/powerpc/kernel/irq.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/irq.c	2007-10-15 17:10:11.000000000 +1000
+++ linux-work/arch/powerpc/kernel/irq.c	2007-10-15 17:11:09.000000000 +1000
@@ -114,7 +114,7 @@ static inline void set_soft_enabled(unsi
 	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
 }
 
-void local_irq_restore(unsigned long en)
+void raw_local_irq_restore(unsigned long en)
 {
 	/*
 	 * get_paca()->soft_enabled = en;
@@ -175,6 +175,7 @@ void local_irq_restore(unsigned long en)
 
 	__hard_irq_enable();
 }
+EXPORT_SYMBOL(raw_local_irq_restore);
 #endif /* CONFIG_PPC64 */
 
 int show_interrupts(struct seq_file *p, void *v)
@@ -311,8 +312,20 @@ void do_IRQ(struct pt_regs *regs)
 				handler = &__do_IRQ;
 			irqtp->task = curtp->task;
 			irqtp->flags = 0;
+
+			/* Copy the softirq bits in preempt_count so that the
+			 * softirq checks work in the hardirq context.
+			 */
+			irqtp->preempt_count =
+				(irqtp->preempt_count & ~SOFTIRQ_MASK) |
+				(curtp->preempt_count & SOFTIRQ_MASK);
+
 			call_handle_irq(irq, desc, irqtp, handler);
 			irqtp->task = NULL;
+
+			/* Set any flag that may have been set on the
+			 * alternate stack
+			 */
 			if (irqtp->flags)
 				set_bits(irqtp->flags, &curtp->flags);
 		} else
@@ -358,7 +371,7 @@ void irq_ctx_init(void)
 		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
 		tp = softirq_ctx[i];
 		tp->cpu = i;
-		tp->preempt_count = SOFTIRQ_OFFSET;
+		tp->preempt_count = 0;
 
 		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
 		tp = hardirq_ctx[i];
Index: linux-work/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/ppc_ksyms.c	2007-10-15 17:10:11.000000000 +1000
+++ linux-work/arch/powerpc/kernel/ppc_ksyms.c	2007-10-15 17:11:09.000000000 +1000
@@ -49,10 +49,6 @@
 #include <asm/commproc.h>
 #endif
 
-#ifdef CONFIG_PPC64
-EXPORT_SYMBOL(local_irq_restore);
-#endif
-
 #ifdef CONFIG_PPC32
 extern void transfer_to_handler(void);
 extern void do_IRQ(struct pt_regs *regs);
Index: linux-work/include/asm-powerpc/hw_irq.h
===================================================================
--- linux-work.orig/include/asm-powerpc/hw_irq.h	2007-10-15 17:10:12.000000000 +1000
+++ linux-work/include/asm-powerpc/hw_irq.h	2007-10-15 17:11:09.000000000 +1000
@@ -27,7 +27,7 @@ static inline unsigned long local_get_fl
 	return flags;
 }
 
-static inline unsigned long local_irq_disable(void)
+static inline unsigned long raw_local_irq_disable(void)
 {
 	unsigned long flags, zero;
 
@@ -39,14 +39,15 @@ static inline unsigned long local_irq_di
 	return flags;
 }
 
-extern void local_irq_restore(unsigned long);
+extern void raw_local_irq_restore(unsigned long);
 extern void iseries_handle_interrupts(void);
 
-#define local_irq_enable()	local_irq_restore(1)
-#define local_save_flags(flags)	((flags) = local_get_flags())
-#define local_irq_save(flags)	((flags) = local_irq_disable())
+#define raw_local_irq_enable()		raw_local_irq_restore(1)
+#define raw_local_save_flags(flags)	((flags) = local_get_flags())
+#define raw_local_irq_save(flags)	((flags) = raw_local_irq_disable())
 
-#define irqs_disabled()		(local_get_flags() == 0)
+#define raw_irqs_disabled()		(local_get_flags() == 0)
+#define raw_irqs_disabled_flags(flags)	((flags) == 0)
 
 #define __hard_irq_enable()	__mtmsrd(mfmsr() | MSR_EE, 1)
 #define __hard_irq_disable()	__mtmsrd(mfmsr() & ~MSR_EE, 1)
Index: linux-work/include/asm-powerpc/irqflags.h
===================================================================
--- linux-work.orig/include/asm-powerpc/irqflags.h	2007-10-15 17:10:12.000000000 +1000
+++ linux-work/include/asm-powerpc/irqflags.h	2007-10-15 17:11:09.000000000 +1000
@@ -2,30 +2,29 @@
  * include/asm-powerpc/irqflags.h
  *
  * IRQ flags handling
- *
- * This file gets included from lowlevel asm headers too, to provide
- * wrapped versions of the local_irq_*() APIs, based on the
- * raw_local_irq_*() macros from the lowlevel headers.
  */
 #ifndef _ASM_IRQFLAGS_H
 #define _ASM_IRQFLAGS_H
 
+#ifndef __ASSEMBLY__
 /*
  * Get definitions for raw_local_save_flags(x), etc.
  */
 #include <asm-powerpc/hw_irq.h>
 
+#else
+#ifdef CONFIG_TRACE_IRQFLAGS
 /*
- * Do the CPU's IRQ-state tracing from assembly code. We call a
- * C function, so save all the C-clobbered registers:
+ * Most of the CPU's IRQ-state tracing is done from assembly code; we
+ * have to call a C function so call a wrapper that saves all the
+ * C-clobbered registers.
  */
-#ifdef CONFIG_TRACE_IRQFLAGS
-
-#error No support on PowerPC yet for CONFIG_TRACE_IRQFLAGS
-
+#define TRACE_ENABLE_INTS	bl .trace_hardirqs_on
+#define TRACE_DISABLE_INTS	bl .trace_hardirqs_off
 #else
-# define TRACE_IRQS_ON
-# define TRACE_IRQS_OFF
+#define TRACE_ENABLE_INTS
+#define TRACE_DISABLE_INTS
+#endif
 #endif
 
 #endif
Index: linux-work/include/asm-powerpc/rwsem.h
===================================================================
--- linux-work.orig/include/asm-powerpc/rwsem.h	2007-10-15 17:10:12.000000000 +1000
+++ linux-work/include/asm-powerpc/rwsem.h	2007-10-15 17:11:09.000000000 +1000
@@ -32,11 +32,21 @@ struct rw_semaphore {
 #define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
 	spinlock_t		wait_lock;
 	struct list_head	wait_list;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define __RWSEM_DEP_MAP_INIT(lockname) , .dep_map = { .name = #lockname }
+#else
+# define __RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
 #define __RWSEM_INITIALIZER(name) \
 	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) }
+	  LIST_HEAD_INIT((name).wait_list) \
+	  __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name)		\
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
@@ -46,12 +56,15 @@ extern struct rw_semaphore *rwsem_down_w
 extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
 
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-}
+extern void __init_rwsem(struct rw_semaphore *sem, const char *name,
+			 struct lock_class_key *key);
+
+#define init_rwsem(sem)					\
+	do {						\
+		static struct lock_class_key __key;	\
+							\
+		__init_rwsem((sem), #sem, &__key);	\
+	} while (0)
 
 /*
  * lock for reading
@@ -78,7 +91,7 @@ static inline int __down_read_trylock(st
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
+static inline void __down_write_nested(struct rw_semaphore *sem, int subclass)
 {
 	int tmp;
 
@@ -88,6 +101,11 @@ static inline void __down_write(struct r
 		rwsem_down_write_failed(sem);
 }
 
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	__down_write_nested(sem, 0);
+}
+
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
 	int tmp;
Index: linux-work/include/asm-powerpc/spinlock.h
===================================================================
--- linux-work.orig/include/asm-powerpc/spinlock.h	2007-10-15 17:10:12.000000000 +1000
+++ linux-work/include/asm-powerpc/spinlock.h	2007-10-15 17:11:09.000000000 +1000
@@ -19,6 +19,7 @@
  *
  * (the type definitions are in asm/spinlock_types.h)
  */
+#include <linux/irqflags.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #include <asm/hvcall.h>
Index: linux-work/include/asm-powerpc/exception.h
===================================================================
--- linux-work.orig/include/asm-powerpc/exception.h	2007-10-15 17:10:12.000000000 +1000
+++ linux-work/include/asm-powerpc/exception.h	2007-10-15 17:11:09.000000000 +1000
@@ -232,14 +232,15 @@ BEGIN_FW_FTR_SECTION;				\
 	mfmsr	r10;				\
 	ori	r10,r10,MSR_EE;			\
 	mtmsrd	r10,1;				\
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES);	\
+	TRACE_DISABLE_INTS
 
 #else
 #define DISABLE_INTS				\
 	li	r11,0;				\
 	stb	r11,PACASOFTIRQEN(r13);		\
-	stb	r11,PACAHARDIRQEN(r13)
-
+	stb	r11,PACAHARDIRQEN(r13);		\
+	TRACE_DISABLE_INTS
 #endif /* CONFIG_PPC_ISERIES */
 
 #define ENABLE_INTS				\
Index: linux-work/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_64.S	2007-10-15 17:10:11.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_64.S	2007-10-15 17:11:09.000000000 +1000
@@ -36,8 +36,7 @@
 #include <asm/firmware.h>
 #include <asm/page_64.h>
 #include <asm/exception.h>
-
-#define DO_SOFT_DISABLE
+#include <asm/irqflags.h>
 
 /*
  * We layout physical memory as follows:
@@ -450,24 +449,35 @@ bad_stack:
  */
 fast_exc_return_irq:			/* restores irq state too */
 	ld	r3,SOFTE(r1)
-	ld	r12,_MSR(r1)
+#ifdef CONFIG_TRACE_IRQFLAGS
+	cmpdi	r3,0
+	bne	1f
 	stb	r3,PACASOFTIRQEN(r13)	/* restore paca->soft_enabled */
+	bl	.trace_hardirqs_off
+	b	2f
+1:
+	bl	.trace_hardirqs_on
+	li	r3,1
+#endif /* CONFIG_TRACE_IRQFLAGS */
+	stb	r3,PACASOFTIRQEN(r13)	/* restore paca->soft_enabled */
+2:
+	ld	r12,_MSR(r1)
 	rldicl	r4,r12,49,63		/* get MSR_EE to LSB */
 	stb	r4,PACAHARDIRQEN(r13)	/* restore paca->hard_enabled */
-	b	1f
+	b	3f
 
 	.globl	fast_exception_return
 fast_exception_return:
 	ld	r12,_MSR(r1)
-1:	ld	r11,_NIP(r1)
+3:	ld	r11,_NIP(r1)
 	andi.	r3,r12,MSR_RI		/* check if RI is set */
 	beq-	unrecov_fer
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	andi.	r3,r12,MSR_PR
-	beq	2f
+	beq	4f
 	ACCOUNT_CPU_USER_EXIT(r3, r4)
-2:
+4:
 #endif
 
 	ld	r3,_CCR(r1)
@@ -820,6 +830,25 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 
 	/*
+	 * On iSeries, we soft-disable interrupts here, then
+	 * hard-enable interrupts so that the hash_page code can spin on
+	 * the hash_table_lock without problems on a shared processor.
+	 */
+	DISABLE_INTS
+
+	/*
+	 * Currently, trace_hardirqs_off() will be called by DISABLE_INTS
+	 * and will clobber volatile registers when irq tracing is enabled
+	 * so we need to reload them. It may be possible to be smarter here
+	 * and move the irq tracing elsewhere but let's keep it simple for
+	 * now
+	 */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	ld	r3,_DAR(r1)
+	ld	r4,_DSISR(r1)
+	ld	r5,_TRAP(r1)
+#endif /* CONFIG_TRACE_IRQFLAGS */
+	/*
 	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
 	 * accessing a userspace segment (even from the kernel). We assume
 	 * kernel addresses always have the high bit set.
@@ -832,13 +861,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	rlwimi	r4,r5,22+2,31-2,31-2	/* Set _PAGE_EXEC if trap is 0x400 */
 
 	/*
-	 * On iSeries, we soft-disable interrupts here, then
-	 * hard-enable interrupts so that the hash_page code can spin on
-	 * the hash_table_lock without problems on a shared processor.
-	 */
-	DISABLE_INTS
-
-	/*
 	 * r3 contains the faulting address
 	 * r4 contains the required access permissions
 	 * r5 contains the trap number
@@ -848,7 +870,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	bl	.hash_page		/* build HPTE if possible */
 	cmpdi	r3,0			/* see if hash_page succeeded */
 
-#ifdef DO_SOFT_DISABLE
 BEGIN_FW_FTR_SECTION
 	/*
 	 * If we had interrupts soft-enabled at the point where the
@@ -860,7 +881,7 @@ BEGIN_FW_FTR_SECTION
 	 */
 	beq	13f
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif
+
 BEGIN_FW_FTR_SECTION
 	/*
 	 * Here we have interrupts hard-disabled, so it is sufficient
@@ -874,11 +895,22 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISER
 
 	/*
 	 * hash_page couldn't handle it, set soft interrupt enable back
-	 * to what it was before the trap.  Note that .local_irq_restore
+	 * to what it was before the trap.  Note that .raw_local_irq_restore
 	 * handles any interrupts pending at this point.
 	 */
 	ld	r3,SOFTE(r1)
-	bl	.local_irq_restore
+#ifdef CONFIG_TRACE_IRQFLAGS
+	cmpdi	r3,0
+	bne	14f
+	bl	.raw_local_irq_restore
+	bl	.trace_hardirqs_off
+	b	15f
+14:
+	bl	.trace_hardirqs_on
+	li	r3,1
+#endif /* CONFIG_TRACE_IRQFLAGS */
+	bl	.raw_local_irq_restore
+15:
 	b	11f
 
 /* Here we have a page fault that hash_page can't handle. */
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2007-10-15 17:10:11.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2007-10-15 17:11:09.000000000 +1000
@@ -33,6 +33,7 @@
 #include <linux/serial_8250.h>
 #include <linux/bootmem.h>
 #include <linux/pci.h>
+#include <linux/lockdep.h>
 #include <asm/io.h>
 #include <asm/kdump.h>
 #include <asm/prom.h>
@@ -359,6 +360,11 @@ void __init setup_system(void)
 			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
 
 	/*
+	 * start lockdep
+	 */
+	lockdep_init();
+
+	/*
 	 * Unflatten the device-tree passed by prom_init or kexec
 	 */
 	unflatten_device_tree();
Index: linux-work/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/entry_64.S	2007-10-15 17:10:11.000000000 +1000
+++ linux-work/arch/powerpc/kernel/entry_64.S	2007-10-15 17:13:28.000000000 +1000
@@ -29,6 +29,7 @@
 #include <asm/cputable.h>
 #include <asm/firmware.h>
 #include <asm/bug.h>
+#include <asm/irqflags.h>
 
 /*
  * System calls.
@@ -88,6 +89,13 @@ system_call_common:
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r9)		/* "regshere" marker */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	.trace_hardirqs_on
+	REST_GPR(0,r1)
+	REST_4GPRS(3,r1)
+	REST_2GPRS(7,r1)
+	addi	r9,r1,STACK_FRAME_OVERHEAD
+#endif /* CONFIG_TRACE_IRQFLAGS */
 	li	r10,1
 	stb	r10,PACASOFTIRQEN(r13)
 	stb	r10,PACAHARDIRQEN(r13)
@@ -500,14 +508,27 @@ BEGIN_FW_FTR_SECTION
 	stb	r3,PACASOFTIRQEN(r13)	/* ensure we are soft-disabled */
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10			/* hard-enable again */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	.trace_hardirqs_off
+#endif
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_IRQ
 	b	.ret_from_except_lite		/* loop back and handle more */
 4:
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
+#ifdef CONFIG_TRACE_IRQFLAGS
+	cmpdi	r5,0
+	bne	5f
 	stb	r5,PACASOFTIRQEN(r13)
-
+	bl	.trace_hardirqs_off
+	b	6f
+5:
+	bl	.trace_hardirqs_on
+	li	r5,1
+#endif
+	stb	r5,PACASOFTIRQEN(r13)
+6:
 	/* extract EE bit and use it to restore paca->hard_enabled */
 	ld	r3,_MSR(r1)
 	rldicl	r4,r3,49,63		/* r0 = (r3 >> 15) & 1 */
@@ -574,6 +595,10 @@ do_work:
 	bne	restore
 	/* here we are preempting the current task */
 1:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	.trace_hardirqs_on
+	mfmsr	r10		/* Get current interrupt state */
+#endif /* CONFIG_TRACE_IRQFLAGS */
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13)
 	stb	r0,PACAHARDIRQEN(r13)
