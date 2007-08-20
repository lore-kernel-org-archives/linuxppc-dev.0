Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9438ADDDD8
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 23:57:17 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l7KDvD9I023535
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 08:57:14 -0500
Date: Mon, 20 Aug 2007 08:57:29 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3 v3] Remove old includes from arch/ppc
In-Reply-To: <Pine.LNX.4.64.0708200854160.16444@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0708200856510.16457@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708200854160.16444@blarg.am.freescale.net>
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

Remove includes of files that existed in arch/ppc that we dont need in
arch/powerpc anymore.  The following includes were removed:

 <asm/amigappc.h>
 <asm/bootinfo.h>
 <asm/ppcboot.h>
 <asm/ppc_sys.h>
 <asm/residual.h>
 <asm/m8260_pci.h>

This also caused platforms/embedded6xx/mpc7448_hpc2.h to no longer be
needed and thus removed.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_32.c                    |    2 --
 arch/powerpc/platforms/52xx/lite5200.c            |    1 -
 arch/powerpc/platforms/82xx/m82xx_pci.h           |    2 --
 arch/powerpc/platforms/82xx/mpc82xx.c             |    1 -
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |    1 -
 arch/powerpc/platforms/82xx/pq2ads.h              |    1 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c         |    1 -
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |    1 -
 arch/powerpc/platforms/83xx/mpc834x_mds.c         |    1 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c         |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |    1 -
 arch/powerpc/platforms/8xx/m8xx_setup.c           |    4 ++--
 arch/powerpc/platforms/8xx/mpc86xads.h            |    1 -
 arch/powerpc/platforms/8xx/mpc86xads_setup.c      |    1 -
 arch/powerpc/platforms/8xx/mpc885ads.h            |    1 -
 arch/powerpc/platforms/8xx/mpc885ads_setup.c      |    1 -
 arch/powerpc/platforms/chrp/smp.c                 |    1 -
 arch/powerpc/platforms/embedded6xx/ls_uart.c      |    1 -
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    1 -
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h |   21 ---------------------
 arch/powerpc/platforms/powermac/bootx_init.c      |    1 -
 22 files changed, 2 insertions(+), 45 deletions(-)
 delete mode 100644 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 7ec6ba5..a288a5f 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -18,13 +18,11 @@
 #include <linux/cpu.h>
 #include <linux/console.h>

-#include <asm/residual.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
 #include <asm/pgtable.h>
 #include <asm/setup.h>
-#include <asm/amigappc.h>
 #include <asm/smp.h>
 #include <asm/elf.h>
 #include <asm/cputable.h>
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 84bd3da..ce3f695 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -35,7 +35,6 @@
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/bootinfo.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/82xx/m82xx_pci.h b/arch/powerpc/platforms/82xx/m82xx_pci.h
index 9cd8893..65e38a7 100644
--- a/arch/powerpc/platforms/82xx/m82xx_pci.h
+++ b/arch/powerpc/platforms/82xx/m82xx_pci.h
@@ -8,8 +8,6 @@
  * 2 of the License, or (at your option) any later version.
  */

-#include <asm/m8260_pci.h>
-
 #define SIU_INT_IRQ1   ((uint)0x13 + CPM_IRQ_OFFSET)

 #ifndef _IO_BASE
diff --git a/arch/powerpc/platforms/82xx/mpc82xx.c b/arch/powerpc/platforms/82xx/mpc82xx.c
index cc9900d..c706871 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx.c
@@ -36,7 +36,6 @@
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
 #include <asm/mpc8260.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index 2d1b05b..c0a0c56 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -37,7 +37,6 @@
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
 #include <asm/mpc8260.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h b/arch/powerpc/platforms/82xx/pq2ads.h
index 5b5cca6..6f749b7 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -23,7 +23,6 @@
 #define __MACH_ADS8260_DEFS

 #include <linux/seq_file.h>
-#include <asm/ppcboot.h>

 /* For our show_cpuinfo hooks. */
 #define CPUINFO_VENDOR		"Freescale Semiconductor"
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 2c8e641..61e3f1c 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -32,7 +32,6 @@
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/bootinfo.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 47ba544..6d06645 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -30,7 +30,6 @@
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/bootinfo.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 4c9ff9c..f8aba9a 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -30,7 +30,6 @@
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/bootinfo.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 84b5893..69970b9 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -38,7 +38,6 @@
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/bootinfo.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 6a171e9..0402334 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -35,7 +35,6 @@
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
 #include <asm/mpc85xx.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index be25ecd..53830c9 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -38,7 +38,6 @@
 #include <asm/time.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
 #include <asm/mpc85xx.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index f169355..f00c8d1 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -36,13 +36,11 @@

 #include <asm/mmu.h>
 #include <asm/reg.h>
