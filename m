Return-Path: <B32736@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 56F52B6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2012 16:49:36 +1100 (EST)
From: Zhicheng Fan <B32736@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 2/2 v6] powerpc/85xx: Abstract common define of signal
 multiplex control for qe
Date: Wed, 22 Feb 2012 13:44:07 +0800
Message-ID: <1329889447-1756-2-git-send-email-B32736@freescale.com>
In-Reply-To: <1329889447-1756-1-git-send-email-B32736@freescale.com>
References: <1329889447-1756-1-git-send-email-B32736@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhicheng Fan <b32736@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhicheng Fan <b32736@freescale.com>

The mpc85xx_rdb and mpc85xx_mds have commom define of signal multiplex for qe, so
they need to go in common header, the patch abstract them to fsl_guts.h

Signed-off-by: Zhicheng Fan <b32736@freescale.com>
---
 arch/powerpc/include/asm/fsl_guts.h       |    6 ++++-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |   35 ++++++++++++----------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/asm/fsl_guts.h
index bebd124..ce04530 100644
--- a/arch/powerpc/include/asm/fsl_guts.h
+++ b/arch/powerpc/include/asm/fsl_guts.h
@@ -4,7 +4,7 @@
  * Authors: Jeff Brown
  *          Timur Tabi <timur@freescale.com>
  *
- * Copyright 2004,2007 Freescale Semiconductor, Inc
+ * Copyright 2004,2007,2012 Freescale Semiconductor, Inc
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -114,6 +114,10 @@ struct ccsr_guts_86xx {
 	__be32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
 } __attribute__ ((packed));
 
+
+/* Alternate function signal multiplex control */
+#define MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
+
 #ifdef CONFIG_PPC_86xx
 
 #define CCSR_GUTS_DMACR_DEV_SSI	0	/* DMA controller/channel set to SSI */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 1d15a0c..71a316d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -1,5 +1,6 @@
 /*
- * Copyright (C) Freescale Semicondutor, Inc. 2006-2010. All rights reserved.
+ * Copyright (C) 2006-2010, 2012 Freescale Semicondutor, Inc.
+ * All rights reserved.
  *
  * Author: Andy Fleming <afleming@freescale.com>
  *
@@ -51,6 +52,7 @@
 #include <asm/qe_ic.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
+#include <asm/fsl_guts.h>
 #include "smp.h"
 
 #include "mpc85xx.h"
@@ -268,34 +270,27 @@ static void __init mpc85xx_mds_qe_init(void)
 	mpc85xx_mds_reset_ucc_phys();
 
 	if (machine_is(p1021_mds)) {
-#define MPC85xx_PMUXCR_OFFSET           0x60
-#define MPC85xx_PMUXCR_QE0              0x00008000
-#define MPC85xx_PMUXCR_QE3              0x00001000
-#define MPC85xx_PMUXCR_QE9              0x00000040
-#define MPC85xx_PMUXCR_QE12             0x00000008
-		static __be32 __iomem *pmuxcr;
 
-		np = of_find_node_by_name(NULL, "global-utilities");
+		struct ccsr_guts_85xx __iomem *guts;
 
+		np = of_find_node_by_name(NULL, "global-utilities");
 		if (np) {
-			pmuxcr = of_iomap(np, 0) + MPC85xx_PMUXCR_OFFSET;
-
-			if (!pmuxcr)
-				printk(KERN_EMERG "Error: Alternate function"
-					" signal multiplex control register not"
-					" mapped!\n");
-			else
+			guts = of_iomap(np, 0);
+			if (!guts)
+				pr_err("mpc85xx-rdb: could not map global utilities register\n");
+			else{
 			/* P1021 has pins muxed for QE and other functions. To
 			 * enable QE UEC mode, we need to set bit QE0 for UCC1
 			 * in Eth mode, QE0 and QE3 for UCC5 in Eth mode, QE9
 			 * and QE12 for QE MII management signals in PMUXCR
 			 * register.
 			 */
-				setbits32(pmuxcr, MPC85xx_PMUXCR_QE0 |
-						  MPC85xx_PMUXCR_QE3 |
-						  MPC85xx_PMUXCR_QE9 |
-						  MPC85xx_PMUXCR_QE12);
-
+				setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
+						  MPC85xx_PMUXCR_QE(3) |
+						  MPC85xx_PMUXCR_QE(9) |
+						  MPC85xx_PMUXCR_QE(12));
+				iounmap(guts);
+			}
 			of_node_put(np);
 		}
 
-- 
1.7.0.4
