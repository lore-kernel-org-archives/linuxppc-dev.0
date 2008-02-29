Return-Path: <dgibson@ozlabs.org>
Date: Fri, 29 Feb 2008 16:51:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Make -I dtb mode use fill_fullpaths()
Message-ID: <20080229055128.GC1197@localhost.localdomain>
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

At present -I dts and -I fs modes both use the fill_fullpaths() helper
function to fill in the fullpath and basenamelen fields of struct
node, which are useful in later parts of the code.  -I dtb mode,
however, fills these in itself.

This patch simplifies flattree.c by making -I dtb mode use
fill_fullpaths() like the others.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2008-02-29 13:38:15.000000000 +1100
+++ dtc/flattree.c	2008-02-29 16:46:02.000000000 +1100
@@ -704,59 +704,37 @@ static struct reserve_info *flat_read_me
 
 static char *nodename_from_path(const char *ppath, const char *cpath)
 {
-	const char *lslash;
 	int plen;
 
-	lslash = strrchr(cpath, '/');
-	if (! lslash)
-		return NULL;
+	plen = strlen(ppath);
 
-	plen = lslash - cpath;
+	if (!strneq(ppath, cpath, plen))
+		die("Path \"%s\" is not valid as a child of \"%s\"\n",
+		    cpath, ppath);
 
-	if (streq(cpath, "/") && streq(ppath, ""))
-		return "";
+	/* root node is a special case */
+	if (!streq(ppath, "/"))
+		plen++;
 
-	if ((plen == 0) && streq(ppath, "/"))
-		return strdup(lslash+1);
-
-	if (! strneq(ppath, cpath, plen))
-		return NULL;
-
-	return strdup(lslash+1);
-}
-
-static int find_basenamelen(const char *name)
-{
-	const char *atpos = strchr(name, '@');
-
-	if (atpos)
-		return atpos - name;
-	else
-		return strlen(name);
+	return strdup(cpath + plen);
 }
 
 static struct node *unflatten_tree(struct inbuf *dtbuf,
 				   struct inbuf *strbuf,
-				   const char *parent_path, int flags)
+				   const char *parent_flatname, int flags)
 {
 	struct node *node;
+	char *flatname;
 	u32 val;
 
 	node = build_node(NULL, NULL);
 
-	if (flags & FTF_FULLPATH) {
-		node->fullpath = flat_read_string(dtbuf);
-		node->name = nodename_from_path(parent_path, node->fullpath);
-
-		if (! node->name)
-			die("Path \"%s\" is not valid as a child of \"%s\"\n",
-			    node->fullpath, parent_path);
-	} else {
-		node->name = flat_read_string(dtbuf);
-		node->fullpath = join_path(parent_path, node->name);
-	}
+	flatname = flat_read_string(dtbuf);
 
-	node->basenamelen = find_basenamelen(node->name);
+	if (flags & FTF_FULLPATH)
+		node->name = nodename_from_path(parent_flatname, flatname);
+	else
+		node->name = flatname;
 
 	do {
 		struct property *prop;
@@ -773,8 +751,7 @@ static struct node *unflatten_tree(struc
 			break;
 
 		case FDT_BEGIN_NODE:
-			child = unflatten_tree(dtbuf,strbuf, node->fullpath,
-					       flags);
+			child = unflatten_tree(dtbuf,strbuf, flatname, flags);
 			add_child(node, child);
 			break;
 
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2008-02-28 12:55:04.000000000 +1100
+++ dtc/dtc.c	2008-02-29 16:16:07.000000000 +1100
@@ -55,7 +55,7 @@ char *join_path(const char *path, const 
 	return str;
 }
 
-void fill_fullpaths(struct node *tree, const char *prefix)
+static void fill_fullpaths(struct node *tree, const char *prefix)
 {
 	struct node *child;
 	const char *unit;
@@ -208,6 +208,7 @@ int main(int argc, char *argv[])
 	if (! bi || ! bi->dt || bi->error)
 		die("Couldn't read input tree\n");
 
+	fill_fullpaths(bi->dt, "");
 	process_checks(force, bi);
 
 	if (streq(outname, "-")) {
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2008-02-28 17:02:38.000000000 +1100
+++ dtc/dtc.h	2008-02-29 16:16:07.000000000 +1100
@@ -264,6 +264,5 @@ struct boot_info *dt_from_fs(const char 
 /* misc */
 
 char *join_path(const char *path, const char *name);
-void fill_fullpaths(struct node *tree, const char *prefix);
 
 #endif /* _DTC_H */
Index: dtc/fstree.c
===================================================================
--- dtc.orig/fstree.c	2008-02-28 12:55:04.000000000 +1100
+++ dtc/fstree.c	2008-02-29 16:16:07.000000000 +1100
@@ -87,8 +87,6 @@ struct boot_info *dt_from_fs(const char 
 	tree = read_fstree(dirname);
 	tree = name_node(tree, "", NULL);
 
-	fill_fullpaths(tree, "");
-
 	return build_boot_info(NULL, tree);
 }
 
Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2008-02-28 17:02:36.000000000 +1100
+++ dtc/treesource.c	2008-02-29 16:16:07.000000000 +1100
@@ -37,8 +37,6 @@ struct boot_info *dt_from_source(const c
 	if (yyparse() != 0)
 		return NULL;
 
-	fill_fullpaths(the_boot_info->dt, "");
-
 	the_boot_info->error = treesource_error;
 	return the_boot_info;
 }

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
