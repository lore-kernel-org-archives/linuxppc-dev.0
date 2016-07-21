Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw45T1fJnzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:44:45 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id cf3so4672100pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:44:45 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 01/14] powerpc: add arch/powerpc/tools directory
Date: Thu, 21 Jul 2016 16:44:00 +1000
Message-Id: <1469083453-9279-2-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move a couple of existing scripts under there. Remove scripts directory:
a script is a tool, a tool is not a script.

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile                             |  8 ++-
 arch/powerpc/relocs_check.sh                      | 59 -----------------------
 arch/powerpc/scripts/gcc-check-mprofile-kernel.sh | 23 ---------
 arch/powerpc/tools/gcc-check-mprofile-kernel.sh   | 23 +++++++++
 arch/powerpc/tools/relocs_check.sh                | 59 +++++++++++++++++++++++
 5 files changed, 88 insertions(+), 84 deletions(-)
 delete mode 100755 arch/powerpc/relocs_check.sh
 delete mode 100755 arch/powerpc/scripts/gcc-check-mprofile-kernel.sh
 create mode 100755 arch/powerpc/tools/gcc-check-mprofile-kernel.sh
 create mode 100755 arch/powerpc/tools/relocs_check.sh

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 709a22a..d8d30fc 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -134,7 +134,7 @@ CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
 
 ifdef CONFIG_MPROFILE_KERNEL
-    ifeq ($(shell $(srctree)/arch/powerpc/scripts/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__),OK)
+    ifeq ($(shell $(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__),OK)
         CC_FLAGS_FTRACE := -pg -mprofile-kernel
         KBUILD_CPPFLAGS += -DCC_USING_MPROFILE_KERNEL
     else
@@ -227,6 +227,9 @@ cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)
 
+archscripts: scripts_basic
+	$(Q)$(MAKE) $(build)=arch/powerpc/tools
+
 head-y				:= arch/powerpc/kernel/head_$(CONFIG_WORD_SIZE).o
 head-$(CONFIG_8xx)		:= arch/powerpc/kernel/head_8xx.o
 head-$(CONFIG_40x)		:= arch/powerpc/kernel/head_40x.o
@@ -268,7 +271,7 @@ quiet_cmd_relocs_check = CALL    $<
       cmd_relocs_check = $(CONFIG_SHELL) $< "$(OBJDUMP)" "$(obj)/vmlinux"
 
 PHONY += relocs_check
-relocs_check: arch/powerpc/relocs_check.sh vmlinux
+relocs_check: arch/powerpc/tools/relocs_check.sh vmlinux
 	$(call cmd,relocs_check)
 
 zImage: relocs_check
@@ -368,6 +371,7 @@ endif
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
+	$(Q)$(MAKE) $(clean)=arch/powerpc/tools
 
 archprepare: checkbin
 
