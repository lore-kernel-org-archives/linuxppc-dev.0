Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wP0kz5QsqzDqZf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 03:40:59 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id s62so4373452pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 10:40:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 1/3] powerpc/64s: tool to flag direct branches from
 unrelocated interrupt vectors
Date: Fri, 12 May 2017 03:40:38 +1000
Message-Id: <20170511174040.19728-2-npiggin@gmail.com>
In-Reply-To: <20170511174040.19728-1-npiggin@gmail.com>
References: <20170511174040.19728-1-npiggin@gmail.com>
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

Direct banches from code below __end_interrupts to code above
__end_interrupts when built with CONFIG_RELOCATABLE are disallowed
because they will break when the kernel is not located at 0.

Sample output:

    WARNING: Unrelocated relative branches
    c000000000000118 bl-> 0xc000000000038fb8 <pnv_restore_hyp_resource>
    c00000000000013c b-> 0xc0000000001068a4 <kvm_start_guest>
    c000000000000148 b-> 0xc00000000003919c <pnv_wakeup_loss>
    c00000000000014c b-> 0xc00000000003923c <pnv_wakeup_noloss>
    c0000000000005a4 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
    c000000000001af0 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
    c000000000001b24 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
    c000000000001b58 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile.postlink           |  9 ++++-
 arch/powerpc/tools/unrel_branch_check.sh | 57 ++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100755 arch/powerpc/tools/unrel_branch_check.sh

diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
index 3c22d64b2de9..1f9f6e66bdec 100644
--- a/arch/powerpc/Makefile.postlink
+++ b/arch/powerpc/Makefile.postlink
@@ -11,7 +11,14 @@ include include/config/auto.conf
 include scripts/Kbuild.include
 
 quiet_cmd_relocs_check = CHKREL  $@
-      cmd_relocs_check = $(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/relocs_check.sh "$(OBJDUMP)" "$@"
+ifdef CONFIG_PPC_BOOK3S_64
+      cmd_relocs_check =						\
+	$(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/relocs_check.sh "$(OBJDUMP)" "$@" ; \
+	$(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/unrel_branch_check.sh "$(OBJDUMP)" "$@"
+else
+      cmd_relocs_check =						\
+	$(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/relocs_check.sh "$(OBJDUMP)" "$@"
+endif
 
 # `@true` prevents complaint when there is nothing to be done
 
diff --git a/arch/powerpc/tools/unrel_branch_check.sh b/arch/powerpc/tools/unrel_branch_check.sh
new file mode 100755
index 000000000000..1e972df3107e
--- /dev/null
+++ b/arch/powerpc/tools/unrel_branch_check.sh
@@ -0,0 +1,57 @@
+# Copyright © 2016 IBM Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version
+# 2 of the License, or (at your option) any later version.
+#
+# This script checks the relocations of a vmlinux for "suspicious"
+# branches from unrelocated code (head_64.S code).
+
+# Turn this on if you want more debug output:
+# set -x
+
+# Have Kbuild supply the path to objdump so we handle cross compilation.
+objdump="$1"
+vmlinux="$2"
+
+#__end_interrupts should be located within the first 64K
+
+end_intr=0x$(
+"$objdump" -R "$vmlinux" -d --start-address=0xc000000000000000		\
+		 --stop-address=0xc000000000010000 |
+grep '\<__end_interrupts>:' |
+awk '{print $1}'
+)
+
+BRANCHES=$(
+"$objdump" -R "$vmlinux" -D --start-address=0xc000000000000000		\
+		--stop-address=${end_intr} |
+grep -e "^c[0-9a-f]*:[[:space:]]*\([0-9a-f][0-9a-f][[:space:]]\)\{4\}[[:space:]]*b" |
+grep -v '\<__start_initialization_multiplatform>' |
+grep -v -e 'b.\?.\?ctr' |
+grep -v -e 'b.\?.\?lr' |
+sed 's/://' |
+awk '{ print $1 ":" $6 ":0x" $7 ":" $8 " "}'
+)
+
+for tuple in $BRANCHES
+do
+	from=`echo $tuple | cut -d':' -f1`
+	branch=`echo $tuple | cut -d':' -f2`
+	to=`echo $tuple | cut -d':' -f3 | sed 's/cr[0-7],//'`
+	sym=`echo $tuple | cut -d':' -f4`
+
+	if (( $to > $end_intr ))
+	then
+		if [ -z "$bad_branches" ]; then
+			echo "WARNING: Unrelocated relative branches"
+			bad_branches="yes"
+		fi
+		echo "$from $branch-> $to $sym"
+	fi
+done
+
+if [ -z "$bad_branches" ]; then
+	exit 0
+fi
-- 
2.11.0
