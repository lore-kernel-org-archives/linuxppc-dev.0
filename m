Return-Path: <dgibson@ozlabs.org>
Date: Thu, 26 Jun 2008 11:03:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Address an assortment of portability problems
Message-ID: <20080626010349.GH308@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Benno Rice <benno@jeamland.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've recently worked with a FreeBSD developer, getting dtc and libfdt
working on FreeBSD.  This showed up a number of portability problems
in the dtc package which this patch addresses.  Changes are as
follows:

	- the parent_offset and supernode_atdepth_offset testcases
used the glibc extension functions strchrnul() and strndupa().  Those
are removed, using slightly longer coding with standard C functions
instead.

	- some other testcases had a #define _GNU_SOURCE for no
particular reason.  This is removed.

	- run_tests.sh has bash specific constructs removed, and the
interpreter changed to /bin/sh.  This apparently now runs fine on
FreeBSD's /bin/sh, and I've also tested it with both ash and dash.

	- convert-dtsv0-lexer.l has some extra #includes added.  These
must have been included indirectly with Linux and glibc, but aren't on
FreeBSD.

	- the endian handling functions in libfdt_env.h, based on
endian.h and byteswap.h are replaced with some portable open-coded
versions.  Unfortunately, these result in fairly crappy code when
compiled, but as far as I can determine there doesn't seem to be any
POSIX, SUS or de facto standard way of determining endianness at
compile time, nor standard names for byteswapping functions.

	- some more endian handling, from testdata.h using the
problematic endian.h is simply removed, since it wasn't actually being
used anyway.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 convert-dtsv0-lexer.l            |    5 +++++
 libfdt/libfdt_env.h              |   27 ++++++++++++++-------------
 tests/get_path.c                 |    2 --
 tests/parent_offset.c            |    9 +++++----
 tests/run_tests.sh               |   18 +++++++++---------
 tests/supernode_atdepth_offset.c |   12 +++++++-----
 tests/testdata.h                 |   11 -----------
 tests/testutils.c                |    2 +-
 8 files changed, 41 insertions(+), 45 deletions(-)

Index: dtc/tests/supernode_atdepth_offset.c
===================================================================
--- dtc.orig/tests/supernode_atdepth_offset.c	2008-06-26 10:40:59.000000000 +1000
+++ dtc/tests/supernode_atdepth_offset.c	2008-06-26 10:43:21.000000000 +1000
@@ -17,8 +17,6 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
  */
-#define _GNU_SOURCE
-
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -64,7 +62,7 @@
 
 	p = path;
 	for (i = 0; i < depth; i++)
-		p = strchrnul(p+1, '/');
+		p = p+1 + strcspn(p+1, "/");
 
 	return p - path;
 }
