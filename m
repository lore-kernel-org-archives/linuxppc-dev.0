Return-Path: <linuxppc-dev+bounces-21696-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C205CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 08:33:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc7J2M03z2yQH;
	Fri, 29 May 2026 18:33:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780043580;
	cv=none; b=UTZ4Fs9N8LMh9Mh61FhzQA0bd9p6VK0olDabdVCQRpmC2SDrO+M7ydi6c2e9Vpsa6iDd9/O/7Vii8g1bNXjHCMIGivkKfXjaqW1l76Z3RbAAa6HprEkO03V9DW/CAVVHrlh4PCTUwT1VWK+H0OCVeREjOwzCEP7EeusZZJMJiDxJ54EctekwsYpAze5Ctk0j3iw8B9LOnwSqw5yi1o8FCA4W5k/AZ0Qg469w/ts2hPlBwLL+lYetVHDyR19LYyI5WK56IVNPPXWzBf37dNrcsVJ+1tq/nW/6MoMpoFY84NJKAgbRQ9Pi45VyQ/6oxIPTfvMyd5EU9KIZuQGfxwHOag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780043580; c=relaxed/relaxed;
	bh=KjvwXdqEq/+1DficM1XZTTUKhCSP4ds5mbTs0wcBq4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGx+rn7SL7HJJb00xm1ttTRiySlwaXIAkPQ+murzG9cP/GI9n9kHBOeUJ4z8tHRLf+4tiCm7A2FNJekP6+eNuEbgakjhckSKC25q8SJKUjLrAvzUR4wMncKSLOm9n74Y50J2es2hfjEjqJvSlKZqGKpmJNnJgYKwD9r85ZqQE9KhThUYm+LQBqkaP+xCGPjbrBw5tnPDPzAkzMqR+4FiHAFomITZ9bYPd7/ojg/ojnZMo9mokIfTLlmDLlTUC/P1Ofy7gMLguQaKkUmk8UdSVqfdOUjCHzEOsmbAqmgg+q6GzpnLRNLBVXSsEb4OVLJJ+Svt/JdAyo6VJjMXLw+9Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YgZNzICf; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YgZNzICf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc7H2CdHz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 18:32:59 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22C0E202C;
	Fri, 29 May 2026 01:25:13 -0700 (PDT)
Received: from [10.57.91.162] (unknown [10.57.91.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E033B3F632;
	Fri, 29 May 2026 01:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780043118; bh=fE3yUIKV893yO/tU1IRXNu65M0GI1yHd4oHW0SZSKMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YgZNzICfhAaEewMLd5sYOiMJ/3HYuhCaubt55GtmzGsIIRiS2/eSAIgolKHy6Ujas
	 R1Xu42Al/6MwTK6QYWiT9p5q5f4DsYTTmioLV5ywaNJQ05OfFjqw8JRvuf3tckys1N
	 E28dqI6faiZItNHpvu6iRQgocCCB1jlpG25489Os=
Message-ID: <23aaeb97-104c-4010-9525-d80922c434c0@arm.com>
Date: Fri, 29 May 2026 10:25:10 +0200
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
Subject: Re: [PATCH v6 07/15] arm64: kfence: Avoid NOMAP tricks when mapping
 the early pool
To: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-24-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260526175846.2694125-24-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2026 19:58, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Now that the map_mem() routines respect existing page mappings and
> contiguous granule sized blocks with the contiguous bit cleared, there
> is no longer a reason to play tricks with the memblock NOMAP attribute.
>
> Instead, the kfence pool can be allocated and mapped with page
> granularity first, and this granularity will be respected when the rest
> of DRAM is mapped later, even if block and contiguous mappings are
> allowed for the remainder of those mappings.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 25 ++++----------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d7a6991e1844..55bb40348a47 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1083,36 +1083,24 @@ static int __init parse_kfence_early_init(char *arg)
>  }
>  early_param("kfence.sample_interval", parse_kfence_early_init);
>  
> -static phys_addr_t __init arm64_kfence_alloc_pool(void)
> +static void __init arm64_kfence_map_pool(void)
>  {
>  	phys_addr_t kfence_pool;
>  
>  	if (!kfence_early_init)
> -		return 0;
> +		return;
>  
>  	kfence_pool = memblock_phys_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
>  	if (!kfence_pool) {
>  		pr_err("failed to allocate kfence pool\n");
>  		kfence_early_init = false;
> -		return 0;
> -	}
> -
> -	/* Temporarily mark as NOMAP. */
> -	memblock_mark_nomap(kfence_pool, KFENCE_POOL_SIZE);
> -
> -	return kfence_pool;
> -}
> -
> -static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool)
> -{
> -	if (!kfence_pool)
>  		return;
> +	}
>  
>  	/* KFENCE pool needs page-level mapping. */
>  	__map_memblock(kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
>  			pgprot_tagged(PAGE_KERNEL),
>  			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> -	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
>  	__kfence_pool = phys_to_virt(kfence_pool);
>  }
>  
> @@ -1144,8 +1132,7 @@ bool arch_kfence_init_pool(void)
>  }
>  #else /* CONFIG_KFENCE */
>  
> -static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
> -static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool) { }
> +static inline void arm64_kfence_map_pool(void) { }
>  
>  #endif /* CONFIG_KFENCE */
>  
> @@ -1155,7 +1142,6 @@ static void __init map_mem(void)
>  	phys_addr_t kernel_start = __pa_symbol(_text);
>  	phys_addr_t kernel_end = __pa_symbol(__init_begin);
>  	phys_addr_t start, end;
> -	phys_addr_t early_kfence_pool;
>  	int flags = NO_EXEC_MAPPINGS;
>  	u64 i;
>  
> @@ -1172,7 +1158,7 @@ static void __init map_mem(void)
>  	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end) &&
>  		     pgd_index(_PAGE_OFFSET(VA_BITS_MIN)) != PTRS_PER_PGD - 1);
>  
> -	early_kfence_pool = arm64_kfence_alloc_pool();
> +	arm64_kfence_map_pool();
>  
>  	linear_map_requires_bbml2 = !force_pte_mapping() && can_set_direct_map();
>  
> @@ -1210,7 +1196,6 @@ static void __init map_mem(void)
>  	 */
>  	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
>  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> -	arm64_kfence_map_pool(early_kfence_pool);
>  }
>  
>  void mark_rodata_ro(void)

