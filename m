Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F3961A0C1D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:57 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:13:56 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 247162BB0062
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:54 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDVdS34144306
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:39 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDKtL030412
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:21 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 47/50] drivers/of: Specify parent node in
 of_fdt_unflatten_tree()
Date: Thu,  5 Nov 2015 00:12:47 +1100
Message-Id: <1446642770-4681-48-git-send-email-gwshan@linux.vnet.ibm.com>
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

This adds one more argument to of_fdt_unflatten_tree() to specify
the parent node of the FDT blob that is going to be unflattened.
In the result, the function can be used to unflatten FDT blob that
represents device sub-tree in PowerNV PCI hotplug driver.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/fdt.c       | 14 ++++++++++----
 drivers/of/unittest.c  |  2 +-
 include/linux/of_fdt.h |  1 +
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 559ce49..8c8228e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -443,11 +443,13 @@ static void *unflatten_dt_nodes(const void *blob,
  * pointers of the nodes so the normal device-tree walking functions
  * can be used.
  * @blob: The blob to expand
+ * @dad: Parent device node
  * @mynodes: The device_node tree created by the call
  * @dt_alloc: An allocator that provides a virtual address to memory
  * for the resulting tree
  */
 static void __unflatten_device_tree(const void *blob,
+			     struct device_node *dad,
 			     struct device_node **mynodes,
 			     void * (*dt_alloc)(u64 size, u64 align))
 {
@@ -472,7 +474,7 @@ static void __unflatten_device_tree(const void *blob,
 	}
 
 	/* First pass, scan for size */
-	size = (unsigned long)unflatten_dt_nodes(blob, NULL, NULL, NULL, true);
+	size = (unsigned long)unflatten_dt_nodes(blob, NULL, dad, NULL, true);
 	size = ALIGN(size, 4);
 
 	pr_debug("  size is %lx, allocating...\n", size);
@@ -486,7 +488,7 @@ static void __unflatten_device_tree(const void *blob,
 	pr_debug("  unflattening %p...\n", mem);
 
 	/* Second pass, do actual unflattening */
-	unflatten_dt_nodes(blob, mem, NULL, mynodes, false);
+	unflatten_dt_nodes(blob, mem, dad, mynodes, false);
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
 		pr_warning("End of tree marker overwritten: %08x\n",
 			   be32_to_cpup(mem + size));
@@ -501,6 +503,9 @@ static void *kernel_tree_alloc(u64 size, u64 align)
 
 /**
  * of_fdt_unflatten_tree - create tree of device_nodes from flat blob
+ * @blob: Flat device tree blob
+ * @dad: Parent device node
+ * @mynodes: The device tree created by the call
  *
  * unflattens the device-tree passed by the firmware, creating the
  * tree of struct device_node. It also fills the "name" and "type"
@@ -508,9 +513,10 @@ static void *kernel_tree_alloc(u64 size, u64 align)
  * can be used.
  */
 void of_fdt_unflatten_tree(const unsigned long *blob,
+			struct device_node *dad,
 			struct device_node **mynodes)
 {
-	__unflatten_device_tree(blob, mynodes, &kernel_tree_alloc);
+	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
 }
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 
@@ -1163,7 +1169,7 @@ bool __init early_init_dt_scan(void *params)
  */
 void __init unflatten_device_tree(void)
 {
-	__unflatten_device_tree(initial_boot_params, &of_root,
+	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
 				early_init_dt_alloc_memory_arch);
 
 	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 9f71770b6..bafcf66 100644
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
index df9ef38..3644960 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -38,6 +38,7 @@ extern bool of_fdt_is_big_endian(const void *blob,
 extern int of_fdt_match(const void *blob, unsigned long node,
 			const char *const *compat);
 extern void of_fdt_unflatten_tree(const unsigned long *blob,
+			       struct device_node *dad,
 			       struct device_node **mynodes);
 
 /* TBD: Temporary export of fdt globals - remove when code fully merged */
-- 
2.1.0
