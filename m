Return-Path: <linuxppc-dev+bounces-19715-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE31F531C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 18:39:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvbmk2bwbz2yv7;
	Tue, 14 Apr 2026 04:39:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776105590;
	cv=none; b=gucSYuFwF5UNOxFtc06kJR4D6aRNcqaCc4BRQZD+r3cnshPtff1gVS0BRTV8G0FSB7iF589ZbC7MDvHS2yWbk7AkGhxn5PxYmB+MxdBaV41MTWQjOO350AiGGXLIfxuf7YIGMzBCHovdtZ1198uw21GZbLWc3/nOoQqwpbuOL77laVql0XcrQlqVH/fYpsiNWlZ6jiY/lxWHYRjaCzLOddmy2WS1vd7NDha70abTIjC18trGX7vmcL3gd6ySDUKNIlUcC7+6Y3zyQvS+mrMr7wwhcLHiU/q3PHNWoVoP4uqRFLoEvw0eEfILH3sYHsU1KaD2oLAvCtP0msDV/8AsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776105590; c=relaxed/relaxed;
	bh=O/hrFqndwJtN2pq3357Wgsw7hOLsXaP6RS7BTWcmses=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iP8U0HmmfjxPM/n/LGhTHDqTlxoddVJBK4TUEN8Rdhru8qKWwc9YIJUH3WaVNSIwaQ3d0urvVWCpYcw0oYIBNBplBlZt6rgTYUrl+O1+7YHeKXY6ogKPyW/U4DcI7IPmGbb6bWmLbqlq0+VKD3xRGfuvMBCsi2HJNFq8MOUQ1VO8rBzLsk+m4qkhq6debqhK7IODW2angSd3I4J8ZjhNTD1HwSp/svxMbyHhus6bbxpF/jjupYnFH/q2VIGcbeENDs1Z8MnQWps+cc3/SJ6qLpwYDO7/o7Di3NRsQW9/vk3/j3nPiqt8xBpDc7jOKuWAq1pHU/OjThOK6vuTzyiTsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AEDQuqIW; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AEDQuqIW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvbmj3Vq4z2yv4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 04:39:49 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 393256183B;
	Mon, 13 Apr 2026 18:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5133C2BCAF;
	Mon, 13 Apr 2026 18:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776105586;
	bh=RLos5eu/k4OkgzYUfoZ0rIuWLWwHtGR4/FZoPNAg1WQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AEDQuqIWbNe2wApXlo2hjS3KG2iI6BUI+d43CmYsPxHWaB0Xp8Q1CmWRyCuOn8AOR
	 W80aa/DJ0JML556anny4PaJf9/qzUrMUVKV9x0G1GtM/65FxhvZ0/Tbzegg01cq40G
	 Tt9HzrLP+eNfs6t5Z6lhSxABkcKSOAV1G7nUqN2Us5kpYLAonYwjinOGRledZE+tMI
	 bncp1C6Hpjq3PX0gSCkdiWcgJ1HKr+CKtiDQG6H3UhpmJCLRXy5NOGIPXNUVq2sxcY
	 eSp629TYMGMXrJJ9oEibCVRH3n47w9cuFeSL7xNReoqqr2qoGyLd7/tbatyAz2KaDd
	 3RJ8Gg4R8bbsA==
Message-ID: <d44ff75a-a1bd-4a28-8e8b-0b008d24d41b@kernel.org>
Date: Mon, 13 Apr 2026 20:39:37 +0200
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
Subject: Re: [PATCH 03/49] mm/sparse: fix vmemmap page accounting for HVOed
 DAX
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com, joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-4-songmuchun@bytedance.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260405125240.2558577-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/26 14:51, Muchun Song wrote:
> When HVO is enabled for DAX, the vmemmap page accounting is wrong since
> it only accounts for non-HVO case.
> 
> Fix the accounting by introducing section_vmemmap_pages() that returns
> the exact number of vmemmap pages needed for the given pfn range.

I guess only the accounting in /proc/meminfo is messed up, correct?

> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")

Similarly, please send all fixes out separately.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/sparse-vmemmap.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 7aa9a97498eb..0ef96b1afbcc 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -724,6 +724,27 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  	return rc;
>  }
>  
> +static int __meminit section_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
> +					   struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
> +{
> +	unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
> +	unsigned long pages_per_compound = 1L << order;
> +
> +	VM_BUG_ON(!IS_ALIGNED(pfn | nr_pages, min(pages_per_compound, PAGES_PER_SECTION)));
> +	VM_BUG_ON(pfn_to_section_nr(pfn) != pfn_to_section_nr(pfn + nr_pages - 1));

No new VM_BUG_ON. Ever. :)

VM_WARN_ON_ONCE() is your friend.

> +
> +	if (!vmemmap_can_optimize(altmap, pgmap))
> +		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
> +
> +	if (order < PFN_SECTION_SHIFT)
> +		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
> +
> +	if (IS_ALIGNED(pfn, pages_per_compound))
> +		return VMEMMAP_RESERVE_NR;
> +
> +	return 0;
> +}
> +
>  /*
>   * To deactivate a memory region, there are 3 cases to handle:
>   *
> @@ -775,11 +796,12 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	 * section_activate() and pfn_valid() .
>  	 */
>  	if (!section_is_early) {
> -		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));

That's nice to be factored out in any case.

-- 
Cheers,

David

