Return-Path: <anton@ozlabs.org>
Date: Sun, 31 Jan 2010 22:09:38 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 1/5] powerpc: Rework /proc/interrupts
Message-ID: <20100131110938.GL2996@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On a large machine I noticed the columns of /proc/interrupts failed to line up
with the header after CPU9. At sufficiently large numbers of CPUs it becomes
impossible to line up the CPU number with the counts.

While fixing this I noticed x86 has a number of updates that we may as well
pull in. On PowerPC we currently omit an interrupt completely if there is no
active handler, whereas on x86 it is printed if there is a non zero count.

The x86 code also spaces the first column correctly based on nr_irqs.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

This patch follows on from "powerpc: Reduce footprint of irq_stat" and
"powerpc: Reduce footprint of xics_ipi_struct"

Index: linux-cpumask/arch/powerpc/kernel/irq.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/irq.c	2010-01-30 19:56:31.650960989 +1100
+++ linux-cpumask/arch/powerpc/kernel/irq.c	2010-01-30 22:31:00.037227967 +1100
@@ -183,30 +183,46 @@ notrace void raw_local_irq_restore(unsig
 EXPORT_SYMBOL(raw_local_irq_restore);
 #endif /* CONFIG_PPC64 */
 
+static int show_other_interrupts(struct seq_file *p, int prec)
+{
+	int j;
+
+#if defined(CONFIG_PPC32) && defined(CONFIG_TAU_INT)
+	if (tau_initialized) {
+		seq_printf(p, "%*s: ", prec, "TAU");
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", tau_interrupts(j));
+		seq_puts(p, "  PowerPC             Thermal Assist (cpu temp)\n");
+	}
+#endif /* CONFIG_PPC32 && CONFIG_TAU_INT */
+
+	seq_printf(p, "%*s: %10u\n", prec, "BAD", ppc_spurious_interrupts);
+
+	return 0;
+}
+
 int show_interrupts(struct seq_file *p, void *v)
 {
-	int i = *(loff_t *)v, j;
+	unsigned long flags, any_count = 0;
+	int i = *(loff_t *) v, j, prec;
 	struct irqaction *action;
 	struct irq_desc *desc;
-	unsigned long flags;
 
+	if (i > nr_irqs)
+		return 0;
+
+	for (prec = 3, j = 1000; prec < 10 && j <= nr_irqs; ++prec)
+		j *= 10;
+
+	if (i == nr_irqs)
+		return show_other_interrupts(p, prec);
+
+	/* print header */
 	if (i == 0) {
-		seq_puts(p, "           ");
+		seq_printf(p, "%*s", prec + 8, "");
 		for_each_online_cpu(j)
-			seq_printf(p, "CPU%d       ", j);
+			seq_printf(p, "CPU%-8d", j);
 		seq_putc(p, '\n');
-	} else if (i == nr_irqs) {
-#if defined(CONFIG_PPC32) && defined(CONFIG_TAU_INT)
-		if (tau_initialized){
-			seq_puts(p, "TAU: ");
-			for_each_online_cpu(j)
-				seq_printf(p, "%10u ", tau_interrupts(j));
-			seq_puts(p, "  PowerPC             Thermal Assist (cpu temp)\n");
-		}
-#endif /* CONFIG_PPC32 && CONFIG_TAU_INT*/
-		seq_printf(p, "BAD: %10u\n", ppc_spurious_interrupts);
-
-		return 0;
 	}
 
 	desc = irq_to_desc(i);
@@ -214,34 +230,31 @@ int show_interrupts(struct seq_file *p, 
 		return 0;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
-
+	for_each_online_cpu(j)
+		any_count |= kstat_irqs_cpu(i, j);
 	action = desc->action;
-	if (!action || !action->handler)
-		goto skip;
+	if (!action && !any_count)
+		goto out;
 
-	seq_printf(p, "%3d: ", i);
-#ifdef CONFIG_SMP
+	seq_printf(p, "%*d: ", prec, i);
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
-#else
-	seq_printf(p, "%10u ", kstat_irqs(i));
-#endif /* CONFIG_SMP */
 
 	if (desc->chip)
-		seq_printf(p, " %s ", desc->chip->name);
+		seq_printf(p, "  %-16s", desc->chip->name);
 	else
-		seq_puts(p, "  None      ");
+		seq_printf(p, "  %-16s", "None");
+	seq_printf(p, " %-8s", (desc->status & IRQ_LEVEL) ? "Level" : "Edge");
 
-	seq_printf(p, "%s", (desc->status & IRQ_LEVEL) ? "Level " : "Edge  ");
-	seq_printf(p, "    %s", action->name);
+	if (action) {
+		seq_printf(p, "     %s", action->name);
+		while ((action = action->next) != NULL)
+			seq_printf(p, ", %s", action->name);
+	}
 
-	for (action = action->next; action; action = action->next)
-		seq_printf(p, ", %s", action->name);
 	seq_putc(p, '\n');
-
-skip:
+out:
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
-
 	return 0;
 }
 
