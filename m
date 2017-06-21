Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wstjM0PZVzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 15:35:50 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L5T9ST118337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 01:35:48 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b7j5ns6rv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 01:35:47 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 15:35:44 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5L5ZgFI2162986
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 15:35:42 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5L5Zg90019946
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 15:35:42 +1000
Subject: Re: [RFC v2 01/12] powerpc: Free up four 64K PTE bits in 4K backed
 hpte pages.
To: Ram Pai <linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-2-git-send-email-linuxram@us.ibm.com>
 <e5cf3deb-36ef-2e0f-4c5a-98534c34d54e@linux.vnet.ibm.com>
 <20170620232358.GF17588@ram.oc3035372033.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 21 Jun 2017 11:05:33 +0530
MIME-Version: 1.0
In-Reply-To: <20170620232358.GF17588@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <a9d0c7c7-fa42-c65e-2cf4-bd118c407b05@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/2017 04:53 AM, Ram Pai wrote:
> On Tue, Jun 20, 2017 at 03:50:25PM +0530, Anshuman Khandual wrote:
>> On 06/17/2017 09:22 AM, Ram Pai wrote:
>>> Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6
>>> in the 4K backed hpte pages. These bits continue to be used
>>> for 64K backed hpte pages in this patch, but will be freed
>>> up in the next patch.
>>
>> The counting 3, 4, 5 and 6 are in BE format I believe, I was
>> initially trying to see that from right to left as we normally
>> do in the kernel and was getting confused. So basically these
>> bits (which are only applicable for 64K mapping IIUC) are going
>> to be freed up from the PTE format.
>>
>> #define _RPAGE_RSV1		0x1000000000000000UL
>> #define _RPAGE_RSV2		0x0800000000000000UL
>> #define _RPAGE_RSV3		0x0400000000000000UL
>> #define _RPAGE_RSV4		0x0200000000000000UL
>>
>> As you have mentioned before this feature is available for 64K
>> page size only and not for 4K mappings. So I assume we support
>> both the combinations.
>>
>> * 64K mapping on 64K
>> * 64K mapping on 4K
> 
> yes.
> 
>>
>> These are the current users of the above bits
>>
>> #define H_PAGE_BUSY		_RPAGE_RSV1 /* software: PTE & hash are busy */
>> #define H_PAGE_F_SECOND		_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
>> #define H_PAGE_F_GIX		(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
>> #define H_PAGE_HASHPTE		_RPAGE_RPN43	/* PTE has associated HPTE */
>>
>>>
>>> The patch does the following change to the 64K PTE format
>>>
>>> H_PAGE_BUSY moves from bit 3 to bit 9
>>
>> and what is in there on bit 9 now ? This ?
>>
>> #define _RPAGE_SW2		0x00400
>>
>> which is used as 
>>
>> #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
>>
>> which will not be required any more ?
> 
> i think you are reading bit 9 from right to left. the bit 9 i refer to
> is from left to right. Using the same numbering convention the ISA3.0 uses.

Right, my bad. Then it would be this one.

'#define _RPAGE_RPN42		0x0040000000000000UL'

> I know it is confusing, will make a mention in the comment of this
> patch, to read it the big-endian way.

Right.

> 
> BTW: Bit 9 is not used currently. so using it in this patch. But this is
> a temporary move. the H_PAGE_BUSY will move to bit 7 in the next patch.
> 
> Had to keep at bit 9, because bit 7 is not yet entirely freed up. it is
> used by 64K PTE backed by 64k htpe.

Got it.

