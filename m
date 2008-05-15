Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 May 2008 16:39:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Add program to convert dts files from v0 to v1
Message-ID: <20080515063912.GA30996@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a new utility program, convert-dtsv0, to the dtc
sources.  This program will convert dts files from v0 to v1,
preserving comments and spacing.  It also includes some heuristics to
guess an appropriate base to use in the v1 output (so it will use hex
for the contents of reg properties and decimal for clock-frequency
properties, for example).  They're limited and imperfect, but not
terrible.

The guts of the converter program is a modified version of the lexer
from dtc itself.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2008-05-15 13:08:38.000000000 +1000
+++ dtc/Makefile	2008-05-15 13:33:02.000000000 +1000
@@ -46,7 +46,7 @@
 DEPTARGETS = $(filter-out $(NODEPTARGETS),$(MAKECMDGOALS))
 endif
 
-all: dtc ftdump libfdt
+all: dtc ftdump convert-dtsv0 libfdt
 
 install: all
 	@$(VECHO) INSTALL
@@ -121,12 +121,16 @@
 -include $(DTC_OBJS:%.o=%.d)
 endif
 #
-# Rules for ftdump
+# Rules for ftdump & convert-dtsv0
 #
-BIN += ftdump
+BIN += ftdump convert-dtsv0
 
 ftdump:	ftdump.o
 
+convert-dtsv0: convert-dtsv0-lexer.lex.o srcpos.o
+	@$(VECHO) LD $@
+	$(LINK.c) -o $@ $^
+
 ifneq ($(DEPTARGETS),)
 -include ftdump.d
 endif
