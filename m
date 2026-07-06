Return-Path: <linuxppc-dev+bounces-23629-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBBCC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:57:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv4Bx1GJrz3bby;
	Mon, 06 Jul 2026 22:57:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783332461;
	cv=none; b=R/BAGdoHqZ2jMmGc0fXvmBTBkgVJUCzvvQrLcWdk8ra7/ijJuYwtrbwrsNBTYUShXgRKmB2JjHfKck7WaNDr7BHTf/8wVftoRL2+s+zwOk+nX9o+BB1DVoIsNwN7KZiXwy7ZJB5f6o3d4Y9cjzkdE/BSuNviPX2IIfFcuLIuZAiHglu4ghSFAiDhFT5tMyvoElv0oKyndHcNGVblEbS15qgAa1WoduRwRhq+eWJe81cRrDX5rmf6YxlEtnavqu/bdYoBZ+Rt/stNhjAMMkTRcinR090j5t4N+4ShDsbPElDwbtmDuBDypWspkPLvONmVI3hIzyJ+PN/xZgIBqxJgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783332461; c=relaxed/relaxed;
	bh=XV8hLM1BVaZzJ2YbfALYkq3xi+MgnRUgQHg6QJiWrc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bR/vn9idx2UOvwTovp03hB1C8pn4PseN76b7XXgu7RHb1kykdxweEjv80LYRJdt+SpGyZ3cYekXt+TDzdQhSp1GWr6lZP06cfEkZAjQT+JNAlQGv4WGiUTh7BgZlUQ1hphRgerZncumMc7h/utqO+6DxB4IvxuCvcTjkuTkGsKEaZ0DPgZPSgvZ3eoaYy6vA7CHBOglilotgQPHMBzHujtbxV/2ncKeBF+FYnPJTmn4XadC7ug8UQBgKrNNhsQ6NbHORHA2eRXhdtKJ4Nx51SWSkf0ICQVUkz+t/xfzPELo6uLfO8mrr58SxpZtPSbmKjU25yZiDMn2myLbcL+/oAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Iz/DDVJc; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=mclapinski@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Iz/DDVJc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=mclapinski@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv0Qz0PMxz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 20:07:38 +1000 (AEST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so53529a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783332450; x=1783937250; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XV8hLM1BVaZzJ2YbfALYkq3xi+MgnRUgQHg6QJiWrc4=;
        b=Iz/DDVJcy9pp1xHJFCGDY1uU3jvIDMq0J+vYz/NQtKXcDjLrcnLbAHFCDSIBI9m7eE
         VQ8LjmyfOqxyXu66pB7ocBiIIPryRaC0PIKKbyjzpFN68OO4RMNsSQ/iD+8jM0+RyVYT
         7eQSriniesO8g94Rp9DIG4aFAxfq3jFhjMtAmXAdyvRHpmUUsaE2/UMVLAFb4jTvAzBu
         bhdlHBsMpApabAGNRE6FJeLwOk15qZ41Xmuk0aXW4H66N/1GDco9xv9LutkOGk934EWf
         sLGDNp6w+N25k9UCHGyBULlTxOsAXSCUqvUlZ8Ua4vuiUMwdfSZCHPkXMz1/aRB64T7I
         AwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783332450; x=1783937250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XV8hLM1BVaZzJ2YbfALYkq3xi+MgnRUgQHg6QJiWrc4=;
        b=fr/1OU0DNnv5NG7Mh9YaE2PmGsM/6hvDacGXNYNO+q04UJ42ay6jl0Ou8nZ2xVeICZ
         XicpLrd2YPuH5avk0USQgWevRFyp2aWxybrRfR571fUxC4RNy6O4zmyv7kPafSUwRX0c
         3dKxOuqwAZTEAaixCP5VaAuVmyt/6Vy+/fbNk9rR/hPsLMZfywy+uX1Na7HK9DkwjKF9
         5IY0985Fx949SM5o6aRmphnGe183KQLP1ckOij11VeaEBRK43e5fZlccCcNXCWjJ98Wo
         WoLVeNz/LrMiQyYrWikoKlzhZ5R5dWcZwPPZflALQlzqmS1VuEJBzbW0Q7YXY4JC/YDd
         N4jA==
X-Forwarded-Encrypted: i=1; AHgh+Ronq8jB6BWbFGFM1IiDOQpH5fIi+oOIpRIr/aRn8+5bTCgm25Uv0IYZZoqZ+u9uJx0YVltiPv9mHWevV7Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw7y2Ls8xFUr8HNoEYTqIT8x120qPoMfOfSyQl42ix2uiARdtzG
	CSKCquIkGyDXlKjwV1h+x6BOxGmR+G4sp9nBZBRrXQOxCkoI3yROGtFxmjYOogkx42BZ4rSen9P
	t/DiIrXlLz9o=
X-Gm-Gg: AfdE7cmD47jadWw6YqRr7xc9aAe77YdL0Eov5fcQTLiSgiithstmd6lOc21He9dqPAn
	lgOO2tQCxQuVjhdOOp5mi2+iQKudJcmxyOiBU04nWJ8sdNU5lW+5aQUdrgaO169B6xXBv9JDEGH
	AA7W9QHgfpESHfpzX8RtIfAJde2J5DmVTXmSHKAX+mqItMmb/S7H+m6rV73VvBmXZtLAa66KyAZ
	39ECqx4dzxiAFbux7S7yCu1uabD4czJ4LnMwtkzCd37bF6JapvHFuRH2fcQOB55Tz8jIITPkZ78
	pwZgMPF88NtYgW5gWKy0DSEbqvSg6Wyr7fjgP4E/IjB9daoZ3s057Gs42W/BEOBs2RoPIJjP356
	WVbegTs73+vNND56zScMR83MRTgcUivzSVCqGGVhIlxluRngsz1aXLb9S15udkfuHAkJPH6EuDd
	nNX+795fxsWsEylpeva+Up/DYnMfTdNNiiT+f/9qgYpXCQaAEdOCKg0oKynOMbIfB6z6uvAcyZX
	SoECimEaqxZMpUGQeSL
X-Received: by 2002:aa7:d9d2:0:b0:698:59af:fb08 with SMTP id 4fb4d7f45d1cf-69a19ca26d1mr52807a12.4.1783332449904;
        Mon, 06 Jul 2026 03:07:29 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2890:d:9f2c:a127:989c:b6af? ([2a00:79e0:2890:d:9f2c:a127:989c:b6af])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62c552esm710227466b.49.2026.07.06.03.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:07:29 -0700 (PDT)
Message-ID: <b4b200da-f510-4fe2-95ac-c63e4467c4bd@google.com>
Date: Mon, 6 Jul 2026 12:07:27 +0200
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
Subject: Re: [PATCH v4 01/19] mm/hugetlb: Fix boot panic with CONFIG_DEBUG_VM
 and HVO bootmem pages
To: Muchun Song <songmuchun@bytedance.com>, Oscar Salvador
 <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani
 <ritesh.list@gmail.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Mike Kravetz <mike.kravetz@oracle.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
 <20260612035903.2468601-2-songmuchun@bytedance.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
In-Reply-To: <20260612035903.2468601-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/26 5:58 AM, Muchun Song wrote:
> Commit 622026e87c40 ("mm/hugetlb: remove fake head pages") switched
> HVO to reuse per-zone shared tail pages from zone->vmemmap_tails[].
> 
> Those shared tail pages were initialized in hugetlb_vmemmap_init(), but
> bootmem HugeTLB folios are prepared earlier from gather_bootmem_prealloc().
> With hugetlb_free_vmemmap=on, prep_and_add_bootmem_folios() can access
> pageblock flags on bootmem HugeTLB pages whose mirrored tail struct pages
> already point to the shared tail page. On CONFIG_DEBUG_VM kernels,
> get_pfnblock_bitmap_bitidx() then dereferences the still-uninitialized
> shared tail page and can panic during boot.
> 
> Initialize zone->vmemmap_tails[] from gather_bootmem_prealloc(), before
> bootmem HugeTLB folios are processed, and drop the later initialization
> from hugetlb_vmemmap_init().
> 
> This bug only affects CONFIG_DEBUG_VM kernels, where the relevant
> assertion is evaluated.
> 
> Fixes: 622026e87c40 ("mm/hugetlb: remove fake head pages")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/hugetlb.c         | 25 +++++++++++++++++++++++++
>   mm/hugetlb_vmemmap.c | 17 -----------------
>   mm/sparse-vmemmap.c  |  2 +-
>   3 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 571212b80835..cd55524c7e30 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3365,6 +3365,31 @@ static void __init gather_bootmem_prealloc(void)
>   		.max_threads	= num_node_state(N_MEMORY),
>   		.numa_aware	= true,
>   	};
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +	struct zone *zone;
> +
> +	for_each_zone(zone) {
> +		for (int i = 0; i < NR_VMEMMAP_TAILS; i++) {
> +			struct page *tail, *p;
> +			unsigned int order;
> +
> +			tail = zone->vmemmap_tails[i];
> +			if (!tail)
> +				continue;
> +
> +			order = i + VMEMMAP_TAIL_MIN_ORDER;
> +			p = page_to_virt(tail);
> +			/*
> +			 * prep_and_add_bootmem_folios() can access pageblock
> +			 * flags on bootmem HugeTLB pages, so initialize the
> +			 * shared tail struct pages here before bootmem folios
> +			 * start using them.
> +			 */
> +			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
> +				init_compound_tail(p + j, NULL, order, zone);
> +		}
> +	}
> +#endif

