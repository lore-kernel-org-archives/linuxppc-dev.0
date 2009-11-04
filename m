Return-Path: <nfont@austin.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20D9AB7BA4
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 09:18:41 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA4MExmo014893
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 17:14:59 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA4MIdtr113336
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 17:18:39 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA4MIc5L021649
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 17:18:39 -0500
Message-ID: <4AF1FDBB.8060704@austin.ibm.com>
Date: Wed, 04 Nov 2009 16:18:35 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [RFC PATCH 3/5] powerpc and pseries updates for new OF dynamic code
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

Updates to powerpc generic and powerpc/pseries.  This patch removes the
dynamic device tree updating code from prom.c and deletes the no longer
neccessary pSeries_reconfig.h file,  all of the functionality is now in the
generic OF code.

The remaining changes deal with updating code for name changes with using
the OF code.

Signed-off-by: Nathan Fonteot <nfont@austin.ibm.com>
---

Index: linux-next/arch/powerpc/include/asm/pSeries_reconfig.h
===================================================================
--- linux-next.orig/arch/powerpc/include/asm/pSeries_reconfig.h	2009-11-04 14:42:17.000000000 -0600
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,29 +0,0 @@
-#ifndef _PPC64_PSERIES_RECONFIG_H
-#define _PPC64_PSERIES_RECONFIG_H
-#ifdef __KERNEL__
-
-#include <linux/notifier.h>
-
-/*
- * Use this API if your code needs to know about OF device nodes being
- * added or removed on pSeries systems.
- */
-
-#define PSERIES_RECONFIG_ADD		0x0001
-#define PSERIES_RECONFIG_REMOVE		0x0002
-#define PSERIES_DRCONF_MEM_ADD		0x0003
-#define PSERIES_DRCONF_MEM_REMOVE	0x0004
-
-#ifdef CONFIG_PPC_PSERIES
-extern int pSeries_reconfig_notifier_register(struct notifier_block *);
-extern void pSeries_reconfig_notifier_unregister(struct notifier_block *);
-#else /* !CONFIG_PPC_PSERIES */
-static inline int pSeries_reconfig_notifier_register(struct notifier_block *nb)
-{
-	return 0;
-}
-static inline void pSeries_reconfig_notifier_unregister(struct notifier_block *nb) { }
-#endif /* CONFIG_PPC_PSERIES */
-
-#endif /* __KERNEL__ */
-#endif /* _PPC64_PSERIES_RECONFIG_H */
Index: linux-next/arch/powerpc/kernel/prom.c
===================================================================
--- linux-next.orig/arch/powerpc/kernel/prom.c	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/kernel/prom.c	2009-11-04 14:45:43.000000000 -0600
@@ -50,7 +50,6 @@
 #include <asm/btext.h>
 #include <asm/sections.h>
 #include <asm/machdep.h>
-#include <asm/pSeries_reconfig.h>
 #include <asm/pci-bridge.h>
 #include <asm/phyp_dump.h>
 #include <asm/kexec.h>
@@ -1313,138 +1312,6 @@
 	return NULL;
 }
 
