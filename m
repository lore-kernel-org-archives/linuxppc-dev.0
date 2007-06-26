Return-Path: <dgibson@ozlabs.org>
Date: Tue, 26 Jun 2007 12:45:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Improve and better integrate dtc and libfdt Makefiles
Message-ID: <20070626024551.GG4383@localhost.localdomain>
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

This patch substantially revamps the dtc Makefiles, in particular
better integrating the Makefile for dtc proper with the Makefiles
imported from libfdt for libfdt and the shared testsuite.  Notable
changes:
	- No recursive make calls.  Instead subsidiary Makefiles are
included into the top-level Makefile so we get a complete dependency
information.
	- Common pattern rules, CFLAGS etc. shared between dtc, libfdt
and testsuite, rather than separate copies.
	- Vaguely Kbuild-like non-verbose mode used by default, which
makes warnings more prominent.
	- libfdt Makefile consists only of variable definitions and
helper rules, to make it more easily embeddable into other Makefile
systems.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/Makefile
===================================================================
--- dtc.orig/libfdt/Makefile	2007-06-26 11:55:00.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,64 +0,0 @@
-PREFIX = /usr/local
-TARGETLIBS = libfdt.a
-LIBOBJS = fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerror.o
-
-SOURCE = $(shell find . -maxdepth 1 ! -name version.h -a -name '*.[h]')
-SOURCE += *.c Makefile
-NODEPTARGETS=<clean>
-
-CPPFLAGS = -I.
-CFLAGS = -Wall -g
-
-LIBDIR = $(PREFIX)/$(LIB32)
-
-EXTRA_DIST = \
-	README \
-	HOWTO \
-	LGPL-2.1
-
-ifdef V
-VECHO = :
-else
-VECHO = echo "	"
-ARFLAGS = rc
-.SILENT:
-endif
-
-DEPFILES = $(LIBOBJS:%.o=%.d)
-
-all:	libs
-
-.PHONY:	libs
-
-libs:	$(TARGETLIBS)
-
-%.o: %.c
-	@$(VECHO) CC $@
-	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
-
-libfdt.a: $(LIBOBJS)
-	@$(VECHO) AR $@
-	$(AR) $(ARFLAGS) $@ $^
-
-%.i:	%.c
-	@$(VECHO) CPP $@
-	$(CC) $(CPPFLAGS) -E $< > $@
-
-%.s:	%.c
-	@$(VECHO) CC -S $@
-	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -S $<
-
-clean:
-	@$(VECHO) CLEAN
-	rm -f *~ *.o *.so *.a *.d *.i *.s core a.out $(VERSION)
-
-%.d: %.c
-	@$(CC) $(CPPFLAGS) -MM -MT "$*.o $@" $< > $@
-
-# Workaround: Don't build dependencies for certain targets
-#    When the include below is executed, make will use the %.d target above to
-# generate missing files.  For certain targets (clean, version.h, etc) we don't
-# need or want these dependency files, so don't include them in this case.
-ifeq (,$(findstring <$(MAKECMDGOALS)>,$(NODEPTARGETS)))
--include $(DEPFILES)
-endif
Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-06-26 11:55:00.000000000 +1000
+++ dtc/Makefile	2007-06-26 11:56:18.000000000 +1000
@@ -1,67 +1,115 @@
-TARGETS = dtc ftdump
+CPPFLAGS = -I libfdt
 CFLAGS = -Wall -g
+LDFLAGS = -Llibfdt
 
 BISON = bison
 
-DTC_OBJS = dtc.o flattree.o fstree.o data.o livetree.o \
-		srcpos.o treesource.o \
-		dtc-parser.tab.o lex.yy.o
+#
+# Overall rules
+#
+ifdef V
+VECHO = :
+else
+VECHO = echo "	"
+ARFLAGS = rc
+.SILENT:
+endif
+
+NODEPTARGETS = clean
+ifeq ($(MAKECMDGOALS),)
+DEPTARGETS = all
+else
+DEPTARGETS = $(filter-out $(NODEPTARGETS),$(MAKECMDGOALS))
+endif
+
+all: dtc ftdump libfdt tests
+
+STD_CLEANFILES = *~ *.o *.d *.a *.i *.s core a.out
+
+clean: libfdt_clean tests_clean
+	@$(VECHO) CLEAN
+	rm -f $(STD_CLEANFILES)
+	rm -f *.tab.[ch] lex.yy.c *.output vgcore.*
+	rm -f $(BIN)
+
+#
+# General rules
+#
+
+%.o: %.c
+	@$(VECHO) CC $@
+	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
+
+%.o: %.S
+	@$(VECHO) AS $@
+	$(CC) $(CPPFLAGS) $(AFLAGS) -D__ASSEMBLY__ -o $@ -c $<
 
