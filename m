Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A389DE02B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 00:22:32 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l9BEMRKU020268
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 09:22:28 -0500
Date: Thu, 11 Oct 2007 09:21:53 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] [POWERPC] 85xx: Killed <asm/mpc85xx.h>
Message-ID: <Pine.LNX.4.64.0710110921160.11335@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

asm-powerpc/mpc85xx.h was really a hold over from arch/ppc.  Now that
more decoupling has occurred we can remove <asm/mpc85xx.h> and some of
its legacy.

As part of this we moved the definition of CPM_MAP_ADDR into cpm2.h
for 85xx platforms.  This is a stop gap until drivers stop using
CPM_MAP_ADDR.

---

Feels good to remove code :)

 arch/powerpc/platforms/85xx/mpc8540_ads.h |   35 -----------------
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_ads.h |   60 -----------------------------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   10 ++++-
 arch/powerpc/platforms/85xx/mpc85xx_cds.h |   43 --------------------
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 -
 include/asm-powerpc/cpm2.h                |    4 ++
 include/asm-powerpc/fs_pd.h               |    2 -
 include/asm-powerpc/mpc85xx.h             |   45 ---------------------
 10 files changed, 13 insertions(+), 189 deletions(-)
 delete mode 100644 arch/powerpc/platforms/85xx/mpc8540_ads.h
 delete mode 100644 arch/powerpc/platforms/85xx/mpc85xx_ads.h
 delete mode 100644 arch/powerpc/platforms/85xx/mpc85xx_cds.h
 delete mode 100644 include/asm-powerpc/mpc85xx.h

diff --git a/arch/powerpc/platforms/85xx/mpc8540_ads.h b/arch/powerpc/platforms/85xx/mpc8540_ads.h
deleted file mode 100644
index da82f4c..0000000
--- a/arch/powerpc/platforms/85xx/mpc8540_ads.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * arch/powerpc/platforms/85xx/mpc8540_ads.h
- *
- * MPC8540ADS board definitions
- *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
- *
- * Copyright 2004 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-#ifndef __MACH_MPC8540ADS_H__
-#define __MACH_MPC8540ADS_H__
-
-#include <linux/initrd.h>
-
-#define BOARD_CCSRBAR		((uint)0xe0000000)
-#define BCSR_ADDR		((uint)0xf8000000)
-#define BCSR_SIZE		((uint)(32 * 1024))
-
-/* PCI interrupt controller */
-#define PIRQA		MPC85xx_IRQ_EXT1
-#define PIRQB		MPC85xx_IRQ_EXT2
-#define PIRQC		MPC85xx_IRQ_EXT3
-#define PIRQD		MPC85xx_IRQ_EXT4
-
-/* Offset of CPM register space */
-#define CPM_MAP_ADDR	(CCSRBAR + MPC85xx_CPM_OFFSET)
-
-#endif				/* __MACH_MPC8540ADS_H__ */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 509d46b..bccdc25 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -23,7 +23,6 @@
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
-#include <asm/mpc85xx.h>
 #include <asm/mpic.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.h b/arch/powerpc/platforms/85xx/mpc85xx_ads.h
deleted file mode 100644
index 46c3532..0000000
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * MPC85xx ADS board definitions
- *
- * Maintainer: Kumar Gala <galak@kernel.crashing.org>
- *
- * Copyright 2004 Freescale Semiconductor Inc.
- *
- * 2006 (c) MontaVista Software, Inc.
- * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-#ifndef __MACH_MPC85XXADS_H
-#define __MACH_MPC85XXADS_H
-
-#include <linux/initrd.h>
-#include <sysdev/fsl_soc.h>
-
-#define BCSR_ADDR		((uint)0xf8000000)
-#define BCSR_SIZE		((uint)(32 * 1024))
-
-#ifdef CONFIG_CPM2
-
-#define MPC85xx_CPM_OFFSET	(0x80000)
-
-#define CPM_MAP_ADDR		(get_immrbase() + MPC85xx_CPM_OFFSET)
-#define CPM_IRQ_OFFSET		60
-
-#define SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
-#define SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
-
-/* FCC1 Clock Source Configuration.  These can be
- * redefined in the board specific file.
- *    Can only choose from CLK9-12 */
-#define F1_RXCLK       12
-#define F1_TXCLK       11
-
-/* FCC2 Clock Source Configuration.  These can be
- * redefined in the board specific file.
- *    Can only choose from CLK13-16 */
-#define F2_RXCLK       13
-#define F2_TXCLK       14
-
-/* FCC3 Clock Source Configuration.  These can be
- * redefined in the board specific file.
- *    Can only choose from CLK13-16 */
-#define F3_RXCLK       15
-#define F3_TXCLK       16
-
-#endif	/* CONFIG_CPM2 */
-#endif	/* __MACH_MPC85XXADS_H */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index afe5868..4d063ee 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -36,7 +36,6 @@
 #include <asm/machdep.h>
 #include <asm/ipic.h>
 #include <asm/pci-bridge.h>
