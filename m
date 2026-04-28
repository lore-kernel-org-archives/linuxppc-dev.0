Return-Path: <linuxppc-dev+bounces-20217-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CEBFF886F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 07:31:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4XDj32dDz2xld;
	Tue, 28 Apr 2026 17:31:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777361493;
	cv=none; b=K7fiYNVRGSvxQv5Zk3hRNihl0T6yUAllP4XYoobeNLKRIhKz3RFUhxtLdwJkN9Kbh1F1DfHVurWCXRblATly4CCUny1xVnIHCebq2uLIxdMXn5ptNfTMwEujHnRFL1NdfUpCLnwev8B8jWnb+gBkVfxGZKwQefpokk+umNnkCO1/TL8wRTUWb6BqoUYpaDZr3ChxA3VRDPA/a6Duix5w7HfgzhPqciDgiO6uiLqkHJxEewn1g4xvPKEDPgCSjs4Getmx9e+kaa4HbUp26w2NScJFuRKz1USNpFoh/8adZVod3F4BW/sIHsRG4F794fmI6bdgQUx3FdQmhM3Qbk6CPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777361493; c=relaxed/relaxed;
	bh=WMWWXBt0H8FUH6gYap1afdCvnPjjFas3H4vg06N54js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVBquZt/wGGsK27KfJ8imrtaNCIn0EIV99rmNLmuk/zK9qDdiUY9iVix05NUcWEFfg27a5UpqjEf8gALJ/mjjzOIU8G44eVf4YTlm7BYAHYSEAVp4rwVoH/w5Yj7+/gPSXGWNTU8bF9HR156Uwh6YFZwUXpxsBQEOrJhMSwxA1vn7FTVKFJNoqSA6doxnmyVBCfyyVrJ67ZozPiKoVTssfstzzTTe7B2FdoG0CsCcbiynZADjVUsK00ZI55aDhb+xb2gj/jVVnIv4THuldizZt3JD5gZwEqxjrRNUXhaCwkoJRo0TBZcun3Ee4QtRZwuBqxjTYnCKZYrVai7dklWNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CVnvaBDj; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CVnvaBDj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4XDg5ptjz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 17:31:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8116840026;
	Tue, 28 Apr 2026 07:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E87C2BCAF;
	Tue, 28 Apr 2026 07:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777361488;
	bh=xV2f8Ehs2QX5rw4Q715j9yMyngPX6sqnJ8NY9F+asyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVnvaBDjTn1o/2v+QpYU3O6WYRNiAGm6NTsiljZtdtji+vqLHyVPkdVCxi4Iapy7t
	 K7nq9Ja+qgzkDp1c2i9Cl1jy2e3n52hTs0YML53u33P6lUVheDejIwYxxLgcBph/k7
	 UW23Rrs5VQPJrX0E1nR8rRESg1bZVPaAmABbWZcQNpW9cs80rCvI9vARmwviKhHPzr
	 FwAki4R9DE7zxLfsAPqlOV9/xMkksNpCcSYybRwNPmbMv3lA1KHU7kC8wZRE6lkmIX
	 iTSLl1NfNuhTXTvtmJLzoYc2maxXL2mhT1LsUE9fKOFytdhw0gJDZG642O5hI+GJZS
	 uRyV/MwreZrtw==
Date: Tue, 28 Apr 2026 09:31:18 +0200
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
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: Re: [PATCH 08/49] mm: Convert vmemmap_p?d_populate() to static
 functions
Message-ID: <afBiRvBPx4Vm5ECs@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-9-songmuchun@bytedance.com>
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
In-Reply-To: <20260405125240.2558577-9-songmuchun@bytedance.com>

On Sun, Apr 05, 2026 at 08:51:59PM +0800, Muchun Song wrote:
> From: Chengkaitao <chengkaitao@kylinos.cn>
> 
> Since the vmemmap_p?d_populate functions are unused outside the mm
> subsystem, we can remove their external declarations and convert
> them to static functions.

I think this is already merged
 
> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> ---
>  include/linux/mm.h  |  7 -------
>  mm/sparse-vmemmap.c | 10 +++++-----
>  2 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bebc5f892f81..aa8c05de7585 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4860,13 +4860,6 @@ unsigned long section_map_size(void);
>  struct page * __populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
>  		struct dev_pagemap *pgmap);
> -pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
> -p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
> -pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
> -pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
> -pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
> -			    struct vmem_altmap *altmap, unsigned long ptpfn,
> -			    unsigned long flags);
>  void *vmemmap_alloc_block(unsigned long size, int node);
>  struct vmem_altmap;
>  void *vmemmap_alloc_block_buf(unsigned long size, int node,
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index d3096de04cc6..0ee03db0b22f 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -151,7 +151,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
>  			start, end - 1);
>  }
>  
> -pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
> +static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
>  				       struct vmem_altmap *altmap,
>  				       unsigned long ptpfn, unsigned long flags)
>  {
> @@ -195,7 +195,7 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
>  	return p;
>  }
>  
> -pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
> +static pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
>  {
>  	pmd_t *pmd = pmd_offset(pud, addr);
>  	if (pmd_none(*pmd)) {
> @@ -208,7 +208,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
>  	return pmd;
>  }
>  
> -pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
> +static pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
>  {
>  	pud_t *pud = pud_offset(p4d, addr);
>  	if (pud_none(*pud)) {
> @@ -221,7 +221,7 @@ pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
>  	return pud;
>  }
>  
> -p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
> +static p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
>  {
>  	p4d_t *p4d = p4d_offset(pgd, addr);
>  	if (p4d_none(*p4d)) {
> @@ -234,7 +234,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
>  	return p4d;
>  }
>  
> -pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
> +static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
>  {
>  	pgd_t *pgd = pgd_offset_k(addr);
>  	if (pgd_none(*pgd)) {
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

