Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 May 2008 13:10:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Fix some printf() format warnings when compiling 64-bit
Message-ID: <20080520031052.GL22279@yookeroo.seuss>
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

Currently, dtc generates a few gcc build warnings if built for a
64-bit target, due to the altered type of uint64_t and size_t.  This
patch fixes the warnings (without generating new warnings for 32-bit).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/dtbs_equal_ordered.c
===================================================================
--- dtc.orig/tests/dtbs_equal_ordered.c	2008-05-20 13:06:50.000000000 +1000
+++ dtc/tests/dtbs_equal_ordered.c	2008-05-20 13:07:41.000000000 +1000
@@ -49,7 +49,10 @@ void compare_mem_rsv(const void *fdt1, c
 		if ((addr1 != addr2) || (size1 != size2))
 			FAIL("Mismatch in reserve entry %d: "
 			     "(0x%llx, 0x%llx) != (0x%llx, 0x%llx)", i,
-			     addr1, size1, addr2, size2);
+			     (unsigned long long)addr1,
+			     (unsigned long long)size1,
+			     (unsigned long long)addr2,
+			     (unsigned long long)size2);
 	}
 }
 
Index: dtc/tests/references.c
===================================================================
--- dtc.orig/tests/references.c	2008-05-20 13:05:21.000000000 +1000
+++ dtc/tests/references.c	2008-05-20 13:05:53.000000000 +1000
@@ -38,7 +38,7 @@ void check_ref(const void *fdt, int node
 	if (!p)
 		FAIL("fdt_getprop(%d, \"ref\"): %s", node, fdt_strerror(len));
 	if (len != sizeof(*p))
-		FAIL("'ref' in node at %d has wrong size (%d instead of %d)",
+		FAIL("'ref' in node at %d has wrong size (%d instead of %zd)",
 		     node, len, sizeof(*p));
 	ref = fdt32_to_cpu(*p);
 	if (ref != checkref)
@@ -49,7 +49,7 @@ void check_ref(const void *fdt, int node
 	if (!p)
 		FAIL("fdt_getprop(%d, \"lref\"): %s", node, fdt_strerror(len));
 	if (len != sizeof(*p))
-		FAIL("'lref' in node at %d has wrong size (%d instead of %d)",
+		FAIL("'lref' in node at %d has wrong size (%d instead of %zd)",
 		     node, len, sizeof(*p));
 	ref = fdt32_to_cpu(*p);
 	if (ref != checkref)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
