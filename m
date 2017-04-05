Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyVv72mJ4zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 13:00:02 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id n11so128726pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 20:00:02 -0700 (PDT)
Subject: Re: [PATCH kernel] powerpc/iommu: Do not call PageTransHuge() on tail
 pages
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20170328052559.12912-1-aik@ozlabs.ru>
 <871st834na.fsf@skywalker.in.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Greg Kurz <groug@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0657df73-b221-2a49-358b-9f0c339cb0be@ozlabs.ru>
Date: Wed, 5 Apr 2017 12:59:55 +1000
MIME-Version: 1.0
In-Reply-To: <871st834na.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/04/17 19:26, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> The CMA pages migration code does not support compound pages at
>> the moment so it performs few tests before proceeding to actual page
>> migration.
>>
>> One of the tests - PageTransHuge() - has VM_BUG_ON_PAGE(PageTail()) as
>> it should be called on head pages. Since we also test for PageCompound(),
>> and it contains PageTail(), we can simply move PageCompound() in front
>> of PageTransHuge() and therefore avoid possible VM_BUG_ON_PAGE.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> Some of actual POWER8 systems do crash on that BUG_ON.
>> ---
>>  arch/powerpc/mm/mmu_context_iommu.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
>> index 497130c5c742..ba7fccf993b3 100644
>> --- a/arch/powerpc/mm/mmu_context_iommu.c
>> +++ b/arch/powerpc/mm/mmu_context_iommu.c
>> @@ -81,7 +81,7 @@ struct page *new_iommu_non_cma_page(struct page *page, unsigned long private,
>>  	gfp_t gfp_mask = GFP_USER;
>>  	struct page *new_page;
>>
>> -	if (PageHuge(page) || PageTransHuge(page) || PageCompound(page))
>> +	if (PageCompound(page) || PageHuge(page) || PageTransHuge(page))
> 
> 
> A checked for compound page should be sufficient here, because a
> Huge/TransHuge page is also marked compound.


But PageCompound() calls PageTail() so PageTail() will be called on a trans
page which is BUG_ON in PageTransHuge but it is not in PageCompound() -
this inconsistency is bothering me. Does not this BUG_ON tell us that we
should not be calling PageTail() on _any_ page?

In other words, should I get a head page (via compound_head()) first and
only then test the head page if it is thp/huge (as you suggested in a chat)?


> If we want to indicate that
> we don't handle hugetlb and THP pages, we can write that as a comment ?
> 
> 
> 
>>  		return NULL;
>>
>>  	if (PageHighMem(page))
>> @@ -100,7 +100,7 @@ static int mm_iommu_move_page_from_cma(struct page *page)
>>  	LIST_HEAD(cma_migrate_pages);
>>
>>  	/* Ignore huge pages for now */
>> -	if (PageHuge(page) || PageTransHuge(page) || PageCompound(page))
>> +	if (PageCompound(page) || PageHuge(page) || PageTransHuge(page))
>>  		return -EBUSY;
>>
>>  	lru_add_drain();
>> -- 
>> 2.11.0
> 


-- 
Alexey