Index: dtc/convert-dtsv0-lexer.l
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/convert-dtsv0-lexer.l	2008-05-15 16:28:33.000000000 +1000
@@ -0,0 +1,260 @@
+/*
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005, 2008.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+%option noyywrap nounput stack
+
+%x INCLUDE
+%x BYTESTRING
+%x PROPNODENAME
+
+PROPNODECHAR	[a-zA-Z0-9,._+*#?@-]
+PATHCHAR	({PROPNODECHAR}|[/])
+LABEL		[a-zA-Z_][a-zA-Z0-9_]*
+
+%{
+#include <stdarg.h>
+#include <assert.h>
+#include <fnmatch.h>
+#include "srcpos.h"
+
+static int v1_tagged; /* = 0 */
+static int cbase = 16;
+static int saw_hyphen; /* = 0 */
+static unsigned long long last_val;
+static char *last_name; /* = NULL */
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static inline void __attribute__((noreturn)) die(char * str, ...)
+{
+	va_list ap;
+
+	va_start(ap, str);
+	fprintf(stderr, "FATAL ERROR: ");
+	vfprintf(stderr, str, ap);
+	exit(1);
+}
+
+static inline void *xmalloc(size_t len)
+{
+	void *new = malloc(len);
+
+	if (! new)
+		die("malloc() failed\n");
+
+	return new;
+}
+
+const struct {
+	const char *pattern;
+	int obase, width;
+} guess_table[] = {
+	{ "*-frequency", 10, 0 },
+	{ "num-*", 10, 0 },
+	{ "#*-cells", 10, 0 },
+	{ "*cache-line-size", 10, 0 },
+	{ "*cache-block-size", 10, 0 },
+	{ "*cache-size", 10, 0 },
+	{ "*cache-sets", 10, 0 },
+	{ "cell-index", 10, 0 },
+	{ "bank-width", 10, 0 },
+	{ "*-fifo-size", 10, 0 },
+	{ "*-frame-size", 10, 0 },
+	{ "*-channel", 10, 0 },
+	{ "current-speed", 10, 0 },
+	{ "phy-map", 16, 8 },
+	{ "dcr-reg", 16, 3 },
+	{ "reg", 16, 8 },
+	{ "ranges", 16, 8},
+};
+%}
+
+%%
+<*>"/include/"	{
+			ECHO;
+			yy_push_state(INCLUDE);
+		}
+
+<INCLUDE>\"[^"\n]*\"	{
+			ECHO;
+			yy_pop_state();
+		}
+
+
+<*>\"([^\\"]|\\.)*\"	ECHO;
+
+<*>"/dts-v1/"	{
+			die("Input dts file is already version 1\n");
+		}
+
+<*>"/memreserve/"	{
+			if (!v1_tagged) {
+				fprintf(yyout, "/dts-v1/;\n\n");
+				v1_tagged = 1;
+			}
+
+			ECHO;
+			BEGIN(INITIAL);
+		}
+
+<*>{LABEL}:		ECHO;
+
+<INITIAL>[bodh]# {
+			if (*yytext == 'b')
+				cbase = 2;
+			else if (*yytext == 'o')
+				cbase = 8;
+			else if (*yytext == 'd')
+				cbase = 10;
+			else
+				cbase = 16;
+		}
+
+<INITIAL>[0-9a-fA-F]+	{
+			unsigned long long val;
+			int obase = 16, width = 0;
+			int i;
+
+			val = strtoull(yytext, NULL, cbase);
+
+			if (saw_hyphen)
+				val = val - last_val + 1;
+
+			if (last_name) {
+				for (i = 0; i < ARRAY_SIZE(guess_table); i++)
+					if (fnmatch(guess_table[i].pattern,
+					    last_name, 0) == 0) {
+					    	obase = guess_table[i].obase;
+						width = guess_table[i].width;
+					}
+			} else {
+				obase = 16;
+				width = 16;
+			}
+
+			if (cbase != 16)
+				obase = cbase;
+
+			switch (obase) {
+			case 2:
+			case 16:
+				fprintf(yyout, "0x%0*llx", width, val);
+				break;
+			case 8:
+				fprintf(yyout, "0%0*llo", width, val);
+				break;
+			case 10:
+				fprintf(yyout, "%*llu", width, val);
+				break;
+			}
+
+			cbase = 16;
+			last_val = val;
+			saw_hyphen = 0;
+		}
+
+\&{LABEL}		ECHO;
+
+"&{/"{PATHCHAR}+\}	ECHO;
+
+<INITIAL>"&/"{PATHCHAR}+ fprintf(yyout, "&{/%s}", yytext + 2);
+
+<BYTESTRING>[0-9a-fA-F]{2} ECHO;
+
+<BYTESTRING>"]"	{
+			ECHO;
+			BEGIN(INITIAL);
+		}
+
+<PROPNODENAME>{PROPNODECHAR}+ {
+			ECHO;
+			last_name = strdup(yytext);
+			BEGIN(INITIAL);
+		}
+
+<*>[[:space:]]+		ECHO;
+
+<*>"/*"([^*]|\*+[^*/])*\*+"/" ECHO;
+
+<*>"//".*\n		ECHO;
+
+<*>-		{	/* Hack to convert old style memreserves */
+			saw_hyphen = 1;
+			fprintf(yyout, " ");
+		}
+
+<*>.		{
+			if (!v1_tagged) {
+				fprintf(yyout, "/dts-v1/;\n\n");
+				v1_tagged = 1;
+			}
+
+			ECHO;
+			if (yytext[0] == '[') {
+				BEGIN(BYTESTRING);
+			}
+			if ((yytext[0] == '{')
+			    || (yytext[0] == ';')) {
+				BEGIN(PROPNODENAME);
+			}
+		}
+
+%%
+static void usage(void)
+{
+	fprintf(stderr, "convert-dtsv0 <v0 dts file>...\n");
+	exit(3);
+}
+
+static void convert_file(const char *fname)
+{
+	const char suffix[] = "v1";
+	int len = strlen(fname);
+	char *newname;
+
+	newname = xmalloc(len + sizeof(suffix));
+	memcpy(newname, fname, len);
+	memcpy(newname + len, suffix, sizeof(suffix));
+
+	srcpos_file = dtc_open_file(fname, NULL);
+	yyin = srcpos_file->file;
+
+	yyout = fopen(newname, "w");
+	if (!yyout)
+		die("Couldn't open output file %s: %s\n",
+		    newname, strerror(errno));
+
+	while(yylex())
+		;
+}
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+	if (argc < 2)
+		usage();
+
+	for (i = 1; i < argc; i++) {
+		fprintf(stderr, "Converting %s from dts v0 to dts v1\n", argv[i]);
+		convert_file(argv[i]);
+	}
+
+	exit(0);
+}
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2008-05-15 13:58:38.000000000 +1000
+++ dtc/tests/Makefile.tests	2008-05-15 14:19:06.000000000 +1000
@@ -27,7 +27,7 @@
 TESTS_DEPFILES = $(TESTS:%=%.d) \
 	$(addprefix $(TESTS_PREFIX),testutils.d trees.d dumptrees.d)
 
