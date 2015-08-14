Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CFE81A009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 10:31:23 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42FB71401CD
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:31:23 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 10:31:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3465B2BB004D
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:31:19 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E0VBhe63963166
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:31:19 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E0UkCo004237
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 10:30:46 +1000
Date: Fri, 14 Aug 2015 10:30:21 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 1/6] powerpc/powernv: don't enable SRIOV when VF BAR
 has non 64bit-prefetchable BAR
Message-ID: <20150814003021.GA14809@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439475071-7001-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439475071-7001-2-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 13, 2015 at 10:11:06PM +0800, Wei Yang wrote:
>On PHB_IODA2, we enable SRIOV devices by mapping IOV BAR with M64 BARs. If
>a SRIOV device's IOV BAR is not 64bit-prefetchable, this is not assigned
>from 64bit prefetchable window, which means M64 BAR can't work on it.
>
>This patch makes this explicit.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/platforms/powernv/pci-ioda.c |   25 +++++++++----------------
> 1 file changed, 9 insertions(+), 16 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 5738d31..9ac324e 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -908,9 +908,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
> 		if (!res->flags || !res->parent)
> 			continue;
>
>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>-			continue;
>-
> 		/*
> 		 * The actual IOV BAR range is determined by the start address
> 		 * and the actual size for num_vfs VFs BAR.  This check is to
>@@ -939,9 +936,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
> 		if (!res->flags || !res->parent)
> 			continue;
>
>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>-			continue;
>-
> 		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
> 		res2 = *res;
> 		res->start += size * offset;
>@@ -1221,9 +1215,6 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
> 		if (!res->flags || !res->parent)
> 			continue;
>
>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>-			continue;
>-
> 		for (j = 0; j < vf_groups; j++) {
> 			do {
> 				win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
>@@ -1510,6 +1501,12 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
> 	pdn = pci_get_pdn(pdev);
>
> 	if (phb->type == PNV_PHB_IODA2) {
>+		if (!pdn->vfs_expanded) {
>+			dev_info(&pdev->dev, "don't support this SRIOV device"
>+				" with non 64bit-prefetchable IOV BAR\n");
>+			return -ENOSPC;
>+		}
>+
> 		/* Calculate available PE for required VFs */
> 		mutex_lock(&phb->ioda.pe_alloc_mutex);
> 		pdn->offset = bitmap_find_next_zero_area(
>@@ -2774,9 +2771,10 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> 		if (!res->flags || res->parent)
> 			continue;
> 		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>-			dev_warn(&pdev->dev, " non M64 VF BAR%d: %pR\n",
>+			dev_warn(&pdev->dev, "Don't support SR-IOV with"
>+					" non M64 VF BAR%d: %pR. \n",
> 				 i, res);
>-			continue;
>+			return;
> 		}
>
> 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>@@ -2795,11 +2793,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
> 		if (!res->flags || res->parent)
> 			continue;
>-		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>-			dev_warn(&pdev->dev, "Skipping expanding VF BAR%d: %pR\n",
>-				 i, res);
>-			continue;
>-		}
>
> 		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
> 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>-- 
>1.7.9.5
>