> 
>>
>>> H_PAGE_F_SECOND which occupied bit 4 moves to the second part
>>> 	of the pte.
>>> H_PAGE_F_GIX which  occupied bit 5, 6 and 7 also moves to the
>>> 	second part of the pte.
>>>
>>> the four  bits((H_PAGE_F_SECOND|H_PAGE_F_GIX) that represent a slot
>>> is  initialized  to  0xF  indicating  an invalid  slot.  If  a hpte
>>> gets cached in a 0xF  slot(i.e  7th  slot  of  secondary),  it   is
>>> released immediately. In  other  words, even  though   0xF   is   a
>>
>> Release immediately means we attempt again for a new hash slot ?
> 
> yes.
> 
>>
>>> valid slot we discard  and consider it as an invalid
>>> slot;i.e hpte_soft_invalid(). This  gives  us  an opportunity to not
>>> depend on a bit in the primary PTE in order to determine the
>>> validity of a slot.
>>
>> So we have to see the slot number in the second half for each PTE to
>> figure out if it has got a valid slot in the hash page table.
> 
> yes.
> 
>>
>>>
>>> When  we  release  a    hpte   in the 0xF   slot we also   release a
>>> legitimate primary   slot  and    unmap    that  entry. This  is  to
>>> ensure  that we do get a   legimate   non-0xF  slot the next time we
>>> retry for a slot.
>>
>> Okay.
>>
>>>
>>> Though treating 0xF slot as invalid reduces the number of available
>>> slots  and  may  have an effect  on the performance, the probabilty
>>> of hitting a 0xF is extermely low.
>>
>> Why you say that ? I thought every slot number has the same probability
>> of hit from the hash function.
> 
> Every hash bucket has the same probability. But every slot within the
> hash bucket is filled in sequentially. so it takes 15 hptes to hash to
> the same bucket before we get to the 15th slot in the secondary.

Okay, would the last one be 16th instead ?

> 
>>
>>>
>>> Compared  to the current scheme, the above described scheme reduces
>>> the number of false hash table updates  significantly  and  has the
>>
>> How it reduces false hash table updates ?
> 
> earlier, we had 1 bit allocated in the first-part-of-the 64K-PTE 
> for four consecutive 4K hptes. If any one 4k hpte got hashed-in,
> the bit got set. Which means anytime it faulted on the remaining
> three 4k hpte, we saw the bit already set and tried to erroneously 
> update that hpte. So we had a 75% update error rate. Funcationally
> not bad, but bad from a performance point of view.

I am bit out of sync regarding these PTE bits, after Aneesh's radix
changes went in :) Will look into this bit closer.

> 
> With the current scheme, we decide if a 4k slot is valid by looking
> at its value rather than depending on a bit in the main-pte. So
> there is no chance of getting mislead. And hence no chance of trying
> to update a invalid hpte. Should improve performance and at the same
> time give us four valuable PTE bits.

I am not sure why you say 'invalid hpte'. IIUC

* We will require 16 '64K on 4K' mappings to actually cover 64K on 64K

* A single (64K on 4K)'s TLB can cover 64K on 64K as long as the TLB is
  present and not flushed. That gets us performance. Once flushed, a new
  HPTE entry covering new (64K on 4K) is inserted. As long as the PFN
  for the 4K is different HPTE will be different and it cannot collide
  with any existing ones and create problems (ERAT error ?)

As you are pointing out, I am not sure whether the existing design had
more probability for an invalid HPTE insert. Will look into this in
detail.

