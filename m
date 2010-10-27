Return-Path: <nacc@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF4A0B7105
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 14:36:01 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9R3K4VT032538
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 23:20:04 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9R3Zj5b167548
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 23:35:45 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9R3ZjvU003285
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 23:35:45 -0400
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 5/7 v2] ppc/iommu: do not need to check for dma_window ==
	NULL
Date: Tue, 26 Oct 2010 20:35:15 -0700
Message-Id: <1288150518-4026-6-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
Cc: sonnyrao@us.ibm.com, miltonm@bga.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The block in pci_dma_dev_setup_pSeriesLP for dma_window == NULL can be
removed because we will only teminate the loop if we had already allocated
a iommu table for that node or we found a window.  While there may be
no window for the device, the intresting part is if we are reusing a
table or creating it for the first device under it.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 0ae5a60..9d564b9 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -530,12 +530,6 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	}
 	pr_debug("  parent is %s\n", pdn->full_name);
 
-	if (dma_window == NULL) {
-		pr_debug("  no dma window for device, linking to parent\n");
-		set_iommu_table_base(&dev->dev, PCI_DN(pdn)->iommu_table);
-		return;
-	}
-
 	pci = PCI_DN(pdn);
 	if (!pci->iommu_table) {
 		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-- 
1.7.1
