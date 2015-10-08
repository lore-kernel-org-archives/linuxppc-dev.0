Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37B241A0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 17:30:04 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0D33F140187
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 17:30:03 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 16:30:02 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 70A773578054
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 17:29:59 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t986TphK31916122
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 17:29:59 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t986TQpM007108
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 17:29:27 +1100
Date: Thu, 8 Oct 2015 14:29:09 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V4 1/6] powerpc/powernv: don't enable SRIOV when VF BAR
 has non 64bit-prefetchable BAR
Message-ID: <20151008062909.GA3309@Richards-MacBook-Pro.local>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439949704-8023-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <560E466E.9080901@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <560E466E.9080901@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 02, 2015 at 06:55:10PM +1000, Alexey Kardashevskiy wrote:
>On 08/19/2015 12:01 PM, Wei Yang wrote:
>>On PHB_IODA2, we enable SRIOV devices by mapping IOV BAR with M64 BARs. If
>>a SRIOV device's IOV BAR is not 64bit-prefetchable, this is not assigned
>>from 64bit prefetchable window, which means M64 BAR can't work on it.
>
>
>Please change the commit log to explain what limit came from where.
>Something like:
>
>PCI bridges support only 2 windows and the kernel code programs bridges in
>the way that one window is 32bit-nonprefetchable and another one is
>64bit-prefetchable. So if devices' IOV BAR is 64bit and non-prefetchable, it
                   ^

Suggest to add "on powernv platform", since other platform could have a
32bit-prefetchable window.

>will be mapped into 32bit space and therefore M64 cannot be used for it.
>
>
>>
>>This patch makes this explicit.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c |   25 +++++++++----------------
>>  1 file changed, 9 insertions(+), 16 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 85cbc96..8c031b5 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -908,9 +908,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>>  		if (!res->flags || !res->parent)
>>  			continue;
>>
>>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>>-			continue;
>>-
>>  		/*
>>  		 * The actual IOV BAR range is determined by the start address
>>  		 * and the actual size for num_vfs VFs BAR.  This check is to
>>@@ -939,9 +936,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>>  		if (!res->flags || !res->parent)
>>  			continue;
>>
>>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>>-			continue;
>>-
>>  		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>>  		res2 = *res;
>>  		res->start += size * offset;
>>@@ -1221,9 +1215,6 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>>  		if (!res->flags || !res->parent)
>>  			continue;
>>
>>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>>-			continue;
>>-
>>  		for (j = 0; j < vf_groups; j++) {
>>  			do {
>>  				win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
>>@@ -1510,6 +1501,12 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>>  	pdn = pci_get_pdn(pdev);
>>
>>  	if (phb->type == PNV_PHB_IODA2) {
>>+		if (!pdn->vfs_expanded) {
>
>The patch claims it does make the limitation explicit but it is not clear at
>all how to trace from vfs_expanded==0 to "non 64bit-prefetchable IOV BAR".
>

hmm... vfs_expanded is set in pnv_pci_ioda_fixup_iov_resources(), which is
executed before pnv_pci_sriov_enable(). If the PF han no 32bit-prefetchable
BAR, vfs_expanded will be set to a non-zero integer. Otherwise, it is left 0.

I agree this is not obvious. As you suggested, not counting on vfs_expanded,
we need to check each IOV BAR at this place with pnv_pci_is_mem_pref_64(). If
you think this is better, I will change it in next version.

>
>>+			dev_info(&pdev->dev, "don't support this SRIOV device"
>>+				" with non 64bit-prefetchable IOV BAR\n");
>>+			return -ENOSPC;
>>+		}
>>+
>>  		/* Calculate available PE for required VFs */
>>  		mutex_lock(&phb->ioda.pe_alloc_mutex);
>>  		pdn->offset = bitmap_find_next_zero_area(
>>@@ -2775,9 +2772,10 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  		if (!res->flags || res->parent)
>>  			continue;
>>  		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>>-			dev_warn(&pdev->dev, " non M64 VF BAR%d: %pR\n",
>>+			dev_warn(&pdev->dev, "Don't support SR-IOV with"
>>+					" non M64 VF BAR%d: %pR. \n",
>>  				 i, res);
>>-			continue;
>>+			return;
>>  		}
>>
>>  		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>>@@ -2796,11 +2794,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>>  		if (!res->flags || res->parent)
>>  			continue;
>>-		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>
>
>And this check was quite clear. I'd keep this one.
>
>
>>-			dev_warn(&pdev->dev, "Skipping expanding VF BAR%d: %pR\n",
>>-				 i, res);
>>-			continue;
>>-		}
>>
>>  		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
>>  		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
