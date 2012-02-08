Return-Path: <B32736@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6BBB2B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 20:55:27 +1100 (EST)
From: Zhicheng Fan <B32736@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2 v2] powerpc: Abstract common define of signal multiplex
 control for qe
Date: Wed, 8 Feb 2012 17:52:58 +0800
Message-ID: <1328694779-24024-1-git-send-email-B32736@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhicheng Fan <b32736@freeescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhicheng Fan <b32736@freeescale.com>

The mpc85xx_rdb and mpc85xx_mds have commom define of signal multiplex for qe ,so
they need to go in common header, the patch abstract them to fsl_guts.h

Signed-off-by: Zhicheng Fan <b32736@freeescale.com>
---
 arch/powerpc/include/asm/fsl_guts.h       |   19 +++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    7 ++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/asm/fsl_guts.h
index bebd124..efacfe3 100644
--- a/arch/powerpc/include/asm/fsl_guts.h
+++ b/arch/powerpc/include/asm/fsl_guts.h
@@ -114,6 +114,25 @@ struct ccsr_guts_86xx {
 	__be32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
 } __attribute__ ((packed));
 
+#ifdef CONFIG_PPC_85xx
+
+/* Alternate function signal multiplex control */
+#define MPC85xx_PMUXCR_OFFSET           0x60
+#define MPC85xx_PMUXCR_QE0              0x00008000
+#define MPC85xx_PMUXCR_QE2              0x00002000
+#define MPC85xx_PMUXCR_QE3              0x00001000
+#define MPC85xx_PMUXCR_QE4              0x00000800
+#define MPC85xx_PMUXCR_QE5              0x00000400
+#define MPC85xx_PMUXCR_QE6              0x00000200
+#define MPC85xx_PMUXCR_QE7              0x00000100
+#define MPC85xx_PMUXCR_QE8              0x00000080
+#define MPC85xx_PMUXCR_QE9              0x00000040
+#define MPC85xx_PMUXCR_QE10             0x00000020
+#define MPC85xx_PMUXCR_QE11             0x00000010
+#define MPC85xx_PMUXCR_QE12             0x00000008
+
+#endif
+
 #ifdef CONFIG_PPC_86xx
 
 #define CCSR_GUTS_DMACR_DEV_SSI	0	/* DMA controller/channel set to SSI */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 1d15a0c..1bd339a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -51,6 +51,7 @@
 #include <asm/qe_ic.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
+#include <asm/fsl_guts.h>
 #include "smp.h"
 
 #include "mpc85xx.h"
@@ -268,11 +269,7 @@ static void __init mpc85xx_mds_qe_init(void)
 	mpc85xx_mds_reset_ucc_phys();
 
 	if (machine_is(p1021_mds)) {
-#define MPC85xx_PMUXCR_OFFSET           0x60
-#define MPC85xx_PMUXCR_QE0              0x00008000
-#define MPC85xx_PMUXCR_QE3              0x00001000
-#define MPC85xx_PMUXCR_QE9              0x00000040
-#define MPC85xx_PMUXCR_QE12             0x00000008
+
 		static __be32 __iomem *pmuxcr;
 
 		np = of_find_node_by_name(NULL, "global-utilities");
-- 
1.7.0.4
