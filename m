Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 563861A03E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 11:45:30 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2C72A140549
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 11:45:30 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 10:45:28 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B97AB2BB0051
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 11:45:23 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9L0jHFQ32112808
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 11:45:25 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9L0ioLo006640
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 11:44:51 +1100
Date: Wed, 21 Oct 2015 11:44:26 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH V6 1/6] powerpc/powernv: don't enable SRIOV when VF BAR
 has non 64bit-prefetchable BAR
Message-ID: <20151021004426.GA19956@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1445331785-4645-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445331785-4645-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445331785-4645-2-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 20, 2015 at 05:03:00PM +0800, Wei Yang wrote:
>On PHB_IODA2, we enable SRIOV devices by mapping IOV BAR with M64 BARs. If
    ^^^^^^^^^

s/PHB_IODA2/PHB3 or s/PHB_IODA2/IODA2 PHB

>a SRIOV device's IOV BAR is not 64bit-prefetchable, this is not assigned
>from 64bit prefetchable window, which means M64 BAR can't work on it.
>
>The reason is PCI bridges support only 2 windows and the kernel code
                                        ^^^^^^^^^

It would be more accurate: "2 memory windows".

>programs bridges in the way that one window is 32bit-nonprefetchable and
>the other one is 64bit-prefetchable. So if devices' IOV BAR is 64bit and
>non-prefetchable, it will be mapped into 32bit space and therefore M64
>cannot be used for it.
>
>This patch makes this explicit and truncate IOV resource in this case to
                                    ^^^^^^^^
>save MMIO space.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 34 ++++++++++++++++---------------
> 1 file changed, 18 insertions(+), 16 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 85cbc96..f042fed 100644
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
>@@ -2775,9 +2772,10 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> 		if (!res->flags || res->parent)
> 			continue;
> 		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>-			dev_warn(&pdev->dev, " non M64 VF BAR%d: %pR\n",
>+			dev_warn(&pdev->dev, "Don't support SR-IOV with"
>+					" non M64 VF BAR%d: %pR. \n",
> 				 i, res);
>-			continue;
>+			goto truncate_iov;
> 		}
>
> 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>@@ -2796,11 +2794,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
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
>@@ -2810,6 +2803,15 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> 			 i, res, mul);
> 	}
> 	pdn->vfs_expanded = mul;
>+
>+	return;
>+
>+truncate_iov:
>+	/* To save MMIO space, IOV BAR is truncated. */
>+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>+		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>+		res->end = res->start - 1;
>+	}

res->flags isn't cleared out, the IOV BAR will be counted in the optional list
in resource sizing stage. However, the size has became zero. It's obvious not
necessary to do that. I doubt this piece of code has been really testified on
real PCI adapter or one with emulated M32 IOV BAR?

> }
> #endif /* CONFIG_PCI_IOV */
>
>-- 
>2.5.0
>
