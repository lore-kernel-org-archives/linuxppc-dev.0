Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 17 Apr 2008 14:35:01 +1000
Subject: [PATCH 3/3] [POWERPC] irqtrace support to 64-bit powerpc
Message-Id: <20080417043609.62E17DE1FD@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the low level irq tracing hooks to the powerpc architecture
needed to enable full lockdep functionality

Partly based on Johannes Berg's initial version, removing the asm
trampoline that isn't needed (thus improving perfs) and all sorts
of bits and pieces, reworking most of the assembly, etc...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---

 arch/powerpc/Kconfig            |    9 +++++++
 arch/powerpc/kernel/entry_64.S  |   27 +++++++++++++++++++++-
 arch/powerpc/kernel/head_64.S   |   47 +++++++++++++++++++++++++++-------------
 arch/powerpc/kernel/irq.c       |    3 +-
 arch/powerpc/kernel/ppc_ksyms.c |    4 ---
 arch/powerpc/kernel/setup_64.c  |    4 +++
 include/asm-powerpc/exception.h |    6 ++---
 include/asm-powerpc/hw_irq.h    |   13 +++++------
 include/asm-powerpc/irqflags.h  |   37 +++++++++++++++++++++----------
 include/asm-powerpc/rwsem.h     |   35 ++++++++++++++++++++++-------
 include/asm-powerpc/spinlock.h  |    1 
 11 files changed, 134 insertions(+), 52 deletions(-)

--- linux-work.orig/arch/powerpc/Kconfig	2008-04-17 14:23:30.000000000 +1000
+++ linux-work/arch/powerpc/Kconfig	2008-04-17 14:30:06.000000000 +1000
@@ -53,6 +53,15 @@ config STACKTRACE_SUPPORT
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
--- linux-work.orig/arch/powerpc/kernel/irq.c	2008-04-17 14:29:57.000000000 +1000
+++ linux-work/arch/powerpc/kernel/irq.c	2008-04-17 14:30:06.000000000 +1000
@@ -114,7 +114,7 @@ static inline void set_soft_enabled(unsi
 	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
 }
 
