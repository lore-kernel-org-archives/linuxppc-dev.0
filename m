Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8FBF42C030A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 00:02:45 +1000 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v3] powerpc/pci: Fix setup of Freescale PCI / PCIe controllers
Date: Mon, 17 Jun 2013 16:02:41 +0200
Message-ID: <7498229.szaOTnNpbV@pcimr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Guntsche <michael.guntsche@it-loops.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 50d8f87d2b3 (powerpc/fsl-pci Make PCIe hotplug work with Freescale
PCIe controllers) does not handle non-PCIe controllers properly, which causes
a panic during boot for certain configurations.
This patch fixes the issue by calling setup_indirect_pci for all device types.
fsl_indirect_read_config is now only used for booke/86xx PCIe controllers.

Reported-by: Michael Guntsche <mike@it-loops.com>
Cc: Scott Wood <scottwood@freescale.com>
Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
---
v3: Fix compile error

 arch/powerpc/sysdev/fsl_pci.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 028ac1f..46ac1dd 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -97,22 +97,14 @@ static int fsl_indirect_read_config(struct pci_bus *bus, unsigned int devfn,
 	return indirect_read_config(bus, devfn, offset, len, val);
 }
 
-static struct pci_ops fsl_indirect_pci_ops =
+#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
+
+static struct pci_ops fsl_indirect_pcie_ops =
 {
 	.read = fsl_indirect_read_config,
 	.write = indirect_write_config,
 };
 
-static void __init fsl_setup_indirect_pci(struct pci_controller* hose,
-					  resource_size_t cfg_addr,
-					  resource_size_t cfg_data, u32 flags)
-{
-	setup_indirect_pci(hose, cfg_addr, cfg_data, flags);
-	hose->ops = &fsl_indirect_pci_ops;
-}
-
-#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
-
 #define MAX_PHYS_ADDR_BITS	40
 static u64 pci64_dma_offset = 1ull << MAX_PHYS_ADDR_BITS;
 
@@ -504,13 +496,15 @@ int __init fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	if (!hose->private_data)
 		goto no_bridge;
 
-	fsl_setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
-			       PPC_INDIRECT_TYPE_BIG_ENDIAN);
+	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
+			   PPC_INDIRECT_TYPE_BIG_ENDIAN);
 
 	if (in_be32(&pci->block_rev1) < PCIE_IP_REV_3_0)
 		hose->indirect_type |= PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK;
 
 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
+		/* use fsl_indirect_read_config for PCIe */
+		hose->ops = &fsl_indirect_pcie_ops;
 		/* For PCIE read HEADER_TYPE to identify controler mode */
 		early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &hdr_type);
 		if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
@@ -814,8 +808,8 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 		if (ret)
 			goto err0;
 	} else {
-		fsl_setup_indirect_pci(hose, rsrc_cfg.start,
-				       rsrc_cfg.start + 4, 0);
+		setup_indirect_pci(hose, rsrc_cfg.start,
+				   rsrc_cfg.start + 4, 0);
 	}
 
 	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "

--
1.8.1.5
