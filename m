Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 23 Mar 2006 23:33:20 +1100
Subject: [PATCH 4/4] powerpc: Cope with duplicate node & property names in
	/proc/device-tree
In-Reply-To: <1143117144.850591.48752080269.qpush@concordia>
Message-Id: <20060323123350.8321667AC5@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Various dodgy firmware might give us nodes and/or properties in the device
tree with conflicting names. That's generally ok, except for when we export
the device tree via /proc, so check when we're creating the proc device tree
and munge names accordingly.

Tested on a faked device tree with kexec, would be good if someone with
actual bogus firmware could try it, but just for completeness.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 fs/proc/proc_devtree.c |   93 +++++++++++++++++++++++++++++++++++++------------
 1 files changed, 72 insertions(+), 21 deletions(-)

Index: to-merge/fs/proc/proc_devtree.c
===================================================================
--- to-merge.orig/fs/proc/proc_devtree.c
+++ to-merge/fs/proc/proc_devtree.c
@@ -52,7 +52,8 @@ static int property_read_proc(char *page
  * Add a property to a node
  */
 static struct proc_dir_entry *
-__proc_device_tree_add_prop(struct proc_dir_entry *de, struct property *pp)
+__proc_device_tree_add_prop(struct proc_dir_entry *de, struct property *pp,
+		char *name)
 {
 	struct proc_dir_entry *ent;
 
@@ -60,14 +61,14 @@ __proc_device_tree_add_prop(struct proc_
 	 * Unfortunately proc_register puts each new entry
 	 * at the beginning of the list.  So we rearrange them.
 	 */
-	ent = create_proc_read_entry(pp->name,
-				     strncmp(pp->name, "security-", 9)
+	ent = create_proc_read_entry(name,
+				     strncmp(name, "security-", 9)
 				     ? S_IRUGO : S_IRUSR, de,
 				     property_read_proc, pp);
 	if (ent == NULL)
 		return NULL;
 
-	if (!strncmp(pp->name, "security-", 9))
+	if (!strncmp(name, "security-", 9))
 		ent->size = 0; /* don't leak number of password chars */
 	else
 		ent->size = pp->length;
@@ -78,7 +79,7 @@ __proc_device_tree_add_prop(struct proc_
 
 void proc_device_tree_add_prop(struct proc_dir_entry *pde, struct property *prop)
 {
-	__proc_device_tree_add_prop(pde, prop);
+	__proc_device_tree_add_prop(pde, prop, prop->name);
 }
 
 void proc_device_tree_remove_prop(struct proc_dir_entry *pde,
@@ -106,6 +107,61 @@ void proc_device_tree_update_prop(struct
 }
 
 /*
+ * Various dodgy firmware might give us nodes and/or properties with
+ * conflicting names. That's generally ok, except for exporting via /proc,
+ * so munge names here to ensure they're unique.
+ */
+
+static int duplicate_name(struct proc_dir_entry *de, char *name)
+{
+	struct proc_dir_entry *ent;
+
+	for (ent = de->subdir; ent != NULL; ent = ent->next)
+		if (strcmp(ent->name, name) == 0)
+			return 1;
+
+	return 0;
+}
+
+static char *fixup_name(struct device_node *np, struct proc_dir_entry *de,
+		char *name)
+{
+	char *fixed_name;
+	int fixup_len = strlen(name) + 2 + 1; /* name + #x + \0 */
+	int i = 1, size;
+
+realloc:
+	fixed_name = kmalloc(fixup_len, GFP_KERNEL);
+	if (fixed_name == NULL) {
+		printk(KERN_ERR "device-tree: Out of memory trying to fixup "
+				"name \"%s\"\n", name);
+		return name;
+	}
+
+retry:
+	size = snprintf(fixed_name, fixup_len, "%s#%d", name, i);
+	size++; /* account for NULL */
+
+	if (size > fixup_len) {
+		/* We ran out of space, free and reallocate. */
+		kfree(fixed_name);
+		fixup_len = size;
+		goto realloc;
+	}
+
+	if (duplicate_name(de, fixed_name)) {
+		/* Multiple duplicates. Retry with a different offset. */
+		i++;
+		goto retry;
+	}
+
+	printk(KERN_WARNING "device-tree: Duplicate name in %s, "
+			"renamed to \"%s\"\n", np->full_name, fixed_name);
+
+	return fixed_name;
+}
+
+/*
  * Process a node, adding entries for its children and its properties.
  */
 void proc_device_tree_add_node(struct device_node *np,
@@ -118,35 +174,30 @@ void proc_device_tree_add_node(struct de
 
 	set_node_proc_entry(np, de);
 	for (child = NULL; (child = of_get_next_child(np, child));) {
+		/* Use everything after the last slash, or the full name */
 		p = strrchr(child->full_name, '/');
 		if (!p)
 			p = child->full_name;
 		else
 			++p;
+
+		if (duplicate_name(de, p))
+			p = fixup_name(np, de, p);
+
 		ent = proc_mkdir(p, de);
 		if (ent == 0)
 			break;
 		proc_device_tree_add_node(child, ent);
 	}
 	of_node_put(child);
+
 	for (pp = np->properties; pp != 0; pp = pp->next) {
-		/*
-		 * Yet another Apple device-tree bogosity: on some machines,
-		 * they have properties & nodes with the same name. Those
-		 * properties are quite unimportant for us though, thus we
-		 * simply "skip" them here, but we do have to check.
-		 */
-		for (ent = de->subdir; ent != NULL; ent = ent->next)
-			if (!strcmp(ent->name, pp->name))
-				break;
-		if (ent != NULL) {
-			printk(KERN_WARNING "device-tree: property \"%s\" name"
-			       " conflicts with node in %s\n", pp->name,
-			       np->full_name);
-			continue;
-		}
+		p = pp->name;
+
+		if (duplicate_name(de, p))
+			p = fixup_name(np, de, p);
 
-		ent = __proc_device_tree_add_prop(de, pp);
+		ent = __proc_device_tree_add_prop(de, pp, p);
 		if (ent == 0)
 			break;
 	}
