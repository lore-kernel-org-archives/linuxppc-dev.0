Return-Path: <linuxppc-dev+bounces-27656-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8941C88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 06:14:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmMm51vQFz2y2W;
	Fri, 18 Sep 2026 16:14:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789712085;
	cv=none; b=kAcB9xM0MlJ/PSrjofbGNClVeQB9pDGMEwzJoB0d9/LSyTh8p3/Jx4NhxIhO+zs3AS/WI+pTmAMyit+1nT4ak7HlYFzNM8tGjqQ+NjvZW+4vJuOC46DDW3W0eF5Pe6UVwyCZCvwVyhQk9e6ODvXJdLZBjQr9ETQg1npt/7PYMpCKAxuPV5a84s60o/rqKcQD3EQW1tURYDO4dyx6uISj+s+6P+0UHUPIca0RAQhc7FtO+2GgF4rrm7s9Ry20dQNAaxRgu8a8ivGZN4CUTg4DHHcKJbGZXQQI3PrERE5YfWJqu4sYZ+oWgt5gjfScOeGNR6i7Nu7Ze0yq9pN6Q8I9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789712085; c=relaxed/relaxed;
	bh=QW/2OE6ihA5SygTL3ENfiEwrR7oH0H/ao5/23GWCpoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrsiFqKb+tb9KyqPDClWBdFYaxlCq0w7KiHr6gvRWIH9w6ditEUZJZg7u6yD6tySewnX1iY6pITjqhIzwp39UsQvm/0m6DtZEooKKQ185R35phyLoYxgOJmfJOFeFeuYTJdca9TOqMYcDmqDGIxeePCGVCek6jtLVVPisF9J/JebuaLCqS+LsujUy7IewKp/xT188yczs5fd0mTD/K1TzCTc4H8t1UP8tMqy15dK1QdUAwxz6MUl9WF3gcSsJfPZgN1uM2Pq0lYK2ymGyEznjnBYw3wqHGtI2vwsUCHjgQE7HK1EYUrOJUMaAyYz6QNnKMlKA1ZO1OhkfCSKAhZCog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otP3upcn; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otP3upcn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmMm428vDz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 16:14:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B07CF41326;
	Fri, 18 Sep 2026 06:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD641F000FF;
	Fri, 18 Sep 2026 06:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789712081;
	bh=QW/2OE6ihA5SygTL3ENfiEwrR7oH0H/ao5/23GWCpoA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=otP3upcnF/PdMiljpfNt/pX7FBoUKThHlCjIOr4ocBN6YGLnvSzlu4n4le8nm2m7D
	 J/1HVEoYxd8AcLxccybfuBhL80HWwXeUPJvd1Z/eehiCpYux1nFjpGhm6yrNQgu8mk
	 f+m6E0/s7mYEkF49Oszhalv+9kvFP7F/rqUG+K4Y0rdY8Vvn63HPWeF2zBiTD1/Sx5
	 mMzOWD/fTEin1uB3zArAhRrJKlWnf5LFsp8Z5vr/I89NtAVxUmdYf4kKIpIxXxbgO1
	 n0EPKP0fHl/M+i3enV0AeM1z4tLsVDuOGqxUknUuhzdO8FlxTF7Yu8Ro735NFVk6hc
	 QB6YMAcTcHNIQ==
Message-ID: <58e3b456-7389-4752-8de5-1cc82964c3c7@kernel.org>
Date: Fri, 18 Sep 2026 08:14:31 +0200
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
Subject: Re: [PATCH v8 02/10] powerpc/8xx: add pte_set_huge()
To: Wen Jiang <jiangwenxiaomi@gmail.com>, akpm@linux-foundation.org,
 catalin.marinas@arm.com, linux-mm@kvack.org, urezki@gmail.com,
 will@kernel.org
