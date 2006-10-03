Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 03 Oct 2006 14:12:07 +1000
Subject: [PATCH 1/2] Cleanup include/asm-powerpc/xmon.h
Message-Id: <1159848727.955823.82109451606.qpush@concordia>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For some reason we have two prototypes for xmon_init(), remove the
one in system.h.

No one calls xmon() anymore, debugger() is preferable, so we don't
need the prototype. And similarly no one calls xmon_printf().

Also update the include guards on xmon.h to match the standard
format, add copyright and license, and add comments to #endifs.

Built for pseries_defconfig and pmac32_defconfig.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 include/asm-powerpc/system.h |    4 ----
 include/asm-powerpc/xmon.h   |   22 ++++++++++++++--------
 2 files changed, 14 insertions(+), 12 deletions(-)

Index: to-merge/include/asm-powerpc/system.h
===================================================================
--- to-merge.orig/include/asm-powerpc/system.h
+++ to-merge/include/asm-powerpc/system.h
@@ -91,10 +91,6 @@ DEBUGGER_BOILERPLATE(debugger_iabr_match
 DEBUGGER_BOILERPLATE(debugger_dabr_match)
 DEBUGGER_BOILERPLATE(debugger_fault_handler)
 
-#ifdef CONFIG_XMON
-extern void xmon_init(int enable);
-#endif
-
 #else
 static inline int debugger(struct pt_regs *regs) { return 0; }
 static inline int debugger_ipi(struct pt_regs *regs) { return 0; }
Index: to-merge/include/asm-powerpc/xmon.h
===================================================================
--- to-merge.orig/include/asm-powerpc/xmon.h
+++ to-merge/include/asm-powerpc/xmon.h
@@ -1,12 +1,18 @@
-#ifndef __PPC_XMON_H
-#define __PPC_XMON_H
-#ifdef __KERNEL__
+#ifndef __ASM_POWERPC_XMON_H
+#define __ASM_POWERPC_XMON_H
+
+/*
+ * Copyrignt (C) 2006 IBM Corp
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
 
-struct pt_regs;
+#ifdef __KERNEL__
 
-extern int xmon(struct pt_regs *excp);
-extern void xmon_printf(const char *fmt, ...);
 extern void xmon_init(int);
 
-#endif
-#endif
+#endif /* __KERNEL __ */
+#endif /* __ASM_POWERPC_XMON_H */
