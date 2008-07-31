Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 52E4EDE03A
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 19:40:13 +1000 (EST)
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc - Initialize the irq radix tree earlier
Date: Thu, 31 Jul 2008 11:40:39 +0200
Message-Id: <1217497241-10685-2-git-send-email-sebastien.dugue@bull.net>
In-Reply-To: <1217497241-10685-1-git-send-email-sebastien.dugue@bull.net>
References: <1217497241-10685-1-git-send-email-sebastien.dugue@bull.net>
Cc: tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net,
	Sebastien Dugue <sebastien.dugue@bull.net>, paulus@samba.org,
	gilles.carry@ext.bull.net, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  The radix tree used for fast irq reverse mapping by the XICS is initialized
late in the boot process, after the first interrupt (IPI) gets registered
and after the first IPI is received.

  This patch moves the initialization of the XICS radix tree earlier into
the boot process in smp_xics_probe() (the mm is already up but no interrupts
have been registered at that point) to avoid having to insert a mapping into
the tree in interrupt context. This will help in simplifying the locking
constraints and move to a lockless radix tree in subsequent patches.

  As a nice side effect, there is no need any longer to check for
(host->revmap_data.tree.gfp_mask != 0) to know if the tree have been
initialized.


Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/irq.c            |   44 +++++++++------------------------
 arch/powerpc/platforms/pseries/smp.c |    1 +
 include/asm-powerpc/irq.h            |    5 ++++
 3 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 6ac8612..0a1445c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -840,9 +840,6 @@ void irq_dispose_mapping(unsigned int virq)
 			host->revmap_data.linear.revmap[hwirq] = NO_IRQ;
 		break;
 	case IRQ_HOST_MAP_TREE:
-		/* Check if radix tree allocated yet */
-		if (host->revmap_data.tree.gfp_mask == 0)
-			break;
 		irq_radix_wrlock(&flags);
 		radix_tree_delete(&host->revmap_data.tree, hwirq);
 		irq_radix_wrunlock(flags);
@@ -893,28 +890,28 @@ unsigned int irq_find_mapping(struct irq_host *host,
 }
 EXPORT_SYMBOL_GPL(irq_find_mapping);
 
+void __init irq_radix_revmap_init(void)
+{
+ 	struct irq_host *h;
+
+	list_for_each_entry(h, &irq_hosts, link) {
+		if (h->revmap_type == IRQ_HOST_MAP_TREE)
+			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_ATOMIC);
+	}
+}
 
 unsigned int irq_radix_revmap(struct irq_host *host,
 			      irq_hw_number_t hwirq)
 {
-	struct radix_tree_root *tree;
 	struct irq_map_entry *ptr;
 	unsigned int virq;
 	unsigned long flags;
 
 	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
 
-	/* Check if the radix tree exist yet. We test the value of
-	 * the gfp_mask for that. Sneaky but saves another int in the
-	 * structure. If not, we fallback to slow mode
-	 */
-	tree = &host->revmap_data.tree;
-	if (tree->gfp_mask == 0)
-		return irq_find_mapping(host, hwirq);
-
-	/* Now try to resolve */
+	/* Try to resolve */
 	irq_radix_rdlock(&flags);
-	ptr = radix_tree_lookup(tree, hwirq);
+	ptr = radix_tree_lookup(&host->revmap_data.tree, hwirq);
 	irq_radix_rdunlock(flags);
 
 	/* Found it, return */
@@ -927,7 +924,7 @@ unsigned int irq_radix_revmap(struct irq_host *host,
 	virq = irq_find_mapping(host, hwirq);
 	if (virq != NO_IRQ) {
 		irq_radix_wrlock(&flags);
-		radix_tree_insert(tree, hwirq, &irq_map[virq]);
+		radix_tree_insert(&host->revmap_data.tree, hwirq, &irq_map[virq]);
 		irq_radix_wrunlock(flags);
 	}
 	return virq;
@@ -1035,23 +1032,6 @@ void irq_early_init(void)
 		get_irq_desc(i)->status |= IRQ_NOREQUEST;
 }
 
-/* We need to create the radix trees late */
-static int irq_late_init(void)
-{
-	struct irq_host *h;
-	unsigned long flags;
-
-	irq_radix_wrlock(&flags);
-	list_for_each_entry(h, &irq_hosts, link) {
-		if (h->revmap_type == IRQ_HOST_MAP_TREE)
-			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_ATOMIC);
-	}
-	irq_radix_wrunlock(flags);
-
-	return 0;
-}
-arch_initcall(irq_late_init);
-
 #ifdef CONFIG_VIRQ_DEBUG
 static int virq_debug_show(struct seq_file *m, void *private)
 {
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 9d8f8c8..b143fe7 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -130,6 +130,7 @@ static void smp_xics_message_pass(int target, int msg)
 
 static int __init smp_xics_probe(void)
 {
+	irq_radix_revmap_init();
 	xics_request_IPIs();
 
 	return cpus_weight(cpu_possible_map);
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 1ef8e30..47b8119 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -237,6 +237,11 @@ extern unsigned int irq_find_mapping(struct irq_host *host,
  */
 extern unsigned int irq_create_direct_mapping(struct irq_host *host);
 
+/*
+ * Initialize the radix tree used by some irq controllers
+ */
+extern void __init irq_radix_revmap_init(void);
+
 /**
  * irq_radix_revmap - Find a linux virq from a hw irq number.
  * @host: host owning this hardware interrupt
-- 
1.5.5.1