-/**
- *	of_node_get - Increment refcount of a node
- *	@node:	Node to inc refcount, NULL is supported to
- *		simplify writing of callers
- *
- *	Returns node.
- */
-struct device_node *of_node_get(struct device_node *node)
-{
-	if (node)
-		kref_get(&node->kref);
-	return node;
-}
-EXPORT_SYMBOL(of_node_get);
-
-static inline struct device_node * kref_to_device_node(struct kref *kref)
-{
-	return container_of(kref, struct device_node, kref);
-}
-
-/**
- *	of_node_release - release a dynamically allocated node
- *	@kref:  kref element of the node to be released
- *
- *	In of_node_put() this function is passed to kref_put()
- *	as the destructor.
- */
-static void of_node_release(struct kref *kref)
-{
-	struct device_node *node = kref_to_device_node(kref);
-	struct property *prop = node->properties;
-
-	/* We should never be releasing nodes that haven't been detached. */
-	if (!of_node_check_flag(node, OF_DETACHED)) {
-		printk("WARNING: Bad of_node_put() on %s\n", node->full_name);
-		dump_stack();
-		kref_init(&node->kref);
-		return;
-	}
-
-	if (!of_node_check_flag(node, OF_DYNAMIC))
-		return;
-
-	while (prop) {
-		struct property *next = prop->next;
-		kfree(prop->name);
-		kfree(prop->value);
-		kfree(prop);
-		prop = next;
-
-		if (!prop) {
-			prop = node->deadprops;
-			node->deadprops = NULL;
-		}
-	}
-	kfree(node->full_name);
-	kfree(node->data);
-	kfree(node);
-}
-
-/**
- *	of_node_put - Decrement refcount of a node
- *	@node:	Node to dec refcount, NULL is supported to
- *		simplify writing of callers
- *
- */
-void of_node_put(struct device_node *node)
-{
-	if (node)
-		kref_put(&node->kref, of_node_release);
-}
-EXPORT_SYMBOL(of_node_put);
-
-/*
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
@@ -1491,7 +1358,7 @@
 	int err;
 
 	switch (action) {
-	case PSERIES_RECONFIG_ADD:
+	case OF_ATTACH_NODE:
 		err = of_finish_dynamic_node(node);
 		if (err < 0) {
 			printk(KERN_ERR "finish_node returned %d\n", err);
@@ -1512,125 +1379,11 @@
 
 static int __init prom_reconfig_setup(void)
 {
-	return pSeries_reconfig_notifier_register(&prom_reconfig_nb);
+	return of_update_notifier_register(&prom_reconfig_nb);
 }
 __initcall(prom_reconfig_setup);
 #endif
 
-/*
- * Add a property to a node
- */
-int prom_add_property(struct device_node* np, struct property* prop)
-{
-	struct property **next;
-	unsigned long flags;
-
-	prop->next = NULL;	
-	write_lock_irqsave(&devtree_lock, flags);
-	next = &np->properties;
-	while (*next) {
-		if (strcmp(prop->name, (*next)->name) == 0) {
-			/* duplicate ! don't insert it */
-			write_unlock_irqrestore(&devtree_lock, flags);
-			return -1;
-		}
-		next = &(*next)->next;
-	}
-	*next = prop;
-	write_unlock_irqrestore(&devtree_lock, flags);
-
-#ifdef CONFIG_PROC_DEVICETREE
-	/* try to add to proc as well if it was initialized */
-	if (np->pde)
-		proc_device_tree_add_prop(np->pde, prop);
-#endif /* CONFIG_PROC_DEVICETREE */
-
-	return 0;
-}
-
-/*
- * Remove a property from a node.  Note that we don't actually
- * remove it, since we have given out who-knows-how-many pointers
- * to the data using get-property.  Instead we just move the property
- * to the "dead properties" list, so it won't be found any more.
- */
-int prom_remove_property(struct device_node *np, struct property *prop)
-{
-	struct property **next;
-	unsigned long flags;
-	int found = 0;
-
-	write_lock_irqsave(&devtree_lock, flags);
-	next = &np->properties;
-	while (*next) {
-		if (*next == prop) {
-			/* found the node */
-			*next = prop->next;
-			prop->next = np->deadprops;
-			np->deadprops = prop;
-			found = 1;
-			break;
-		}
-		next = &(*next)->next;
-	}
-	write_unlock_irqrestore(&devtree_lock, flags);
-
-	if (!found)
-		return -ENODEV;
-
-#ifdef CONFIG_PROC_DEVICETREE
-	/* try to remove the proc node as well */
-	if (np->pde)
-		proc_device_tree_remove_prop(np->pde, prop);
-#endif /* CONFIG_PROC_DEVICETREE */
-
-	return 0;
-}
-
-/*
- * Update a property in a node.  Note that we don't actually
- * remove it, since we have given out who-knows-how-many pointers
- * to the data using get-property.  Instead we just move the property
- * to the "dead properties" list, and add the new property to the
- * property list
- */
-int prom_update_property(struct device_node *np,
-			 struct property *newprop,
-			 struct property *oldprop)
-{
-	struct property **next;
-	unsigned long flags;
-	int found = 0;
-
-	write_lock_irqsave(&devtree_lock, flags);
-	next = &np->properties;
-	while (*next) {
-		if (*next == oldprop) {
-			/* found the node */
-			newprop->next = oldprop->next;
-			*next = newprop;
-			oldprop->next = np->deadprops;
-			np->deadprops = oldprop;
-			found = 1;
-			break;
-		}
-		next = &(*next)->next;
-	}
-	write_unlock_irqrestore(&devtree_lock, flags);
-
-	if (!found)
-		return -ENODEV;
-
-#ifdef CONFIG_PROC_DEVICETREE
-	/* try to add to proc as well if it was initialized */
-	if (np->pde)
-		proc_device_tree_update_prop(np->pde, newprop, oldprop);
-#endif /* CONFIG_PROC_DEVICETREE */
-
-	return 0;
-}
-
-
 /* Find the device node for a given logical cpu number, also returns the cpu
  * local thread number (index in ibm,interrupt-server#s) if relevant and
  * asked for (non NULL)
Index: linux-next/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- linux-next.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/platforms/pseries/hotplug-cpu.c	2009-11-04 14:45:43.000000000 -0600
@@ -21,13 +21,13 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
+#include <linux/of.h>
 #include <asm/system.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/firmware.h>
 #include <asm/machdep.h>
 #include <asm/vdso_datapage.h>
-#include <asm/pSeries_reconfig.h>
 #include "xics.h"
 #include "plpar_wrappers.h"
 
@@ -234,11 +234,11 @@
 	int err = NOTIFY_OK;
 
 	switch (action) {
-	case PSERIES_RECONFIG_ADD:
+	case OF_ATTACH_NODE:
 		if (pseries_add_processor(node))
 			err = NOTIFY_BAD;
 		break;
-	case PSERIES_RECONFIG_REMOVE:
+	case OF_DETACH_NODE:
 		pseries_remove_processor(node);
 		break;
 	default:
@@ -284,7 +284,7 @@
 
 	/* Processors can be added/removed only on LPAR */
 	if (firmware_has_feature(FW_FEATURE_LPAR))
