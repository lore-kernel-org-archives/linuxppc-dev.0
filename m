Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3788B2C0172
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 08:40:09 +1100 (EST)
Message-Id: <20140223212736.333718121@linutronix.de>
Date: Sun, 23 Feb 2014 21:40:08 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 01/26] powerpc: irq: Use generic_handle_irq
References: <20140223212703.511977310@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
 ppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No functional change

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ppc <linuxppc-dev@lists.ozlabs.org>
---
 arch/powerpc/kernel/irq.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: tip/arch/powerpc/kernel/irq.c
===================================================================
--- tip.orig/arch/powerpc/kernel/irq.c
+++ tip/arch/powerpc/kernel/irq.c
@@ -465,7 +465,6 @@ static inline void check_stack_overflow(
 
 void __do_irq(struct pt_regs *regs)
 {
-	struct irq_desc *desc;
 	unsigned int irq;
 
 	irq_enter();
@@ -487,11 +486,8 @@ void __do_irq(struct pt_regs *regs)
 	/* And finally process it */
 	if (unlikely(irq == NO_IRQ))
 		__get_cpu_var(irq_stat).spurious_irqs++;
-	else {
-		desc = irq_to_desc(irq);
-		if (likely(desc))
-			desc->handle_irq(irq, desc);
-	}
+	else
+		generic_handle_irq(irq);
 
 	trace_irq_exit(regs);
 
