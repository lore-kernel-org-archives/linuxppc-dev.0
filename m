Return-Path: <nfont@austin.ibm.com>
Message-ID: <4B06B053.7080901@austin.ibm.com>
Date: Fri, 20 Nov 2009 09:05:55 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH 1/4 v2] Merge of_attach_node
References: <4B06AF33.1000400@austin.ibm.com>
In-Reply-To: <4B06AF33.1000400@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge the common of_attach_node() routine from powerpc and microblaze to
drivers/of/of_dynamic.c

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---
 arch/microblaze/include/asm/prom.h |    1 -
 arch/microblaze/kernel/prom.c      |   15 ---------------
 arch/powerpc/include/asm/prom.h    |    1 -
 arch/powerpc/kernel/prom.c         |   15 ---------------
 drivers/of/of_dynamic.c            |   32 ++++++++++++++++++++++++++++++++
 include/linux/of_dynamic.h         |   26 ++++++++++++++++++++++++++
 6 files changed, 58 insertions(+), 32 deletions(-)

Index: test-devicetree/arch/microblaze/kernel/prom.c
===================================================================
--- test-devicetree.orig/arch/microblaze/kernel/prom.c	2009-11-18 17:34:36.000000000 -0600
+++ test-devicetree/arch/microblaze/kernel/prom.c	2009-11-20 11:59:03.000000000 -0600
@@ -483,21 +483,6 @@
 EXPORT_SYMBOL(of_node_put);
 
 /*
- * Plug a device node into the tree and global list.
- */
-void of_attach_node(struct device_node *np)
-{
-	unsigned long flags;
-
-	write_lock_irqsave(&devtree_lock, flags);
-	np->sibling = np->parent->child;
-	np->allnext = allnodes;
-	np->parent->child = np;
-	allnodes = np;
-	write_unlock_irqrestore(&devtree_lock, flags);
-}
-
-/*
  * "Unplug" a node from the device tree.  The caller must hold
  * a reference to the node.  The memory associated with the node
  * is not freed until its refcount goes to zero.
Index: test-devicetree/arch/powerpc/kernel/prom.c
===================================================================
--- test-devicetree.orig/arch/powerpc/kernel/prom.c	2009-11-18 17:34:36.000000000 -0600
+++ test-devicetree/arch/powerpc/kernel/prom.c	2009-11-20 11:59:03.000000000 -0600
@@ -936,21 +936,6 @@
 EXPORT_SYMBOL(of_node_put);
 
 /*
- * Plug a device node into the tree and global list.
- */
-void of_attach_node(struct device_node *np)
-{
-	unsigned long flags;
-
-	write_lock_irqsave(&devtree_lock, flags);
-	np->sibling = np->parent->child;
-	np->allnext = allnodes;
-	np->parent->child = np;
-	allnodes = np;
-	write_unlock_irqrestore(&devtree_lock, flags);
-}
-
-/*
  * "Unplug" a node from the device tree.  The caller must hold
  * a reference to the node.  The memory associated with the node
  * is not freed until its refcount goes to zero.
Index: test-devicetree/drivers/of/of_dynamic.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ test-devicetree/drivers/of/of_dynamic.c	2009-11-20 12:27:24.000000000 -0600
@@ -0,0 +1,32 @@
+/*
+ * Procedures for dynamically updating the device tree.
+ *
+ * Paul Mackerras	August 1996.
+ * Copyright (C) 1996-2005 Paul Mackerras.
+ *
+ *  Adapted for 64bit PowerPC by Dave Engebretsen and Peter Bergner.
+ *    {engebret|bergner}@us.ibm.com
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/of_dynamic.h>
+
+/*
+ * Plug a device node into the tree and global list.
+ */
+void of_attach_node(struct device_node *np)
+{
+	unsigned long flags;
+
+	write_lock_irqsave(&devtree_lock, flags);
+	np->sibling = np->parent->child;
+	np->allnext = allnodes;
+	np->parent->child = np;
+	allnodes = np;
+	write_unlock_irqrestore(&devtree_lock, flags);
+}
+
Index: test-devicetree/include/linux/of_dynamic.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ test-devicetree/include/linux/of_dynamic.h	2009-11-20 12:27:09.000000000 -0600
@@ -0,0 +1,26 @@
+/*
+ * Definitions for dynamically updating the device tree.
+ *
+ * Paul Mackerras	August 1996.
+ * Copyright (C) 1996-2005 Paul Mackerras.
+ *
+ *  Adapted for 64bit PowerPC by Dave Engebretsen and Peter Bergner.
+ *    {engebret|bergner}@us.ibm.com
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_OF_DYNAMIC_H
+#define _LINUX_OF_DYNAMIC_H
+
+#include <linux/of.h>
+
+/* temporary while merging */
+extern struct device_node *allnodes;
+extern rwlock_t devtree_lock;
+
+extern void of_attach_node(struct device_node *);
+#endif
Index: test-devicetree/arch/microblaze/include/asm/prom.h
===================================================================
--- test-devicetree.orig/arch/microblaze/include/asm/prom.h	2009-11-20 11:59:00.000000000 -0600
+++ test-devicetree/arch/microblaze/include/asm/prom.h	2009-11-20 12:24:47.000000000 -0600
@@ -40,7 +40,6 @@
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
 /* For updating the device tree at runtime */
-extern void of_attach_node(struct device_node *);
 extern void of_detach_node(struct device_node *);
 
 /* Other Prototypes */
Index: test-devicetree/arch/powerpc/include/asm/prom.h
===================================================================
--- test-devicetree.orig/arch/powerpc/include/asm/prom.h	2009-11-20 11:59:00.000000000 -0600
+++ test-devicetree/arch/powerpc/include/asm/prom.h	2009-11-20 12:24:07.000000000 -0600
@@ -35,7 +35,6 @@
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
 /* For updating the device tree at runtime */
-extern void of_attach_node(struct device_node *);
 extern void of_detach_node(struct device_node *);
 
 #ifdef CONFIG_PPC32
