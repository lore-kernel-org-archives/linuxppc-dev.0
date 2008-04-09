Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@ozlabs.org>
Date: Wed, 09 Apr 2008 17:21:28 +1000
Subject: [PATCH 3/6] [POWERPC] Fixup softirq preempt count
Message-Id: <20080409072227.9244CDDE3A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes the handling of the preempt count when switching
interrupt stacks so that HW interrupt properly get the softirq
mask copied over from the previous stack.

It also initializes the softirq stack preempt_count to 0 instead
of SOFTIRQ_OFFSET, like x86, as __do_softirq() does the increment,
and we hit some lockdep checks if we have it twice.

That means we do run for a little while off the softirq stack
with the preempt-count set to 0, which could be deadly if we
try to take a softirq at that point, however we do so with
interrupts disabled, so I think we are ok.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/irq.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/kernel/irq.c	2008-04-02 16:48:58.000000000 +1100
+++ linux-work/arch/powerpc/kernel/irq.c	2008-04-02 16:49:36.000000000 +1100
@@ -310,8 +310,21 @@ void do_IRQ(struct pt_regs *regs)
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
+
+			/* Set any flag that may have been set on the
+			 * alternate stack
+			 */
 			if (irqtp->flags)
 				set_bits(irqtp->flags, &curtp->flags);
 		} else
@@ -357,7 +370,7 @@ void irq_ctx_init(void)
 		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
 		tp = softirq_ctx[i];
 		tp->cpu = i;
-		tp->preempt_count = SOFTIRQ_OFFSET;
+		tp->preempt_count = 0;
 
 		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
 		tp = hardirq_ctx[i];
