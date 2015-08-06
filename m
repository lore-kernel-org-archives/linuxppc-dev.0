Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1984D1A3995
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:36:59 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E1988140291
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 14:36:58 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:36:57 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E91E93578057
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 14:36:54 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764amx964880852
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 14:36:56 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764aMPA015518
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 14:36:22 +1000
Date: Thu, 6 Aug 2015 14:35:57 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 1/6] powerpc/powernv: don't enable SRIOV when VF BAR
 contains non M64 BAR
Message-ID: <20150806043557.GA28524@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438737903-10399-2-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 05, 2015 at 09:24:58AM +0800, Wei Yang wrote:
>On PHB_IODA2, we enable SRIOV devices by mapping IOV BAR with M64 BARs. If
>a SRIOV device's BAR is not 64-bit prefetchable, this is not assigned from
>M64 windwo, which means M64 BAR can't work on it.
>

s/PHB_IODA2/PHB3
s/windwo/window

>This patch makes this explicit.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

The idea sounds right, but there is one question as below.

>---
> arch/powerpc/platforms/powernv/pci-ioda.c |   25 +++++++++----------------
> 1 file changed, 9 insertions(+), 16 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 5738d31..9b41dba 100644
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
>+				" with non M64 VF BAR\n");
>+			return -EBUSY;
>+		}
>+

It would be -ENOSPC since -EBUSY indicates the devices (VFs) are temparily
unavailable. For this case, the VFs are permanently unavailable because of
running out of space to accomodate M64 and non-M64 VF BARs.

The error message could be printed with dev_warn() and it would be precise
as below or something else you prefer:

	dev_warn(&pdev->dev, "SRIOV not supported because of non-M64 VF BAR\n");


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

When any one IOV BAR on the PF is non-M64, none of the VFs can be enabled.
Will we still allocate/assign M64 or M32 resources for the IOV BARs? If so,
I think it can be avoided.

>
> 		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
> 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>-- 
>1.7.9.5
>
