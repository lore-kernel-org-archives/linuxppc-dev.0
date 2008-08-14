Return-Path: <galak@kernel.crashing.org>
Date: Thu, 14 Aug 2008 08:28:19 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: jdl@freescale.com, devicetree-discuss@ozlabs.org
Subject: [PATCH v3] libfdt: Add support for using aliases in fdt_path_offset()
Message-ID: <Pine.LNX.4.64.0808140827220.2701@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the path doesn't start with '/' check to see if it matches some alias
under "/aliases" and substitute the matching alias value in the path
and retry the lookup.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Simplify down the aliases.dts to only whats needed for the test.

- k

 libfdt/fdt_ro.c             |   21 ++++++++++++++-
 tests/Makefile.tests        |    2 +-
 tests/aliases.dts           |   21 +++++++++++++++
 tests/path_offset_aliases.c |   59 +++++++++++++++++++++++++++++++++++++++++++
 tests/run_tests.sh          |    4 +++
 5 files changed, 104 insertions(+), 3 deletions(-)
 create mode 100644 tests/aliases.dts
 create mode 100644 tests/path_offset_aliases.c

diff --git a/libfdt/fdt_ro.c b/libfdt/fdt_ro.c
index ebd1260..2f3ff48 100644
--- a/libfdt/fdt_ro.c
+++ b/libfdt/fdt_ro.c
@@ -139,8 +139,25 @@ int fdt_path_offset(const void *fdt, const char *path)

 	FDT_CHECK_HEADER(fdt);

-	if (*path != '/')
-		return -FDT_ERR_BADPATH;
+	/* see if we have an alias */
+	if (*path != '/') {
+		const char *q;
+		int aliasoffset = fdt_path_offset(fdt, "/aliases");
+
+		if (aliasoffset < 0)
+			return -FDT_ERR_BADPATH;
+
+		q = strchr(path, '/');
+		if (!q)
+			q = end;
+
+		p = fdt_getprop_namelen(fdt, aliasoffset, path, q - p, NULL);
+		if (!p)
+			return -FDT_ERR_BADPATH;
+		offset = fdt_path_offset(fdt, p);
+
+		p = q;
+	}

 	while (*p) {
 		const char *q;
diff --git a/tests/Makefile.tests b/tests/Makefile.tests
index 704c95d..44021b0 100644
--- a/tests/Makefile.tests
+++ b/tests/Makefile.tests
@@ -11,7 +11,7 @@ LIB_TESTS_L = get_mem_rsv \
 	open_pack rw_tree1 set_name setprop del_property del_node \
 	string_escapes references path-references boot-cpuid incbin \
 	dtbs_equal_ordered \
-	add_subnode_with_nops
+	add_subnode_with_nops path_offset_aliases
 LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)

 LIBTREE_TESTS_L = truncated_property
diff --git a/tests/aliases.dts b/tests/aliases.dts
new file mode 100644
index 0000000..39d88ff
--- /dev/null
+++ b/tests/aliases.dts
@@ -0,0 +1,21 @@
+/dts-v1/;
+
+/ {
+	aliases {
+		s1 = &sub1;
+		ss1 = &subsub1;
+		sss1 = &subsubsub1;
+	};
+
+	sub1: subnode@1 {
+		compatible = "subnode1";
+
+		subsub1: subsubnode {
+			compatible = "subsubnode1", "subsubnode";
+
+			subsubsub1: subsubsubnode {
+				compatible = "subsubsubnode1", "subsubsubnode";
+			};
+		};
+	};
+};
diff --git a/tests/path_offset_aliases.c b/tests/path_offset_aliases.c
new file mode 100644
index 0000000..191edd2
--- /dev/null
+++ b/tests/path_offset_aliases.c
@@ -0,0 +1,59 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_path_offset()
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
+ * Copyright 2008 Kumar Gala, Freescale Semiconductor, Inc.
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
+void check_alias(void *fdt, const char *full_path, const char *alias_path)
+{
+	int offset, offset_a;
+
+	offset = fdt_path_offset(fdt, full_path);
+	offset_a = fdt_path_offset(fdt, alias_path);
+
+	if (offset != offset_a)
+		FAIL("Mismatch between %s path_offset (%d) and %s path_offset alias (%d)",
+		     full_path, offset, alias_path, offset_a);
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
+	check_alias(fdt, "/subnode@1/subsubnode", "s1/subsubnode");
+	check_alias(fdt, "/subnode@1/subsubnode/subsubsubnode", "sss1");
+	check_alias(fdt, "/subnode@1/subsubnode/subsubsubnode", "ss1/subsubsubnode");
+	check_alias(fdt, "/subnode@1/subsubnode/subsubsubnode", "s1/subsubnode/subsubsubnode");
+
+	PASS();
+}
diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index 7bfc399..eb29462 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -214,6 +214,10 @@ dtc_tests () {
     run_dtc_test -I dts -O dtb -o dtc_comments-cmp.test.dtb comments-cmp.dts
     run_test dtbs_equal_ordered dtc_comments.test.dtb dtc_comments-cmp.test.dtb

+    # Check aliases support in fdt_path_offset
+    run_dtc_test -I dts -O dtb -o aliases.dtb aliases.dts
+    run_test path_offset_aliases aliases.dtb
+
     # Check /include/ directive
     run_dtc_test -I dts -O dtb -o includes.test.dtb include0.dts
     run_test dtbs_equal_ordered includes.test.dtb test_tree1.dtb
-- 
1.5.5.1
