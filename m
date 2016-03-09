Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFD521A02A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:33 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 9 Mar 2016 16:30:33 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2FDEE357805D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:30 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u296UMFQ11599980
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:30 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u296TvKh010530
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:29:57 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel 08/10] powerpc/powernv/npu: Add NPU devices to IOMMU
 group
Date: Wed,  9 Mar 2016 17:29:04 +1100
Message-Id: <1457504946-40649-9-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NPU devices have their own TVT which means they are isolated and can be
passed to the userspace via VFIO. The first step is to create an IOMMU
group and attach devices there so does the patch.

This adds a helper to npu-dma.c which gets GPU from the NPU's pdev and
then walks through all devices on the same bus to determine which NPUs
belong to the same GPU.

This adds an additional loop over PEs in pnv_ioda_setup_dma() as the main
loop skips NPU PEs as they do not have 32bit DMA segments.

This uses get_gpu_pci_dev_and_pe() to get @gpdev rather than
pnv_pci_get_gpu_dev() as the following patch will use @gpe as well.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c  | 40 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |  8 +++++++
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 3 files changed, 49 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 866d3d3..e5a5feb 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -263,3 +263,43 @@ void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass)
 		}
 	}
 }
+
+void pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
+{
+	struct iommu_table *tbl;
+	struct pnv_phb *phb = npe->phb;
+	struct pci_bus *pbus = phb->hose->bus;
+	struct pci_dev *npdev, *gpdev = NULL, *gptmp;
+	struct pnv_ioda_pe *gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
+
+	if (!gpe || !gpdev)
+		return;
+
+	iommu_register_group(&npe->table_group, phb->hose->global_number,
+			npe->pe_number);
+
+	tbl = pnv_pci_table_alloc(phb->hose->node);
+
+	list_for_each_entry(npdev, &pbus->devices, bus_list) {
+		gptmp = pnv_pci_get_gpu_dev(npdev);
+
+		if (gptmp != gpdev)
+			continue;
+
+		/*
+		 * The iommu_add_device() picks an IOMMU group from
+		 * the first IOMMU group attached to the iommu_table
+		 * so we need to pretend that there is a table so
+		 * iommu_add_device() can complete the job.
+		 * We unlink the tempopary table from the group afterwards.
+		 */
+		pnv_pci_link_table_and_group(phb->hose->node, 0,
+				tbl, &npe->table_group);
+		set_iommu_table_base(&npdev->dev, tbl);
+		iommu_add_device(&npdev->dev);
+		set_iommu_table_base(&npdev->dev, NULL);
+		pnv_pci_unlink_table_and_group(tbl, &npe->table_group);
+	}
+
+	iommu_free_table(tbl, "");
+}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5a6cf2e..becd168 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2570,6 +2570,14 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 		remaining -= segs;
 		base += segs;
 	}
+	/*
+	 * Create an IOMMU group and add devices to it.
+	 * DMA setup is to be done via GPU's dma_set_mask().
+	 */
+	if (phb->type == PNV_PHB_NPU) {
+		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link)
+			pnv_pci_npu_setup_iommu(pe);
+	}
 }
 
 #ifdef CONFIG_PCI_MSI
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 06405fd..0c0083a 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -235,5 +235,6 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 /* Nvlink functions */
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
 extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
+extern void pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
 
 #endif /* __POWERNV_PCI_H */
-- 
2.5.0.rc3
