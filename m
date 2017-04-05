Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyWgS1XWpzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 13:34:59 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v353Xf5T029915
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 23:34:51 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29mc5k9auu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 23:34:51 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 21:34:50 -0600
Subject: Re: [PATCH kernel] powerpc/iommu: Do not call PageTransHuge() on tail
 pages
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
References: <20170328052559.12912-1-aik@ozlabs.ru>
 <871st834na.fsf@skywalker.in.ibm.com>
 <0657df73-b221-2a49-358b-9f0c339cb0be@ozlabs.ru>
Cc: Balbir Singh <bsingharora@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Greg Kurz <groug@kaod.org>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 09:04:43 +0530
MIME-Version: 1.0
In-Reply-To: <0657df73-b221-2a49-358b-9f0c339cb0be@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
Message-Id: <62c19feb-11a6-573b-6e1e-27aeb3a06fd5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 05 April 2017 08:29 AM, Alexey Kardashevskiy wrote:
> On 04/04/17 19:26, Aneesh Kumar K.V wrote:
>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>
>>> The CMA pages migration code does not support compound pages at
>>> the moment so it performs few tests before proceeding to actual page
>>> migration.
>>>
>>> One of the tests - PageTransHuge() - has VM_BUG_ON_PAGE(PageTail()) as
>>> it should be called on head pages. Since we also test for PageCompound(),
>>> and it contains PageTail(), we can simply move PageCompound() in front
>>> of PageTransHuge() and therefore avoid possible VM_BUG_ON_PAGE.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>
>>> Some of actual POWER8 systems do crash on that BUG_ON.
>>> ---
>>>  arch/powerpc/mm/mmu_context_iommu.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
>>> index 497130c5c742..ba7fccf993b3 100644
>>> --- a/arch/powerpc/mm/mmu_context_iommu.c
>>> +++ b/arch/powerpc/mm/mmu_context_iommu.c
>>> @@ -81,7 +81,7 @@ struct page *new_iommu_non_cma_page(struct page *page, unsigned long private,
>>>  	gfp_t gfp_mask = GFP_USER;
>>>  	struct page *new_page;
>>>
>>> -	if (PageHuge(page) || PageTransHuge(page) || PageCompound(page))
>>> +	if (PageCompound(page) || PageHuge(page) || PageTransHuge(page))
>>
>>
>> A checked for compound page should be sufficient here, because a
>> Huge/TransHuge page is also marked compound.
>
>
> But PageCompound() calls PageTail() so PageTail() will be called on a trans
> page which is BUG_ON in PageTransHuge but it is not in PageCompound() -
> this inconsistency is bothering me. Does not this BUG_ON tell us that we
> should not be calling PageTail() on _any_ page?
>
> In other words, should I get a head page (via compound_head()) first and
> only then test the head page if it is thp/huge (as you suggested in a chat)?
>
>
>

I was suggesting to replace that if () condition with just

/* We don't handle hugetlb/THP pages yet */
if (PageCompund(page)) {

}

-aneesh