-		pSeries_reconfig_notifier_register(&pseries_smp_nb);
+		of_update_notifier_register(&pseries_smp_nb);
 
 	return 0;
 }
Index: linux-next/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- linux-next.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/platforms/pseries/hotplug-memory.c	2009-11-04 14:45:43.000000000 -0600
@@ -13,8 +13,8 @@
 #include <linux/lmb.h>
 #include <asm/firmware.h>
 #include <asm/machdep.h>
-#include <asm/pSeries_reconfig.h>
 #include <asm/sparsemem.h>
+#include "pseries.h"
 
 static int pseries_remove_lmb(unsigned long base, unsigned int lmb_size)
 {
@@ -118,7 +118,10 @@
 	return (ret < 0) ? -EINVAL : 0;
 }
 
-static int pseries_drconf_memory(unsigned long *base, unsigned int action)
+#define PSERIES_DRCONF_MEM_ADD		1
+#define PSERIES_DRCONF_MEM_REMOVE	2
+
+static int pseries_drconf_memory(unsigned long base, unsigned int action)
 {
 	struct device_node *np;
 	const unsigned long *lmb_size;
@@ -135,10 +138,10 @@
 	}
 
 	if (action == PSERIES_DRCONF_MEM_ADD) {
-		rc = lmb_add(*base, *lmb_size);
+		rc = lmb_add(base, *lmb_size);
 		rc = (rc < 0) ? -EINVAL : 0;
 	} else if (action == PSERIES_DRCONF_MEM_REMOVE) {
-		rc = pseries_remove_lmb(*base, *lmb_size);
+		rc = pseries_remove_lmb(base, *lmb_size);
 	} else {
 		rc = -EINVAL;
 	}
@@ -147,25 +150,30 @@
 	return rc;
 }
 
