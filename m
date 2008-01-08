Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 2FDD0DDFD6
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 06:22:26 +1100 (EST)
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JUC006XVB3LZR50@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 08 Jan 2008 12:21:21 -0700 (MST)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JUC004OPB31Q450@pd2mr6so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Tue, 08 Jan 2008 12:21:21 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JUC00FZYB2LOR50@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 08 Jan 2008 12:21:01 -0700 (MST)
Date: Tue, 08 Jan 2008 12:20:40 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] Add of_find_matching_node() helper function
To: linuxppc-dev@ozlabs.org
Message-id: <20080108192040.9556.28899.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Similar to of_find_compatible_node(), of_find_matching_node() and
for_each_matching_node() allow you to iterate over the device tree
looking for specific nodes except that it accepts a of_device_id
table instead of strings.

This patch also moves of_match_node() from driver/of/device.c to
driver/of/base.c to colocate it with the of_find_matching_node which
depends on it.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/kernel/ibmebus.c                  |    1 
 arch/powerpc/kernel/of_platform.c              |    1 
 arch/powerpc/platforms/celleb/io-workarounds.c |    1 
 arch/powerpc/platforms/celleb/pci.c            |    1 
 drivers/net/ibm_newemac/core.c                 |    1 
 drivers/of/base.c                              |   58 ++++++++++++++++++++++++
 drivers/of/device.c                            |   29 ------------
 drivers/serial/mpc52xx_uart.c                  |    3 +
 include/linux/of.h                             |    8 +++
 include/linux/of_device.h                      |    2 -
 10 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index caae49f..3b70844 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -41,6 +41,7 @@
 #include <linux/kobject.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <asm/ibmebus.h>
 #include <asm/abs_addr.h>
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index de36e23..7a3cafb 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -19,6 +19,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 
diff --git a/arch/powerpc/platforms/celleb/io-workarounds.c b/arch/powerpc/platforms/celleb/io-workarounds.c
index b939c0e..423339b 100644
--- a/arch/powerpc/platforms/celleb/io-workarounds.c
+++ b/arch/powerpc/platforms/celleb/io-workarounds.c
@@ -22,6 +22,7 @@
 
 #undef DEBUG
 
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/irq.h>
 
diff --git a/arch/powerpc/platforms/celleb/pci.c b/arch/powerpc/platforms/celleb/pci.c
index 5d399e0..51b390d 100644
--- a/arch/powerpc/platforms/celleb/pci.c
+++ b/arch/powerpc/platforms/celleb/pci.c
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/pci_regs.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 
 #include <asm/io.h>
diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index cb06280..fced441 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -37,6 +37,7 @@
 #include <linux/mii.h>
 #include <linux/bitops.h>
 #include <linux/workqueue.h>
+#include <linux/of.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9377f3b..b306fef 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -273,3 +273,61 @@ struct device_node *of_find_compatible_node(struct device_node *from,
 	return np;
 }
 EXPORT_SYMBOL(of_find_compatible_node);
+
+/**
+ * of_match_node - Tell if an device_node has a matching of_match structure
+ *	@matches:	array of of device match structures to search in
+ *	@node:		the of device structure to match against
+ *
+ *	Low level utility function used by device matching.
+ */
+const struct of_device_id *of_match_node(const struct of_device_id *matches,
+					 const struct device_node *node)
+{
+	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
+		int match = 1;
+		if (matches->name[0])
+			match &= node->name
+				&& !strcmp(matches->name, node->name);
+		if (matches->type[0])
+			match &= node->type
+				&& !strcmp(matches->type, node->type);
+		if (matches->compatible[0])
+			match &= of_device_is_compatible(node,
+						matches->compatible);
+		if (match)
+			return matches;
+		matches++;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(of_match_node);
+
+/**
+ *	of_find_matching_node - Find a node based on an of_device_id match
+ *				table.
+ *	@from:		The node to start searching from or NULL, the node
+ *			you pass will not be searched, only the next one
+ *			will; typically, you pass what the previous call
+ *			returned. of_node_put() will be called on it
+ *	@matches:	array of of device match structures to search in
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *of_find_matching_node(struct device_node *from,
+					  const struct of_device_id *matches)
+{
+	struct device_node *np;
+
+	read_lock(&devtree_lock);
+	np = from ? from->allnext : allnodes;
+	for (; np; np = np->allnext) {
+		if (of_match_node(matches, np) && of_node_get(np))
+			break;
+	}
+	of_node_put(from);
+	read_unlock(&devtree_lock);
+	return np;
+}
+EXPORT_SYMBOL(of_find_matching_node);
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 6245f06..29681c4 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -10,35 +10,6 @@
 #include <asm/errno.h>
 
 /**
- * of_match_node - Tell if an device_node has a matching of_match structure
- * @ids: array of of device match structures to search in
- * @node: the of device structure to match against
- *
- * Low level utility function used by device matching.
- */
-const struct of_device_id *of_match_node(const struct of_device_id *matches,
-					 const struct device_node *node)
-{
-	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
-		int match = 1;
-		if (matches->name[0])
-			match &= node->name
-				&& !strcmp(matches->name, node->name);
-		if (matches->type[0])
-			match &= node->type
-				&& !strcmp(matches->type, node->type);
-		if (matches->compatible[0])
-			match &= of_device_is_compatible(node,
-						matches->compatible);
-		if (match)
-			return matches;
-		matches++;
-	}
-	return NULL;
-}
-EXPORT_SYMBOL(of_match_node);
-
-/**
  * of_match_device - Tell if an of_device structure has a matching
  * of_match structure
  * @ids: array of of device match structures to search in
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index ec36ad7..7e3ba8b 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -72,7 +72,8 @@
 #include <asm/io.h>
 
 #if defined(CONFIG_PPC_MERGE)
-#include <asm/of_platform.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #else
 #include <linux/platform_device.h>
 #endif
diff --git a/include/linux/of.h b/include/linux/of.h
index c65af7b..b5f33ef 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -17,6 +17,7 @@
  */
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/mod_devicetable.h>
 
 #include <asm/prom.h>
 
@@ -41,6 +42,11 @@ extern struct device_node *of_find_compatible_node(struct device_node *from,
 #define for_each_compatible_node(dn, type, compatible) \
 	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
 	     dn = of_find_compatible_node(dn, type, compatible))
+extern struct device_node *of_find_matching_node(struct device_node *from,
+	const struct of_device_id *matches);
+#define for_each_matching_node(dn, matches) \
+	for (dn = of_find_matching_node(NULL, matches); dn; \
+	     dn = of_find_matching_node(dn, matches))
 extern struct device_node *of_find_node_by_path(const char *path);
 extern struct device_node *of_find_node_by_phandle(phandle handle);
 extern struct device_node *of_get_parent(const struct device_node *node);
@@ -60,5 +66,7 @@ extern const void *of_get_property(const struct device_node *node,
 				int *lenp);
 extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
+extern const struct of_device_id *of_match_node(
+	const struct of_device_id *matches, const struct device_node *node);
 
 #endif /* _LINUX_OF_H */
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 212bffb..6dc1195 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -10,8 +10,6 @@
 
 #define	to_of_device(d) container_of(d, struct of_device, dev)
 
-extern const struct of_device_id *of_match_node(
-	const struct of_device_id *matches, const struct device_node *node);
 extern const struct of_device_id *of_match_device(
 	const struct of_device_id *matches, const struct of_device *dev);
 
