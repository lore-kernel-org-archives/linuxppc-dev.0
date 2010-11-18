Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (sg2ehsobe002.messaging.microsoft.com
	[207.46.51.76]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 562BAB7144
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 11:10:32 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: <grant.likely@secretlab.ca>, <dirk.brandewie@gmail.com>,
	<devicetree-discuss@lists.ozlabs.org>, <linuxppc-dev@lists.ozlabs.org>,
	<microblaze-uclinux@itee.uq.edu.au>
Subject: [PATCH 7/7] fdt.c: Refactor unflatten_device_tree and add
	fdt_unflatten_tree
Date: Thu, 18 Nov 2010 15:55:02 -0800
In-Reply-To: <1290124502-13125-7-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1290021345-4303-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-6-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-7-git-send-email-stephen.neuendorffer@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <8aead437-fb77-4e72-8b66-2b1626f6316d@SG2EHSMHS008.ehs.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

unflatten_device_tree has two dependencies on things that happen
during boot time.  Firstly, it references the initial device tree
directly. Secondly, it allocates memory using the early boot
allocator.  This patch factors out these dependencies and uses
the new __unflatten_device_tree function to implement a driver-visible
fdt_unflatten_tree function, which can be used to unflatten a
blob after boot time.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

--

V2: remove extra __va() call
	 make dt_alloc functions return void *.  This doesn't fix the general
    strangeness in this code that constantly casts back and forth between
    unsigned long and __be32 *
---
 drivers/of/fdt.c       |  149 +++++++++++++++++++++++++++++++----------------
 include/linux/of_fdt.h |    2 +
 2 files changed, 100 insertions(+), 51 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 236a8c9..e29dbe2 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -11,10 +11,12 @@
 
 #include <linux/kernel.h>
 #include <linux/initrd.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/slab.h>
 
 #ifdef CONFIG_PPC
 #include <asm/machdep.h>
@@ -312,6 +314,94 @@ unsigned long unflatten_dt_node(struct boot_param_header *blob,
 	return mem;
 }
 
+/**
+ * __unflatten_device_tree - create tree of device_nodes from flat blob
+ *
+ * unflattens a device-tree, creating the
+ * tree of struct device_node. It also fills the "name" and "type"
+ * pointers of the nodes so the normal device-tree walking functions
+ * can be used.
+ * @blob: The blob to expand
+ * @mynodes: The device_node tree created by the call
+ * @dt_alloc: An allocator that provides a virtual address to memory
+ * for the resulting tree
+ */
+void __unflatten_device_tree(struct boot_param_header *blob,
+			     struct device_node **mynodes,
+			     void * (*dt_alloc)(u64 size, u64 align))
+{
+	unsigned long start, mem, size;
+	struct device_node **allnextp = mynodes;
+
+	pr_debug(" -> unflatten_device_tree()\n");
+
+	if (!blob) {
+		pr_debug("No device tree pointer\n");
+		return;
+	}
+
+	pr_debug("Unflattening device tree:\n");
+	pr_debug("magic: %08x\n", be32_to_cpu(blob->magic));
+	pr_debug("size: %08x\n", be32_to_cpu(blob->totalsize));
+	pr_debug("version: %08x\n", be32_to_cpu(blob->version));
+
+	if (be32_to_cpu(blob->magic) != OF_DT_HEADER) {
+		pr_err("Invalid device tree blob header\n");
+		return;
+	}
+
+	/* First pass, scan for size */
+	start = ((unsigned long)blob) +
+		be32_to_cpu(blob->off_dt_struct);
+	size = unflatten_dt_node(blob, 0, &start, NULL, NULL, 0);
+	size = (size | 3) + 1;
+
+	pr_debug("  size is %lx, allocating...\n", size);
+
+	/* Allocate memory for the expanded device tree */
+	mem = (unsigned long)
+		dt_alloc(size + 4, __alignof__(struct device_node));
+
+	((__be32 *)mem)[size / 4] = cpu_to_be32(0xdeadbeef);
+
+	pr_debug("  unflattening %lx...\n", mem);
+
+	/* Second pass, do actual unflattening */
+	start = ((unsigned long)blob) +
+		be32_to_cpu(blob->off_dt_struct);
+	unflatten_dt_node(blob, mem, &start, NULL, &allnextp, 0);
+	if (be32_to_cpup((__be32 *)start) != OF_DT_END)
+		pr_warning("Weird tag at end of tree: %08x\n", *((u32 *)start));
+	if (be32_to_cpu(((__be32 *)mem)[size / 4]) != 0xdeadbeef)
+		pr_warning("End of tree marker overwritten: %08x\n",
+			   be32_to_cpu(((__be32 *)mem)[size / 4]));
+	*allnextp = NULL;
+
+	pr_debug(" <- unflatten_device_tree()\n");
+}
+
+static void *kernel_tree_alloc(u64 size, u64 align)
+{
+	return kzalloc(size, GFP_KERNEL);
+}
+
+/**
+ * of_fdt_unflatten_tree - create tree of device_nodes from flat blob
+ *
+ * unflattens the device-tree passed by the firmware, creating the
+ * tree of struct device_node. It also fills the "name" and "type"
+ * pointers of the nodes so the normal device-tree walking functions
+ * can be used.
+ */
+void of_fdt_unflatten_tree(unsigned long *blob,
+			struct device_node **mynodes)
+{
+	struct boot_param_header *device_tree =
+		(struct boot_param_header *)blob;
+	__unflatten_device_tree(device_tree, mynodes, &kernel_tree_alloc);
+}
+EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
+
 /* Everything below here references initial_boot_params directly. */
 int __initdata dt_root_addr_cells;
 int __initdata dt_root_size_cells;
@@ -569,6 +659,12 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 	return 1;
 }
 
