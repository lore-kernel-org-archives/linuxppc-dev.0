Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyljY0R5hzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 22:37:37 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 79so1869573pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 05:37:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	devicetree@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/3] of/fdt: introduce of_scan_flat_dt_subnodes and
 of_get_flat_dt_phandle
Date: Wed,  5 Apr 2017 22:37:05 +1000
Message-Id: <20170405123706.6081-3-npiggin@gmail.com>
In-Reply-To: <20170405123706.6081-1-npiggin@gmail.com>
References: <20170405123706.6081-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce primitives for FDT parsing. These will be used for powerpc
cpufeatures node scanning, which has quite complex structure but should
be processed early.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/of/fdt.c       | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h |  6 ++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e5ce4b59e162..a45854fe5156 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -754,6 +754,37 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
 }
 
 /**
+ * of_scan_flat_dt_subnodes - scan sub-nodes of a node call callback on each.
+ * @it: callback function
+ * @data: context data pointer
+ *
+ * This function is used to scan sub-nodes of a node.
+ */
+int __init of_scan_flat_dt_subnodes(unsigned long node,
+				    int (*it)(unsigned long node,
+					      const char *uname,
+					      void *data),
+				    void *data)
+{
+	const void *blob = initial_boot_params;
+	const char *pathp;
+	int offset, rc = 0;
+
+	offset = node;
+        for (offset = fdt_first_subnode(blob, offset);
+             offset >= 0 && !rc;
+             offset = fdt_next_subnode(blob, offset)) {
+
+		pathp = fdt_get_name(blob, offset, NULL);
+		if (*pathp == '/')
+			pathp = kbasename(pathp);
+		rc = it(offset, pathp, data);
+	}
+	return rc;
+}
+
+
+/**
  * of_get_flat_dt_subnode_by_name - get the subnode by given name
  *
  * @node: the parent node
@@ -812,6 +843,14 @@ int __init of_flat_dt_match(unsigned long node, const char *const *compat)
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
2.11.0
