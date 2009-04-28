Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <8145356a0f1a01511aff073d2e2a9eed42a7a1bd.1240919855.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/6] powerpc: Move #ifdef'ed body of do_IRQ() into a separate
	function
Date: Tue, 28 Apr 2009 21:57:43 +1000 (EST)
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rather than a giant ifdef in the body of do_IRQ(), including a
dangling else, move the irq stack logic into a separate routine and
do the ifdef there.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |   96 ++++++++++++++++++++++++++-------------------
 1 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 8c1a496..3d3658d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -248,13 +248,63 @@ void fixup_irqs(cpumask_t map)
 }
 #endif
 
+#ifdef CONFIG_IRQSTACKS
+static inline void handle_one_irq(unsigned int irq)
+{
+	struct thread_info *curtp, *irqtp;
+	unsigned long saved_sp_limit;
+	struct irq_desc *desc;
+	void *handler;
+
+	/* Switch to the irq stack to handle this */
+	curtp = current_thread_info();
+	irqtp = hardirq_ctx[smp_processor_id()];
+
+	if (curtp == irqtp) {
+		/* We're already on the irq stack, just handle it */
+		generic_handle_irq(irq);
+		return;
+	}
+
+	desc = irq_desc + irq;
+	saved_sp_limit = current->thread.ksp_limit;
+
+	handler = desc->handle_irq;
+	if (handler == NULL)
+		handler = &__do_IRQ;
+
+	irqtp->task = curtp->task;
+	irqtp->flags = 0;
+
+	/* Copy the softirq bits in preempt_count so that the
+	 * softirq checks work in the hardirq context. */
+	irqtp->preempt_count = (irqtp->preempt_count & ~SOFTIRQ_MASK) |
+			       (curtp->preempt_count & SOFTIRQ_MASK);
+
+	current->thread.ksp_limit = (unsigned long)irqtp +
+		_ALIGN_UP(sizeof(struct thread_info), 16);
+
+	call_handle_irq(irq, desc, irqtp, handler);
+	current->thread.ksp_limit = saved_sp_limit;
+	irqtp->task = NULL;
+
+	/* Set any flag that may have been set on the
+	 * alternate stack
+	 */
+	if (irqtp->flags)
+		set_bits(irqtp->flags, &curtp->flags);
+}
+#else
+static inline void handle_one_irq(unsigned int irq)
+{
+	generic_handle_irq(irq);
+}
+#endif
+
 void do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned int irq;
-#ifdef CONFIG_IRQSTACKS
-	struct thread_info *curtp, *irqtp;
-#endif
 
 	irq_enter();
 
@@ -282,43 +332,9 @@ void do_IRQ(struct pt_regs *regs)
 	 */
 	irq = ppc_md.get_irq();
 
-	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE) {
-#ifdef CONFIG_IRQSTACKS
-		/* Switch to the irq stack to handle this */
-		curtp = current_thread_info();
-		irqtp = hardirq_ctx[smp_processor_id()];
-		if (curtp != irqtp) {
-			struct irq_desc *desc = irq_desc + irq;
-			void *handler = desc->handle_irq;
-			unsigned long saved_sp_limit = current->thread.ksp_limit;
-			if (handler == NULL)
-				handler = &__do_IRQ;
-			irqtp->task = curtp->task;
-			irqtp->flags = 0;
-
-			/* Copy the softirq bits in preempt_count so that the
-			 * softirq checks work in the hardirq context.
-			 */
-			irqtp->preempt_count =
-				(irqtp->preempt_count & ~SOFTIRQ_MASK) |
-				(curtp->preempt_count & SOFTIRQ_MASK);
-
-			current->thread.ksp_limit = (unsigned long)irqtp +
-				_ALIGN_UP(sizeof(struct thread_info), 16);
-			call_handle_irq(irq, desc, irqtp, handler);
-			current->thread.ksp_limit = saved_sp_limit;
-			irqtp->task = NULL;
-
-
-			/* Set any flag that may have been set on the
-			 * alternate stack
-			 */
-			if (irqtp->flags)
-				set_bits(irqtp->flags, &curtp->flags);
-		} else
-#endif
-			generic_handle_irq(irq);
-	} else if (irq != NO_IRQ_IGNORE)
+	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE)
+		handle_one_irq(irq);
+	else if (irq != NO_IRQ_IGNORE)
 		/* That's not SMP safe ... but who cares ? */
 		ppc_spurious_interrupts++;
 
-- 
1.6.2.1
