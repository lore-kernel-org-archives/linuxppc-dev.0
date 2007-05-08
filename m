Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 3/7] powerpc: Add powerpc/platforms/44x,
	disable platforms/4xx for now
In-Reply-To: <20070508025832.GD11340@localhost.localdomain>
Message-Id: <20070508025930.8CA75DE0FF@ozlabs.org>
Date: Tue,  8 May 2007 12:59:30 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch prepares for Ebony/440 support by creating an
arch/powerpc/platforms/44x directory.  It is populated with a single
misc_44x.S file, into which is moved the 44x specific reset code from
head_44x.S (on the grounds that we should really stop clogging up the
head_* files with random asm helper routines).

At the same time, we disable the (empty save Kconfig and Makefile)
arch/powerpc/platforms/4xx directory from the arch/powerpc/platforms
Makefile.  Contrary to the comment in
arch/powerpc/platforms/4xx/Makefile, attempting to build such an empty
Makefile will fail, thus breaking compile for the 44x platforms we're
about to add.  It can go back in once we start porting some of the 40x
platforms (and thus it becomes non-empty).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/kernel/head_44x.S        |   10 ----------
 arch/powerpc/platforms/44x/44x.h      |    6 ++++++
 arch/powerpc/platforms/44x/Makefile   |    1 +
 arch/powerpc/platforms/44x/misc_44x.S |   26 ++++++++++++++++++++++++++
 arch/powerpc/platforms/Makefile       |    3 ++-
 5 files changed, 35 insertions(+), 11 deletions(-)

Index: working-2.6/arch/powerpc/platforms/44x/misc_44x.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/platforms/44x/misc_44x.S	2007-05-07 14:19:02.000000000 +1000
@@ -0,0 +1,26 @@
+/*
+ * This file contains miscellaneous low-level functions for PPC 44x.
+ *    Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+
+	.text
+
+/*
+ * void ppc44x_reset_system(char *cmd)
+ *
+ * At present, this routine just applies a system reset.
+ */
+_GLOBAL(ppc44x_reset_system)
+	mfspr	r13,SPRN_DBCR0
+	oris	r13,r13,DBCR0_RST_SYSTEM@h
+	mtspr	SPRN_DBCR0,r13
+	b	.			/* Just in case the reset doesn't work */
Index: working-2.6/arch/powerpc/platforms/44x/44x.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/platforms/44x/44x.h	2007-05-07 14:12:22.000000000 +1000
@@ -0,0 +1,6 @@
+#ifndef __POWERPC_PLATFORMS_44X_44X_H
+#define __POWERPC_PLATFORMS_44X_44X_H
+
+extern void ppc44x_reset_system(char *cmd);
+
+#endif /* __POWERPC_PLATFORMS_44X_44X_H */
Index: working-2.6/arch/powerpc/kernel/head_44x.S
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-05-07 14:11:33.000000000 +1000
+++ working-2.6/arch/powerpc/kernel/head_44x.S	2007-05-07 14:12:22.000000000 +1000
@@ -709,16 +709,6 @@ _GLOBAL(giveup_fpu)
 	blr
 #endif
 
-/*
- * extern void abort(void)
- *
- * At present, this routine just applies a system reset.
- */
-_GLOBAL(abort)
-        mfspr   r13,SPRN_DBCR0
-        oris    r13,r13,DBCR0_RST_SYSTEM@h
-        mtspr   SPRN_DBCR0,r13
-
 _GLOBAL(set_context)
 
 #ifdef CONFIG_BDI_SWITCH
Index: working-2.6/arch/powerpc/platforms/44x/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/platforms/44x/Makefile	2007-05-07 14:12:22.000000000 +1000
@@ -0,0 +1 @@
+obj-$(CONFIG_44x)	:= misc_44x.o
Index: working-2.6/arch/powerpc/platforms/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/Makefile	2007-05-07 14:11:33.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/Makefile	2007-05-07 14:12:22.000000000 +1000
@@ -6,7 +6,8 @@ obj-$(CONFIG_PPC_PMAC)		+= powermac/
 endif
 endif
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
-obj-$(CONFIG_4xx)		+= 4xx/
+#obj-$(CONFIG_4xx)		+= 4xx/
+obj-$(CONFIG_44x)		+= 44x/
 obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
 obj-$(CONFIG_PPC_8xx)		+= 8xx/
 obj-$(CONFIG_PPC_82xx)		+= 82xx/
