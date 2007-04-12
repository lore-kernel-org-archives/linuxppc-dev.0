Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 68CFCDDF30
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 15:34:14 +1000 (EST)
Date: Thu, 12 Apr 2007 15:34:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>, paulus@samba.org
Subject: [PATCH] Start split out of common open firmware code
Message-Id: <20070412153424.bf3957f4.sfr@canb.auug.org.au>
In-Reply-To: <20070412141905.6f30efd3.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This creates kernel/openfw.c (depending on CONFIG_OPENFW) and puts the
first trivially common bits from the prom.c files into it.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig       |    3 ++
 arch/powerpc/kernel/prom.c |   42 ----------------------------
 arch/sparc/Kconfig         |    3 ++
 arch/sparc/kernel/prom.c   |   42 ----------------------------
 arch/sparc64/Kconfig       |    3 ++
 arch/sparc64/kernel/prom.c |   42 ----------------------------
 include/asm-powerpc/prom.h |    3 ++
 include/asm-sparc/prom.h   |    3 ++
 include/asm-sparc64/prom.h |    3 ++
 kernel/Makefile            |    1 +
 kernel/openfw.c            |   65 ++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 84 insertions(+), 126 deletions(-)
 create mode 100644 kernel/openfw.c

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 20a8fdc..00fceed 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -99,6 +99,9 @@ config ARCH_MAY_HAVE_PC_FDC
 config PPC_OF
 	def_bool y
 
+config OPENFW
+	def_bool y
+
 config PPC_UDBG_16550
 	bool
 	default n
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index ec6921c..2971f1e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1042,36 +1042,6 @@ void __init early_init_devtree(void *params)
 
 #undef printk
 
-int of_n_addr_cells(struct device_node* np)
-{
-	const int *ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#address-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #address-cells property for the root node, default to 1 */
-	return 1;
-}
-EXPORT_SYMBOL(of_n_addr_cells);
-
-int of_n_size_cells(struct device_node* np)
-{
-	const int* ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#size-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #size-cells property for the root node, default to 1 */
-	return 1;
-}
-EXPORT_SYMBOL(of_n_size_cells);
-
 /**
  * Construct and return a list of the device_nodes with a given name.
  */
