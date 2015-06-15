Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BDBD1A0E4B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 17:56:15 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 15 Jun 2015 17:56:14 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4E2CF3578054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 17:56:10 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5F7u0Xc8978562
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 17:56:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5F7taxJ022897
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 17:55:36 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel] powerpc/iommu/ioda2: Enable compile with IOV=on and
 IOMMU_API=off
Date: Mon, 15 Jun 2015 17:49:59 +1000
Message-Id: <1434354599-22659-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pnv_pci_ioda2_unset_window() function is used to do the final
cleanup of a DMA window being released:
- via VFIO ioctl by the guest request;
- via unplugging a virtual PCI function.
However the function was under #ifdef CONFIG_IOMMU_API and was missing.

This moves the helper outside of IOMMU_API block and enables it
for either or both IOMMU_API and PCI_IOV.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 50 ++++++++++++++++---------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b9f0f43..8424f5c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2116,6 +2116,32 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	return 0;
 }
 
+#if defined(CONFIG_IOMMU_API) || defined(CONFIG_PCI_IOV)
+static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
+		int num)
+{
+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
+	struct pnv_phb *phb = pe->phb;
+	long ret;
+
+	pe_info(pe, "Removing DMA window #%d\n", num);
+
+	ret = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
+			(pe->pe_number << 1) + num,
+			0/* levels */, 0/* table address */,
+			0/* table size */, 0/* page size */);
+	if (ret)
+		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
+	else
+		pnv_pci_ioda2_tce_invalidate_entire(pe);
+
+	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
+
+	return ret;
+}
+#endif
+
 #ifdef CONFIG_IOMMU_API
 static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
 		__u64 window_size, __u32 levels)
@@ -2149,30 +2175,6 @@ static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
 	return bytes;
 }
 
-static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
-		int num)
-{
-	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
-			table_group);
-	struct pnv_phb *phb = pe->phb;
-	long ret;
-
-	pe_info(pe, "Removing DMA window #%d\n", num);
-
-	ret = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
-			(pe->pe_number << 1) + num,
-			0/* levels */, 0/* table address */,
-			0/* table size */, 0/* page size */);
-	if (ret)
-		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
-	else
-		pnv_pci_ioda2_tce_invalidate_entire(pe);
-
-	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
-
-	return ret;
-}
-
 static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 {
 	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
-- 
2.4.0.rc3.8.gfb3e7d5
