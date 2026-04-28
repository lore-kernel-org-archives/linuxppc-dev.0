Return-Path: <linuxppc-dev+bounces-20208-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC870FF886F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 06:57:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4WSs3kWyz2ynv;
	Tue, 28 Apr 2026 16:57:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777359421;
	cv=none; b=X74VWohcigK9LuPnk/8Qubc8bdOb3F9kPBVmbBXfFnpDf14B0NA0iADdC2FFdwtbH9xvZKL5QkeV3lu/NHzhsL5vkMIaJMFjT1DkkDJTpRWXVWIuaWtsqtUChhrpkOMq4yoSNe6/ailTC/GREoxkbTgdzZfGN+xRysSmb8cSE2TTmavdrT6EXtqUFeCamBhQjJEP12B7LVRojwjYWC6d+7WXitx8QgBCUC+d9WY/PlEXjjMHc0Futbs5eK3yAeVdzvNKMqxpFbtVTyhan04BUTvMARWeP5qU8PLUu1kFZPvhomgb3d0XwhHMjtcit9HbiL/mpjKteLw1TqJGUQkkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777359421; c=relaxed/relaxed;
	bh=pN8lwMEMUKE6fLRDbfBi5SwwXfSZd6/phLXUVKiAbUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OetdMxLcCH5PPabXqahehqkIq43/g5qH2Y8CJYu+8EGiUfurDD0FZSk/KIeK9mSheVjyp2YQiGuvNANGYTFpdBJAiZDYTKu6bajbG3dQUZgiRlq1zq9AQOJHui7dHxG32eU5RcCaS/dCegmGQ32O1ahaMyksd8UYUF8UkmiDokDho/3BXKMbAtUPGFfu4NdPdoEBT4buVcFJ7b3drm8JgF2Sf1QPPqN/zHwSPweTfbsEs3W65nBueqxDt87vsUjf3aD4QyPNNER7CLGiHhxytGKU/+GisWUzrdWXlKHBP6FqI0oSq/r7IG3cxGrfeRE0SIfAH9cMDlcReh2lZ31MtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rhDcpnNh; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rhDcpnNh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4WSr2MKhz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 16:57:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A9B2437AA;
	Tue, 28 Apr 2026 06:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9236AC2BCB6;
	Tue, 28 Apr 2026 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777359418;
	bh=1V4TENqnFf/Ppcn/URrmHTYv7JS1tp4lOcKYXeX/qQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rhDcpnNhXg3VFM3rIQ8P9HEfk7yNT1kNtmGQA//PASZJYF5qFVLU3rJQKIjHPMvMe
	 HNf+ZqUWVIec+QOX6efzQXIJgyVTzJ3SajalcZfX9oSShcsx1S6liBquLNTUSEkPWh
	 4Cyc/D7lLdtCoLQMQXAl64utOCjpMSIyeJ8zLhZtFS5/mgoy0dRpWXclxIvDKnysUq
	 SpCE7vcf08EM3C8UiLJLQfn69JGz6zNVXPFlXdd3w/0cNuTpygcfyKvh5PaIqr59MO
	 bLVRmTTn9+akih5Vt7HEV1f7qS8w3zDaa2o4t4+vuoIOLVGu4TF+GObYA5jWj8WQ8M
	 JqMpETW6OQY+A==
Date: Tue, 28 Apr 2026 08:56:48 +0200
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
Subject: Re: [PATCH 09/49] mm: panic on memory allocation failure in
 sparse_init_nid()
Message-ID: <afBaMEBoR_35Fblc@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-10-songmuchun@bytedance.com>
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
In-Reply-To: <20260405125240.2558577-10-songmuchun@bytedance.com>

On Sun, Apr 05, 2026 at 08:52:00PM +0800, Muchun Song wrote:
> When vmemmap pages allocation or usemap allocation fails, sparse_init_nid()
> currently only marks the corresponding section as non-present. However,
> subsequent code like memmap_init() iterating over PFNs does not check for
> non-present sections, leading to invalid memory access (additional,
> subsection_map_init() accessing the unallocated usemap as well).
> 
> It is complex to audit and fix all boot-time PFN iterators to handle these
> partially initialized sections correctly. Since vmemmap and usemap allocation
> failures are extremely rare during early boot, the more appropriate approach
> is to expose the problem as early as possible.
> 
> Therefore, use BUG_ON() to panic immediately if allocation fails, instead of
> attempting a partial recovery that leads to obscure crashes later.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/sparse.c | 37 ++++++++-----------------------------
>  1 file changed, 8 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index effdac6b0ab1..5c12b979a618 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -354,19 +354,15 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>  				   unsigned long map_count)
>  {
>  	unsigned long pnum;
> -	struct page *map;
> -	struct mem_section *ms;
> -
> -	if (sparse_usage_init(nid, map_count)) {
> -		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
> -		goto failed;
> -	}
>  
> +	if (sparse_usage_init(nid, map_count))
> +		panic("The node[%d] usemap allocation failed\n", nid);

Please consider using memblock_alloc_or_panic() in sparse_usage_init(), it
would simplify the code even more.

>  	sparse_buffer_init(map_count * section_map_size(), nid);
>  
>  	sparse_vmemmap_init_nid_early(nid);
>  
>  	for_each_present_section_nr(pnum_begin, pnum) {
> +		struct mem_section *ms;
>  		unsigned long pfn = section_nr_to_pfn(pnum);
>  
>  		if (pnum >= pnum_end)
> @@ -374,16 +370,12 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>  
>  		ms = __nr_to_section(pnum);
>  		if (!preinited_vmemmap_section(ms)) {
> +			struct page *map;
> +
>  			map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
> -					nid, NULL, NULL);
> -			if (!map) {
> -				pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
> -				       __func__, nid);
> -				pnum_begin = pnum;
> -				sparse_usage_fini();
> -				sparse_buffer_fini();
> -				goto failed;
> -			}
> +							nid, NULL, NULL);
> +			if (!map)
> +				panic("Populate section (%ld) on node[%d] failed\n", pnum, nid);
>  			memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
>  							   PAGE_SIZE));
>  			sparse_init_early_section(nid, map, pnum, 0);
> @@ -391,19 +383,6 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>  	}
>  	sparse_usage_fini();
>  	sparse_buffer_fini();
> -	return;
> -failed:
> -	/*
> -	 * We failed to allocate, mark all the following pnums as not present,
> -	 * except the ones already initialized earlier.
> -	 */
> -	for_each_present_section_nr(pnum_begin, pnum) {
> -		if (pnum >= pnum_end)
> -			break;
> -		ms = __nr_to_section(pnum);
> -		if (!preinited_vmemmap_section(ms))
> -			ms->section_mem_map = 0;
> -	}
>  }
>  
>  /*
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

