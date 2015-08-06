Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 776981A0655
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:15 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 86FE8357806C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764D3ot36700322
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:11 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764Cck0026511
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:39 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 40/42] drivers/of: Return allocated memory chunk from
 of_fdt_unflatten_tree()
Date: Thu,  6 Aug 2015 14:11:45 +1000
Message-Id: <1438834307-26960-41-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This changes of_fdt_unflatten_tree() so that it returns the allocated
memory chunk for unflattened device-tree, which can be released once
it's obsoleted.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/fdt.c       | 11 ++++++-----
 include/linux/of_fdt.h |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 074870a..8e1ba7e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -408,7 +408,7 @@ static void *unflatten_dt_node(const void *blob,
  * @dt_alloc: An allocator that provides a virtual address to memory
  * for the resulting tree
  */
-static void __unflatten_device_tree(const void *blob,
+static void *__unflatten_device_tree(const void *blob,
 			     struct device_node *dad,
 			     struct device_node **mynodes,
 			     void * (*dt_alloc)(u64 size, u64 align))
@@ -421,7 +421,7 @@ static void __unflatten_device_tree(const void *blob,
 
 	if (!blob) {
 		pr_debug("No device tree pointer\n");
-		return;
+		return NULL;
 	}
 
 	pr_debug("Unflattening device tree:\n");
@@ -431,7 +431,7 @@ static void __unflatten_device_tree(const void *blob,
 
 	if (fdt_check_header(blob)) {
 		pr_err("Invalid device tree blob header\n");
-		return;
+		return NULL;
 	}
 
 	/* First pass, scan for size */
@@ -458,6 +458,7 @@ static void __unflatten_device_tree(const void *blob,
 			   be32_to_cpup(mem + size));
 
 	pr_debug(" <- unflatten_device_tree()\n");
+	return mem;
 }
 
 static void *kernel_tree_alloc(u64 size, u64 align)
@@ -473,11 +474,11 @@ static void *kernel_tree_alloc(u64 size, u64 align)
  * pointers of the nodes so the normal device-tree walking functions
  * can be used.
  */
-void of_fdt_unflatten_tree(const unsigned long *blob,
+void *of_fdt_unflatten_tree(const unsigned long *blob,
 			struct device_node *dad,
 			struct device_node **mynodes)
 {
-	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
+	return __unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
 }
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 3644960..00db279 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -37,7 +37,7 @@ extern bool of_fdt_is_big_endian(const void *blob,
 				 unsigned long node);
 extern int of_fdt_match(const void *blob, unsigned long node,
 			const char *const *compat);
-extern void of_fdt_unflatten_tree(const unsigned long *blob,
+extern void *of_fdt_unflatten_tree(const unsigned long *blob,
 			       struct device_node *dad,
 			       struct device_node **mynodes);
 
-- 
2.1.0
