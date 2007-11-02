Return-Path: <dgibson@ozlabs.org>
Date: Fri, 2 Nov 2007 14:40:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Further Makefile cleanups
Message-ID: <20071102034016.GH19839@localhost.localdomain>
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

Informed by the experience attempting to embed dtc into the kernel
tree, make further simplification of the Makefiles.  In particular
make the Makefile.dtc and Makefile.libfdt fragments truly minimal.

This change also stops linking dtc with libfdt, which it does not
need.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 Makefile               |   13 +++++++------
 Makefile.dtc           |   20 ++------------------
 libfdt/Makefile.libfdt |    6 ------
 tests/Makefile.tests   |   49 ++++++++++++++++++++++---------------------------
 4 files changed, 31 insertions(+), 57 deletions(-)

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-11-02 14:36:22.000000000 +1100
+++ dtc/Makefile	2007-11-02 14:36:43.000000000 +1100
@@ -17,7 +17,6 @@ CONFIG_LOCALVERSION =
 
 CPPFLAGS = -I libfdt
 CFLAGS = -Wall -g -Os
-LDFLAGS = -Llibfdt
 
 BISON = bison
 LEX = flex
@@ -138,15 +137,16 @@ LIBFDT_objdir = libfdt
 LIBFDT_srcdir = libfdt
 include libfdt/Makefile.libfdt
 
+LIBFDT_lib = $(LIBFDT_objdir)/libfdt.a
+
 .PHONY: libfdt
-libfdt: $(LIBFDT_LIB)
+libfdt: $(LIBFDT_lib)
 
-$(LIBFDT_LIB): $(addprefix libfdt/,$(LIBFDT_OBJS))
+$(LIBFDT_lib): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
 
 libfdt_clean:
 	@$(VECHO) CLEAN "(libfdt)"
 	rm -f $(addprefix libfdt/,$(STD_CLEANFILES))
-	rm -f $(addprefix libfdt/,$(LIBFDT_CLEANFILES))
 
 ifneq ($(DEPTARGETS),)
 -include $(LIBFDT_OBJS:%.o=$(LIBFDT_objdir)/%.d)
@@ -155,7 +155,8 @@ endif
 #
 # Testsuite rules
 #
-TESTS_PREFIX=tests/
+TESTS_srcdir = tests
+TESTS_objdir = tests
 include tests/Makefile.tests
 
 #
@@ -166,7 +167,7 @@ STD_CLEANFILES = *~ *.o *.d *.a *.i *.s 
 
 clean: libfdt_clean tests_clean
 	@$(VECHO) CLEAN
-	rm -f $(STD_CLEANFILES) $(DTC_CLEANFILES)
+	rm -f $(STD_CLEANFILES)
 	rm -f $(VERSION_FILE)
 	rm -f $(BIN)
 
Index: dtc/libfdt/Makefile.libfdt
===================================================================
--- dtc.orig/libfdt/Makefile.libfdt	2007-11-02 14:36:16.000000000 +1100
+++ dtc/libfdt/Makefile.libfdt	2007-11-02 14:36:24.000000000 +1100
@@ -4,11 +4,5 @@
 # be easily embeddable into other systems of Makefiles.
 #
 LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
-LIBFDT_INCLUDES = fdt.h libfdt.h
-LIBFDT_EXTRA = libfdt_internal.h
-LIBFDT_LIB = libfdt/libfdt.a
-
 LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
 
-$(LIBFDT_objdir)/$(LIBFDT_LIB): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
-
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-11-02 14:36:16.000000000 +1100
+++ dtc/tests/Makefile.tests	2007-11-02 14:36:24.000000000 +1100
@@ -1,4 +1,4 @@
-LIB_TESTS_L = get_mem_rsv \
+LIB_TESTS = get_mem_rsv \
 	root_node find_property subnode_offset path_offset \
 	get_name getprop get_path supernode_atdepth_offset parent_offset \
 	node_offset_by_prop_value \
@@ -9,50 +9,45 @@ LIB_TESTS_L = get_mem_rsv \
 	move_and_save mangle-layout \
 	open_pack rw_tree1 setprop del_property del_node \
 	string_escapes dtbs_equal_ordered
-LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)
+LIBTREE_TESTS = truncated_property
+ASM_DTBS = test_tree1.dtb
 
-LIBTREE_TESTS_L = truncated_property
-LIBTREE_TESTS = $(LIBTREE_TESTS_L:%=$(TESTS_PREFIX)%)
+TESTS_util_obj = $(TESTS_objdir)/testutils.o
+TESTS_tree_obj = $(TESTS_objdir)/trees.o
 
