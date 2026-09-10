Return-Path: <linuxppc-dev+bounces-27012-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5DBC79FB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 07:53:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgVKj6b7nz2yFK;
	Thu, 10 Sep 2026 17:53:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789026809;
	cv=none; b=JxL3na3EeJEdur7yWoBd6GuTyxlcFBTtP+WO+lrGs8SW4DSdLKJlH/tcyt34B6z9nbGFVD3dyo6KVtmjdNjJksocFr3EsV0rtJvg4TUJtErFY5o9RBwAeGJTFFAp57E6HY1XY2eF8s82HT2Txjnt/ElQ2wIs6/Sd90G8NhABmzxj9jPso/+cusYbLd/Rx15heUdn9u4hEyhEIhHORLdCUEzOJTIVHwGQlqvBm+KcNis9dT8CZyE/qWeImRxWwA/SE9o96uDKtqSmHzks65km0D10vXRPgSDaUKMAU0VtLsXTfGyxTOAro6Q/+ZHmgIjjqv7plvlGtjwV1A0qgAQSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789026809; c=relaxed/relaxed;
	bh=KRB916lj3l/kaoIROZgvEq5UY1QI+PbW3M7goiEHvOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofIaHebiFm+tXOmhfGHjYCO9szpBp0nMj+pNQt0pIGMkt8p9omPu7tnyQ+w2eei/dxzObTaZeYT7xTJ0FhOfu3q0LUP7d2TkKv2lZkRpfEfVZvYSZXbc28twtxIoD5IaJ9pEKYWSoz1IEe+uzSYFYkHzjBciA6u3cpzY7sBEk8VDmI2VH1D3zqmZ0nwWhBsabOxdrGE+c9YLhBY0DmDxmoIu0uHjvQa8apbyhDkLmojCnnnuzVgVDoeeXJD9y/rq9PtYHm2V+5HYRnTvKjj6dppx5OPFJh3tQBg/HqmV9eH2znjUQvgjEOXoqvhIHa09G3O07wsMXZb1m2XWiwec+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhV9mmVJ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhV9mmVJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgVKh5lwdz2y2S
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 17:53:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8CD00601EF;
	Thu, 10 Sep 2026 07:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5A31F0089A;
	Thu, 10 Sep 2026 07:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789026805;
	bh=KRB916lj3l/kaoIROZgvEq5UY1QI+PbW3M7goiEHvOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PhV9mmVJj8HaWPabBYhvMSsgZMBm/iNmNrVKbOAwBrvBUDAS3kQzPqHIsoQoErIZ+
	 kUhMB7AiLoWxhuQwHEtRsLJ+TcYl/HFfQkIH0iosT9Vlfk/ZtkRrN7667NE1qNLDHA
	 3AWysrlhQkVoPGtjqmN2K0E1FN0qTC1lIjb5S6M3W7UXsmbTNfwG4r9hY0DDdOA4r9
	 39KEZ4ww4zwmSXesWcJRj8jYzQ6s5AlQXWTz5KJiYZ7+480u/c5Ev5cs/GMeJ6Ikl5
	 m+vjuqsmPW9pRo8g5Hx1mk/LubFTe1VuqHcmHEu7leARLCHxOafE/t+y+DHmEzvslm
	 eEdS7mvZL1hnw==
Message-ID: <b803e45f-76c2-44bd-a913-9ce310319f41@kernel.org>
Date: Thu, 10 Sep 2026 09:50:26 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] mm/sparse-vmemmap: open-code
 init_compound_tail()
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
 <20260908030335.96549-4-songmuchun@bytedance.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260908030335.96549-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 05:03, Muchun Song wrote:
> init_compound_tail() is only used by vmemmap_shared_tail_page(), where
> the shared tail page setup intentionally passes NULL as the compound head.
> 
> Keeping this helper in mm/internal.h exposes that special case to the rest
> of the MM code and can make the NULL head argument look generally valid.
> Open-code the initialization at the only call site so the special-case use
> stays local to sparse vmemmap optimization.
> 
> No functional change intended.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Qi Zheng <qi.zheng@linux.dev>
> ---
> v2:
> - Collect Acked-by from Qi Zheng
> ---
>  mm/internal.h       | 9 ---------
>  mm/sparse-vmemmap.c | 5 ++++-
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index da14c56fb24e..0dca33db068f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -786,15 +786,6 @@ static inline void prep_compound_tail(struct page *tail,
>  	VM_WARN_ON_ONCE(tail->private);
>  }
>  
> -static inline void init_compound_tail(struct page *tail,
> -		const struct page *head, unsigned int order, struct zone *zone)
> -{
> -	atomic_set(&tail->_mapcount, -1);
> -	set_page_node(tail, zone_to_nid(zone));
> -	set_page_zone(tail, zone_idx(zone));
> -	prep_compound_tail(tail, head, order);
> -}
> -
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>  
>  /*
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 70143dd8b579..e453ce4675a0 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -189,7 +189,10 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
>  	for (int i = 0; i < PAGE_SIZE / sizeof(struct page); i++) {
>  		page = (struct page *)addr + i;
>  		mm_zero_struct_page(page);
> -		init_compound_tail(page, NULL, order, zone);
> +		atomic_set(&page->_mapcount, -1);
> +		set_page_node(page, zone_to_nid(zone));
> +		set_page_zone(page, zone_idx(zone));
> +		prep_compound_tail(page, NULL, order);
>  	}
>  
>  	page = virt_to_page(addr);

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David

