Return-Path: <yangbo.lu@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0084.outbound.protection.outlook.com [207.46.100.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r03ZV0xfpzDqKg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 13:34:57 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <netdev@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, Scott Wood <oss@buserror.net>, Mark Rutland
 <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King
 <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>, Joerg Roedel
 <joro@8bytes.org>, Claudiu Manoil <claudiu.manoil@freescale.com>, "Bhupesh
 Sharma" <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 "Kumar Gala" <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 <leoyang.li@nxp.com>, <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v9, 5/7] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Wed, 4 May 2016 11:24:32 +0800
Message-ID: <1462332274-13744-6-git-send-email-yangbo.lu@nxp.com>
In-Reply-To: <1462332274-13744-1-git-send-email-yangbo.lu@nxp.com>
References: <1462332274-13744-1-git-send-email-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move mpc85xx.h to include/linux/fsl and rename it to svr.h as
a common header file. It has been used for mpc85xx and it will
be used for ARM-based SoC as well.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Scott Wood <oss@buserror.net>
Acked-by: Joerg Roedel <jroedel@suse.de>
---
Changes for v2:
	- None
Changes for v3:
	- None
Changes for v4:
	- None
Changes for v5:
	- Changed to Move mpc85xx.h to include/linux/fsl/
	- Adjusted '#include <linux/fsl/svr.h>' position in file
Changes for v6:
	- None
Changes for v7:
	- Added 'Acked-by: Wolfram Sang' for I2C part
	- Also applied to arch/powerpc/kernel/cpu_setup_fsl_booke.S
Changes for v8:
	- Added 'Acked-by: Stephen Boyd' for clk part
	- Added 'Acked-by: Scott Wood'
	- Added 'Acked-by: Joerg Roedel' for iommu part
Changes for v9:
	- None
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S                     | 2 +-
 drivers/clk/clk-qoriq.c                                       | 3 +--
 drivers/i2c/busses/i2c-mpc.c                                  | 2 +-
 drivers/iommu/fsl_pamu.c                                      | 3 +--
 drivers/net/ethernet/freescale/gianfar.c                      | 2 +-
 arch/powerpc/include/asm/mpc85xx.h => include/linux/fsl/svr.h | 4 ++--
 6 files changed, 7 insertions(+), 9 deletions(-)
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
diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 7bc1c45..fc7f722 100644
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
@@ -1148,8 +1149,6 @@ bad_args:
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
index d2f917a..2224b10 100644
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
2.1.0.27.g96db324
