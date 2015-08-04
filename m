Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 3D26A1A076F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 00:36:57 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/5] powerpc/pseries: extract of_helpers module
Date: Tue,  4 Aug 2015 17:36:45 +0300
Message-Id: <1438699009-112794-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Extract a new module to share the code between other modules.

There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/platforms/pseries/Makefile     |  1 +
 arch/powerpc/platforms/pseries/of_helpers.c | 38 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/of_helpers.h |  8 ++++++
 arch/powerpc/platforms/pseries/reconfig.c   | 34 ++------------------------
 4 files changed, 49 insertions(+), 32 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/of_helpers.c
 create mode 100644 arch/powerpc/platforms/pseries/of_helpers.h

diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 0348079..2e857c2 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -2,6 +2,7 @@ ccflags-$(CONFIG_PPC64)			:= $(NO_MINIMAL_TOC)
 ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG
 
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
+			   of_helpers.o \
 			   setup.o iommu.o event_sources.o ras.o \
 			   firmware.o power.o dlpar.o mobility.o rng.o
 obj-$(CONFIG_SMP)	+= smp.o
diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
new file mode 100644
index 0000000..1cbd896
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -0,0 +1,38 @@
+#include <linux/string.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+
+#include "of_helpers.h"
+
+/**
+ * pseries_of_derive_parent - basically like dirname(1)
+ * @path:  the full_name of a node to be added to the tree
+ *
+ * Returns the node which should be the parent of the node
+ * described by path.  E.g., for path = "/foo/bar", returns
+ * the node with full_name = "/foo".
+ */
+struct device_node *pseries_of_derive_parent(const char *path)
+{
+	struct device_node *parent = NULL;
+	char *parent_path = "/";
+	size_t parent_path_len = strrchr(path, '/') - path + 1;
+
+	/* reject if path is "/" */
+	if (!strcmp(path, "/"))
+		return ERR_PTR(-EINVAL);
+
+	if (strrchr(path, '/') != path) {
+		parent_path = kmalloc(parent_path_len, GFP_KERNEL);
+		if (!parent_path)
+			return ERR_PTR(-ENOMEM);
+		strlcpy(parent_path, path, parent_path_len);
+	}
+	parent = of_find_node_by_path(parent_path);
+	if (!parent)
+		return ERR_PTR(-EINVAL);
+	if (strcmp(parent_path, "/"))
+		kfree(parent_path);
+	return parent;
+}
diff --git a/arch/powerpc/platforms/pseries/of_helpers.h b/arch/powerpc/platforms/pseries/of_helpers.h
new file mode 100644
index 0000000..bb83d39
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/of_helpers.h
@@ -0,0 +1,8 @@
+#ifndef _PSERIES_OF_HELPERS_H
+#define _PSERIES_OF_HELPERS_H
+
+#include <linux/of.h>
+
+struct device_node *pseries_of_derive_parent(const char *path);
+
+#endif /* _PSERIES_OF_HELPERS_H */
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 0f31952..7c7fcc0 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -22,37 +22,7 @@
 #include <asm/uaccess.h>
 #include <asm/mmu.h>
 
-/**
- *	derive_parent - basically like dirname(1)
- *	@path:  the full_name of a node to be added to the tree
- *
- *	Returns the node which should be the parent of the node
- *	described by path.  E.g., for path = "/foo/bar", returns
- *	the node with full_name = "/foo".
- */
-static struct device_node *derive_parent(const char *path)
-{
-	struct device_node *parent = NULL;
-	char *parent_path = "/";
-	size_t parent_path_len = strrchr(path, '/') - path + 1;
-
-	/* reject if path is "/" */
-	if (!strcmp(path, "/"))
-		return ERR_PTR(-EINVAL);
-
-	if (strrchr(path, '/') != path) {
-		parent_path = kmalloc(parent_path_len, GFP_KERNEL);
-		if (!parent_path)
-			return ERR_PTR(-ENOMEM);
-		strlcpy(parent_path, path, parent_path_len);
-	}
-	parent = of_find_node_by_path(parent_path);
-	if (!parent)
-		return ERR_PTR(-EINVAL);
-	if (strcmp(parent_path, "/"))
-		kfree(parent_path);
-	return parent;
-}
+#include "of_helpers.h"
 
 static int pSeries_reconfig_add_node(const char *path, struct property *proplist)
 {
@@ -71,7 +41,7 @@ static int pSeries_reconfig_add_node(const char *path, struct property *proplist
 	of_node_set_flag(np, OF_DYNAMIC);
 	of_node_init(np);
 
-	np->parent = derive_parent(path);
+	np->parent = pseries_of_derive_parent(path);
 	if (IS_ERR(np->parent)) {
 		err = PTR_ERR(np->parent);
 		goto out_err;
-- 
2.4.6
