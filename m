Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8CAC04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:18:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D65B20869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D65B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z69l3j5PzF3Wf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 18:18:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Z67b4rwwzF3VB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 18:16:59 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9G79ZVf131712
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 03:16:57 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n57pwqrqy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 03:16:56 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 16 Oct 2018 08:16:54 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Oct 2018 08:16:50 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9G7GnSl48627920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Oct 2018 07:16:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A70F5205A;
 Tue, 16 Oct 2018 07:16:49 +0000 (GMT)
Received: from skywalker (unknown [9.199.58.69])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id CD04052052;
 Tue, 16 Oct 2018 07:16:36 +0000 (GMT)
Received: (nullmailer pid 21845 invoked by uid 1000);
 Tue, 16 Oct 2018 07:16:35 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, akpm@linux-foundation.org,
 Michal Hocko <mhocko@kernel.org>, mpe@ellerman.id.au
Subject: Re: [PATCH V3 1/2] mm: Add get_user_pages_cma_migrate
In-Reply-To: <6112386d-65cd-fc1f-b012-e33da2c3b8fe@ozlabs.ru>
References: <20180918115839.22154-1-aneesh.kumar@linux.ibm.com>
 <20180918115839.22154-2-aneesh.kumar@linux.ibm.com>
 <6112386d-65cd-fc1f-b012-e33da2c3b8fe@ozlabs.ru>
