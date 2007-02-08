Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 08 Feb 2007 18:33:51 +1100
Subject: [PATCH 1/4] Consolidate pseries platform header files into pseries.h
Message-Id: <1170920031.184014.219881150011.qpush@cradle>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Following the example of platforms/pasemi, consolidate a couple of
tiny header files in platforms/pseries into pseries.h.

This gives us a convenient place to put things that need to be
available to the platform code, but not public. And hopefully will
help people resist the temptation of sticking externs in C files.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/firmware.h |   17 -----------------
 arch/powerpc/platforms/pseries/pseries.h  |   20 ++++++++++++++++++++
 arch/powerpc/platforms/pseries/ras.c      |    2 +-
 arch/powerpc/platforms/pseries/ras.h      |    9 ---------
 arch/powerpc/platforms/pseries/setup.c    |    4 ++--
 5 files changed, 23 insertions(+), 29 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/firmware.h
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/firmware.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright 2006 IBM Corporation.
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-
-#ifndef _PSERIES_FIRMWARE_H
-#define _PSERIES_FIRMWARE_H
-
-#include <asm/firmware.h>
-
-extern void __init fw_feature_init(void);
-
-#endif /* _PSERIES_FIRMWARE_H */
Index: powerpc/arch/powerpc/platforms/pseries/pseries.h
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/platforms/pseries/pseries.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright 2006 IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _PSERIES_PSERIES_H
+#define _PSERIES_PSERIES_H
+
+extern void __init fw_feature_init(void);
+
+struct pt_regs;
+
+extern int pSeries_system_reset_exception(struct pt_regs *regs);
+extern int pSeries_machine_check_exception(struct pt_regs *regs);
+
+#endif /* _PSERIES_PSERIES_H */
Index: powerpc/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/ras.c
+++ powerpc/arch/powerpc/platforms/pseries/ras.c
@@ -51,7 +51,7 @@
 #include <asm/udbg.h>
 #include <asm/firmware.h>
 
-#include "ras.h"
+#include "pseries.h"
 
 static unsigned char ras_log_buf[RTAS_ERROR_LOG_MAX];
 static DEFINE_SPINLOCK(ras_log_buf_lock);
Index: powerpc/arch/powerpc/platforms/pseries/ras.h
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/ras.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef _PSERIES_RAS_H
-#define _PSERIES_RAS_H
-
-struct pt_regs;
-
-extern int pSeries_system_reset_exception(struct pt_regs *regs);
-extern int pSeries_machine_check_exception(struct pt_regs *regs);
-
-#endif /* _PSERIES_RAS_H */
Index: powerpc/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/setup.c
+++ powerpc/arch/powerpc/platforms/pseries/setup.c
@@ -65,10 +65,10 @@
 #include <asm/i8259.h>
 #include <asm/udbg.h>
 #include <asm/smp.h>
+#include <asm/firmware.h>
 
 #include "plpar_wrappers.h"
-#include "ras.h"
-#include "firmware.h"
+#include "pseries.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
