Return-Path: <nacc@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC735100991
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 04:33:41 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o98HH9bb029918
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 13:17:09 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o98HXc2r137062
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 13:33:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o98HXb0u027363
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 13:33:38 -0400
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 07/11] ppc/iommu: do not need to check for dma_window ==
	NULL
Date: Fri,  8 Oct 2010 10:33:08 -0700
Message-Id: <1286559192-10898-8-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
References: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, miltonm@bga.com,
	Paul Mackerras <paulus@samba.org>,
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
