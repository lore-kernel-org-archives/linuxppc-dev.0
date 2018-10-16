Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EEEC04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 04:59:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093452054F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 04:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="oaVQYGqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093452054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z35F6bmrzDqD5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 15:59:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="oaVQYGqE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="oaVQYGqE"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Z32Z04tMzF3Vw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 15:57:25 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id f18-v6so10243730pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 21:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GZ5i8bLxWPJ3Fb+vgTbKum5dXYXluQdyF4rEe/OCbP4=;
 b=oaVQYGqEoa7BZwSBigvBks9AXD1HW81G+c8DvSuiVwnp+FstwrfTQp7fnbW35xGZV6
 8U0uWiI2xmrmWkpJchTKLNmRx9PGeCOh97iUqkw+ov+xSI8cJzrX7+FRbhUGne7Cg3cT
 p2ln7TscOuI16De+WNFwlVWZKGGjvuN8qFSw7Rb4QuFTJDM6Jdx5uTeSvYEnRJNfCoI7
 q9hxjJ+S6BePTM3bRRH/dCFtT3y2mL8yU4L696a7gX8w6l6LQo4whybD35EjHwsvHR3a
 SKdwTFfKXxKanp/DmMXZ1uIfOGDhzlnXdb79LhI7ARW73GCTLfAQSLZQ/p8wUg9UkctJ
 Ofbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GZ5i8bLxWPJ3Fb+vgTbKum5dXYXluQdyF4rEe/OCbP4=;
 b=RYrJus+b5ZwFgu7qpNs0dbE8Hw+lHIk1C4BvMsFMcO7L5N8S8OMQormsPdG6EKUiwl
 N5S7Gv5vbXdpC2lL5lyxmhITXud2P9wLFogevaViPdkbWlIlSU+TosbxKPal9W+pjxjD
 4Hg8VG/sdLbZUQ8llEFPtf0CJ4SicabunOYrYWJ/gsXq6rg1F/juTMEN+ADn/p1ckEMn
 FgUrpc6K1xJHUMmdaq4YLmB4v/UISmRqXtmReRrBW66XfWVSD9LvsrNDZ3dxbM4FXEo3
 ctkVRqKxVOMDQ9JvLbr7noI8ReKyzDKmKMOuZBjJgff8BSs7VcDvSUhzv/pBTpHgbdqb
 nSyQ==
X-Gm-Message-State: ABuFfojmjF0cV6Jmkgl4ZVvnjW2bzCUwLFfSe5hVNpsGA5oQbhOHvIs/
 Bjcbbqi5wwcuvu64j5OjQ+Vbm84KSDI=
X-Google-Smtp-Source: ACcGV62QU6aPuqzJTDSHkyCACz0zP1ol5qE4EUGLOGuI1NIXwh8SzDl5rOx34OyHni22JsfeLXZ0mQ==
X-Received: by 2002:a62:3995:: with SMTP id
 u21-v6mr20672975pfj.116.1539665844017; 
 Mon, 15 Oct 2018 21:57:24 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id z11-v6sm24179378pfd.99.2018.10.15.21.57.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Oct 2018 21:57:23 -0700 (PDT)
Subject: Re: [PATCH V3 1/2] mm: Add get_user_pages_cma_migrate
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
 mpe@ellerman.id.au
References: <20180918115839.22154-1-aneesh.kumar@linux.ibm.com>
 <20180918115839.22154-2-aneesh.kumar@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <6112386d-65cd-fc1f-b012-e33da2c3b8fe@ozlabs.ru>
Date: Tue, 16 Oct 2018 15:57:19 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180918115839.22154-2-aneesh.kumar@linux.ibm.com>
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



On 18/09/2018 21:58, Aneesh Kumar K.V wrote:
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
>  mm/migrate.c            | 132 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 6b68e345f0ca..1abccb1a1ecc 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -357,6 +357,8 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
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
> index 3c21775f196b..1abbfcb84f66 100644
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
> index d6a2e89b086a..2f92534ea7a1 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -3006,3 +3006,135 @@ int migrate_vma(const struct migrate_vma_ops *ops,
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
> +	gfp_t gfp_mask = GFP_USER | __GFP_THISNODE;
> +
> +	if (PageHighMem(page))
> +		gfp_mask |= __GFP_HIGHMEM;
> +
> +	if (PageTransHuge(page)) {
> +		struct page *thp;
> +		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_THISNODE;
> +
> +		/*
> +		 * Remove the movable mask so that we don't allocate from
> +		 * CMA area again.
> +		 */
> +		thp_gfpmask &= ~__GFP_MOVABLE;
> +		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);


HPAGE_PMD_ORDER is 2MB or 1GB? THP are always that PMD order?


> +		if (!thp)
> +			return NULL;
> +		prep_transhuge_page(thp);
> +		return thp;
> +
> +#ifdef  CONFIG_HUGETLB_PAGE
> +	} else if (PageHuge(page)) {
> +
> +		struct hstate *h = page_hstate(page);
> +		/*
> +		 * We don't want to dequeue from the pool because pool pages will
> +		 * mostly be from the CMA region.
> +		 */
> +		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
> +#endif
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


I do not see any locking or get_user_pages(), hidden somewhere?

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
> +			if (PageHuge(pages[i]))
> +				isolate_huge_page(pages[i], &cma_page_list);
> +			else {
> +				struct page *head = compound_head(pages[i]);
> +
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


Above 10 lines I cannot really comment due to my massive ignorance in
this area, especially about what lru_add_drain_all() and
mod_node_page_state() :(


> +				}
> +			}
> +		}
> +	}
> +	if (!list_empty(&cma_page_list)) {
> +		/*
> +		 * drop the above get_user_pages reference.
> +		 */
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


migrate_allow seems useless, simply calling get_user_pages_fast() should
make the code easier to read imho. And the comment says
get_user_pages(), where does this guy hide?

> +
> +			if (!list_empty(&cma_page_list))
> +				putback_movable_pages(&cma_page_list);
> +		}
> +		/*
> +		 * We did migrate all the pages, Try to get the page references again
> +		 * migrating any new CMA pages which we failed to isolate earlier.
> +		 */
> +		drain_allow = true;

Move this "drain_allow = true" right after "get_user_again:"?


> +		goto get_user_again;
> +	}
> +	return ret;
> +}
> 

-- 
Alexey