+int pseries_drconf_memory_add(unsigned long base)
+{
+	return pseries_drconf_memory(base, PSERIES_DRCONF_MEM_ADD);
+}
+
+int pseries_drconf_memory_remove(unsigned long base)
+{
+	return pseries_drconf_memory(base, PSERIES_DRCONF_MEM_REMOVE);
+}
+
 static int pseries_memory_notifier(struct notifier_block *nb,
 				unsigned long action, void *node)
 {
 	int err = NOTIFY_OK;
 
 	switch (action) {
-	case PSERIES_RECONFIG_ADD:
+	case OF_ATTACH_NODE:
 		if (pseries_add_memory(node))
 			err = NOTIFY_BAD;
 		break;
-	case PSERIES_RECONFIG_REMOVE:
+	case OF_DETACH_NODE:
 		if (pseries_remove_memory(node))
 			err = NOTIFY_BAD;
 		break;
-	case PSERIES_DRCONF_MEM_ADD:
-	case PSERIES_DRCONF_MEM_REMOVE:
-		if (pseries_drconf_memory(node, action))
-			err = NOTIFY_BAD;
-		break;
 	default:
 		err = NOTIFY_DONE;
 		break;
@@ -180,7 +188,7 @@
 static int __init pseries_memory_hotplug_init(void)
 {
 	if (firmware_has_feature(FW_FEATURE_LPAR))
-		pSeries_reconfig_notifier_register(&pseries_mem_nb);
+		of_update_notifier_register(&pseries_mem_nb);
 
 	return 0;
 }
Index: linux-next/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-next.orig/arch/powerpc/platforms/pseries/iommu.c	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/platforms/pseries/iommu.c	2009-11-04 14:45:43.000000000 -0600
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/crash_dump.h>
+#include <linux/of.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -40,7 +41,6 @@
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 #include <asm/abs_addr.h>
-#include <asm/pSeries_reconfig.h>
 #include <asm/firmware.h>
 #include <asm/tce.h>
 #include <asm/ppc-pci.h>
@@ -570,7 +570,7 @@
 	struct pci_dn *pci = PCI_DN(np);
 
 	switch (action) {
-	case PSERIES_RECONFIG_REMOVE:
+	case OF_DETACH_NODE:
 		if (pci && pci->iommu_table &&
 		    of_get_property(np, "ibm,dma-window", NULL))
 			iommu_free_table(pci->iommu_table, np->full_name);
@@ -617,7 +617,7 @@
 	}
 
 
-	pSeries_reconfig_notifier_register(&iommu_reconfig_nb);
+	of_update_notifier_register(&iommu_reconfig_nb);
 
 	set_pci_dma_ops(&dma_iommu_ops);
 }
Index: linux-next/arch/powerpc/platforms/pseries/pseries.h
===================================================================
--- linux-next.orig/arch/powerpc/platforms/pseries/pseries.h	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/platforms/pseries/pseries.h	2009-11-04 14:45:43.000000000 -0600
@@ -40,4 +40,18 @@
 
 extern void find_udbg_vterm(void);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+extern int pseries_drconf_memory_add(unsigned long);
+extern int pseries_drconf_memory_remove(unsigned long);
+#else
+static inline int pseries_drconf_memory_add(unsigned long base)
+{
+	return 0;
+}
+static inline int pseries_drconf_memory_remove(unsigned long base)
+{
+	return 0;
+}
+#endif
+
 #endif /* _PSERIES_PSERIES_H */
Index: linux-next/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- linux-next.orig/arch/powerpc/platforms/pseries/reconfig.c	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/platforms/pseries/reconfig.c	2009-11-04 14:57:47.000000000 -0600
@@ -13,100 +13,14 @@
 
 #include <linux/kernel.h>
 #include <linux/kref.h>
-#include <linux/notifier.h>
-#include <linux/proc_fs.h>
+#include <linux/of.h>
 
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/uaccess.h>
-#include <asm/pSeries_reconfig.h>
 #include <asm/mmu.h>
 
-
-
-/*
- * Routines for "runtime" addition and removal of device tree nodes.
- */
-#ifdef CONFIG_PROC_DEVICETREE
-/*
- * Add a node to /proc/device-tree.
- */
-static void add_node_proc_entries(struct device_node *np)
-{
-	struct proc_dir_entry *ent;
-
-	ent = proc_mkdir(strrchr(np->full_name, '/') + 1, np->parent->pde);
-	if (ent)
-		proc_device_tree_add_node(np, ent);
-}
-
-static void remove_node_proc_entries(struct device_node *np)
-{
-	struct property *pp = np->properties;
-	struct device_node *parent = np->parent;
-
-	while (pp) {
-		remove_proc_entry(pp->name, np->pde);
-		pp = pp->next;
-	}
-	if (np->pde)
-		remove_proc_entry(np->pde->name, parent->pde);
-}
-#else /* !CONFIG_PROC_DEVICETREE */
-static void add_node_proc_entries(struct device_node *np)
-{
-	return;
-}
-
-static void remove_node_proc_entries(struct device_node *np)
-{
-	return;
-}
-#endif /* CONFIG_PROC_DEVICETREE */
-
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
-
-static BLOCKING_NOTIFIER_HEAD(pSeries_reconfig_chain);
-
-int pSeries_reconfig_notifier_register(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&pSeries_reconfig_chain, nb);
-}
-
-void pSeries_reconfig_notifier_unregister(struct notifier_block *nb)
-{
-	blocking_notifier_chain_unregister(&pSeries_reconfig_chain, nb);
-}
+#include "pseries.h"
 
 static int pSeries_reconfig_add_node(const char *path, struct property *proplist)
 {
@@ -124,34 +38,12 @@
 	strcpy(np->full_name, path);
 
 	np->properties = proplist;
-	of_node_set_flag(np, OF_DYNAMIC);
-	kref_init(&np->kref);
-
-	np->parent = derive_parent(path);
-	if (IS_ERR(np->parent)) {
-		err = PTR_ERR(np->parent);
-		goto out_err;
-	}
-
-	err = blocking_notifier_call_chain(&pSeries_reconfig_chain,
-				  PSERIES_RECONFIG_ADD, np);
-	if (err == NOTIFY_BAD) {
-		printk(KERN_ERR "Failed to add device node %s\n", path);
-		err = -ENOMEM; /* For now, safe to assume kmalloc failure */
-		goto out_err;
-	}
-
 	of_attach_node(np);
 
-	add_node_proc_entries(np);
-
-	of_node_put(np->parent);
-
 	return 0;
 
 out_err:
 	if (np) {
-		of_node_put(np->parent);
 		kfree(np->full_name);
 		kfree(np);
 	}
@@ -172,10 +64,6 @@
 		return -EBUSY;
 	}
 
