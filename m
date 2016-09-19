Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdDz65QX7zDsd9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 04:33:06 +1000 (AEST)
Subject: Re: [PATCH v2 2/3] powerpc: get hugetlbpage handling more generic
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
References: <cover.1474009019.git.christophe.leroy@c-s.fr>
 <dab1fde59f711dd7d3f1996dee72f61c46033f47.1474009019.git.christophe.leroy@c-s.fr>
 <87poo0xx13.fsf@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <2c8682d7-78ce-0aaf-79bd-85a85849e227@c-s.fr>
Date: Mon, 19 Sep 2016 20:32:59 +0200
MIME-Version: 1.0
In-Reply-To: <87poo0xx13.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/09/2016 à 07:45, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> Today there are two implementations of hugetlbpages which are managed
>> by exclusive #ifdefs:
>> * FSL_BOOKE: several directory entries points to the same single hugepage
>> * BOOK3S: one upper level directory entry points to a table of hugepages
>>
>> In preparation of implementation of hugepage support on the 8xx, we
>> need a mix of the two above solutions, because the 8xx needs both cases
>> depending on the size of pages:
>> * In 4k page size mode, each PGD entry covers a 4M bytes area. It means
>> that 2 PGD entries will be necessary to cover an 8M hugepage while a
>> single PGD entry will cover 8x 512k hugepages.
>> * In 16 page size mode, each PGD entry covers a 64M bytes area. It means
>> that 8x 8M hugepages will be covered by one PGD entry and 64x 512k
>> hugepages will be covers by one PGD entry.
>>
>> This patch:
>> * removes #ifdefs in favor of if/else based on the range sizes
>> * merges the two huge_pte_alloc() functions as they are pretty similar
>> * merges the two hugetlbpage_init() functions as they are pretty similar
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> v2: This part is new and results from a split of last patch of v1 serie in
>> two parts
>>
>>  arch/powerpc/mm/hugetlbpage.c | 189 +++++++++++++++++-------------------------
>>  1 file changed, 77 insertions(+), 112 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index 8a512b1..2119f00 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c

[...]

>
>> -#ifdef CONFIG_PPC_FSL_BOOK3E
>>  struct kmem_cache *hugepte_cache;
>>  static int __init hugetlbpage_init(void)
>>  {
>>  	int psize;
>>
>> -	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
>> -		unsigned shift;
>> -
>> -		if (!mmu_psize_defs[psize].shift)
>> -			continue;
>> -
>> -		shift = mmu_psize_to_shift(psize);
>> -
>> -		/* Don't treat normal page sizes as huge... */
>> -		if (shift != PAGE_SHIFT)
>> -			if (add_huge_page_size(1ULL << shift) < 0)
>> -				continue;
>> -	}
>> -
>> -	/*
>> -	 * Create a kmem cache for hugeptes.  The bottom bits in the pte have
>> -	 * size information encoded in them, so align them to allow this
>> -	 */
>> -	hugepte_cache =  kmem_cache_create("hugepte-cache", sizeof(pte_t),
>> -					   HUGEPD_SHIFT_MASK + 1, 0, NULL);
>> -	if (hugepte_cache == NULL)
>> -		panic("%s: Unable to create kmem cache for hugeptes\n",
>> -		      __func__);
>> -
>> -	/* Default hpage size = 4M */
>> -	if (mmu_psize_defs[MMU_PAGE_4M].shift)
>> -		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_4M].shift;
>> -	else
>> -		panic("%s: Unable to set default huge page size\n", __func__);
>> -
>> -
>> -	return 0;
>> -}
>> -#else
>> -static int __init hugetlbpage_init(void)
>> -{
>> -	int psize;
>> -
>> +#if !defined(CONFIG_PPC_FSL_BOOK3E)
>>  	if (!radix_enabled() && !mmu_has_feature(MMU_FTR_16M_PAGE))
>>  		return -ENODEV;
>> -
>> +#endif
>
> Do we need that #if ? radix_enabled() should become 0 and that if
> condition should be removed at compile time isn't it ? or are you
> finding errors with that ?

Having radix_enabled() being 0, it becomes:

if (!mmu_has_feature(MMU_FTR_16M_PAGE))
	return -ENODEV;

Which means hugepage will only be handled by CPUs having 16M pages. 
That's the issue.

>
>
>>  	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
>>  		unsigned shift;
>>  		unsigned pdshift;
>> @@ -860,16 +807,31 @@ static int __init hugetlbpage_init(void)
>>  		 * if we have pdshift and shift value same, we don't
>>  		 * use pgt cache for hugepd.
>>  		 */
>> -		if (pdshift != shift) {
>> +		if (pdshift > shift) {
>>  			pgtable_cache_add(pdshift - shift, NULL);
>>  			if (!PGT_CACHE(pdshift - shift))
>>  				panic("hugetlbpage_init(): could not create "
>>  				      "pgtable cache for %d bit pagesize\n", shift);
>> +		} else if (!hugepte_cache) {
>> +			/*
>> +			 * Create a kmem cache for hugeptes.  The bottom bits in
>> +			 * the pte have size information encoded in them, so
>> +			 * align them to allow this
>> +			 */
>> +			hugepte_cache = kmem_cache_create("hugepte-cache",
>> +							  sizeof(pte_t),
>> +							  HUGEPD_SHIFT_MASK + 1,
>> +							  0, NULL);
>> +			if (hugepte_cache == NULL)
>> +				panic("%s: Unable to create kmem cache "
>> +				      "for hugeptes\n", __func__);
>> +
>
>
> We don't need hugepte_cache for book3s 64K. I guess we will endup
> creating one here ?

Should not, because on book3s 64k, we will have pdshift > shift
won't we ?

>
>>  		}
>>  	}
>>
>>  	/* Set default large page size. Currently, we pick 16M or 1M
>>  	 * depending on what is available
>> +	 * We select 4M on other ones.
>>  	 */
>>  	if (mmu_psize_defs[MMU_PAGE_16M].shift)
>>  		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_16M].shift;
>> @@ -877,11 +839,14 @@ static int __init hugetlbpage_init(void)
>>  		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_1M].shift;
>>  	else if (mmu_psize_defs[MMU_PAGE_2M].shift)
>>  		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_2M].shift;
>> -
>> +	else if (mmu_psize_defs[MMU_PAGE_4M].shift)
>> +		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_4M].shift;
>> +	else
>> +		panic("%s: Unable to set default huge page size\n", __func__);
>>
>>  	return 0;
>>  }
>> -#endif
>> +
>>  arch_initcall(hugetlbpage_init);
>>
>>  void flush_dcache_icache_hugepage(struct page *page)
>> --
>> 2.1.0

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
