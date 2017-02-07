Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHQQD2Q0yzDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 11:36:52 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vHQQC2tg9z9s2s
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2017 11:36:51 +1100 (AEDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v170aiW3011891
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Feb 2017 18:36:46 -0600
Message-ID: <1486427804.4850.104.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/irq: Improve/fix migrate_irqs()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Tue, 07 Feb 2017 11:36:44 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

migrate_irqs() is used by some platforms to migrate interrupts
away from a CPU about to be offlined.

The current implementation had various issues such as not taking
the descriptor lock before manipulating it. This refactors it
a bit, fixing that problem at the same time.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/irq.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a018f5c..52308b4 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -456,22 +456,31 @@ void migrate_irqs(void)
 	for_each_irq_desc(irq, desc) {
 		struct irq_data *data;
 		struct irq_chip *chip;
+		const struct cpumask *affinity;
 
-		data = irq_desc_get_irq_data(desc);
-		if (irqd_is_per_cpu(data))
-			continue;
+		/* Interrupts are already disabled */
+		raw_spin_lock(&desc->lock);
 
+		data = irq_desc_get_irq_data(desc);
+		affinity = irq_data_get_affinity_mask(data);
 		chip = irq_data_get_irq_chip(data);
+		if (!irq_has_action(irq) || irqd_is_per_cpu(data) ||
+		    cpumask_subset(affinity, cpu_online_mask) ||
+		    !chip) {
+			raw_spin_unlock(&desc->lock);
+			continue;
+		}
 
-		cpumask_and(mask, irq_data_get_affinity_mask(data), map);
-		if (cpumask_any(mask) >= nr_cpu_ids) {
+		cpumask_and(mask, affinity, map);
+		if (cpumask_empty(mask)) {
 			pr_warn("Breaking affinity for irq %i\n", irq);
 			cpumask_copy(mask, map);
 		}
 		if (chip->irq_set_affinity)
 			chip->irq_set_affinity(data, mask, true);
 		else if (desc->action && !(warned++))
-			pr_err("Cannot set affinity for irq %i\n", irq);
+			pr_debug("Cannot set affinity for irq %i\n", irq);
+		raw_spin_unlock(&desc->lock);
 	}
 
 	free_cpumask_var(mask);
