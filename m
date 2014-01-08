Return-Path: <Minghuan.Lian@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 77B262C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 16:02:14 +1100 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 12/12][v4] pci: fsl: fix function check_pci_ctl_endpt_part
Date: Wed, 8 Jan 2014 13:02:03 +0800
Message-ID: <1389157323-3088-12-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linux-pci@vger.kernel.org,
 Zang Roy-R61911 <r61911@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new FSL PCI driver does not use cfg_addr of pci_controller,
we may directly access PCI CCSR using fsl_pci->regs.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v4:
no change
v1-v3:
The new patch to fix function check_pci_ctl_endpt_part

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 arch/powerpc/sysdev/fsl_pci.h   | 5 -----
 drivers/iommu/fsl_pamu_domain.c | 6 ++++--
 include/linux/fsl/pci-common.h  | 1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index ae4dbe2..3176eb2 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -16,11 +16,6 @@
 
 struct platform_device;
 
-
-/* FSL PCI controller BRR1 register */
-#define PCI_FSL_BRR1      0xbf8
-#define PCI_FSL_BRR1_VER 0xffff
-
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index c857c30..dd7bc25 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -36,6 +36,7 @@
 
 #include <asm/pci-bridge.h>
 #include <sysdev/fsl_pci.h>
+#include <linux/fsl/pci-common.h>
 
 #include "fsl_pamu_domain.h"
 #include "pci.h"
@@ -908,10 +909,11 @@ static struct iommu_group *get_device_iommu_group(struct device *dev)
 static  bool check_pci_ctl_endpt_part(struct pci_controller *pci_ctl)
 {
 	u32 version;
+	struct fsl_pci *pci = fsl_arch_sys_to_pci(pci_ctl);
 
 	/* Check the PCI controller version number by readding BRR1 register */
-	version = in_be32(pci_ctl->cfg_addr + (PCI_FSL_BRR1 >> 2));
-	version &= PCI_FSL_BRR1_VER;
+	version = in_be32(&pci->regs->block_rev1);
+	version &= PCIE_IP_REV_MASK;
 	/* If PCI controller version is >= 0x204 we can partition endpoints*/
 	if (version >= 0x204)
 		return 1;
diff --git a/include/linux/fsl/pci-common.h b/include/linux/fsl/pci-common.h
index 3247682..4e4191e 100644
--- a/include/linux/fsl/pci-common.h
+++ b/include/linux/fsl/pci-common.h
@@ -18,6 +18,7 @@
 #define PCIE_LTSSM_L0	0x16		/* L0 state */
 #define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block version Rev2.2 */
 #define PCIE_IP_REV_3_0		0x02080300 /* PCIE IP block version Rev3.0 */
+#define PCIE_IP_REV_MASK	0xffff
 #define PIWAR_EN		0x80000000	/* Enable */
 #define PIWAR_PF		0x20000000	/* prefetch */
 #define PIWAR_TGI_LOCAL		0x00f00000	/* target - local memory */
-- 
1.8.1.2
