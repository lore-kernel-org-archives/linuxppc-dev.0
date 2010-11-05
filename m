Return-Path: <B25806@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 188021007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Nov 2010 14:35:11 +1100 (EST)
Received: from mail78-am1 (localhost.localdomain [127.0.0.1])	by
	mail78-am1-R.bigfish.com (Postfix) with ESMTP id 7756E1C584E1	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  5 Nov 2010 03:19:55 +0000 (UTC)
Received: from AM1EHSMHS008.bigfish.com (unknown [10.3.201.243])	by
	mail78-am1.bigfish.com (Postfix) with ESMTP id CB0D81C40050	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  5 Nov 2010 03:19:54 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oA53JoPB008508	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 4 Nov 2010 20:19:50 -0700 (MST)
Received: from zch01exm28.fsl.freescale.net (zch01exm28.ap.freescale.net
	[10.192.129.225])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oA53apet002867	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 4 Nov 2010 22:36:51 -0500 (CDT)
From: Lan Chunhe <b25806@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/3] edac: Use ccsr_pci structure instead of hardcoded define
Date: Fri, 5 Nov 2010 11:23:03 +0800
Message-ID: <1288927383-1300-1-git-send-email-b25806@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lan Chunhe <b25806@freescale.com>, akpm@linux-foundation.org,
	"Kai.Jiang" <Kai.Jiang@freescale.com>, dougthompson@xmission.com
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

Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Lan Chunhe <b25806@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.h |   54 +++++++++++++++++++++++++++++++---------
 drivers/edac/mpc85xx_edac.h   |   13 +--------
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index 8ad72a1..796985b 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -1,7 +1,7 @@
 /*
  * MPC85xx/86xx PCI Express structure define
  *
- * Copyright 2007 Freescale Semiconductor, Inc
+ * Copyright 2007, 2010 Freescale Semiconductor, Inc
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
@@ -71,18 +73,46 @@ struct ccsr_pci {
  */
 	struct pci_inbound_window_regs piw[3];
 
-	__be32	pex_err_dr;		/* 0x.e00 - PCI/PCIE error detect register */
-	u8	res21[4];
-	__be32	pex_err_en;		/* 0x.e08 - PCI/PCIE error interrupt enable register */
-	u8	res22[4];
-	__be32	pex_err_disr;		/* 0x.e10 - PCI/PCIE error disable register */
-	u8	res23[12];
-	__be32	pex_err_cap_stat;	/* 0x.e20 - PCI/PCIE error capture status register */
+/* Merge PCI/PCI Express error management registers */
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
-	__be32	pex_err_cap_r0;		/* 0x.e28 - PCIE error capture register 0 */
-	__be32	pex_err_cap_r1;		/* 0x.e2c - PCIE error capture register 0 */
-	__be32	pex_err_cap_r2;		/* 0x.e30 - PCIE error capture register 0 */
-	__be32	pex_err_cap_r3;		/* 0x.e34 - PCIE error capture register 0 */
+	__be32	pex_err_cap_r0;	  /* 0x.e28 - PCIE error capture register 0 */
+	__be32	pex_err_cap_r1;	  /* 0x.e2c - PCIE error capture register 1 */
+	__be32	pex_err_cap_r2;	  /* 0x.e30 - PCIE error capture register 2 */
+	__be32	pex_err_cap_r3;	  /* 0x.e34 - PCIE error capture register 3 */
 };
 
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
diff --git a/drivers/edac/mpc85xx_edac.h b/drivers/edac/mpc85xx_edac.h
index cb24df8..099581d 100644
--- a/drivers/edac/mpc85xx_edac.h
+++ b/drivers/edac/mpc85xx_edac.h
@@ -1,5 +1,7 @@
 /*
  * Freescale MPC85xx Memory Controller kenel module
+ * Copyright (c) 2010 Freescale Semiconductor, Inc.
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
1.5.4.5
