Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 005AA1A2D0C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 19:41:08 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 52C121402B7
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 19:41:08 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 15:11:06 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2345E1258061
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 15:14:14 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t769f4cD65732758
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 15:11:04 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t769f3mi004647
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 15:11:03 +0530
Date: Thu, 6 Aug 2015 17:41:02 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 2/6] powerpc/powernv: simplify the calculation of iov
 resource
Message-ID: <20150806094102.GB13055@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150806045139.GB28524@gwshan> <55C32210.9090803@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C32210.9090803@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 06, 2015 at 07:00:00PM +1000, Alexey Kardashevskiy wrote:
>On 08/06/2015 02:51 PM, Gavin Shan wrote:
>>On Wed, Aug 05, 2015 at 09:24:59AM +0800, Wei Yang wrote:
>>>The alignment of IOV BAR on PowerNV platform is the total size of the IOV
>>>BAR. No matter whether the IOV BAR is truncated or not, the total size
>>>could be calculated by (vfs_expanded * VF size).
>>>
>>
>>s/VF size/VF BAR size
>>
>>I think the changelog would be more explicit:
>>
>>The alignment of IOV BAR on PowerNV platform is the total size of the
>>IOV BAR, no matter whether the IOV BAR is extended with number of max
>>VFs or number of max PE number (256). The alignment can be calculated
>>by (vfs_expaned * VF_BAR_size).
>
>
>
>Is that really a PowerNV-specific requirement or it is valid for
>every platform (I suspect this is the case here)?
>

Currently, it is PowerNV-specific.

>
>Also, what is the exact meaning of "expanded" in @vfs_expanded? It is
>either 255 (if individual VF BARs are <= 64MB) or
>roundup_pow_of_two(total_vfs) (which is something like 4 or 16). What
>is expanded here?
>

PF's IOV BAR original size is (VF BAR size * total_vfs). 

After expanding, the IOV BAR size  is (VF BAR size * 256) or (VF BAR size *
roundup_pow_of_two(total_vfs)).

>
>>
>>>This patch simplifies the pnv_pci_iov_resource_alignment() by removing the
>>>first case.
>>>
>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>
>>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>
>>>---
>>>arch/powerpc/platforms/powernv/pci-ioda.c |   14 +++++++++-----
>>>1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>index 9b41dba..7192e62 100644
>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>@@ -2987,12 +2987,16 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>>>						      int resno)
>>>{
>>>	struct pci_dn *pdn = pci_get_pdn(pdev);
>>>-	resource_size_t align, iov_align;
>>>-
>>>-	iov_align = resource_size(&pdev->resource[resno]);
>>>-	if (iov_align)
>>>-		return iov_align;
>>>+	resource_size_t align;
>>>
>>>+	/*
>>>+	 * On PowerNV platform, IOV BAR is mapped by M64 BAR to enable the
>>>+	 * SR-IOV. While from hardware perspective, the range mapped by M64
>>>+	 * BAR should be size aligned.
>>>+	 *
>>>+	 * This function return the total IOV BAR size if expanded or just the
>>>+	 * individual size if not.
>>>+	 */
>>>	align = pci_iov_resource_size(pdev, resno);
>>>	if (pdn->vfs_expanded)
>>>		return pdn->vfs_expanded * align;
>>>--
>>>1.7.9.5
>>>
>>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
