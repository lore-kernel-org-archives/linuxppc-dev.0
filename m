Return-Path: <linuxppc-dev+bounces-19778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB17F4384E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 15:53:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwm035CPzz2yvh;
	Thu, 16 Apr 2026 01:53:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776268419;
	cv=none; b=PuAILboV8Dy1nSux+dJHl2W5N+KLFn4P/2r3c0D56gQPpi5LnMtPqMvAtHeGu5Ckh1LqohjAT/gb18uKm4Q2QESxRFZSM3irzBIvJc1Bv4HnlZc6k2JjizHya7zJ4jjKqKv6QSQ7sZTsXS6lkvSD287XorXUuI3CO4ScAsHSHiqN+M6Ieg/uu9MAm1ySfwwUdrNWNm6dH3B670WNB8CDy6ljQ0NsYowWeWZ/QTOnpLyoSctbBDwuVToRXNO+VJYFNW/dPsGXSM28NEiVXggrhWsUvpFm8Nzf1EQivBtr8QhebIbmdBV1TZyCabpXgyF3n0MUn0SI0IA63QtE/16G0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776268419; c=relaxed/relaxed;
	bh=2Eah7MTKP3MQv1T3pNJu3Q/x/mQvB0bQiXwPwwnBgAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8LoaFdJLEYgjm5CQ4V7rntCAysbssFHYxcKVIKdb+ga5J3NQz4zzsWFCrjGr+yEx0q6tIwLVNXfj7OFtxC9gdDuo4O1nbwOp/2AIxbOKF5E+Uk1qZd8Bf8n4R1/uGBTO4KPgY8Ati0T+rcosDmWOt8KBoW6af6rnK4rW8qkMcaw1jxP4Uvp5ObFAZ1VCzlSnx3MkNlbk5JjgoJtgeZql4Zv6OClKXZTea9+F+dmMEkAwHsOFZdrNS74l0vA2x3M98h59WCnrvQkmSMErqv8oV/0/x4EI87X2jlS7qB3i4tzYGXvxoanz5WPFhCk6aVzSGY8uCkNyujK02I6WkWmQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DlGLUOug; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DlGLUOug;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwm023lrcz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 01:53:38 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EB0BB600AE;
	Wed, 15 Apr 2026 15:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A646C19424;
	Wed, 15 Apr 2026 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776268415;
	bh=pF5Ty1TKfbXQTKmLGalKXImAXtzwkULsJDc+vi4BCZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlGLUOuga1MKiMMANQa+Xk/NacVG+N3rBbJfCtnyo19AEl1tE+4MksQOwjbEhbhPp
	 jW7SzH/5Nyz1ZO+tC4wvPydch5UTMHICyGDxlOJm3ceDJeRhFvHkZ+8+LsUtLzoyhz
	 32fmq9wPfWG550vpxwBSqtJPFwaqyFBz7UFdwAH7je4GAH6yNHCNBfXGpn+pPkFSwb
	 bx8T3rxSf1V08O+tncqh6acRwlEE0HsKP0+zmeWypjdet9c+vb+WXyd9YyI4LRlEoe
	 Zdr9LirARf4S4xVxQIGPC3feUCBDloz+XHbrlXpQK1a912jqlO4/aLE6DCRJa98/Lt
	 DPukwP+gwpx0A==
Date: Wed, 15 Apr 2026 18:53:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mm/sparse-vmemmap: Fix vmemmap accounting
 underflow
Message-ID: <ad-0dcuaoC9LKDEF@kernel.org>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
 <20260415111412.1003526-2-songmuchun@bytedance.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415111412.1003526-2-songmuchun@bytedance.com>

On Wed, Apr 15, 2026 at 07:14:07PM +0800, Muchun Song wrote:
> In section_activate(), if populate_section_memmap() fails, the error
> handling path calls section_deactivate() to roll back the state. This
> causes a vmemmap accounting imbalance.
> 
> Since commit c3576889d87b ("mm: fix accounting of memmap pages"),
> memmap pages are accounted for only after populate_section_memmap()
> succeeds. However, the failure path unconditionally calls
> section_deactivate(), which decreases the vmemmap count. Consequently,
> a failure in populate_section_memmap() leads to an accounting underflow,
> incorrectly reducing the system's tracked vmemmap usage.
> 
> Fix this more thoroughly by moving all accounting calls into the lower
> level functions that actually perform the vmemmap allocation and freeing:
> 
>   - populate_section_memmap() accounts for newly allocated vmemmap pages
>   - depopulate_section_memmap() unaccounts when vmemmap is freed
>   - free_map_bootmem() handles early bootmem section accounting
> 
> This ensures proper accounting in all code paths, including error
> handling and early section cases.
> 
> Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/sparse-vmemmap.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 6eadb9d116e4..a7b11248b989 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -656,7 +656,12 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
>  		struct dev_pagemap *pgmap)
>  {
> -	return __populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
> +	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
> +						      pgmap);
> +
> +	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
> +
> +	return page;
>  }
>  
>  static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
> @@ -665,13 +670,17 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
>  	unsigned long start = (unsigned long) pfn_to_page(pfn);
>  	unsigned long end = start + nr_pages * sizeof(struct page);
>  
> +	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
>  	vmemmap_free(start, end, altmap);
>  }
> +
>  static void free_map_bootmem(struct page *memmap)
>  {
>  	unsigned long start = (unsigned long)memmap;
>  	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
>  
> +	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
> +						  PAGE_SIZE)));
>  	vmemmap_free(start, end, NULL);
>  }
>  
> @@ -774,14 +783,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	 * The memmap of early sections is always fully populated. See
>  	 * section_activate() and pfn_valid() .
>  	 */
> -	if (!section_is_early) {
> -		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
> +	if (!section_is_early)
>  		depopulate_section_memmap(pfn, nr_pages, altmap);
> -	} else if (memmap) {
> -		memmap_boot_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page),
> -							  PAGE_SIZE)));
> +	else if (memmap)
>  		free_map_bootmem(memmap);
> -	}
>  
>  	if (empty)
>  		ms->section_mem_map = (unsigned long)NULL;
> @@ -826,7 +831,6 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>  		section_deactivate(pfn, nr_pages, altmap);
>  		return ERR_PTR(-ENOMEM);
>  	}
> -	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
>  
>  	return memmap;
>  }
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

