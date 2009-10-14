Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <1dec053fee540bd474f88d4850d4ab213ea7215d.1255499081.git.michael@ellerman.id.au>
In-Reply-To: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/6] powerpc: Rearrange and fix show_interrupts() for sparse
	irq_descs
Date: Wed, 14 Oct 2009 16:45:00 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the default case out of the if, ie. when we're just displaying
an irq. And consolidate all the odd cases at the top, ie. printing
the header and footer.

And in the process cope with sparse irq_descs.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |   64 ++++++++++++++++++++++++++-------------------
 1 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index baa49eb..63e27d5 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -187,33 +187,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		for_each_online_cpu(j)
 			seq_printf(p, "CPU%d       ", j);
 		seq_putc(p, '\n');
-	}
-
-	if (i < NR_IRQS) {
-		desc = irq_to_desc(i);
-		spin_lock_irqsave(&desc->lock, flags);
-		action = desc->action;
-		if (!action || !action->handler)
-			goto skip;
-		seq_printf(p, "%3d: ", i);
-#ifdef CONFIG_SMP
-		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
-#else
-		seq_printf(p, "%10u ", kstat_irqs(i));
-#endif /* CONFIG_SMP */
-		if (desc->chip)
-			seq_printf(p, " %s ", desc->chip->typename);
-		else
-			seq_puts(p, "  None      ");
-		seq_printf(p, "%s", (desc->status & IRQ_LEVEL) ? "Level " : "Edge  ");
-		seq_printf(p, "    %s", action->name);
-		for (action = action->next; action; action = action->next)
-			seq_printf(p, ", %s", action->name);
-		seq_putc(p, '\n');
-skip:
-		spin_unlock_irqrestore(&desc->lock, flags);
-	} else if (i == NR_IRQS) {
+	} else if (i == nr_irqs) {
 #if defined(CONFIG_PPC32) && defined(CONFIG_TAU_INT)
 		if (tau_initialized){
 			seq_puts(p, "TAU: ");
@@ -223,7 +197,43 @@ skip:
 		}
 #endif /* CONFIG_PPC32 && CONFIG_TAU_INT*/
 		seq_printf(p, "BAD: %10u\n", ppc_spurious_interrupts);
+
+		return 0;
 	}
+
+	desc = irq_to_desc(i);
+	if (!desc)
+		return 0;
+
+	spin_lock_irqsave(&desc->lock, flags);
+
+	action = desc->action;
+	if (!action || !action->handler)
+		goto skip;
+
+	seq_printf(p, "%3d: ", i);
+#ifdef CONFIG_SMP
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
+#else
+	seq_printf(p, "%10u ", kstat_irqs(i));
+#endif /* CONFIG_SMP */
+
+	if (desc->chip)
+		seq_printf(p, " %s ", desc->chip->typename);
+	else
+		seq_puts(p, "  None      ");
+
+	seq_printf(p, "%s", (desc->status & IRQ_LEVEL) ? "Level " : "Edge  ");
+	seq_printf(p, "    %s", action->name);
+
+	for (action = action->next; action; action = action->next)
+		seq_printf(p, ", %s", action->name);
+	seq_putc(p, '\n');
+
+skip:
+	spin_unlock_irqrestore(&desc->lock, flags);
+
 	return 0;
 }
 
-- 
1.6.2.1
