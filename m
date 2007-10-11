Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2683DDDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 21:32:58 +1000 (EST)
Subject: [PATCH/RFT] powerpc: 64-bit irqtrace support
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <1184159028.6669.10.camel@johannes.berg>
References: <1184159028.6669.10.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 14:10:18 +0200
Message-Id: <1192104618.4770.40.camel@johannes.berg>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds irqtrace support to 64-bit powerpc to enable lockdep.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
Requires Christoph's stack trace patch to really enable lockdep.

This patch is updated against the current powerpc master branch, mostly
required because of the introduction of exception.h

I'd like see this tested on some other platforms (maybe iSeries, Cell)
to make sure it doesn't blow up there and also reviewed by someone more
familiar with the exception handling; maybe some of the calls don't need
to be wrapped this excessively.

I haven't succeeded in making it work on 32-bit yet, somebody else can
take that if they want to :)

 arch/powerpc/Kconfig            |    9 ++++
 arch/powerpc/kernel/Makefile    |    1 
 arch/powerpc/kernel/entry_64.S  |   21 +++++++++
 arch/powerpc/kernel/head_64.S   |   37 +++++++++++++----
 arch/powerpc/kernel/irq.c       |    3 -
 arch/powerpc/kernel/irqtrace.S  |   87 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/ppc_ksyms.c |    4 -
 arch/powerpc/kernel/setup_64.c  |    6 ++
 include/asm-powerpc/exception.h |    7 +--
 include/asm-powerpc/hw_irq.h    |   13 +++--
 include/asm-powerpc/irqflags.h  |   23 +++++-----
 include/asm-powerpc/rwsem.h     |   38 +++++++++++++----
 include/asm-powerpc/spinlock.h  |    1 
 13 files changed, 208 insertions(+), 42 deletions(-)

--- powerpc.orig/arch/powerpc/Kconfig	2007-10-11 13:35:59.034629802 +0200
+++ powerpc/arch/powerpc/Kconfig	2007-10-11 13:40:13.844629802 +0200
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
 
--- powerpc.orig/arch/powerpc/kernel/irq.c	2007-10-11 13:32:39.399629802 +0200
+++ powerpc/arch/powerpc/kernel/irq.c	2007-10-11 13:40:13.848629802 +0200
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
--- powerpc.orig/arch/powerpc/kernel/ppc_ksyms.c	2007-10-11 13:32:39.422629802 +0200
+++ powerpc/arch/powerpc/kernel/ppc_ksyms.c	2007-10-11 13:40:13.850629802 +0200
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
--- powerpc.orig/include/asm-powerpc/hw_irq.h	2007-10-11 13:28:06.923629802 +0200
+++ powerpc/include/asm-powerpc/hw_irq.h	2007-10-11 13:40:13.853629802 +0200
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
--- powerpc.orig/include/asm-powerpc/irqflags.h	2007-10-11 13:28:06.943629802 +0200
+++ powerpc/include/asm-powerpc/irqflags.h	2007-10-11 13:40:13.856629802 +0200
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
+#define TRACE_ENABLE_INTS_WRAPPED	bl .powerpc_trace_hardirqs_on
+#define TRACE_DISABLE_INTS_WRAPPED	bl .powerpc_trace_hardirqs_off
 #else
-# define TRACE_IRQS_ON
-# define TRACE_IRQS_OFF
+#define TRACE_ENABLE_INTS_WRAPPED
+#define TRACE_DISABLE_INTS_WRAPPED
+#endif
 #endif
 
 #endif
--- powerpc.orig/include/asm-powerpc/rwsem.h	2007-10-11 13:34:16.677629802 +0200
+++ powerpc/include/asm-powerpc/rwsem.h	2007-10-11 13:40:13.859629802 +0200
@@ -5,6 +5,10 @@
 #error "Please don't include <asm/rwsem.h> directly, use <linux/rwsem.h> instead."
 #endif
 
