Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-119.roch.qwest.net [67.41.71.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE9202BD71
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 10:27:07 +1000 (EST)
Received: from jdub.homelinux.org (localhost.localdomain [127.0.0.1])
	by jdub.homelinux.org (8.12.11/8.12.11) with ESMTP id i8DNsuZp031370
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2004 18:54:57 -0500
Received: (from jwboyer@localhost)
	by jdub.homelinux.org (8.12.11/8.12.11/Submit) id i8DNsuc3031369
	for linuxppc-dev@ozlabs.org; Mon, 13 Sep 2004 18:54:56 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Message-Id: <1095119695.16444.209.camel@67-41-71-119.roch.qwest.net>
Mime-Version: 1.0
Date: Mon, 13 Sep 2004 18:54:55 -0500
Subject: [RFC] [PATCH] ppc32: Separate IRQ stacks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The following patch implements separate hard and soft IRQ stacks for
PPC32.  It compiles cleanly against 2.6.9-rc2, but it is untested as I
have no PPC hardware at the moment.  (Working on that though).

The main reason I did this was basically just for proof-of-concept. 
Eventually, I may do a 4K stack patch for PPC32 and this would be needed
then anyway.  That probably won't happen until I get some hardware to
test with though.

Comments would be appreciated.

thx,
josh

Signed-off-by: Josh Boyer <jwboyer@jdub.homelinux.org>

diff -Naur linux-2.6.9-rc2/arch/ppc/Kconfig.debug linux-2.6.9-rc2.jwb/arch/ppc/Kconfig.debug
--- linux-2.6.9-rc2/arch/ppc/Kconfig.debug	2004-09-13 17:00:25.000000000 -0500
+++ linux-2.6.9-rc2.jwb/arch/ppc/Kconfig.debug	2004-09-13 18:10:18.586814816 -0500
@@ -81,4 +81,11 @@
 	depends on IBM_OCP || FSL_OCP
 	default y
 
+config IRQSTACKS
+	bool "Use separate kernel stacks when processing interrupts"
+	help
+	  If you say Y here the kernel will use separate kernel stacks
+	  for handling hard and soft interrupts.  This can help avoid
+	  overflowing the process kernel stacks.
+
 endmenu
diff -Naur linux-2.6.9-rc2/arch/ppc/kernel/irq.c linux-2.6.9-rc2.jwb/arch/ppc/kernel/irq.c
--- linux-2.6.9-rc2/arch/ppc/kernel/irq.c	2004-09-13 17:00:26.000000000 -0500
+++ linux-2.6.9-rc2.jwb/arch/ppc/kernel/irq.c	2004-09-13 18:10:18.690799008 -0500
@@ -411,8 +411,7 @@
 	return 0;
 }
 
-static inline void
-handle_irq_event(int irq, struct pt_regs *regs, struct irqaction *action)
+void handle_irq_event(int irq, struct pt_regs *regs, struct irqaction *action)
 {
 	int status = 0;
 	int ret;
@@ -440,6 +439,9 @@
 	int status;
 	struct irqaction *action;
 	irq_desc_t *desc = irq_desc + irq;
+#ifdef CONFIG_IRQSTACKS
+	struct thread_info *curtp, *irqtp;
+#endif
 
 	kstat_this_cpu.irqs[irq]++;
 	spin_lock(&desc->lock);
@@ -498,6 +500,20 @@
 	 */
 	for (;;) {
 		spin_unlock(&desc->lock);
+		
+#ifdef CONFIG_IRQSTACKS
+		/* Switch to the irq stack to handle this */
+		curtp = current_thread_info();
+		irqtp = hardirq_ctx[smp_processor_id()];
+		if (curtp != irqtp) {
+			irqtp->task = curtp->task;
+			irqtp->flags = 0;
+			call_handle_irq_event(irq, regs, action, irqtp);
+			irqtp->task = NULL;
+			if (irqtp->flags)
+				set_bits(irqtp->flags, &curtp->flags);
+		} else
+#endif
 		handle_irq_event(irq, regs, action);
 		spin_lock(&desc->lock);
 
@@ -682,4 +698,57 @@
 		irq_affinity[i] = DEFAULT_CPU_AFFINITY;
 
 	ppc_md.init_IRQ();
+	irq_ctx_init();
+}
+
+#ifdef CONFIG_IRQSTACKS
+struct thread_info *softirq_ctx[NR_CPUS];
+struct thread_info *hardirq_ctx[NR_CPUS];
+
+/* This was taken from arch/i386/kernel/irq.c.  Maybe replace with kmalloc? */
+static char softirq_stack[NR_CPUS * THREAD_SIZE] __attribute__((__aligned__(THREAD_SIZE)));
+static char hardirq_stack[NR_CPUS * THREAD_SIZE] __attribute__((__aligned__(THREAD_SIZE)));
+
+void irq_ctx_init(void)
+{
+	struct thread_info *tp;
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		softirq_ctx[i] = (struct thread_info *) &softirq_stack[i*THREAD_SIZE];
+		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
+		tp = softirq_ctx[i];
+		tp->cpu = i;
+		tp->preempt_count = SOFTIRQ_OFFSET;
+
+		hardirq_ctx[i] = (struct thread_info *) &hardirq_stack[i*THREAD_SIZE];
+		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
+		tp = hardirq_ctx[i];
+		tp->cpu = i;
+		tp->preempt_count = HARDIRQ_OFFSET;
+	}
 }
