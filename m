Return-Path: <linuxppc-dev+bounces-19975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8AFFA1FDC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 18:50:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g17ZW4dftz2yrT;
	Thu, 23 Apr 2026 04:50:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776883811;
	cv=none; b=GCUaWvRKdCBtz+C1lXRRq8igmVb787SyjLzI80RLlmBeADE49oWXyn96NBQishX7HnHm/SjcDVt9CpMvj3732TiSXfwo9MmLHSZWdRcWihQbszfE65JtWSBb5YbYJmziP6mI+/McrkRNZVq8A9ZMbYpxTbkoKsFHW4k7Gg/NIX3xPfQmTYWAzFm77knokhxqaJPsZByPWIHQQMTAQAz5B/F7LMXKaicq1JxpqoDO/oApHtXTU2Vp2Ukuj54UIkxT9OBhSAHdSabdIEv1CemBkLWZ2s5bHVEEvpKvs+Fr93wAHdhL2QEW7x1ZwfDgwVNaBSVREmLEejgUzT6jYqn1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776883811; c=relaxed/relaxed;
	bh=qZaiM8bKBuZYKvp/hTxAUTVFeOQL9tY9dSkdiXcaXBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFXMWtB3DiyAVTZpJ0FJaEsEteiUJgN4bcdpHpPKFxlvipmk8/oY8VdQlYiDpNAkIP/ylA5LRURMphtZ4HhkiTfbXfWZO7JO351Zm5nqykEd2oWgrJMPYol0G6OKTQupIcOG3gds1URZw5EMU61khcpPObAvrITO7QCknBxjSEAbrXdWfpzOj+Zzd/fxRgW/Fk67Dx0e+ZVRXc5x8V386TLzOGaiTvQPxoN3OcCrNpSEwQ9rbkluxFcw4JpO8y75hxaTwppzuzBe0Y5EAQoppt7tYGlEx9cV9g84ywhFfyRTz6F1oHHZ8vf9pGMuzGX5YgvAn64hBTapEFxhz0DyQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jAIEDdzG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jAIEDdzG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g17ZV5SlFz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 04:50:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 114CC61863;
	Wed, 22 Apr 2026 18:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699E5C19425;
	Wed, 22 Apr 2026 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776883807;
	bh=PRcbGxXVn+TWgBm3sJFNt59RhR0CP0MQw5XEPliYcQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jAIEDdzGdEaHrvn5Xd7STmKTqm2T2XldfKWf5vr0ekqMtSHo7neA4GPJOpSpAKReh
	 AVfcLMYPCX3nOo0zR5EXdg1pzyLrIWBnabYXWq3JWmbjCENqcfEYf7r8a4aV6Tm08D
	 NvDc/HPGXvpY71v1PFiDinN5YTj5l3MecrA6ECCgNmUv4Buj/v/1G4laqTeiuhP59B
	 WXUgLoMux/zvVz+cg+87dFOgivzib+43+gFcQ6NsGZrZqccbs6i4nZn85v1GrCA8em
	 Jg9oUKp+p6iv7RIYmUK3oP6XvMH4Bk/5ijGblcim242hF1pOGxXPlMUqmbUMMqA6vV
	 Heg5sYvMCi5Hg==
Message-ID: <fc80afb9-6e97-481f-8136-d684ff3690a7@kernel.org>
Date: Wed, 22 Apr 2026 20:50:00 +0200
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
Subject: Re: [PATCH v4 2/5] mm/sparse-vmemmap: Pass @pgmap argument to memory
 deactivation paths
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
References: <20260422081420.4009847-1-songmuchun@bytedance.com>
 <20260422081420.4009847-3-songmuchun@bytedance.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260422081420.4009847-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 10:14, Muchun Song wrote:
> Currently, the memory hot-remove call chain -- arch_remove_memory(),
> __remove_pages(), sparse_remove_section() and section_deactivate() --
> does not carry the struct dev_pagemap pointer. This prevents the lower
> levels from knowing whether the section was originally populated with
> vmemmap optimizations (e.g., DAX with vmemmap optimization enabled).
> 
> Without this information, we cannot call vmemmap_can_optimize() to
> determine if the vmemmap pages were optimized. As a result, the vmemmap
> page accounting during teardown will mistakenly assume a non-optimized
> allocation, leading to incorrect memmap statistics.
> 
> To lay the groundwork for fixing the vmemmap page accounting, we need
> to pass the @pgmap pointer down to the deactivation location. Plumb the
> @pgmap argument through the APIs of arch_remove_memory(), __remove_pages()
> and sparse_remove_section(), mirroring the corresponding *_activate()
> paths.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>


[...]

>  static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
> -		struct vmem_altmap *altmap)
> +		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>  {
>  	unsigned long start = (unsigned long) pfn_to_page(pfn);
>  	unsigned long end = start + nr_pages * sizeof(struct page);
> @@ -746,7 +746,7 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>   * usage map, but still need to free the vmemmap range.
>   */
>  static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> -		struct vmem_altmap *altmap)
> +		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>  {
>  	struct mem_section *ms = __pfn_to_section(pfn);
>  	bool section_is_early = early_section(ms);
> @@ -784,7 +784,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	 * section_activate() and pfn_valid() .
>  	 */
>  	if (!section_is_early)
> -		depopulate_section_memmap(pfn, nr_pages, altmap);
> +		depopulate_section_memmap(pfn, nr_pages, altmap, pgmap);
>  	else if (memmap)
>  		free_map_bootmem(memmap);
>  
> @@ -828,7 +828,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>  
>  	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
>  	if (!memmap) {
> -		section_deactivate(pfn, nr_pages, altmap);
> +		section_deactivate(pfn, nr_pages, altmap, pgmap);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> @@ -889,13 +889,13 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  }
>  
>  void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
> -			   struct vmem_altmap *altmap)
> +			   struct vmem_altmap *altmap, struct dev_pagemap *pgmap)

While at it, could switch to two-tab indent here as well.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David

