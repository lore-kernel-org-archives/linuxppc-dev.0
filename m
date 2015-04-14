Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8ECB1A0BBE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:28:23 +1000 (AEST)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 678D01402A8
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:28:23 +1000 (AEST)
Received: by paboj16 with SMTP id oj16so124964318pab.0
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:28:22 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 02/10] powerpc/powernv: Move MSI-related ops to
 pci_controller_ops
Date: Tue, 14 Apr 2015 14:27:55 +1000
Message-Id: <1428985683-24767-3-git-send-email-dja@axtens.net>
In-Reply-To: <1428985683-24767-1-git-send-email-dja@axtens.net>
References: <1428985683-24767-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the PowerNV/BML platform to use the pci_controller_ops structure
rather than ppc_md for MSI related PCI controller operations.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/powernv/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index bca2aeb..0f04940 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -768,16 +768,14 @@ void __init pnv_pci_init(void)
 	ppc_md.tce_free_rm = pnv_tce_free_rm;
 	ppc_md.tce_get = pnv_tce_get;
 	set_pci_dma_ops(&dma_iommu_ops);
-
-	/* Configure MSIs */
-#ifdef CONFIG_PCI_MSI
-	ppc_md.setup_msi_irqs = pnv_setup_msi_irqs;
-	ppc_md.teardown_msi_irqs = pnv_teardown_msi_irqs;
-#endif
 }
 
 machine_subsys_initcall_sync(powernv, tce_iommu_bus_notifier_init);
 
 struct pci_controller_ops pnv_pci_controller_ops = {
 	.dma_dev_setup = pnv_pci_dma_dev_setup,
+#ifdef CONFIG_PCI_MSI
+	.setup_msi_irqs = pnv_setup_msi_irqs,
+	.teardown_msi_irqs = pnv_teardown_msi_irqs,
+#endif
 };
-- 
2.1.4
