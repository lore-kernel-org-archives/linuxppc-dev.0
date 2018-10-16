Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E944CC04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:54:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C8120869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="z0uPCSsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C8120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z6zF1D68zF31y
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 18:54:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="z0uPCSsR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="z0uPCSsR"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Z6wV3hM1zF3Vt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 18:52:26 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id f29-v6so11038716pff.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V0PPsLrS4FET3TfvfGoFmLZ01KFf5zqYUUxR1cczWUw=;
 b=z0uPCSsRxn4Cu3Og1P2jlVkYQjA4rByXj1d9CSGupoVCbKOTRKe32unF2zcJzjDLWi
 3b6wChJ3Lxvs3jJ/LOsaIsU6j7qRpUY7vq2K2EHVsSbuVH8kuSjoHbFHmf/3EfPmZwQj
 RxXQIBSnEIQmSzxfGSFZhv8ARkRbFvZchDXmxLeb5sViiUub9nnLEyBL2oeJeCueypCi
 jYNT4ftIr2Qi6wmJPQhw8S15Vda5RCcD0xpc4phAGXXkWgMeHFyu9D688mUMGoLkV6Z+
 +qO3np0Xf4wXd1MafK+k40al1ILgsB9WQKvhTTI2HOXR1/7GoyWbRmGBKIncw9sEWcLb
 KlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=V0PPsLrS4FET3TfvfGoFmLZ01KFf5zqYUUxR1cczWUw=;
 b=DyE81XW2hsoHUspcA7MfNYWgOuf3I/atgoOcH+ZSVJmjQPxjMZ0kdzPxESDyKnTMTc
 uBGTdoNvKtq0hyT2h4Rq6QpnvEFMmccLVznEGpLzo/PJay5Rc3Y1S3McxMEGoCYBR5c6
 4Ci2RGpuXZvC2BzXKseRpceNZ0Y5aCMeko578Mts2YSQ0PMTWfRNqnfFJJwWyfssMT5V
 CvWPgSEodeFqQs2kQiZKlU3no9Vhm4BleAX+OpI3YxlnBuw5TGDeX8ZMGFBvZXBCE9B+
 6qF49hmJQ/ThgAwuXY9U/vPpVbM9oSmuMLr0Ec6rF0ycxGkm/u+VU7j3fxxRU9WrRuIG
 /CrQ==
X-Gm-Message-State: ABuFfohB1oGkEa5u83jbFPyVkuiVSOycUeCQFo2beQo3E2jTJ68+oGVe
 Cg6bMDYu8o6FtL6qCSn5W9qgJYopywc=
X-Google-Smtp-Source: ACcGV628X7zKsUTCb7QM6ygqA8chtSBo+DF65Cl/DmL0YmNpfNHByDfWcy9idaYEKoTZAogYl4jjkA==
X-Received: by 2002:a63:e04d:: with SMTP id
 n13-v6mr19543748pgj.426.1539676344086; 
 Tue, 16 Oct 2018 00:52:24 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id b10-v6sm22002581pfe.148.2018.10.16.00.52.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Oct 2018 00:52:23 -0700 (PDT)
Subject: Re: [PATCH V3 1/2] mm: Add get_user_pages_cma_migrate
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
 mpe@ellerman.id.au
References: <20180918115839.22154-1-aneesh.kumar@linux.ibm.com>
 <20180918115839.22154-2-aneesh.kumar@linux.ibm.com>
 <6112386d-65cd-fc1f-b012-e33da2c3b8fe@ozlabs.ru>
 <87murewecs.fsf@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <485adcad-4996-ae2c-c098-9dc7bcd2d29a@ozlabs.ru>
