Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0EFA1A0C7E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:32 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:43:30 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 918CA125805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:43:26 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDPrp55967788
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:25 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDNCm032497
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:24 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 46/50] drivers/of: Rename unflatten_dt_node()
Date: Thu,  5 Nov 2015 00:12:46 +1100
Message-Id: <1446642770-4681-47-git-send-email-gwshan@linux.vnet.ibm.com>
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

This renames unflatten_dt_node() to unflatten_dt_nodes() as it
populates multiple device nodes from FDT blob. No logical changes
introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/fdt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index f4793d0..559ce49 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -380,7 +380,7 @@ static void reverse_nodes(struct device_node *parent)
 }
 
 /**
- * unflatten_dt_node - Alloc and populate a device_node from the flat tree
+ * unflatten_dt_nodes - Alloc and populate device nodes from the flat tree
  * @blob: The parent device tree blob
  * @mem: Memory chunk to use for allocating device nodes and properties
  * @dad: Parent struct device_node
@@ -388,11 +388,11 @@ static void reverse_nodes(struct device_node *parent)
  * @dryrun: If true, do not allocate device nodes but still calculate needed
  * memory size
  */
-static void *unflatten_dt_node(const void *blob,
-			       void *mem,
-			       struct device_node *dad,
-			       struct device_node **nodepp,
-			       bool dryrun)
+static void *unflatten_dt_nodes(const void *blob,
+				void *mem,
+				struct device_node *dad,
+				struct device_node **nodepp,
+				bool dryrun)
 {
 	struct device_node *root;
 	int offset = 0, depth = 0;
@@ -472,7 +472,7 @@ static void __unflatten_device_tree(const void *blob,
 	}
 
 	/* First pass, scan for size */
-	size = (unsigned long)unflatten_dt_node(blob, NULL, NULL, NULL, true);
+	size = (unsigned long)unflatten_dt_nodes(blob, NULL, NULL, NULL, true);
 	size = ALIGN(size, 4);
 
 	pr_debug("  size is %lx, allocating...\n", size);
@@ -486,7 +486,7 @@ static void __unflatten_device_tree(const void *blob,
 	pr_debug("  unflattening %p...\n", mem);
 
 	/* Second pass, do actual unflattening */
-	unflatten_dt_node(blob, mem, NULL, mynodes, false);
+	unflatten_dt_nodes(blob, mem, NULL, mynodes, false);
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
 		pr_warning("End of tree marker overwritten: %08x\n",
 			   be32_to_cpup(mem + size));
-- 
2.1.0
