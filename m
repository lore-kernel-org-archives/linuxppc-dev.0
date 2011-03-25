Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 387431007F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:15 +1100 (EST)
Message-Id: <20110325164141.807239107@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:22 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 12/14] powerpc: irq: Use irqdata based information
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

We want to tighten the irq_desc access. So use the new accessors for
the same information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/irq.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

Index: linux-2.6-tip/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6-tip/arch/powerpc/kernel/irq.c
@@ -276,7 +276,7 @@ int show_interrupts(struct seq_file *p, 
 		seq_printf(p, "  %-16s", chip->name);
 	else
 		seq_printf(p, "  %-16s", "None");
-	seq_printf(p, " %-8s", (desc->status & IRQ_LEVEL) ? "Level" : "Edge");
+	seq_printf(p, " %-8s", (irqd_is_level_type(&desc->irq_data) ? "Level" : "Edge");
 
 	if (action) {
 		seq_printf(p, "     %s", action->name);
@@ -315,24 +315,25 @@ void fixup_irqs(const struct cpumask *ma
 	alloc_cpumask_var(&mask, GFP_KERNEL);
 
 	for_each_irq(irq) {
+		struct irq_data *data;
 		struct irq_chip *chip;
 
-		desc = irq_to_desc(irq);
-		if (!desc)
+		data = irq_get_irq_data(irq);
+		if (!data)
 			continue;
 
-		if (desc->status & IRQ_PER_CPU)
+		if (irqd_is_per_cpu(data))
 			continue;
 
-		chip = get_irq_desc_chip(desc);
+		chip = irq_data_get_chip(data);
 
-		cpumask_and(mask, desc->irq_data.affinity, map);
+		cpumask_and(mask, data->affinity, map);
 		if (cpumask_any(mask) >= nr_cpu_ids) {
 			printk("Breaking affinity for irq %i\n", irq);
 			cpumask_copy(mask, map);
 		}
 		if (chip->irq_set_affinity)
-			chip->irq_set_affinity(&desc->irq_data, mask, true);
+			chip->irq_set_affinity(data, mask, true);
 		else if (desc->action && !(warned++))
 			printk("Cannot set affinity for irq %i\n", irq);
 	}
@@ -827,7 +828,7 @@ unsigned int irq_create_of_mapping(struc
 
 	/* Set type if specified and different than the current one */
 	if (type != IRQ_TYPE_NONE &&
-	    type != (irq_to_desc(virq)->status & IRQF_TRIGGER_MASK))
+	    type != (irqd_get_trigger_type(irq_get_irq_data(virq))))
 		set_irq_type(virq, type);
 	return virq;
 }
