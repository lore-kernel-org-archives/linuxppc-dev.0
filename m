Return-Path: <dgibson@ozlabs.org>
Date: Wed, 20 Aug 2008 16:55:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Add function to explicitly expand aliases
Message-ID: <20080820065514.GA18996@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar has already added alias expansion to fdt_path_offset().
However, in some circumstances it may be convenient for the user of
libfdt to explicitly get the string expansion of an alias.  This patch
adds a function to do this, fdt_get_alias(), and uses it to implement
fdt_path_offset().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-08-20 15:59:56.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2008-08-20 15:59:56.000000000 +1000
@@ -141,17 +141,12 @@ int fdt_path_offset(const void *fdt, con
 
 	/* see if we have an alias */
 	if (*path != '/') {
-		const char *q;
-		int aliasoffset = fdt_path_offset(fdt, "/aliases");
-
-		if (aliasoffset < 0)
-			return -FDT_ERR_BADPATH;
+		const char *q = strchr(path, '/');
 
-		q = strchr(path, '/');
 		if (!q)
 			q = end;
 
-		p = fdt_getprop_namelen(fdt, aliasoffset, path, q - p, NULL);
+		p = fdt_get_alias_namelen(fdt, p, q - p);
 		if (!p)
 			return -FDT_ERR_BADPATH;
 		offset = fdt_path_offset(fdt, p);
@@ -302,6 +297,23 @@ uint32_t fdt_get_phandle(const void *fdt
 	return fdt32_to_cpu(*php);
 }
 
+const char *fdt_get_alias_namelen(const void *fdt,
+				  const char *name, int namelen)
+{
+	int aliasoffset;
+
+	aliasoffset = fdt_path_offset(fdt, "/aliases");
+	if (aliasoffset < 0)
+		return NULL;
+
+	return fdt_getprop_namelen(fdt, aliasoffset, name, namelen, NULL);
+}
+
+const char *fdt_get_alias(const void *fdt, const char *name)
+{
+	return fdt_get_alias_namelen(fdt, name, strlen(name));
+}
+
 int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen)
 {
 	int pdepth = 0, p = 0;
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2008-08-20 15:59:56.000000000 +1000
+++ dtc/libfdt/libfdt.h	2008-08-20 15:59:56.000000000 +1000
@@ -459,6 +459,32 @@ static inline void *fdt_getprop_w(void *
 uint32_t fdt_get_phandle(const void *fdt, int nodeoffset);
 
 /**
+ * fdt_get_namelen - get alias based on substring
+ * @fdt: pointer to the device tree blob
+ * @name: name of the alias th look up
+ * @namelen: number of characters of name to consider
+ *
+ * Identical to fdt_get_alias(), but only examine the first namelen
+ * characters of name for matching the alias name.
+ */
+const char *fdt_get_alias_namelen(const void *fdt,
+				  const char *name, int namelen);
+
+/**
+ * fdt_get_alias - retreive the path referenced by a given alias
+ * @fdt: pointer to the device tree blob
+ * @name: name of the alias th look up
+ *
+ * fdt_get_alias() retrieves the value of a given alias.  That is, the
+ * value of the property named 'name' in the node /aliases.
+ *
+ * returns:
+ *	a pointer to the expansion of the alias named 'name', of it exists
+ *	NULL, if the given alias or the /aliases node does not exist
+ */
+const char *fdt_get_alias(const void *fdt, const char *name);
+
+/**
  * fdt_get_path - determine the full path of a node
  * @fdt: pointer to the device tree blob
  * @nodeoffset: offset of the node whose path to find
Index: dtc/tests/get_alias.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/get_alias.c	2008-08-20 15:59:56.000000000 +1000
@@ -0,0 +1,58 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_get_alias()
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1 of
+ * the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "tests.h"
+#include "testdata.h"
+
+void check_alias(void *fdt, const char *path, const char *alias)
+{
+	const char *aliaspath;
+
+	aliaspath = fdt_get_alias(fdt, alias);
+
+	if (path && !aliaspath)
+		FAIL("fdt_get_alias(%s) failed\n", alias);
+
+	if (strcmp(aliaspath, path) != 0)
+		FAIL("fdt_get_alias(%s) returned %s instead of %s\n",
+		     alias, aliaspath, path);
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+
+	check_alias(fdt, "/subnode@1", "s1");
+	check_alias(fdt, "/subnode@1/subsubnode", "ss1");
+	check_alias(fdt, "/subnode@1/subsubnode/subsubsubnode", "sss1");
+
+	PASS();
+}
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2008-08-20 15:59:56.000000000 +1000
+++ dtc/tests/Makefile.tests	2008-08-20 15:59:56.000000000 +1000
@@ -4,6 +4,7 @@ LIB_TESTS_L = get_mem_rsv \
 	get_path supernode_atdepth_offset parent_offset \
 	node_offset_by_prop_value node_offset_by_phandle \
 	node_check_compatible node_offset_by_compatible \
+	get_alias \
 	notfound \
 	setprop_inplace nop_property nop_node \
 	sw_tree1 \
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-08-20 15:59:56.000000000 +1000
+++ dtc/tests/run_tests.sh	2008-08-20 15:59:56.000000000 +1000
@@ -216,6 +216,7 @@ dtc_tests () {
 
     # Check aliases support in fdt_path_offset
     run_dtc_test -I dts -O dtb -o aliases.dtb aliases.dts
+    run_test get_alias aliases.dtb
     run_test path_offset_aliases aliases.dtb
 
     # Check /include/ directive

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
