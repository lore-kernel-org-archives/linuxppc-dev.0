Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQddn1w1VzDvWt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 14:26:37 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id x23so6990764pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 19:26:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc/64: tool to check head sections location sanity
Date: Sat, 26 Nov 2016 14:26:12 +1100
Message-Id: <20161126032612.13559-5-npiggin@gmail.com>
In-Reply-To: <20161126032612.13559-1-npiggin@gmail.com>
References: <20161126032612.13559-1-npiggin@gmail.com>
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

Use a tool to check the location of "fixed sections" is where we
expected them, which catches cases the linker script can't (stubs
being added to start of .text section), and which ends up being
neater.

Sample output:

  ERROR: start_text address is c000000000008100, should be c000000000008000
  ERROR: see comments in arch/powerpc/tools/head_check.sh

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile.postlink     |  8 ++++-
 arch/powerpc/include/asm/head-64.h |  4 +--
 arch/powerpc/kernel/vmlinux.lds.S  | 22 ------------
 arch/powerpc/tools/head_check.sh   | 70 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 25 deletions(-)
 create mode 100755 arch/powerpc/tools/head_check.sh

diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
index 1f9f6e6..4c1eafd 100644
--- a/arch/powerpc/Makefile.postlink
+++ b/arch/powerpc/Makefile.postlink
@@ -10,6 +10,9 @@ __archpost:
 include include/config/auto.conf
 include scripts/Kbuild.include
 
+quiet_cmd_head_check = CHKHEAD $@
+      cmd_head_check = $(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/head_check.sh "$(NM)" "$@"
+
 quiet_cmd_relocs_check = CHKREL  $@
 ifdef CONFIG_PPC_BOOK3S_64
       cmd_relocs_check =						\
@@ -24,6 +27,9 @@ endif
 
 vmlinux: FORCE
 	@true
+ifdef CONFIG_PPC64
+	$(call cmd,head_check)
+endif
 ifdef CONFIG_RELOCATABLE
 	$(call if_changed,relocs_check)
 endif
@@ -32,7 +38,7 @@ endif
 	@true
 
 clean:
-	@true
+	rm -f .tmp_symbols.txt
 
 PHONY += FORCE clean
 
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index ab90c2f..492ebe7 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -49,8 +49,8 @@
  *   CLOSE_FIXED_SECTION() or elsewhere, there may be something
  *   unexpected being added there. Remove the '. = x_len' line, rebuild, and
  *   check what is pushing the section down.
- * - If the build dies in linking, check arch/powerpc/kernel/vmlinux.lds.S
- *   for instructions.
+ * - If the build dies in linking, check arch/powerpc/tools/head_check.sh
+ *   comments.
  * - If the kernel crashes or hangs in very early boot, it could be linker
  *   stubs at the start of the main text.
  */
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 7394b77..bcd2a52 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -58,7 +58,6 @@ SECTIONS
 #ifdef CONFIG_PPC64
 		KEEP(*(.head.text.first_256B));
 #ifdef CONFIG_PPC_BOOK3E
-# define END_FIXED	0x100
 #else
 		KEEP(*(.head.text.real_vectors));
 		*(.head.text.real_trampolines);
@@ -66,34 +65,13 @@ SECTIONS
 		*(.head.text.virt_trampolines);
 # if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 		KEEP(*(.head.data.fwnmi_page));
-#  define END_FIXED	0x8000
-# else
-#  define END_FIXED	0x7000
 # endif
 #endif
-		ASSERT((. == END_FIXED), "vmlinux.lds.S: fixed section overflow error");
 #else /* !CONFIG_PPC64 */
 		HEAD_TEXT
 #endif
 	} :kernel
 
-	/*
-	 * If the build dies here, it's likely code in head_64.S is referencing
-	 * labels it can't reach, and the linker inserting stubs without the
-	 * assembler's knowledge. To debug, remove the above assert and
-	 * rebuild. Look for branch stubs in the fixed section region.
-	 *
-	 * Linker stub generation could be allowed in "trampoline"
-	 * sections if absolutely necessary, but this would require
-	 * some rework of the fixed sections. Before resorting to this,
-	 * consider references that have sufficient addressing range,
-	 * (e.g., hand coded trampolines) so the linker does not have
-	 * to add stubs.
-	 *
-	 * Linker stubs at the top of the main text section are currently not
-	 * detected, and will result in a crash at boot due to offsets being
-	 * wrong.
-	 */
 #ifdef CONFIG_PPC64
 	/*
 	 * BLOCK(0) overrides the default output section alignment because
diff --git a/arch/powerpc/tools/head_check.sh b/arch/powerpc/tools/head_check.sh
new file mode 100755
index 0000000..11efe45
--- /dev/null
+++ b/arch/powerpc/tools/head_check.sh
@@ -0,0 +1,70 @@
+# Copyright © 2016 IBM Corporation
+
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version
+# 2 of the License, or (at your option) any later version.
+
+# This script checks the head of a vmlinux for linker stubs that
+# break our placement of fixed-location code for 64-bit.
+
+# based on relocs_check.pl
+# Copyright © 2009 IBM Corporation
+
+# READ THIS
+#
+# If the build dies here, it's likely code in head_64.S or nearby is
+# referencing labels it can't reach, which results in the linker inserting
+# stubs without the assembler's knowledge. This can move code around in ways
+# that break the fixed location placement stuff (head-64.h). To debug,
+# disassemble the vmlinux and look for branch stubs (long_branch, plt_branch
+# etc) in the fixed section region (0 - 0x8000ish). Check what places are
+# calling those stubs.
+#
+# Linker stubs use the TOC pointer, so even if fixed section code could
+# tolerate them being inserted into head code, they can't be allowed in low
+# level entry code (boot, interrupt vectors, etc) until r2 is set up. This
+# could cause the kernel to die in early boot.
+
+# Turn this on if you want more debug output:
+# set -x
+
+if [ $# -lt 2 ]; then
+	echo "$0 [path to nm] [path to vmlinux]" 1>&2
+	exit 1
+fi
+
+# Have Kbuild supply the path to nm so we handle cross compilation.
+nm="$1"
+vmlinux="$2"
+
+$nm "$vmlinux" | grep -e " T _stext$" -e " t start_first_256B$" -e " a text_start$" -e " t start_text$" -m4 > .tmp_symbols.txt
+
+
+vma=$(cat .tmp_symbols.txt | grep " T _stext$" | cut -d' ' -f1)
+
+expected_start_head_addr=$vma
+
+start_head_addr=$(cat .tmp_symbols.txt | grep " t start_first_256B$" | cut -d' ' -f1)
+
+if [ "$start_head_addr" != "$expected_start_head_addr" ]; then
+	echo "ERROR: head code starts at $start_head_addr, should be 0"
+	echo "ERROR: see comments in arch/powerpc/tools/head_check.sh"
+
+	exit 1
+fi
+
+top_vma=$(echo $vma | cut -d'0' -f1)
+
+expected_start_text_addr=$(cat .tmp_symbols.txt | grep " a text_start$" | cut -d' ' -f1 | sed "s/^0/$top_vma/")
+
+start_text_addr=$(cat .tmp_symbols.txt | grep " t start_text$" | cut -d' ' -f1)
+
+if [ "$start_text_addr" != "$expected_start_text_addr" ]; then
+	echo "ERROR: start_text address is $start_text_addr, should be $expected_start_text_addr"
+	echo "ERROR: see comments in arch/powerpc/tools/head_check.sh"
+
+	exit 1
+fi
+
+rm .tmp_symbols.txt
-- 
2.10.2
