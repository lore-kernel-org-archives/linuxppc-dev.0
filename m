Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Nov 2007 09:52:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Add missing dependencies for tests
Message-ID: <20071112225258.GF1219@localhost.localdomain>
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

At present, the Makefiles will not rebuild trees.o or the dtb files
derived from it if testdata.h is updated.  This is incorrect, and is
because of missing dependency information.

This patch fixes the problem by making sure that dependency
information is generated from trees.S and dumptrees.c.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-11-12 17:57:11.000000000 +1100
+++ dtc/Makefile	2007-11-12 17:57:23.000000000 +1100
@@ -188,6 +188,10 @@ clean: libfdt_clean tests_clean
 	@$(VECHO) DEP $<
 	$(CC) $(CPPFLAGS) -MM -MG -MT "$*.o $@" $< > $@
 
+%.d: %.S
+	@$(VECHO) DEP $<
+	$(CC) $(CPPFLAGS) -MM -MG -MT "$*.o $@" $< > $@
+
 %.i:	%.c
 	@$(VECHO) CPP $@
 	$(CC) $(CPPFLAGS) -E $< > $@
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-11-12 17:56:29.000000000 +1100
+++ dtc/tests/Makefile.tests	2007-11-12 18:02:44.000000000 +1100
@@ -21,7 +21,8 @@ TESTS_TREES = $(TESTS_TREES_L:%=$(TESTS_
 
 TESTS_TARGETS = $(TESTS) $(TESTS_TREES)
 
-TESTS_DEPFILES = $(TESTS:%=%.d) $(TESTS_PREFIX)testutils.d
+TESTS_DEPFILES = $(TESTS:%=%.d) \
+	$(addprefix $(TESTS_PREFIX),testutils.d trees.d dumptrees.d)
 
 TESTS_CLEANFILES_L =  *.output vgcore.* *.dtb *.test.dts
 TESTS_CLEANFILES = $(TESTS_CLEANFILES_L:%=$(TESTS_PREFIX)%)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
