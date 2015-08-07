Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFD371A0808
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 11:36:17 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 176631402AC
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 11:36:16 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 07:06:14 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2B4023940053
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 07:06:13 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t771aC1f54395008
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 07:06:12 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t771aCQ9014822
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 07:06:12 +0530
Date: Fri, 7 Aug 2015 09:36:10 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 2/6] powerpc/powernv: simplify the calculation of iov
 resource
Message-ID: <20150807013610.GA8292@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150806045139.GB28524@gwshan> <55C32210.9090803@ozlabs.ru>
 <20150806094102.GB13055@richard> <55C333DB.4080406@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C333DB.4080406@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 06, 2015 at 08:15:55PM +1000, Alexey Kardashevskiy wrote:
>On 08/06/2015 07:41 PM, Wei Yang wrote:
>>On Thu, Aug 06, 2015 at 07:00:00PM +1000, Alexey Kardashevskiy wrote:
>>>On 08/06/2015 02:51 PM, Gavin Shan wrote:
>>>>On Wed, Aug 05, 2015 at 09:24:59AM +0800, Wei Yang wrote:
>>>>>The alignment of IOV BAR on PowerNV platform is the total size of the IOV
>>>>>BAR. No matter whether the IOV BAR is truncated or not, the total size
>>>>>could be calculated by (vfs_expanded * VF size).
>>>>>
>>>>
>>>>s/VF size/VF BAR size
>>>>
>>>>I think the changelog would be more explicit:
>>>>
>>>>The alignment of IOV BAR on PowerNV platform is the total size of the
>>>>IOV BAR, no matter whether the IOV BAR is extended with number of max
>>>>VFs or number of max PE number (256). The alignment can be calculated
>>>>by (vfs_expaned * VF_BAR_size).
>>>
>>>
>>>
>>>Is that really a PowerNV-specific requirement or it is valid for
>>>every platform (I suspect this is the case here)?
>>>
>>
>>Currently, it is PowerNV-specific.
>
>
>How is x86 different on this matter?
>Why would we need this extra alignment, not just VF's BAR alignment?
>
>

The difference lie the "PE" isolation on Power.

>From the MMIO perspective, we use M32 BAR and M64 BAR to map a MMIO range to a
PE#.  M32 is controlled with one M32 BAR, while M64 has 16 BARs.

Now let's back to the pure PCI world. Every PCI device has BAR, which is
required to be size aligned. For example, BAR#0 is 1MB, which means it is 1MB
aligned. Then let's look at the SRIOV case. The PF's IOV BAR (6 BARs at most)
contains the start address of the total_vfs number of VFs BAR. For example, VF
BAR#0 size is 1MB, and suppose PF's IOV BAR#0 is assigned to 0 and total_vfs
is 8. The IOV BAR is mapped to a range [0 - (8MB -1)]. When pci core
allocating the IOV BAR, it just make sure IOV BAR is 1MB aligned, since by
doing so each VF BAR is size aligned. That is x86 does and maybe other
platforms. I believe you understand this part.

Now back to our platform, we want to use M64 BAR to map the IOV BAR. Come to
the example above. The IOV BAR#0 is 8MB size, if we still let the pci core
allocate it with 1MB alignment, our M64 BAR can't work. Since M64 BAR itself
should be size aligned(in this case 8MB.). The same concept as PCI BAR.

>>>
>>>Also, what is the exact meaning of "expanded" in @vfs_expanded? It is
>>>either 255 (if individual VF BARs are <= 64MB) or
>>>roundup_pow_of_two(total_vfs) (which is something like 4 or 16). What
>>>is expanded here?
>>>
>>
>>PF's IOV BAR original size is (VF BAR size * total_vfs).
>>
>>After expanding, the IOV BAR size  is (VF BAR size * 256) or (VF BAR size *
>>roundup_pow_of_two(total_vfs)).
>
>
>Ufff, got it now. I'd store just an expanded IOV BAR size (not some
>magic VFs number) because this is what it actually is:
>pdn->vfs_expanded * align
>

This would change the idea, since VF still could have 6 BARs. In your
proposal, we need to 6 variable to store the expanded size for each.

>
>>>
>>>>
>>>>>This patch simplifies the pnv_pci_iov_resource_alignment() by removing the
>>>>>first case.
>>>>>
>>>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>>
>>>>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>
>>>>>---
>>>>>arch/powerpc/platforms/powernv/pci-ioda.c |   14 +++++++++-----
>>>>>1 file changed, 9 insertions(+), 5 deletions(-)
>>>>>
>>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>index 9b41dba..7192e62 100644
>>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>@@ -2987,12 +2987,16 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>>>>>						      int resno)
>>>>>{
>>>>>	struct pci_dn *pdn = pci_get_pdn(pdev);
>>>>>-	resource_size_t align, iov_align;
>>>>>-
>>>>>-	iov_align = resource_size(&pdev->resource[resno]);
>>>>>-	if (iov_align)
>>>>>-		return iov_align;
>>>>>+	resource_size_t align;
>>>>>
>>>>>+	/*
>>>>>+	 * On PowerNV platform, IOV BAR is mapped by M64 BAR to enable the
>>>>>+	 * SR-IOV. While from hardware perspective, the range mapped by M64
>>>>>+	 * BAR should be size aligned.
>>>>>+	 *
>>>>>+	 * This function return the total IOV BAR size if expanded or just the
>>>>>+	 * individual size if not.
>>>>>+	 */
>>>>>	align = pci_iov_resource_size(pdev, resno);
>>>>>	if (pdn->vfs_expanded)
>>>>>		return pdn->vfs_expanded * align;
>>>>>--
>>>>>1.7.9.5
>>>>>
>>>>
>>>
>>>
>>>--
>>>Alexey
>>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
