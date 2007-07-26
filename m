Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55D2BDDEEF
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:33:12 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/8] [POWERPC] Fix PCI indirect for big-endian cfg_addr
Date: Thu, 26 Jul 2007 01:32:32 -0500
Message-Id: <11854315613622-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We didn't actually propogate the flag we pass into setup_indirect_pci()
to set indirect_type and thus were getting the wrong endianness if
PPC_INDIRECT_TYPE_BIG_ENDIAN was set.

Also, we need to or in additional flags rather than just doing a
direct assignment.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_pci.c      |    2 +-
 arch/powerpc/sysdev/indirect_pci.c |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 51c2233..8712227 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -216,7 +216,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 
 	/* check PCI express link status */
 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
-		hose->indirect_type = PPC_INDIRECT_TYPE_EXT_REG |
+		hose->indirect_type |= PPC_INDIRECT_TYPE_EXT_REG |
 			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
 		if (fsl_pcie_check_link(hose))
 			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index a8ac2df..5294560 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -160,4 +160,5 @@ setup_indirect_pci(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data, u32
 		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
 	hose->cfg_data = mbase + (cfg_data & ~PAGE_MASK);
 	hose->ops = &indirect_pci_ops;
+	hose->indirect_type = flags;
 }
-- 
1.5.2.2
