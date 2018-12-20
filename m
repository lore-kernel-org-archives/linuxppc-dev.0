Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A6AC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 05:19:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C37720869
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 05:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="MntpbJIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C37720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L0RY0RlrzDqrm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 16:19:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="MntpbJIx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="MntpbJIx"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L0Nq5Fb3zDqKg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 16:16:43 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id a14so301074plm.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 21:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DWDJ8Em7wHs3TJ0GFe2Bu7hF2N/+eHuKwAfeYaJX8ss=;
 b=MntpbJIxkX4sLTHkpIu4argz0bCTGZbTJvTlquq1nV81UaJ3XoObat9DKoOmHu2P1x
 I0HX8moiLQDXudHJMmgy+WitRveH5QDJ6pnd3dGaHkkuIQHk1NyLz2Ri8wP26ZotURje
 1hnrz3pOpAp5iqPJD8bItdnbueRomf3XnQJy9plxMJDYZcwFsihv8Ovw52gwBRBdJcDV
 8kxiPd1tXJCQboGvl5iVu9Bq6PRDXVv85tqEjyM1zLPQUPB3Q205CgCKRU5XKanhBwf2
 7KLExKRptp+7vr7EfEHASbr5dE8Tp12wp7rEKJU7QjvK9S4jY49Puge1UjbjVPTAcNer
 7pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DWDJ8Em7wHs3TJ0GFe2Bu7hF2N/+eHuKwAfeYaJX8ss=;
 b=Gj0KywfiozKRrwAhswpKD7Ak6eN1clEMP8wNjbqUNlOuvWoelom34kTsX5/blG0WRe
 FjluGK8Kyq69jsZknzgZX+xWd82zSHBUfTlAQbK6rH2Jwv84g4LA2lVK4Oq/rwUQzRt+
 oYZ6rLW3gxJJmNz9RS0ZJ+aI2SKpSXe2DE0iG90je6P/iZyEO8RN5FOXjCPHKiEkacvj
 e8Be0fIaptxW6x6VuTIetnh7Ocl1Thtj2fuHpkqHW6iFjCpls+SM4AoukrHhG4SfDEO1
 5vkNUARPB5nEze95FtUGb9sQ5KOxV/bKjQDkdUkK3zr6nKiSeHMlXxNnum631G3UerAF
 aJ4Q==
X-Gm-Message-State: AA+aEWaUHOxQrDNLF9FvQKYdkwHLwNIkvjNpZwth6UQJfQYuQxxBCJ+d
 4JC2xjKp4zzarX16XMHTnWnArARzbK8=
X-Google-Smtp-Source: AFSGD/V2UAq0lT5lym6Hoa3GIoLh14cetuRqFe10/XmJfzLjSbfG/kdZksZsyBQxW+MP4pEuA9cMeA==
X-Received: by 2002:a17:902:2468:: with SMTP id
 m37mr22855448plg.314.1545283001116; 
 Wed, 19 Dec 2018 21:16:41 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id v62sm34146901pfd.163.2018.12.19.21.16.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 21:16:40 -0800 (PST)
Subject: Re: [PATCH V5 2/3] powerpc/mm/iommu: Allow migration of cma allocated
 pages during mm_iommu_get
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
 mpe@ellerman.id.au, paulus@samba.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20181219034047.16305-1-aneesh.kumar@linux.ibm.com>
 <20181219034047.16305-3-aneesh.kumar@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <a766bcac-272d-c028-ad58-8d31dddddbd1@ozlabs.ru>
Date: Thu, 20 Dec 2018 16:16:33 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219034047.16305-3-aneesh.kumar@linux.ibm.com>
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
> Current code doesn't do page migration if the page allocated is a compound page.
> With HugeTLB migration support, we can end up allocating hugetlb pages from
> CMA region. Also THP pages can be allocated from CMA region. This patch updates
> the code to handle compound pages correctly.
> 
> This use the new helper get_user_pages_cma_migrate. It does one get_user_pages
> with right count, instead of doing one get_user_pages per page. That avoids
> reading page table multiple times.
> 
> The patch also convert the hpas member of mm_iommu_table_group_mem_t to a union.
> We use the same storage location to store pointers to struct page. We cannot
> update alll the code path use struct page *, because we access hpas in real mode

s/alll/all/


