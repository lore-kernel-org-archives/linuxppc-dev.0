Return-Path: <dgibson@ozlabs.org>
Date: Tue, 6 Nov 2007 10:42:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: libfdt: Fix sw_tree1 testcase
Message-ID: <20071105234245.GA27067@localhost.localdomain>
References: <20071105053844.GC21064@localhost.localdomain>
	<E1Ip3bp-000260-Of@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1Ip3bp-000260-Of@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 05, 2007 at 09:11:25AM -0600, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > There is a bug in the sw_tree1 testcase / utility which puts two
> > "compatible" properties in one node in the output tree.  This patch
> > fixes the bug, and also adds a new test checking that the sw_tree1
> > output is equal to test_tree1.dtb as its supposed to be, which should
> > catch future errors of this type.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> This change appears to cause a test to fail.
> I've not looked into it beyond "make check failed":

Crud, I screwed up and gave you an intermediate version of the patch
which tried to do the same thing for rw_tree1.  For that to work, I'll
need to write a dtbs_equal_notordered test.

Corrected version below.

libfdt: Fix sw_tree1 testcase

There is a bug in the sw_tree1 testcase / utility which puts two
"compatible" properties in one node in the output tree.  This patch
fixes the bug, and also adds a new test checking that the sw_tree1
output is equal to test_tree1.dtb as its supposed to be, which should
catch future errors of this type.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-11-06 10:38:21.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-11-06 10:39:37.000000000 +1100
@@ -71,6 +71,7 @@
     run_test sw_tree1
     tree1_tests sw_tree1.test.dtb
     tree1_tests unfinished_tree1.test.dtb
+    run_test dtbs_equal_ordered test_tree1.dtb sw_tree1.test.dtb
 
     # fdt_move tests
     for tree in test_tree1.dtb sw_tree1.test.dtb unfinished_tree1.test.dtb; do
Index: dtc/tests/sw_tree1.c
===================================================================
--- dtc.orig/tests/sw_tree1.c	2007-11-05 16:59:13.000000000 +1100
+++ dtc/tests/sw_tree1.c	2007-11-06 10:39:37.000000000 +1100
@@ -64,7 +64,6 @@
 	CHECK(fdt_begin_node(fdt, "subsubnode"));
 	CHECK(fdt_property(fdt, "compatible", "subsubnode1\0subsubnode",
 			   23));
-	CHECK(fdt_property_string(fdt, "compatible", "subsubnode1\0"));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_end_node(fdt));
 	CHECK(fdt_end_node(fdt));


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