-void local_irq_restore(unsigned long en)
+void raw_local_irq_restore(unsigned long en)
 {
 	/*
 	 * get_paca()->soft_enabled = en;
@@ -174,6 +174,7 @@ void local_irq_restore(unsigned long en)
 
 	__hard_irq_enable();
 }
+EXPORT_SYMBOL(raw_local_irq_restore);
 #endif /* CONFIG_PPC64 */
 
 int show_interrupts(struct seq_file *p, void *v)
Index: linux-work/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/ppc_ksyms.c	2008-04-17 13:10:10.000000000 +1000
+++ linux-work/arch/powerpc/kernel/ppc_ksyms.c	2008-04-17 14:30:06.000000000 +1000
@@ -45,10 +45,6 @@
 #include <asm/signal.h>
 #include <asm/dcr.h>
 
-#ifdef CONFIG_PPC64
-EXPORT_SYMBOL(local_irq_restore);
-#endif
-
 #ifdef CONFIG_PPC32
 extern void transfer_to_handler(void);
 extern void do_IRQ(struct pt_regs *regs);
Index: linux-work/include/asm-powerpc/hw_irq.h
===================================================================
--- linux-work.orig/include/asm-powerpc/hw_irq.h	2008-04-17 13:10:10.000000000 +1000
+++ linux-work/include/asm-powerpc/hw_irq.h	2008-04-17 14:30:06.000000000 +1000
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
--- linux-work.orig/include/asm-powerpc/irqflags.h	2008-04-17 13:10:10.000000000 +1000
+++ linux-work/include/asm-powerpc/irqflags.h	2008-04-17 14:30:06.000000000 +1000
@@ -2,30 +2,43 @@
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
+#define TRACE_AND_RESTORE_IRQ_PARTIAL(en,skip)	\
+	cmpdi	en, 0;				\
+	bne	95f;				\
+	stb	en,PACASOFTIRQEN(r13);		\
+	bl	.trace_hardirqs_off;		\
+	b	skip;				\
+95:	bl	.trace_hardirqs_on;		\
+	li	en,1;
+#define TRACE_AND_RESTORE_IRQ(en)		\
+	TRACE_AND_RESTORE_IRQ_PARTIAL(en,96f);	\
+96:	stb	en,PACASOFTIRQEN(r13)
 #else
-# define TRACE_IRQS_ON
-# define TRACE_IRQS_OFF
+#define TRACE_ENABLE_INTS
+#define TRACE_DISABLE_INTS
+#define TRACE_AND_RESTORE_IRQ_PARTIAL(en,skip)
+#define TRACE_AND_RESTORE_IRQ(en)		\
+	stb	en,PACASOFTIRQEN(r13)
+#endif
 #endif
 
 #endif
Index: linux-work/include/asm-powerpc/rwsem.h
===================================================================
--- linux-work.orig/include/asm-powerpc/rwsem.h	2008-04-17 13:10:10.000000000 +1000
+++ linux-work/include/asm-powerpc/rwsem.h	2008-04-17 14:30:06.000000000 +1000
@@ -32,11 +32,20 @@ struct rw_semaphore {
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
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) }
+	{ RWSEM_UNLOCKED_VALUE, __SPIN_LOCK_UNLOCKED((name).wait_lock), \
+	  LIST_HEAD_INIT((name).wait_list) __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name)		\
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
@@ -46,12 +55,15 @@ extern struct rw_semaphore *rwsem_down_w
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
@@ -78,7 +90,7 @@ static inline int __down_read_trylock(st
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
+static inline void __down_write_nested(struct rw_semaphore *sem, int subclass)
 {
 	int tmp;
 
@@ -88,6 +100,11 @@ static inline void __down_write(struct r
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
--- linux-work.orig/include/asm-powerpc/spinlock.h	2008-04-17 13:10:10.000000000 +1000
+++ linux-work/include/asm-powerpc/spinlock.h	2008-04-17 14:30:06.000000000 +1000
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
--- linux-work.orig/include/asm-powerpc/exception.h	2008-04-17 13:10:10.000000000 +1000
+++ linux-work/include/asm-powerpc/exception.h	2008-04-17 14:30:06.000000000 +1000
@@ -228,18 +228,18 @@ label##_pSeries:							\
 BEGIN_FW_FTR_SECTION;				\
 	stb	r11,PACAHARDIRQEN(r13);		\
 END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES);	\
+	TRACE_DISABLE_INTS;			\
 BEGIN_FW_FTR_SECTION;				\
 	mfmsr	r10;				\
 	ori	r10,r10,MSR_EE;			\
 	mtmsrd	r10,1;				\
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-
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
--- linux-work.orig/arch/powerpc/kernel/head_64.S	2008-04-17 13:10:10.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_64.S	2008-04-17 14:30:06.000000000 +1000
@@ -36,8 +36,7 @@
 #include <asm/firmware.h>
 #include <asm/page_64.h>
 #include <asm/exception.h>
-
-#define DO_SOFT_DISABLE
+#include <asm/irqflags.h>
 
 /*
  * We layout physical memory as follows:
@@ -450,8 +449,8 @@ bad_stack:
  */
 fast_exc_return_irq:			/* restores irq state too */
 	ld	r3,SOFTE(r1)
+	TRACE_AND_RESTORE_IRQ(r3);
 	ld	r12,_MSR(r1)
-	stb	r3,PACASOFTIRQEN(r13)	/* restore paca->soft_enabled */
 	rldicl	r4,r12,49,63		/* get MSR_EE to LSB */
 	stb	r4,PACAHARDIRQEN(r13)	/* restore paca->hard_enabled */
 	b	1f
@@ -808,7 +807,7 @@ _STATIC(load_up_altivec)
  * Hash table stuff
  */
 	.align	7
-_GLOBAL(do_hash_page)
+_STATIC(do_hash_page)
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
 
@@ -820,6 +819,27 @@ BEGIN_FTR_SECTION
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
+	ld	r12,_MSR(r1)
+	clrrdi	r5,r5,4
+#endif /* CONFIG_TRACE_IRQFLAGS */
+	/*
 	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
 	 * accessing a userspace segment (even from the kernel). We assume
 	 * kernel addresses always have the high bit set.
@@ -832,13 +852,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
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
@@ -848,7 +861,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	bl	.hash_page		/* build HPTE if possible */
 	cmpdi	r3,0			/* see if hash_page succeeded */
 
-#ifdef DO_SOFT_DISABLE
 BEGIN_FW_FTR_SECTION
 	/*
 	 * If we had interrupts soft-enabled at the point where the
@@ -860,7 +872,7 @@ BEGIN_FW_FTR_SECTION
 	 */
 	beq	13f
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif
+
 BEGIN_FW_FTR_SECTION
 	/*
 	 * Here we have interrupts hard-disabled, so it is sufficient
@@ -874,11 +886,12 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISER
 
 	/*
 	 * hash_page couldn't handle it, set soft interrupt enable back
-	 * to what it was before the trap.  Note that .local_irq_restore
+	 * to what it was before the trap.  Note that .raw_local_irq_restore
 	 * handles any interrupts pending at this point.
 	 */
 	ld	r3,SOFTE(r1)
-	bl	.local_irq_restore
+	TRACE_AND_RESTORE_IRQ_PARTIAL(r3, 11f)
+	bl	.raw_local_irq_restore
 	b	11f
 
 /* Here we have a page fault that hash_page can't handle. */
@@ -1477,6 +1490,10 @@ _INIT_STATIC(start_here_multiplatform)
 	addi	r2,r2,0x4000
 	add	r2,r2,r26
 
+	/* Set initial ptr to current */
+	LOAD_REG_IMMEDIATE(r4, init_task)
+	std	r4,PACACURRENT(r13)
+
 	/* Do very early kernel initializations, including initial hash table,
 	 * stab and slb setup before we turn on relocation.	*/
 
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2008-04-17 13:10:10.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2008-04-17 14:30:06.000000000 +1000
@@ -33,6 +33,7 @@
 #include <linux/serial_8250.h>
 #include <linux/bootmem.h>
 #include <linux/pci.h>
+#include <linux/lockdep.h>
 #include <asm/io.h>
 #include <asm/kdump.h>
 #include <asm/prom.h>
@@ -178,6 +179,9 @@ void __init early_setup(unsigned long dt
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
+	/* Initialize lockdep early or else spinlocks will blow */
+	lockdep_init();
+
  	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
 
 	/*
Index: linux-work/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/entry_64.S	2008-04-17 14:23:29.000000000 +1000
+++ linux-work/arch/powerpc/kernel/entry_64.S	2008-04-17 14:30:24.000000000 +1000
@@ -30,6 +30,7 @@
 #include <asm/firmware.h>
 #include <asm/bug.h>
 #include <asm/ptrace.h>
+#include <asm/irqflags.h>
 
 /*
  * System calls.
@@ -89,6 +90,14 @@ system_call_common:
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r9)		/* "regshere" marker */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	.trace_hardirqs_on
+	REST_GPR(0,r1)
+	REST_4GPRS(3,r1)
+	REST_2GPRS(7,r1)
+	addi	r9,r1,STACK_FRAME_OVERHEAD
+	ld	r12,_MSR(r1)
+#endif /* CONFIG_TRACE_IRQFLAGS */
 	li	r10,1
 	stb	r10,PACASOFTIRQEN(r13)
 	stb	r10,PACAHARDIRQEN(r13)
@@ -103,7 +112,7 @@ BEGIN_FW_FTR_SECTION
 	b	hardware_interrupt_entry
 2:
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif
+#endif /* CONFIG_PPC_ISERIES */
 	mfmsr	r11
 	ori	r11,r11,MSR_EE
 	mtmsrd	r11,1
@@ -505,6 +514,10 @@ BEGIN_FW_FTR_SECTION
 
 	li	r3,0
 	stb	r3,PACASOFTIRQEN(r13)	/* ensure we are soft-disabled */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	.trace_hardirqs_off
+	mfmsr	r10
+#endif
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10			/* hard-enable again */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -513,7 +526,7 @@ BEGIN_FW_FTR_SECTION
 4:
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
-	stb	r5,PACASOFTIRQEN(r13)
+	TRACE_AND_RESTORE_IRQ(r5);
 
 	/* extract EE bit and use it to restore paca->hard_enabled */
 	ld	r3,_MSR(r1)
@@ -581,6 +594,16 @@ do_work:
 	bne	restore
 	/* here we are preempting the current task */
 1:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	.trace_hardirqs_on
+	/* Note: we just clobbered r10 which used to contain the previous
+	 * MSR before the hard-disabling done by the caller of do_work.
+	 * We don't have that value anymore, but it doesn't matter as
+	 * we will hard-enable unconditionally, we can just reload the
+	 * current MSR into r10
+	 */
+	mfmsr	r10
+#endif /* CONFIG_TRACE_IRQFLAGS */
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13)
 	stb	r0,PACAHARDIRQEN(r13)
