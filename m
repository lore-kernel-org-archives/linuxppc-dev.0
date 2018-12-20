Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B635C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 04:21:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA49520866
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 04:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="g4eReqOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA49520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Kz9L412GzDqYY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 15:21:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="g4eReqOh";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="g4eReqOh"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Kz6S48NhzDqTM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 15:19:10 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id b5so250437plr.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 20:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PRhBzkskgzE50dsk0gTaVqZbOF7zblbhBjKrtAW6Z3c=;
 b=g4eReqOhFHFhAbW30dzSGBYFtJ4Glg7ShWdncYnJchM6MM2h6mjucrIn5kYT/jBlrg
 Zfay1DNk10N+wct93viisA8kYe0ZyEJTPazpYVyKiCKM/QCoO5qfUIbLQsvTwG/tIRTz
 ePY/znkzB3rEt3utBG0fmdRe2zsOGd2p5jhBWtMpzF50jFx04CNqOvuGMoirEBr/9AEE
 pzrFUu2v/8SEXdhnVJlVLB92SMnfP9ZY6Wa24HNqdYZs9d50ExGqtmisEnHHBUhbCUWw
 UWk3iASCBXpoD+rzk0J2XxSiUvFy6M8QOZKPvmiSSlTdMTbioq2c+BW0kXi5+k6m9/jm
 khLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=PRhBzkskgzE50dsk0gTaVqZbOF7zblbhBjKrtAW6Z3c=;
 b=StXRh7E6rHHwXRAnctPWFxbpXsyTUwjy0VNDb5mQ5COP/3OkBTXdhkrj1uiDOR0oX5
 3zoulqo1qeMOrU7u3QdYQLLdJYnaiRpLiaZbRAX/YsdKDJXG9Ta/a36iJsX3m6ZEA78y
 KdAi8zoEV7kFvRm1u+IKa876jiY08c/D8dJaQB03dj9x1x/Mey/EDs9GCXotYLoDf7Ir
 c1D/OCuMzyU0cXYgLwCtIXDZT0ACIQYhuJ4oddj0QBUG/QtNBBx+YKeVd70SNV+9E8Rq
 quSctoYDEYPN6gKu60zoMWwI618ZiKguFSlqz607seVXPHTJ4xzAQSN76Dx1A/t6fco/
 WAWQ==
X-Gm-Message-State: AA+aEWYzMJkKNy5NE3XzOw1/2CRurIdXHo5Uz25E+GKX+y5a0kmH5hTR
 c7WSPsj+1UeNtMz5ImCDE6MHq8Fv79E=
X-Google-Smtp-Source: AFSGD/Vz7V2/6jRbMg1VVW4hab7s+ARpP7rCKdL73IzcKkHNCtTUgQMe5nrmSDNzpNH/D24lpbSMqw==
X-Received: by 2002:a17:902:722:: with SMTP id
 31mr22837913pli.271.1545279548166; 
 Wed, 19 Dec 2018 20:19:08 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 7sm61918827pfm.8.2018.12.19.20.19.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 20:19:07 -0800 (PST)
Subject: Re: [PATCH V5 1/3] mm: Add get_user_pages_cma_migrate
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
 mpe@ellerman.id.au, paulus@samba.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20181219034047.16305-1-aneesh.kumar@linux.ibm.com>
 <20181219034047.16305-2-aneesh.kumar@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <e9c9b68a-a31b-ab59-902a-73401a89f72a@ozlabs.ru>
Date: Thu, 20 Dec 2018 15:19:00 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219034047.16305-2-aneesh.kumar@linux.ibm.com>
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



