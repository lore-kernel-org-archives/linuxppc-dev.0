Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMgbT6p3LzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 23:44:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 1/3] of/fdt: introduce of_scan_flat_dt_subnodes and
 of_get_flat_dt_phandle
Date: Tue,  9 May 2017 23:44:30 +1000
Message-Id: <1494337472-23419-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Introduce primitives for FDT parsing. These will be used for powerpc
cpufeatures node scanning, which has quite complex structure but should
be processed early.

Cc: devicetree@vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/of/fdt.c       | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h |  6 ++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e5ce4b59e162..961ca97072a9 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -754,6 +754,36 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
 }
 
 /**
+ * of_scan_flat_dt_subnodes - scan sub-nodes of a node call callback on each.
+ * @it: callback function
+ * @data: context data pointer
+ *
+ * This function is used to scan sub-nodes of a node.
+ */
+int __init of_scan_flat_dt_subnodes(unsigned long parent,
+				    int (*it)(unsigned long node,
+					      const char *uname,
+					      void *data),
+				    void *data)
+{
+	const void *blob = initial_boot_params;
+	int node;
+
+	fdt_for_each_subnode(node, blob, parent) {
+		const char *pathp;
+		int rc;
+
+		pathp = fdt_get_name(blob, node, NULL);
+		if (*pathp == '/')
+			pathp = kbasename(pathp);
+		rc = it(node, pathp, data);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+/**
  * of_get_flat_dt_subnode_by_name - get the subnode by given name
  *
  * @node: the parent node
@@ -812,6 +842,14 @@ int __init of_flat_dt_match(unsigned long node, const char *const *compat)
 	return of_fdt_match(initial_boot_params, node, compat);
 }
 
+/**
+ * of_get_flat_dt_prop - Given a node in the flat blob, return the phandle
+ */
+uint32_t __init of_get_flat_dt_phandle(unsigned long node)
+{
+	return fdt_get_phandle(initial_boot_params, node);
+}
+
 struct fdt_scan_status {
 	const char *name;
 	int namelen;
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 271b3fdf0070..1dfbfd0d8040 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -54,6 +54,11 @@ extern char __dtb_end[];
 extern int of_scan_flat_dt(int (*it)(unsigned long node, const char *uname,
 				     int depth, void *data),
 			   void *data);
+extern int of_scan_flat_dt_subnodes(unsigned long node,
+				    int (*it)(unsigned long node,
+					      const char *uname,
+					      void *data),
+				    void *data);
 extern int of_get_flat_dt_subnode_by_name(unsigned long node,
 					  const char *uname);
 extern const void *of_get_flat_dt_prop(unsigned long node, const char *name,
@@ -62,6 +67,7 @@ extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern int of_flat_dt_match(unsigned long node, const char *const *matches);
 extern unsigned long of_get_flat_dt_root(void);
 extern int of_get_flat_dt_size(void);
+extern uint32_t of_get_flat_dt_phandle(unsigned long node);
 
 extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data);
-- 
2.7.4