I think it would be better if this was located in mm/hugetlb_vmemmap.c 
as a separate function.

>   
>   	padata_do_multithreaded(&job);
>   }
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 133b46dfb09f..c713c0d2593a 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -870,27 +870,10 @@ static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
>   static int __init hugetlb_vmemmap_init(void)
>   {
>   	const struct hstate *h;
> -	struct zone *zone;
>   
>   	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
>   	BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
>   
> -	for_each_zone(zone) {
> -		for (int i = 0; i < NR_VMEMMAP_TAILS; i++) {
> -			struct page *tail, *p;
> -			unsigned int order;
> -
> -			tail = zone->vmemmap_tails[i];
> -			if (!tail)
> -				continue;
> -
> -			order = i + VMEMMAP_TAIL_MIN_ORDER;
> -			p = page_to_virt(tail);
> -			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
> -				init_compound_tail(p + j, NULL, order, zone);
> -		}
> -	}
> -
>   	for_each_hstate(h) {
>   		if (hugetlb_vmemmap_optimizable(h)) {
>   			register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 99e2be39671b..bb23fb3077a3 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -342,7 +342,7 @@ static __meminit struct page *vmemmap_get_tail(unsigned int order, struct zone *
>   	 *
>   	 * Any initialization done here will be overwritten by memmap_init().
>   	 *
> -	 * hugetlb_vmemmap_init() will take care of initialization after
> +	 * gather_bootmem_prealloc() will take care of initialization after
>   	 * memmap_init().
>   	 */
>   

It gets the job done.

Tested-by: Michal Clapinski <mclapinski@google.com>
Reviewed-by: Michal Clapinski <mclapinski@google.com>


