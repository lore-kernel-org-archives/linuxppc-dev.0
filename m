Return-Path: <B36685@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5FCB82C0203
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 13:53:19 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH 2/2 v2] powerpc/fsl: PCI: add
 quirk_enable_non_msi_intx_interrupt
Date: Mon, 16 Jul 2012 11:31:27 +0800
Message-ID: <1342409487-28256-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1342409487-28256-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1342409487-28256-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On current fsl powerpc platforms, the PCIe root port doesn't support
generating MSI/MSI-X and INTx interrupt in RC mode (those interrupts
are supported only in EP mode). So we use the shared error interrupt
by flag PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ for PCIe port driver to
support AER, Hot-plug etc, services.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
v2: separated platform-specific part to arch/powerpc/sysdev.

 arch/powerpc/sysdev/fsl_pci.c |    2 ++
 arch/powerpc/sysdev/fsl_pci.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6073288..fb8862f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -498,6 +498,8 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
+			quirk_enable_non_msi_intx_interrupt);
 
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
 struct mpc83xx_pcie_priv {
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a39ed5c..a98c6d8 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -91,6 +91,7 @@ struct ccsr_pci {
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
+extern void __devinit quirk_enable_non_msi_intx_interrupt(struct pci_dev *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
 
 #endif /* __POWERPC_FSL_PCI_H */
-- 
1.6.4
