Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A5E2767BC5
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 07:02:30 +1000 (EST)
Date: Thu, 28 Sep 2006 16:02:26 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 2/2] add mpc83xx.h to powerpc include proper
Message-Id: <20060928160226.4dca5b8c.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

add mpc83xx.h to powerpc include proper, rm defines in board header files replaced by the dt.  This completes 83xx transition to ARCH=powerpc.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 arch/powerpc/platforms/83xx/mpc834x_itx.h |    5 -----
 arch/powerpc/platforms/83xx/mpc834x_sys.h |    7 +------
 include/asm-powerpc/mpc83xx.h             |   30 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.h b/arch/powerpc/platforms/83xx/mpc834x_itx.h
index 174ca4e..88932d2 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.h
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.h
@@ -15,9 +15,4 @@
 #ifndef __MACH_MPC83XX_ITX_H__
 #define __MACH_MPC83XX_ITX_H__
 
-#define PIRQA	MPC83xx_IRQ_EXT4
-#define PIRQB	MPC83xx_IRQ_EXT5
-#define PIRQC	MPC83xx_IRQ_EXT6
-#define PIRQD	MPC83xx_IRQ_EXT7
-
 #endif				/* __MACH_MPC83XX_ITX_H__ */
diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.h b/arch/powerpc/platforms/83xx/mpc834x_sys.h
index fedecb7..8ec5f2f 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.h
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.h
@@ -1,5 +1,5 @@
 /*
- * arch/powerppc/platforms/83xx/mpc834x_sys.h
+ * arch/powerpc/platforms/83xx/mpc834x_sys.h
  *
  * MPC834X SYS common board definitions
  *
@@ -15,9 +15,4 @@
 #ifndef __MACH_MPC83XX_SYS_H__
 #define __MACH_MPC83XX_SYS_H__
 
-#define PIRQA	MPC83xx_IRQ_EXT4
-#define PIRQB	MPC83xx_IRQ_EXT5
-#define PIRQC	MPC83xx_IRQ_EXT6
-#define PIRQD	MPC83xx_IRQ_EXT7
-
 #endif				/* __MACH_MPC83XX_SYS_H__ */
diff --git a/include/asm-powerpc/mpc83xx.h b/include/asm-powerpc/mpc83xx.h
new file mode 100644
index 0000000..5773cba
--- /dev/null
+++ b/include/asm-powerpc/mpc83xx.h
@@ -0,0 +1,30 @@
+/*
+ * include/asm-powerpc/mpc83xx.h
+ *
+ * MPC83xx definitions
+ *
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
+ *
+ * Copyright 2005 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_MPC83xx_H__
+#define __ASM_MPC83xx_H__
+
+#include <asm/mmu.h>
+
+#ifdef CONFIG_83xx
+
+#ifdef CONFIG_MPC834x_SYS
+#include <platforms/83xx/mpc834x_sys.h>
+#endif
+
+#endif /* CONFIG_83xx */
+#endif /* __ASM_MPC83xx_H__ */
+#endif /* __KERNEL__ */
-- 
1.4.2.1
