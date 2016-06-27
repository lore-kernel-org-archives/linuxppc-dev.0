Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSpD5dcjzDqv7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:25:56 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdSpD0sgPz9t1M
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 22:25:55 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/17] powerpc/powernv: Add IODA3 PHB type
Date: Mon, 27 Jun 2016 22:25:21 +1000
Message-Id: <1467030333-31435-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For now, mostly treat it as IODA2

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 15 +++++++++++----
 arch/powerpc/platforms/powernv/pci.c      |  4 ++++
 arch/powerpc/platforms/powernv/pci.h      |  2 ++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3a5ea82..341a9db 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -408,7 +408,8 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	const u32 *r;
 	u64 pci_addr;
 
-	if (phb->type != PNV_PHB_IODA1 && phb->type != PNV_PHB_IODA2) {
+	if (phb->type != PNV_PHB_IODA1 && phb->type != PNV_PHB_IODA2 &&
+	    phb->type != PNV_PHB_IODA3) {
 		pr_info("  Not support M64 window\n");
 		return;
 	}
@@ -1419,7 +1420,7 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	/* Release VF PEs */
 	pnv_ioda_release_vf_PE(pdev);
 
-	if (phb->type == PNV_PHB_IODA2) {
+	if (phb->type == PNV_PHB_IODA2 || phb->type == PNV_PHB_IODA3) {
 		if (!pdn->m64_single_mode)
 			pnv_pci_vf_resource_shift(pdev, -*pdn->pe_num_map);
 
@@ -1515,7 +1516,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	phb = hose->private_data;
 	pdn = pci_get_pdn(pdev);
 
-	if (phb->type == PNV_PHB_IODA2) {
+	if (phb->type == PNV_PHB_IODA2 || phb->type == PNV_PHB_IODA3) {
 		if (!pdn->vfs_expanded) {
 			dev_info(&pdev->dev, "don't support this SRIOV device"
 				" with non 64bit-prefetchable IOV BAR\n");
@@ -2717,7 +2718,8 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 		 */
 		if (phb->type == PNV_PHB_IODA1) {
 			pnv_pci_ioda1_setup_dma_pe(phb, pe);
-		} else if (phb->type == PNV_PHB_IODA2) {
+		} else if (phb->type == PNV_PHB_IODA2 ||
+			   phb->type == PNV_PHB_IODA3) {
 			pe_info(pe, "Assign DMA32 space\n");
 			pnv_pci_ioda2_setup_dma_pe(phb, pe);
 		} else if (phb->type == PNV_PHB_NPU) {
@@ -3621,6 +3623,11 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		hose->mem_resources[1].flags = 0;
 }
 
+void __init pnv_pci_init_ioda3_phb(struct device_node *np)
+{
+	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_IODA3);
+}
+
 void __init pnv_pci_init_ioda2_phb(struct device_node *np)
 {
 	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_IODA2);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 1d92bd9..517a789 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -815,6 +815,10 @@ void __init pnv_pci_init(void)
 	for_each_compatible_node(np, NULL, "ibm,ioda2-phb")
 		pnv_pci_init_ioda2_phb(np);
 
+	/* Look for ioda3 built-in PHB4's */
+	for_each_compatible_node(np, NULL, "ibm,ioda3-phb")
+		pnv_pci_init_ioda3_phb(np);
+
 	/* Look for NPU PHBs */
 	for_each_compatible_node(np, NULL, "ibm,ioda2-npu-phb")
 		pnv_pci_init_npu_phb(np);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 7dee25e..772ad41 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -7,6 +7,7 @@ enum pnv_phb_type {
 	PNV_PHB_IODA1	= 0,
 	PNV_PHB_IODA2	= 1,
 	PNV_PHB_NPU	= 2,
+	PNV_PHB_IODA3	= 3,
 };
 
 /* Precise PHB model for error management */
@@ -202,6 +203,7 @@ extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 				      u64 dma_offset, unsigned page_shift);
 extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
+extern void pnv_pci_init_ioda3_phb(struct device_node *np);
 extern void pnv_pci_init_npu_phb(struct device_node *np);
 extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 					__be64 *startp, __be64 *endp, bool rm);
-- 
2.7.4
