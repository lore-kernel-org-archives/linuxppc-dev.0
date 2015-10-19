Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDFE51A0A23
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 20:41:08 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 19 Oct 2015 15:11:04 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AF36AE0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 15:11:03 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9J8uqTJ2949490
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 15:11:01 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9J8VAJV005446
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 14:01:11 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 00/31] powerpc/mm: Update page table format for book3s
 64
In-Reply-To: <1445088167.24309.58.camel@kernel.crashing.org>
References: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1445088167.24309.58.camel@kernel.crashing.org>
Date: Mon, 19 Oct 2015 14:01:09 +0530
Message-ID: <87io6345v6.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sat, 2015-10-17 at 15:38 +0530, Aneesh Kumar K.V wrote:
>> Hi All,
>> 
>> This patch series attempt to update book3s 64 linux page table format to
>> make it more flexible. Our current pte format is very restrictive and we
>> overload multiple pte bits. This is due to the non-availability of free bits
>> in pte_t. We use pte_t to track the validity of 4K subpages. This patch
>> series free up pte_t of 11 bits by moving 4K subpage tracking to the
>> lower half of PTE page. The pte format is updated such that we have a
>> better method for identifying a pte entry at pmd level. This will also enable
>> us to implement hugetlb migration(not yet done in this series). 
>
> I still have serious concerns about the fact that we now use 4 times
> more memory for page tables than strictly necessary. We were using
> twice as much before.
>
> We need to find a way to not allocate all those "other halves" when not
> needed.
>
> I understand it's tricky, we tend to notice we need the second half too
> late...
>
> Maybe if we could escalate the hash miss into a minor fault when the
> second half is needed and not present, we can then allocate it from the
>
> For demotion of the vmap space, we might have to be a bit smarter,
> maybe detect at ioremap/vmap time and flag the mm as needed second
> halves for everything (and allocate them).
>
> Of course if the machine doesn't do hw 64k, we would always allocate
> the second half.
>

I am now trying to do the conditional alloc and one of the unpleasant
side effect of that is spreading of subpage 4k information all around
the code. We have the below cases

1) subpage protection:
This will result in demotion of segment when we call sys_subpage_prot.
New allocation of pgtable_t will result in subpage tracking page
allocation by checking in pte_alloc_one as below

pte_t *page_table_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
{
	pte_t *pte;

	pte = get_from_cache(mm);
	if (pte)
		goto out;

	pte = __alloc_for_cache(mm, kernel);
out:
	if (REGIOND_ID(vmaddr) == USER_REGION_ID) {
		int slice_psize;

		slice_psize = get_slice_psize(mm, vmaddr);
		/*
		 * 64K linux page size with 4K segment base page size. Allocate
		 * the 4k subpage track page
		 */
		if (slice_psize == MMU_PAGE_4K)
			alloc_and_update_4k(pte);
	}
	return pte;
}

Existing allocation when trying to insert a 4K hpte will push the fault
to handle_mm_fault and I am looking at adding the below in update_mmu_cache

	/*
	 * The fault was sent to us because, we didn't had the subpage
	 * tracking page
	 */
	if (pte_val(*ptep) & _PAGE_COMBO)
		alloc_and_update_4k(ptep);

We would have marked the pte _PAGE_COMBO in __hash_page_4k

2) ioremap with cache inhibited restrictions:
We can handle that in map_kernel_page
		/*
		 * if pte is non-cacheable and we have restrictions on
		 * using non cacheable large pages, we will have to use
		 * 4K subpages. Allocate the 4K region, but skip the
		 * segment demote
		 */
		if (mmu_ci_restrictions && (flags & _PAGE_NO_CACHE)) {
			alloc_and_update_4k(ptep);
		}

3) remap_4k_pfn:
Can we mark the segment demoted here ?. if so the pte alloc will handle
that if the remap address is in user region.

4) vmalloc space demotion because somebody did a remap_4k_pfn to an address
in that range:
Not yet sure about this 

5) Anything else I missed ?
you mention about vmap space. I was not able to find out when we would
demote an address in 0xf region ?

I will try to see if there is a better way to isolate the subpage
handling, but it looks like, we are making the code more complex by
doing the above ?

Also how do I evaluate the impact of doubling the pgtable_t size ?
Looking at the above i am wondering if this is really a issue we need
worry about ? We are better than other arch with 4K page size in-terms
of pte pages. We allocate one pte page per 128MB of address range and
for 4K page size architectures that is one per every 2MB ?

-aneesh
