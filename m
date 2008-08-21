Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 50B3DDE433
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 17:10:18 +1000 (EST)
Date: Thu, 21 Aug 2008 00:10:17 -0700 (PDT)
Message-Id: <20080821.001017.261408123.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3]: sparc: Implement irq_of_parse_and_map() and
	irq_dispose_mapping().
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


sparc: Implement irq_of_parse_and_map() and irq_dispose_mapping().

This allows more OF layer code to be shared between powerpc and
sparc.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/prom.h   |    8 ++++++++
 arch/sparc/kernel/of_device.c   |   11 +++++++++++
 arch/sparc64/kernel/of_device.c |   11 +++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index b5efc4d..58b85fa 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -96,6 +96,14 @@ static inline void of_node_put(struct device_node *node)
 {
 }
 
+/* These routines are here to provide compatibility with how powerpc
+ * handles IRQ mapping for OF device nodes.  We precompute and permanently
+ * register them in the of_device objects, whereas powerpc computes them
+ * on request.
+ */
+extern int irq_of_parse_and_map(struct device_node *node, int index);
+#define irq_dispose_mapping(irq) do { } while (0)
+
 /*
  * NB:  This is here while we transition from using asm/prom.h
  * to linux/of.h
diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index cc4c235..56e9a71 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -29,6 +29,17 @@ struct of_device *of_find_device_by_node(struct device_node *dp)
 }
 EXPORT_SYMBOL(of_find_device_by_node);
 
+int irq_of_parse_and_map(struct device_node *node, int index)
+{
+	struct of_device *op = of_find_device_by_node(node);
+
+	if (!op || index >= op->num_irqs)
+		return 0xffffffff;
+
+	return op->irqs[index];
+}
+EXPORT_SYMBOL(irq_of_parse_and_map);
+
 #ifdef CONFIG_PCI
 struct bus_type ebus_bus_type;
 EXPORT_SYMBOL(ebus_bus_type);
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index f8b50cb..8a0d823 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -55,6 +55,17 @@ struct of_device *of_find_device_by_node(struct device_node *dp)
 }
 EXPORT_SYMBOL(of_find_device_by_node);
 
+int irq_of_parse_and_map(struct device_node *node, int index)
+{
+	struct of_device *op = of_find_device_by_node(node);
+
+	if (!op || index >= op->num_irqs)
+		return 0xffffffff;
+
+	return op->irqs[index];
+}
+EXPORT_SYMBOL(irq_of_parse_and_map);
+
 #ifdef CONFIG_PCI
 struct bus_type ebus_bus_type;
 EXPORT_SYMBOL(ebus_bus_type);
-- 
1.5.6.5.GIT
