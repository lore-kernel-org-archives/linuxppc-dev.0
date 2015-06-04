Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA0571A0E5C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:55 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:44:54 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 33D772BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:51 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hSth38142040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546h2rV005595
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 40/42] drivers/of: Allow to specify root node in
 of_fdt_unflatten_tree()
Date: Thu,  4 Jun 2015 16:42:09 +1000
Message-Id: <1433400131-18429-41-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces one more argument to of_fdt_unflatten_tree()
to specify the root node for the FDT blob, which is going to be
unflattened. In the result, the function can be used to unflatten
FDT blob, which represents device sub-tree in subsequent patches.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Newly introduced
---
 drivers/of/fdt.c       | 26 ++++++++++++++++++--------
 drivers/of/unittest.c  |  2 +-
 include/linux/of_fdt.h |  3 ++-
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index b87c157..b6a6c59 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -380,9 +380,16 @@ static void *unflatten_dt_node(void *blob,
 			       struct device_node **nodepp,
 			       bool dryrun)
 {
+	unsigned long fpsize = 0;
+
+	if (dad)
+		fpsize = strlen(of_node_full_name(dad));
+	else
+		fpsize = 0;
+
 	cur_node_depth = 1;
 	return __unflatten_dt_node(blob, mem, poffset,
-				   dad, nodepp, 0, dryrun);
+				   dad, nodepp, fpsize, dryrun);
 }
 
 /**
@@ -393,13 +400,15 @@ static void *unflatten_dt_node(void *blob,
  * pointers of the nodes so the normal device-tree walking functions
  * can be used.
  * @blob: The blob to expand
+ * @dad: The root node of the created device_node tree
  * @mynodes: The device_node tree created by the call
  * @dt_alloc: An allocator that provides a virtual address to memory
  * for the resulting tree
  */
 static void __unflatten_device_tree(void *blob,
-			     struct device_node **mynodes,
-			     void * (*dt_alloc)(u64 size, u64 align))
+				    struct device_node *dad,
+				    struct device_node **mynodes,
+				    void * (*dt_alloc)(u64 size, u64 align))
 {
 	unsigned long size;
 	int start;
@@ -425,7 +434,7 @@ static void __unflatten_device_tree(void *blob,
 	/* First pass, scan for size */
 	start = 0;
 	size = (unsigned long)unflatten_dt_node(blob, NULL, &start,
-						NULL, NULL, true);
+						dad, NULL, true);
 	size = ALIGN(size, 4);
 
 	pr_debug("  size is %lx, allocating...\n", size);
@@ -440,7 +449,7 @@ static void __unflatten_device_tree(void *blob,
 
 	/* Second pass, do actual unflattening */
 	start = 0;
-	unflatten_dt_node(blob, mem, &start, NULL, mynodes, false);
+	unflatten_dt_node(blob, mem, &start, dad, mynodes, false);
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
 		pr_warning("End of tree marker overwritten: %08x\n",
 			   be32_to_cpup(mem + size));
@@ -462,9 +471,10 @@ static void *kernel_tree_alloc(u64 size, u64 align)
  * can be used.
  */
 void of_fdt_unflatten_tree(unsigned long *blob,
-			struct device_node **mynodes)
+			   struct device_node *dad,
+			   struct device_node **mynodes)
 {
-	__unflatten_device_tree(blob, mynodes, &kernel_tree_alloc);
+	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
 }
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 
@@ -1095,7 +1105,7 @@ bool __init early_init_dt_scan(void *params)
  */
 void __init unflatten_device_tree(void)
 {
-	__unflatten_device_tree(initial_boot_params, &of_root,
+	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
 				early_init_dt_alloc_memory_arch);
 
 	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 1801634..2270830 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -907,7 +907,7 @@ static int __init unittest_data_add(void)
 			"not running tests\n", __func__);
 		return -ENOMEM;
 	}
-	of_fdt_unflatten_tree(unittest_data, &unittest_data_node);
+	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
 	if (!unittest_data_node) {
 		pr_warn("%s: No tree to attach; not running tests\n", __func__);
 		return -ENODATA;
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 587ee50..8882640 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -38,7 +38,8 @@ extern bool of_fdt_is_big_endian(const void *blob,
 extern int of_fdt_match(const void *blob, unsigned long node,
 			const char *const *compat);
 extern void of_fdt_unflatten_tree(unsigned long *blob,
-			       struct device_node **mynodes);
+				  struct device_node *dad,
+				  struct device_node **mynodes);
 
 /* TBD: Temporary export of fdt globals - remove when code fully merged */
 extern int __initdata dt_root_addr_cells;
-- 
2.1.0
