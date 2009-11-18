Return-Path: <nfont@austin.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A91171007D3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 13:53:58 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAI2qhID026475
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:52:43 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAI2rpH7157542
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:53:51 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAI2tVIR003535
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 19:55:31 -0700
Message-ID: <4B0361A9.20209@austin.ibm.com>
Date: Tue, 17 Nov 2009 20:53:29 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH 1/4] Merge of_attach_node
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

Merge the common of_attach_node() routine from powerpc and microblaze to
drivers/of/of_dynamic.c

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: test-devicetree/arch/microblaze/kernel/prom.c
===================================================================
--- test-devicetree.orig/arch/microblaze/kernel/prom.c	2009-11-17 13:52:45.000000000 -0600
+++ test-devicetree/arch/microblaze/kernel/prom.c	2009-11-17 14:17:05.000000000 -0600
@@ -957,21 +957,6 @@
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
--- test-devicetree.orig/arch/powerpc/kernel/prom.c	2009-11-17 13:52:45.000000000 -0600
+++ test-devicetree/arch/powerpc/kernel/prom.c	2009-11-17 14:17:05.000000000 -0600
@@ -1413,21 +1413,6 @@
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
+++ test-devicetree/drivers/of/of_dynamic.c	2009-11-17 14:18:11.000000000 -0600
@@ -0,0 +1,36 @@
+/*
+ * Procedures for creating, accessing and interpreting the device tree.
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
+#include <linux/of.h>
+
+/* temporary while merging */
+extern struct device_node *allnodes;
+extern rwlock_t devtree_lock;
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
