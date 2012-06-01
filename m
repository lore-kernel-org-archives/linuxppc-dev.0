Return-Path: <B25806@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8622CB700D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2012 18:19:30 +1000 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] edac: Use ccsr_pci structure instead of hardcoded define
Date: Fri, 1 Jun 2012 16:16:57 +0800
Message-ID: <1338538618-26939-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Doug Thompson <dougthompson@xmission.com>,
 Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are some differences of register offset and definition between
pci and pcie error management registers. While, some other pci/pcie
error management registers are nearly the same.

To merge pci and pcie edac code into one, it is easier to use ccsr_pci
structure than the hardcoded define. So remove the hardcoded define and
add pci/pcie error management register in ccsr_pci structure.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Doug Thompson <dougthompson@xmission.com>
---
 arch/powerpc/sysdev/fsl_pci.h |   46 +++++++++++++++++++++++++++++++++-------
 drivers/edac/mpc85xx_edac.h   |   13 +---------
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a39ed5c..5378a47 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -1,7 +1,7 @@
 /*
  * MPC85xx/86xx PCI Express structure define
  *
- * Copyright 2007,2011 Freescale Semiconductor, Inc
+ * Copyright 2007,2011,2012 Freescale Semiconductor, Inc
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -14,6 +14,8 @@
 #ifndef __POWERPC_FSL_PCI_H
 #define __POWERPC_FSL_PCI_H
 
+#include <asm/pci-bridge.h>
+
 #define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
 #define PCIE_LTSSM_L0	0x16		/* L0 state */
 #define PIWAR_EN		0x80000000	/* Enable */
@@ -74,13 +76,41 @@ struct ccsr_pci {
  */
 	struct pci_inbound_window_regs piw[4];
 
-	__be32	pex_err_dr;		/* 0x.e00 - PCI/PCIE error detect register */
-	u8	res21[4];
-	__be32	pex_err_en;		/* 0x.e08 - PCI/PCIE error interrupt enable register */
-	u8	res22[4];
-	__be32	pex_err_disr;		/* 0x.e10 - PCI/PCIE error disable register */
-	u8	res23[12];
-	__be32	pex_err_cap_stat;	/* 0x.e20 - PCI/PCIE error capture status register */
+/* Merge PCI Express/PCI error management registers */
+	__be32	pex_err_dr;	  /* 0x.e00
+				   * - PCI/PCIE error detect register
+				   */
+	__be32	pex_err_cap_dr;	  /* 0x.e04
+				   * - PCI error capture disabled register
+				   * - PCIE has no this register
+				   */
+	__be32	pex_err_en;	  /* 0x.e08
+				   * - PCI/PCIE error interrupt enable register
+				   */
+	__be32	pex_err_attrib;	  /* 0x.e0c
+				   * - PCI error attributes capture register
+				   * - PCIE has no this register
+				   */
+	__be32	pex_err_disr;	  /* 0x.e10
+				   * - PCI error address capture register
+				   * - PCIE error disable register
+				   */
+	__be32	pex_err_ext_addr; /* 0x.e14
+				   * - PCI error extended addr capture register
+				   * - PCIE has no this register
+				   */
+	__be32	pex_err_dl;	  /* 0x.e18
+				   * - PCI error data low capture register
+				   * - PCIE has no this register
+				   */
+	__be32	pex_err_dh;	  /* 0x.e1c
+				   * - PCI error data high capture register
+				   * - PCIE has no this register
+				   */
+	__be32	pex_err_cap_stat; /* 0x.e20
+				   * - PCI gasket timer register
+				   * - PCIE error capture status register
+				   */
 	u8	res24[4];
 	__be32	pex_err_cap_r0;		/* 0x.e28 - PCIE error capture register 0 */
 	__be32	pex_err_cap_r1;		/* 0x.e2c - PCIE error capture register 0 */
diff --git a/drivers/edac/mpc85xx_edac.h b/drivers/edac/mpc85xx_edac.h
index 932016f..8ba4152 100644
--- a/drivers/edac/mpc85xx_edac.h
+++ b/drivers/edac/mpc85xx_edac.h
@@ -1,5 +1,7 @@
 /*
  * Freescale MPC85xx Memory Controller kenel module
+ * Copyright (c) 2012 Freescale Semiconductor, Inc.
+ *
  * Author: Dave Jiang <djiang@mvista.com>
  *
  * 2006-2007 (c) MontaVista Software, Inc. This file is licensed under
@@ -131,17 +133,6 @@
 #define PCI_EDE_PERR_MASK	(PCI_EDE_TGT_PERR | PCI_EDE_MST_PERR | \
 				PCI_EDE_ADDR_PERR)
 
-#define MPC85XX_PCI_ERR_DR		0x0000
-#define MPC85XX_PCI_ERR_CAP_DR		0x0004
-#define MPC85XX_PCI_ERR_EN		0x0008
-#define MPC85XX_PCI_ERR_ATTRIB		0x000c
-#define MPC85XX_PCI_ERR_ADDR		0x0010
-#define MPC85XX_PCI_ERR_EXT_ADDR	0x0014
-#define MPC85XX_PCI_ERR_DL		0x0018
-#define MPC85XX_PCI_ERR_DH		0x001c
-#define MPC85XX_PCI_GAS_TIMR		0x0020
-#define MPC85XX_PCI_PCIX_TIMR		0x0024
-
 struct mpc85xx_mc_pdata {
 	char *name;
 	int edac_idx;
-- 
1.5.6.5
