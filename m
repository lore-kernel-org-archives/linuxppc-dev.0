Return-Path: <linuxppc-dev+bounces-28655-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8749CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 14:43:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwZQd6zS9z2yTQ;
	Fri, 02 Oct 2026 00:43:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790865785;
	cv=none; b=E/mI5L2ImSl8PFzebTWdzZFc8FLNGH6MJzdA4TY/JmoId2Ge89L9dMqRomX5/pNB0QpUKLejfy6+L61YaMnHbMoPSs9N9Z8RU9a+ZPmst1Rw++IVkzy6M9SiBpaYpbtgJGx/kEEDCFJW5h9nIBelL2z2wRnBn86nqIzv4XNuIgnua+si121qSUdXdVhDJ0dWvwyh35hF32JB32m95HvgMV3lmCp5Y0mwfupzHGOXSPskCLeEsivT3YwWmNMg7yE5/n+Mo3/SNsi+hEivWtv0qJxw4jXzRDMATgJiXG9SQgCeKi7OeLMMxU9gcL88+Pz3O+IrjTXjKCX3yPNPr+h76A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790865785; c=relaxed/relaxed;
	bh=mE8ugBn4aBPJ3MiNkA50lNnSRYdI1uITSgWQ30TMfOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSgdMKeKPBH5HQ6GpMUnkC4wlFk9cWLOz4Gt+g7FzDkEr6vLgBCzGVEJAwRFybRabgDhWGw24Eth+sRDYLTwkvUix70s5g3+qElDOC842447p7mvrVNLCILNhFdZyo6+XMj5E6UQTcr1HnjyOlpmSsr2VuK1VtRPVS5TMXkSPNoIMlgifHqlyMtfO8h3caCA+UgBJJ1O8Yp3PWtW2C4ug1xk5r5JAzgXOqtVkR9PCup91tJ8ZERRYh/B45nDEV4BAQRaXuuJQ/HQ6VuKotO6TefT4gvMmrixTIAJE1qOlGEipteLQip6gLSP09anAwp5dWhtHTogXuuDa8DNLcayiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATQ8I74B; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATQ8I74B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwZQc6bkxz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 00:43:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9DB916022E;
	Thu,  1 Oct 2026 14:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AFF1F000FF;
	Thu,  1 Oct 2026 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865781;
	bh=mE8ugBn4aBPJ3MiNkA50lNnSRYdI1uITSgWQ30TMfOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ATQ8I74BR/BF6dUU++SXaq7I6Ck1VUK8xU6ciYD+3Yq9OVtY7acRBm1+vz/B65lHl
	 DF1YRe85C4R5RAMbAtbtHRrR80IEigqMuLFCyhcR+AaFk1VSlQYZZu5BQrNbBURuMG
	 syBdLUPqfXrl80oACFAlymuTJazq0Cmj7BieKQYbiPoqoedYOIm/PDYpnFoe8B0WJn
	 z84v0wjUNNjYIsznTbXcj79Q1zEf3omB7I/CvLt4BkMPUk1Kv0LziIJUwOuu5NevHH
	 aHlJHZZutXIab/4oxymEt5BTLNWAW1l1MJHo/BdxL+viezsQ9ccvB921pMRlzrwjff
	 MLpY18Z/6cO9w==
Date: Thu, 1 Oct 2026 16:42:53 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev
Subject: Re: [PATCH v3 6/6] mm/mm_init: add zone mismatch warning during page
 init
Message-ID: <ar5xbQsUpSQZg0wO@kernel.org>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
 <20260929053231.66085-7-songmuchun@bytedance.com>
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
In-Reply-To: <20260929053231.66085-7-songmuchun@bytedance.com>

Hi Muchun,

On Tue, Sep 29, 2026 at 01:32:31PM +0800, Muchun Song wrote:
> For vmemmap-optimized sections, tail struct pages may be backed by
> shared vmemmap pages. Those shared pages must carry the same page zone
> ID as the struct pages initialized for the section.
> 
> Warn in __init_single_page() if the shared tail page has a different
> page_zone_id(), which would indicate inconsistent initialization.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Qi Zheng <qi.zheng@linux.dev>
> ---
> v3:
> - Collect Acked-by from Qi Zheng
> 
> v2:
> - New patch.
> ---
>  mm/mm_init.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 1650d6bc1211..bd02e8d06965 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -609,6 +609,9 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
>  	if (!is_highmem_idx(zone))
>  		set_page_address(page, __va(pfn << PAGE_SHIFT));
>  #endif
> +	VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)) &&
> +			page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=
> +			page_zone_id(page));

Hmm, page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES is initialized a tad later
than page so it'll have stale data in the page->flags, won't it?

>  }
>  
>  #ifdef CONFIG_NUMA
> -- 
> 2.54.0
> 

-- 
Sincerely yours,
Mike.