On 19/12/2018 14:40, Aneesh Kumar K.V wrote:
> This helper does a get_user_pages_fast and if it find pages in the CMA area
> it will try to migrate them before taking page reference. This makes sure that
> we don't keep non-movable pages (due to page reference count) in the CMA area.
> Not able to move pages out of CMA area result in CMA allocation failures.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/hugetlb.h |   2 +
>  include/linux/migrate.h |   3 +
>  mm/hugetlb.c            |   4 +-
>  mm/migrate.c            | 139 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 146 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 087fd5f48c91..1eed0cdaec0e 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -371,6 +371,8 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
>  				nodemask_t *nmask);
>  struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>  				unsigned long address);
> +struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
> +				     int nid, nodemask_t *nmask);
>  int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
>  			pgoff_t idx);
>  
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index f2b4abbca55e..d82b35afd2eb 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -286,6 +286,9 @@ static inline int migrate_vma(const struct migrate_vma_ops *ops,
>  }
>  #endif /* IS_ENABLED(CONFIG_MIGRATE_VMA_HELPER) */
>  
> +extern int get_user_pages_cma_migrate(unsigned long start, int nr_pages, int write,
> +				      struct page **pages);
> +
>  #endif /* CONFIG_MIGRATION */
>  
>  #endif /* _LINUX_MIGRATE_H */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7f2a28ab46d5..faf3102ae45e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1585,8 +1585,8 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>  	return page;
>  }
>  
> -static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
> -		int nid, nodemask_t *nmask)
> +struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
> +				     int nid, nodemask_t *nmask)
>  {
>  	struct page *page;
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f7e4bfdc13b7..d564558fba03 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2946,3 +2946,142 @@ int migrate_vma(const struct migrate_vma_ops *ops,
>  }
>  EXPORT_SYMBOL(migrate_vma);
>  #endif /* defined(MIGRATE_VMA_HELPER) */
> +
> +static struct page *new_non_cma_page(struct page *page, unsigned long private)
> +{
> +	/*
> +	 * We want to make sure we allocate the new page from the same node
> +	 * as the source page.
> +	 */
> +	int nid = page_to_nid(page);
> +	/*
> +	 * Trying to allocate a page for migration. Ignore allocation
> +	 * failure warnings
> +	 */
> +	gfp_t gfp_mask = GFP_USER | __GFP_THISNODE | __GFP_NOWARN;
> +
> +	if (PageHighMem(page))
> +		gfp_mask |= __GFP_HIGHMEM;
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +	if (PageHuge(page)) {
> +		struct hstate *h = page_hstate(page);
> +		/*
> +		 * We don't want to dequeue from the pool because pool pages will
> +		 * mostly be from the CMA region.
> +		 */
> +		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
> +	}
> +#endif
> +	if (PageTransHuge(page)) {
> +		struct page *thp;
> +		/*
> +		 * ignore allocation failure warnings
> +		 */
> +		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_THISNODE | __GFP_NOWARN;
> +
> +		/*
> +		 * Remove the movable mask so that we don't allocate from
> +		 * CMA area again.
> +		 */
> +		thp_gfpmask &= ~__GFP_MOVABLE;
> +		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
> +		if (!thp)
> +			return NULL;
> +		prep_transhuge_page(thp);
> +		return thp;
> +	}
> +
> +	return __alloc_pages_node(nid, gfp_mask, 0);
> +}
> +
> +/**
> + * get_user_pages_cma_migrate() - pin user pages in memory by migrating pages in CMA region
> + * @start:	starting user address
> + * @nr_pages:	number of pages from start to pin
> + * @write:	whether pages will be written to
> + * @pages:	array that receives pointers to the pages pinned.
> + *		Should be at least nr_pages long.
> + *
> + * Attempt to pin user pages in memory without taking mm->mmap_sem.
> + * If not successful, it will fall back to taking the lock and
> + * calling get_user_pages().
> + *
> + * If the pinned pages are backed by CMA region, we migrate those pages out,
> + * allocating new pages from non-CMA region. This helps in avoiding keeping
> + * pages pinned in the CMA region for a long time thereby resulting in
> + * CMA allocation failures.
> + *
> + * Returns number of pages pinned. This may be fewer than the number
> + * requested. If nr_pages is 0 or negative, returns 0. If no pages
> + * were pinned, returns -errno.
> + */
> +
> +int get_user_pages_cma_migrate(unsigned long start, int nr_pages, int write,
> +			       struct page **pages)
> +{
> +	int i, ret;
> +	bool drain_allow = true;
> +	bool migrate_allow = true;
> +	LIST_HEAD(cma_page_list);
> +
> +get_user_again:
> +	ret = get_user_pages_fast(start, nr_pages, write, pages);
> +	if (ret <= 0)
> +		return ret;
> +
> +	for (i = 0; i < ret; ++i) {
> +		/*
> +		 * If we get a page from the CMA zone, since we are going to
> +		 * be pinning these entries, we might as well move them out
> +		 * of the CMA zone if possible.
> +		 */
> +		if (is_migrate_cma_page(pages[i]) && migrate_allow) {
> +
> +			struct page *head = compound_head(pages[i]);
> +
> +			if (PageHuge(head))
> +				isolate_huge_page(head, &cma_page_list);


You need curly braces in both branches as per
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n191


> +			else {
> +				if (!PageLRU(head) && drain_allow) {
> +					lru_add_drain_all();
> +					drain_allow = false;
> +				}
> +
> +				if (!isolate_lru_page(head)) {
> +					list_add_tail(&head->lru, &cma_page_list);
> +					mod_node_page_state(page_pgdat(head),
> +							    NR_ISOLATED_ANON +
> +							    page_is_file_cache(head),
> +							    hpage_nr_pages(head));
> +				}
> +			}
> +		}
> +	}
> +	if (!list_empty(&cma_page_list)) {
> +		/*
> +		 * drop the above get_user_pages reference.
> +		 */


Can be a single line comment.

> +		for (i = 0; i < ret; ++i)
> +			put_page(pages[i]);
> +
> +		if (migrate_pages(&cma_page_list, new_non_cma_page,
> +				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
> +			/*
> +			 * some of the pages failed migration. Do get_user_pages
> +			 * without migration.
> +			 */
> +			migrate_allow = false;
> +
> +			if (!list_empty(&cma_page_list))
> +				putback_movable_pages(&cma_page_list);
> +		}
> +		/*
> +		 * We did migrate all the pages, Try to get the page references again
> +		 * migrating any new CMA pages which we failed to isolate earlier.
> +		 */
> +		drain_allow = true;
> +		goto get_user_again;


So it is possible to have pages pinned, then successfully migrated
(migrate_pages() returned 0), then pinned again, then some pages may end
up in CMA again and migrate again and nothing seems to prevent this loop
from being endless. What do I miss?

(ps I hate such "goto"s, confuse a lot)


> +	}
> +	return ret;
> +}
> 

-- 
Alexey
