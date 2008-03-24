Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Mar 2008 13:24:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Clean up included Makefile fragments
Message-ID: <20080324022452.GB29985@localhost.localdomain>
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

Currently the Makefile.dtc and Makefile.libfdt fragments include a
number of things that seemed like they might be useful for other
projects embedding the pieces, or for a make dist target.

Well, we have no make dist target, it's become fairly unclear that
these things would actually be useful to embedders (the kernel
certainly doesn't use them), and it's a bunch of stuff with no current
users.

This patch, therefore, removes a bunch of unused definitions from the
Makefile fragments.  It also removes a dependency declared in
Makefile.libfdt (of libfdt.a on the constituent .o files) which was
incorrect (wrong path), and if corrected would be redundant with the
similar dependency in the top-level makefile.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 Makefile               |    7 ++++---
 Makefile.dtc           |   18 +-----------------
 libfdt/Makefile.libfdt |    7 -------
 tests/Makefile.tests   |    4 ++--
 4 files changed, 7 insertions(+), 29 deletions(-)

Index: dtc/Makefile.dtc
===================================================================
--- dtc.orig/Makefile.dtc	2008-03-24 13:16:17.000000000 +1100
+++ dtc/Makefile.dtc	2008-03-24 13:24:06.000000000 +1100
@@ -5,21 +5,5 @@
 #
 DTC_SRCS = dtc.c flattree.c fstree.c data.c livetree.c treesource.c srcpos.c \
 	checks.c
-DTC_EXTRA = dtc.h srcpos.h
-DTC_LEXFILES = dtc-lexer.l
-DTC_BISONFILES = dtc-parser.y
-
-DTC_LEX_SRCS = $(DTC_LEXFILES:%.l=%.lex.c)
-DTC_BISON_SRCS = $(DTC_BISONFILES:%.y=%.tab.c)
-DTC_BISON_INCLUDES = $(DTC_BISONFILES:%.y=%.tab.h)
-
-DTC_GEN_SRCS = $(DTC_LEX_SRCS) $(DTC_BISON_SRCS)
-DTC_GEN_ALL = $(DTC_GEN_SRCS) $(DTC_BISON_INCLUDES)
+DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.c
 DTC_OBJS = $(DTC_SRCS:%.c=%.o) $(DTC_GEN_SRCS:%.c=%.o)
-
-DTC_CLEANFILES = $(DTC_GEN_ALL)
-
-# We assume the containing Makefile system can do auto-dependencies for most
-# things, but we supply the dependencies on generated header files explicitly
-
-$(addprefix $(DTC_objdir)/,$(DTC_GEN_SRCS:%.c=%.o)): $(addprefix $(DTC_objdir)/,$(DTC_BISON_INCLUDES))
Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2008-03-24 13:16:17.000000000 +1100
+++ dtc/Makefile	2008-03-24 13:17:58.000000000 +1100
@@ -53,7 +53,7 @@
 	$(INSTALL) -d $(DESTDIR)$(BINDIR)
 	$(INSTALL) -m 755 dtc $(DESTDIR)$(BINDIR)
 	$(INSTALL) -d $(DESTDIR)$(LIBDIR)
-	$(INSTALL) -m 644 $(LIBFDT_LIB) $(DESTDIR)$(LIBDIR)
+	$(INSTALL) -m 644 $(LIBFDT_lib) $(DESTDIR)$(LIBDIR)
 	$(INSTALL) -d $(DESTDIR)$(INCLUDEDIR)
 	$(INSTALL) -m 644 $(addprefix $(LIBFDT_srcdir)/,$(LIBFDT_INCLUDES)) $(DESTDIR)$(INCLUDEDIR)
 
@@ -135,12 +135,13 @@
 #
 LIBFDT_objdir = libfdt
 LIBFDT_srcdir = libfdt
+LIBFDT_lib = $(LIBFDT_objdir)/libfdt.a
 include $(LIBFDT_srcdir)/Makefile.libfdt
 
 .PHONY: libfdt
-libfdt: $(LIBFDT_LIB)
+libfdt: $(LIBFDT_lib)
 
-$(LIBFDT_LIB): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
+$(LIBFDT_lib): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
 
 libfdt_clean:
 	@$(VECHO) CLEAN "(libfdt)"
Index: dtc/libfdt/Makefile.libfdt
===================================================================
--- dtc.orig/libfdt/Makefile.libfdt	2008-03-24 13:16:17.000000000 +1100
+++ dtc/libfdt/Makefile.libfdt	2008-03-24 13:17:58.000000000 +1100
@@ -4,11 +4,4 @@
 # be easily embeddable into other systems of Makefiles.
 #
 LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
-LIBFDT_INCLUDES = fdt.h libfdt.h
-LIBFDT_EXTRA = libfdt_internal.h
-LIBFDT_LIB = libfdt/libfdt.a
-
 LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
-
-$(LIBFDT_objdir)/$(LIBFDT_LIB): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
-
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2008-03-24 13:16:17.000000000 +1100
+++ dtc/tests/Makefile.tests	2008-03-24 13:17:58.000000000 +1100
@@ -35,9 +35,9 @@
 .PHONY: tests
 tests:	$(TESTS) $(TESTS_TREES)
 
-$(LIB_TESTS): %: $(TESTS_PREFIX)testutils.o $(LIBFDT_LIB)
+$(LIB_TESTS): %: $(TESTS_PREFIX)testutils.o $(LIBFDT_lib)
 
-$(LIBTREE_TESTS): %: $(TESTS_PREFIX)testutils.o $(TESTS_PREFIX)trees.o $(LIBFDT_LIB)
+$(LIBTREE_TESTS): %: $(TESTS_PREFIX)testutils.o $(TESTS_PREFIX)trees.o $(LIBFDT_lib)
 
 $(TESTS_PREFIX)dumptrees: $(TESTS_PREFIX)trees.o
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
