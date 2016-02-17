Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E5C71A0320
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:59 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 13:45:59 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4209E357805E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:56 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H3jmbq55246910
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:56 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H3jI4j013166
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:23 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 42/45] drivers/of: Rename unflatten_dt_node()
Date: Wed, 17 Feb 2016 14:44:25 +1100
Message-Id: <1455680668-23298-43-git-send-email-gwshan@linux.vnet.ibm.com>
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

This renames unflatten_dt_node() to unflatten_dt_nodes() as it
populates multiple device nodes from FDT blob. No logical changes
introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/fdt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 667a5b2..3fc9a30 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -381,7 +381,7 @@ static void reverse_nodes(struct device_node *parent)
 }
 
 /**
- * unflatten_dt_node - Alloc and populate a device_node from the flat tree
+ * unflatten_dt_nodes - Alloc and populate a device_node from the flat tree
  * @blob: The parent device tree blob
  * @mem: Memory chunk to use for allocating device nodes and properties
  * @dad: Parent struct device_node
@@ -389,10 +389,10 @@ static void reverse_nodes(struct device_node *parent)
  *
  * It returns the size of unflattened device tree or error code
  */
-static int unflatten_dt_node(const void *blob,
-			     void *mem,
-			     struct device_node *dad,
-			     struct device_node **nodepp)
+static int unflatten_dt_nodes(const void *blob,
+			      void *mem,
+			      struct device_node *dad,
+			      struct device_node **nodepp)
 {
 	struct device_node *root;
 	int offset = 0, depth = 0;
@@ -479,7 +479,7 @@ static void __unflatten_device_tree(const void *blob,
 	}
 
 	/* First pass, scan for size */
-	size = unflatten_dt_node(blob, NULL, NULL, NULL);
+	size = unflatten_dt_nodes(blob, NULL, NULL, NULL);
 	if (size < 0)
 		return;
 
@@ -495,7 +495,7 @@ static void __unflatten_device_tree(const void *blob,
 	pr_debug("  unflattening %p...\n", mem);
 
 	/* Second pass, do actual unflattening */
-	unflatten_dt_node(blob, mem, NULL, mynodes);
+	unflatten_dt_nodes(blob, mem, NULL, mynodes);
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
 		pr_warning("End of tree marker overwritten: %08x\n",
 			   be32_to_cpup(mem + size));
-- 
2.1.0
