Return-Path: <dgibson@ozlabs.org>
Date: Wed, 3 Oct 2007 15:59:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Refactor Makefiles
Message-ID: <20071003055933.GE18978@localhost.localdomain>
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

This patch makes a number of Makefile cleanups and improvements:
	- We use more generic rules to invoke flex and bison, which is
useful for some of the other changes.
	- We use the name dtc-lexer.lex.c for the flex output, instead
of the default lex.yy.c.  That means less potential for confusion if
dtc is embedded into other projects (e.g. the kernel).
	- We separate out a Makefile.dtc designed for embedding into
other projects, analagous to Makefile.libfdt.
	- Makefile.libfdt is cleaned up to be more useful based on
some actual trial runs of embedding libfdt in the kernel bootwrapper.
	- Versioning related rules and variables are collected into
one place in the Makefile.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-09-27 14:08:05.000000000 +1000
+++ dtc/Makefile	2007-09-27 14:32:49.000000000 +1000
@@ -15,40 +15,12 @@ EXTRAVERSION =
 LOCAL_VERSION =
 CONFIG_LOCALVERSION =
 
-DTC_VERSION = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
-VERSION_FILE = version_gen.h
-
-CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
-	  else if [ -x /bin/bash ]; then echo /bin/bash; \
-	  else echo sh; fi ; fi)
-
-nullstring :=
-space	:= $(nullstring) # end of line
-
-localver_config = $(subst $(space),, $(string) \
-			      $(patsubst "%",%,$(CONFIG_LOCALVERSION)))
-
-localver_cmd = $(subst $(space),, $(string) \
-			      $(patsubst "%",%,$(LOCALVERSION)))
-
-localver_scm = $(shell $(CONFIG_SHELL) ./scripts/setlocalversion)
-localver_full  = $(localver_config)$(localver_cmd)$(localver_scm)
-
-dtc_version = $(DTC_VERSION)$(localver_full)
-
-#
-# Contents of the generated version file.
-#
-define filechk_version
-	(echo "#define DTC_VERSION \"DTC $(dtc_version)\""; )
-endef
-
-
 CPPFLAGS = -I libfdt
 CFLAGS = -Wall -g -Os
 LDFLAGS = -Llibfdt
 
 BISON = bison
+LEX = flex
 
 INSTALL = /usr/bin/install
 DESTDIR =
@@ -77,52 +49,107 @@ endif
 
 all: dtc ftdump libfdt tests
 
+install: all
+	@$(VECHO) INSTALL
+	$(INSTALL) -d $(DESTDIR)$(BINDIR)
+	$(INSTALL) -m 755 dtc $(DESTDIR)$(BINDIR)
+	$(INSTALL) -d $(DESTDIR)$(LIBDIR)
+	$(INSTALL) -m 644 $(LIBFDT_LIB) $(DESTDIR)$(LIBDIR)
+	$(INSTALL) -d $(DESTDIR)$(INCLUDEDIR)
+	$(INSTALL) -m 644 $(LIBFDT_INCLUDES) $(DESTDIR)$(INCLUDEDIR)
+
 #
-# Rules for dtc proper
+# Rules for versioning
 #
-DTC_PROGS = dtc ftdump
-DTC_OBJS = dtc.o flattree.o fstree.o data.o livetree.o \
-		srcpos.o treesource.o \
-		dtc-parser.tab.o lex.yy.o
-DTC_DEPFILES = $(DTC_OBJS:%.o=%.d)
 
-BIN += dtc ftdump
+DTC_VERSION = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
+VERSION_FILE = version_gen.h
 
