Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 904801A0CC7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:49 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:43:47 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2EFA0125806C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:43:44 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDQML4718952
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:26 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDOQ4032551
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:26 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 48/50] drivers/of: Return allocated memory from
 of_fdt_unflatten_tree()
Date: Thu,  5 Nov 2015 00:12:48 +1100
Message-Id: <1446642770-4681-49-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
 drivers/of/fdt.c       | 25 ++++++++++++++++---------
 include/linux/of_fdt.h |  6 +++---
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 8c8228e..b0a5708 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -447,11 +447,14 @@ static void *unflatten_dt_nodes(const void *blob,
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
 	unsigned long size;
 	void *mem;
@@ -460,7 +463,7 @@ static void __unflatten_device_tree(const void *blob,
 
 	if (!blob) {
 		pr_debug("No device tree pointer\n");
-		return;
+		return NULL;
 	}
 
 	pr_debug("Unflattening device tree:\n");
@@ -470,7 +473,7 @@ static void __unflatten_device_tree(const void *blob,
 
 	if (fdt_check_header(blob)) {
 		pr_err("Invalid device tree blob header\n");
-		return;
+		return NULL;
 	}
 
 	/* First pass, scan for size */
@@ -494,6 +497,7 @@ static void __unflatten_device_tree(const void *blob,
 			   be32_to_cpup(mem + size));
 
 	pr_debug(" <- unflatten_device_tree()\n");
+	return mem;
 }
 
 static void *kernel_tree_alloc(u64 size, u64 align)
@@ -511,10 +515,13 @@ static void *kernel_tree_alloc(u64 size, u64 align)
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
 	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
 }
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