-#include <asm/residual.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
 #include <asm/machdep.h>
-#include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/prom.h>
 #include <asm/fs_pd.h>
@@ -55,7 +53,9 @@ struct mpc8xx_pcmcia_ops m8xx_pcmcia_ops;
 #endif

 void m8xx_calibrate_decr(void);
+#ifdef CONFIG_8xx_WDT
 extern void m8xx_wdt_handler_install(bd_t *bp);
+#endif
 extern int cpm_pic_init(void);
 extern int cpm_get_irq(void);

diff --git a/arch/powerpc/platforms/8xx/mpc86xads.h b/arch/powerpc/platforms/8xx/mpc86xads.h
index 59bad2f..dd10cd2 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads.h
+++ b/arch/powerpc/platforms/8xx/mpc86xads.h
@@ -15,7 +15,6 @@
 #ifndef __ASM_MPC86XADS_H__
 #define __ASM_MPC86XADS_H__

-#include <asm/ppcboot.h>
 #include <sysdev/fsl_soc.h>

 /* U-Boot maps BCSR to 0xff080000 */
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index d881647..8f64f48 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -31,7 +31,6 @@
 #include <asm/processor.h>
 #include <asm/system.h>
 #include <asm/time.h>
-#include <asm/ppcboot.h>
 #include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
 #include <asm/commproc.h>
diff --git a/arch/powerpc/platforms/8xx/mpc885ads.h b/arch/powerpc/platforms/8xx/mpc885ads.h
index 7c31aec..14db124 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads.h
+++ b/arch/powerpc/platforms/8xx/mpc885ads.h
@@ -15,7 +15,6 @@
 #ifndef __ASM_MPC885ADS_H__
 #define __ASM_MPC885ADS_H__

-#include <asm/ppcboot.h>
 #include <sysdev/fsl_soc.h>

 /* U-Boot maps BCSR to 0xff080000 */
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index bd5ff7a..d3da385 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -32,7 +32,6 @@
 #include <asm/processor.h>
 #include <asm/system.h>
 #include <asm/time.h>
-#include <asm/ppcboot.h>
 #include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
 #include <asm/commproc.h>
diff --git a/arch/powerpc/platforms/chrp/smp.c b/arch/powerpc/platforms/chrp/smp.c
index a137d13..10a4a4d 100644
--- a/arch/powerpc/platforms/chrp/smp.c
+++ b/arch/powerpc/platforms/chrp/smp.c
@@ -26,7 +26,6 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
-#include <asm/residual.h>
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/mpic.h>
diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index d0bee9f..f7a4def 100644
--- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
+++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
@@ -5,7 +5,6 @@
 #include <linux/serial_8250.h>
 #include <asm/io.h>
 #include <asm/mpc10x.h>
-#include <asm/ppc_sys.h>
 #include <asm/prom.h>
 #include <asm/termbits.h>

diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 25c29bc..96737e5 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -40,7 +40,6 @@
 #include <asm/pci-bridge.h>
 #include <asm/reg.h>
 #include <mm/mmu_decl.h>
-#include "mpc7448_hpc2.h"
 #include <asm/tsi108_pci.h>
 #include <asm/tsi108_irq.h>
 #include <asm/mpic.h>
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h
deleted file mode 100644
index f7e0e0c..0000000
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * mpc7448_hpc2.h
- *
- * Definitions for Freescale MPC7448_HPC2 platform
- *
- * Author: Jacob Pan
- *         jacob.pan@freescale.com
- * Maintainer: Roy Zang <roy.zang@freescale.com>
- *
- * 2006 (c) Freescale Semiconductor, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#ifndef __PPC_PLATFORMS_MPC7448_HPC2_H
-#define __PPC_PLATFORMS_MPC7448_HPC2_H
-
-#include <asm/ppcboot.h>
-
-#endif				/* __PPC_PLATFORMS_MPC7448_HPC2_H */
diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index 9d73d02..cf66091 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -17,7 +17,6 @@
 #include <asm/prom.h>
 #include <asm/page.h>
 #include <asm/bootx.h>
-#include <asm/bootinfo.h>
 #include <asm/btext.h>
 #include <asm/io.h>

-- 
1.5.2.2
