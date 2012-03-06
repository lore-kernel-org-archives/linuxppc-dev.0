Return-Path: <B35336@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C7BDB7444
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:09:13 +1100 (EST)
Received: from mail97-am1 (localhost [127.0.0.1])	by mail97-am1-R.bigfish.com
 (Postfix) with ESMTP id 30FE5E0218	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2012 09:09:10 +0000 (UTC)
Received: from AM1EHSMHS011.bigfish.com (unknown [10.3.201.246])	by
 mail97-am1.bigfish.com (Postfix) with ESMTP id 562F01A004A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:09:09 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/4] fsl_pci: Add a workaround for PCI 6 errata in MPC8548
Date: Tue, 6 Mar 2012 17:10:55 +0800
Message-ID: <1331025056-15983-3-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1331025056-15983-1-git-send-email-chenhui.zhao@freescale.com>
References: <1331025056-15983-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: chenhui zhao <chenhui.zhao@freescale.com>

Issue:
The register bits ERR_DR[OWMSV] and ERR_DR[ORMSV] can erroneously set and
may trigger an interrupt if capturing and reporting of these events are enabled.

Workaround:
Disable OWMSV, ORMSV error capture and disable OWMSV, ORMSV error reporting.
Do not affect the functionality of the controller when the checking is disabled.

Refer to PCI 6 in MPC8548 errata document.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |   16 ++++++++++++
 arch/powerpc/sysdev/fsl_pci.h |   53 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 9bdee6d..43aafc3 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -156,6 +156,22 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 	    return;
 	}
 
+	/*
+	 * PCI/PCI-X erroneous error detection
+	 * Fix erratum PCI 6 on MPC8548
+	 */
+#define OWMSV 0x10
+#define ORMSV 0x08
+	if ((fsl_svr_is(SVR_8548) || fsl_svr_is(SVR_8548_E))
+		&& fsl_svr_older_than(2, 1)) {
+		if (of_device_is_compatible(hose->dn, "fsl,mpc8540-pci")) {
+			/* disable OWMSV and ORMSV error capture */
+			setbits32(&pci->pcier.pecdr, OWMSV | ORMSV);
+			/* disable OWMSV and ORMSV error reporting */
+			clrbits32(&pci->pcier.peer, OWMSV | ORMSV);
+		}
+	}
+
 	/* Disable all windows (except powar0 since it's ignored) */
 	for(i = 1; i < 5; i++)
 		out_be32(&pci->pow[i].powar, 0);
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a39ed5c..f09a78d 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -43,6 +43,45 @@ struct pci_inbound_window_regs {
 	u8	res2[12];
 };
 
+/* PCI Error Management Registers */
+struct pci_err_regs {
+	/*   0x.e00 - PCI Error Detect Register */
+	__be32	pedr;
+	/*   0x.e04 - PCI Error Capture Disable Register */
+	__be32	pecdr;
+	/*   0x.e08 - PCI Error Interrupt Enable Register */
+	__be32	peer;
+	/*   0x.e0c - PCI Error Attributes Capture Register */
+	__be32	peattrcr;
+	/*   0x.e10 - PCI Error Address Capture Register */
+	__be32	peaddrcr;
+	/*   0x.e14 - PCI Error Extended Address Capture Register */
+	__be32	peextaddrcr;
+	/*   0x.e18 - PCI Error Data Low Capture Register */
+	__be32	pedlcr;
+	/*   0x.e1c - PCI Error Data High Capture Register */
+	__be32	pedhcr;
+	/*   0x.e20 - PCI Gasket Timer Register */
+	__be32	gas_timr;
+	u8	res21[4];
+};
+
+/* PCI Express Error Management Registers */
+struct pcie_err_regs {
+	/*  0x.e00 - PCI/PCIE error detect register */
+	__be32	pex_err_dr;
+	u8	res21[4];
+	/*  0x.e08 - PCI/PCIE error interrupt enable register */
+	__be32	pex_err_en;
+	u8	res22[4];
+	/*  0x.e10 - PCI/PCIE error disable register */
+	__be32	pex_err_disr;
+	u8	res23[12];
+	/*  0x.e20 - PCI/PCIE error capture status register */
+	__be32	pex_err_cap_stat;
+	u8	res24[4];
+};
+
 /* PCI/PCI Express IO block registers for 85xx/86xx */
 struct ccsr_pci {
 	__be32	config_addr;		/* 0x.000 - PCI/PCIE Configuration Address Register */
@@ -73,15 +112,11 @@ struct ccsr_pci {
  * define an inbound window base extended address register.
  */
 	struct pci_inbound_window_regs piw[4];
-
-	__be32	pex_err_dr;		/* 0x.e00 - PCI/PCIE error detect register */
-	u8	res21[4];
-	__be32	pex_err_en;		/* 0x.e08 - PCI/PCIE error interrupt enable register */
-	u8	res22[4];
-	__be32	pex_err_disr;		/* 0x.e10 - PCI/PCIE error disable register */
-	u8	res23[12];
-	__be32	pex_err_cap_stat;	/* 0x.e20 - PCI/PCIE error capture status register */
-	u8	res24[4];
+/* PCI/PCI Express Error Management Registers */
+	union {
+		struct pci_err_regs pcier;
+		struct pcie_err_regs pexer;
+	};
 	__be32	pex_err_cap_r0;		/* 0x.e28 - PCIE error capture register 0 */
 	__be32	pex_err_cap_r1;		/* 0x.e2c - PCIE error capture register 0 */
 	__be32	pex_err_cap_r2;		/* 0x.e30 - PCIE error capture register 0 */
-- 
1.6.4.1