-#include <asm/mpc85xx.h>
 #include <asm/irq.h>
 #include <mm/mmu_decl.h>
 #include <asm/prom.h>
@@ -47,6 +46,15 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>

+/* CADMUS info */
+/* xxx - galak, move into device tree */
+#define CADMUS_BASE (0xf8004000)
+#define CADMUS_SIZE (256)
+#define CM_VER	(0)
+#define CM_CSR	(1)
+#define CM_RST	(2)
+
+
 static int cds_pci_slot = 2;
 static volatile u8 *cadmus;

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.h b/arch/powerpc/platforms/85xx/mpc85xx_cds.h
deleted file mode 100644
index b251c9f..0000000
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * arch/powerpc/platforms/85xx/mpc85xx_cds.h
- *
- * MPC85xx CDS board definitions
- *
- * Maintainer: Kumar Gala <galak@kernel.crashing.org>
- *
- * Copyright 2004 Freescale Semiconductor, Inc
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-#ifndef __MACH_MPC85XX_CDS_H__
-#define __MACH_MPC85XX_CDS_H__
-
-/* CADMUS info */
-#define CADMUS_BASE (0xf8004000)
-#define CADMUS_SIZE (256)
-#define CM_VER	(0)
-#define CM_CSR	(1)
-#define CM_RST	(2)
-
-/* CDS NVRAM/RTC */
-#define CDS_RTC_ADDR	(0xf8000000)
-#define CDS_RTC_SIZE	(8 * 1024)
-
-/* PCI interrupt controller */
-#define PIRQ0A			MPC85xx_IRQ_EXT0
-#define PIRQ0B			MPC85xx_IRQ_EXT1
-#define PIRQ0C			MPC85xx_IRQ_EXT2
-#define PIRQ0D			MPC85xx_IRQ_EXT3
-#define PIRQ1A			MPC85xx_IRQ_EXT11
-
-#define NR_8259_INTS		16
-#define CPM_IRQ_OFFSET		NR_8259_INTS
-
-#define MPC85xx_OPENPIC_IRQ_OFFSET	80
-
-#endif /* __MACH_MPC85XX_CDS_H__ */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 772e8de..59c121a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -24,7 +24,6 @@
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
-#include <asm/mpc85xx.h>
 #include <mm/mmu_decl.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 6913e99..61b3eed 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -39,7 +39,6 @@
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
-#include <asm/mpc85xx.h>
 #include <asm/irq.h>
 #include <mm/mmu_decl.h>
 #include <asm/prom.h>
diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
index e698b1d..f1112c1 100644
--- a/include/asm-powerpc/cpm2.h
+++ b/include/asm-powerpc/cpm2.h
@@ -13,6 +13,10 @@
 #include <asm/immap_cpm2.h>
 #include <asm/cpm.h>

+#ifdef CONFIG_PPC_85xx
+#define CPM_MAP_ADDR (get_immrbase() + 0x80000)
+#endif
+
 /* CPM Command register.
 */
 #define CPM_CR_RST	((uint)0x80000000)
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index 64706a0..9361cd5 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -19,8 +19,6 @@

 #if defined(CONFIG_8260)
 #include <asm/mpc8260.h>
-#elif defined(CONFIG_85xx)
-#include <asm/mpc85xx.h>
 #endif

 #define cpm2_map(member) (&cpm2_immr->member)
diff --git a/include/asm-powerpc/mpc85xx.h b/include/asm-powerpc/mpc85xx.h
deleted file mode 100644
index 5414299..0000000
--- a/include/asm-powerpc/mpc85xx.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * include/asm-powerpc/mpc85xx.h
- *
- * MPC85xx definitions
- *
- * Maintainer: Kumar Gala <galak@kernel.crashing.org>
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
-#ifndef __ASM_MPC85xx_H__
-#define __ASM_MPC85xx_H__
-
-#include <asm/mmu.h>
-
-#ifdef CONFIG_85xx
-
-#if defined(CONFIG_MPC8540_ADS) || defined(CONFIG_MPC8560_ADS)
-#include <platforms/85xx/mpc85xx_ads.h>
-#endif
-#if defined(CONFIG_MPC8555_CDS) || defined(CONFIG_MPC8548_CDS)
-#include <platforms/85xx/mpc8555_cds.h>
-#endif
-#ifdef CONFIG_MPC85xx_CDS
-#include <platforms/85xx/mpc85xx_cds.h>
-#endif
-
-/* Let modules/drivers get at CCSRBAR */
-extern phys_addr_t get_ccsrbar(void);
-
-#ifdef MODULE
-#define CCSRBAR get_ccsrbar()
-#else
-#define CCSRBAR BOARD_CCSRBAR
-#endif
-
-#endif /* CONFIG_85xx */
-#endif /* __ASM_MPC85xx_H__ */
-#endif /* __KERNEL__ */
-- 
1.5.2.4
