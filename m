Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87453DE111
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 07:08:37 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m84L8XQ3032624
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 17:08:33 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m84L8Hhr203030
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 15:08:17 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m84L8Cpe011791
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 15:08:13 -0600
Message-ID: <48C04E4E.6090408@linux.vnet.ibm.com>
Date: Thu, 04 Sep 2008 16:08:30 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: libhugetlbfs-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Libhugetlbfs-devel] Buglet in 16G page handling
References: <20080902050510.GB12965@yookeroo.seuss>
	<48BD73FB.1050601@linux.vnet.ibm.com>
	<20080903002029.GC9681@yookeroo.seuss>
	<48BF0D6F.2010602@linux.vnet.ibm.com>
In-Reply-To: <48BF0D6F.2010602@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Tollefson wrote:
> David Gibson wrote:
>   
>> On Tue, Sep 02, 2008 at 12:12:27PM -0500, Jon Tollefson wrote:
>>   
>>     
>>> David Gibson wrote:
>>>     
>>>       
>>>> When BenH and I were looking at the new code for handling 16G pages,
>>>> we noticed a small bug.  It doesn't actually break anything user
>>>> visible, but it's certainly not the way things are supposed to be.
>>>> The 16G patches didn't update the huge_pte_offset() and
>>>> huge_pte_alloc() functions, which means that the hugepte tables for
>>>> 16G pages will be allocated much further down the page table tree than
>>>> they should be - allocating several levels of page table with a single
>>>> entry in them along the way.
>>>>
>>>> The patch below is supposed to fix this, cleaning up the existing
>>>> handling of 64k vs 16M pages while its at it.  However, it needs some
>>>> testing.
>>>>
>>>> I've checked that it doesn't break existing 16M support, either with
>>>> 4k or 64k base pages.  I haven't figured out how to test with 64k
>>>> pages yet, at least until the multisize support goes into
>>>> libhugetlbfs.  For 16G pages, I just don't have access to a machine
>>>> with enough memory to test.  Jon, presumably you must have found such
>>>> a machine when you did the 16G page support in the first place.  Do
>>>> you still have access, and can you test this patch?
>>>>   
>>>>       
>>>>         
>>> I do have access to a machine to test it.  I applied the patch to -rc4
>>> and used a pseries_defconfig.  I boot with
>>> default_hugepagesz=16G... in order to test huge page sizes other then
>>> 16M at this point.
>>>
>>> Running the libhugetlbfs test suite it gets as far as   Readback (64):  
>>> PASS
>>> before it hits the following program check.
>>>     
>>>       
>> Ah, yes, oops, forgot to fix up the pagetable freeing path in line
>> with the other changes.  Try the revised version below.
>>   
>>     
> I have run through the tests twice now with this new patch using a 4k
> base page size(and 16G huge page size) and there are no program checks
> or spin lock issues.  So looking good.
>
> I will run it next a couple of times with 64K base pages.
>   
I have run through the libhugetest suite 3 times each now with both
combinations(4k and 64K base page) and have not seen the spin lock
problem or any other problems.

Acked-by: Jon Tollefson <kniht@linux.vnet.ibm.com>


