Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 317CC1009B7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:40 +1100 (EST)
Message-Id: <20110325164142.002913929@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:25 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 14/14] powerpc: Use generic show_interrupts()
References: <20110325164049.138289403@linutronix.de>
Cc: Lennert Buytenhek <buytenh@secretlab.ca>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/Kconfig      |    2 +
 arch/powerpc/kernel/irq.c |   61 ----------------------------------------------
 2 files changed, 3 insertions(+), 60 deletions(-)

Index: linux-2.6-tip/arch/powerpc/Kconfig
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/Kconfig
+++ linux-2.6-tip/arch/powerpc/Kconfig
@@ -135,6 +135,8 @@ config PPC
 	select HAVE_SPARSE_IRQ
 	select IRQ_PER_CPU
 	select GENERIC_HARDIRQS_NO_DEPRECATED
+	select GENERIC_IRQ_SHOW
+	select GENERIC_IRQ_SHOW_LEVEL
 
 config EARLY_PRINTK
 	bool
Index: linux-2.6-tip/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6-tip/arch/powerpc/kernel/irq.c
@@ -195,7 +195,7 @@ notrace void arch_local_irq_restore(unsi
 EXPORT_SYMBOL(arch_local_irq_restore);
 #endif /* CONFIG_PPC64 */
 
-static int show_other_interrupts(struct seq_file *p, int prec)
+int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	int j;
 
@@ -231,65 +231,6 @@ static int show_other_interrupts(struct 
 	return 0;
 }
 
-int show_interrupts(struct seq_file *p, void *v)
-{
-	unsigned long flags, any_count = 0;
-	int i = *(loff_t *) v, j, prec;
-	struct irqaction *action;
-	struct irq_desc *desc;
-	struct irq_chip *chip;
-
-	if (i > nr_irqs)
-		return 0;
-
-	for (prec = 3, j = 1000; prec < 10 && j <= nr_irqs; ++prec)
-		j *= 10;
-
-	if (i == nr_irqs)
-		return show_other_interrupts(p, prec);
-
-	/* print header */
-	if (i == 0) {
-		seq_printf(p, "%*s", prec + 8, "");
-		for_each_online_cpu(j)
-			seq_printf(p, "CPU%-8d", j);
-		seq_putc(p, '\n');
-	}
-
-	desc = irq_to_desc(i);
-	if (!desc)
-		return 0;
-
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	for_each_online_cpu(j)
-		any_count |= kstat_irqs_cpu(i, j);
-	action = desc->action;
-	if (!action && !any_count)
-		goto out;
-
-	seq_printf(p, "%*d: ", prec, i);
-	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
-
-	chip = get_irq_desc_chip(desc);
-	if (chip)
-		seq_printf(p, "  %-16s", chip->name);
-	else
-		seq_printf(p, "  %-16s", "None");
-	seq_printf(p, " %-8s", (irqd_is_level_type(&desc->irq_data) ? "Level" : "Edge");
-
-	if (action) {
-		seq_printf(p, "     %s", action->name);
-		while ((action = action->next) != NULL)
-			seq_printf(p, ", %s", action->name);
-	}
-
-	seq_putc(p, '\n');
-out:
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-	return 0;
-}
-
 /*
  * /proc/stat helpers
  */