-TESTS = $(LIB_TESTS) $(LIBTREE_TESTS)
+TESTS_lib_exec = $(LIB_TESTS:%=$(TESTS_objdir)/%)
+TESTS_libtree_exec = $(LIBTREE_TESTS:%=$(TESTS_objdir)/%)
+TESTS_dumptrees_exec = $(TEST_objdir)/dumptrees
+TESTS_exec = $(TESTS_lib_exec) $(TESTS_libtree_exec) $(TESTS_dumptrees_exec)
 
-TESTS_TREES_L = test_tree1.dtb
-TESTS_TREES = $(TESTS_TREES_L:%=$(TESTS_PREFIX)%)
+TESTS_dtb = $(ASM_DTBS:%=$(TESTS_objdir)/%)
 
-TESTS_TARGETS = $(TESTS) $(TESTS_TREES)
-
-TESTS_DEPFILES = $(TESTS:%=%.d) $(TESTS_PREFIX)testutils.d
-
-TESTS_CLEANFILES_L =  *.output vgcore.* *.dtb
-TESTS_CLEANFILES = $(TESTS_CLEANFILES_L:%=$(TESTS_PREFIX)%)
-
-BIN += $(TESTS) $(TESTS_PREFIX)dumptrees
+BIN += $(TESTS_exec)
 
 .PHONY: tests
-tests:	$(TESTS) $(TESTS_TREES)
+tests:	$(TESTS_exec) $(TESTS_dtb)
 
-$(LIB_TESTS): %: $(TESTS_PREFIX)testutils.o $(LIBFDT_LIB)
+$(TESTS_lib_exec): %: $(TESTS_util_obj) $(LIBFDT_lib)
 
-$(LIBTREE_TESTS): %: $(TESTS_PREFIX)testutils.o $(TESTS_PREFIX)trees.o $(LIBFDT_LIB)
+$(TESTS_libtree_exec): %: $(TESTS_util_obj) $(TESTS_tree_obj) $(LIBFDT_lib)
 
-$(TESTS_PREFIX)dumptrees: $(TESTS_PREFIX)trees.o
+$(TESTS_dumptrees_exec): $(TESTS_tree_obj)
 
-$(TESTS_TREES): $(TESTS_PREFIX)dumptrees
+$(TESTS_dtb): $(TESTS_dumptrees_exec)
 	@$(VECHO) DUMPTREES
-	cd $(TESTS_PREFIX); ./dumptrees >/dev/null
+	cd $(TESTS_objdir); ./dumptrees >/dev/null
 
 tests_clean:
 	@$(VECHO) CLEAN "(tests)"
-	rm -f $(STD_CLEANFILES:%=$(TESTS_PREFIX)%)
-	rm -f $(TESTS_CLEANFILES)
+	rm -f $(STD_CLEANFILES:%=$(TESTS_objdir)/%)
+	rm -f $(TESTS_objdir)/*.dtb
 
 check:	tests dtc
-	cd $(TESTS_PREFIX); ./run_tests.sh
+	cd $(TESTS_objdir); ./run_tests.sh
 
 checkv:	tests dtc
-	cd $(TESTS_PREFIX); ./run_tests.sh -v
+	cd $(TESTS_objdir); ./run_tests.sh -v
 
 ifneq ($(DEPTARGETS),)
--include $(TESTS_DEPFILES)
+-include $(TESTS_exec:%=%.d) $(TESTS_util_obj:%.o=%.d) $(TESTS_tree_obj:%.o=%.d)
 endif
-
Index: dtc/Makefile.dtc
===================================================================
--- dtc.orig/Makefile.dtc	2007-11-02 14:36:16.000000000 +1100
+++ dtc/Makefile.dtc	2007-11-02 14:36:24.000000000 +1100
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
-DTC_OBJS = $(DTC_SRCS:%.c=%.o) $(DTC_GEN_SRCS:%.c=%.o)
-
-DTC_CLEANFILES = $(DTC_GEN_ALL)
-
-# We assume the containing Makefile system can do auto-dependencies for most
-# things, but we supply the dependencies on generated header files explicitly
-
-$(addprefix $(DTC_objdir)/,$(DTC_GEN_SRCS:%.c=%.o)): $(addprefix $(DTC_objdir)/,$(DTC_BISON_INCLUDES))
+DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.[ch]
+DTC_OBJS = $(DTC_SRCS:%.c=%.o) dtc-lexer.lex.o dtc-parser.tab.o

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