> 
> 
>>
>>> added  advantage  of  releasing  four  valuable  PTE bits for other
>>> purpose.
>>>
>>> This idea was jointly developed by Paul Mackerras, Aneesh, Michael
>>> Ellermen and myself.
>>>
>>> 4K PTE format remain unchanged currently.
>>>
>>> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>>> ---
>>>  arch/powerpc/include/asm/book3s/64/hash-4k.h  | 20 +++++++
>>>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 32 +++++++----
>>>  arch/powerpc/include/asm/book3s/64/hash.h     | 15 +++--
>>>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  5 ++
>>>  arch/powerpc/mm/dump_linuxpagetables.c        |  3 +-
>>>  arch/powerpc/mm/hash64_4k.c                   | 14 ++---
>>>  arch/powerpc/mm/hash64_64k.c                  | 81 ++++++++++++---------------
>>>  arch/powerpc/mm/hash_utils_64.c               | 30 +++++++---
>>>  8 files changed, 122 insertions(+), 78 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>>> index b4b5e6b..5ef1d81 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>>> @@ -16,6 +16,18 @@
>>>  #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
>>>  #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
>>>
>>> +
>>> +/*
>>> + * Only supported by 4k linux page size
>>> + */
>>> +#define H_PAGE_F_SECOND        _RPAGE_RSV2     /* HPTE is in 2ndary HPTEG */
>>> +#define H_PAGE_F_GIX           (_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
>>> +#define H_PAGE_F_GIX_SHIFT     56
>>> +
>>> +#define H_PAGE_BUSY	_RPAGE_RSV1     /* software: PTE & hash are busy */
>>> +#define H_PAGE_HASHPTE	_RPAGE_RPN43    /* PTE has associated HPTE */
>>> +
>>> +
>>
>> So we moved the common 64K definitions here.
> 
> yes.
>>
>>
>>>  /* PTE flags to conserve for HPTE identification */
>>>  #define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | \
>>>  			 H_PAGE_F_SECOND | H_PAGE_F_GIX)
>>> @@ -48,6 +60,14 @@ static inline int hash__hugepd_ok(hugepd_t hpd)
>>>  }
>>>  #endif
>>>
>>> +static inline unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
>>> +			unsigned int subpg_index, unsigned long slot)
>>> +{
>>> +	return (slot << H_PAGE_F_GIX_SHIFT) &
>>> +		(H_PAGE_F_SECOND | H_PAGE_F_GIX);
>>> +}
>>
>> Why we are passing the first 3 arguments of the function if we never
>> use it inside. Is the caller expected to take care of it ?
> 
> trying to keep the same prototype for the 4K-pte and 64K-pte cases.
> Otherwise the caller has to wonder which parameter scheme to use.
> 
>>
>>> +
>>> +
>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>
>>>  static inline char *get_hpte_slot_array(pmd_t *pmdp)
>>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>> index 9732837..0eb3c89 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>> @@ -10,23 +10,25 @@
>>>   * 64k aligned address free up few of the lower bits of RPN for us
>>>   * We steal that here. For more deatils look at pte_pfn/pfn_pte()
>>>   */
>>> -#define H_PAGE_COMBO	_RPAGE_RPN0 /* this is a combo 4k page */
>>> -#define H_PAGE_4K_PFN	_RPAGE_RPN1 /* PFN is for a single 4k page */
>>> +#define H_PAGE_COMBO   _RPAGE_RPN0 /* this is a combo 4k page */
>>> +#define H_PAGE_4K_PFN  _RPAGE_RPN1 /* PFN is for a single 4k page */
>>
>> Its the same thing, changes nothing.
> 
> it fixes some space/tab problem.
> 
>>
>>> +#define H_PAGE_F_SECOND	_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
>>> +#define H_PAGE_F_GIX	(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
>>> +#define H_PAGE_F_GIX_SHIFT	56
>>> +
>>> +
>>> +#define H_PAGE_BUSY	_RPAGE_RPN42     /* software: PTE & hash are busy */
>>> +#define H_PAGE_HASHPTE	_RPAGE_RPN43    /* PTE has associated HPTE */
>>
>> H_PAGE_BUSY seems to be differently defined here.
> 
> Yes. it is using two different bits depending on 4K hpte v/s 64k hpte
> case. But in the next patch all will be same and consistent.
> 
>>
>>> +
>>>  /*
>>>   * We need to differentiate between explicit huge page and THP huge
>>>   * page, since THP huge page also need to track real subpage details
>>>   */
>>>  #define H_PAGE_THP_HUGE  H_PAGE_4K_PFN
>>>
>>> -/*
>>> - * Used to track subpage group valid if H_PAGE_COMBO is set
>>> - * This overloads H_PAGE_F_GIX and H_PAGE_F_SECOND
>>> - */
>>> -#define H_PAGE_COMBO_VALID	(H_PAGE_F_GIX | H_PAGE_F_SECOND)
>>
>> H_PAGE_COMBO_VALID is not defined alternately ?
> 
> it is not needed anymore.
> 
>>
>>> -
>>>  /* PTE flags to conserve for HPTE identification */
>>> -#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_F_SECOND | \
>>> -			 H_PAGE_F_GIX | H_PAGE_HASHPTE | H_PAGE_COMBO)
>>> +#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | H_PAGE_COMBO)
>>> +
>>
>> Slot information has moved to the second half, hence _PAGE_HPTEFLAGS
>> need not carry that.
> 
> yes.
> 
>>
>>>  /*
>>>   * we support 16 fragments per PTE page of 64K size.
>>>   */
>>> @@ -74,6 +76,16 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
>>>  	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
>>>  }
>>>
>>> +static inline unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
>>> +		unsigned int subpg_index, unsigned long slot)
>>> +{
>>> +	unsigned long *hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
>>> +
>>> +	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
>>> +	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
>>> +	return 0x0UL;
>>> +}
>>
>> New method to insert the slot information in the second half.
> 
> yes. well it basically trying to reduce code redundancy. Too many places
> using exactly the same code to accomplish the same thing. Makes sense to
> bring it all in one place.

