Return-Path: <B48286@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0107.outbound.protection.outlook.com [157.56.111.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B770C1A0B53
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 23:09:17 +1100 (AEDT)
From: Zhiqiang Hou <B48286@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <galak@kernel.crashing.org>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <mpe@ellerman.id.au>, <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
 <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <ijc+devicetree@hellion.org.uk>, <harninder.rai@freescale.com>
CC: <Minghuan.Lian@freescale.com>, <Mingkai.Hu@freescale.com>
Subject: [PATCH 2/2] powerpc/85xx: Add PCIe controller support for bsc9132qds
Date: Tue, 13 Oct 2015 19:29:21 +0800
Message-ID: <1444735761-1510-2-git-send-email-B48286@freescale.com>
In-Reply-To: <1444735761-1510-1-git-send-email-B48286@freescale.com>
References: <1444735761-1510-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Harninder Rai <harninder.rai@freescale.com>

1. Use machine_arch_initcall to hook mpc85xx_common_publish_devices
This can ensure before pcibios_init() is called, pci controllers have
been probed and added to the hose_list.
2. Add a workaround for errata A-005434
For the BSC9132, PEX_PEXIWARn[TRGT] for all windows defaults to 0xF,
which is mapped to CCSRBAR. However, for other products, 0xF is
mapped to the local memory. Therefore, for the BSC9132, any default
PCI Express access to the local memory (DDR) will now access the
CCSRBAR. This patch changes the mapping of targets of inbound windows
PEX_PEXIWARn[TRGT] to the Local address space – 0x0 (from 0xF).

Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Change-Id: Iebb3d0e057d64d5b96263c130495e5d04caf7948
Reviewed-on: http://git.am.freescale.net:8181/2455
Reviewed-by: Zang Tiefei-R61911 <tie-fei.zang@freescale.com>
Reviewed-by: Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>
Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
---
 arch/powerpc/platforms/85xx/bsc913x_qds.c |  8 +++++++-
 arch/powerpc/sysdev/fsl_pci.c             | 13 +++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/bsc913x_qds.c b/arch/powerpc/platforms/85xx/bsc913x_qds.c
index f0927e5..dcfafd6 100644
--- a/arch/powerpc/platforms/85xx/bsc913x_qds.c
+++ b/arch/powerpc/platforms/85xx/bsc913x_qds.c
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 #include <asm/mpic.h>
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 #include <asm/udbg.h>
 
 #include "mpc85xx.h"
@@ -46,10 +47,12 @@ static void __init bsc913x_qds_setup_arch(void)
 	mpc85xx_smp_init();
 #endif
 
+	fsl_pci_assign_primary();
+
 	pr_info("bsc913x board from Freescale Semiconductor\n");
 }
 
-machine_device_initcall(bsc9132_qds, mpc85xx_common_publish_devices);
+machine_arch_initcall(bsc9132_qds, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -67,6 +70,9 @@ define_machine(bsc9132_qds) {
 	.probe			= bsc9132_qds_probe,
 	.setup_arch		= bsc913x_qds_setup_arch,
 	.init_IRQ		= bsc913x_qds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index ebc1f412..b8607f6 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -193,6 +193,19 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	const u64 *reg;
 	int len;
 
+	if (of_device_is_compatible(hose->dn, "fsl,bsc9132-pcie")) {
+		/*
+		 * BSC9132 Rev1.0 has an issue where all the PEX inbound
+		 * windows have implemented the default target value as 0xf
+		 * for CCSR space.In all Freescale legacy devices the target
+		 * of 0xf is reserved for local memory space. 9132 Rev1.0
+		 * now has local mempry space mapped to target 0x0 instead of
+		 * 0xf. Hence adding a workaround to remove the target 0xf
+		 * defined for memory space from Inbound window attributes.
+		 */
+		piwar &= ~PIWAR_TGI_LOCAL;
+	}
+
 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
 		if (in_be32(&pci->block_rev1) >= PCIE_IP_REV_2_2) {
 			win_idx = 2;
-- 
2.1.0.27.g96db324
