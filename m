Return-Path: <nfont@austin.ibm.com>
Message-ID: <4B06B091.3030506@austin.ibm.com>
Date: Fri, 20 Nov 2009 09:06:57 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH 2/4 v2] Merge of_detach_node
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

Merge the common of_detach_node() from powerpc and microblaze into the common
drivers/of/of_dynamic.c

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---
 arch/microblaze/include/asm/prom.h |    3 --
 arch/microblaze/kernel/prom.c      |   44 -------------------------------------
 arch/powerpc/include/asm/prom.h    |    3 --
 arch/powerpc/kernel/prom.c         |   44 -------------------------------------
 drivers/of/of_dynamic.c            |   43 ++++++++++++++++++++++++++++++++++++
 include/linux/of_dynamic.h         |    1 
 6 files changed, 44 insertions(+), 94 deletions(-)

Index: test-devicetree/arch/microblaze/kernel/prom.c
===================================================================
--- test-devicetree.orig/arch/microblaze/kernel/prom.c	2009-11-20 11:59:03.000000000 -0600
+++ test-devicetree/arch/microblaze/kernel/prom.c	2009-11-20 12:28:33.000000000 -0600
@@ -482,50 +482,6 @@
 }
 EXPORT_SYMBOL(of_node_put);
 
-/*
- * "Unplug" a node from the device tree.  The caller must hold
- * a reference to the node.  The memory associated with the node
- * is not freed until its refcount goes to zero.
- */
-void of_detach_node(struct device_node *np)
-{
-	struct device_node *parent;
-	unsigned long flags;
-
-	write_lock_irqsave(&devtree_lock, flags);
-
-	parent = np->parent;
-	if (!parent)
-		goto out_unlock;
-
-	if (allnodes == np)
-		allnodes = np->allnext;
-	else {
-		struct device_node *prev;
-		for (prev = allnodes;
-		     prev->allnext != np;
-		     prev = prev->allnext)
-			;
-		prev->allnext = np->allnext;
-	}
-
-	if (parent->child == np)
-		parent->child = np->sibling;
-	else {
-		struct device_node *prevsib;
-		for (prevsib = np->parent->child;
-		     prevsib->sibling != np;
-		     prevsib = prevsib->sibling)
-			;
-		prevsib->sibling = np->sibling;
-	}
-
-	of_node_set_flag(np, OF_DETACHED);
-
-out_unlock:
-	write_unlock_irqrestore(&devtree_lock, flags);
-}
-
 #if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
 static struct debugfs_blob_wrapper flat_dt_blob;
 
Index: test-devicetree/arch/powerpc/kernel/prom.c
===================================================================
--- test-devicetree.orig/arch/powerpc/kernel/prom.c	2009-11-20 11:59:03.000000000 -0600
+++ test-devicetree/arch/powerpc/kernel/prom.c	2009-11-20 12:28:33.000000000 -0600
@@ -935,50 +935,6 @@
 }
 EXPORT_SYMBOL(of_node_put);
 
-/*
- * "Unplug" a node from the device tree.  The caller must hold
- * a reference to the node.  The memory associated with the node
- * is not freed until its refcount goes to zero.
- */
-void of_detach_node(struct device_node *np)
-{
-	struct device_node *parent;
-	unsigned long flags;
-
-	write_lock_irqsave(&devtree_lock, flags);
-
-	parent = np->parent;
-	if (!parent)
-		goto out_unlock;
-
-	if (allnodes == np)
-		allnodes = np->allnext;
-	else {
-		struct device_node *prev;
-		for (prev = allnodes;
-		     prev->allnext != np;
-		     prev = prev->allnext)
-			;
-		prev->allnext = np->allnext;
-	}
-
-	if (parent->child == np)
-		parent->child = np->sibling;
-	else {
-		struct device_node *prevsib;
-		for (prevsib = np->parent->child;
-		     prevsib->sibling != np;
-		     prevsib = prevsib->sibling)
-			;
-		prevsib->sibling = np->sibling;
-	}
-
-	of_node_set_flag(np, OF_DETACHED);
-
-out_unlock:
-	write_unlock_irqrestore(&devtree_lock, flags);
-}
-
 #ifdef CONFIG_PPC_PSERIES
 /*
  * Fix up the uninitialized fields in a new device node:
Index: test-devicetree/drivers/of/of_dynamic.c
===================================================================
--- test-devicetree.orig/drivers/of/of_dynamic.c	2009-11-20 12:27:24.000000000 -0600
+++ test-devicetree/drivers/of/of_dynamic.c	2009-11-20 12:28:33.000000000 -0600
@@ -30,3 +30,46 @@
 	write_unlock_irqrestore(&devtree_lock, flags);
 }
 
+/*
+ * "Unplug" a node from the device tree.  The caller must hold
+ * a reference to the node.  The memory associated with the node
+ * is not freed until its refcount goes to zero.
+ */
+void of_detach_node(struct device_node *np)
+{
+	struct device_node *parent;
+	unsigned long flags;
+
+	write_lock_irqsave(&devtree_lock, flags);
+
+	parent = np->parent;
+	if (!parent)
+		goto out_unlock;
+
+	if (allnodes == np)
+		allnodes = np->allnext;
+	else {
+		struct device_node *prev;
+		for (prev = allnodes;
+		     prev->allnext != np;
+		     prev = prev->allnext)
+			;
+		prev->allnext = np->allnext;
+	}
+
+	if (parent->child == np)
+		parent->child = np->sibling;
+	else {
+		struct device_node *prevsib;
+		for (prevsib = np->parent->child;
+		     prevsib->sibling != np;
+		     prevsib = prevsib->sibling)
+			;
+		prevsib->sibling = np->sibling;
+	}
+
+	of_node_set_flag(np, OF_DETACHED);
+
+out_unlock:
+	write_unlock_irqrestore(&devtree_lock, flags);
+}
Index: test-devicetree/arch/microblaze/include/asm/prom.h
===================================================================
--- test-devicetree.orig/arch/microblaze/include/asm/prom.h	2009-11-20 12:24:47.000000000 -0600
+++ test-devicetree/arch/microblaze/include/asm/prom.h	2009-11-20 12:30:33.000000000 -0600
@@ -39,9 +39,6 @@
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-/* For updating the device tree at runtime */
-extern void of_detach_node(struct device_node *);
-
 /* Other Prototypes */
 extern int early_uartlite_console(void);
 
Index: test-devicetree/arch/powerpc/include/asm/prom.h
===================================================================
--- test-devicetree.orig/arch/powerpc/include/asm/prom.h	2009-11-20 12:24:07.000000000 -0600
+++ test-devicetree/arch/powerpc/include/asm/prom.h	2009-11-20 12:30:41.000000000 -0600
@@ -34,9 +34,6 @@
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
-/* For updating the device tree at runtime */
-extern void of_detach_node(struct device_node *);
-
 #ifdef CONFIG_PPC32
 /*
  * PCI <-> OF matching functions
Index: test-devicetree/include/linux/of_dynamic.h
===================================================================
--- test-devicetree.orig/include/linux/of_dynamic.h	2009-11-20 12:27:09.000000000 -0600
+++ test-devicetree/include/linux/of_dynamic.h	2009-11-20 12:30:22.000000000 -0600
@@ -23,4 +23,5 @@
 extern rwlock_t devtree_lock;
 
 extern void of_attach_node(struct device_node *);
+extern void of_detach_node(struct device_node *);
 #endif
