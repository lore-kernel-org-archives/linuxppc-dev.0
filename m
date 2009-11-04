Return-Path: <nfont@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BFFC5B7BA6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 09:16:49 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA4MEbdF022134
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 15:14:37 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nA4MGhZu204792
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 15:16:45 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nA4GDuK1006669
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 09:13:56 -0700
Message-ID: <4AF1FD46.9050101@austin.ibm.com>
Date: Wed, 04 Nov 2009 16:16:38 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [RFC PATCH 2/5] Merge dynamic OF code to of_dynamic.c
References: <4AF1FB29.50905@austin.ibm.com>
In-Reply-To: <4AF1FB29.50905@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Creation of the OF dynamic device tree update code in drivers/of.  This
merges the common device tree updating routines to add/remove nodes and
properties from powerpc and microblaze.  All of the new code is conditional
based on a new OF_DYNAMIC config option.

There are two updates to the code.  First, the routines to update properties
are re-named from prom_* to of_*.  This seems correct as the routines no longer
reside in prom.c files.  Second, the addition of a notifier chain for when
nodes are added removed from the device tree.  This is a feature that currently
exists in powerpc.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: linux-next/drivers/of/of_dynamic.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-next/drivers/of/of_dynamic.c	2009-11-04 14:45:11.000000000 -0600
@@ -0,0 +1,387 @@
+/*
+ * Definitions for talking to the Open Firmware PROM on
+ * Power Macintosh and other computers.
+ *
+ * Copyright (C) 1996-2005 Paul Mackerras.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/of.h>
+
+BLOCKING_NOTIFIER_HEAD(of_update_chain);
+
+/**
+ *	of_node_get - Increment refcount of a node
+ *	@node:	Node to inc refcount, NULL is supported to
+ *		simplify writing of callers
+ *
+ *	Returns node.
+ */
+struct device_node *of_node_get(struct device_node *node)
+{
+	if (node)
+		kref_get(&node->kref);
+	return node;
+}
+EXPORT_SYMBOL(of_node_get);
+
+static inline struct device_node *kref_to_device_node(struct kref *kref)
+{
+	return container_of(kref, struct device_node, kref);
+}
+
+/**
+ *	of_node_release - release a dynamically allocated node
+ *	@kref:  kref element of the node to be released
+ *
+ *	In of_node_put() this function is passed to kref_put()
+ *	as the destructor.
+ */
+static void of_node_release(struct kref *kref)
+{
+	struct device_node *node = kref_to_device_node(kref);
+	struct property *prop = node->properties;
+
+	/* We should never be releasing nodes that haven't been detached. */
+	if (!of_node_check_flag(node, OF_DETACHED)) {
+		printk(KERN_WARNING "Bad of_node_put() on %s\n",
+		       node->full_name);
+		dump_stack();
+		kref_init(&node->kref);
+		return;
+	}
+
+	if (!of_node_check_flag(node, OF_DYNAMIC))
+		return;
+
+	while (prop) {
+		struct property *next = prop->next;
+		kfree(prop->name);
+		kfree(prop->value);
+		kfree(prop);
+		prop = next;
+
+		if (!prop) {
+			prop = node->deadprops;
+			node->deadprops = NULL;
+		}
+	}
+	kfree(node->full_name);
+	kfree(node->data);
+	kfree(node);
+}
+
+/**
+ *	of_node_put - Decrement refcount of a node
+ *	@node:	Node to dec refcount, NULL is supported to
+ *		simplify writing of callers
+ *
+ */
+void of_node_put(struct device_node *node)
+{
+	if (node)
+		kref_put(&node->kref, of_node_release);
+}
+EXPORT_SYMBOL(of_node_put);
+
+static struct device_node *of_derive_parent(char *path)
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
+
+	parent = of_find_node_by_path(parent_path);
+	if (!parent)
+		return ERR_PTR(-EINVAL);
+
+	if (strcmp(parent_path, "/"))
+		kfree(parent_path);
+	return parent;
+}
+
+static int of_attach_one_node(struct device_node *np)
+{
+	struct proc_dir_entry *ent;
+	unsigned long flags;
+	int rc;
+
+	of_node_set_flag(np, OF_DYNAMIC);
+	kref_init(&np->kref);
+
+	np->parent = of_derive_parent(np->full_name);
+	if (IS_ERR(np->parent))
+		return PTR_ERR(np->parent);
+
+	rc = of_update_notifier_call(OF_ATTACH_NODE, np);
+	if (rc == NOTIFY_BAD) {
+		printk(KERN_ERR "Failed to add device node %s\n",
+		       np->full_name);
+		return -ENOMEM;  /* For now, safe to assume kmalloc failure */
+	}
+
+	write_lock_irqsave(&devtree_lock, flags);
+	np->sibling = np->parent->child;
+	np->allnext = allnodes;
+	np->parent->child = np;
+
+	allnodes = np;
+	write_unlock_irqrestore(&devtree_lock, flags);
+
+#ifdef CONFIG_PROC_DEVICETREE
+	ent = proc_mkdir(strrchr(np->full_name, '/') + 1, np->parent->pde);
+	if (ent)
+		proc_device_tree_add_node(np, ent);
+#endif
+
+	of_node_put(np->parent);
+	return 0;
+}
+
+int of_attach_node(struct device_node *np)
+{
+	struct device_node *child = np->child;
+	struct device_node *sibling = np->sibling;
+	int rc;
+
+	np->child = NULL;
+	np->sibling = NULL;
+	np->parent = NULL;
+
+	rc = of_attach_one_node(np);
+	if (rc)
+		return rc;
+
+	if (child) {
+		rc = of_attach_node(child);
+		if (rc)
+			return rc;
+	}
+
+	if (sibling)
+		rc = of_attach_node(sibling);
+
+	return rc;
+}
+EXPORT_SYMBOL(of_attach_node);
+
+/*
+ * "Unplug" a node from the device tree.  The caller must hold
+ * a reference to the node.  The memory associated with the node
+ * is not freed until its refcount goes to zero.
+ */
+static int of_detach_one_node(struct device_node *np)
+{
+	struct device_node *parent = np->parent;
+	struct property *prop = np->properties;
+	unsigned long flags;
+
+	if (!parent)
+		return -1;
+
+#ifdef CONFIG_PROC_DEVICETREE
+	while (prop) {
+		remove_proc_entry(prop->name, np->pde);
+		prop = prop->next;
+	}
+
+	if (np->pde)
+		remove_proc_entry(np->pde->name, parent->pde);
+#endif
+
+	of_update_notifier_call(OF_DETACH_NODE, np);
+
+	write_lock_irqsave(&devtree_lock, flags);
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
+	write_unlock_irqrestore(&devtree_lock, flags);
+	of_node_put(np);
+	return 0;
+}
+
+static int _of_detach_node(struct device_node *np)
+{
+	int rc;
+
+	if (np->child) {
+		rc = _of_detach_node(np->child);
+		if (rc)
+			return rc;
+	}
+
+	if (np->sibling) {
+		rc = _of_detach_node(np->sibling);
+		if (rc)
+			return rc;
+	}
+
+	rc = of_detach_one_node(np);
+	return rc;
+}
+
+int of_detach_node(struct device_node *np)
+{
+	int rc;
+
+	if (np->child) {
+		rc = _of_detach_node(np->child);
+		if (rc)
+			return rc;
+	}
+
+	rc = of_detach_one_node(np);
+	return rc;
+}
+EXPORT_SYMBOL(of_detach_node);
+
+/*
+ * Add a property to a node
+ */
+int of_property_attach(struct device_node *np, struct property* prop)
+{
+	struct property **next;
+	unsigned long flags;
+
+	prop->next = NULL;
+
+	write_lock_irqsave(&devtree_lock, flags);
+	next = &np->properties;
+	while (*next) {
+		if (strcmp(prop->name, (*next)->name) == 0) {
+			/* duplicate ! don't insert it */
+			write_unlock_irqrestore(&devtree_lock, flags);
+			return -1;
+		}
+		next = &(*next)->next;
+	}
+	*next = prop;
+	write_unlock_irqrestore(&devtree_lock, flags);
+
+#ifdef CONFIG_PROC_DEVICETREE
+	/* try to add to proc as well if it was initialized */
+	if (np->pde)
+		proc_device_tree_add_prop(np->pde, prop);
+#endif /* CONFIG_PROC_DEVICETREE */
+
+	return 0;
+}
+EXPORT_SYMBOL(of_property_attach);
+
+/*
+ * Remove a property from a node.  Note that we don't actually
+ * remove it, since we have given out who-knows-how-many pointers
+ * to the data using get-property.  Instead we just move the property
+ * to the "dead properties" list, so it won't be found any more.
+ */
+int of_property_detach(struct device_node *np, struct property *prop)
+{
+	struct property **next;
+	unsigned long flags;
+	int found = 0;
+
+	write_lock_irqsave(&devtree_lock, flags);
+	next = &np->properties;
+	while (*next) {
+		if (*next == prop) {
+			/* found the node */
+			*next = prop->next;
+			prop->next = np->deadprops;
+			np->deadprops = prop;
+			found = 1;
+			break;
+		}
+		next = &(*next)->next;
+	}
+	write_unlock_irqrestore(&devtree_lock, flags);
+
+	if (!found)
+		return -ENODEV;
+
+#ifdef CONFIG_PROC_DEVICETREE
+	/* try to remove the proc node as well */
+	if (np->pde)
+		proc_device_tree_remove_prop(np->pde, prop);
+#endif /* CONFIG_PROC_DEVICETREE */
+
+	return 0;
+}
+EXPORT_SYMBOL(of_property_detach);
+
+/*
+ * Update a property in a node.  Note that we don't actually
+ * remove it, since we have given out who-knows-how-many pointers
+ * to the data using get-property.  Instead we just move the property
+ * to the "dead properties" list, and add the new property to the
+ * property list
+ */
+int of_property_update(struct device_node *np, struct property *newprop,
+		       struct property *oldprop)
+{
+	struct property **next;
+	unsigned long flags;
+	int found = 0;
+
+	write_lock_irqsave(&devtree_lock, flags);
+	next = &np->properties;
+	while (*next) {
+		if (*next == oldprop) {
+			/* found the node */
+			newprop->next = oldprop->next;
+			*next = newprop;
+			oldprop->next = np->deadprops;
+			np->deadprops = oldprop;
+			found = 1;
+			break;
+		}
+		next = &(*next)->next;
+	}
+	write_unlock_irqrestore(&devtree_lock, flags);
+
+	if (!found)
+		return -ENODEV;
+
+#ifdef CONFIG_PROC_DEVICETREE
+	/* try to add to proc as well if it was initialized */
+	if (np->pde)
+		proc_device_tree_update_prop(np->pde, newprop, oldprop);
+#endif /* CONFIG_PROC_DEVICETREE */
+
+	return 0;
+}
+EXPORT_SYMBOL(of_property_update);
Index: linux-next/include/linux/of.h
===================================================================
--- linux-next.orig/include/linux/of.h	2009-11-03 11:18:08.000000000 -0600
+++ linux-next/include/linux/of.h	2009-11-03 13:42:38.000000000 -0600
@@ -20,6 +20,8 @@
 #include <linux/kref.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spinlock.h>
