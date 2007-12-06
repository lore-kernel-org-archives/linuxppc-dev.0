Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Dec 2007 17:04:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Remove obsolete check_properties() function
Message-ID: <20071206060404.GF19927@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After the last couple of patches converting various old-style semantic
checks to the new framework, the only thing that the old-style
check_properties() function still checks is that the size of "reg"
properties is a multiple of the cell size.

This patch removes check_properties() and all related code and data.
The check on the size of reg properties is folded into the existing
check for the format of "reg" properties (still old-style for the time
being).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-12-05 11:08:45.000000000 +1100
+++ dtc/checks.c	2007-12-05 11:08:48.000000000 +1100
@@ -412,46 +412,6 @@
 
 #define DO_ERR(...) do {ERRMSG(__VA_ARGS__); ok = 0; } while (0)
 
-static int must_be_cells(struct property *prop, struct node *node)
-{
-	if ((prop->val.len % sizeof(cell_t)) != 0) {
-		ERRMSG("\"%s\" property in %s is not a multiple of cell size\n",
-		       prop->name, node->fullpath);
-		return 0;
-	}
-
-	return 1;
-}
-
-static struct {
-	char *propname;
-	int (*check_fn)(struct property *prop, struct node *node);
-} prop_checker_table[] = {
-	{"reg", must_be_cells},
-};
-
-static int check_properties(struct node *node)
-{
-	struct property *prop;
-	struct node *child;
-	int i;
-	int ok = 1;
-
-	for_each_property(node, prop)
-		for (i = 0; i < ARRAY_SIZE(prop_checker_table); i++)
-			if (streq(prop->name, prop_checker_table[i].propname))
-				if (! prop_checker_table[i].check_fn(prop, node)) {
-					ok = 0;
-					break;
-				}
-
-	for_each_child(node, child)
-		if (! check_properties(child))
-			ok = 0;
-
-	return ok;
-}
-
 #define CHECK_HAVE(node, propname) \
 	do { \
 		if (! (prop = get_property((node), (propname)))) \
@@ -672,10 +632,9 @@
 
 	prop = get_property(node, "reg");
 	if (prop) {
-		int len = prop->val.len / 4;
-
-		if ((len % (addr_cells+size_cells)) != 0)
-			DO_ERR("\"reg\" property in %s has invalid length (%d) for given #address-cells (%d) and #size-cells (%d)\n",
+		int reg_entry_len = (addr_cells + size_cells) * sizeof(cell_t);
+		if ((prop->val.len % reg_entry_len) != 0)
+			DO_ERR("\"reg\" property in %s has invalid length (%d bytes) for given #address-cells (%d) and #size-cells (%d)\n",
 			       node->fullpath, prop->val.len,
 			       addr_cells, size_cells);
 	}
@@ -699,7 +658,6 @@
 {
 	int ok = 1;
 
-	ok = ok && check_properties(dt);
 	ok = ok && check_addr_size_reg(dt, -1, -1);
 	ok = ok && check_root(dt);
 	ok = ok && check_cpus(dt, outversion, boot_cpuid_phys);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