-DEPFILES = $(DTC_OBJS:.o=.d)
-
-.PHONY: libfdt tests
+%.d: %.c
+	$(CC) $(CPPFLAGS) -MM -MG -MT "$*.o $@" $< > $@
 
-all: $(TARGETS) tests libfdt
+%.i:	%.c
+	@$(VECHO) CPP $@
+	$(CC) $(CPPFLAGS) -E $< > $@
+
+%.s:	%.c
+	@$(VECHO) CC -S $@
+	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -S $<
+
+%.a:
+	@$(VECHO) AR $@
+	$(AR) $(ARFLAGS) $@ $^
 
-dtc: $(DTC_OBJS)
+$(BIN): %:
+	@$(VECHO) LD $@
 	$(LINK.c) -o $@ $^
 
-ftdump:	ftdump.o
-	$(LINK.c) -o $@ $^
 
-libfdt:
-	cd libfdt && $(MAKE) all
+#
+# Rules for dtc proper
+#
+DTC_PROGS = dtc ftdump
+DTC_OBJS = dtc.o flattree.o fstree.o data.o livetree.o \
+		srcpos.o treesource.o \
+		dtc-parser.tab.o lex.yy.o
+DTC_DEPFILES = $(DTC_OBJS:%.o=%.d)
 
 dtc-parser.tab.c dtc-parser.tab.h dtc-parser.output: dtc-parser.y
+	@$(VECHO) BISON $@
 	$(BISON) -d $<
 
 lex.yy.c: dtc-lexer.l
+	@$(VECHO) LEX $@
 	$(LEX) $<
 
-lex.yy.o: lex.yy.c dtc-parser.tab.h
+BIN += dtc ftdump
 
-tests:	tests/all
-
-tests/%: libfdt
-	$(MAKE) -C tests $*
-
-check:	all
-	cd tests; ./run_tests.sh
-
-checkv:	all
-	cd tests; ./run_tests.sh -v
-
-func:	all
-	cd tests; ./run_tests.sh -t func
-
-funcv:	all
-	cd tests; ./run_tests.sh -t func -v
-
-stress:	all
-	cd tests; ./run_tests.sh -t stress
-
-stressv: all
-	cd tests; ./run_tests.sh -t stress -v
-
-clean:
-	rm -f *~ *.o a.out core $(TARGETS)
-	rm -f *.tab.[ch] lex.yy.c
-	rm -f *.i *.output vgcore.*
-	rm -f *.d
-	$(MAKE) -C libfdt clean
-	$(MAKE) -C tests clean
+dtc: $(DTC_OBJS)
 
-%.d: %.c
-	$(CC) $(CPPFLAGS) -MM -MG -MT "$*.o $@" $< > $@
+ftdump:	ftdump.o
 