> Jon
>
>
>
>
>   
>> Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
>> ===================================================================
>> --- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2008-09-02 11:50:12.000000000 +1000
>> +++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2008-09-03 10:10:54.000000000 +1000
>> @@ -128,29 +128,37 @@ static int __hugepte_alloc(struct mm_str
>>  	return 0;
>>  }
>>
>> -/* Base page size affects how we walk hugetlb page tables */
>> -#ifdef CONFIG_PPC_64K_PAGES
>> -#define hpmd_offset(pud, addr, h)	pmd_offset(pud, addr)
>> -#define hpmd_alloc(mm, pud, addr, h)	pmd_alloc(mm, pud, addr)
>> -#else
>> -static inline
>> -pmd_t *hpmd_offset(pud_t *pud, unsigned long addr, struct hstate *hstate)
>> +
>> +static pud_t *hpud_offset(pgd_t *pgd, unsigned long addr, struct hstate *hstate)
>> +{
>> +	if (huge_page_shift(hstate) < PUD_SHIFT)
>> +		return pud_offset(pgd, addr);
>> +	else
>> +		return (pud_t *) pgd;
>> +}
>> +static pud_t *hpud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long addr,
>> +			 struct hstate *hstate)
>>  {
>> -	if (huge_page_shift(hstate) == PAGE_SHIFT_64K)
>> +	if (huge_page_shift(hstate) < PUD_SHIFT)
>> +		return pud_alloc(mm, pgd, addr);
>> +	else
>> +		return (pud_t *) pgd;
>> +}
>> +static pmd_t *hpmd_offset(pud_t *pud, unsigned long addr, struct hstate *hstate)
>> +{
>> +	if (huge_page_shift(hstate) < PMD_SHIFT)
>>  		return pmd_offset(pud, addr);
>>  	else
>>  		return (pmd_t *) pud;
>>  }
>> -static inline
>> -pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
>> -		  struct hstate *hstate)
>> +static pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
>> +			 struct hstate *hstate)
>>  {
>> -	if (huge_page_shift(hstate) == PAGE_SHIFT_64K)
>> +	if (huge_page_shift(hstate) < PMD_SHIFT)
>>  		return pmd_alloc(mm, pud, addr);
>>  	else
>>  		return (pmd_t *) pud;
>>  }
>> -#endif
>>
>>  /* Build list of addresses of gigantic pages.  This function is used in early
>>   * boot before the buddy or bootmem allocator is setup.
>> @@ -204,7 +212,7 @@ pte_t *huge_pte_offset(struct mm_struct 
>>
>>  	pg = pgd_offset(mm, addr);
>>  	if (!pgd_none(*pg)) {
>> -		pu = pud_offset(pg, addr);
>> +		pu = hpud_offset(pg, addr, hstate);
>>  		if (!pud_none(*pu)) {
>>  			pm = hpmd_offset(pu, addr, hstate);
>>  			if (!pmd_none(*pm))
>> @@ -233,7 +241,7 @@ pte_t *huge_pte_alloc(struct mm_struct *
>>  	addr &= hstate->mask;
>>
>>  	pg = pgd_offset(mm, addr);
>> -	pu = pud_alloc(mm, pg, addr);
>> +	pu = hpud_alloc(mm, pg, addr, hstate);
>>
>>  	if (pu) {
>>  		pm = hpmd_alloc(mm, pu, addr, hstate);
>> @@ -316,13 +324,7 @@ static void hugetlb_free_pud_range(struc
>>  	pud = pud_offset(pgd, addr);
>>  	do {
>>  		next = pud_addr_end(addr, end);
>> -#ifdef CONFIG_PPC_64K_PAGES
>> -		if (pud_none_or_clear_bad(pud))
>> -			continue;
>> -		hugetlb_free_pmd_range(tlb, pud, addr, next, floor, ceiling,
>> -				       psize);
>> -#else
>> -		if (shift == PAGE_SHIFT_64K) {
>> +		if (shift < PMD_SHIFT) {
>>  			if (pud_none_or_clear_bad(pud))
>>  				continue;
>>  			hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
>> @@ -332,7 +334,6 @@ static void hugetlb_free_pud_range(struc
>>  				continue;
>>  			free_hugepte_range(tlb, (hugepd_t *)pud, psize);
>>  		}
>> -#endif
>>  	} while (pud++, addr = next, addr != end);
>>
>>  	start &= PGDIR_MASK;
>> @@ -422,9 +423,15 @@ void hugetlb_free_pgd_range(struct mmu_g
>>  		psize = get_slice_psize(tlb->mm, addr);
>>  		BUG_ON(!mmu_huge_psizes[psize]);
>>  		next = pgd_addr_end(addr, end);
>> -		if (pgd_none_or_clear_bad(pgd))
>> -			continue;
>> -		hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
>> +		if (mmu_psize_to_shift(psize) < PUD_SHIFT) {
>> +			if (pgd_none_or_clear_bad(pgd))
>> +				continue;
>> +			hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
>> +		} else {
>> +			if (pgd_none(*pgd))
>> +				continue;
>> +			free_hugepte_range(tlb, (hugepd_t *)pgd, psize);
>> +		}
>>  	} while (pgd++, addr = next, addr != end);
>>  }
>>     