+
+void do_softirq(void)
+{
+	unsigned long flags;
+	struct thread_info *curtp, *irqtp;
+
+	if (in_interrupt())
+		return;
+
+	local_irq_save(flags);
+
+	if (local_softirq_pending()) {
+		curtp = current_thread_info();
+		irqtp = softirq_ctx[smp_processor_id()];
+		irqtp->task = curtp->task;
+		call_do_softirq(irqtp);
+		irqtp->task = NULL;
+	}
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(do_softirq);
+
+#endif /* CONFIG_IRQSTACKS */
diff -Naur linux-2.6.9-rc2/arch/ppc/kernel/misc.S linux-2.6.9-rc2.jwb/arch/ppc/kernel/misc.S
--- linux-2.6.9-rc2/arch/ppc/kernel/misc.S	2004-09-13 17:00:26.000000000 -0500
+++ linux-2.6.9-rc2.jwb/arch/ppc/kernel/misc.S	2004-09-13 18:10:18.736792016 -0500
@@ -401,6 +401,30 @@
 	nop
 _GLOBAL(local_irq_enable_end)
 
+#ifdef CONFIG_IRQSTACKS
+_GLOBAL(call_do_softirq)
+	mflr    r0
+	stw     r0,4(r1)
+	stwu    r1,THREAD_SIZE-16(r3)
+	mr      r1,r3
+	bl      __do_softirq
+	lwz     r1,0(r1)
+	lwz     r0,4(r1)
+	mtlr    r0
+	blr
+
+_GLOBAL(call_handle_irq_event)
+	mflr    r0
+	stw     r0,4(r1)
+	stwu    r1,THREAD_SIZE-16(r6)
+	mr      r1,r6
+	bl      handle_irq_event
+	lwz     r1,0(r1)
+	lwz     r0,4(r1)
+	mtlr    r0
+	blr
+#endif /* CONFIG_IRQSTACKS */
+
 /*
  * complement mask on the msr then "or" some values on.
  *     _nmask_and_or_msr(nmask, value_to_or)
diff -Naur linux-2.6.9-rc2/include/asm-ppc/bitops.h linux-2.6.9-rc2.jwb/include/asm-ppc/bitops.h
--- linux-2.6.9-rc2/include/asm-ppc/bitops.h	2004-08-14 00:36:58.000000000 -0500
+++ linux-2.6.9-rc2.jwb/include/asm-ppc/bitops.h	2004-09-13 18:10:18.000000000 -0500
@@ -23,6 +23,21 @@
 #define SMP_MB
 #endif /* CONFIG_SMP */
 
+static __inline__ void set_bits(unsigned long mask, unsigned long *addr)
+{
+	unsigned long old;
+
+	__asm__ __volatile__(
+			"1: lwarx	%0,0,%3\n\
+			or %0,%0,%2 \n"
+			PPC405_ERR77(0,%3)
+			"stwcx.	%0,0,%3\n\
+			bne-	1b"
+			: "=&r" (old), "=m" (*addr)
+			: "r" (mask), "r" (addr), "m" (*addr)
+			: "cc" );
+}
+
 static __inline__ void set_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long old;
diff -Naur linux-2.6.9-rc2/include/asm-ppc/irq.h linux-2.6.9-rc2.jwb/include/asm-ppc/irq.h
--- linux-2.6.9-rc2/include/asm-ppc/irq.h	2004-08-14 00:36:16.000000000 -0500
+++ linux-2.6.9-rc2.jwb/include/asm-ppc/irq.h	2004-09-13 18:10:18.000000000 -0500
@@ -3,6 +3,7 @@
 #define _ASM_IRQ_H
 
 #include <linux/config.h>
+#include <linux/threads.h>		/* NR_CPUS */
 #include <asm/machdep.h>		/* ppc_md */
 #include <asm/atomic.h>
 
@@ -326,5 +327,23 @@
 struct pt_regs;
 int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 
+#ifdef CONFIG_IRQSTACKS
+/*
+ * Per-cpu stacks for handling hard and soft interrupts.
+ */
+extern struct thread_info *hardirq_ctx[NR_CPUS];
+extern struct thread_info *softirq_ctx[NR_CPUS];
+
+extern void irq_ctx_init(void);
+extern void call_do_softirq(struct thread_info *tp);
+extern int call_handle_irq_event(int irq, struct pt_regs *regs,
+		struct irqaction *action, struct thread_info *tp);
+
+#define __ARCH_HAS_DO_SOFTIRQ
+
+#else
+#define irq_ctx_init()
+
+#endif /* CONFIG_IRQSTACKS */
 #endif /* _ASM_IRQ_H */
 #endif /* __KERNEL__ */
