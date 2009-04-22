Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 879CEDE0BE
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 03:34:55 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n3MHYpuq022092
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 12:34:52 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/86xx: clean up smp init code
Date: Wed, 22 Apr 2009 12:34:51 -0500
Message-Id: <1240421691-10193-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removed the need for asm/mpc86xx.h as it was only used in mpc86xx_smp.c
and just moved the defines it cared about into there.  Also fixed up
the ioremap to only map the one 4k page we need access to and to iounmap
when we are done.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/mpc86xx.h         |   33 ----------------------------
 arch/powerpc/platforms/86xx/gef_ppc9a.c    |    1 -
 arch/powerpc/platforms/86xx/gef_sbc310.c   |    1 -
 arch/powerpc/platforms/86xx/gef_sbc610.c   |    1 -
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    1 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 -
 arch/powerpc/platforms/86xx/mpc86xx_smp.c  |    8 ++++++-
 arch/powerpc/platforms/86xx/sbc8641d.c     |    1 -
 8 files changed, 7 insertions(+), 40 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/mpc86xx.h

diff --git a/arch/powerpc/include/asm/mpc86xx.h b/arch/powerpc/include/asm/mpc86xx.h
deleted file mode 100644
index 15f650f..0000000
--- a/arch/powerpc/include/asm/mpc86xx.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * MPC86xx definitions
- *
- * Author: Jeff Brown
- *
- * Copyright 2004 Freescale Semiconductor, Inc
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#ifdef __KERNEL__
-#ifndef __ASM_POWERPC_MPC86xx_H__
-#define __ASM_POWERPC_MPC86xx_H__
-
-#include <asm/mmu.h>
-
-#ifdef CONFIG_PPC_86xx
-
-#define CPU0_BOOT_RELEASE 0x01000000
-#define CPU1_BOOT_RELEASE 0x02000000
-#define CPU_ALL_RELEASED (CPU0_BOOT_RELEASE | CPU1_BOOT_RELEASE)
-#define MCM_PORT_CONFIG_OFFSET 0x1010
-
-/* Offset from CCSRBAR */
-#define MPC86xx_MCM_OFFSET      (0x00000)
-#define MPC86xx_MCM_SIZE        (0x02000)
-
-#endif /* CONFIG_PPC_86xx */
-#endif /* __ASM_POWERPC_MPC86xx_H__ */
-#endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c b/arch/powerpc/platforms/86xx/gef_ppc9a.c
index d791046..2efa052 100644
--- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
+++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
@@ -28,7 +28,6 @@
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
-#include <asm/mpc86xx.h>
 #include <asm/prom.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index af14f85..90754e7 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -28,7 +28,6 @@
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
-#include <asm/mpc86xx.h>
 #include <asm/prom.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index ea23606..72b31a6 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -28,7 +28,6 @@
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
-#include <asm/mpc86xx.h>
 #include <asm/prom.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 3f49a6f..51eec0c 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -28,7 +28,6 @@
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
-#include <asm/mpc86xx.h>
 #include <asm/prom.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index c4ec49b..7e9e83c 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -24,7 +24,6 @@
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
-#include <asm/mpc86xx.h>
 #include <asm/prom.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
index 014e26c..d84bbb5 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
@@ -20,7 +20,6 @@
 #include <asm/pgtable.h>
 #include <asm/pci-bridge.h>
 #include <asm/mpic.h>
-#include <asm/mpc86xx.h>
 #include <asm/cacheflush.h>
 
 #include <sysdev/fsl_soc.h>
@@ -30,6 +29,11 @@
 extern void __secondary_start_mpc86xx(void);
 extern unsigned long __secondary_hold_acknowledge;
 
+#define MCM_PORT_CONFIG_OFFSET	0x10
+
+/* Offset from CCSRBAR */
+#define MPC86xx_MCM_OFFSET      (0x1000)
+#define MPC86xx_MCM_SIZE        (0x1000)
 
 static void __init
 smp_86xx_release_core(int nr)
@@ -48,6 +52,8 @@ smp_86xx_release_core(int nr)
 	pcr = in_be32(mcm_vaddr + (MCM_PORT_CONFIG_OFFSET >> 2));
 	pcr |= 1 << (nr + 24);
 	out_be32(mcm_vaddr + (MCM_PORT_CONFIG_OFFSET >> 2), pcr);
+
+	iounmap(mcm_vaddr);
 }
 
 
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index 2886a36..51c8f33 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -25,7 +25,6 @@
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
-#include <asm/mpc86xx.h>
 #include <asm/prom.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
-- 
1.6.0.6
