Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C333B7E91
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 11:00:24 +1100 (EST)
Date: Tue, 8 Mar 2011 01:00:20 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 27/28] powerpc: core irq_data conversion.
Message-ID: <20110308000020.GF16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1299541392.git.buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/powerpc/kernel/irq.c           |   23 ++++++++++++++++-------
 arch/powerpc/kernel/machine_kexec.c |   21 ++++++++++++---------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ce557f6..4a9fa84 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -237,6 +237,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	int i = *(loff_t *) v, j, prec;
 	struct irqaction *action;
 	struct irq_desc *desc;
+	struct irq_chip *chip;
 
 	if (i > nr_irqs)
 		return 0;
@@ -270,8 +271,9 @@ int show_interrupts(struct seq_file *p, void *v)
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
 
-	if (desc->chip)
-		seq_printf(p, "  %-16s", desc->chip->name);
+	chip = get_irq_desc_chip(desc);
+	if (chip)
+		seq_printf(p, "  %-16s", chip->name);
 	else
 		seq_printf(p, "  %-16s", "None");
 	seq_printf(p, " %-8s", (desc->status & IRQ_LEVEL) ? "Level" : "Edge");
@@ -313,6 +315,8 @@ void fixup_irqs(const struct cpumask *map)
 	alloc_cpumask_var(&mask, GFP_KERNEL);
 
 	for_each_irq(irq) {
+		struct irq_chip *chip;
+
 		desc = irq_to_desc(irq);
 		if (!desc)
 			continue;
@@ -320,13 +324,15 @@ void fixup_irqs(const struct cpumask *map)
 		if (desc->status & IRQ_PER_CPU)
 			continue;
 
-		cpumask_and(mask, desc->affinity, map);
+		chip = get_irq_desc_chip(desc);
+
+		cpumask_and(mask, desc->irq_data.affinity, map);
 		if (cpumask_any(mask) >= nr_cpu_ids) {
 			printk("Breaking affinity for irq %i\n", irq);
 			cpumask_copy(mask, map);
 		}
-		if (desc->chip->set_affinity)
-			desc->chip->set_affinity(irq, mask);
+		if (chip->irq_set_affinity)
+			chip->irq_set_affinity(&desc->irq_data, mask, true);
 		else if (desc->action && !(warned++))
 			printk("Cannot set affinity for irq %i\n", irq);
 	}
@@ -1159,11 +1165,14 @@ static int virq_debug_show(struct seq_file *m, void *private)
 		raw_spin_lock_irqsave(&desc->lock, flags);
 
 		if (desc->action && desc->action->handler) {
+			struct irq_chip *chip;
+
 			seq_printf(m, "%5d  ", i);
 			seq_printf(m, "0x%05lx  ", virq_to_hw(i));
 
-			if (desc->chip && desc->chip->name)
-				p = desc->chip->name;
+			chip = get_irq_desc_chip(desc);
+			if (chip && chip->name)
+				p = chip->name;
 			else
 				p = none;
 			seq_printf(m, "%-15s  ", p);
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index a5f8672..bd1e1ff 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -26,20 +26,23 @@ void machine_kexec_mask_interrupts(void) {
 
 	for_each_irq(i) {
 		struct irq_desc *desc = irq_to_desc(i);
+		struct irq_chip *chip;
 
-		if (!desc || !desc->chip)
+		if (!desc)
 			continue;
 
-		if (desc->chip->eoi &&
-		    desc->status & IRQ_INPROGRESS)
-			desc->chip->eoi(i);
+		chip = get_irq_desc_chip(desc);
+		if (!chip)
+			continue;
+
+		if (chip->irq_eoi && desc->status & IRQ_INPROGRESS)
+			chip->irq_eoi(&desc->irq_data);
 
-		if (desc->chip->mask)
-			desc->chip->mask(i);
+		if (chip->irq_mask)
+			chip->irq_mask(&desc->irq_data);
 
-		if (desc->chip->disable &&
-		    !(desc->status & IRQ_DISABLED))
-			desc->chip->disable(i);
+		if (chip->irq_disable && !(desc->status & IRQ_DISABLED))
+			chip->irq_disable(&desc->irq_data);
 	}
 }
 
-- 
1.7.4