Cc: Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, anshuman.khandual@arm.com,
 baohua@kernel.org, david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com,
 leo.yan@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
 ryan.roberts@arm.com
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
 <20260917052933.188679-3-jiangwenxiaomi@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260917052933.188679-3-jiangwenxiaomi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/09/2026 à 07:29, Wen Jiang a écrit :
> From: Wen Jiang <jiangwen6@xiaomi.com>
> 
> vmap installs PTE-level block mappings (SZ_16K/SZ_512K on powerpc/8xx)
> by reusing set_huge_pte_at(), a HugeTLB helper gated by
> CONFIG_HUGETLB_PAGE. This makes the feature silently unavailable on
> CONFIG_HUGETLB_PAGE=n kernels and couples mm/vmalloc.c to HugeTLB
> internals it does not otherwise need.
> 
> Add pte_set_huge() to powerpc/8xx, next to the existing
> pmd_clear_huge()/pud_clear_huge() in mm/nohash/8xx.c. It builds the huge
> PTE and writes it into the backing cells directly, without going through
> set_huge_pte_at(), so it does not depend on CONFIG_HUGETLB_PAGE.
> 
> No pte_clear_huge() is needed: 8xx does not implement
> arch_vmap_pte_range_unmap_size(), so the vmap unmap path never takes the
> block-mapping branch.
> 
> In practice PPC_8xx selects HUGETLBFS unconditionally, so
> CONFIG_HUGETLB_PAGE=n does not occur there today; this is a decoupling
> cleanup rather than a new configuration.

8xx selects CONFIG_HUGETLB_PAGE because it uses set_huge_pte_at() to map 
kernel text with large pages. That was added by commit 34536d780683 
("powerpc/8xx: Add a function to early map kernel via huge pages")

But now pte_set_huge() could be used instead in 
__early_map_kernel_hugepage() and then CONFIG_HUGETLB_PAGE could be removed.

> 
> There is no caller yet: mm/vmalloc.c is converted later in this series,
> once the generic fallbacks are in place.
> 
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/include/asm/nohash/32/pte-8xx.h |  4 +++
>   arch/powerpc/mm/nohash/8xx.c                 | 29 ++++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> index e2ea8ba9f8cae..1ee3f8f0de974 100644
> --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> @@ -235,6 +235,10 @@ static inline pte_t ptep_get(pte_t *ptep)
>   }
>   #endif /* CONFIG_PPC_16K_PAGES */
>   
> +#define __HAVE_ARCH_PTE_SET_HUGE
> +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
> +		  pgprot_t prot, unsigned long size);
> +
>   #endif
>   
>   #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
> index a9d3f4729eada..2518d2a6bdb41 100644
> --- a/arch/powerpc/mm/nohash/8xx.c
> +++ b/arch/powerpc/mm/nohash/8xx.c
> @@ -220,3 +220,32 @@ int pmd_clear_huge(pmd_t *pmd)
>   {
>   	 return 0;
>   }
> +
> +/*
> + * vmap PTE-level block mapping. Sets a present kernel mapping directly,
> + * so unlike set_huge_pte_at() it needs neither CONFIG_HUGETLB_PAGE nor
> + * set_pte_filter() (a no-op for non-exec kernel mappings).
> + */
> +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
> +		  pgprot_t prot, unsigned long size)
> +{
> +	pmd_t *pmdp = pmd_off(&init_mm, addr);
> +	pte_t pte = pfn_pte(PHYS_PFN(phys), prot);
> +	pte_basic_t val;
> +	pte_basic_t *entry = (pte_basic_t *)ptep;
> +	int num, i;
> +
> +	pte = arch_make_huge_pte(pte, ilog2(size), 0);
> +	val = pte_val(pte);
> +
> +	/*
> +	 * Make sure hardware valid bit is not set. We don't do
> +	 * tlb flush for this update.
> +	 */
> +	VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));
> +
> +	num = number_of_cells_per_pte(pmdp, val, 1);
> +
> +	for (i = 0; i < num; i++, entry++, val += SZ_4K)
> +		*entry = val;
> +}


