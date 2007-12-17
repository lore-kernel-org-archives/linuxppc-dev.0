Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 16:39:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Don't build tests as part of "all"
Message-ID: <20071217053939.GE3477@localhost.localdomain>
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

Currently "make all" for dtc will build (but not run) the testcase
binaries.  This is a problem for cross compiles, because building the
tests will attempt to run the dumptrees utility on the host system,
which won't work if it's cross-compiled of course.

Although it would be possible to separately build host binaries,
there's not a lot of value in doing so since we don't have a facility
for cross-executing the testsuite anyway.

Therefore, remove the tests from the "all" target.  It will still, of
course, be build as a prerequisite to "make check" which will run the
testsuite.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-12-17 16:34:48.000000000 +1100
+++ dtc/Makefile	2007-12-17 16:34:57.000000000 +1100
@@ -46,7 +46,7 @@ else
 DEPTARGETS = $(filter-out $(NODEPTARGETS),$(MAKECMDGOALS))
 endif
 
-all: dtc ftdump libfdt tests
+all: dtc ftdump libfdt
 
 install: all
 	@$(VECHO) INSTALL

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
