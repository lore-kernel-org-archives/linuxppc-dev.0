Return-Path: <dgibson@ozlabs.org>
Date: Tue, 16 Oct 2007 16:42:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Improve support for string escapes
Message-ID: <20071016064202.GC9052@localhost.localdomain>
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

dtc supports the use of C-style escapes (\n, \t and so forth) in
string property definitions via the data_copy_escape_string()
function.  However, while it supports the most common escape
characters, it doesn't support the full set that C does, which is a
potential gotcha.

Worse, a bug in the lexer means that while data_copy_escape_string()
can handle the \" escape, a string with such an escape won't lex
correctly.

This patch fixes both problems, extending data_copy_escape_string() to
support the missing escapes, and fixing the regex for strings in the
lexer to handle internal escaped quotes.

This also adds a testcase for string escape functionality.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2007-10-16 16:29:37.000000000 +1000
+++ dtc/data.c	2007-10-16 16:29:37.000000000 +1000
@@ -150,12 +150,24 @@ struct data data_copy_escape_string(char
 		c = s[i++];
 		assert(c);
 		switch (c) {
+		case 'a':
+			q[d.len++] = '\a';
+			break;
+		case 'b':
+			q[d.len++] = '\b';
+			break;
 		case 't':
 			q[d.len++] = '\t';
 			break;
 		case 'n':
 			q[d.len++] = '\n';
 			break;
+		case 'v':
+			q[d.len++] = '\v';
+			break;
+		case 'f':
+			q[d.len++] = '\f';
+			break;
 		case 'r':
 			q[d.len++] = '\r';
 			break;
Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2007-10-16 16:29:37.000000000 +1000
+++ dtc/dtc-lexer.l	2007-10-16 16:38:03.000000000 +1000
@@ -69,7 +69,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			}
 		}
 
-\"[^"]*\"	{
+\"([^\\"]|\\.)*\"	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("String: %s\n", yytext);
Index: dtc/tests/testdata.h
===================================================================
--- dtc.orig/tests/testdata.h	2007-10-16 16:29:37.000000000 +1000
+++ dtc/tests/testdata.h	2007-10-16 16:29:37.000000000 +1000
@@ -24,6 +24,7 @@
 #define TEST_VALUE_2	cell_to_fdt(0xabcd1234)
 
 #define TEST_STRING_1	"hello world"
+#define TEST_STRING_2	"nastystring: \a\b\t\n\v\f\r\\\"\xff"
 
 #ifndef __ASSEMBLY__
 extern struct fdt_header _test_tree1;
Index: dtc/tests/escapes.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/escapes.dts	2007-10-16 16:29:37.000000000 +1000
@@ -0,0 +1,4 @@
+/ {
+	compatible = "test_string_escapes";
+	escape-str = "nastystring: \a\b\t\n\v\f\r\\\"\xff";
+};
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-10-16 16:29:37.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-10-16 16:30:13.000000000 +1000
@@ -104,6 +104,9 @@ dtc_tests () {
     run_test dtc.sh -f -I dts -O dtb -o dtc_tree1.test.dtb test_tree1.dts
     tree1_tests dtc_tree1.test.dtb
     tree1_tests_rw dtc_tree1.test.dtb
+
+    run_test dtc.sh -f -I dts -O dtb -o dtc_escapes.test.dtb escapes.dts
+    run_test string_escapes dtc_escapes.test.dtb
 }
 
 while getopts "vdt:" ARG ; do
Index: dtc/tests/string_escapes.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/string_escapes.c	2007-10-16 16:34:20.000000000 +1000
@@ -0,0 +1,42 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for strinc escapes in dtc
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
+int main(int argc, char *argv[])
+{
+	void *fdt;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+
+	check_getprop(fdt, 0, "escape-str",
+		      strlen(TEST_STRING_2)+1, TEST_STRING_2);
+
+	PASS();
+}
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-10-16 16:31:44.000000000 +1000
+++ dtc/tests/Makefile.tests	2007-10-16 16:32:41.000000000 +1000
@@ -7,7 +7,8 @@ LIB_TESTS_L = get_mem_rsv \
 	setprop_inplace nop_property nop_node \
 	sw_tree1 \
 	move_and_save \
-	open_pack rw_tree1 setprop del_property del_node
+	open_pack rw_tree1 setprop del_property del_node \
+	string_escapes
 LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)
 
 LIBTREE_TESTS_L = truncated_property

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
