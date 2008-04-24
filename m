Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d3f56e3d99619e642b6f8cd73b35dad4597934ed.1209002897.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Discourage people from fiddling with kernel data from
	prom_init
Date: Thu, 24 Apr 2008 12:08:22 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As BenH said the other day, it is an "accident" that prom_init.o is linked
with the rest of the kernel. The truth is a little more subtle, prom_init
isn't truly bootloader, it does fiddle with kernel data in a few places.

What we can do is discourage people from adding new code that accesses
data outside of prom_init. And hence this patch, from the script:

 # This script checks prom_init.o to see what external symbols it
 # is using, if it finds symbols not in the whitelist it returns
 # an error. The point of this is to discourage people from
 # intentionally or accidentally adding new code to prom_init.c
 # which has side effects on other parts of the kernel.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/Makefile           |    9 +++++
 arch/powerpc/kernel/prom_init_check.sh |   58 ++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 5183a90..562bb02 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -106,4 +106,13 @@ PHONY += systbl_chk
 systbl_chk: $(src)/systbl_chk.sh $(obj)/systbl_chk.i
 	$(call cmd,systbl_chk)
 
+$(obj)/built-in.o:		prom_init_check
+
+quiet_cmd_prom_init_check = CALL    $<
+      cmd_prom_init_check = $(CONFIG_SHELL) $< "$(NM)" "$(obj)/prom_init.o"
+
+PHONY += prom_init_check
+prom_init_check: $(src)/prom_init_check.sh $(obj)/prom_init.o
+	$(call cmd,prom_init_check)
+
 clean-files := vmlinux.lds
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
new file mode 100644
index 0000000..8e24fc1
--- /dev/null
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+#
+# Copyright © 2008 IBM Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version
+# 2 of the License, or (at your option) any later version.
+
+# This script checks prom_init.o to see what external symbols it
+# is using, if it finds symbols not in the whitelist it returns
+# an error. The point of this is to discourage people from
+# intentionally or accidentally adding new code to prom_init.c
+# which has side effects on other parts of the kernel.
+
+# If you really need to reference something from prom_init.o add
+# it to the list below:
+
+WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
+_end enter_prom memcpy memset reloc_offset __secondary_hold
+__secondary_hold_acknowledge __secondary_hold_spinloop __start
+strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
+reloc_got2"
+
+NM="$1"
+OBJ="$2"
+
+ERROR=0
+
+for UNDEF in $($NM -u $OBJ | awk '{print $2}')
+do
+	# On 64-bit nm gives us the function descriptors, which have
+	# a leading . on the name, so strip it off here.
+	UNDEF="${UNDEF#.}"
+
+	if [ $KBUILD_VERBOSE ]; then
+		if [ $KBUILD_VERBOSE -ne 0 ]; then
+			echo "Checking prom_init.o symbol '$UNDEF'"
+		fi
+	fi
+
+	OK=0
+	for WHITE in $WHITELIST
+	do
+		if [ "$UNDEF" = "$WHITE" ]; then
+			OK=1
+			break
+		fi
+	done
+
+	if [ $OK -eq 0 ]; then
+		ERROR=1
+		echo "Error: External symbol '$UNDEF' referenced" \
+		     "from prom_init.c" >&2
+	fi
+done
+
+exit $ERROR
-- 
1.5.5