diff --git a/arch/powerpc/relocs_check.sh b/arch/powerpc/relocs_check.sh
deleted file mode 100755
index 2e4ebd0..0000000
--- a/arch/powerpc/relocs_check.sh
+++ /dev/null
@@ -1,59 +0,0 @@
-#!/bin/sh
-
-# Copyright © 2015 IBM Corporation
-
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License
-# as published by the Free Software Foundation; either version
-# 2 of the License, or (at your option) any later version.
-
-# This script checks the relocations of a vmlinux for "suspicious"
-# relocations.
-
-# based on relocs_check.pl
-# Copyright © 2009 IBM Corporation
-
-if [ $# -lt 2 ]; then
-	echo "$0 [path to objdump] [path to vmlinux]" 1>&2
-	exit 1
-fi
-
-# Have Kbuild supply the path to objdump so we handle cross compilation.
-objdump="$1"
-vmlinux="$2"
-
-bad_relocs=$(
-"$objdump" -R "$vmlinux" |
-	# Only look at relocation lines.
-	grep -E '\<R_' |
-	# These relocations are okay
-	# On PPC64:
-	#	R_PPC64_RELATIVE, R_PPC64_NONE
-	#	R_PPC64_ADDR64 mach_<name>
-	# On PPC:
-	#	R_PPC_RELATIVE, R_PPC_ADDR16_HI,
-	#	R_PPC_ADDR16_HA,R_PPC_ADDR16_LO,
-	#	R_PPC_NONE
-	grep -F -w -v 'R_PPC64_RELATIVE
-R_PPC64_NONE
-R_PPC_ADDR16_LO
-R_PPC_ADDR16_HI
-R_PPC_ADDR16_HA
-R_PPC_RELATIVE
-R_PPC_NONE' |
-	grep -E -v '\<R_PPC64_ADDR64[[:space:]]+mach_'
-)
-
-if [ -z "$bad_relocs" ]; then
-	exit 0
-fi
-
-num_bad=$(echo "$bad_relocs" | wc -l)
-echo "WARNING: $num_bad bad relocations"
-echo "$bad_relocs"
-
-# If we see this type of relocation it's an idication that
-# we /may/ be using an old version of binutils.
-if echo "$bad_relocs" | grep -q -F -w R_PPC64_UADDR64; then
-	echo "WARNING: You need at least binutils >= 2.19 to build a CONFIG_RELOCATABLE kernel"
-fi
diff --git a/arch/powerpc/scripts/gcc-check-mprofile-kernel.sh b/arch/powerpc/scripts/gcc-check-mprofile-kernel.sh
deleted file mode 100755
index c658d8c..0000000
--- a/arch/powerpc/scripts/gcc-check-mprofile-kernel.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/bash
-
-set -e
-set -o pipefail
-
-# To debug, uncomment the following line
-# set -x
-
-# Test whether the compile option -mprofile-kernel exists and generates
-# profiling code (ie. a call to _mcount()).
-echo "int func() { return 0; }" | \
-    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
-    grep -q "_mcount"
-
-# Test whether the notrace attribute correctly suppresses calls to _mcount().
-
-echo -e "#include <linux/compiler.h>\nnotrace int func() { return 0; }" | \
-    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
-    grep -q "_mcount" && \
-    exit 1
-
-echo "OK"
-exit 0
diff --git a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
new file mode 100755
index 0000000..c658d8c
--- /dev/null
+++ b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+
+set -e
+set -o pipefail
+
+# To debug, uncomment the following line
+# set -x
+
+# Test whether the compile option -mprofile-kernel exists and generates
+# profiling code (ie. a call to _mcount()).
+echo "int func() { return 0; }" | \
+    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
+    grep -q "_mcount"
+
+# Test whether the notrace attribute correctly suppresses calls to _mcount().
+
+echo -e "#include <linux/compiler.h>\nnotrace int func() { return 0; }" | \
+    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
+    grep -q "_mcount" && \
+    exit 1
+
+echo "OK"
+exit 0
diff --git a/arch/powerpc/tools/relocs_check.sh b/arch/powerpc/tools/relocs_check.sh
new file mode 100755
index 0000000..2e4ebd0
--- /dev/null
+++ b/arch/powerpc/tools/relocs_check.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+# Copyright © 2015 IBM Corporation
+
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version
+# 2 of the License, or (at your option) any later version.
+
+# This script checks the relocations of a vmlinux for "suspicious"
+# relocations.
+
+# based on relocs_check.pl
+# Copyright © 2009 IBM Corporation
+
+if [ $# -lt 2 ]; then
+	echo "$0 [path to objdump] [path to vmlinux]" 1>&2
+	exit 1
+fi
+
+# Have Kbuild supply the path to objdump so we handle cross compilation.
+objdump="$1"
+vmlinux="$2"
+
+bad_relocs=$(
+"$objdump" -R "$vmlinux" |
+	# Only look at relocation lines.
+	grep -E '\<R_' |
+	# These relocations are okay
+	# On PPC64:
+	#	R_PPC64_RELATIVE, R_PPC64_NONE
+	#	R_PPC64_ADDR64 mach_<name>
+	# On PPC:
+	#	R_PPC_RELATIVE, R_PPC_ADDR16_HI,
+	#	R_PPC_ADDR16_HA,R_PPC_ADDR16_LO,
+	#	R_PPC_NONE
+	grep -F -w -v 'R_PPC64_RELATIVE
+R_PPC64_NONE
+R_PPC_ADDR16_LO
+R_PPC_ADDR16_HI
+R_PPC_ADDR16_HA
+R_PPC_RELATIVE
+R_PPC_NONE' |
+	grep -E -v '\<R_PPC64_ADDR64[[:space:]]+mach_'
+)
+
+if [ -z "$bad_relocs" ]; then
+	exit 0
+fi
+
+num_bad=$(echo "$bad_relocs" | wc -l)
+echo "WARNING: $num_bad bad relocations"
+echo "$bad_relocs"
+
+# If we see this type of relocation it's an idication that
+# we /may/ be using an old version of binutils.
+if echo "$bad_relocs" | grep -q -F -w R_PPC64_UADDR64; then
+	echo "WARNING: You need at least binutils >= 2.19 to build a CONFIG_RELOCATABLE kernel"
+fi
-- 
2.8.1
