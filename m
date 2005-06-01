Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 17:07:27 +1000
Message-Id: <1117609647.5409.8.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc32/ppc64: cleanup /proc/device-tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch cleans up the /proc/device-tree representation of the Open
Firmware device-tree on ppc and ppc64. It does the following things:

 - Workaround an issue in some Apple device-trees where a property may
exist with the same name as a child node of the parent. We now simply
"drop" the property instead of creating duplicate entries in /proc with
random result...

 - Do not try to chop off the "@0" at the end of a node name whose unit
address is 0. This is not useful, inconsistent, and the code was buggy
and didn't always work anyway.

 - Do not create symlinks for the short name and unit address parts of a
ndoe. These were never really used, bloated the memory footprint of the
device-tree with useless struct proc_dir_entry and their matching dentry
and inode cache bloat.

This results in smaller code, smaller memory footprint, and a more
accurate view of the tree presented to userland.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/fs/proc/proc_devtree.c
===================================================================
--- linux-work.orig/fs/proc/proc_devtree.c	2005-06-01 16:18:51.000000000 +1000
+++ linux-work/fs/proc/proc_devtree.c	2005-06-01 16:47:35.000000000 +1000
@@ -12,15 +12,8 @@
 #include <asm/uaccess.h>
 
 #ifndef HAVE_ARCH_DEVTREE_FIXUPS
-static inline void set_node_proc_entry(struct device_node *np, struct proc_dir_entry *de)
-{
-}
-
-static void inline set_node_name_link(struct device_node *np, struct proc_dir_entry *de)
-{
-}
-
-static void inline set_node_addr_link(struct device_node *np, struct proc_dir_entry *de)
+static inline void set_node_proc_entry(struct device_node *np,
+				       struct proc_dir_entry *de)
 {
 }
 #endif
@@ -58,89 +51,67 @@
 /*
  * Process a node, adding entries for its children and its properties.
  */
