Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3c91644d7ab701f99ec7f621fc5c16d23e75c71a.1210220561.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/2] Add irq_free_host() to free an irq_host
Date: Thu,  8 May 2008 14:23:10 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently there is no irq_free_host() routine, and that's
more or less OK - because all you need to do is free it.
However the next patch needs to introduce additional
tear down so we'll need a proper free routine.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |   15 ++++++++-------
 include/asm-powerpc/irq.h |    8 ++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)


ps.  This is 27 material.

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2f73f70..8ba8fbf 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -442,6 +442,13 @@ static int default_irq_host_match(struct irq_host *h, struct device_node *np)
 	return h->of_node != NULL && h->of_node == np;
 }
 
+void irq_free_host(struct irq_host *host)
+{
+	/* If it's still very early in boot we can't free, oh well. */
+	if (mem_init_done)
+		kfree(host);
+}
+
 struct irq_host *irq_alloc_host(struct device_node *of_node,
 				unsigned int revmap_type,
 				unsigned int revmap_arg,
@@ -478,13 +485,7 @@ struct irq_host *irq_alloc_host(struct device_node *of_node,
 	if (revmap_type == IRQ_HOST_MAP_LEGACY) {
 		if (irq_map[0].host != NULL) {
 			spin_unlock_irqrestore(&irq_big_lock, flags);
-			/* If we are early boot, we can't free the structure,
-			 * too bad...
-			 * this will be fixed once slab is made available early
-			 * instead of the current cruft
-			 */
-			if (mem_init_done)
-				kfree(host);
+			irq_free_host(host);
 			return NULL;
 		}
 		irq_map[0].host = host;
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 5089deb..7d9974a 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -165,6 +165,14 @@ extern struct irq_host *irq_alloc_host(struct device_node *of_node,
 				       struct irq_host_ops *ops,
 				       irq_hw_number_t inval_irq);
 
+/**
+ * irq_free_host - Free an irq_host data structure
+ * @host: The irq_host to free.
+ *
+ * Does any required cleanup and then frees the irq_host.
+ */
+extern void irq_free_host(struct irq_host *host);
+
 
 /**
  * irq_find_host - Locates a host for a given device node
-- 
1.5.5