-dtc-parser.tab.c dtc-parser.tab.h dtc-parser.output: dtc-parser.y
-	@$(VECHO) BISON $@
-	@$(VECHO) ---- Expect 2 s/r and 2 r/r. ----
-	$(BISON) -d $<
+CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
+	  else if [ -x /bin/bash ]; then echo /bin/bash; \
+	  else echo sh; fi ; fi)
+
+nullstring :=
+space	:= $(nullstring) # end of line
+
+localver_config = $(subst $(space),, $(string) \
+			      $(patsubst "%",%,$(CONFIG_LOCALVERSION)))
+
+localver_cmd = $(subst $(space),, $(string) \
+			      $(patsubst "%",%,$(LOCALVERSION)))
+
+localver_scm = $(shell $(CONFIG_SHELL) ./scripts/setlocalversion)
+localver_full  = $(localver_config)$(localver_cmd)$(localver_scm)
+
+dtc_version = $(DTC_VERSION)$(localver_full)
+
+# Contents of the generated version file.
+define filechk_version
+	(echo "#define DTC_VERSION \"DTC $(dtc_version)\""; )
+endef
+
+define filechk
+	set -e;					\
+	echo '	CHK $@';			\
+	mkdir -p $(dir $@);			\
+	$(filechk_$(1)) < $< > $@.tmp;		\
+	if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
+		rm -f $@.tmp;			\
+	else					\
+		echo '	UPD $@';		\
+		mv -f $@.tmp $@;		\
+	fi;
+endef
 
 $(VERSION_FILE): Makefile FORCE
 	$(call filechk,version)
 
-lex.yy.c: dtc-lexer.l
-	@$(VECHO) LEX $@
-	$(LEX) $<
+#
+# Rules for dtc proper
+#
+include Makefile.dtc
+
+BIN += dtc
+
+# This stops make from generating the lex and bison output during
+# auto-dependency computation, but throwing them away as an
+# intermediate target and building them again "for real"
+.SECONDARY: $(DTC_GEN_SRCS)
 
 dtc: $(DTC_OBJS)
 
+ifneq ($(DEPTARGETS),)
+-include $(DTC_OBJS:%.o=%.d)
+endif
+#
+# Rules for ftdump
+#
+BIN += ftdump
+
 ftdump:	ftdump.o
 
 ifneq ($(DEPTARGETS),)
--include $(DTC_DEPFILES)
+-include ftdump.d
 endif
-
 #
 # Rules for libfdt
 #
-LIBFDT_PREFIX = libfdt/
+LIBFDT_objdir = libfdt
+LIBFDT_srcdir = libfdt
 include libfdt/Makefile.libfdt
 
 .PHONY: libfdt
 libfdt: $(LIBFDT_LIB)
 
+$(LIBFDT_LIB): $(addprefix libfdt/,$(LIBFDT_OBJS))
+
 libfdt_clean:
 	@$(VECHO) CLEAN "(libfdt)"
-	rm -f $(LIBFDT_CLEANFILES)
+	rm -f $(addprefix libfdt/,$(STD_CLEANFILES))
+	rm -f $(addprefix libfdt/,$(LIBFDT_CLEANFILES))
 
 ifneq ($(DEPTARGETS),)
--include $(LIBFDT_DEPFILES)
+-include $(LIBFDT_OBJS:%.o=%.d)
 endif
 
 #
@@ -131,38 +158,18 @@ endif
 TESTS_PREFIX=tests/
 include tests/Makefile.tests
 
-STD_CLEANFILES = *~ *.o *.d *.a *.i *.s core a.out
-GEN_CLEANFILES = $(VERSION_FILE)
+#
+# Clean rules
+#
+STD_CLEANFILES = *~ *.o *.d *.a *.i *.s core a.out vgcore.* \
+	*.tab.[ch] *.lex.c *.output
 
 clean: libfdt_clean tests_clean
 	@$(VECHO) CLEAN
-	rm -f $(STD_CLEANFILES)
-	rm -f $(GEN_CLEANFILES)
-	rm -f *.tab.[ch] lex.yy.c *.output vgcore.*
+	rm -f $(STD_CLEANFILES) $(DTC_CLEANFILES)
+	rm -f $(VERSION_FILE)
 	rm -f $(BIN)
 
-install: all
-	@$(VECHO) INSTALL
-	$(INSTALL) -d $(DESTDIR)$(BINDIR)
-	$(INSTALL) -m 755 dtc $(DESTDIR)$(BINDIR)
-	$(INSTALL) -d $(DESTDIR)$(LIBDIR)
-	$(INSTALL) -m 644 $(LIBFDT_LIB) $(DESTDIR)$(LIBDIR)
-	$(INSTALL) -d $(DESTDIR)$(INCLUDEDIR)
-	$(INSTALL) -m 644 $(LIBFDT_INCLUDES) $(DESTDIR)$(INCLUDEDIR)
-
-define filechk
-	set -e;					\
-	echo '	CHK $@';			\
-	mkdir -p $(dir $@);			\
-	$(filechk_$(1)) < $< > $@.tmp;		\
-	if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
-		rm -f $@.tmp;			\
-	else					\
-		echo '	UPD $@';		\
-		mv -f $@.tmp $@;		\
-	fi;
-endef
-
 #
 # Generic compile rules
 #
