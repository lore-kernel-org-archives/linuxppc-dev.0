Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 3F14CB7002
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 16:34:24 +1000 (EST)
Subject: [PATCH 4/8] powerpc irq: always free duplicate IRQ_LEGACY hosts
Message-Id: <irq-legacy-kfree@mdm.bga.com>
From: Milton Miller <miltonm@bga.com>
In-Reply-To: <more-irq-cleanups@mdm.bga.com>
References: <more-irq-cleanups@mdm.bga.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 May 2011 01:34:17 -0500
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since kmem caches are allocated before init_IRQ as noted in 3af259d155
(powerpc: Radix trees are available before init_IRQ), we now call
kmalloc in all cases and can can always call kfree if we are asked
to allocate a duplicate or conflicting IRQ_HOST_MAP_LEGACY host.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: work.git/arch/powerpc/kernel/irq.c
===================================================================
--- work.git.orig/arch/powerpc/kernel/irq.c	2011-05-19 05:51:25.715500763 -0500
+++ work.git/arch/powerpc/kernel/irq.c	2011-05-19 05:57:30.776503350 -0500
@@ -557,15 +557,8 @@ struct irq_host *irq_alloc_host(struct d
 	if (revmap_type == IRQ_HOST_MAP_LEGACY) {
 		if (irq_map[0].host != NULL) {
 			raw_spin_unlock_irqrestore(&irq_big_lock, flags);
-			/* If we are early boot, we can't free the structure,
-			 * too bad...
-			 * this will be fixed once slab is made available early
-			 * instead of the current cruft
-			 */
-			if (mem_init_done) {
-				of_node_put(host->of_node);
-				kfree(host);
-			}
+			of_node_put(host->of_node);
+			kfree(host);
 			return NULL;
 		}
 		irq_map[0].host = host;
