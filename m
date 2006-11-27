Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id A13B967C14
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:17:24 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/9] [POWERPC] Separate IRQ config / register set from main
	header
Date: Mon, 27 Nov 2006 14:16:26 -0700
Message-Id: <1164662207513-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11646622072999-git-send-email-grant.likely@secretlab.ca>
References: <1164662190802-git-send-email-grant.likely@secretlab.ca>
	<11646622052490-git-send-email-grant.likely@secretlab.ca>
	<11646622063980-git-send-email-grant.likely@secretlab.ca>
	<11646622073115-git-send-email-grant.likely@secretlab.ca>
	<11646622072999-git-send-email-grant.likely@secretlab.ca>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sylvain Munaut <tnt@246tNt.com>

There is no need to expose theses settings outside the scope
of the interrupt controller code itself.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_pic.h |   53 +++++++++++++++++++++++++++++
 include/asm-powerpc/mpc52xx.h             |   37 --------------------
 3 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 6df51f0..504154f 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -33,6 +33,7 @@ #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/mpc52xx.h>
+#include "mpc52xx_pic.h"
 
 /*
  *
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.h b/arch/powerpc/platforms/52xx/mpc52xx_pic.h
new file mode 100644
index 0000000..1a26bcd
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.h
@@ -0,0 +1,53 @@
+/*
+ * Header file for Freescale MPC52xx Interrupt controller
+ *
+ * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 MontaVista, Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __POWERPC_SYSDEV_MPC52xx_PIC_H__
+#define __POWERPC_SYSDEV_MPC52xx_PIC_H__
+
+#include <asm/types.h>
+
+
+/* HW IRQ mapping */
+#define MPC52xx_IRQ_L1_CRIT	(0)
+#define MPC52xx_IRQ_L1_MAIN	(1)
+#define MPC52xx_IRQ_L1_PERP	(2)
+#define MPC52xx_IRQ_L1_SDMA	(3)
+
+#define MPC52xx_IRQ_L1_OFFSET   (6)
+#define MPC52xx_IRQ_L1_MASK     (0x00c0)
+
+#define MPC52xx_IRQ_L2_OFFSET   (0)
+#define MPC52xx_IRQ_L2_MASK     (0x003f)
+
+#define MPC52xx_IRQ_HIGHTESTHWIRQ (0xd0)
+
+
+/* Interrupt controller Register set */
+struct mpc52xx_intr {
+	u32 per_mask;		/* INTR + 0x00 */
+	u32 per_pri1;		/* INTR + 0x04 */
+	u32 per_pri2;		/* INTR + 0x08 */
+	u32 per_pri3;		/* INTR + 0x0c */
+	u32 ctrl;		/* INTR + 0x10 */
+	u32 main_mask;		/* INTR + 0x14 */
+	u32 main_pri1;		/* INTR + 0x18 */
+	u32 main_pri2;		/* INTR + 0x1c */
+	u32 reserved1;		/* INTR + 0x20 */
+	u32 enc_status;		/* INTR + 0x24 */
+	u32 crit_status;	/* INTR + 0x28 */
+	u32 main_status;	/* INTR + 0x2c */
+	u32 per_status;		/* INTR + 0x30 */
+	u32 reserved2;		/* INTR + 0x34 */
+	u32 per_error;		/* INTR + 0x38 */
+};
+
+#endif /* __POWERPC_SYSDEV_MPC52xx_PIC_H__ */
+
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index e9aa622..fff752c 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -20,48 +20,11 @@ #endif /* __ASSEMBLY__ */
 
 
 /* ======================================================================== */
-/* HW IRQ mapping                                                           */
-/* ======================================================================== */
-
-#define MPC52xx_IRQ_L1_CRIT		(0)
-#define MPC52xx_IRQ_L1_MAIN		(1)
-#define MPC52xx_IRQ_L1_PERP		(2)
-#define MPC52xx_IRQ_L1_SDMA		(3)
-
-#define MPC52xx_IRQ_L1_OFFSET		(6)
-#define MPC52xx_IRQ_L1_MASK		(0xc0)
-
-#define MPC52xx_IRQ_L2_OFFSET		(0)
-#define MPC52xx_IRQ_L2_MASK		(0x3f)
-
-#define MPC52xx_IRQ_HIGHTESTHWIRQ	(0xd0)
-
-
-/* ======================================================================== */
 /* Structures mapping of some unit register set                             */
 /* ======================================================================== */
 
 #ifndef __ASSEMBLY__
 
-/* Interrupt controller Register set */
-struct mpc52xx_intr {
-	u32 per_mask;		/* INTR + 0x00 */
-	u32 per_pri1;		/* INTR + 0x04 */
-	u32 per_pri2;		/* INTR + 0x08 */
-	u32 per_pri3;		/* INTR + 0x0c */
-	u32 ctrl;		/* INTR + 0x10 */
-	u32 main_mask;		/* INTR + 0x14 */
-	u32 main_pri1;		/* INTR + 0x18 */
-	u32 main_pri2;		/* INTR + 0x1c */
-	u32 reserved1;		/* INTR + 0x20 */
-	u32 enc_status;		/* INTR + 0x24 */
-	u32 crit_status;	/* INTR + 0x28 */
-	u32 main_status;	/* INTR + 0x2c */
-	u32 per_status;		/* INTR + 0x30 */
-	u32 reserved2;		/* INTR + 0x34 */
-	u32 per_error;		/* INTR + 0x38 */
-};
-
 /* Memory Mapping Control */
 struct mpc52xx_mmap_ctl {
 	u32 mbar;		/* MMAP_CTRL + 0x00 */
-- 
1.4.3.rc2.g0503