> and we can't do that struct page * to pfn conversion in real mode.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/mm/mmu_context_iommu.c | 120 ++++++++--------------------
>  1 file changed, 35 insertions(+), 85 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> index 56c2234cc6ae..1d5161f93ce6 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -21,6 +21,7 @@
>  #include <linux/sizes.h>
>  #include <asm/mmu_context.h>
>  #include <asm/pte-walk.h>
> +#include <linux/mm_inline.h>
>  
>  static DEFINE_MUTEX(mem_list_mutex);
>  
> @@ -34,8 +35,18 @@ struct mm_iommu_table_group_mem_t {
>  	atomic64_t mapped;
>  	unsigned int pageshift;
>  	u64 ua;			/* userspace address */
> -	u64 entries;		/* number of entries in hpas[] */

Still a valid comment imho, or you could s'hpas'hpas/hpages' but
replacing hpas with hpages seems strange.


> -	u64 *hpas;		/* vmalloc'ed */
> +	u64 entries;		/* number of entries in hpages[] */
> +	/*
> +	 * in mm_iommu_get we temporarily use this to store
> +	 * struct page address.
> +	 *
> +	 * We need to convert ua to hpa in real mode. Make it
> +	 * simpler by storing physicall address.

s/physicall/physical/


> +	 */
> +	union {
> +		struct page **hpages;	/* vmalloc'ed */
> +		phys_addr_t *hpas;
> +	};
>  };
>  
>  static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
> @@ -78,63 +89,14 @@ bool mm_iommu_preregistered(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
>  
> -/*
> - * Taken from alloc_migrate_target with changes to remove CMA allocations
> - */
> -struct page *new_iommu_non_cma_page(struct page *page, unsigned long private)
> -{
> -	gfp_t gfp_mask = GFP_USER;
> -	struct page *new_page;
> -
> -	if (PageCompound(page))
> -		return NULL;
> -
> -	if (PageHighMem(page))
> -		gfp_mask |= __GFP_HIGHMEM;
> -
> -	/*
> -	 * We don't want the allocation to force an OOM if possibe
> -	 */
> -	new_page = alloc_page(gfp_mask | __GFP_NORETRY | __GFP_NOWARN);
> -	return new_page;
> -}
> -
> -static int mm_iommu_move_page_from_cma(struct page *page)
> -{
> -	int ret = 0;
> -	LIST_HEAD(cma_migrate_pages);
> -
> -	/* Ignore huge pages for now */
> -	if (PageCompound(page))
> -		return -EBUSY;
> -
> -	lru_add_drain();
> -	ret = isolate_lru_page(page);
> -	if (ret)
> -		return ret;
> -
> -	list_add(&page->lru, &cma_migrate_pages);
> -	put_page(page); /* Drop the gup reference */
> -
> -	ret = migrate_pages(&cma_migrate_pages, new_iommu_non_cma_page,
> -				NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE);
> -	if (ret) {
> -		if (!list_empty(&cma_migrate_pages))
> -			putback_movable_pages(&cma_migrate_pages);
> -	}
> -
> -	return 0;
> -}
> -
>  long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
>  		struct mm_iommu_table_group_mem_t **pmem)
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
> -	long i, j, ret = 0, locked_entries = 0;
> +	long i, ret = 0, locked_entries = 0;
>  	unsigned int pageshift;
>  	unsigned long flags;
>  	unsigned long cur_ua;
> -	struct page *page = NULL;
>  
>  	mutex_lock(&mem_list_mutex);
>  
> @@ -181,41 +143,24 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
>  		goto unlock_exit;
>  	}
>  
> +	ret = get_user_pages_cma_migrate(ua, entries, 1, mem->hpages);

btw get_user_pages_cma_migrate() name suggests me (yeah, not a native
speaker and an ignorant person in general :) ) that it migrates and pins
pages while it can actually pin pages without migrating them (if it
could not).


> +	if (ret != entries) {
> +		/* free the reference taken */
> +		for (i = 0; i < ret; i++)
> +			put_page(mem->hpages[i]);
> +
> +		vfree(mem->hpas);
> +		kfree(mem);
> +		ret = -EFAULT;
> +		goto unlock_exit;
> +	} else

Missing curly braces.

> +		ret = 0;
> +
> +	pageshift = PAGE_SHIFT;
>  	for (i = 0; i < entries; ++i) {
> +		struct page *page = mem->hpages[i];

An empty line here.

>  		cur_ua = ua + (i << PAGE_SHIFT);
> -		if (1 != get_user_pages_fast(cur_ua,
> -					1/* pages */, 1/* iswrite */, &page)) {
> -			ret = -EFAULT;
> -			for (j = 0; j < i; ++j)
> -				put_page(pfn_to_page(mem->hpas[j] >>
> -						PAGE_SHIFT));
> -			vfree(mem->hpas);
> -			kfree(mem);
> -			goto unlock_exit;
> -		}
> -		/*
> -		 * If we get a page from the CMA zone, since we are going to
> -		 * be pinning these entries, we might as well move them out
> -		 * of the CMA zone if possible. NOTE: faulting in + migration
> -		 * can be expensive. Batching can be considered later
> -		 */
> -		if (is_migrate_cma_page(page)) {
> -			if (mm_iommu_move_page_from_cma(page))
> -				goto populate;
> -			if (1 != get_user_pages_fast(cur_ua,
> -						1/* pages */, 1/* iswrite */,
> -						&page)) {
> -				ret = -EFAULT;
> -				for (j = 0; j < i; ++j)
> -					put_page(pfn_to_page(mem->hpas[j] >>
> -								PAGE_SHIFT));
> -				vfree(mem->hpas);
> -				kfree(mem);
> -				goto unlock_exit;
> -			}
> -		}
> -populate:
> -		pageshift = PAGE_SHIFT;
> +
>  		if (mem->pageshift > PAGE_SHIFT && PageCompound(page)) {
>  			pte_t *pte;
>  			struct page *head = compound_head(page);
> @@ -233,7 +178,12 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
>  			local_irq_restore(flags);
>  		}
>  		mem->pageshift = min(mem->pageshift, pageshift);
> +		/*
> +		 * We don't need struct page reference any more, switch
> +		 * physicall address.

s/physicall/physical/


> +		 */
>  		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
> +

Unnecessary empty line.


>  	}
>  
>  	atomic64_set(&mem->mapped, 1);
> 

-- 
Alexey
