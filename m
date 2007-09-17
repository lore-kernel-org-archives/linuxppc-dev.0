Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Sep 2007 15:42:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Consistently use big-endian property data in testcases
Message-ID: <20070917054236.GA9303@localhost.localdomain>
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

Flat device trees always have integers in their structure stored as
big-endian.  From this point of view, property values are
bags-of-bytes and any endianness is up to users of the device tree to
determine.

The libfdt testcases which use properties with integer values,
currently use native endian format for the architecture on which the
testcases are run.  This works ok for now, since both the creation and
checking of the example device trees happen in the same endianness.

This will become a problem, however, for tests of dtc which we want to
add in the nearish future.  dtc always uses big-endian format for
'cell' format data in properties; as it needs to in order to produce
powerpc-usable device trees when hosted on a little-endian
architecture.

This patch, therefore, changes the libfdt testsuite to use big-endian
format always for integer format data, in order to interoperate sanely
with future dtc testcases.  This also means that the example trees
created by the testsuite should now be byte-for-byte identical
regardless of dtc and libfdt's host platform, which is arguably an
advantage.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/testdata.h
===================================================================
--- dtc.orig/tests/testdata.h	2007-09-17 11:50:21.000000000 +1000
+++ dtc/tests/testdata.h	2007-09-17 15:41:10.000000000 +1000
@@ -1,5 +1,16 @@
-#define TEST_VALUE_1	0xdeadbeef
-#define TEST_VALUE_2	0xabcd1234
+#include <endian.h>
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+#define cell_to_fdt(x)	(x)
+#else
+/* We do this as a big hairy expression instead of using bswap_32()
+ * because we need it to work in asm as well as C. */
+#define cell_to_fdt(x)	((((x) >> 24) & 0xff) | (((x) >> 8) & 0xff00) \
+			 | (((x) << 8) & 0xff0000) | (((x) << 24) & 0xff000000))
+#endif
+
+#define TEST_VALUE_1	cell_to_fdt(0xdeadbeef)
+#define TEST_VALUE_2	cell_to_fdt(0xabcd1234)
 
 #define TEST_STRING_1	"hello world"
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
