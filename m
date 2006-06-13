Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13DB167B22
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 13:48:27 +1000 (EST)
Subject: [PATCH] powerpc-genirq: Use generic_handle_irq()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 13:47:51 +1000
Message-Id: <1150170472.13958.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch updates the ppc and powerpc architectures to use the new
generic_handle_irq() so that interrupt controllers can be ported to the
new genirq layer.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Patch depends on Ingo/Thomas genirq patchset.

Index: linux-work/arch/powerpc/kernel/irq.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/irq.c	2006-06-05 15:29:37.000000000 +1000
+++ linux-work/arch/powerpc/kernel/irq.c	2006-06-05 15:50:53.000000000 +1000
@@ -219,15 +219,19 @@ void do_IRQ(struct pt_regs *regs)
 		curtp = current_thread_info();
 		irqtp = hardirq_ctx[smp_processor_id()];
 		if (curtp != irqtp) {
+			struct irq_desc *desc = irq_desc + irq;
+			void *handler = desc->handle_irq;
+			if (handler == NULL)
+				handler = &__do_IRQ;
 			irqtp->task = curtp->task;
 			irqtp->flags = 0;
-			call___do_IRQ(irq, regs, irqtp);
+			call_handle_irq(irq, desc, regs, irqtp, handler);
 			irqtp->task = NULL;
 			if (irqtp->flags)
 				set_bits(irqtp->flags, &curtp->flags);
 		} else
 #endif
-			__do_IRQ(irq, regs);
+			generic_handle_irq(irq, regs);
 	} else if (irq != -2)
 		/* That's not SMP safe ... but who cares ? */
 		ppc_spurious_interrupts++;
Index: linux-work/arch/powerpc/kernel/misc_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/misc_64.S	2006-06-05 15:29:37.000000000 +1000
+++ linux-work/arch/powerpc/kernel/misc_64.S	2006-06-05 15:38:01.000000000 +1000
@@ -89,12 +89,14 @@ _GLOBAL(call_do_softirq)
 	mtlr	r0
 	blr
 
-_GLOBAL(call___do_IRQ)
+_GLOBAL(call_handle_irq)
+	ld	r8,0(r7)
 	mflr	r0
 	std	r0,16(r1)
-	stdu	r1,THREAD_SIZE-112(r5)
-	mr	r1,r5
-	bl	.__do_IRQ
+	mtctr	r8
+	stdu	r1,THREAD_SIZE-112(r6)
+	mr	r1,r6
+	bctrl
 	ld	r1,0(r1)
 	ld	r0,16(r1)
 	mtlr	r0
Index: linux-work/include/asm-powerpc/irq.h
===================================================================
--- linux-work.orig/include/asm-powerpc/irq.h	2006-06-05 15:29:37.000000000 +1000
+++ linux-work/include/asm-powerpc/irq.h	2006-06-05 15:50:53.000000000 +1000
@@ -494,8 +494,8 @@ extern struct thread_info *softirq_ctx[N
 
 extern void irq_ctx_init(void);
 extern void call_do_softirq(struct thread_info *tp);
-extern int call___do_IRQ(int irq, struct pt_regs *regs,
-		struct thread_info *tp);
+extern int call_handle_irq(int irq, void *p1, void *p2,
+			   struct thread_info *tp, void *func);
 
 #else
 #define irq_ctx_init()
