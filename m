Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D9A41A0A02
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 15:12:35 +1000 (AEST)
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DA973140083
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:12:34 +1000 (AEST)
Received: by pdbqd1 with SMTP id qd1so152151752pdb.2
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 22:12:33 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/pci: add dma_set_mask to pci_controller_ops
Date: Tue, 28 Apr 2015 15:12:06 +1000
Message-Id: <1430197927-24814-3-git-send-email-dja@axtens.net>
In-Reply-To: <1430197927-24814-1-git-send-email-dja@axtens.net>
References: <1430197927-24814-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some systems only need to deal with DMA masks for PCI devices.
For these systems, we can avoid the need for a platform hook and
instead use a pci controller based hook.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/pci-bridge.h |  2 ++
 arch/powerpc/kernel/dma.c             | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index a3b6252..6d17bb8 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -36,6 +36,8 @@ struct pci_controller_ops {
 					  int nvec, int type);
 	void		(*teardown_msi_irqs)(struct pci_dev *dev);
 #endif
+
+	int             (*dma_set_mask)(struct pci_dev *dev, u64 dma_mask);
 };
 
 /*
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 484b2d4..1acf19c 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -246,8 +246,19 @@ int __dma_set_mask(struct device *dev, u64 dma_mask)
 
 int dma_set_mask(struct device *dev, u64 dma_mask)
 {
+	struct pci_dev *pdev;
+	struct pci_controller *phb;
+	
 	if (ppc_md.dma_set_mask)
 		return ppc_md.dma_set_mask(dev, dma_mask);
+
+	if (dev_is_pci(dev)) {
+		pdev = to_pci_dev(dev);
+		phb = pci_bus_to_host(pdev->bus);
+		if (phb->controller_ops.dma_set_mask)
+			return phb->controller_ops.dma_set_mask(pdev, dma_mask);
+	}
+
 	return __dma_set_mask(dev, dma_mask);
 }
 EXPORT_SYMBOL(dma_set_mask);
-- 
2.1.4
