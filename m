Return-Path: <galak@freescale.com>
Date: Wed, 26 Oct 2005 09:56:10 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510260955420.6094@linen.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: Moved dcr support to arch/powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit ef5ace072939eda2e37acf1204363c8402727368
tree d5faa9bbae927b302e36cda55b8a41fd7b54eaf2
parent 76b3884004db7ea66b3ef801dd0fa1e2337025a8
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 26 Oct 2005 09:48:25 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 26 Oct 2005 09:48:25 -0500

 arch/powerpc/sysdev/Makefile |    2 ++
 arch/powerpc/sysdev/dcr.S    |   41 +++++++++++++++++++++++++++++++++++++++++
 arch/ppc/syslib/Makefile     |    2 --
 arch/ppc/syslib/dcr.S        |   41 -----------------------------------------
 4 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -2,3 +2,5 @@ obj-$(CONFIG_MPIC)		+= mpic.o
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
+obj-$(CONFIG_BOOKE)		+= dcr.o
+obj-$(CONFIG_40x)		+= dcr.o
diff --git a/arch/powerpc/sysdev/dcr.S b/arch/powerpc/sysdev/dcr.S
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/sysdev/dcr.S
@@ -0,0 +1,41 @@
+/*
+ * arch/ppc/syslib/dcr.S
+ *
+ * "Indirect" DCR access
+ *
+ * Copyright (c) 2004 Eugene Surovegin <ebs@ebshome.net>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under  the terms of  the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/processor.h>
+
+#define DCR_ACCESS_PROLOG(table) \
+	rlwinm  r3,r3,4,18,27;   \
+	lis     r5,table@h;      \
+	ori     r5,r5,table@l;   \
+	add     r3,r3,r5;        \
+	mtctr   r3;              \
+	bctr
+
+_GLOBAL(__mfdcr)
+	DCR_ACCESS_PROLOG(__mfdcr_table)
+
+_GLOBAL(__mtdcr)
+	DCR_ACCESS_PROLOG(__mtdcr_table)
+
+__mfdcr_table:
+	mfdcr  r3,0; blr
+__mtdcr_table:
+	mtdcr  0,r4; blr
+
+dcr     = 1
+        .rept   1023
+	mfdcr   r3,dcr; blr
+	mtdcr   dcr,r4; blr
+	dcr     = dcr + 1
+	.endr
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -86,8 +86,6 @@ endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_MPC10X_BRIDGE)	+= mpc10x_common.o ppc_sys.o
 obj-$(CONFIG_MPC10X_OPENPIC)	+= open_pic.o
-obj-$(CONFIG_40x)		+= dcr.o
-obj-$(CONFIG_BOOKE)		+= dcr.o
 obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o \
 					ppc_sys.o mpc85xx_sys.o \
 					mpc85xx_devices.o
diff --git a/arch/ppc/syslib/dcr.S b/arch/ppc/syslib/dcr.S
deleted file mode 100644
--- a/arch/ppc/syslib/dcr.S
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * arch/ppc/syslib/dcr.S
- *
- * "Indirect" DCR access
- *
- * Copyright (c) 2004 Eugene Surovegin <ebs@ebshome.net>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under  the terms of  the GNU General Public License as published by the
- * Free Software Foundation;  either version 2 of the License, or (at your
- * option) any later version.
- */
-
-#include <asm/ppc_asm.h>
-#include <asm/processor.h>
-
-#define DCR_ACCESS_PROLOG(table) \
-	rlwinm  r3,r3,4,18,27;   \
-	lis     r5,table@h;      \
-	ori     r5,r5,table@l;   \
-	add     r3,r3,r5;        \
-	mtctr   r3;              \
-	bctr
-
-_GLOBAL(__mfdcr)
-	DCR_ACCESS_PROLOG(__mfdcr_table)
-
-_GLOBAL(__mtdcr)
-	DCR_ACCESS_PROLOG(__mtdcr_table)
-
-__mfdcr_table:
-	mfdcr  r3,0; blr
-__mtdcr_table:
-	mtdcr  0,r4; blr
-
-dcr     = 1
-        .rept   1023
-	mfdcr   r3,dcr; blr
-	mtdcr   dcr,r4; blr
-	dcr     = dcr + 1
-	.endr
