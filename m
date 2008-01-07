Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8CB28DDE16
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 16:12:51 +1100 (EST)
Date: Mon, 7 Jan 2008 16:12:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Check that the syscall table matches the syscall
	numbers
Message-Id: <20080107161244.dfc8131e.sfr@canb.auug.org.au>
In-Reply-To: <20080103164141.8faa9f27.sfr@canb.auug.org.au>
References: <20080103164141.8faa9f27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also check that __NR_syscalls has been updated appropriately.

Hopefully this will catch any out of order additions to the
table in the future.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/Makefile      |   10 ++++++
 arch/powerpc/kernel/systbl_chk.c  |   58 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/systbl_chk.sh |   33 +++++++++++++++++++++
 3 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/kernel/systbl_chk.c
 create mode 100644 arch/powerpc/kernel/systbl_chk.sh

This version does not modify the current code for generating the syscall
tables and does more checking.

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 9374bc9..d9b3770 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -91,3 +91,13 @@ obj-$(CONFIG_PPC64)		+= $(obj64-y)
 
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-$(CONFIG_PPC64)		+= entry_64.o
+
+extra-y				+= systbl_chk.i
+$(obj)/systbl.o:		systbl_chk
+
+quiet_cmd_systbl_chk = CALL    $<
+      cmd_systbl_chk = $(CONFIG_SHELL) $< $(obj)/systbl_chk.i
+
+PHONY += systbl_chk
+systbl_chk: $(src)/systbl_chk.sh $(obj)/systbl_chk.i
+	$(call cmd,systbl_chk)
diff --git a/arch/powerpc/kernel/systbl_chk.c b/arch/powerpc/kernel/systbl_chk.c
new file mode 100644
index 0000000..238aa63
--- /dev/null
+++ b/arch/powerpc/kernel/systbl_chk.c
@@ -0,0 +1,58 @@
+/*
+ * This file, when run through CPP produces a list of syscall numbers
+ * in the order of systbl.h.  That way we can check for gaps and syscalls
+ * that are out of order.
+ *
+ * Unfortunately, we cannot check for the correct ordering of entries
+ * using SYSX().
+ *
+ * Copyright © IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <asm/unistd.h>
+
+#define SYSCALL(func)		__NR_##func
+#define COMPAT_SYS(func)	__NR_##func
+#define PPC_SYS(func)		__NR_##func
+#ifdef CONFIG_PPC64
+#define OLDSYS(func)		-1
+#define SYS32ONLY(func)		-1
+#else
+#define OLDSYS(func)		__NR_old##func
+#define SYS32ONLY(func)		__NR_##func
+#endif
+#define SYSX(f, f3264, f32)	-1
+
+#define SYSCALL_SPU(func)	SYSCALL(func)
+#define COMPAT_SYS_SPU(func)	COMPAT_SYS(func)
+#define PPC_SYS_SPU(func)	PPC_SYS(func)
+#define SYSX_SPU(f, f3264, f32)	SYSX(f, f3264, f32)
+
+/* Just insert a marker for ni_syscalls */
+#define	__NR_ni_syscall		-1
+
+/*
+ * These are the known exceptions.
+ * Hopefully, there will be no more.
+ */
+#define	__NR_llseek		__NR__llseek
+#undef	__NR_umount
+#define	__NR_umount		__NR_umount2
+#define	__NR_old_getrlimit	__NR_getrlimit
+#define	__NR_newstat		__NR_stat
+#define	__NR_newlstat		__NR_lstat
+#define	__NR_newfstat		__NR_fstat
+#define	__NR_newuname		__NR_uname
+#define	__NR_sysctl		__NR__sysctl
+#define __NR_olddebug_setcontext	__NR_sys_debug_setcontext
+
+/* We call sys_ugetrlimit for syscall number __NR_getrlimit */
+#define getrlimit		ugetrlimit
+
+START_TABLE
+#include <asm/systbl.h>
+END_TABLE __NR_syscalls
diff --git a/arch/powerpc/kernel/systbl_chk.sh b/arch/powerpc/kernel/systbl_chk.sh
new file mode 100644
index 0000000..19415e7
--- /dev/null
+++ b/arch/powerpc/kernel/systbl_chk.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# Just process the CPP output from systbl_chk.c and complain
+# if anything is out of order.
+#
+# Copyright © 2008 IBM Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version
+# 2 of the License, or (at your option) any later version.
+
+awk	'BEGIN { num = -1; }	# Ignore the beginning of the file
+	/^#/ { next; }
+	/^[ \t]*$/ { next; }
+	/^START_TABLE/ { num = 0; next; }
+	/^END_TABLE/ {
+		if (num != $2) {
+			printf "__NR_syscalls (%s) is not one more than the last syscall (%s)\n",
+				$2, num - 1;
+			exit(1);
+		}
+		num = -1;	# Ignore the rest of the file
+	}
+	{
+		if (num == -1) next;
+		if (($1 != -1) && ($1 != num)) {
+			printf "Syscall %s out of order (expected %s)\n",
+				$1, num;
+			exit(1);
+		};
+		num++;
+	}' "$1"
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
