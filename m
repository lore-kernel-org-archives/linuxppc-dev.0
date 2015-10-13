Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA46A1A098C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 12:50:54 +1100 (AEDT)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C1DB0140DA5
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 12:50:53 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 07:20:51 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7A556E005A
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 07:20:44 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9D1olpb39649380
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 07:20:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9D1ok8S003154
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 07:20:47 +0530
Date: Tue, 13 Oct 2015 09:49:30 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, aik@ozlabs.ru,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH V5 1/6] powerpc/powernv: don't enable SRIOV when VF BAR
 has non 64bit-prefetchable BAR
Message-ID: <20151013014930.GA1437@Richards-MacBook-Pro.local>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1444358816-8163-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1444358816-8163-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <20151013000124.GA20966@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151013000124.GA20966@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2015 at 11:01:24AM +1100, Gavin Shan wrote:
>On Fri, Oct 09, 2015 at 10:46:51AM +0800, Wei Yang wrote:
>>On PHB_IODA2, we enable SRIOV devices by mapping IOV BAR with M64 BARs. If
>>a SRIOV device's IOV BAR is not 64bit-prefetchable, this is not assigned
>>from 64bit prefetchable window, which means M64 BAR can't work on it.
>>
>>The reason is PCI bridges support only 2 windows and the kernel code
>>programs bridges in the way that one window is 32bit-nonprefetchable and
>>the other one is 64bit-prefetchable. So if devices' IOV BAR is 64bit and
>>non-prefetchable, it will be mapped into 32bit space and therefore M64
>>cannot be used for it.
>>
>>This patch makes this explicit.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>---
>> arch/powerpc/platforms/powernv/pci-ioda.c | 25 +++++++++----------------
>> 1 file changed, 9 insertions(+), 16 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 85cbc96..8c031b5 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -908,9 +908,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>> 		if (!res->flags || !res->parent)
>> 			continue;
>>
>>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>>-			continue;
>>-
>> 		/*
>> 		 * The actual IOV BAR range is determined by the start address
>> 		 * and the actual size for num_vfs VFs BAR.  This check is to
>>@@ -939,9 +936,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>> 		if (!res->flags || !res->parent)
>> 			continue;
>>
>>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>>-			continue;
>>-
>> 		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>> 		res2 = *res;
>> 		res->start += size * offset;
>>@@ -1221,9 +1215,6 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>> 		if (!res->flags || !res->parent)
>> 			continue;
>>
>>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>>-			continue;
>>-
>> 		for (j = 0; j < vf_groups; j++) {
>> 			do {
>> 				win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
>>@@ -1510,6 +1501,12 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>> 	pdn = pci_get_pdn(pdev);
>>
>> 	if (phb->type == PNV_PHB_IODA2) {
>>+		if (!pdn->vfs_expanded) {
>>+			dev_info(&pdev->dev, "don't support this SRIOV device"
>>+				" with non 64bit-prefetchable IOV BAR\n");
>>+			return -ENOSPC;
>>+		}
>>+
>> 		/* Calculate available PE for required VFs */
>> 		mutex_lock(&phb->ioda.pe_alloc_mutex);
>> 		pdn->offset = bitmap_find_next_zero_area(
>>@@ -2775,9 +2772,10 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> 		if (!res->flags || res->parent)
>> 			continue;
>> 		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>>-			dev_warn(&pdev->dev, " non M64 VF BAR%d: %pR\n",
>>+			dev_warn(&pdev->dev, "Don't support SR-IOV with"
>>+					" non M64 VF BAR%d: %pR. \n",
>> 				 i, res);
>>-			continue;
>>+			return;
>
>When the IOV BAR isn't 64-bits prefetchable one, it's going to be allocated from
>M32 aperatus. However, the IOV BAR won't be used as the SRIOV capability on the PF
>can't be enabled. Occasionally, the IOV BAR is huge (e.g. 4GB) and it eats up all
>M32 space, BARs other than 64-bits prefetchable BARs on other device will fail in
>this case. Would it a problem you ever thought of?
>

IOV BARs are in optional list during assignment.

>> 		}
>>
>> 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>>@@ -2796,11 +2794,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> 		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>> 		if (!res->flags || res->parent)
>> 			continue;
>>-		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>>-			dev_warn(&pdev->dev, "Skipping expanding VF BAR%d: %pR\n",
>>-				 i, res);
>>-			continue;
>>-		}
>>
>> 		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
>> 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>>-- 
>>2.5.0
>>

-- 
Richard Yang
Help you, Help me
