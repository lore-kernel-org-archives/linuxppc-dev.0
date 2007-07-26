Return-Path: <dgibson@ozlabs.org>
Date: Thu, 26 Jul 2007 17:25:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>, linuxppc-dev@ozlabs.org
Subject: Re: DTC 1.0.0 Release Coming?
Message-ID: <20070726072523.GE1149@localhost.localdomain>
References: <E1IDjSy-0003eC-T4@jdl.com>
	<20070726030550.GA1149@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070726030550.GA1149@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 01:05:50PM +1000, David Gibson wrote:
> On Wed, Jul 25, 2007 at 11:12:00AM -0500, Jon Loeliger wrote:
> > Folks,
> > 
> > I'd like to make an official DTC Version 1.0.0 release soon!
> > To that end, I've published a repo on jdl.com with a v1.0.0-rc1
> > tag on it.  I anticipate some updates to the Documentation before
> > a final 1.0.0 release still.  However, if you have something
> > you would like to have be in The Real 1.0.0 release, please
> > let me know soon!
> 
> It would certainly be great to have a release, since dtc is becoming
> necessary for more and more kernel builds.
> 
> Only thing I'm not really happy with in the current release is the
> versioning stuff.  For starters, it always reports my builds as
> -dirty, even when they're not.  It also seems a bit hideously
> complicated for what it does.  I'd prefer to see something simpler
> using git-describe to derive the version strings directly from the git
> tags themselves.  Obviously we need some sort of cacheing mechanism to
> make the versioning work for tarball releases without the git history,
> but I think we can handle that with a suitable "make dist" target.
> 
> I'll see if I can make a patch or two in the next few days.

Well, here's a first cut at my proposed simpler versioning scheme.
This is *not* ready to merge.  It needs more testing and some more
thought on how to integrate it with a "make dist" target.

Still, provided for comment.

dtc: Simpler versioning

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-07-26 16:56:12.000000000 +1000
+++ dtc/Makefile	2007-07-26 17:13:30.000000000 +1000
@@ -1,54 +1,12 @@
 #
 # Device Tree Compiler
 #
-
-#
-# Version information will be constructed in this order:
-# EXTRAVERSION might be "-rc", for example.
-# LOCAL_VERSION is likely from command line.
-# CONFIG_LOCALVERSION from some future config system.
-#
-VERSION = 1
-PATCHLEVEL = 0
-SUBLEVEL = 0
-EXTRAVERSION =-rc1
-LOCAL_VERSION =
-CONFIG_LOCALVERSION = 
-
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
 CFLAGS = -Wall -g
 LDFLAGS = -Llibfdt
 
 BISON = bison
+GIT = git
 
 INSTALL = /usr/bin/install
 DESTDIR =
@@ -57,9 +15,6 @@ BINDIR = $(PREFIX)/bin
 LIBDIR = $(PREFIX)/lib
 INCLUDEDIR = $(PREFIX)/include
 
-#
-# Overall rules
-#
 ifdef V
 VECHO = :
 else
@@ -68,7 +23,7 @@ ARFLAGS = rc
 .SILENT:
 endif
 
-NODEPTARGETS = clean
+NODEPTARGETS = clean .git-manifest version.h
 ifeq ($(MAKECMDGOALS),)
 DEPTARGETS = all
 else
@@ -93,9 +48,6 @@ dtc-parser.tab.c dtc-parser.tab.h dtc-pa
 	@$(VECHO) ---- Expect 2 s/r and 2 r/r. ----
 	$(BISON) -d $<
 
-$(VERSION_FILE): Makefile FORCE
-	$(call filechk,version)
-
 lex.yy.c: dtc-lexer.l
 	@$(VECHO) LEX $@
 	$(LEX) $<
@@ -133,13 +85,28 @@ endif
 TESTS_PREFIX=tests/
 include tests/Makefile.tests
 