Date: Tue, 16 Oct 2018 18:52:18 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87murewecs.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 16/10/2018 18:16, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> On 18/09/2018 21:58, Aneesh Kumar K.V wrote:
>>> This helper does a get_user_pages_fast and if it find pages in the CMA area
>>> it will try to migrate them before taking page reference. This makes sure that
>>> we don't keep non-movable pages (due to page reference count) in the CMA area.
>>> Not able to move pages out of CMA area result in CMA allocation failures.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>  include/linux/hugetlb.h |   2 +
>>>  include/linux/migrate.h |   3 +
>>>  mm/hugetlb.c            |   4 +-
>>>  mm/migrate.c            | 132 ++++++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 139 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 6b68e345f0ca..1abccb1a1ecc 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -357,6 +357,8 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
>>>  				nodemask_t *nmask);
>>>  struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>>>  				unsigned long address);
>>> +struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
>>> +				     int nid, nodemask_t *nmask);
>>>  int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
>>>  			pgoff_t idx);
>>>  
>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>> index f2b4abbca55e..d82b35afd2eb 100644
>>> --- a/include/linux/migrate.h
>>> +++ b/include/linux/migrate.h
>>> @@ -286,6 +286,9 @@ static inline int migrate_vma(const struct migrate_vma_ops *ops,
>>>  }
>>>  #endif /* IS_ENABLED(CONFIG_MIGRATE_VMA_HELPER) */
>>>  
>>> +extern int get_user_pages_cma_migrate(unsigned long start, int nr_pages, int write,
>>> +				      struct page **pages);
>>> +
>>>  #endif /* CONFIG_MIGRATION */
>>>  
>>>  #endif /* _LINUX_MIGRATE_H */
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 3c21775f196b..1abbfcb84f66 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1585,8 +1585,8 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>>>  	return page;
>>>  }
>>>  
>>> -static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
>>> -		int nid, nodemask_t *nmask)
>>> +struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
>>> +				     int nid, nodemask_t *nmask)
>>>  {
>>>  	struct page *page;
>>>  
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index d6a2e89b086a..2f92534ea7a1 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -3006,3 +3006,135 @@ int migrate_vma(const struct migrate_vma_ops *ops,
>>>  }
>>>  EXPORT_SYMBOL(migrate_vma);
>>>  #endif /* defined(MIGRATE_VMA_HELPER) */
>>> +
>>> +static struct page *new_non_cma_page(struct page *page, unsigned long private)
>>> +{
>>> +	/*
>>> +	 * We want to make sure we allocate the new page from the same node
>>> +	 * as the source page.
>>> +	 */
>>> +	int nid = page_to_nid(page);
>>> +	gfp_t gfp_mask = GFP_USER | __GFP_THISNODE;
>>> +
>>> +	if (PageHighMem(page))
>>> +		gfp_mask |= __GFP_HIGHMEM;
>>> +
>>> +	if (PageTransHuge(page)) {
>>> +		struct page *thp;
>>> +		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_THISNODE;
>>> +
>>> +		/*
>>> +		 * Remove the movable mask so that we don't allocate from
>>> +		 * CMA area again.
>>> +		 */
>>> +		thp_gfpmask &= ~__GFP_MOVABLE;
>>> +		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
>>
>>
>> HPAGE_PMD_ORDER is 2MB or 1GB? THP are always that PMD order?
> 
> 2M or 16M. THP is at PMD level.
> 
>>
>>
>>> +		if (!thp)
>>> +			return NULL;
>>> +		prep_transhuge_page(thp);
>>> +		return thp;
>>> +
>>> +#ifdef  CONFIG_HUGETLB_PAGE
>>> +	} else if (PageHuge(page)) {
>>> +
>>> +		struct hstate *h = page_hstate(page);
>>> +		/*
>>> +		 * We don't want to dequeue from the pool because pool pages will
>>> +		 * mostly be from the CMA region.
>>> +		 */
>>> +		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
>>> +#endif
>>> +	}
>>> +
>>> +	return __alloc_pages_node(nid, gfp_mask, 0);
>>> +}
>>> +
>>> +/**
>>> + * get_user_pages_cma_migrate() - pin user pages in memory by migrating pages in CMA region
>>> + * @start:	starting user address
>>> + * @nr_pages:	number of pages from start to pin
>>> + * @write:	whether pages will be written to
>>> + * @pages:	array that receives pointers to the pages pinned.
>>> + *		Should be at least nr_pages long.
>>> + *
>>> + * Attempt to pin user pages in memory without taking mm->mmap_sem.
>>> + * If not successful, it will fall back to taking the lock and
>>> + * calling get_user_pages().
>>
>>
>> I do not see any locking or get_user_pages(), hidden somewhere?
>>
> 
> The rules are same as get_user_pages_fast, which does that pin attempt
> without taking mm->mmap_sem. If it fail get_user_pages_fast will take
> the mmap_sem and try to pin the pages. The details are in
> get_user_pages_fast. You can look at get_user_pages_unlocked

Ah, right.


>>> + *
>>> + * If the pinned pages are backed by CMA region, we migrate those pages out,
>>> + * allocating new pages from non-CMA region. This helps in avoiding keeping
>>> + * pages pinned in the CMA region for a long time thereby resulting in
>>> + * CMA allocation failures.
>>> + *
>>> + * Returns number of pages pinned. This may be fewer than the number
>>> + * requested. If nr_pages is 0 or negative, returns 0. If no pages
>>> + * were pinned, returns -errno.
>>> + */
>>> +
>>> +int get_user_pages_cma_migrate(unsigned long start, int nr_pages, int write,
>>> +			       struct page **pages)
>>> +{
>>> +	int i, ret;
>>> +	bool drain_allow = true;
>>> +	bool migrate_allow = true;
>>> +	LIST_HEAD(cma_page_list);
>>> +
>>> +get_user_again:
>>> +	ret = get_user_pages_fast(start, nr_pages, write, pages);
>>> +	if (ret <= 0)
>>> +		return ret;
>>> +
>>> +	for (i = 0; i < ret; ++i) {
>>> +		/*
>>> +		 * If we get a page from the CMA zone, since we are going to
>>> +		 * be pinning these entries, we might as well move them out
>>> +		 * of the CMA zone if possible.
>>> +		 */
>>> +		if (is_migrate_cma_page(pages[i]) && migrate_allow) {
>>> +			if (PageHuge(pages[i]))
>>> +				isolate_huge_page(pages[i], &cma_page_list);
>>> +			else {
>>> +				struct page *head = compound_head(pages[i]);
>>> +
>>> +				if (!PageLRU(head) && drain_allow) {
>>> +					lru_add_drain_all();
>>> +					drain_allow = false;
>>> +				}
>>> +
>>> +				if (!isolate_lru_page(head)) {
>>> +					list_add_tail(&head->lru, &cma_page_list);
>>> +					mod_node_page_state(page_pgdat(head),
>>> +							    NR_ISOLATED_ANON +
>>> +							    page_is_file_cache(head),
>>> +							    hpage_nr_pages(head));
>>
>>
>> Above 10 lines I cannot really comment due to my massive ignorance in
>> this area, especially about what lru_add_drain_all() and
>> mod_node_page_state() :(
> 
> That makes sure we move the pages from per cpu lru vec and add them to
> the right lru list so that we can isolate the pages correctly.

I understand the idea but cannot confirm the correctness :-/


> 
>>
>>
>>> +				}
>>> +			}
>>> +		}
>>> +	}
>>> +	if (!list_empty(&cma_page_list)) {
>>> +		/*
>>> +		 * drop the above get_user_pages reference.
>>> +		 */


btw, can these pages be used by somebody else in this short window
before we migrated and pinned them?


>>> +		for (i = 0; i < ret; ++i)
>>> +			put_page(pages[i]);
>>> +
>>> +		if (migrate_pages(&cma_page_list, new_non_cma_page,
>>> +				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
>>> +			/*
>>> +			 * some of the pages failed migration. Do get_user_pages
>>> +			 * without migration.
>>> +			 */
>>> +			migrate_allow = false;
>>
>>
>> migrate_allow seems useless, simply calling get_user_pages_fast() should
>> make the code easier to read imho. And the comment says
>> get_user_pages(), where does this guy hide?
> 
> I didn't get that suggestion. What we want to do here is try to migrate pages as
> long as we find CMA pages in the result of get_user_pages_fast. If we
> failed any migration attempt, don't try to migrate again.


Setting migrate_allow to false here means you jump up, call
get_user_pages_fast() and then run the loop which will do nothing just
because if(...migrate_allow) is false. Instead of jumping up you could
just call get_user_pages_fast().

btw what is migrate_pages() leaves something in cma_page_list (I cannot
see it removing pages)? Won't it loop indefinitely?



> 
>>
>>> +
>>> +			if (!list_empty(&cma_page_list))
>>> +				putback_movable_pages(&cma_page_list);
>>> +		}
>>> +		/*
>>> +		 * We did migrate all the pages, Try to get the page references again
>>> +		 * migrating any new CMA pages which we failed to isolate earlier.
>>> +		 */
>>> +		drain_allow = true;
>>
>> Move this "drain_allow = true" right after "get_user_again:"? 1
>  
>>
>>
>>> +		goto get_user_again;
>>> +	}
>>> +	return ret;
>>> +}
>>>
>>
>> -- 
>> Alexey
> 
> -aneesh
> 

-- 
Alexey
