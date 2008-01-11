Return-Path: <dgibson@ozlabs.org>
Date: Fri, 11 Jan 2008 14:55:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Add fdt_set_name() function
Message-ID: <20080111035505.GB25055@localhost.localdomain>
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

This patch adds an fdt_set_name() function to libfdt, mirroring
fdt_get_name().  This is a r/w function which alters the name of a
given device tree node.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-12-19 10:52:12.000000000 +1100
+++ dtc/libfdt/libfdt.h	2008-01-11 14:53:27.000000000 +1100
@@ -846,6 +846,32 @@ int fdt_add_mem_rsv(void *fdt, uint64_t 
 int fdt_del_mem_rsv(void *fdt, int n);
 
 /**
+ * fdt_set_name - change the name of a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: structure block offset of a node
+ * @name: name to give the node
+ *
+ * fdt_set_name() replaces the name (including unit address, if any)
+ * of the given node with the given string.  NOTE: this function can't
+ * efficiently check if the new name is unique amongst the given
+ * node's siblings; results are undefined if this function is invoked
+ * with a name equal to one of the given node's siblings.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob
+ *		to contain the new name
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE, standard meanings
+ */
+int fdt_set_name(void *fdt, int nodeoffset, const char *name);
+
+/**
  * fdt_setprop - create or change a property
  * @fdt: pointer to the device tree blob
  * @nodeoffset: offset of the node whose property to change
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2007-12-19 10:52:12.000000000 +1100
+++ dtc/libfdt/fdt_rw.c	2008-01-11 14:45:27.000000000 +1100
@@ -252,6 +252,30 @@ static int _add_property(void *fdt, int 
 	return 0;
 }
 
+int fdt_set_name(void *fdt, int nodeoffset, const char *name)
+{
+	char *namep;
+	int oldlen, newlen;
+	int err;
+
+	if ((err = rw_check_header(fdt)))
+		return err;
+
+	namep = (char *)fdt_get_name(fdt, nodeoffset, &oldlen);
+	if (!namep)
+		return oldlen;
+
+	newlen = strlen(name);
+
+	err = _blob_splice_struct(fdt, namep, ALIGN(oldlen+1, FDT_TAGSIZE),
+				  ALIGN(newlen+1, FDT_TAGSIZE));
+	if (err)
+		return err;
+
+	memcpy(namep, name, newlen+1);
+	return 0;
+}
+
 int fdt_setprop(void *fdt, int nodeoffset, const char *name,
 		const void *val, int len)
 {
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-12-19 16:50:09.000000000 +1100
+++ dtc/tests/Makefile.tests	2008-01-11 14:34:11.000000000 +1100
@@ -8,7 +8,7 @@ LIB_TESTS_L = get_mem_rsv \
 	setprop_inplace nop_property nop_node \
 	sw_tree1 \
 	move_and_save mangle-layout \
-	open_pack rw_tree1 setprop del_property del_node \
+	open_pack rw_tree1 set_name setprop del_property del_node \
 	string_escapes references path-references \
 	dtbs_equal_ordered
 LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)
Index: dtc/tests/set_name.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/set_name.c	2008-01-11 14:52:17.000000000 +1100
@@ -0,0 +1,91 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_set_name()
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
+void check_set_name(void *fdt, const char *path, const char *newname)
+{
+	int offset;
+	const char *getname, *oldname;
+	int len, err;
+
+	oldname = strrchr(path, '/');
+	if (!oldname)
+		TEST_BUG();
+	oldname += 1;
+
+	offset = fdt_path_offset(fdt, path);
+	if (offset < 0)
+		FAIL("Couldn't find %s", path);
+
+	getname = fdt_get_name(fdt, offset, &len);
+	verbose_printf("fdt_get_name(%d) returns \"%s\" (len=%d)\n",
+		       offset, getname, len);
+	if (!getname)
+		FAIL("fdt_get_name(%d): %s", offset, fdt_strerror(len));
+
+	if (strcmp(getname, oldname) != 0)
+		FAIL("fdt_get_name(%s) returned \"%s\" instead of \"%s\"",
+		     path, getname, oldname);
+
+	if (len != strlen(getname))
+		FAIL("fdt_get_name(%s) returned length %d instead of %zd",
+		     path, len, strlen(getname));
+
+	err = fdt_set_name(fdt, offset, newname);
+	if (err)
+		FAIL("fdt_set_name(%d, \"%s\"): %s", offset, newname,
+		     fdt_strerror(err));
+
+	getname = fdt_get_name(fdt, offset, &len);
+	if (!getname)
+		FAIL("fdt_get_name(%d): %s", offset, fdt_strerror(len));
+
+	if (strcmp(getname, newname) != 0)
+		FAIL("fdt_get_name(%s) returned \"%s\" instead of \"%s\"",
+		     path, getname, newname);
+
+	if (len != strlen(getname))
+		FAIL("fdt_get_name(%s) returned length %d instead of %zd",
+		     path, len, strlen(getname));
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+	fdt = open_blob_rw(fdt);
+
+	check_set_name(fdt, "/subnode@1", "subnode@17");
+	check_set_name(fdt, "/subnode@2/subsubnode@0", "fred@0");
+	check_set_name(fdt, "/subnode@17/subsubnode", "something@0");
+
+	PASS();
+}
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-01-11 14:43:28.000000000 +1100
+++ dtc/tests/run_tests.sh	2008-01-11 14:43:35.000000000 +1100
@@ -69,6 +69,7 @@ tree1_tests_rw () {
     TREE=$1
 
     # Read-write tests
+    run_test set_name $TREE
     run_test setprop $TREE
     run_test del_property $TREE
     run_test del_node $TREE

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
