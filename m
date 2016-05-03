Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhvc44jnzDqmr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:33:32 +1000 (AEST)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 18:53:28 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E8F1A3940068
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:53:21 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DNRI027721824
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:27 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DNIZ3015524
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:21 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v9 19/22] drivers/of: Specify parent node in
 of_fdt_unflatten_tree()
Date: Tue,  3 May 2016 23:22:50 +1000
Message-Id: <1462281773-26438-20-git-send-email-gwshan@linux.vnet.ibm.com>
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

This adds one more argument to of_fdt_unflatten_tree() to specify
the parent node of the FDT blob that is going to be unflattened.
In the result, the function can be used to unflatten FDT blob that
represents device sub-tree in PowerNV PCI hotplug driver.

Cc: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c |  2 +-
 drivers/of/fdt.c                             | 14 ++++++++++----
 drivers/of/unittest.c                        |  2 +-
 include/linux/of_fdt.h                       |  1 +
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c b/drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c
index 106679b..f9c79da 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c
@@ -157,7 +157,7 @@ struct device_node * __init tilcdc_get_overlay(struct kfree_table *kft)
 	if (!overlay_data || kfree_table_add(kft, overlay_data))
 		return NULL;
 
-	of_fdt_unflatten_tree(overlay_data, &overlay);
+	of_fdt_unflatten_tree(overlay_data, NULL, &overlay);
 	if (!overlay) {
 		pr_warn("%s: Unfattening overlay tree failed\n", __func__);
 		return NULL;
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7850150..337fb1a 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -450,11 +450,13 @@ static int unflatten_dt_nodes(const void *blob,
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
@@ -479,7 +481,7 @@ static void __unflatten_device_tree(const void *blob,
 	}
 
 	/* First pass, scan for size */
-	size = unflatten_dt_nodes(blob, NULL, NULL, NULL);
+	size = unflatten_dt_nodes(blob, NULL, dad, NULL);
 	if (size < 0)
 		return;
 
@@ -495,7 +497,7 @@ static void __unflatten_device_tree(const void *blob,
 	pr_debug("  unflattening %p...\n", mem);
 
 	/* Second pass, do actual unflattening */
-	unflatten_dt_nodes(blob, mem, NULL, mynodes);
+	unflatten_dt_nodes(blob, mem, dad, mynodes);
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
 		pr_warning("End of tree marker overwritten: %08x\n",
 			   be32_to_cpup(mem + size));
@@ -512,6 +514,9 @@ static DEFINE_MUTEX(of_fdt_unflatten_mutex);
 
 /**
  * of_fdt_unflatten_tree - create tree of device_nodes from flat blob
+ * @blob: Flat device tree blob
+ * @dad: Parent device node
+ * @mynodes: The device tree created by the call
  *
  * unflattens the device-tree passed by the firmware, creating the
  * tree of struct device_node. It also fills the "name" and "type"
@@ -519,10 +524,11 @@ static DEFINE_MUTEX(of_fdt_unflatten_mutex);
  * can be used.
  */
 void of_fdt_unflatten_tree(const unsigned long *blob,
+			struct device_node *dad,
 			struct device_node **mynodes)
 {
 	mutex_lock(&of_fdt_unflatten_mutex);
-	__unflatten_device_tree(blob, mynodes, &kernel_tree_alloc);
+	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
 	mutex_unlock(&of_fdt_unflatten_mutex);
 }
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
@@ -1189,7 +1195,7 @@ bool __init early_init_dt_scan(void *params)
  */
 void __init unflatten_device_tree(void)
 {
-	__unflatten_device_tree(initial_boot_params, &of_root,
+	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
 				early_init_dt_alloc_memory_arch);
 
 	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e986e6e..8c0f11c 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -921,7 +921,7 @@ static int __init unittest_data_add(void)
 			"not running tests\n", __func__);
 		return -ENOMEM;
 	}
-	of_fdt_unflatten_tree(unittest_data, &unittest_data_node);
+	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
 	if (!unittest_data_node) {
 		pr_warn("%s: No tree to attach; not running tests\n", __func__);
 		return -ENODATA;
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 2fbe868..1bffcbd 100644
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
