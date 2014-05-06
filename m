Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4F6C9140E3B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 19:39:51 +1000 (EST)
Message-ID: <5368ADE3.1050503@suse.de>
Date: Tue, 06 May 2014 11:39:47 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] KVM: PPC: BOOK3S: HV: THP support for guest
References: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5368A78D.4070509@suse.de> <1399368400.18906.9.camel@pasglop>
In-Reply-To: <1399368400.18906.9.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2014 11:26 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2014-05-06 at 11:12 +0200, Alexander Graf wrote:
>
>> So if I understand this patch correctly, it simply introduces logic to
>> handle page sizes other than 4k, 64k, 16M by analyzing the actual page
>> size field in the HPTE. Mind to explain why exactly that enables us to
>> use THP?
>>
>> What exactly is the flow if the pages are not backed by huge pages? What
>> is the flow when they start to get backed by huge pages?
> The hypervisor doesn't care about segments ... but it needs to properly
> decode the page size requested by the guest, if anything, to issue the
> right form of tlbie instruction.
>
> The encoding in the HPTE for a 16M page inside a 64K segment is
> different than the encoding for a 16M in a 16M segment, this is done so
> that the encoding carries both information, which allows broadcast
> tlbie to properly find the right set in the TLB for invalidations among
> others.
>
> So from a KVM perspective, we don't know whether the guest is doing THP
> or something else (Linux calls it THP but all we care here is that this
> is MPSS, another guest than Linux might exploit that differently).

Ugh. So we're just talking about a guest using MPSS here? Not about the 
host doing THP? I must've missed that part.

>
> What we do know is that if we advertise MPSS, we need to decode the page
> sizes encoded in the HPTE so that we know what we are dealing with in
> H_ENTER and can do the appropriate TLB invalidations in H_REMOVE &
> evictions.

Yes. That makes a lot of sense. So this patch really is all about 
enabling MPSS support for 16MB pages. No more, no less.

>
>>> +			if (a_size != -1)
>>> +				return 1ul << mmu_psize_defs[a_size].shift;
>>> +		}
>>> +
>>> +	}
>>> +	return 0;
>>>    }
>>>    
>>>    static inline unsigned long hpte_rpn(unsigned long ptel, unsigned long psize)
>>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>>> index 8227dba5af0f..a38d3289320a 100644
>>> --- a/arch/powerpc/kvm/book3s_hv.c
>>> +++ b/arch/powerpc/kvm/book3s_hv.c
>>> @@ -1949,6 +1949,13 @@ static void kvmppc_add_seg_page_size(struct kvm_ppc_one_seg_page_size **sps,
>>>    	 * support pte_enc here
>>>    	 */
>>>    	(*sps)->enc[0].pte_enc = def->penc[linux_psize];
>>> +	/*
>>> +	 * Add 16MB MPSS support
>>> +	 */
>>> +	if (linux_psize != MMU_PAGE_16M) {
>>> +		(*sps)->enc[1].page_shift = 24;
>>> +		(*sps)->enc[1].pte_enc = def->penc[MMU_PAGE_16M];
>>> +	}
>> So this basically indicates that every segment (except for the 16MB one)
>> can also handle 16MB MPSS page sizes? I suppose you want to remove the
>> comment in kvm_vm_ioctl_get_smmu_info_hv() that says we don't do MPSS here.
> I haven't reviewed the code there, make sure it will indeed do a
> different encoding for every combination of segment/actual page size.
>
>> Can we also ensure that every system we run on can do MPSS?
> P7 and P8 are identical in that regard. However 970 doesn't do MPSS so
> let's make sure we get that right.

yes. When / if people can easily get their hands on p7/p8 bare metal 
systems I'll be more than happy to remove 970 support as well, but for 
now it's probably good to keep in.


Alex