-TESTS_CLEANFILES_L =  *.output vglog.* vgcore.* *.dtb *.test.dts tmp.*
+TESTS_CLEANFILES_L =  *.output vglog.* vgcore.* *.dtb *.test.dts *.dtsv1 tmp.*
 TESTS_CLEANFILES = $(TESTS_CLEANFILES_L:%=$(TESTS_PREFIX)%)
 
 BIN += $(TESTS) $(TESTS_PREFIX)dumptrees
@@ -50,13 +50,13 @@
 	rm -f $(STD_CLEANFILES:%=$(TESTS_PREFIX)%)
 	rm -f $(TESTS_CLEANFILES)
 
-check:	tests dtc
+check:	tests dtc convert-dtsv0
 	cd $(TESTS_PREFIX); ./run_tests.sh
 
-checkm: tests dtc
+checkm: tests dtc convert-dtsv0
 	cd $(TESTS_PREFIX); ./run_tests.sh -m 2>&1 | tee vglog.$$$$
 
-checkv:	tests dtc
+checkv:	tests dtc convert-dtsv0
 	cd $(TESTS_PREFIX); ./run_tests.sh -v
 
 ifneq ($(DEPTARGETS),)
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-05-15 13:46:24.000000000 +1000
+++ dtc/tests/run_tests.sh	2008-05-15 14:22:15.000000000 +1000
@@ -72,6 +72,13 @@
     base_run_test wrap_test $VALGRIND $DTC "$@"
 }
 
+CONVERT=../convert-dtsv0
+
+run_convert_test () {
+    echo -n "convert-dtsv0 $@:	"
+    base_run_test wrap_test $VALGRIND $CONVERT "$@"
+}
+
 tree1_tests () {
     TREE=$1
 
@@ -260,6 +267,21 @@
     run_sh_test dtc-fatal.sh -I fs -O dtb nosuchfile
 }
 
+convert_tests () {
+    V0_DTS="test_tree1_dts0.dts references_dts0.dts empty.dts escapes.dts \
+	test01.dts label01.dts"
+    for dts in $V0_DTS; do
+	run_dtc_test -I dts -O dtb -o cvtraw_$dts.test.dtb $dts
+	run_dtc_test -I dts -O dts -o cvtdtc_$dts.test.dts $dts
+	run_dtc_test -I dts -O dtb -o cvtdtc_$dts.test.dtb cvtdtc_$dts.test.dts
+	run_convert_test $dts
+	run_dtc_test -I dts -O dtb -o cvtcvt_$dts.test.dtb ${dts}v1
+
+	run_wrap_test cmp cvtraw_$dts.test.dtb cvtdtc_$dts.test.dtb
+	run_wrap_test cmp cvtraw_$dts.test.dtb cvtcvt_$dts.test.dtb
+    done
+}
+
 while getopts "vt:m" ARG ; do
     case $ARG in
 	"v")
@@ -275,7 +297,7 @@
 done
 
 if [ -z "$TESTSETS" ]; then
-    TESTSETS="libfdt dtc"
+    TESTSETS="libfdt dtc convert"
 fi
 
 # Make sure we don't have stale blobs lying around
@@ -289,6 +311,9 @@
 	"dtc")
 	    dtc_tests
 	    ;;
+	"convert")
+	    convert_tests
+	    ;;
     esac
 done
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
