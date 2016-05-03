Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhvy42mfzDr7K
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:33:50 +1000 (AEST)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 18:53:28 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C1D5F125804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:55:24 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DNQFO42336384
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:26 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DNH5I015515
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:20 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 20/22] drivers/of: Return allocated memory from
 of_fdt_unflatten_tree()
Date: Tue,  3 May 2016 23:22:51 +1000
Message-Id: <1462281773-26438-21-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
index 337fb1a..c95054c 100644
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
index 1bffcbd..901ec01 100644
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
