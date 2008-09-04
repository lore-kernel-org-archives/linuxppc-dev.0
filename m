Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id B15C3DE04A
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 22:37:18 +1000 (EST)
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc - Make the irq reverse mapping radix tree lockless
Date: Thu,  4 Sep 2008 14:37:08 +0200
Message-Id: <1220531828-9732-3-git-send-email-sebastien.dugue@bull.net>
In-Reply-To: <1220531828-9732-1-git-send-email-sebastien.dugue@bull.net>
References: <1220531828-9732-1-git-send-email-sebastien.dugue@bull.net>
Cc: dwalker@mvista.com, tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net, michael@ellerman.id.au,
	sebastien.dugue@bull.net, paulus@samba.org,
	gilles.carry@ext.bull.net, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  The radix trees used by interrupt controllers for their irq reverse mapping
(currently only the XICS found on pSeries) have a complex locking scheme
dating back to before the advent of the lockless radix tree.

  Take advantage of this and of the fact that the items of the tree are
pointers to a static array (irq_map) elements which can never go under us
to simplify the locking.

  Concurrency between readers and writers is handled by the intrinsic
properties of the lockless radix tree. Concurrency between writers is handled
with a global mutex.


Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |   76 ++++++--------------------------------------
 1 files changed, 11 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2656924..ac222d0 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -439,9 +439,8 @@ void do_softirq(void)
 
 static LIST_HEAD(irq_hosts);
 static DEFINE_SPINLOCK(irq_big_lock);
-static DEFINE_PER_CPU(unsigned int, irq_radix_reader);
-static unsigned int irq_radix_writer;
 static unsigned int revmap_trees_allocated;
+static DEFINE_MUTEX(revmap_trees_mutex);
 struct irq_map_entry irq_map[NR_IRQS];
 static unsigned int irq_virq_count = NR_IRQS;
 static struct irq_host *irq_default_host;
@@ -584,57 +583,6 @@ void irq_set_virq_count(unsigned int count)
 		irq_virq_count = count;
 }
 
-/* radix tree not lockless safe ! we use a brlock-type mecanism
- * for now, until we can use a lockless radix tree
- */
-static void irq_radix_wrlock(unsigned long *flags)
-{
-	unsigned int cpu, ok;
-
-	spin_lock_irqsave(&irq_big_lock, *flags);
-	irq_radix_writer = 1;
-	smp_mb();
-	do {
-		barrier();
-		ok = 1;
-		for_each_possible_cpu(cpu) {
-			if (per_cpu(irq_radix_reader, cpu)) {
-				ok = 0;
-				break;
-			}
-		}
-		if (!ok)
-			cpu_relax();
-	} while(!ok);
-}
-
-static void irq_radix_wrunlock(unsigned long flags)
-{
-	smp_wmb();
-	irq_radix_writer = 0;
-	spin_unlock_irqrestore(&irq_big_lock, flags);
-}
-
-static void irq_radix_rdlock(unsigned long *flags)
-{
-	local_irq_save(*flags);
-	__get_cpu_var(irq_radix_reader) = 1;
-	smp_mb();
-	if (likely(irq_radix_writer == 0))
-		return;
-	__get_cpu_var(irq_radix_reader) = 0;
-	smp_wmb();
-	spin_lock(&irq_big_lock);
-	__get_cpu_var(irq_radix_reader) = 1;
-	spin_unlock(&irq_big_lock);
-}
-
-static void irq_radix_rdunlock(unsigned long flags)
-{
-	__get_cpu_var(irq_radix_reader) = 0;
-	local_irq_restore(flags);
-}
-
 static int irq_setup_virq(struct irq_host *host, unsigned int virq,
 			    irq_hw_number_t hwirq)
 {
@@ -789,7 +737,6 @@ void irq_dispose_mapping(unsigned int virq)
 {
 	struct irq_host *host;
 	irq_hw_number_t hwirq;
-	unsigned long flags;
 
 	if (virq == NO_IRQ)
 		return;
@@ -829,9 +776,9 @@ void irq_dispose_mapping(unsigned int virq)
 		smp_rmb();
 		if (revmap_trees_allocated < 1)
 			break;
-		irq_radix_wrlock(&flags);
+		mutex_lock(&revmap_trees_mutex);
 		radix_tree_delete(&host->revmap_data.tree, hwirq);
-		irq_radix_wrunlock(flags);
+		mutex_unlock(&revmap_trees_mutex);
 		break;
 	}
 
@@ -885,7 +832,6 @@ unsigned int irq_radix_revmap_lookup(struct irq_host *host,
 {
 	struct irq_map_entry *ptr;
 	unsigned int virq;
-	unsigned long flags;
 
 	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
 
@@ -897,9 +843,11 @@ unsigned int irq_radix_revmap_lookup(struct irq_host *host,
 		return irq_find_mapping(host, hwirq);
 
 	/* Now try to resolve */
-	irq_radix_rdlock(&flags);
+	/*
+	 * No rcu_read_lock(ing) needed, the ptr returned can't go under us
+	 * as it's referencing an entry in the static irq_map table.
+	 */
 	ptr = radix_tree_lookup(&host->revmap_data.tree, hwirq);
-	irq_radix_rdunlock(flags);
 
 	/*
 	 * If found in radix tree, then fine.
@@ -917,7 +865,6 @@ unsigned int irq_radix_revmap_lookup(struct irq_host *host,
 void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
 			     irq_hw_number_t hwirq)
 {
-	unsigned long flags;
 
 	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
 
@@ -931,10 +878,10 @@ void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
 		return;
 
 	if (virq != NO_IRQ) {
-		irq_radix_wrlock(&flags);
+		mutex_lock(&revmap_trees_mutex);
 		radix_tree_insert(&host->revmap_data.tree, hwirq,
 				  &irq_map[virq]);
-		irq_radix_wrunlock(flags);
+		mutex_unlock(&revmap_trees_mutex);
 	}
 }
 
@@ -1044,7 +991,6 @@ void irq_early_init(void)
 static int irq_late_init(void)
 {
 	struct irq_host *h;
-	unsigned long flags;
 	unsigned int i;
 
 	/*
@@ -1068,14 +1014,14 @@ static int irq_late_init(void)
 	 * Insert the reverse mapping for those interrupts already present
 	 * in irq_map[].
 	 */
-	irq_radix_wrlock(&flags);
+	mutex_lock(&revmap_trees_mutex);
 	for (i = 0; i < irq_virq_count; i++) {
 		if (irq_map[i].host &&
 		    (irq_map[i].host->revmap_type == IRQ_HOST_MAP_TREE))
 			radix_tree_insert(&irq_map[i].host->revmap_data.tree,
 					  irq_map[i].hwirq, &irq_map[i]);
 	}
-	irq_radix_wrunlock(flags);
+	mutex_unlock(&revmap_trees_mutex);
 
 	/*
 	 * Make sure the radix trees insertions are visible before setting
-- 
1.5.5.1