+#include <linux/proc_fs.h>
+#include <linux/notifier.h>
 
 typedef u32 phandle;
 typedef u32 ihandle;
@@ -191,4 +193,34 @@
 	const char *list_name, const char *cells_name, int index,
 	struct device_node **out_node, const void **out_args);
 
+#ifdef CONFIG_OF_DYNAMIC
+extern int of_attach_node(struct device_node *np);
+extern int of_detach_node(struct device_node *np);
+extern int of_property_attach(struct device_node *np, struct property *prop);
+extern int of_property_detach(struct device_node *np, struct property *prop);
+extern int of_property_update(struct device_node *np, struct property *newprop,
+			      struct property *oldprop);
+
+/* Dynamic Update Notifier Chain */
+extern struct blocking_notifier_head of_update_chain;
+
+#define OF_ATTACH_NODE		1
+#define OF_DETACH_NODE		2
+
+static inline int of_update_notifier_register(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&of_update_chain, nb);
+}
+
+static inline int of_update_notifier_unregister(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&of_update_chain, nb);
+}
+
+static inline int of_update_notifier_call(unsigned int value, void *data)
+{
+	return blocking_notifier_call_chain(&of_update_chain, value, data);
+}
+#endif /* CONFIG_OF_DYNAMIC */
+
 #endif /* _LINUX_OF_H */
Index: linux-next/drivers/of/Makefile
===================================================================
--- linux-next.orig/drivers/of/Makefile	2009-11-03 11:18:08.000000000 -0600
+++ linux-next/drivers/of/Makefile	2009-11-03 13:42:35.000000000 -0600
@@ -1,6 +1,7 @@
 obj-y = base.o
-obj-$(CONFIG_OF_DEVICE) += device.o platform.o
-obj-$(CONFIG_OF_GPIO)   += gpio.o
-obj-$(CONFIG_OF_I2C)	+= of_i2c.o
-obj-$(CONFIG_OF_SPI)	+= of_spi.o
-obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
+obj-$(CONFIG_OF_DEVICE)		+= device.o platform.o
+obj-$(CONFIG_OF_GPIO)		+= gpio.o
+obj-$(CONFIG_OF_I2C)		+= of_i2c.o
+obj-$(CONFIG_OF_SPI)		+= of_spi.o
+obj-$(CONFIG_OF_MDIO)		+= of_mdio.o
+obj-$(CONFIG_OF_DYNAMIC)	+= of_dynamic.o
