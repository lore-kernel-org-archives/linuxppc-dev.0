Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <526423a25b0e40c03678f4bb1d56e4b5719ab74d.1180682602.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/1] Use NO_IRQ not IRQ_NONE
Date: Fri,  1 Jun 2007 17:23:26 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is a thinko in the irq code, it uses IRQ_NONE to indicate no irq,
whereas it should be using NO_IRQ. IRQ_NONE is returned from irq handlers
to say "not handled".

As it happens they currently have the same value (0), so this is just for
future proof-ness.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 068377a..42c8ed6 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -489,7 +489,7 @@ struct irq_host *irq_alloc_host(unsigned int revmap_type,
 	case IRQ_HOST_MAP_LINEAR:
 		rmap = (unsigned int *)(host + 1);
 		for (i = 0; i < revmap_arg; i++)
-			rmap[i] = IRQ_NONE;
+			rmap[i] = NO_IRQ;
 		host->revmap_data.linear.size = revmap_arg;
 		smp_wmb();
 		host->revmap_data.linear.revmap = rmap;
@@ -614,7 +614,7 @@ unsigned int irq_create_mapping(struct irq_host *host,
 	 * host->ops->map() to update the flags
 	 */
 	virq = irq_find_mapping(host, hwirq);
-	if (virq != IRQ_NONE) {
+	if (virq != NO_IRQ) {
 		if (host->ops->remap)
 			host->ops->remap(host, virq, hwirq);
 		pr_debug("irq: -> existing mapping on virq %d\n", virq);
@@ -741,7 +741,7 @@ void irq_dispose_mapping(unsigned int virq)
 	switch(host->revmap_type) {
 	case IRQ_HOST_MAP_LINEAR:
 		if (hwirq < host->revmap_data.linear.size)
-			host->revmap_data.linear.revmap[hwirq] = IRQ_NONE;
+			host->revmap_data.linear.revmap[hwirq] = NO_IRQ;
 		break;
 	case IRQ_HOST_MAP_TREE:
 		/* Check if radix tree allocated yet */
-- 
1.5.1.3.g7a33b