--include $(DEPFILES)
+ifneq ($(DEPTARGETS),)
+-include $(DTC_DEPFILES)
+endif
+
+#
+# Rules for libfdt
+#
+LIBFDT_PREFIX = libfdt/
+include libfdt/Makefile.libfdt
+
+.PHONY: libfdt
+libfdt: $(LIBFDT_LIB)
+
+libfdt_clean:
+	@$(VECHO) CLEAN "(libfdt)"
+	rm -f $(LIBFDT_CLEANFILES)
+
+ifneq ($(DEPTARGETS),)
+-include $(LIBFDT_DEPFILES)
+endif
+
+#
+# Testsuite rules
+#
+TESTS_PREFIX=tests/
+include tests/Makefile.tests
Index: dtc/tests/Makefile
===================================================================
--- dtc.orig/tests/Makefile	2007-06-26 11:55:00.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,67 +0,0 @@
-DTC = ../dtc
-VG_DTC = valgrind --tool=memcheck ../dtc
-
-LIB_TESTS = root_node find_property subnode_offset path_offset getprop \
-	notfound \
-	setprop_inplace nop_property nop_node \
-	sw_tree1 \
-	move_and_save \
-	open_pack rw_tree1 setprop del_property del_node
-LIBTREE_TESTS = truncated_property
-TESTS = $(LIB_TESTS) $(LIBTREE_TESTS)
-UTILS = dumptrees
-
-TREES = test_tree1.dtb
-
-CFLAGS = -Wall -g
-CPPFLAGS = -I../libfdt
-LDFLAGS = -L../libfdt
-
-LIBFDT = ../libfdt/libfdt.a
-
-ifdef V
-VECHO = :
-else
-VECHO = echo "	"
-.SILENT:
-endif
-
-DEPFILES = $(TESTS:%=%.d) testutils.d
-
-check: all
-	./run_tests.sh
-
-all:	$(TESTS) $(TREES)
-
-%.o: %.c
-	@$(VECHO) CC $@
-	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
-
-%.o: %.S
-	@$(VECHO) AS $@
-	$(CC) -D__ASSEMBLY__ $(CPPFLAGS) -o $@ -c $<
-
-%: %.o
-	@$(VECHO) LD $@
-	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
-
-$(LIB_TESTS): %: testutils.o $(LIBFDT)
-
-$(LIBTREE_TESTS): %: testutils.o trees.o $(LIBFDT)
-
-dumptrees: %: trees.o
-
-$(TREES): dumptrees
-	@$(VECHO) DUMPTREES
-	./dumptrees >/dev/null
-
-clean:
-	rm -f $(TESTS)
-	rm -f *.dtb dumptrees
-	rm -f *~ *.d *.o a.out core
-	rm -f *.i *.output vgcore.*
-
-%.d: %.c
-	@$(CC) $(CPPFLAGS) -MM -MT "$*.o $@" $< > $@
-
--include $(DEPFILES)
Index: dtc/libfdt/Makefile.libfdt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/libfdt/Makefile.libfdt	2007-06-26 11:55:00.000000000 +1000
@@ -0,0 +1,19 @@
+# Makefile.libfdt
+#
+# This is not a complete Makefile of itself.  Instead, it is designed to
+# be easily embeddable into other systems of Makefiles.
+#
+
+LIBFDT_OBJS_L = fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerror.o
+LIBFDT_OBJS = $(LIBFDT_OBJS_L:%=$(LIBFDT_PREFIX)%)
+
+LIBFDT_LIB_L = libfdt.a
+LIBFDT_LIB = $(LIBFDT_LIB_L:%=$(LIBFDT_PREFIX)%)
+
+LIBFDT_CLEANFILES_L = *~ *.o *.d *.a $(LIBFDT_LIB) \
+	*.i *.s a.out core
+LIBFDT_CLEANFILES = $(LIBFDT_CLEANFILES_L:%=$(LIBFDT_PREFIX)%)
+
+$(LIBFDT_LIB): $(LIBFDT_OBJS)
+
+LIBFDT_DEPFILES = $(LIBFDT_OBJS:%.o=%.d)
Index: dtc/tests/Makefile.tests
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/Makefile.tests	2007-06-26 11:55:00.000000000 +1000
@@ -0,0 +1,65 @@
+LIB_TESTS_L = root_node find_property subnode_offset path_offset getprop \
+	notfound \
+	setprop_inplace nop_property nop_node \
+	sw_tree1 \
+	move_and_save \
+	open_pack rw_tree1 setprop del_property del_node
+LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)
+
+LIBTREE_TESTS_L = truncated_property
+LIBTREE_TESTS = $(LIBTREE_TESTS_L:%=$(TESTS_PREFIX)%)
+
+TESTS = $(LIB_TESTS) $(LIBTREE_TESTS)
+
+TESTS_TREES_L = test_tree1.dtb
+TESTS_TREES = $(TESTS_TREES_L:%=$(TESTS_PREFIX)%)
+
+TESTS_TARGETS = $(TESTS) $(TESTS_TREES)
+
+TESTS_DEPFILES = $(TESTS:%=%.d) $(TESTS_PREFIX)testutils.d
+
+TESTS_CLEANFILES_L =  *.output vgcore.* *.dtb
+TESTS_CLEANFILES = $(TESTS_CLEANFILES_L:%=$(TESTS_PREFIX)%)
+
+BIN += $(TESTS) $(TESTS_PREFIX)dumptrees
+
+.PHONY: tests
+tests:	$(TESTS) $(TESTS_TREES)
+
+$(LIB_TESTS): %: $(TESTS_PREFIX)testutils.o $(LIBFDT_LIB)
+
+$(LIBTREE_TESTS): %: $(TESTS_PREFIX)testutils.o $(TESTS_PREFIX)trees.o $(LIBFDT_LIB)
+
+$(TESTS_PREFIX)dumptrees: $(TESTS_PREFIX)trees.o
+
+$(TESTS_TREES): $(TESTS_PREFIX)dumptrees
+	@$(VECHO) DUMPTREES
+	cd $(TESTS_PREFIX); ./dumptrees >/dev/null
+
+tests_clean:
+	@$(VECHO) CLEAN "(tests)"
+	rm -f $(STD_CLEANFILES:%=$(TESTS_PREFIX)%)
+	rm -f $(TESTS_CLEANFILES)
+
+check:	tests
+	cd $(TESTS_PREFIX); ./run_tests.sh
+
+checkv:	tests
+	cd $(TESTS_PREFIX); ./run_tests.sh -v
+
+func:	tests
+	cd $(TESTS_PREFIX); ./run_tests.sh -t func
+
+funcv:	tests
+	cd $(TESTS_PREFIX); ./run_tests.sh -t func -v
+
+stress:	tests
+	cd $(TESTS_PREFIX); ./run_tests.sh -t stress
+
+stressv: tests
+	cd $(TESTS_PREFIX); ./run_tests.sh -t stress -v
+
+ifneq ($(DEPTARGETS),)
+-include $(TESTS_DEPFILES)
+endif
+

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
