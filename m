Return-Path: <dgibson@ozlabs.org>
Date: Wed, 11 Jun 2008 11:58:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Add support for binary includes.
Message-ID: <20080611015839.GB22012@yookeroo.seuss>
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<20080226003955.GA24382@localhost.localdomain>
	<7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>
	<483C4C04.9020408@freescale.com>
	<20080528235859.GA10260@yookeroo.seuss>
	<20080529000227.GB10260@yookeroo.seuss>
	<48404D83.4070108@freescale.com>
	<20080604041304.GD29085@yookeroo.seuss>
	<4846A60F.9020909@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4846A60F.9020909@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 04, 2008 at 09:26:23AM -0500, Jon Loeliger wrote:
> David Gibson wrote:
>
>> But as I said that can be dealt with in the future without breaking
>> compatibility.  Objection withdrawn.
>>
>
> And on that note, I officially implore Scott to
> re-submit his binary include patch!

Scott's original patch does still have some implementation details I
didn't like.  So in the interests of saving time, I've addressed some
of those, added a testcase, and and now resubmitting my revised
version of Scott's patch.

dtc: Add support for binary includes.

A property's data can be populated with a file's contents
as follows:

node {
	prop = /incbin/("path/to/data");
};

A subset of a file can be included by passing start and size parameters.
For example, to include bytes 8 through 23:

node {
	prop = /incbin/("path/to/data", 8, 16);
};

As with /include/, non-absolute paths are looked for in the directory
of the source file that includes them.

Implementation revised, and a testcase added by David Gibson

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2008-06-11 11:50:29.000000000 +1000
+++ dtc/data.c	2008-06-11 11:50:38.000000000 +1000
@@ -167,14 +167,29 @@
 	return d;
 }
 
-struct data data_copy_file(FILE *f, size_t len)
+struct data data_copy_file(FILE *f, size_t maxlen)
 {
-	struct data d;
+	struct data d = empty_data;
+
+	while (!feof(f) && (d.len < maxlen)) {
+		size_t chunksize, ret;
+
+		if (maxlen == -1)
+			chunksize = 4096;
+		else
+			chunksize = maxlen - d.len;
+
+		d = data_grow_for(d, chunksize);
+		ret = fread(d.val + d.len, 1, chunksize, f);
+
+		if (ferror(f))
+			die("Error reading file into data: %s", strerror(errno));
 
-	d = data_grow_for(empty_data, len);
+		if (d.len + ret < d.len)
+			die("Overflow reading file into data\n");
 
-	d.len = len;
-	fread(d.val, len, 1, f);
+		d.len += ret;
+	}
 
 	return d;
 }
Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2008-06-11 11:50:29.000000000 +1000
+++ dtc/dtc-lexer.l	2008-06-11 11:50:38.000000000 +1000
@@ -190,6 +190,13 @@
 			return DT_PROPNODENAME;
 		}
 
