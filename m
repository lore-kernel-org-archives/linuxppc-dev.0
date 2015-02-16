Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAAA61A0742
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:49 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 16 Feb 2015 20:07:47 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 04DA33578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:45 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1GA7aLS37027906
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1GA7APp000859
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:11 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 25/28] vfio: powerpc/spapr: powerpc/powernv/ioda2: Rework
 ownership
Date: Mon, 16 Feb 2015 21:06:17 +1100
Message-Id: <1424081180-4494-26-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
References: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This uses new helpers to remove the default TCE table if the ownership is
being taken and create it otherwise. So once an external user (such as
VFIO) obtained the ownership over a group, it does not have any DMA
windows, neither default 32bit not bypass window. The external user is
expected to unprogram DMA windows on PHBs before returning ownership
back to the kernel.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 30 ++++++++++++++++++++++++++----
 drivers/vfio/vfio_iommu_spapr_tce.c       |  8 ++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 16ddaba..79a8149 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1570,11 +1570,33 @@ static void pnv_ioda2_set_ownership(struct powerpc_iommu *iommu,
 {
 	struct pnv_ioda_pe *pe = container_of(iommu, struct pnv_ioda_pe,
 						iommu);
-	if (enable)
-		iommu_take_ownership(iommu);
-	else
-		iommu_release_ownership(iommu);
+	if (enable) {
+		pnv_pci_ioda2_unset_window(&pe->iommu, 0);
+		pnv_pci_ioda2_free_table(&pe->iommu.tables[0]);
+	} else {
+		struct iommu_table *tbl = &pe->iommu.tables[0];
+		int64_t rc;
 
+		rc = pnv_pci_ioda2_create_table(&pe->iommu, 0,
+				IOMMU_PAGE_SHIFT_4K,
+				ilog2(pe->phb->ioda.m32_pci_base),
+				POWERPC_IOMMU_DEFAULT_LEVELS, tbl);
+		if (rc) {
+			pe_err(pe, "Failed to create 32-bit TCE table, err %ld",
+					rc);
+			return;
+		}
+
+		iommu_init_table(tbl, pe->phb->hose->node);
+
+		rc = pnv_pci_ioda2_set_window(&pe->iommu, 0, tbl);
+		if (rc) {
+			pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
+					rc);
+			pnv_pci_ioda2_free_table(tbl);
+			return;
+		}
+	}
 	pnv_pci_ioda2_set_bypass(pe, !enable);
 }
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index b5134b7..fdcc04c 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -820,8 +820,16 @@ static int tce_iommu_attach_group(void *iommu_data,
 			 * our physical memory via the bypass window instead of just
 			 * the pages that has been explicitly mapped into the iommu
 			 */
+			struct iommu_table tbltmp = { 0 }, *tbl = &tbltmp;
+
 			iommu->ops->set_ownership(iommu, true);
 			container->grp = iommu_group;
+
+			ret = iommu->ops->create_table(iommu, 0,
+					IOMMU_PAGE_SHIFT_4K,
+					ilog2(iommu->tce32_size), 1, tbl);
+			if (!ret)
+				ret = iommu->ops->set_window(iommu, 0, tbl);
 		} else {
 			ret = -ENODEV;
 		}
-- 
2.0.0