@@ -1622,18 +1592,6 @@ struct property *of_find_property(const struct device_node *np,
 EXPORT_SYMBOL(of_find_property);
 
 /*
- * Find a property with a given name for a given node
- * and return the value.
- */
-const void *of_get_property(const struct device_node *np, const char *name,
-			 int *lenp)
-{
-	struct property *pp = of_find_property(np,name,lenp);
-	return pp ? pp->value : NULL;
-}
-EXPORT_SYMBOL(of_get_property);
-
-/*
  * Add a property to a node
  */
 int prom_add_property(struct device_node* np, struct property* prop)
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index bd992c0..e8be7a1 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -21,6 +21,9 @@ config GENERIC_ISA_DMA
 	bool
 	default y
 
+config OPENFW
+	def_bool y
+
 source "init/Kconfig"
 
 menu "General machine setup"
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index eed140b..ac3f3c2 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -168,18 +168,6 @@ struct property *of_find_property(const struct device_node *np,
 }
 EXPORT_SYMBOL(of_find_property);
 
-/*
- * Find a property with a given name for a given node
- * and return the value.
- */
-const void *of_get_property(const struct device_node *np, const char *name,
-			    int *lenp)
-{
-	struct property *pp = of_find_property(np,name,lenp);
-	return pp ? pp->value : NULL;
-}
-EXPORT_SYMBOL(of_get_property);
-
 int of_getintprop_default(struct device_node *np, const char *name, int def)
 {
 	struct property *prop;
@@ -193,36 +181,6 @@ int of_getintprop_default(struct device_node *np, const char *name, int def)
 }
 EXPORT_SYMBOL(of_getintprop_default);
 
-int of_n_addr_cells(struct device_node *np)
-{
-	const int* ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#address-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #address-cells property for the root node, default to 2 */
-	return 2;
-}
-EXPORT_SYMBOL(of_n_addr_cells);
-
-int of_n_size_cells(struct device_node *np)
-{
-	const int* ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#size-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #size-cells property for the root node, default to 1 */
-	return 1;
-}
-EXPORT_SYMBOL(of_n_size_cells);
-
 int of_set_property(struct device_node *dp, const char *name, void *val, int len)
 {
 	struct property **prevp;
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 590a41b..1b52ab1 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -58,6 +58,9 @@ config AUDIT_ARCH
 	bool
 	default y
 
+config OPENFW
+	def_bool y
+
 choice
 	prompt "Kernel page size"
 	default SPARC64_PAGE_SIZE_8KB
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index 5e1fcd0..7ef5488 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -172,18 +172,6 @@ struct property *of_find_property(const struct device_node *np,
 }
 EXPORT_SYMBOL(of_find_property);
 
-/*
- * Find a property with a given name for a given node
- * and return the value.
- */
-const void *of_get_property(const struct device_node *np, const char *name,
-		      int *lenp)
-{
-	struct property *pp = of_find_property(np,name,lenp);
-	return pp ? pp->value : NULL;
-}
-EXPORT_SYMBOL(of_get_property);
-
 int of_getintprop_default(struct device_node *np, const char *name, int def)
 {
 	struct property *prop;
@@ -197,36 +185,6 @@ int of_getintprop_default(struct device_node *np, const char *name, int def)
 }
 EXPORT_SYMBOL(of_getintprop_default);
 
-int of_n_addr_cells(struct device_node *np)
-{
-	const int* ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#address-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #address-cells property for the root node, default to 2 */
-	return 2;
-}
-EXPORT_SYMBOL(of_n_addr_cells);
-
-int of_n_size_cells(struct device_node *np)
-{
-	const int* ip;
-	do {
-		if (np->parent)
-			np = np->parent;
-		ip = of_get_property(np, "#size-cells", NULL);
-		if (ip != NULL)
-			return *ip;
-	} while (np->parent);
-	/* No #size-cells property for the root node, default to 1 */
-	return 1;
-}
-EXPORT_SYMBOL(of_n_size_cells);
-
 int of_set_property(struct device_node *dp, const char *name, void *val, int len)
 {
 	struct property **prevp;
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index cc85c7f..4a9a479 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -21,6 +21,9 @@
 #include <asm/irq.h>
 #include <asm/atomic.h>
 
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	1
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
+
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
 #define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index 5188852..411018d 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -20,6 +20,9 @@
 #include <linux/proc_fs.h>
 #include <asm/atomic.h>
 
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
+
 typedef u32 phandle;
 typedef u32 ihandle;
 
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index b1557c0..1097e66 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -20,6 +20,9 @@
 #include <linux/proc_fs.h>
 #include <asm/atomic.h>
 
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
+
 typedef u32 phandle;
 typedef u32 ihandle;
 
diff --git a/kernel/Makefile b/kernel/Makefile
index ac6b27a..7fd57ed 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
 obj-$(CONFIG_UTS_NS) += utsname.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o tsacct.o
+obj-$(CONFIG_OPENFW) += openfw.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff --git a/kernel/openfw.c b/kernel/openfw.c
new file mode 100644
index 0000000..04a8cc2
--- /dev/null
+++ b/kernel/openfw.c
@@ -0,0 +1,65 @@
+/*
+ * Procedures for creating, accessing and interpreting the device tree.
+ *
+ * Paul Mackerras	August 1996.
+ * Copyright (C) 1996-2005 Paul Mackerras.
+ *
+ *  Adapted for 64bit PowerPC by Dave Engebretsen and Peter Bergner.
+ *    {engebret|bergner}@us.ibm.com
+ *
+ *  Adapted for sparc and sparc64 by David S. Miller davem@davemloft.net
+ *
+ *  Reconsolidated from arch/x/kernel/prom.c by Stephen Rothwell.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+#include <linux/module.h>
+#include <linux/openfw.h>
+
+int of_n_addr_cells(struct device_node *np)
+{
+	const int *ip;
+
+	do {
+		if (np->parent)
+			np = np->parent;
+		ip = of_get_property(np, "#address-cells", NULL);
+		if (ip)
+			return *ip;
+	} while (np->parent);
+	/* No #address-cells property for the root node */
+	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
+}
+EXPORT_SYMBOL(of_n_addr_cells);
+
+int of_n_size_cells(struct device_node *np)
+{
+	const int *ip;
+
+	do {
+		if (np->parent)
+			np = np->parent;
+		ip = of_get_property(np, "#size-cells", NULL);
+		if (ip)
+			return *ip;
+	} while (np->parent);
+	/* No #size-cells property for the root node */
+	return OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
+}
+EXPORT_SYMBOL(of_n_size_cells);
+
+/*
+ * Find a property with a given name for a given node
+ * and return the value.
+ */
+const void *of_get_property(const struct device_node *np, const char *name,
+			 int *lenp)
+{
+	struct property *pp = of_find_property(np, name, lenp);
+
+	return pp ? pp->value : NULL;
+}
+EXPORT_SYMBOL(of_get_property);
-- 
1.5.1