+"/incbin/"	{
+			yylloc.file = srcpos_file;
+			yylloc.first_line = yylineno;
+			DPRINT("Binary Include\n");
+			return DT_INCBIN;
+		}
+
 <*>[[:space:]]+	/* eat whitespace */
 
 <*>"/*"([^*]|\*+[^*/])*\*+"/"	{
Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2008-06-11 11:50:29.000000000 +1000
+++ dtc/dtc-parser.y	2008-06-11 11:50:38.000000000 +1000
@@ -21,6 +21,8 @@
 %locations
 
 %{
+#include <stdio.h>
+
 #include "dtc.h"
 #include "srcpos.h"
 
@@ -59,6 +61,7 @@
 %token <data> DT_STRING
 %token <labelref> DT_LABEL
 %token <labelref> DT_REF
+%token DT_INCBIN
 
 %type <data> propdata
 %type <data> propdataprefix
@@ -197,6 +200,34 @@
 		{
 			$$ = data_add_marker($1, REF_PATH, $2);
 		}
+	| propdataprefix DT_INCBIN '(' DT_STRING ',' addr ',' addr ')'
+		{
+			struct search_path path = { srcpos_file->dir, NULL, NULL };
+			struct dtc_file *file = dtc_open_file($4.val, &path);
+			struct data d = empty_data;
+
+			if ($6 != 0)
+				if (fseek(file->file, $6, SEEK_SET) != 0)
+					yyerrorf("Couldn't seek to offset %llu in \"%s\": %s",
+						 (unsigned long long)$6,
+						 $4.val, strerror(errno));
+
+			d = data_copy_file(file->file, $8);
+
+			$$ = data_merge($1, d);
+			dtc_close_file(file);
+		}
+	| propdataprefix DT_INCBIN '(' DT_STRING ')'
+		{
+			struct search_path path = { srcpos_file->dir, NULL, NULL };
+			struct dtc_file *file = dtc_open_file($4.val, &path);
+			struct data d = empty_data;
+
+			d = data_copy_file(file->file, -1);
+
+			$$ = data_merge($1, d);
+			dtc_close_file(file);
+		}
 	| propdata DT_LABEL
 		{
 			$$ = data_add_marker($1, LABEL, $2);
Index: dtc/tests/incbin.bin
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/incbin.bin	2008-06-11 11:50:38.000000000 +1000
@@ -0,0 +1 @@
+abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
\ No newline at end of file
Index: dtc/tests/incbin.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/incbin.c	2008-06-11 11:50:38.000000000 +1000
@@ -0,0 +1,75 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for string escapes in dtc
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
+#include <errno.h>
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "tests.h"
+#include "testdata.h"
+
+#define CHUNKSIZE	1024
+
+void *load_file(const char *name, int *len)
+{
+	FILE *f;
+	void *buf = NULL;
+	int bufsize = 0, n;
+
+	*len = 0;
+
+	f = fopen(name, "r");
+	if (!f)
+		FAIL("Couldn't open \"%s\": %s", name, strerror(errno));
+
+	while (!feof(f)) {
+		if (bufsize < (*len + CHUNKSIZE)) {
+			buf = xrealloc(buf, *len + CHUNKSIZE);
+			bufsize = *len + CHUNKSIZE;
+		}
+
+		n = fread(buf + *len, 1, CHUNKSIZE, f);
+		if (ferror(f))
+			FAIL("Error reading \"%s\": %s", name, strerror(errno));
+		*len += n;
+	}
+
+	return buf;
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt, *incbin;
+	int len;
+
+	test_init(argc, argv);
+
+	incbin = load_file("incbin.bin", &len);
+	fdt = load_blob_arg(argc, argv);
+
+	check_getprop(fdt, 0, "incbin", len, incbin);
+	check_getprop(fdt, 0, "incbin-partial", 17, incbin + 13);
+
+	PASS();
+}
Index: dtc/tests/incbin.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/incbin.dts	2008-06-11 11:50:38.000000000 +1000
@@ -0,0 +1,6 @@
+/dts-v1/;
+
+/ {
+	incbin = /incbin/("incbin.bin");
+	incbin-partial = /incbin/("incbin.bin", 13, 17);
+};
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2008-06-11 11:50:29.000000000 +1000
+++ dtc/tests/Makefile.tests	2008-06-11 11:50:38.000000000 +1000
@@ -9,7 +9,7 @@
 	sw_tree1 \
 	move_and_save mangle-layout nopulate \
 	open_pack rw_tree1 set_name setprop del_property del_node \
-	string_escapes references path-references boot-cpuid \
+	string_escapes references path-references boot-cpuid incbin \
 	dtbs_equal_ordered \
 	add_subnode_with_nops
 LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-06-11 11:50:38.000000000 +1000
+++ dtc/tests/run_tests.sh	2008-06-11 11:50:38.000000000 +1000
@@ -207,6 +207,10 @@
     run_dtc_test -I dts -O dtb -o dtc_comments-cmp.test.dtb comments-cmp.dts
     run_test dtbs_equal_ordered dtc_comments.test.dtb dtc_comments-cmp.test.dtb
 
+    # Check /incbin/ directive
+    run_dtc_test -I dts -O dtb -o incbin.test.dtb incbin.dts
+    run_test incbin incbin.test.dtb
+
     # Check boot_cpuid_phys handling
     run_dtc_test -I dts -O dtb -b 17 -o boot_cpuid.test.dtb empty.dts
     run_test boot-cpuid boot_cpuid.test.dtb 17


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
