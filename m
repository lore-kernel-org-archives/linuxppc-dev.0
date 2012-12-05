Return-Path: <B41889@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E23C62C009B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2012 13:31:57 +1100 (EST)
From: Yuanquan Chen <B41889@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [linuxppc-release][PATCH] powerpc/pci-hotplug: fix init issue of
 rescanned pci device
Date: Wed, 5 Dec 2012 10:31:57 +0800
Message-ID: <1354674717-14426-1-git-send-email-B41889@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Yuanquan Chen <B41889@freescale.com>, r61911@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc arch, some fixup work of PCI/PCI-e device is just done during the
first scan at booting time. For the PCI/PCI-e device rescanned after linux OS
booting up, the fixup work won't be done, which leads to dma_set_mask error or
irq related issue in rescanned PCI/PCI-e device's driver. So, it does the same
fixup work for the rescanned device to avoid this issue.

Signed-off-by: Yuanquan Chen <B41889@freescale.com>
---
 arch/powerpc/kernel/pci-common.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7f94f76..f0fb070 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1496,6 +1496,26 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 		if (ppc_md.pcibios_enable_device_hook(dev))
 			return -EINVAL;
 
+	if (!dev->is_added) {
+		/* 
+		 * Fixup NUMA node as it may not be setup yet by the generic
+		 * code and is needed by the DMA init
+		 */
+		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
+
+		/* Hook up default DMA ops */
+		set_dma_ops(&dev->dev, pci_dma_ops);
+		set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
+
+		/* Additional platform DMA/iommu setup */
+		if (ppc_md.pci_dma_dev_setup)
+			ppc_md.pci_dma_dev_setup(dev);
+
+		/* Read default IRQs and fixup if necessary */
+		pci_read_irq_line(dev);
+		if (ppc_md.pci_irq_fixup)
+			ppc_md.pci_irq_fixup(dev);
+	}
 	return pci_enable_resources(dev, mask);
 }
 
-- 
1.7.9.5