Date: Tue, 16 Oct 2018 12:46:35 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18101607-4275-0000-0000-000002CC9BD3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101607-4276-0000-0000-000037D7A21D
Message-Id: <87murewecs.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=44 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160065
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> On 18/09/2018 21:58, Aneesh Kumar K.V wrote:
>> This helper does a get_user_pages_fast and if it find pages in the CMA area
>> it will try to migrate them before taking page reference. This makes sure that
>> we don't keep non-movable pages (due to page reference count) in the CMA area.
>> Not able to move pages out of CMA area result in CMA allocation failures.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  include/linux/hugetlb.h |   2 +
>>  include/linux/migrate.h |   3 +
>>  mm/hugetlb.c            |   4 +-
>>  mm/migrate.c            | 132 ++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 139 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 6b68e345f0ca..1abccb1a1ecc 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -357,6 +357,8 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
>>  				nodemask_t *nmask);
>>  struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>>  				unsigned long address);
>> +struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
>> +				     int nid, nodemask_t *nmask);
>>  int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
>>  			pgoff_t idx);
>>  
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index f2b4abbca55e..d82b35afd2eb 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -286,6 +286,9 @@ static inline int migrate_vma(const struct migrate_vma_ops *ops,
>>  }
>>  #endif /* IS_ENABLED(CONFIG_MIGRATE_VMA_HELPER) */
>>  
>> +extern int get_user_pages_cma_migrate(unsigned long start, int nr_pages, int write,
>> +				      struct page **pages);
>> +
>>  #endif /* CONFIG_MIGRATION */
>>  
>>  #endif /* _LINUX_MIGRATE_H */
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 3c21775f196b..1abbfcb84f66 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1585,8 +1585,8 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>>  	return page;
>>  }
>>  
>> -static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
>> -		int nid, nodemask_t *nmask)
>> +struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
>> +				     int nid, nodemask_t *nmask)
>>  {
>>  	struct page *page;
>>  
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index d6a2e89b086a..2f92534ea7a1 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -3006,3 +3006,135 @@ int migrate_vma(const struct migrate_vma_ops *ops,
>>  }
>>  EXPORT_SYMBOL(migrate_vma);
>>  #endif /* defined(MIGRATE_VMA_HELPER) */
>> +
>> +static struct page *new_non_cma_page(struct page *page, unsigned long private)
>> +{
>> +	/*
>> +	 * We want to make sure we allocate the new page from the same node
>> +	 * as the source page.
>> +	 */
>> +	int nid = page_to_nid(page);
>> +	gfp_t gfp_mask = GFP_USER | __GFP_THISNODE;
>> +
>> +	if (PageHighMem(page))
>> +		gfp_mask |= __GFP_HIGHMEM;
>> +
>> +	if (PageTransHuge(page)) {
>> +		struct page *thp;
>> +		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_THISNODE;
>> +
>> +		/*
>> +		 * Remove the movable mask so that we don't allocate from
>> +		 * CMA area again.
>> +		 */
>> +		thp_gfpmask &= ~__GFP_MOVABLE;
>> +		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
>
>
> HPAGE_PMD_ORDER is 2MB or 1GB? THP are always that PMD order?

2M or 16M. THP is at PMD level.

>
>
>> +		if (!thp)
>> +			return NULL;
>> +		prep_transhuge_page(thp);
>> +		return thp;
>> +
>> +#ifdef  CONFIG_HUGETLB_PAGE
>> +	} else if (PageHuge(page)) {
>> +
>> +		struct hstate *h = page_hstate(page);
>> +		/*
>> +		 * We don't want to dequeue from the pool because pool pages will
>> +		 * mostly be from the CMA region.
>> +		 */
>> +		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
>> +#endif
>> +	}
>> +
>> +	return __alloc_pages_node(nid, gfp_mask, 0);
>> +}
>> +
>> +/**
>> + * get_user_pages_cma_migrate() - pin user pages in memory by migrating pages in CMA region
>> + * @start:	starting user address
>> + * @nr_pages:	number of pages from start to pin
>> + * @write:	whether pages will be written to
>> + * @pages:	array that receives pointers to the pages pinned.
>> + *		Should be at least nr_pages long.
>> + *
>> + * Attempt to pin user pages in memory without taking mm->mmap_sem.
>> + * If not successful, it will fall back to taking the lock and
>> + * calling get_user_pages().
>
>
> I do not see any locking or get_user_pages(), hidden somewhere?
>

The rules are same as get_user_pages_fast, which does that pin attempt
without taking mm->mmap_sem. If it fail get_user_pages_fast will take
the mmap_sem and try to pin the pages. The details are in
get_user_pages_fast. You can look at get_user_pages_unlocked


>> + *
>> + * If the pinned pages are backed by CMA region, we migrate those pages out,
>> + * allocating new pages from non-CMA region. This helps in avoiding keeping
>> + * pages pinned in the CMA region for a long time thereby resulting in
>> + * CMA allocation failures.
>> + *
>> + * Returns number of pages pinned. This may be fewer than the number
>> + * requested. If nr_pages is 0 or negative, returns 0. If no pages
>> + * were pinned, returns -errno.
>> + */
>> +
>> +int get_user_pages_cma_migrate(unsigned long start, int nr_pages, int write,
>> +			       struct page **pages)
>> +{
>> +	int i, ret;
>> +	bool drain_allow = true;
>> +	bool migrate_allow = true;
>> +	LIST_HEAD(cma_page_list);
>> +
>> +get_user_again:
>> +	ret = get_user_pages_fast(start, nr_pages, write, pages);
>> +	if (ret <= 0)
>> +		return ret;
>> +
>> +	for (i = 0; i < ret; ++i) {
>> +		/*
>> +		 * If we get a page from the CMA zone, since we are going to
>> +		 * be pinning these entries, we might as well move them out
>> +		 * of the CMA zone if possible.
>> +		 */
>> +		if (is_migrate_cma_page(pages[i]) && migrate_allow) {
>> +			if (PageHuge(pages[i]))
>> +				isolate_huge_page(pages[i], &cma_page_list);
>> +			else {
>> +				struct page *head = compound_head(pages[i]);
>> +
>> +				if (!PageLRU(head) && drain_allow) {
>> +					lru_add_drain_all();
>> +					drain_allow = false;
>> +				}
>> +
>> +				if (!isolate_lru_page(head)) {
>> +					list_add_tail(&head->lru, &cma_page_list);
>> +					mod_node_page_state(page_pgdat(head),
>> +							    NR_ISOLATED_ANON +
>> +							    page_is_file_cache(head),
>> +							    hpage_nr_pages(head));
>
>
> Above 10 lines I cannot really comment due to my massive ignorance in
> this area, especially about what lru_add_drain_all() and
> mod_node_page_state() :(

That makes sure we move the pages from per cpu lru vec and add them to
the right lru list so that we can isolate the pages correctly.

>
>
>> +				}
>> +			}
>> +		}
>> +	}
>> +	if (!list_empty(&cma_page_list)) {
>> +		/*
>> +		 * drop the above get_user_pages reference.
>> +		 */
>> +		for (i = 0; i < ret; ++i)
>> +			put_page(pages[i]);
>> +
>> +		if (migrate_pages(&cma_page_list, new_non_cma_page,
>> +				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
>> +			/*
>> +			 * some of the pages failed migration. Do get_user_pages
>> +			 * without migration.
>> +			 */
>> +			migrate_allow = false;
>
>
> migrate_allow seems useless, simply calling get_user_pages_fast() should
> make the code easier to read imho. And the comment says
> get_user_pages(), where does this guy hide?

I didn't get that suggestion. What we want to do here is try to migrate pages as
long as we find CMA pages in the result of get_user_pages_fast. If we
failed any migration attempt, don't try to migrate again.

>
>> +
>> +			if (!list_empty(&cma_page_list))
>> +				putback_movable_pages(&cma_page_list);
>> +		}
>> +		/*
>> +		 * We did migrate all the pages, Try to get the page references again
>> +		 * migrating any new CMA pages which we failed to isolate earlier.
>> +		 */
>> +		drain_allow = true;
>
> Move this "drain_allow = true" right after "get_user_again:"? 1
 
>
>
>> +		goto get_user_again;
>> +	}
>> +	return ret;
>> +}
>> 
>
> -- 
> Alexey

-aneesh