+#
+# Versioning rules
+#
+.git-manifest: gengitmanifest FORCE .git
+	@$(VECHO) GENGITMANIFEST
+	./gengitmanifest $@
+
+-include .git-manifest
+
+version.h: .git-manifest
+	@$(VECHO) GENLOCALVERSION $@
+	./genlocalversion $(GIT_COMMITTISH) $(GIT_DESCRIBE) $(GIT_MANIFEST_HASH) $(MANIFEST_FILES) > $@
+
+#
+# Overall rules
+#
 STD_CLEANFILES = *~ *.o *.d *.a *.i *.s core a.out
-GEN_CLEANFILES = $(VERSION_FILE)
 
 clean: libfdt_clean tests_clean
 	@$(VECHO) CLEAN
 	rm -f $(STD_CLEANFILES)
-	rm -f $(GEN_CLEANFILES)
+	rm -f version.h
 	rm -f *.tab.[ch] lex.yy.c *.output vgcore.*
 	rm -f $(BIN)
 
@@ -152,19 +119,6 @@ install: all
 	$(INSTALL) -d $(DESTDIR)$(INCLUDEDIR)
 	$(INSTALL) -m 644 $(LIBFDT_INCLUDES) $(DESTDIR)$(INCLUDEDIR)
 
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
Index: dtc/genlocalversion
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/genlocalversion	2007-07-26 16:56:18.000000000 +1000
@@ -0,0 +1,20 @@
+#! /bin/sh
+
+GIT_COMMITTISH="$1"
+GIT_DESCRIBE="$2"
+GIT_MANIFEST_HASH="$3"
+shift 3
+
+MANIFEST_HASH=$(cat "$@" | sha1sum | cut -f1 -d' ')
+
+if [ "$GIT_MANIFEST_HASH" = "$MANIFEST_HASH" ]; then
+    # Identical to a git committed version
+    DTC_VERSION="$GIT_DESCRIBE"
+else
+    # Locallly modified
+    DTC_VERSION="locally-modified-$MANIFEST_HASH"
+fi
+
+echo "#define DTC_VERSION \"$DTC_VERSION\""
+echo "#define DTC_GIT_COMMITTISH \"$GIT_COMMITTISH\""
+echo "#define DTC_MANIFEST_HASH \"$MANIFEST_HASH\""
Index: dtc/gengitmanifest
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/gengitmanifest	2007-07-26 16:56:18.000000000 +1000
@@ -0,0 +1,21 @@
+#! /bin/sh
+
+set -e
+
+catgitblobs () {
+    for f; do
+	git-cat-file blob HEAD:$f
+    done
+}
+
+exec > "$1"
+
+echo "GIT_COMMITTISH = $(git-rev-parse HEAD)"
+echo "GIT_DESCRIBE = $(git-describe)"
+
+FILES=$(git-ls-files)
+
+echo "MANIFEST_FILES = " $FILES
+echo "version.h: \$(MANIFEST_FILES)"
+
+echo "GIT_MANIFEST_HASH = $(catgitblobs $FILES | sha1sum | cut -f1 -d' ')"
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2007-07-26 16:56:12.000000000 +1000
+++ dtc/dtc.c	2007-07-26 16:56:18.000000000 +1000
@@ -21,7 +21,7 @@
 #include "dtc.h"
 #include "srcpos.h"
 
-#include "version_gen.h"
+#include "version.h"
 
 /*
  * Command line options
Index: dtc/scripts/setlocalversion
===================================================================
--- dtc.orig/scripts/setlocalversion	2007-07-26 16:56:12.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,22 +0,0 @@
-#!/bin/sh
-# Print additional version information for non-release trees.
-
-usage() {
-	echo "Usage: $0 [srctree]" >&2
-	exit 1
-}
-
-cd "${1:-.}" || usage
-
-# Check for git and a git repo.
-if head=`git rev-parse --verify HEAD 2>/dev/null`; then
-	# Do we have an untagged version?
-	if git name-rev --tags HEAD | grep -E '^HEAD[[:space:]]+(.*~[0-9]*|undefined)$' > /dev/null; then
-		printf '%s%s' -g `echo "$head" | cut -c1-8`
-	fi
-
-	# Are there uncommitted changes?
-	if git diff-index HEAD | read dummy; then
-		printf '%s' -dirty
-	fi
-fi


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