-void proc_device_tree_add_node(struct device_node *np, struct proc_dir_entry *de)
+void proc_device_tree_add_node(struct device_node *np,
+			       struct proc_dir_entry *de)
 {
 	struct property *pp;
 	struct proc_dir_entry *ent;
-	struct device_node *child, *sib;
-	const char *p, *at;
-	int l;
-	struct proc_dir_entry *list, **lastp, *al;
+	struct device_node *child;
+	struct proc_dir_entry *list = NULL, **lastp;
+	const char *p;
 
 	set_node_proc_entry(np, de);
 	lastp = &list;
-	for (pp = np->properties; pp != 0; pp = pp->next) {
-		/*
-		 * Unfortunately proc_register puts each new entry
-		 * at the beginning of the list.  So we rearrange them.
-		 */
-		ent = create_proc_read_entry(pp->name, strncmp(pp->name, "security-", 9) ?
-					     S_IRUGO : S_IRUSR, de, property_read_proc, pp);
-		if (ent == 0)
-			break;
-		if (!strncmp(pp->name, "security-", 9))
-		     ent->size = 0; /* don't leak number of password chars */
-		else
-		     ent->size = pp->length;
-		*lastp = ent;
-		lastp = &ent->next;
-	}
-	child = NULL;
-	while ((child = of_get_next_child(np, child))) {
+	for (child = NULL; (child = of_get_next_child(np, child));) {
 		p = strrchr(child->full_name, '/');
 		if (!p)
 			p = child->full_name;
 		else
 			++p;
-		/* chop off '@0' if the name ends with that */
-		l = strlen(p);
-		if (l > 2 && p[l-2] == '@' && p[l-1] == '0')
-			l -= 2;
 		ent = proc_mkdir(p, de);
 		if (ent == 0)
 			break;
 		*lastp = ent;
+		ent->next = NULL;
 		lastp = &ent->next;
 		proc_device_tree_add_node(child, ent);
-
-		/*
-		 * If we left the address part on the name, consider
-		 * adding symlinks from the name and address parts.
-		 */
-		if (p[l] != 0 || (at = strchr(p, '@')) == 0)
-			continue;
-
+	}
+	of_node_put(child);
+	for (pp = np->properties; pp != 0; pp = pp->next) {
 		/*
-		 * If this is the first node with a given name property,
-		 * add a symlink with the name property as its name.
+		 * Yet another Apple device-tree bogosity: on some machines,
+		 * they have properties & nodes with the same name. Those
+		 * properties are quite unimportant for us though, thus we
+		 * simply "skip" them here, but we do have to check.
 		 */
-		sib = NULL;
-		while ((sib = of_get_next_child(np, sib)) && sib != child)
-			if (sib->name && strcmp(sib->name, child->name) == 0)
-				break;
-		if (sib == child && strncmp(p, child->name, l) != 0) {
-			al = proc_symlink(child->name, de, ent->name);
-			if (al == 0) {
-				of_node_put(sib);
+		for (ent = list; ent != NULL; ent = ent->next)
+			if (!strcmp(ent->name, pp->name))
 				break;
-			}
-			set_node_name_link(child, al);
-			*lastp = al;
-			lastp = &al->next;
+		if (ent != NULL) {
+			printk(KERN_WARNING "device-tree: property \"%s\" name"
+			       " conflicts with node in %s\n", pp->name,
+			       np->full_name);
+			continue;
 		}
-		of_node_put(sib);
+
 		/*
-		 * Add another directory with the @address part as its name.
+		 * Unfortunately proc_register puts each new entry
+		 * at the beginning of the list.  So we rearrange them.
 		 */
-		al = proc_symlink(at, de, ent->name);
-		if (al == 0)
+		ent = create_proc_read_entry(pp->name,
+					     strncmp(pp->name, "security-", 9)
+					     ? S_IRUGO : S_IRUSR, de,
+					     property_read_proc, pp);
+		if (ent == 0)
 			break;
-		set_node_addr_link(child, al);
-		*lastp = al;
-		lastp = &al->next;
+		if (!strncmp(pp->name, "security-", 9))
+		     ent->size = 0; /* don't leak number of password chars */
+		else
+		     ent->size = pp->length;
+		ent->next = NULL;
+		*lastp = ent;
+		lastp = &ent->next;
 	}
-	of_node_put(child);
-	*lastp = NULL;
 	de->subdir = list;
 }
 
Index: linux-work/include/asm-ppc64/prom.h
===================================================================
--- linux-work.orig/include/asm-ppc64/prom.h	2005-06-01 16:18:51.000000000 +1000
+++ linux-work/include/asm-ppc64/prom.h	2005-06-01 16:30:30.000000000 +1000
@@ -147,9 +147,7 @@
 	struct	device_node *sibling;
 	struct	device_node *next;	/* next device of same type */
 	struct	device_node *allnext;	/* next in list of all nodes */
-	struct  proc_dir_entry *pde;       /* this node's proc directory */
-	struct  proc_dir_entry *name_link; /* name symlink */
-	struct  proc_dir_entry *addr_link; /* addr symlink */
+	struct  proc_dir_entry *pde;	/* this node's proc directory */
 	struct  kref kref;
 	unsigned long _flags;
 };
@@ -174,15 +172,6 @@
 	dn->pde = de;
 }
 
-static void inline set_node_name_link(struct device_node *dn, struct proc_dir_entry *de)
-{
-	dn->name_link = de;
-}
-
-static void inline set_node_addr_link(struct device_node *dn, struct proc_dir_entry *de)
-{
-	dn->addr_link = de;
-}
 
 /* OBSOLETE: Old stlye node lookup */
 extern struct device_node *find_devices(const char *name);
Index: linux-work/arch/ppc64/kernel/pSeries_reconfig.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pSeries_reconfig.c	2005-06-01 16:18:51.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pSeries_reconfig.c	2005-06-01 16:30:30.000000000 +1000
@@ -47,14 +47,6 @@
 		remove_proc_entry(pp->name, np->pde);
 		pp = pp->next;
 	}
-
-	/* Assuming that symlinks have the same parent directory as
-	 * np->pde.
-	 */
-	if (np->name_link)
-		remove_proc_entry(np->name_link->name, parent->pde);
-	if (np->addr_link)
-		remove_proc_entry(np->addr_link->name, parent->pde);
 	if (np->pde)
 		remove_proc_entry(np->pde->name, parent->pde);
 }
