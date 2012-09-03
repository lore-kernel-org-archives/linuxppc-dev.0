Return-Path: <r61911@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 05E342C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2012 18:21:53 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/pci: Add IP revision register define for
 Freescale PCIe controller
Date: Mon, 3 Sep 2012 17:22:09 +0800
Message-ID: <1346664130-7896-1-git-send-email-tie-fei.zang@freescale.com>
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

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index baa0fd1..7192932 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -16,6 +16,7 @@
 
 #define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
 #define PCIE_LTSSM_L0	0x16		/* L0 state */
+#define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block version Rev2.2 */
 #define PIWAR_EN		0x80000000	/* Enable */
 #define PIWAR_PF		0x20000000	/* prefetch */
 #define PIWAR_TGI_LOCAL		0x00f00000	/* target - local memory */
@@ -57,7 +58,9 @@ struct ccsr_pci {
 	__be32	pex_pme_mes_disr;	/* 0x.024 - PCIE PME and message disable register */
 	__be32	pex_pme_mes_ier;	/* 0x.028 - PCIE PME and message interrupt enable register */
 	__be32	pex_pmcr;		/* 0x.02c - PCIE power management command register */
-	u8	res3[3024];
+	u8	res3[3016];
+	__be32	block_rev1;	/* 0x.bf8 - PCIE Block Revision register 1 */
+	__be32	block_rev2;	/* 0x.bfc - PCIE Block Revision register 2 */
 
 /* PCI/PCI Express outbound window 0-4
  * Window 0 is the default window and is the only window enabled upon reset.
-- 
1.7.8.1
