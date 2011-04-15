Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <1f5f992599ff96957491d9d9fb067e78f104d843.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 02/15] of: Export of_irq_find_parent()
Date: Fri, 15 Apr 2011 18:31:57 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

We have platform code that needs to find a node's interrupt parent, so
export of_irq_find_parent() so we can use it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/of/irq.c       |    2 +-
 include/linux/of_irq.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 75b0d3c..9f689f1 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
  * Returns a pointer to the interrupt parent node, or NULL if the interrupt
  * parent could not be determined.
  */
-static struct device_node *of_irq_find_parent(struct device_node *child)
+struct device_node *of_irq_find_parent(struct device_node *child)
 {
 	struct device_node *p;
 	const __be32 *parp;
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 109e013..e6955f5 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -68,6 +68,7 @@ extern int of_irq_to_resource(struct device_node *dev, int index,
 extern int of_irq_count(struct device_node *dev);
 extern int of_irq_to_resource_table(struct device_node *dev,
 		struct resource *res, int nr_irqs);
+extern struct device_node *of_irq_find_parent(struct device_node *child);
 
 #endif /* CONFIG_OF_IRQ */
 #endif /* CONFIG_OF */
-- 
1.7.1
