Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 90262141345
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 00:23:27 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 6 May 2014 19:53:25 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id ED4BBE004B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 19:53:48 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s46ENR2641353376
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 19:53:27 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s46ENKEw023947
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 19:53:21 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH] KVM: PPC: BOOK3S: HV: THP support for guest
In-Reply-To: <5368A78D.4070509@suse.de>
References: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5368A78D.4070509@suse.de>
Date: Tue, 06 May 2014 19:53:19 +0530
Message-ID: <87tx93q948.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 05/04/2014 07:30 PM, Aneesh Kumar K.V wrote:
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

....
....

>>   static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
>>   {
>> +	int size, a_size;
>> +	/* Look at the 8 bit LP value */
>> +	unsigned int lp = (l >> LP_SHIFT) & ((1 << LP_BITS) - 1);
>> +
>>   	/* only handle 4k, 64k and 16M pages for now */
>>   	if (!(h & HPTE_V_LARGE))
>> -		return 1ul << 12;		/* 4k page */
>> -	if ((l & 0xf000) == 0x1000 && cpu_has_feature(CPU_FTR_ARCH_206))
>> -		return 1ul << 16;		/* 64k page */
>> -	if ((l & 0xff000) == 0)
>> -		return 1ul << 24;		/* 16M page */
>> -	return 0;				/* error */
>> +		return 1ul << 12;
>> +	else {
>> +		for (size = 0; size < MMU_PAGE_COUNT; size++) {
>> +			/* valid entries have a shift value */
>> +			if (!mmu_psize_defs[size].shift)
>> +				continue;
>> +
>> +			a_size = __hpte_actual_psize(lp, size);
>
> a_size as psize is probably a slightly confusing namer. Just call it 
> a_psize.

Will update.

>
> So if I understand this patch correctly, it simply introduces logic to 
> handle page sizes other than 4k, 64k, 16M by analyzing the actual page 
> size field in the HPTE. Mind to explain why exactly that enables us to 
> use THP?
>
> What exactly is the flow if the pages are not backed by huge pages? What 
> is the flow when they start to get backed by huge pages?
>
>> +			if (a_size != -1)
>> +				return 1ul << mmu_psize_defs[a_size].shift;
>> +		}
>> +
>> +	}
>> +	return 0;
>>   }
>>   
>>   static inline unsigned long hpte_rpn(unsigned long ptel, unsigned long psize)
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 8227dba5af0f..a38d3289320a 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -1949,6 +1949,13 @@ static void kvmppc_add_seg_page_size(struct kvm_ppc_one_seg_page_size **sps,
>>   	 * support pte_enc here
>>   	 */
>>   	(*sps)->enc[0].pte_enc = def->penc[linux_psize];
>> +	/*
>> +	 * Add 16MB MPSS support
>> +	 */
>> +	if (linux_psize != MMU_PAGE_16M) {
>> +		(*sps)->enc[1].page_shift = 24;
>> +		(*sps)->enc[1].pte_enc = def->penc[MMU_PAGE_16M];
>> +	}
>
> So this basically indicates that every segment (except for the 16MB one) 
> can also handle 16MB MPSS page sizes? I suppose you want to remove the 
> comment in kvm_vm_ioctl_get_smmu_info_hv() that says we don't do MPSS
> here.

Will do

>
> Can we also ensure that every system we run on can do MPSS?
>

Will do

-aneesh
