Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C31F6DDF73
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 19:38:49 +1000 (EST)
Subject: Re: powerpc stacktrace and lockdep support
From: Johannes Berg <johannes@sipsolutions.net>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <1182898073.4769.6.camel@johannes.berg>
References: <20070108135458.GA23395@lst.de>
	<1182898073.4769.6.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 27 Jun 2007 21:00:29 +0200
Message-Id: <1182970829.4769.62.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a somewhat cleaned-up version that also works with preempt, still
64-bit only, still breaks 32-bit compile (I think, untested).

Works fine on my quad G5 and I've actually made a patch to lockdep to
support flagging my workqueue deadlock, that works too. And the XFS
report I had previously was also "correct" in the sense that it occurs
on all machines and has been patched (although there never was a
possible deadlock.)

---
 arch/powerpc/Kconfig            |    8 +++++
 arch/powerpc/kernel/Makefile    |    1 
 arch/powerpc/kernel/entry_64.S  |   24 +++++++++++++++++
 arch/powerpc/kernel/head_64.S   |   54 ++++++++++++++++++++++++++++++++--------
 arch/powerpc/kernel/irq.c       |    2 -
 arch/powerpc/kernel/irqtrace.S  |   47 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/ppc_ksyms.c |    2 -
 arch/powerpc/kernel/setup_64.c  |    6 ++++
 include/asm-powerpc/hw_irq.h    |   34 +++++++++++++------------
 include/asm-powerpc/irqflags.h  |   13 ---------
 include/asm-powerpc/rwsem.h     |   34 +++++++++++++++++++------
 include/asm-powerpc/spinlock.h  |    1 
 12 files changed, 176 insertions(+), 50 deletions(-)

--- linux-2.6-git.orig/arch/powerpc/Kconfig	2007-06-27 17:37:39.884965668 +0200
+++ linux-2.6-git/arch/powerpc/Kconfig	2007-06-27 17:38:07.929965668 +0200
@@ -38,6 +38,14 @@ config STACKTRACE_SUPPORT
 	bool
 	default y
 
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default y
+
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
--- linux-2.6-git.orig/arch/powerpc/kernel/irq.c	2007-06-27 17:37:39.907965668 +0200
+++ linux-2.6-git/arch/powerpc/kernel/irq.c	2007-06-27 17:38:07.953965668 +0200
@@ -114,7 +114,7 @@ static inline void set_soft_enabled(unsi
 	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
 }
 