-	remove_node_proc_entries(np);
-
-	blocking_notifier_call_chain(&pSeries_reconfig_chain,
-			    PSERIES_RECONFIG_REMOVE, np);
 	of_detach_node(np);
 
 	of_node_put(parent);
@@ -392,7 +280,7 @@
 	if (!prop)
 		return -ENOMEM;
 
-	prom_add_property(np, prop);
+	of_property_attach(np, prop);
 
 	return 0;
 }
@@ -416,7 +304,7 @@
 
 	prop = of_find_property(np, buf, NULL);
 
-	return prom_remove_property(np, prop);
+	return of_property_detach(np, prop);
 }
 
 static int do_update_property(char *buf, size_t bufsize)
@@ -446,37 +334,34 @@
 	oldprop = of_find_property(np, name,NULL);
 	if (!oldprop) {
 		if (strlen(name))
-			return prom_add_property(np, newprop);
+			return of_property_attach(np, newprop);
 		return -ENODEV;
 	}
 
-	rc = prom_update_property(np, newprop, oldprop);
+	rc = of_property_update(np, newprop, oldprop);
 	if (rc)
 		return rc;
 
 	/* For memory under the ibm,dynamic-reconfiguration-memory node
 	 * of the device tree, adding and removing memory is just an update
 	 * to the ibm,dynamic-memory property instead of adding/removing a
-	 * memory node in the device tree.  For these cases we still need to
-	 * involve the notifier chain.
+	 * memory node in the device tree.
 	 */
 	if (!strcmp(name, "ibm,dynamic-memory")) {
-		int action;
+		unsigned long *addr;
 
-		next_prop = parse_next_property(next_prop, end, &name,
-						&length, &value);
+		next_prop = parse_next_property(next_prop, end, &name, &length,
+						(unsigned char **)&addr);
 		if (!next_prop)
 			return -EINVAL;
 
 		if (!strcmp(name, "add"))
-			action = PSERIES_DRCONF_MEM_ADD;
+			rc = pseries_drconf_memory_add(*addr);
 		else
-			action = PSERIES_DRCONF_MEM_REMOVE;
+			rc = pseries_drconf_memory_remove(*addr);
 
-		rc = blocking_notifier_call_chain(&pSeries_reconfig_chain,
-						  action, value);
-		if (rc == NOTIFY_BAD) {
-			rc = prom_update_property(np, oldprop, newprop);
+		if (rc) {
+			rc = of_property_update(np, oldprop, newprop);
 			return -ENOMEM;
 		}
 	}
Index: linux-next/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-next.orig/arch/powerpc/platforms/pseries/setup.c	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/platforms/pseries/setup.c	2009-11-04 14:45:43.000000000 -0600
@@ -40,6 +40,7 @@
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/of.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -63,7 +64,6 @@
 #include <asm/smp.h>
 #include <asm/firmware.h>
 #include <asm/eeh.h>
-#include <asm/pSeries_reconfig.h>
 
 #include "plpar_wrappers.h"
 #include "pseries.h"
@@ -258,7 +258,7 @@
 	int err = NOTIFY_OK;
 
 	switch (action) {
-	case PSERIES_RECONFIG_ADD:
+	case OF_ATTACH_NODE:
 		pci = np->parent->data;
 		if (pci)
 			update_dn_pci_info(np, pci->phb);
@@ -291,7 +291,7 @@
 	/* Find and initialize PCI host bridges */
 	init_pci_config_tokens();
 	find_and_init_phbs();
-	pSeries_reconfig_notifier_register(&pci_dn_reconfig_nb);
+	of_update_notifier_register(&pci_dn_reconfig_nb);
 	eeh_init();
 
 	pSeries_nvram_init();
Index: linux-next/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- linux-next.orig/arch/powerpc/platforms/pseries/smp.c	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/platforms/pseries/smp.c	2009-11-04 14:45:43.000000000 -0600
@@ -40,7 +40,6 @@
 #include <asm/firmware.h>
 #include <asm/system.h>
 #include <asm/rtas.h>
-#include <asm/pSeries_reconfig.h>
 #include <asm/mpic.h>
 #include <asm/vdso_datapage.h>
 #include <asm/cputhreads.h>
Index: linux-next/arch/powerpc/include/asm/prom.h
===================================================================
--- linux-next.orig/arch/powerpc/include/asm/prom.h	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/include/asm/prom.h	2009-11-04 14:45:43.000000000 -0600
@@ -34,10 +34,6 @@
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
-/* For updating the device tree at runtime */
-extern void of_attach_node(struct device_node *);
-extern void of_detach_node(struct device_node *);
-
 #ifdef CONFIG_PPC32
 /*
  * PCI <-> OF matching functions
Index: linux-next/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- linux-next.orig/arch/powerpc/kernel/machine_kexec.c	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/kernel/machine_kexec.c	2009-11-04 14:45:43.000000000 -0600
@@ -173,16 +173,16 @@
 	 * be sure what's in them, so remove them. */
 	prop = of_find_property(node, "linux,crashkernel-base", NULL);
 	if (prop)
-		prom_remove_property(node, prop);
+		of_property_detach(node, prop);
 
 	prop = of_find_property(node, "linux,crashkernel-size", NULL);
 	if (prop)
-		prom_remove_property(node, prop);
+		of_property_detach(node, prop);
 
 	if (crashk_res.start != 0) {
-		prom_add_property(node, &crashk_base_prop);
+		of_property_attach(node, &crashk_base_prop);
 		crashk_size = crashk_res.end - crashk_res.start + 1;
-		prom_add_property(node, &crashk_size_prop);
+		of_property_attach(node, &crashk_size_prop);
 	}
 }
 
@@ -198,11 +198,11 @@
 	/* remove any stale properties so ours can be found */
 	prop = of_find_property(node, kernel_end_prop.name, NULL);
 	if (prop)
-		prom_remove_property(node, prop);
+		of_property_detach(node, prop);
 
 	/* information needed by userspace when using default_machine_kexec */
 	kernel_end = __pa(_end);
-	prom_add_property(node, &kernel_end_prop);
+	of_property_attach(node, &kernel_end_prop);
 
 	export_crashk_values(node);
 
Index: linux-next/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- linux-next.orig/arch/powerpc/kernel/machine_kexec_64.c	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/kernel/machine_kexec_64.c	2009-11-04 14:45:43.000000000 -0600
@@ -15,6 +15,7 @@
 #include <linux/thread_info.h>
 #include <linux/init_task.h>
 #include <linux/errno.h>
+#include <linux/of.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -320,14 +321,14 @@
 	/* remove any stale propertys so ours can be found */
 	prop = of_find_property(node, htab_base_prop.name, NULL);
 	if (prop)
-		prom_remove_property(node, prop);
+		of_property_detach(node, prop);
 	prop = of_find_property(node, htab_size_prop.name, NULL);
 	if (prop)
-		prom_remove_property(node, prop);
+		of_property_detach(node, prop);
 
 	htab_base = __pa(htab_address);
-	prom_add_property(node, &htab_base_prop);
-	prom_add_property(node, &htab_size_prop);
+	of_property_attach(node, &htab_base_prop);
+	of_property_attach(node, &htab_size_prop);
 
 	of_node_put(node);
 	return 0;
Index: linux-next/arch/powerpc/Kconfig
===================================================================
--- linux-next.orig/arch/powerpc/Kconfig	2009-11-04 14:42:17.000000000 -0600
+++ linux-next/arch/powerpc/Kconfig	2009-11-04 14:45:43.000000000 -0600
@@ -174,6 +174,9 @@
 config OF
 	def_bool y
 
+config OF_DYNAMIC
+	def_bool y
+
 config PPC_UDBG_16550
 	bool
 	default n
