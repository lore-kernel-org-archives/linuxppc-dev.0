Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 63E901009D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:40 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <69f5978c647fad7a57b39de2a3c10f2f2bccb642.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:53 -0500
Subject: [PATCH 23/37] powerpc: radix trees are available before init_IRQ
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the generic irq code uses a radix tree for sparse interrupts,
the initcall ordering has been changed to initialize radix trees before
irqs.   We no longer need to defer creating revmap radix trees to the
arch_initcall irq_late_init.

Also, the kmem caches are allocated so we don't need to use
zalloc_maybe_bootmem.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/kernel/irq.c |   78 ++------------------------------------------
 1 files changed, 4 insertions(+), 74 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 826552c..f42e869 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -493,7 +493,6 @@ struct irq_map_entry {
 
 static LIST_HEAD(irq_hosts);
 static DEFINE_RAW_SPINLOCK(irq_big_lock);
-static unsigned int revmap_trees_allocated;
 static DEFINE_MUTEX(revmap_trees_mutex);
 static struct irq_map_entry irq_map[NR_IRQS];
 static unsigned int irq_virq_count = NR_IRQS;
@@ -537,7 +536,7 @@ struct irq_host *irq_alloc_host(struct device_node *of_node,
 	/* Allocate structure and revmap table if using linear mapping */
 	if (revmap_type == IRQ_HOST_MAP_LINEAR)
 		size += revmap_arg * sizeof(unsigned int);
-	host = zalloc_maybe_bootmem(size, GFP_KERNEL);
+	host = kzalloc(size, GFP_KERNEL);
 	if (host == NULL)
 		return NULL;
 
@@ -605,6 +604,9 @@ struct irq_host *irq_alloc_host(struct device_node *of_node,
 		smp_wmb();
 		host->revmap_data.linear.revmap = rmap;
 		break;
+	case IRQ_HOST_MAP_TREE:
+		INIT_RADIX_TREE(&host->revmap_data.tree, GFP_KERNEL);
+		break;
 	default:
 		break;
 	}
@@ -839,13 +841,6 @@ void irq_dispose_mapping(unsigned int virq)
 			host->revmap_data.linear.revmap[hwirq] = NO_IRQ;
 		break;
 	case IRQ_HOST_MAP_TREE:
-		/*
-		 * Check if radix tree allocated yet, if not then nothing to
-		 * remove.
-		 */
-		smp_rmb();
-		if (revmap_trees_allocated < 1)
-			break;
 		mutex_lock(&revmap_trees_mutex);
 		radix_tree_delete(&host->revmap_data.tree, hwirq);
 		mutex_unlock(&revmap_trees_mutex);
@@ -906,14 +901,6 @@ unsigned int irq_radix_revmap_lookup(struct irq_host *host,
 	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
 
 	/*
-	 * Check if the radix tree exists and has bee initialized.
-	 * If not, we fallback to slow mode
-	 */
-	if (revmap_trees_allocated < 2)
-		return irq_find_mapping(host, hwirq);
-
-	/* Now try to resolve */
-	/*
 	 * No rcu_read_lock(ing) needed, the ptr returned can't go under us
 	 * as it's referencing an entry in the static irq_map table.
 	 */
@@ -935,18 +922,8 @@ unsigned int irq_radix_revmap_lookup(struct irq_host *host,
 void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
 			     irq_hw_number_t hwirq)
 {
-
 	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
 
-	/*
-	 * Check if the radix tree exists yet.
-	 * If not, then the irq will be inserted into the tree when it gets
-	 * initialized.
-	 */
-	smp_rmb();
-	if (revmap_trees_allocated < 1)
-		return;
-
 	if (virq != NO_IRQ) {
 		mutex_lock(&revmap_trees_mutex);
 		radix_tree_insert(&host->revmap_data.tree, hwirq,
@@ -1054,53 +1031,6 @@ int arch_early_irq_init(void)
 	return 0;
 }
 
-/* We need to create the radix trees late */
-static int irq_late_init(void)
-{
-	struct irq_host *h;
-	unsigned int i;
-
-	/*
-	 * No mutual exclusion with respect to accessors of the tree is needed
-	 * here as the synchronization is done via the state variable
-	 * revmap_trees_allocated.
-	 */
-	list_for_each_entry(h, &irq_hosts, link) {
-		if (h->revmap_type == IRQ_HOST_MAP_TREE)
-			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_KERNEL);
-	}
-
-	/*
-	 * Make sure the radix trees inits are visible before setting
-	 * the flag
-	 */
-	smp_wmb();
-	revmap_trees_allocated = 1;
-
-	/*
-	 * Insert the reverse mapping for those interrupts already present
-	 * in irq_map[].
-	 */
-	mutex_lock(&revmap_trees_mutex);
-	for (i = 0; i < irq_virq_count; i++) {
-		if (irq_map[i].host &&
-		    (irq_map[i].host->revmap_type == IRQ_HOST_MAP_TREE))
-			radix_tree_insert(&irq_map[i].host->revmap_data.tree,
-					  irq_map[i].hwirq, &irq_map[i]);
-	}
-	mutex_unlock(&revmap_trees_mutex);
-
-	/*
-	 * Make sure the radix trees insertions are visible before setting
-	 * the flag
-	 */
-	smp_wmb();
-	revmap_trees_allocated = 2;
-
-	return 0;
-}
-arch_initcall(irq_late_init);
-
 #ifdef CONFIG_VIRQ_DEBUG
 static int virq_debug_show(struct seq_file *m, void *private)
 {
-- 
1.7.0.4
