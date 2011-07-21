Return-Path: <B21989@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35559B6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 21:28:59 +1000 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/4] powerpc/85xx: Merge PCI/PCI Express error management
	registers
Date: Thu, 21 Jul 2011 18:29:55 +0800
Message-ID: <1311244195-4418-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, "Kai.Jiang" <Kai.Jiang@freescale.com>,
	Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kai.Jiang <Kai.Jiang@freescale.com>

There are some differences of register offset and definition between
pci and pcie error management registers. While, some other pci/pcie
error management registers are nearly the same.

Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.h |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

difg --gite a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a39ed5c..60a76e9 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -74,13 +74,32 @@ struct ccsr_pci {
  */
 	struct pci_inbound_window_regs piw[4];
 
+/* Merge PCI/PCI Express error management registers */
 	__be32	pex_err_dr;		/* 0x.e00 - PCI/PCIE error detect register */
-	u8	res21[4];
-	__be32	pex_err_en;		/* 0x.e08 - PCI/PCIE error interrupt enable register */
-	u8	res22[4];
-	__be32	pex_err_disr;		/* 0x.e10 - PCI/PCIE error disable register */
-	u8	res23[12];
-	__be32	pex_err_cap_stat;	/* 0x.e20 - PCI/PCIE error capture status register */
+	__be32	pex_err_cap_dr;		/* 0x.e04 */
+					/* - PCI error capture disabled register */
+					/* - PCIE has no this register */
+	__be32	pex_err_en;		/* 0x.e08 */
+					/* - PCI/PCIE error interrupt enable register*/
+	__be32	pex_err_attrib;		/* 0x.e0c */
+					/* - PCI error attributes capture register */
+					/* - PCIE has no this register */
+	__be32	pex_err_disr;		/* 0x.e10 */
+					/* - PCI error address capture register */
+					/* - PCIE error disable register */
+	__be32	pex_err_ext_addr;	/* 0x.e14 */
+					/* - PCI error extended addr capture register*/
+					/* - PCIE has no this register */
+	__be32	pex_err_dl;		/* 0x.e18 */
+					/* - PCI error data low capture register */
+					/* - PCIE has no this register */
+	__be32	pex_err_dh;		/* 0x.e1c */
+					/* - PCI error data high capture register */
+					/* - PCIE has no this register */
+	__be32	pex_err_cap_stat;	/* 0x.e20 */
+					/* - PCI gasket timer register */
+					/* - PCIE error capture status register */
+
 	u8	res24[4];
 	__be32	pex_err_cap_r0;		/* 0x.e28 - PCIE error capture register 0 */
 	__be32	pex_err_cap_r1;		/* 0x.e2c - PCIE error capture register 0 */
-- 
1.6.4
