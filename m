Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B0F767C1F
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 16:05:05 +1000 (EST)
Subject: [PATCH] powerpc: Improve IRQ radix tree locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 16:04:52 +1000
Message-Id: <1156485893.8433.315.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When reworking the powerpc irq code, I figured out that we were using
the radix tree in a racy way. As a temporary fix, I put a spinlock in
there. However, this can have a significant impact on performances. This
patch reworks that to use a smarter technique based on the fact that
what we need is in fact a rwlock with extremely rare writers (thus
optimized for the read path).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/irq.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/irq.c	2006-08-25 14:08:41.000000000 +1000
+++ linux-work/arch/powerpc/kernel/irq.c	2006-08-25 15:56:17.000000000 +1000
@@ -322,7 +322,8 @@ EXPORT_SYMBOL(do_softirq);
 
 static LIST_HEAD(irq_hosts);
 static spinlock_t irq_big_lock = SPIN_LOCK_UNLOCKED;
-
+static DEFINE_PER_CPU(unsigned int, irq_radix_reader);
+static unsigned int irq_radix_writer;
 struct irq_map_entry irq_map[NR_IRQS];
 static unsigned int irq_virq_count = NR_IRQS;
 static struct irq_host *irq_default_host;
@@ -455,6 +456,60 @@ void irq_set_virq_count(unsigned int cou
 		irq_virq_count = count;
 }
 
+/* radix tree not lockless safe ! we use a brlock-type mecanism
+ * for now, until we can use a lockless radix tree
+ */
+static void irq_radix_wrlock(unsigned long *flags)
+{
+	unsigned int cpu, ok;
+
+	spin_lock_irqsave(&irq_big_lock, *flags);
+	irq_radix_writer = 1;
+	do {
+		ok = 1;
+		smp_mb();
+		for_each_possible_cpu(cpu) {
+			if (per_cpu(irq_radix_reader, cpu)) {
+				ok = 0;
+				break;
+			}
+		}
+		if (!ok)
+			cpu_relax();
+	} while(!ok);
+}
+
+static void irq_radix_wrunlock(unsigned long flags)
+{
+	smp_wmb();
+	irq_radix_writer = 0;
+	spin_unlock_irqrestore(&irq_big_lock, flags);
+}
+
+static void irq_radix_rdlock(unsigned long *flags)
+{
+	local_irq_save(*flags);
+	if (irq_radix_writer)
+		goto slow;
+	__get_cpu_var(irq_radix_reader) = 1;
+	smp_mb();
+	if (irq_radix_writer == 0)
+		return;
+	__get_cpu_var(irq_radix_reader) = 0;
+	smp_wmb();
+ slow:
+	spin_lock(&irq_big_lock);
+	__get_cpu_var(irq_radix_reader) = 1;
+	spin_unlock(&irq_big_lock);
+}
+
+static void irq_radix_rdunlock(unsigned long flags)
+{
+	__get_cpu_var(irq_radix_reader) = 0;
+	local_irq_restore(flags);
+}
+
+
 unsigned int irq_create_mapping(struct irq_host *host,
 				irq_hw_number_t hwirq)
 {
@@ -604,13 +659,9 @@ void irq_dispose_mapping(unsigned int vi
 		/* Check if radix tree allocated yet */
 		if (host->revmap_data.tree.gfp_mask == 0)
 			break;
-		/* XXX radix tree not safe ! remove lock whem it becomes safe
-		 * and use some RCU sync to make sure everything is ok before we
-		 * can re-use that map entry
-		 */
-		spin_lock_irqsave(&irq_big_lock, flags);
+		irq_radix_wrlock(&flags);
 		radix_tree_delete(&host->revmap_data.tree, hwirq);
-		spin_unlock_irqrestore(&irq_big_lock, flags);
+		irq_radix_wrunlock(flags);
 		break;
 	}
 
@@ -677,25 +728,24 @@ unsigned int irq_radix_revmap(struct irq
 	if (tree->gfp_mask == 0)
 		return irq_find_mapping(host, hwirq);
 
-	/* XXX Current radix trees are NOT SMP safe !!! Remove that lock
-	 * when that is fixed (when Nick's patch gets in
-	 */
-	spin_lock_irqsave(&irq_big_lock, flags);
-
 	/* Now try to resolve */
+	irq_radix_rdlock(&flags);
 	ptr = radix_tree_lookup(tree, hwirq);
+	irq_radix_rdunlock(flags);
+
 	/* Found it, return */
 	if (ptr) {
 		virq = ptr - irq_map;
-		goto bail;
+		return virq;
 	}
 
 	/* If not there, try to insert it */
 	virq = irq_find_mapping(host, hwirq);
-	if (virq != NO_IRQ)
+	if (virq != NO_IRQ) {
+		irq_radix_wrlock(&flags);
 		radix_tree_insert(tree, hwirq, &irq_map[virq]);
- bail:
-	spin_unlock_irqrestore(&irq_big_lock, flags);
+		irq_radix_wrunlock(flags);
+	}
 	return virq;
 }
 
@@ -806,12 +856,12 @@ static int irq_late_init(void)
 	struct irq_host *h;
 	unsigned long flags;
 
-	spin_lock_irqsave(&irq_big_lock, flags);
+	irq_radix_wrlock(&flags);
 	list_for_each_entry(h, &irq_hosts, link) {
 		if (h->revmap_type == IRQ_HOST_MAP_TREE)
 			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_ATOMIC);
 	}
-	spin_unlock_irqrestore(&irq_big_lock, flags);
+	irq_radix_wrunlock(flags);
 
 	return 0;
 }
