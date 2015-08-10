Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EBE71A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 11:40:58 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C61771401CD
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 11:40:57 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 10 Aug 2015 07:10:55 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id BC5A3E004C
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 07:15:11 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7A1eqVF49938648
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 07:10:52 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7A1epKR015163
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 07:10:52 +0530
Date: Mon, 10 Aug 2015 09:40:50 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 1/6] powerpc/powernv: don't enable SRIOV when VF BAR
 contains non M64 BAR
Message-ID: <20150810014050.GB8735@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150806043557.GA28524@gwshan> <20150806141010.GD6235@richard>
 <20150807012010.GB19021@gwshan> <20150807022405.GF8292@richard>
 <55C45AE1.3040404@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C45AE1.3040404@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2015 at 05:14:41PM +1000, Alexey Kardashevskiy wrote:
>On 08/07/2015 12:24 PM, Wei Yang wrote:
>>On Fri, Aug 07, 2015 at 11:20:10AM +1000, Gavin Shan wrote:
>>>On Thu, Aug 06, 2015 at 10:10:10PM +0800, Wei Yang wrote:
>>>>On Thu, Aug 06, 2015 at 02:35:57PM +1000, Gavin Shan wrote:
>>>>>On Wed, Aug 05, 2015 at 09:24:58AM +0800, Wei Yang wrote:
>>>>>>On PHB_IODA2, we enable SRIOV devices by mapping IOV BAR with M64 BARs. If
>>>>>>a SRIOV device's BAR is not 64-bit prefetchable, this is not assigned from
>>>>>>M64 windwo, which means M64 BAR can't work on it.
>>>>>>
>>>>>
>>>>>s/PHB_IODA2/PHB3
>>>>>s/windwo/window
>>>>>
>>>>>>This patch makes this explicit.
>>>>>>
>>>>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>>>
>>>>>The idea sounds right, but there is one question as below.
>>>>>
>>>>>>---
>>>>>>arch/powerpc/platforms/powernv/pci-ioda.c |   25 +++++++++----------------
>>>>>>1 file changed, 9 insertions(+), 16 deletions(-)
>>>>>>
>>>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>>index 5738d31..9b41dba 100644
>>>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>>@@ -908,9 +908,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>>>>>>		if (!res->flags || !res->parent)
>>>>>>			continue;
>>>>>>
>>>>>>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>>>>>>-			continue;
>>>>>>-
>>>>>>		/*
>>>>>>		 * The actual IOV BAR range is determined by the start address
>>>>>>		 * and the actual size for num_vfs VFs BAR.  This check is to
>>>>>>@@ -939,9 +936,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>>>>>>		if (!res->flags || !res->parent)
>>>>>>			continue;
>>>>>>
>>>>>>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>>>>>>-			continue;
>>>>>>-
>>>>>>		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>>>>>>		res2 = *res;
>>>>>>		res->start += size * offset;
>>>>>>@@ -1221,9 +1215,6 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>>>>>>		if (!res->flags || !res->parent)
>>>>>>			continue;
>>>>>>
>>>>>>-		if (!pnv_pci_is_mem_pref_64(res->flags))
>>>>>>-			continue;
>>>>>>-
>>>>>>		for (j = 0; j < vf_groups; j++) {
>>>>>>			do {
>>>>>>				win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
>>>>>>@@ -1510,6 +1501,12 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>>>>>>	pdn = pci_get_pdn(pdev);
>>>>>>
>>>>>>	if (phb->type == PNV_PHB_IODA2) {
>>>>>>+		if (!pdn->vfs_expanded) {
>>>>>>+			dev_info(&pdev->dev, "don't support this SRIOV device"
>>>>>>+				" with non M64 VF BAR\n");
>>>>>>+			return -EBUSY;
>>>>>>+		}
>>>>>>+
>>>>>
>>>>>It would be -ENOSPC since -EBUSY indicates the devices (VFs) are temparily
>>>>>unavailable. For this case, the VFs are permanently unavailable because of
>>>>>running out of space to accomodate M64 and non-M64 VF BARs.
>>>>>
>>>>>The error message could be printed with dev_warn() and it would be precise
>>>>>as below or something else you prefer:
>>>>>
>>>>>	dev_warn(&pdev->dev, "SRIOV not supported because of non-M64 VF BAR\n");
>>>>>
>>>>
>>>>Thanks for the comment, will change accordingly.
>>>>
>>>>>
>>>>>>		/* Calculate available PE for required VFs */
>>>>>>		mutex_lock(&phb->ioda.pe_alloc_mutex);
>>>>>>		pdn->offset = bitmap_find_next_zero_area(
>>>>>>@@ -2774,9 +2771,10 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>>>>>		if (!res->flags || res->parent)
>>>>>>			continue;
>>>>>>		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>>>>>>-			dev_warn(&pdev->dev, " non M64 VF BAR%d: %pR\n",
>>>>>>+			dev_warn(&pdev->dev, "Don't support SR-IOV with"
>>>>>>+					" non M64 VF BAR%d: %pR. \n",
>>>>>>				 i, res);
>>>>>>-			continue;
>>>>>>+			return;
>>>>>>		}
>>>>>>
>>>>>>		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>>>>>>@@ -2795,11 +2793,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>>>>>		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>>>>>>		if (!res->flags || res->parent)
>>>>>>			continue;
>>>>>>-		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>>>>>>-			dev_warn(&pdev->dev, "Skipping expanding VF BAR%d: %pR\n",
>>>>>>-				 i, res);
>>>>>>-			continue;
>>>>>>-		}
>>>>>
>>>>>When any one IOV BAR on the PF is non-M64, none of the VFs can be enabled.
>>>>>Will we still allocate/assign M64 or M32 resources for the IOV BARs? If so,
>>>>>I think it can be avoided.
>>>>>
>>>>
>>>>Don't get your point. You mean to avoid this function?
>>>>
>>>>Or clear the IOV BAR when we found one of it is non-M64?
>>>>
>>>
>>>I mean to clear all IOV BARs in case any more of them are IO or M32. In this
>>>case, the SRIOV capability won't be enabled. Otherwise, the resources for
>>>all IOV BARs are assigned and allocated by PCI subsystem, but they won't
>>>be used. Does it make sense to you?
>>>
>>
>>If we want to save MMIO space, this is not necessary.
>>
>>The IOV BAR will be put into the optional list in assignment stage. So when
>>there is not enough MMIO space, they will not be assigned.
>
>
>If we are not going to use non-64bit IOV BAR, why would we assign
>anything to it at the first place? Or it is a common PCI code which
>does it?
>

Yes.

First skiboot will allocate the range, then kernel read it. Kernel has two
choice, use the address firmware allocated or re-assigned them as we did on
powernv platform

>
>
>
>>For the long term, maybe P9/P10, we will finally adjust the solution to
>>support SRIOV devices with M32 MMIO. So I suggest to leave as it is.
>>
>>>>>>
>>>>>>		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
>>>>>>		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
