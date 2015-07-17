Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB8841A075D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:45 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 10:15:44 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 86A8D2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:42 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6H0FXrP57671928
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:42 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6H0F9ws006168
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:09 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/powernv: Fix alignment for IOV BAR
Date: Fri, 17 Jul 2015 10:14:42 +1000
Message-Id: <1437092083-20672-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1437092083-20672-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1437092083-20672-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IOV BAR is extended to cover 256 VFs or number of supported VFs,
the alignment is the IOV BAR size, which is usually huge and bigger
than M64 segment size (256MB). That means the IOV BAR is expected
to be assigned to the beginning of PHB's M64 window prior to other
M64 BARs in PCI devices that are hooked to the PCI bus behind root
port. Other M64 BARs actually need M64 segment size other than the
huge IOV BAR size as the required alignment.

The patch returns M64 segment size if IOV BAR size is bigger than
it when the PF seats behind root port. Otherwise, the IOV BAR size
is returned as before. It will save lots of consumed M64 space,
which would be 16GB in some cases as I observed.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 35 +++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fdafbac..6ec62b9 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2961,16 +2961,39 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 						      int resno)
 {
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
 	struct pci_dn *pdn = pci_get_pdn(pdev);
-	resource_size_t align, iov_align;
+	resource_size_t align;
+	resource_size_t m64_segsz = phb->ioda.m64_segsize;
 
-	iov_align = resource_size(&pdev->resource[resno]);
-	if (iov_align)
-		return iov_align;
+	/*
+	 * When PF is the only one adapter under the PHB, the IOV BAR
+	 * is expected to be assigned prior to any other M64 BARs. To
+	 * have M64 segment size, which is usually smaller than IOV
+	 * BAR size, as the alignment to avoid wasting M64 space to
+	 * satisfy the alignment required by other M64 BARs.
+	 */
+	align = resource_size(&pdev->resource[resno]);
+	if (align) {
+		if (!pci_bus_is_root(pdev->bus) &&
+		    pci_bus_is_root(pdev->bus->self->bus))
+			align = min(align, m64_segsz);
+		else
+			align = max(align, m64_segsz);
+
+		return align;
+	}
 
 	align = pci_iov_resource_size(pdev, resno);
-	if (pdn->vfs_expanded)
-		return pdn->vfs_expanded * align;
+	if (pdn->vfs_expanded) {
+		align = pdn->vfs_expanded * align;
+		if (!pci_bus_is_root(pdev->bus) &&
+		    pci_bus_is_root(pdev->bus->self->bus))
+			align = min(align, m64_segsz);
+		else
+			align = max(align, m64_segsz);
+	}
 
 	return align;
 }
-- 
2.1.0
