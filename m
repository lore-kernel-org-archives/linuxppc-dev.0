Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsW5537wtzDqMB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 12:50:33 +1000 (AEST)
From: Scott Wood <oss@buserror.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Scott Wood <oss@buserror.net>
Date: Sat, 16 Jul 2016 21:50:21 -0500
Message-Id: <1468723822-30457-5-git-send-email-oss@buserror.net>
In-Reply-To: <1468723822-30457-1-git-send-email-oss@buserror.net>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
Subject: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: yangbo lu <yangbo.lu@nxp.com>

Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a common
header file.  This SVR numberspace is used on some ARM chips as well as
PPC, and even to check for a PPC SVR multi-arch drivers would otherwise
need to ifdef the header inclusion and all references to the SVR symbols.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
[scottwood: update description]
Signed-off-by: Scott Wood <oss@buserror.net>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S                     | 2 +-
 arch/powerpc/sysdev/fsl_pci.c                                 | 2 +-
 drivers/clk/clk-qoriq.c                                       | 3 +--
 drivers/i2c/busses/i2c-mpc.c                                  | 2 +-
 drivers/iommu/fsl_pamu.c                                      | 3 +--
 drivers/net/ethernet/freescale/gianfar.c                      | 2 +-
 arch/powerpc/include/asm/mpc85xx.h => include/linux/fsl/svr.h | 4 ++--
 7 files changed, 8 insertions(+), 10 deletions(-)
 rename arch/powerpc/include/asm/mpc85xx.h => include/linux/fsl/svr.h (97%)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 462aed9..2b0284e 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -13,13 +13,13 @@
  *
  */
 
+#include <linux/fsl/svr.h>
 #include <asm/page.h>
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
 #include <asm/mmu-book3e.h>
 #include <asm/asm-offsets.h>
-#include <asm/mpc85xx.h>
 
 _GLOBAL(__e500_icache_setup)
 	mfspr	r0, SPRN_L1CSR1
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 0ef9df4..0fd1895 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/fsl/edac.h>
+#include <linux/fsl/svr.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/memblock.h>
@@ -37,7 +38,6 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
 #include <asm/machdep.h>
-#include <asm/mpc85xx.h>
 #include <asm/disassemble.h>
 #include <asm/ppc-opcode.h>
 #include <sysdev/fsl_soc.h>
diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 58566a17..4b6c438 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/fsl/guts.h>
+#include <linux/fsl/svr.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -1149,8 +1150,6 @@ bad_args:
 }
 
 #ifdef CONFIG_PPC
-#include <asm/mpc85xx.h>
-
 static const u32 a4510_svrs[] __initconst = {
 	(SVR_P2040 << 8) | 0x10,	/* P2040 1.0 */
 	(SVR_P2040 << 8) | 0x11,	/* P2040 1.1 */
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 48ecffe..600704c 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -27,9 +27,9 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/fsl/svr.h>
 
 #include <asm/mpc52xx.h>
-#include <asm/mpc85xx.h>
 #include <sysdev/fsl_soc.h>
 
 #define DRV_NAME "mpc-i2c"
diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index a34355f..af8fb27 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -21,11 +21,10 @@
 #include "fsl_pamu.h"
 
 #include <linux/fsl/guts.h>
+#include <linux/fsl/svr.h>
 #include <linux/interrupt.h>
 #include <linux/genalloc.h>
 
-#include <asm/mpc85xx.h>
-
 /* define indexes for each operation mapping scenario */
 #define OMI_QMAN        0x00
 #define OMI_FMAN        0x01
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 2e6785b..450d31f 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -86,11 +86,11 @@
 #include <linux/udp.h>
 #include <linux/in.h>
 #include <linux/net_tstamp.h>
+#include <linux/fsl/svr.h>
 
 #include <asm/io.h>
 #ifdef CONFIG_PPC
 #include <asm/reg.h>
-#include <asm/mpc85xx.h>
 #endif
 #include <asm/irq.h>
 #include <asm/uaccess.h>
diff --git a/arch/powerpc/include/asm/mpc85xx.h b/include/linux/fsl/svr.h
similarity index 97%
rename from arch/powerpc/include/asm/mpc85xx.h
rename to include/linux/fsl/svr.h
index 213f3a8..8d13836 100644
--- a/arch/powerpc/include/asm/mpc85xx.h
+++ b/include/linux/fsl/svr.h
@@ -9,8 +9,8 @@
  * (at your option) any later version.
  */
 
-#ifndef __ASM_PPC_MPC85XX_H
-#define __ASM_PPC_MPC85XX_H
+#ifndef FSL_SVR_H
+#define FSL_SVR_H
 
 #define SVR_REV(svr)	((svr) & 0xFF)		/* SOC design resision */
 #define SVR_MAJ(svr)	(((svr) >>  4) & 0xF)	/* Major revision field*/
-- 
2.7.4
