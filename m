Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426FGg09BTzF3SF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2018 21:15:22 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w87BEpa7083166
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2018 07:15:19 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mbqdwhxk3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Sep 2018 07:15:19 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 7 Sep 2018 05:15:18 -0600
Subject: Re: [RFC PATCH V2 4/4] powerpc/mm/iommu: Allow migration of cma
 allocated pages during mm_iommu_get
To: Michal Hocko <mhocko@kernel.org>
Cc: akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 mpe@ellerman.id.au, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906054342.25094-4-aneesh.kumar@linux.ibm.com>
 <20180906125356.GX14951@dhcp22.suse.cz>
 <50d355bf-17d0-ee01-ec35-7f04e79ca277@linux.ibm.com>
 <20180907090312.GF19621@dhcp22.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Fri, 7 Sep 2018 16:45:09 +0530
MIME-Version: 1.0
In-Reply-To: <20180907090312.GF19621@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8337fdcc-3344-04dd-ddb2-68f86912f333@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/07/2018 02:33 PM, Michal Hocko wrote:
> On Thu 06-09-18 19:00:43, Aneesh Kumar K.V wrote:
>> On 09/06/2018 06:23 PM, Michal Hocko wrote:
>>> On Thu 06-09-18 11:13:42, Aneesh Kumar K.V wrote:
>>>> Current code doesn't do page migration if the page allocated is a compound page.
>>>> With HugeTLB migration support, we can end up allocating hugetlb pages from
>>>> CMA region. Also THP pages can be allocated from CMA region. This patch updates
>>>> the code to handle compound pages correctly.
>>>>
>>>> This use the new helper get_user_pages_cma_migrate. It does one get_user_pages
>>>> with right count, instead of doing one get_user_pages per page. That avoids
>>>> reading page table multiple times.
>>>>
>>>> The patch also convert the hpas member of mm_iommu_table_group_mem_t to a union.
>>>> We use the same storage location to store pointers to struct page. We cannot
>>>> update alll the code path use struct page *, because we access hpas in real mode
>>>> and we can't do that struct page * to pfn conversion in real mode.
>>>
>>> I am not fmailiar with this code so bear with me. I am completely
>>> missing the purpose of this patch. The changelog doesn't really explain
>>> that AFAICS. I can only guess that you do not want to establish long
>>> pins on CMA pages, right? So whenever you are about to pin a page that
>>> is in CMA you migrate it away to a different !__GFP_MOVABLE page, right?
>>
>> That is right.
>>
>>> If that is the case then how do you handle pins which are already in
>>> zone_movable? I do not see any specific check for those.
>>
>>
>>>
>>> Btw. why is this a proper thing to do? Problems with longterm pins are
>>> not only for CMA/ZONE_MOVABLE pages. Pinned pages are not reclaimable as
>>> well so there is a risk of OOMs if there are too many of them. We have
>>> discussed approaches that would allow to force pin invalidation/revocation
>>> at LSF/MM. Isn't that a more appropriate solution to the problem you are
>>> seeing?
>>>
>>
>> The CMA area is used on powerpc platforms to allocate guest specific page
>> table (hash page table). If we don't have sufficient free pages we fail to
>> allocate hash page table that result in failure to start guest.
>>
>> Now with vfio, we end up pinning the entire guest RAM. There is a
>> possibility that these guest RAM  pages got allocated from CMA region. We
>> already do supporting migrating those pages out except for compound pages.
>> What this patch does is to start supporting compound page migration that got
>> allocated out of CMA region (ie, THP pages and hugetlb pages if platform
>> supported hugetlb migration).
> 
> This definitely belongs to the changelog.
> 
>> Now to do that I added a helper get_user_pages_cma_migrate().
>>
>> I agree that long term pinned pages do have other issues. The patchset is
>> not solving that issue.
> 
> It would be great to note why a generic approach is not viable. I assume
> the main reason is that those pins are pretty much permanent for the
> guest lifetime so the situation has to be handled in advance. In other
> words, more information please.
> 

That is correct. I will add these details to commit message. And will 
also do a cover letter for the patch series.

-aneesh