@@ -74,10 +72,14 @@
 {
 	int pdepth = path_depth(path);
 	char *superpath;
-	int nodeoffset, supernodeoffset, superpathoffset;
+	int nodeoffset, supernodeoffset, superpathoffset, pathprefixlen;
 	int nodedepth;
 
-	superpath = strndupa(path, path_prefix(path, depth));
+	pathprefixlen = path_prefix(path, depth);
+	superpath = alloca(pathprefixlen + 1);
+	strncpy(superpath, path, pathprefixlen);
+	superpath[pathprefixlen] = '\0';
+
 	verbose_printf("Path %s (%d), depth %d, supernode is %s\n",
 		       path, pdepth, depth, superpath);
 
Index: dtc/tests/get_path.c
===================================================================
--- dtc.orig/tests/get_path.c	2008-06-26 10:40:59.000000000 +1000
+++ dtc/tests/get_path.c	2008-06-26 10:43:21.000000000 +1000
@@ -17,8 +17,6 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
  */
-#define _GNU_SOURCE
-
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
Index: dtc/tests/parent_offset.c
===================================================================
--- dtc.orig/tests/parent_offset.c	2008-06-26 10:40:59.000000000 +1000
+++ dtc/tests/parent_offset.c	2008-06-26 10:43:21.000000000 +1000
@@ -17,8 +17,6 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
  */
-#define _GNU_SOURCE
-
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -45,9 +43,12 @@
 void check_path(struct fdt_header *fdt, const char *path)
 {
 	char *parentpath;
-	int nodeoffset, parentoffset, parentpathoffset;
+	int nodeoffset, parentoffset, parentpathoffset, pathparentlen;
 
-	parentpath = strndupa(path, path_parent_len(path));
+	pathparentlen = path_parent_len(path);
+	parentpath = alloca(pathparentlen + 1);
+	strncpy(parentpath, path, pathparentlen);
+	parentpath[pathparentlen] = '\0';
 
 	verbose_printf("Path: \"%s\"\tParent: \"%s\"\n", path, parentpath);
 
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-06-26 10:40:59.000000000 +1000
+++ dtc/tests/run_tests.sh	2008-06-26 10:43:21.000000000 +1000
@@ -1,6 +1,6 @@
-#! /bin/bash
+#! /bin/sh
 
-. tests.sh
+. ./tests.sh
 
 export QUIET_TEST=1
 
@@ -15,19 +15,19 @@
 tot_strange=0
 
 base_run_test() {
-    tot_tests=$[tot_tests + 1]
+    tot_tests=$((tot_tests + 1))
     if VALGRIND="$VALGRIND" "$@"; then
-	tot_pass=$[tot_pass + 1]
+	tot_pass=$((tot_pass + 1))
     else
 	ret="$?"
 	if [ "$ret" == "1" ]; then
-	    tot_config=$[tot_config + 1]
+	    tot_config=$((tot_config + 1))
 	elif [ "$ret" == "2" ]; then
-	    tot_fail=$[tot_fail + 1]
+	    tot_fail=$((tot_fail + 1))
 	elif [ "$ret" == "$VGCODE" ]; then
-	    tot_vg=$[tot_vg + 1]
+	    tot_vg=$((tot_vg + 1))
 	else
-	    tot_strange=$[tot_strange + 1]
+	    tot_strange=$((tot_strange + 1))
 	fi
 	exit 99
     fi
@@ -53,7 +53,7 @@
 	else
 	    ret="$?"
 	    if [ "$ret" -gt 127 ]; then
-		signame=$(kill -l $[ret - 128])
+		signame=$(kill -l $((ret - 128)))
 		FAIL "Killed by SIG$signame"
 	    else
 		FAIL "Returned error code $ret"
Index: dtc/tests/testutils.c
===================================================================
--- dtc.orig/tests/testutils.c	2008-06-26 10:40:59.000000000 +1000
+++ dtc/tests/testutils.c	2008-06-26 10:43:21.000000000 +1000
@@ -18,7 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
-#define _GNU_SOURCE /* for strsignal() */
+#define _GNU_SOURCE /* for strsignal() in glibc.  FreeBSD has it either way */
 
 #include <stdio.h>
 #include <stdlib.h>
Index: dtc/libfdt/libfdt_env.h
===================================================================
--- dtc.orig/libfdt/libfdt_env.h	2008-06-26 10:40:59.000000000 +1000
+++ dtc/libfdt/libfdt_env.h	2008-06-26 10:43:21.000000000 +1000
@@ -4,19 +4,20 @@
 #include <stddef.h>
 #include <stdint.h>
 #include <string.h>
-#include <endian.h>
-#include <byteswap.h>
 
-#if __BYTE_ORDER == __BIG_ENDIAN
-#define fdt32_to_cpu(x)		(x)
-#define cpu_to_fdt32(x)		(x)
-#define fdt64_to_cpu(x)		(x)
-#define cpu_to_fdt64(x)		(x)
-#else
-#define fdt32_to_cpu(x)		(bswap_32((x)))
-#define cpu_to_fdt32(x)		(bswap_32((x)))
-#define fdt64_to_cpu(x)		(bswap_64((x)))
-#define cpu_to_fdt64(x)		(bswap_64((x)))
-#endif
+#define _B(n)	((unsigned long long)((uint8_t *)&x)[n])
+static inline uint32_t fdt32_to_cpu(uint32_t x)
+{
+	return (_B(0) << 24) | (_B(1) << 16) | (_B(2) << 8) | _B(3);
+}
+#define cpu_to_fdt32(x) fdt32_to_cpu(x)
+
+static inline uint64_t fdt64_to_cpu(uint64_t x)
+{
+	return (_B(0) << 56) | (_B(1) << 48) | (_B(2) << 40) | (_B(3) << 32)
+		| (_B(4) << 24) | (_B(5) << 16) | (_B(6) << 8) | _B(7);
+}
+#define cpu_to_fdt64(x) fdt64_to_cpu(x)
+#undef _B
 
 #endif /* _LIBFDT_ENV_H */
Index: dtc/convert-dtsv0-lexer.l
===================================================================
--- dtc.orig/convert-dtsv0-lexer.l	2008-06-26 10:40:59.000000000 +1000
+++ dtc/convert-dtsv0-lexer.l	2008-06-26 10:43:21.000000000 +1000
@@ -28,9 +28,14 @@
 LABEL		[a-zA-Z_][a-zA-Z0-9_]*
 
 %{
+#include <string.h>
+#include <stdlib.h>
 #include <stdarg.h>
+
+#include <errno.h>
 #include <assert.h>
 #include <fnmatch.h>
+
 #include "srcpos.h"
 
 static int v1_tagged; /* = 0 */
Index: dtc/tests/testdata.h
===================================================================
--- dtc.orig/tests/testdata.h	2008-06-26 10:40:59.000000000 +1000
+++ dtc/tests/testdata.h	2008-06-26 10:43:21.000000000 +1000
@@ -1,14 +1,3 @@
-#include <endian.h>
-
-#if __BYTE_ORDER == __BIG_ENDIAN
-#define cell_to_fdt(x)	(x)
-#else
-/* We do this as a big hairy expression instead of using bswap_32()
- * because we need it to work in asm as well as C. */
-#define cell_to_fdt(x)	((((x) >> 24) & 0xff) | (((x) >> 8) & 0xff00) \
-			 | (((x) << 8) & 0xff0000) | (((x) << 24) & 0xff000000))
-#endif
-
 #ifdef __ASSEMBLY__
 #define ASM_CONST_LL(x)	(x)
 #else

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
