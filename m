Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8B16FDDED0
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 02:44:46 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] kbuild: New 'cc-fullversion' macro
Date: Sat, 19 May 2007 18:49:07 +0200
Message-Id: <11795933481264-git-send-email-segher@kernel.crashing.org>
Message-Id: <f7ff5aadda1b2962d6c45123ff944e9af6879306.1179593209.git.segher@kernel.crashing.org>
Cc: sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Prints a six-digit string including the GCC patchlevel.  Also fix
the 'usage' comment for cc-version.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 scripts/Kbuild.include |    7 ++++++-
 scripts/gcc-version.sh |   15 ++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 06c1a37..677bc6c 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -100,9 +100,14 @@ cc-option-align = $(subst -functions=0,,\
 	$(call cc-option,-falign-functions=0,-malign-functions=0))
 
 # cc-version
-# Usage gcc-ver := $(call cc-version,$(CC))
+# Usage gcc-ver := $(call cc-version)
 cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
 
+# cc-fullversion
+# Usage gcc-ver := $(call cc-fullversion)
+cc-fullversion = $(shell $(CONFIG_SHELL) \
+	$(srctree)/scripts/gcc-version.sh -p $(CC))
+
 # cc-ifversion
 # Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
 cc-ifversion = $(shell [ $(call cc-version, $(CC)) $(1) $(2) ] && echo $(3))
diff --git a/scripts/gcc-version.sh b/scripts/gcc-version.sh
index bb4fbea..8a1d187 100644
--- a/scripts/gcc-version.sh
+++ b/scripts/gcc-version.sh
@@ -1,14 +1,23 @@
 #!/bin/sh
 #
-# gcc-version gcc-command
+# gcc-version [-p] gcc-command
 #
 # Prints the gcc version of `gcc-command' in a canonical 4-digit form
 # such as `0295' for gcc-2.95, `0303' for gcc-3.3, etc.
 #
+# With the -p option, prints the patchlevel as well, for example `029503' for
+# gcc-2.95.3, `030301' for gcc-3.3.1, etc.
+#
+
+if [ $1 = "-p" ] ; then with_patchlevel=1; shift; fi
 
 compiler="$*"
 
 MAJOR=$(echo __GNUC__ | $compiler -E -xc - | tail -n 1)
 MINOR=$(echo __GNUC_MINOR__ | $compiler -E -xc - | tail -n 1)
-printf "%02d%02d\\n" $MAJOR $MINOR
-
+if [ "x$with_patchlevel" != "x" ] ; then
+	PATCHLEVEL=$(echo __GNUC_PATCHLEVEL__ | $compiler -E -xc - | tail -n 1)
+	printf "%02d%02d%02d\\n" $MAJOR $MINOR $PATCHLEVEL
+else
+	printf "%02d%02d\\n" $MAJOR $MINOR
+fi
-- 
1.5.2.rc0.g4342-dirty