Right.

> 
>>
>>> +
>>>  #define __rpte_to_pte(r)	((r).pte)
>>>  extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
>>>  /*
>>> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
>>> index 4e957b0..e7cf03a 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/hash.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
>>> @@ -8,11 +8,8 @@
>>>   *
>>>   */
>>>  #define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
>>> -#define H_PAGE_F_GIX_SHIFT	56
>>> -#define H_PAGE_BUSY		_RPAGE_RSV1 /* software: PTE & hash are busy */
>>> -#define H_PAGE_F_SECOND		_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
>>> -#define H_PAGE_F_GIX		(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
>>> -#define H_PAGE_HASHPTE		_RPAGE_RPN43	/* PTE has associated HPTE */
>>
>> Removing the common definitions.
>>
>>> +
>>> +#define INIT_HIDX (~0x0UL)
>>>
>>>  #ifdef CONFIG_PPC_64K_PAGES
>>>  #include <asm/book3s/64/hash-64k.h>
>>> @@ -160,6 +157,14 @@ static inline int hash__pte_none(pte_t pte)
>>>  	return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0;
>>>  }
>>>
>>> +static inline bool hpte_soft_invalid(unsigned long slot)
>>> +{
>>> +	return ((slot & 0xfUL) == 0xfUL);
>>> +}
>>> +
>>> +unsigned long get_hidx_gslot(unsigned long vpn, unsigned long shift,
>>> +		int ssize, real_pte_t rpte, unsigned int subpg_index);
>>> +
>>>  /* This low level function performs the actual PTE insertion
>>>   * Setting the PTE depends on the MMU type and other factors. It's
>>>   * an horrible mess that I'm not going to try to clean up now but
>>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> index 6981a52..cfb8169 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> @@ -435,6 +435,11 @@ extern int __hash_page_4K(unsigned long ea, unsigned long access,
>>>  extern int __hash_page_64K(unsigned long ea, unsigned long access,
>>>  			   unsigned long vsid, pte_t *ptep, unsigned long trap,
>>>  			   unsigned long flags, int ssize);
>>> +extern unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
>>> +			unsigned int subpg_index, unsigned long slot);
>>> +extern unsigned long get_hidx_slot(unsigned long vpn, unsigned long shift,
>>> +			int ssize, real_pte_t rpte, unsigned int subpg_index);
>>
>> I wonder what purpose set_hidx_slot() defined previously, served.
>>
>>> +
>>>  struct mm_struct;
>>>  unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap);
>>>  extern int hash_page_mm(struct mm_struct *mm, unsigned long ea,
>>> diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
>>> index 44fe483..b832ed3 100644
>>> --- a/arch/powerpc/mm/dump_linuxpagetables.c
>>> +++ b/arch/powerpc/mm/dump_linuxpagetables.c
>>> @@ -213,7 +213,7 @@ struct flag_info {
>>>  		.val	= H_PAGE_4K_PFN,
>>>  		.set	= "4K_pfn",
>>>  	}, {
>>> -#endif
>>> +#else
>>>  		.mask	= H_PAGE_F_GIX,
>>>  		.val	= H_PAGE_F_GIX,
>>>  		.set	= "f_gix",
>>> @@ -224,6 +224,7 @@ struct flag_info {
>>>  		.val	= H_PAGE_F_SECOND,
>>>  		.set	= "f_second",
>>>  	}, {
>>> +#endif /* CONFIG_PPC_64K_PAGES */
>>
>> Are we adding H_PAGE_F_GIX as an element for 4K mapping ?
> 
> I think there is mistake here. 
> In the next patch when these bits are divorsed from
> 64K ptes entirely, we will not need the above code for 64K ptes.
> But good catch. Will fix the error in this patch.
> 
>>
>>>  #endif
>>>  		.mask	= _PAGE_SPECIAL,
>>>  		.val	= _PAGE_SPECIAL,
>>> diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
>>> index 6fa450c..c673829 100644
>>> --- a/arch/powerpc/mm/hash64_4k.c
>>> +++ b/arch/powerpc/mm/hash64_4k.c
>>> @@ -20,6 +20,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>>>  		   pte_t *ptep, unsigned long trap, unsigned long flags,
>>>  		   int ssize, int subpg_prot)
>>>  {
>>> +	real_pte_t rpte;
>>>  	unsigned long hpte_group;
>>>  	unsigned long rflags, pa;
>>>  	unsigned long old_pte, new_pte;
>>> @@ -54,6 +55,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>>>  	 * need to add in 0x1 if it's a read-only user page
>>>  	 */
>>>  	rflags = htab_convert_pte_flags(new_pte);
>>> +	rpte = __real_pte(__pte(old_pte), ptep);
>>>
>>>  	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
>>>  	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
>>> @@ -64,13 +66,10 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>>>  		/*
>>>  		 * There MIGHT be an HPTE for this pte
>>>  		 */
>>> -		hash = hpt_hash(vpn, shift, ssize);
>>> -		if (old_pte & H_PAGE_F_SECOND)
>>> -			hash = ~hash;
>>> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
>>> -		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
>>> +		unsigned long gslot = get_hidx_gslot(vpn, shift,
>>> +						ssize, rpte, 0);
>>
>> I am wondering why there is a 'g' before the slot in all these
>> functions.
> 
> Right. even i was confused initially. :)
> 
> hash table slots are originized as one big table. 8 consecutive entires
> in that table form a bucket.  the term slot is used to refer to the
> slot within the bucket.  the term gslot is used to refer to an entry
> in the table.  roughly speaking slot 2 in bucket 2, will be gslot 2*8+2=18.

Global slot as it can point any where on that two dimensional table ?

> 
>>
>> Its already too much of changes in a single patch. Being a single
>> logical change it needs to be inside a single change but then we
>> need much more description in the commit message for some one to
>> understand what all changed and how.
> 
> I have further broken down this patch, one to introduce get_hidx_gslot()
> one to introduce set_hidx_slot() . Hopefully that will reduce the size
> of the patch to graspable level. let me know,

I did some experiments with the first two patches.

* First of all the first patch does not compile without this.

--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1612,7 +1612,7 @@ unsigned long get_hidx_gslot(unsigned long vpn, unsigned long shift,
 void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
                     unsigned long flags)
 {
-       unsigned long hash, index, shift, hidx, gslot;
+       unsigned long index, shift, gslot;
        int local = flags & HPTE_LOCAL_UPDATE;
 
        DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);

* Though it boots the kernel, system is kind of unresponsive while attempting
  to compile a kernel. Though I did not dig further on this, seems like the
  first patch is not self sufficient yet.

* With both first and second patch, the kernel boots fine and compiles a kernel.

We need to sort out issues in the first two patches before looking into
the rest of the patch series.