+#ifndef _LINUX_RWSEM_H
+#error "please don't include asm/rwsem.h directly, use linux/rwsem.h instead"
+#endif
+
 #ifdef __KERNEL__
 
 /*
@@ -32,11 +36,21 @@ struct rw_semaphore {
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
@@ -46,12 +60,15 @@ extern struct rw_semaphore *rwsem_down_w
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
@@ -78,7 +95,7 @@ static inline int __down_read_trylock(st
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
+static inline void __down_write_nested(struct rw_semaphore *sem, int subclass)
 {
 	int tmp;
 
@@ -88,6 +105,11 @@ static inline void __down_write(struct r
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
--- powerpc.orig/include/asm-powerpc/spinlock.h	2007-10-11 13:28:06.993629802 +0200
+++ powerpc/include/asm-powerpc/spinlock.h	2007-10-11 13:40:13.861629802 +0200
@@ -19,6 +19,7 @@
  *
  * (the type definitions are in asm/spinlock_types.h)
  */
+#include <linux/irqflags.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #include <asm/hvcall.h>
--- powerpc.orig/include/asm-powerpc/exception.h	2007-10-11 13:34:13.733629802 +0200
+++ powerpc/include/asm-powerpc/exception.h	2007-10-11 13:40:13.864629802 +0200
@@ -232,14 +232,15 @@ BEGIN_FW_FTR_SECTION;				\
 	mfmsr	r10;				\
 	ori	r10,r10,MSR_EE;			\
 	mtmsrd	r10,1;				\
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES);	\
+	TRACE_DISABLE_INTS_WRAPPED
 
 #else
 #define DISABLE_INTS				\
 	li	r11,0;				\
 	stb	r11,PACASOFTIRQEN(r13);		\
-	stb	r11,PACAHARDIRQEN(r13)
-
+	stb	r11,PACAHARDIRQEN(r13);		\
+	TRACE_DISABLE_INTS_WRAPPED
 #endif /* CONFIG_PPC_ISERIES */
 
 #define ENABLE_INTS				\
--- powerpc.orig/arch/powerpc/kernel/head_64.S	2007-10-11 13:32:39.357629802 +0200
+++ powerpc/arch/powerpc/kernel/head_64.S	2007-10-11 13:40:13.868629802 +0200
@@ -36,6 +36,7 @@
 #include <asm/firmware.h>
 #include <asm/page_64.h>
 #include <asm/exception.h>
+#include <asm/irqflags.h>
 
 #define DO_SOFT_DISABLE
 
@@ -450,24 +451,35 @@ bad_stack:
  */
 fast_exc_return_irq:			/* restores irq state too */
 	ld	r3,SOFTE(r1)
-	ld	r12,_MSR(r1)
+#ifdef CONFIG_TRACE_IRQFLAGS
+	cmpdi	r3,0
+	bne	1f
+	stb	r3,PACASOFTIRQEN(r13)	/* restore paca->soft_enabled */
+	bl	.trace_hardirqs_off
+	b	2f
+1:
+	bl	.trace_hardirqs_on
+	ld	r3,SOFTE(r1)
+#endif
 	stb	r3,PACASOFTIRQEN(r13)	/* restore paca->soft_enabled */
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
@@ -874,11 +886,22 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISER
 
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
+#endif
+	bl	.raw_local_irq_restore
+15:
 	b	11f
 
 /* Here we have a page fault that hash_page can't handle. */
--- powerpc.orig/arch/powerpc/kernel/setup_64.c	2007-10-11 13:32:39.482629802 +0200
+++ powerpc/arch/powerpc/kernel/setup_64.c	2007-10-11 13:40:13.871629802 +0200
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
--- powerpc.orig/arch/powerpc/kernel/entry_64.S	2007-10-11 13:32:39.347629802 +0200
+++ powerpc/arch/powerpc/kernel/entry_64.S	2007-10-11 13:40:13.875629802 +0200
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
+#endif
 	li	r10,1
 	stb	r10,PACASOFTIRQEN(r13)
 	stb	r10,PACAHARDIRQEN(r13)
