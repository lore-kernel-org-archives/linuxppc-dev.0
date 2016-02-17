Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 076B91A0354
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:58 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 13:45:57 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CBD532BB0064
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:52 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H3jiPx655698
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:52 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H3jJua005689
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:20 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 44/45] drivers/of: Return allocated memory from
 of_fdt_unflatten_tree()
Date: Wed, 17 Feb 2016 14:44:27 +1100
Message-Id: <1455680668-23298-45-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This returns the allocate memory chunk, storing the unflattened device
tree, from of_fdt_unflatten_tree() so that memory chunk can be released
on demand in PowerNV PCI hotplug driver.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c       | 33 ++++++++++++++++++++++-----------
 include/linux/of_fdt.h |  6 +++---
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 16a1ba5..47ec278 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -454,11 +454,14 @@ static int unflatten_dt_nodes(const void *blob,
  * @mynodes: The device_node tree created by the call
  * @dt_alloc: An allocator that provides a virtual address to memory
  * for the resulting tree
+ *
+ * Returns NULL on failure or the memory chunk containing the unflattened
+ * device tree on success.
  */
-static void __unflatten_device_tree(const void *blob,
-			     struct device_node *dad,
-			     struct device_node **mynodes,
-			     void * (*dt_alloc)(u64 size, u64 align))
+static void *__unflatten_device_tree(const void *blob,
+				     struct device_node *dad,
+				     struct device_node **mynodes,
+				     void *(*dt_alloc)(u64 size, u64 align))
 {
 	int size;
 	void *mem;
@@ -467,7 +470,7 @@ static void __unflatten_device_tree(const void *blob,
 
 	if (!blob) {
 		pr_debug("No device tree pointer\n");
-		return;
+		return NULL;
 	}
 
 	pr_debug("Unflattening device tree:\n");
@@ -477,13 +480,13 @@ static void __unflatten_device_tree(const void *blob,
 
 	if (fdt_check_header(blob)) {
 		pr_err("Invalid device tree blob header\n");
-		return;
+		return NULL;
 	}
 
 	/* First pass, scan for size */
 	size = unflatten_dt_nodes(blob, NULL, dad, NULL);
 	if (size < 0)
-		return;
+		return NULL;
 
 	size = ALIGN(size, 4);
 	pr_debug("  size is %d, allocating...\n", size);
@@ -503,6 +506,7 @@ static void __unflatten_device_tree(const void *blob,
 			   be32_to_cpup(mem + size));
 
 	pr_debug(" <- unflatten_device_tree()\n");
+	return mem;
 }
 
 static void *kernel_tree_alloc(u64 size, u64 align)
@@ -522,14 +526,21 @@ static DEFINE_MUTEX(of_fdt_unflatten_mutex);
  * tree of struct device_node. It also fills the "name" and "type"
  * pointers of the nodes so the normal device-tree walking functions
  * can be used.
+ *
+ * Returns NULL on failure or the memory chunk containing the unflattened
+ * device tree on success.
  */
-void of_fdt_unflatten_tree(const unsigned long *blob,
-			struct device_node *dad,
-			struct device_node **mynodes)
+void *of_fdt_unflatten_tree(const unsigned long *blob,
+			    struct device_node *dad,
+			    struct device_node **mynodes)
 {
+	void *mem;
+
 	mutex_lock(&of_fdt_unflatten_mutex);
-	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
+	mem = __unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
 	mutex_unlock(&of_fdt_unflatten_mutex);
+
+	return mem;
 }
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 3644960..b87b26a7 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -37,9 +37,9 @@ extern bool of_fdt_is_big_endian(const void *blob,
 				 unsigned long node);
 extern int of_fdt_match(const void *blob, unsigned long node,
 			const char *const *compat);
-extern void of_fdt_unflatten_tree(const unsigned long *blob,
-			       struct device_node *dad,
-			       struct device_node **mynodes);
+extern void *of_fdt_unflatten_tree(const unsigned long *blob,
+				   struct device_node *dad,
+				   struct device_node **mynodes);
 
 /* TBD: Temporary export of fdt globals - remove when code fully merged */
 extern int __initdata dt_root_addr_cells;
-- 
2.1.0