-void local_irq_restore(unsigned long en)
+void raw_local_irq_restore(unsigned long en)
 {
 	/*
 	 * get_paca()->soft_enabled = en;
--- linux-2.6-git.orig/arch/powerpc/kernel/ppc_ksyms.c	2007-06-27 17:37:39.930965668 +0200
+++ linux-2.6-git/arch/powerpc/kernel/ppc_ksyms.c	2007-06-27 17:38:07.954965668 +0200
@@ -50,7 +50,7 @@
 #endif
 
 #ifdef CONFIG_PPC64
-EXPORT_SYMBOL(local_irq_restore);
+EXPORT_SYMBOL(raw_local_irq_restore);
 #endif
 
 #ifdef CONFIG_PPC32
--- linux-2.6-git.orig/include/asm-powerpc/hw_irq.h	2007-06-27 17:37:40.209965668 +0200
+++ linux-2.6-git/include/asm-powerpc/hw_irq.h	2007-06-27 17:38:08.025965668 +0200
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
+#define raw_local_irq_enable()	raw_local_irq_restore(1)
+#define raw_local_save_flags(flags)	((flags) = local_get_flags())
+#define raw_local_irq_save(flags)	((flags) = raw_local_irq_disable())
 
-#define irqs_disabled()		(local_get_flags() == 0)
+#define raw_irqs_disabled()		(local_get_flags() == 0)
+#define raw_irqs_disabled_flags(flags)		((flags) == 0)
 
 #define __hard_irq_enable()	__mtmsrd(mfmsr() | MSR_EE, 1)
 #define __hard_irq_disable()	__mtmsrd(mfmsr() & ~MSR_EE, 1)
@@ -62,13 +63,13 @@ extern void iseries_handle_interrupts(vo
 
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
@@ -80,7 +81,7 @@ static inline void local_irq_disable(voi
 #endif
 }
 
-static inline void local_irq_enable(void)
+static inline void raw_local_irq_enable(void)
 {
 #ifdef CONFIG_BOOKE
 	__asm__ __volatile__("wrteei 1": : :"memory");
@@ -92,7 +93,7 @@ static inline void local_irq_enable(void
 #endif
 }
 
-static inline void local_irq_save_ptr(unsigned long *flags)
+static inline void raw_local_irq_save_ptr(unsigned long *flags)
 {
 	unsigned long msr;
 	msr = mfmsr();
@@ -105,12 +106,13 @@ static inline void local_irq_save_ptr(un
 	__asm__ __volatile__("": : :"memory");
 }
 
-#define local_save_flags(flags)	((flags) = mfmsr())
-#define local_irq_save(flags)	local_irq_save_ptr(&flags)
-#define irqs_disabled()		((mfmsr() & MSR_EE) == 0)
+#define raw_local_save_flags(flags)	((flags) = mfmsr())
+#define raw_local_irq_save(flags)	raw_local_irq_save_ptr(&flags)
+#define raw_irqs_disabled()		((mfmsr() & MSR_EE) == 0)
+#define raw_irqs_disabled_flags(flags)		(((flags) & MSR_EE) == 0)
 
-#define hard_irq_enable()	local_irq_enable()
-#define hard_irq_disable()	local_irq_disable()
+#define hard_irq_enable()	raw_local_irq_enable()
+#define hard_irq_disable()	raw_local_irq_disable()
 
 #endif /* CONFIG_PPC64 */
 
--- linux-2.6-git.orig/include/asm-powerpc/irqflags.h	2007-06-27 17:37:40.234965668 +0200
+++ linux-2.6-git/include/asm-powerpc/irqflags.h	2007-06-27 17:39:18.499965668 +0200
@@ -15,17 +15,4 @@
  */
 #include <asm-powerpc/hw_irq.h>
 
-/*
- * Do the CPU's IRQ-state tracing from assembly code. We call a
- * C function, so save all the C-clobbered registers:
- */
-#ifdef CONFIG_TRACE_IRQFLAGS
-
-#error No support on PowerPC yet for CONFIG_TRACE_IRQFLAGS
-
-#else
-# define TRACE_IRQS_ON
-# define TRACE_IRQS_OFF
-#endif
-
 #endif
--- linux-2.6-git.orig/include/asm-powerpc/rwsem.h	2007-06-27 17:37:40.256965668 +0200
+++ linux-2.6-git/include/asm-powerpc/rwsem.h	2007-06-27 17:38:08.051965668 +0200
@@ -28,11 +28,21 @@ struct rw_semaphore {
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
@@ -42,12 +52,15 @@ extern struct rw_semaphore *rwsem_down_w
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
@@ -74,7 +87,7 @@ static inline int __down_read_trylock(st
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
+static inline void __down_write_nested(struct rw_semaphore *sem, int subclass)
 {
 	int tmp;
 
@@ -84,6 +97,11 @@ static inline void __down_write(struct r
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
--- linux-2.6-git.orig/include/asm-powerpc/spinlock.h	2007-06-27 17:37:40.293965668 +0200
+++ linux-2.6-git/include/asm-powerpc/spinlock.h	2007-06-27 17:38:08.056965668 +0200
@@ -19,6 +19,7 @@
  *
  * (the type definitions are in asm/spinlock_types.h)
  */
+#include <linux/irqflags.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #include <asm/hvcall.h>
--- linux-2.6-git.orig/arch/powerpc/kernel/head_64.S	2007-06-27 17:37:39.953965668 +0200
+++ linux-2.6-git/arch/powerpc/kernel/head_64.S	2007-06-27 17:52:08.742965668 +0200
@@ -394,6 +394,12 @@ label##_iSeries:							\
 	EXCEPTION_PROLOG_ISERIES_2;					\
 	b	label##_common;						\
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+#define TRACE_DISABLE_INTS bl .powerpc_trace_hardirqs_off
+#else
+#define TRACE_DISABLE_INTS
+#endif
+
 #ifdef CONFIG_PPC_ISERIES
 #define DISABLE_INTS				\
 	li	r11,0;				\
@@ -405,14 +411,15 @@ BEGIN_FW_FTR_SECTION;				\
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
@@ -965,24 +972,38 @@ bad_stack:
  */
 fast_exc_return_irq:			/* restores irq state too */
 	ld	r3,SOFTE(r1)
-	ld	r12,_MSR(r1)
+#ifdef CONFIG_TRACE_IRQFLAGS
+	cmpdi	r3,0
+	beq	1f
+	bl	.trace_hardirqs_on
+	ld	r3,SOFTE(r1)
+1:
 	stb	r3,PACASOFTIRQEN(r13)	/* restore paca->soft_enabled */
+	cmpdi	r3,0
+	bne	2f
+	bl	.trace_hardirqs_off
+	ld	r3,SOFTE(r1)
+2:
+#else
+	stb	r3,PACASOFTIRQEN(r13)	/* restore paca->soft_enabled */
+#endif
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
@@ -1387,11 +1408,24 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISER
 
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
+	beq	14f
+	bl	.trace_hardirqs_on
+	ld	r3,SOFTE(r1)
+14:
+	bl	.raw_local_irq_restore
+	cmpdi	r3,0
+	bne	15f
+	bl	.trace_hardirqs_off
+15:
+#else
+	bl	.raw_local_irq_restore
+#endif
 	b	11f
 
 /* Here we have a page fault that hash_page can't handle. */
--- linux-2.6-git.orig/arch/powerpc/kernel/setup_64.c	2007-06-27 17:37:39.976965668 +0200
+++ linux-2.6-git/arch/powerpc/kernel/setup_64.c	2007-06-27 17:38:08.062965668 +0200
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
--- linux-2.6-git.orig/arch/powerpc/kernel/entry_64.S	2007-06-27 17:37:40.045965668 +0200
+++ linux-2.6-git/arch/powerpc/kernel/entry_64.S	2007-06-27 17:50:16.499965668 +0200
@@ -91,6 +91,13 @@ system_call_common:
 	li	r10,1
 	stb	r10,PACASOFTIRQEN(r13)
 	stb	r10,PACAHARDIRQEN(r13)
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	.trace_hardirqs_on
+	REST_GPR(0,r1)
+	REST_4GPRS(3,r1)
+	REST_2GPRS(7,r1)
+	addi	r9,r1,STACK_FRAME_OVERHEAD
+#endif
 	std	r10,SOFTE(r1)
 #ifdef CONFIG_PPC_ISERIES
 BEGIN_FW_FTR_SECTION
@@ -491,8 +498,20 @@ BEGIN_FW_FTR_SECTION
 4:
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
+#ifdef CONFIG_TRACE_IRQFLAGS
+	cmpdi	r5,0
+	beq	5f
+	bl	.trace_hardirqs_on
+	ld	r5,SOFTE(r1)
 	stb	r5,PACASOFTIRQEN(r13)
-
+	b	6f
+5:
+	stb	r5,PACASOFTIRQEN(r13)
+	bl	.trace_hardirqs_off
+6:
+#else
+	stb	r5,PACASOFTIRQEN(r13)
+#endif
 	/* extract EE bit and use it to restore paca->hard_enabled */
 	ld	r3,_MSR(r1)
 	rldicl	r4,r3,49,63		/* r0 = (r3 >> 15) & 1 */
@@ -560,6 +579,9 @@ do_work:
 	bne	restore
 	/* here we are preempting the current task */
 1:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	.powerpc_trace_hardirqs_on
+#endif
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13)
 	stb	r0,PACAHARDIRQEN(r13)
--- linux-2.6-git.orig/arch/powerpc/kernel/Makefile	2007-06-27 17:37:40.100965668 +0200
+++ linux-2.6-git/arch/powerpc/kernel/Makefile	2007-06-27 17:38:08.064965668 +0200
@@ -62,6 +62,7 @@ obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
+obj-$(CONFIG_TRACE_IRQFLAGS)	+= irqtrace.o
 
 module-$(CONFIG_PPC64)		+= module_64.o
 obj-$(CONFIG_MODULES)		+= $(module-y)
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-git/arch/powerpc/kernel/irqtrace.S	2007-06-27 17:49:15.650965668 +0200
@@ -0,0 +1,47 @@
+/*
+ * crappy helper for irq-trace
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
+#define STACKSPACE	GPR0 + 16*8
+
+#ifdef __powerpc64__
+#define ST	std
+#define L	ld
+#else
+#define ST	stw
+#define L	lw
+#endif
+
+#define PRE				\
+	subi	r1,r1,STACKSPACE ;	\
+	SAVE_GPR(0, r1) ;		\
+	SAVE_8GPRS(2, r1) ;		\
+	SAVE_4GPRS(10, r1) ;		\
+	mfcr	r0 ;			\
+	ST	r0, (14*8)(r1) ;	\
+	mflr	r0 ;			\
+	ST	r0, (15*8)(r1)
+
+#define POST				\
+	REST_8GPRS(2, r1) ;		\
+	REST_4GPRS(10, r1) ;		\
+	L	r0, (14*8)(r1) ;	\
+	mtcr	r0 ;			\
+	L	r0, (15*8)(r1) ;	\
+	mtlr	r0 ;			\
+	REST_GPR(0, r1) ;		\
+	addi	r1,r1,STACKSPACE
+
+_GLOBAL(powerpc_trace_hardirqs_off)
+	PRE
+	bl .trace_hardirqs_off
+	POST
+	blr
+_GLOBAL(powerpc_trace_hardirqs_on)
+	PRE
+	bl .trace_hardirqs_on
+	POST
+	blr