@@ -494,8 +502,18 @@ BEGIN_FW_FTR_SECTION
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
@@ -562,6 +580,7 @@ do_work:
 	bne	restore
 	/* here we are preempting the current task */
 1:
+	TRACE_ENABLE_INTS_WRAPPED
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13)
 	stb	r0,PACAHARDIRQEN(r13)
--- powerpc.orig/arch/powerpc/kernel/Makefile	2007-10-11 13:35:59.037629802 +0200
+++ powerpc/arch/powerpc/kernel/Makefile	2007-10-11 13:40:13.877629802 +0200
@@ -66,6 +66,7 @@ obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
+obj-$(CONFIG_TRACE_IRQFLAGS)	+= irqtrace.o
 
 pci64-$(CONFIG_PPC64)		+= pci_dn.o isa-bridge.o
 obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ powerpc/arch/powerpc/kernel/irqtrace.S	2007-10-11 13:40:13.880629802 +0200
@@ -0,0 +1,87 @@
+/*
+ * helpers for irq-trace
+ *
+ * We invoke the hardirq trace functions from various inconvenient
+ * places; these helpers save all callee-saved registers.
+ *
+ * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
+#ifdef CONFIG_PPC64
+#define ST	std
+#define STU	stdu
+#define L	ld
+#define WSZ	8
+#define FREE	32
+#else
+#error double-check please
+#define ST	stw
+#define STU	stwu
+#define L	lwz
+#define WSZ	4
+#define FREE	16
+#endif
+
+#define STACKSPACE	(FREE + 16*WSZ)
+#define SAVE(n)		(FREE + n*WSZ)
+
+_GLOBAL(powerpc_trace_hardirqs_on)
+	ST	r3, (SAVE(2)-STACKSPACE)(r1)
+	LOAD_REG_IMMEDIATE(r3, .trace_hardirqs_on)
+	b	powerpc_trace_hardirqs
+
+_GLOBAL(powerpc_trace_hardirqs_off)
+	ST	r3, (SAVE(2)-STACKSPACE)(r1)
+	LOAD_REG_IMMEDIATE(r3, .trace_hardirqs_off)
+
+powerpc_trace_hardirqs:
+	ST	r0, (SAVE(0)-STACKSPACE)(r1)
+	mflr	r0
+	ST	r0, LRSAVE(r1)
+	STU	r1, -STACKSPACE(r1)
+	mfctr	r0
+	ST	r0, SAVE(14)(r1)
+	mtctr	r3
+	ST	r2, SAVE(1)(r1)
+	ST	r4, SAVE(3)(r1)
+	ST	r5, SAVE(4)(r1)
+	ST	r6, SAVE(5)(r1)
+	ST	r7, SAVE(6)(r1)
+	ST	r8, SAVE(7)(r1)
+	ST	r9, SAVE(8)(r1)
+	ST	r10, SAVE(9)(r1)
+	ST	r11, SAVE(10)(r1)
+	ST	r12, SAVE(11)(r1)
+	ST	r13, SAVE(12)(r1)
+	mfcr	r0
+	ST	r0, SAVE(13)(r1)
+	bctrl
+	L	r2, SAVE(1)(r1)
+	L	r3, SAVE(2)(r1)
+	L	r4, SAVE(3)(r1)
+	L	r5, SAVE(4)(r1)
+	L	r6, SAVE(5)(r1)
+	L	r7, SAVE(6)(r1)
+	L	r8, SAVE(7)(r1)
+	L	r9, SAVE(8)(r1)
+	L	r10, SAVE(9)(r1)
+	L	r11, SAVE(10)(r1)
+	L	r12, SAVE(11)(r1)
+	L	r13, SAVE(12)(r1)
+	L	r0, SAVE(13)(r1)
+	mtcr	r0
+	L	r0, SAVE(14)(r1)
+	mtctr	r0
+	L	r1, 0(r1)
+	L	r0, LRSAVE(r1)
+	mtlr	r0
+	L	r0, (SAVE(0)-STACKSPACE)(r1)
+	blr
