Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYF7T6hZyzDsT0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 16:26:29 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8D6IfgI131356
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:26:27 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25dxa0s21e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:26:26 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 13 Sep 2016 16:26:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 44A9B2BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 16:26:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8D6QMlm66781256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 16:26:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8D6QLYi017965
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 16:26:22 +1000
Date: Tue, 13 Sep 2016 11:56:17 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] KVM: PPC: Book3S HV: Fall back to same size HPT in
 allocation ioctl
References: <1473678797-22069-1-git-send-email-khandual@linux.vnet.ibm.com>
 <8760q1pblj.fsf@linux.vnet.ibm.com>
In-Reply-To: <8760q1pblj.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <57D79C09.9060502@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/2016 05:35 PM, Aneesh Kumar K.V wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> When the HPT size is explicitly passed on from the userspace, currently
>> the KVM_PPC_ALLOCATE_HTAB will try to allocate the requested size of HPT
>> from reserved CMA area and if that is not possible, the allocation just
>> fails. With the commit 572abd563befd56 ("KVM: PPC: Book3S HV: Don't fall
>> back to smaller HPT size in allocation ioctl"), it does not even try to
>> allocate the same order pages from the page allocator before failing for
>> good. Same order allocation should be attempted from the page allocator
>> as a fallback option when the CMA allocation attempt fails.
> 
> IMO we should fix the reason for these CMA allocation failure. We are just

IMHO, irrespective of the ability of CMA to satisfy allocation requests,
a fall back option from page allocator should always be there when the
guest is failing to start due to unavailability of memory. In my previous
response in this thread, also pointed out how there need to be a parity
between what we do for cases when ioctl calls specify size or not from
having a fallback option.

> doing work around here.
> 
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>> - This change saves guests from failing to start after migration
>>
>>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> index 05f09ae..0a30eb4 100644
>> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> @@ -78,6 +78,14 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>>  			--order;
>>  	}
>>
>> +	/*
>> +	 * Fallback in case the userspace has provided a size via ioctl.
>> +	 * Try allocating the same order pages from the page allocator.
>> +	 */
>> +	if (!hpt && order > PPC_MIN_HPT_ORDER && htab_orderp)
>> +		hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|
>> +			__GFP_NOWARN, order - PAGE_SHIFT);
>> +
>>  	if (!hpt)
>>  		return -ENOMEM;
> 
> A better way to do that would be (not even compile tested) ?
> 
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 65b2b00d93d7..3f8995f27339 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -68,16 +68,18 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>  		memset((void *)hpt, 0, (1ul << order));
>  		kvm->arch.hpt_cma_alloc = 1;
>  	}
> -
> -	/* Lastly try successively smaller sizes from the page allocator */
> -	/* Only do this if userspace didn't specify a size via ioctl */
> -	while (!hpt && order > PPC_MIN_HPT_ORDER && !htab_orderp) {
> +	/*
> +	 * Try successively smaller sizes from the page allocator.
> +	 * If a size was specified via an ioctl, we just try that
> +	 * specific size
> +	 */
> +-	while (!hpt && order > PPC_MIN_HPT_ORDER) {
>  		hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|
>  				       __GFP_NOWARN, order - PAGE_SHIFT);
> -		if (!hpt)
> -			--order;
> +		if (htab_orderp)
> +			break;
> +		--order;
>  	}
> -
>  	if (!hpt)
>  		return -ENOMEM;
> 

Initially thought about this way but then decided not to change this
existing code block instead just one more. But anything is fine, I
can just change this next time around.
