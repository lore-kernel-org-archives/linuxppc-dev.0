Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id CB859100863
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:39 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <a254a95c4fe502cf11a3a094afe0298263c3dbd6.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:57 -0500
Subject: [PATCH 24/37] powerpc: return early if irq_host lookup type is wrong
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If for some reason the code incrorectly calls the wrong function to
manage the revmap, not only should we warn, we should take action.
However, in the paths we expect to be taken every delivered interrupt
change to WARN_ON_ONCE.  Use the if (WARN_ON(x)) format to get the
unlikely for free.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/kernel/irq.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f42e869..4a5aa8c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -814,8 +814,7 @@ void irq_dispose_mapping(unsigned int virq)
 		return;
 
 	host = irq_map[virq].host;
-	WARN_ON (host == NULL);
-	if (host == NULL)
+	if (WARN_ON(host == NULL))
 		return;
 
 	/* Never unmap legacy interrupts */
@@ -898,7 +897,8 @@ unsigned int irq_radix_revmap_lookup(struct irq_host *host,
 	struct irq_map_entry *ptr;
 	unsigned int virq;
 
-	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
+	if (WARN_ON_ONCE(host->revmap_type != IRQ_HOST_MAP_TREE))
+		return irq_find_mapping(host, hwirq);
 
 	/*
 	 * No rcu_read_lock(ing) needed, the ptr returned can't go under us
@@ -922,7 +922,8 @@ unsigned int irq_radix_revmap_lookup(struct irq_host *host,
 void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
 			     irq_hw_number_t hwirq)
 {
-	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
+	if (WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE))
+		return;
 
 	if (virq != NO_IRQ) {
 		mutex_lock(&revmap_trees_mutex);
@@ -937,7 +938,8 @@ unsigned int irq_linear_revmap(struct irq_host *host,
 {
 	unsigned int *revmap;
 
-	WARN_ON(host->revmap_type != IRQ_HOST_MAP_LINEAR);
+	if (WARN_ON_ONCE(host->revmap_type != IRQ_HOST_MAP_LINEAR))
+		return irq_find_mapping(host, hwirq);
 
 	/* Check revmap bounds */
 	if (unlikely(hwirq >= host->revmap_data.linear.size))
-- 
1.7.0.4
