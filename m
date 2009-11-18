Return-Path: <nfont@austin.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 745791007D1
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 13:55:27 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAI2sDHY027714
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:54:13 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAI2tKqP150894
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:55:20 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAI2tKRU019213
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:55:20 -0700
Message-ID: <4B03620C.2060105@austin.ibm.com>
Date: Tue, 17 Nov 2009 20:55:08 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH 2/4] Merge of_detach_node
References: <4B030FC2.9070401@austin.ibm.com>
In-Reply-To: <4B030FC2.9070401@austin.ibm.com>
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

Index: test-devicetree/arch/microblaze/kernel/prom.c
===================================================================
--- test-devicetree.orig/arch/microblaze/kernel/prom.c	2009-11-17 14:17:05.000000000 -0600
+++ test-devicetree/arch/microblaze/kernel/prom.c	2009-11-17 14:18:18.000000000 -0600
@@ -957,50 +957,6 @@
 EXPORT_SYMBOL(of_node_put);
 
 /*
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
-/*
  * Add a property to a node
  */
 int prom_add_property(struct device_node *np, struct property *prop)
Index: test-devicetree/arch/powerpc/kernel/prom.c
===================================================================
--- test-devicetree.orig/arch/powerpc/kernel/prom.c	2009-11-17 14:17:05.000000000 -0600
+++ test-devicetree/arch/powerpc/kernel/prom.c	2009-11-17 14:18:18.000000000 -0600
@@ -1412,50 +1412,6 @@
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
--- test-devicetree.orig/drivers/of/of_dynamic.c	2009-11-17 14:18:11.000000000 -0600
+++ test-devicetree/drivers/of/of_dynamic.c	2009-11-17 14:18:18.000000000 -0600
@@ -34,3 +34,46 @@
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