@@ -193,4 +200,12 @@ endef
 	@$(VECHO) AR $@
 	$(AR) $(ARFLAGS) $@ $^
 
+%.lex.c: %.l
+	@$(VECHO) LEX $@
+	$(LEX) -o $@ $<
+
+%.tab.c %.tab.h %.output: %.y
+	@$(VECHO) BISON $@
+	$(BISON) -d $<
+
 FORCE:
Index: dtc/Makefile.dtc
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/Makefile.dtc	2007-09-27 14:21:17.000000000 +1000
@@ -0,0 +1,24 @@
+# Makefile.dtc
+#
+# This is not a complete Makefile of itself.  Instead, it is designed to
+# be easily embeddable into other systems of Makefiles.
+#
+DTC_SRCS = dtc.c flattree.c fstree.c data.c livetree.c treesource.c srcpos.c
+DTC_EXTRA = dtc.h srcpos.h
+DTC_LEXFILES = dtc-lexer.l
+DTC_BISONFILES = dtc-parser.y
+
+DTC_LEX_SRCS = $(DTC_LEXFILES:%.l=%.lex.c)
+DTC_BISON_SRCS = $(DTC_BISONFILES:%.y=%.tab.c)
+DTC_BISON_INCLUDES = $(DTC_BISONFILES:%.y=%.tab.h)
+
+DTC_GEN_SRCS = $(DTC_LEX_SRCS) $(DTC_BISON_SRCS)
+DTC_GEN_ALL = $(DTC_GEN_SRCS) $(DTC_BISON_INCLUDES)
+DTC_OBJS = $(DTC_SRCS:%.c=%.o) $(DTC_GEN_SRCS:%.c=%.o)
+
+DTC_CLEANFILES = $(DTC_GEN_ALL)
+
+# We assume the containing Makefile system can do auto-dependencies for most
+# things, but we supply the dependencies on generated header files explicitly
+
+$(addprefix $(DTC_objdir)/,$(DTC_GEN_SRCS:%.c=%.o)): $(addprefix $(DTC_objdir)/,$(DTC_BISON_INCLUDES))
Index: dtc/libfdt/Makefile.libfdt
===================================================================
--- dtc.orig/libfdt/Makefile.libfdt	2007-09-27 14:08:05.000000000 +1000
+++ dtc/libfdt/Makefile.libfdt	2007-09-27 14:14:30.000000000 +1000
@@ -3,19 +3,12 @@
 # This is not a complete Makefile of itself.  Instead, it is designed to
 # be easily embeddable into other systems of Makefiles.
 #
-LIBFDT_OBJS_L = fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerror.o
-LIBFDT_OBJS = $(LIBFDT_OBJS_L:%=$(LIBFDT_PREFIX)%)
+LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
+LIBFDT_INCLUDES = fdt.h libfdt.h
+LIBFDT_EXTRA = libfdt_internal.h
+LIBFDT_LIB = libfdt/libfdt.a
 
-LIBFDT_LIB_L = libfdt.a
-LIBFDT_LIB = $(LIBFDT_LIB_L:%=$(LIBFDT_PREFIX)%)
+LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
 
-LIBFDT_INCLUDES_L = fdt.h libfdt.h
-LIBFDT_INCLUDES = $(LIBFDT_INCLUDES_L:%=$(LIBFDT_PREFIX)%)
+$(LIBFDT_objdir)/$(LIBFDT_LIB): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
 
-LIBFDT_CLEANFILES_L = *~ *.o *.d *.a $(LIBFDT_LIB) \
-	*.i *.s a.out core
-LIBFDT_CLEANFILES = $(LIBFDT_CLEANFILES_L:%=$(LIBFDT_PREFIX)%)
-
-$(LIBFDT_LIB): $(LIBFDT_OBJS)
-
-LIBFDT_DEPFILES = $(LIBFDT_OBJS:%.o=%.d)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
