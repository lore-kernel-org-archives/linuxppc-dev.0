Return-Path: <Zhiqiang.Hou@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0122.outbound.protection.outlook.com [65.55.169.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 861091A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 20:46:46 +1100 (AEDT)
From: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>
CC: <scottwood@freescale.com>, <Minghuan.Lian@freescale.com>,
 <chenhui.zhao@freescale.com>, <Mingkai.Hu@freescale.com>, Zhiqiang Hou
 <Zhiqiang.Hou@freescale.com>
Subject: [PATCH] powerpc/fsl-pci: Add a workaround for PCI 5 errata
Date: Fri, 15 Jan 2016 17:38:20 +0800
Message-ID: <1452850700-39442-1-git-send-email-Zhiqiang.Hou@freescale.com>
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

From: chenhui zhao <chenhui.zhao@freescale.com>

Issue:
As a master, the PCI IP block can combine a memory write to the last PCI
double word (4 bytes) of a cacheline with a 4 byte memory write to the
first PCI double word of the subsequent cacheline. This affects 32-bit
PCI target devices that blindly assert STOP on memory-write transactions,
without detecting that the data beat being transferred is the last data
beat of the transaction. It can cause a hang. PCI-X operation is not
affected by this erratum.

Workaround:
Setting the bit MDS in the PCI Bus Function Register will disable the
combining of crossing cacheline boundary requests into one burst
transaction. Therefore, it can prevent the errata scenario from
occurring.

This errata exists in MPC8543, MPC8543E, MPC8545, MPC8545E, MPC8547,
MPC8547E, MPC8548 and MPC8548E. Refer to PCI 5 in MPC8548 errata
document.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index c69e88e..33e50f3 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -37,6 +37,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
 #include <asm/machdep.h>
+#include <asm/mpc85xx.h>
 #include <asm/disassemble.h>
 #include <asm/ppc-opcode.h>
 #include <sysdev/fsl_soc.h>
@@ -527,6 +528,8 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	u8 hdr_type, progif;
 	struct device_node *dev;
 	struct ccsr_pci __iomem *pci;
+	u16 temp;
+	u32 svr = mfspr(SPRN_SVR);
 
 	dev = pdev->dev.of_node;
 
@@ -596,6 +599,27 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
 		if (fsl_pcie_check_link(hose))
 			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+	} else {
+		/*
+		 * Set PBFR(PCI Bus Function Register)[10] = 1 to
+		 * disable the combining of crossing cacheline
+		 * boundary requests into one burst transaction.
+		 * PCI-X operation is not affected.
+		 * Fix erratum PCI 5 on MPC8548
+		 */
+#define PCI_BUS_FUNCTION 0x44
+#define PCI_BUS_FUNCTION_MDS 0x400	/* Master disable streaming */
+		if (((SVR_SOC_VER(svr) == SVR_8543) ||
+			(SVR_SOC_VER(svr) == SVR_8545) ||
+			(SVR_SOC_VER(svr) == SVR_8547) ||
+			(SVR_SOC_VER(svr) == SVR_8548)) &&
+			!early_find_capability(hose, 0, 0, PCI_CAP_ID_PCIX)) {
+			early_read_config_word(hose, 0, 0,
+					PCI_BUS_FUNCTION, &temp);
+			temp |= PCI_BUS_FUNCTION_MDS;
+			early_write_config_word(hose, 0, 0,
+					PCI_BUS_FUNCTION, temp);
+		}
 	}
 
 	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
-- 
2.1.0.27.g96db324