+static void *__init early_device_tree_alloc(u64 size, u64 align)
+{
+	unsigned long mem = early_init_dt_alloc_memory_arch(size, align);
+	return __va(mem);
+}
+
 /**
  * unflatten_device_tree - create tree of device_nodes from flat blob
  *
@@ -579,62 +675,13 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
  */
 void __init unflatten_device_tree(void)
 {
-	unsigned long start, mem, size;
-	struct device_node **allnextp = &allnodes;
-
-	pr_debug(" -> unflatten_device_tree()\n");
-
-	if (!initial_boot_params) {
-		pr_debug("No device tree pointer\n");
-		return;
-	}
-
-	pr_debug("Unflattening device tree:\n");
-	pr_debug("magic: %08x\n", be32_to_cpu(initial_boot_params->magic));
-	pr_debug("size: %08x\n", be32_to_cpu(initial_boot_params->totalsize));
-	pr_debug("version: %08x\n", be32_to_cpu(initial_boot_params->version));
-
-	if (be32_to_cpu(initial_boot_params->magic) != OF_DT_HEADER) {
-		pr_err("Invalid device tree blob header\n");
-		return;
-	}
-
-	/* First pass, scan for size */
-	start = ((unsigned long)initial_boot_params) +
-		be32_to_cpu(initial_boot_params->off_dt_struct);
-	size = unflatten_dt_node(initial_boot_params, 0, &start,
-				 NULL, NULL, 0);
-	size = (size | 3) + 1;
-
-	pr_debug("  size is %lx, allocating...\n", size);
-
-	/* Allocate memory for the expanded device tree */
-	mem = early_init_dt_alloc_memory_arch(size + 4,
-			__alignof__(struct device_node));
-	mem = (unsigned long) __va(mem);
-
-	((__be32 *)mem)[size / 4] = cpu_to_be32(0xdeadbeef);
-
-	pr_debug("  unflattening %lx...\n", mem);
-
-	/* Second pass, do actual unflattening */
-	start = ((unsigned long)initial_boot_params) +
-		be32_to_cpu(initial_boot_params->off_dt_struct);
-	unflatten_dt_node(initial_boot_params, mem, &start,
-			  NULL, &allnextp, 0);
-	if (be32_to_cpup((__be32 *)start) != OF_DT_END)
-		pr_warning("Weird tag at end of tree: %08x\n", *((u32 *)start));
-	if (be32_to_cpu(((__be32 *)mem)[size / 4]) != 0xdeadbeef)
-		pr_warning("End of tree marker overwritten: %08x\n",
-			   be32_to_cpu(((__be32 *)mem)[size / 4]));
-	*allnextp = NULL;
+	__unflatten_device_tree(initial_boot_params, &allnodes,
+				early_device_tree_alloc);
 
 	/* Get pointer to OF "/chosen" node for use everywhere */
 	of_chosen = of_find_node_by_path("/chosen");
 	if (of_chosen == NULL)
 		of_chosen = of_find_node_by_path("/chosen@0");
-
-	pr_debug(" <- unflatten_device_tree()\n");
 }
 
 #endif /* CONFIG_EARLY_FLATTREE */
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 70c5b73..9ce5dfd 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -68,6 +68,8 @@ extern void *of_fdt_get_property(struct boot_param_header *blob,
 extern int of_fdt_is_compatible(struct boot_param_header *blob,
 				unsigned long node,
 				const char *compat);
+extern void of_fdt_unflatten_tree(unsigned long *blob,
+			       struct device_node **mynodes);
 
 /* TBD: Temporary export of fdt globals - remove when code fully merged */
 extern int __initdata dt_root_addr_cells;
-- 
1.5.6.6



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
