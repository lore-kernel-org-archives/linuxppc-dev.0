Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32F2E1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 17:40:12 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0CDA0140D72
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 17:40:11 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 16:40:09 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 31E533578052
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 17:40:06 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t986dv2A28573914
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 17:40:06 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t986dXoS011027
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 17:39:33 +1100
Date: Thu, 8 Oct 2015 14:39:16 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V4 2/6] powerpc/powernv: simplify the calculation of iov
 resource alignment
Message-ID: <20151008063916.GB3309@Richards-MacBook-Pro.local>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439949704-8023-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <560E4721.1090007@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <560E4721.1090007@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 02, 2015 at 06:58:09PM +1000, Alexey Kardashevskiy wrote:
>On 08/19/2015 12:01 PM, Wei Yang wrote:
>>The alignment of IOV BAR on PowerNV platform is the total size of the IOV
>>BAR. No matter whether the IOV BAR is extended with number of
>>roundup_pow_of_two(total_vfs) or number of max PE number (256), the total
>>size could be calculated by (vfs_expanded * VF_BAR_size).
>>
>>This patch simplifies the pnv_pci_iov_resource_alignment() by removing the
>>first case.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c |   14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 8c031b5..e3e0acb 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -2988,12 +2988,16 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>>  						      int resno)
>>  {
>>  	struct pci_dn *pdn = pci_get_pdn(pdev);
>>-	resource_size_t align, iov_align;
>>-
>>-	iov_align = resource_size(&pdev->resource[resno]);
>>-	if (iov_align)
>>-		return iov_align;
>>+	resource_size_t align;
>>
>>+	/*
>>+	 * On PowerNV platform, IOV BAR is mapped by M64 BAR to enable the
>>+	 * SR-IOV. While from hardware perspective, the range mapped by M64
>>+	 * BAR should be size aligned.
>
>
>Out of curiosity - IOV BAR does NOT have to be aligned on other platforms?
>

Quick answer, NO. On other platforms, the alignment applies to VF BAR size.

IOV BAR is composed with several VF BAR. 
    
    IOV BAR size = VF BAR size * total_vfs

And usually VF BAR size equals to one of the PF's BAR size. According to the
SPEC, IOV BAR should be VF BAR size aligned, instead of the IOV BAR size
aligned. This requirement is implicitly met, since PF's BAR alignment is took
into consideration.

The IOV BAR alignment is based on M64 BAR on powernv.

>
>>+	 *
>>+	 * This function returns the total IOV BAR size if expanded or just the
>>+	 * individual size if not.
>
>Expanded vs. non-expanded means "using shared M64" (when it is split by 256
>segments) vs. "using entire M64"?
>

Yes, you are right.

When we use "shared M64", IOV BAR should be aligned by its total size. Then we
need to return the total size.

When we use "entire M64", IOV BAR just need to be aligned with VF BAR size.
That's why just return individual size.

>
>>+	 */
>>  	align = pci_iov_resource_size(pdev, resno);
>>  	if (pdn->vfs_expanded)
>>  		return pdn->vfs_expanded * align;
>>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
