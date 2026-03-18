Return-Path: <linuxppc-dev+bounces-18357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5E4103E183
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 14:17:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbW9c0C2kz2yjV;
	Thu, 19 Mar 2026 01:17:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773843427;
	cv=none; b=cHf3sYPxzr3SH3P5vmaL3JMvYCBypIUTduaM97ftIAH7Z+04ALooVB/IIXoEjx9Xp7Rrua1TCyGljs/N+H2TypBWdBLeCRMtWbx8/xB1ks1b+4UYzyzj+vmePc/KSbIOSgg9UiLySgMIzJh3PrOv/BgCzjEdDTTnYFFlGTsTaeWs6dmPCu4ellhzxSTl2KvSXzN+dIBpdFtCGZNfoZJRzfoeYWzYTtL2MTuZjJhOPuk4hHbHpoNINk/mkda0BwIHj2pubYsP3W0i+MRs2G/M4LMf7e/M0KQkqheJKvEoKt9XTApDF4mHqpoeKlWyIRiyZPnO9JkZYuoLgz84soDANw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773843427; c=relaxed/relaxed;
	bh=5FZ5QXHUzU1ata4VbBabv3m2vQppMp/lSd5sxHdN7Sc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N939veBQxatFmpXWpX7cBzhpg7gQsrWuU14wC364QGqt/EL2QlpO2eHbSOIxUKQyKki+Z3ZgpqgJozUIhKrRiRyL8WxsWncbsW/jla8LfYtPqPC4fiWjmRNPIkQROSy3JQ1yxdNqdOg/6ACphiApLeqNalz/qH8QcTJ55SF2Z1Qvir5fcjfzplkQy0erMGsLRtsnF5jd4LY+5E7ZYcL7KqcScksSx2WFvYTYRwEAoLndw3Q+g6MyWHTqHfWXsvgK/hHojWeC9y9ZHQ7bsxp4Lf2dGISv33sHVXcyX11TMAE8x6nLZJaoAe6h8VJrLo0maDIxsGPwYSOh66/POEoYeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l2n98eIW; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l2n98eIW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbW9Z6KZXz2ygd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 01:17:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BCAC7415F6;
	Wed, 18 Mar 2026 14:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B834CC19421;
	Wed, 18 Mar 2026 14:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773843423;
	bh=Nka2tAu2xfrAzh/LVz+kPzjJGV26abtbTSAN+jQ1zCs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=l2n98eIWgaO3CjkFjgd0Sou85/DdxxIF5f5x0NNXjCnRCCUzjcWJiinkayJ878aww
	 BMJ0pXZVJUefOLLhpj2fMemzle19sO2O1t5wBOu4oWg54p9ZGJdEhdeS/Czy9hnQXA
	 eulz6Qr5rpmd86XRFktfVxpPiPuG0bWwvXiusqCzjYmb/h8nhtFZfXIiV7SJql6pbr
	 L4xv+2VnZl426NR2cd+2lb906X8FppURSFBE0mng0zk5Fvon36cCbedPT6Sf5MOPBk
	 nKWZjGbed3op7zsa/QhDxrRfMTA0/5KlsKm4GWT7flFR84ReuRSkL4lH9ODOoxK1Dd
	 vepd5z1nkYYfQ==
Message-ID: <11428d25-7bea-4be6-a6ee-bfeac1d50807@kernel.org>
Date: Wed, 18 Mar 2026 15:16:52 +0100
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
From: Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH 3/8] mm: move free_reserved_area() to mm/memblock.c
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Andreas Larsson <andreas@gaisler.com>, Ard Biesheuvel <ardb@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <jackmanb@google.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian Brauner <brauner@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Marco Elver <elver@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Saravana Kannan <saravanak@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Will Deacon <will@kernel.org>, Zi Yan <ziy@nvidia.com>,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, x86@kernel.org
References: <20260318105827.1358927-1-rppt@kernel.org>
 <20260318105827.1358927-4-rppt@kernel.org>
In-Reply-To: <20260318105827.1358927-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 11:58, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> free_reserved_area() is related to memblock as it frees reserved memory
> back to the buddy allocator, similar to what memblock_free_late() does.
> 
> Move free_reserved_area() to mm/memblock.c to prepare for further
> consolidation of the functions that free reserved memory.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


> ---
>  mm/memblock.c   | 37 ++++++++++++++++++++++++++++++++++++-
>  mm/page_alloc.c | 36 ------------------------------------
>  2 files changed, 36 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b3ddfdec7a80..8f3010dddc58 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -893,6 +893,42 @@ int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
>  	return memblock_remove_range(&memblock.memory, base, size);
>  }
>  
> +unsigned long free_reserved_area(void *start, void *end, int poison, const char *s)
> +{
> +	void *pos;
> +	unsigned long pages = 0;
> +
> +	start = (void *)PAGE_ALIGN((unsigned long)start);
> +	end = (void *)((unsigned long)end & PAGE_MASK);
> +	for (pos = start; pos < end; pos += PAGE_SIZE, pages++) {
> +		struct page *page = virt_to_page(pos);
> +		void *direct_map_addr;
> +
> +		/*
> +		 * 'direct_map_addr' might be different from 'pos'
> +		 * because some architectures' virt_to_page()
> +		 * work with aliases.  Getting the direct map
> +		 * address ensures that we get a _writeable_
> +		 * alias for the memset().
> +		 */
> +		direct_map_addr = page_address(page);
> +		/*
> +		 * Perform a kasan-unchecked memset() since this memory
> +		 * has not been initialized.
> +		 */
> +		direct_map_addr = kasan_reset_tag(direct_map_addr);
> +		if ((unsigned int)poison <= 0xFF)
> +			memset(direct_map_addr, poison, PAGE_SIZE);
> +
> +		free_reserved_page(page);
> +	}
> +
> +	if (pages && s)
> +		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
> +
> +	return pages;
> +}
> +
>  /**
>   * memblock_free - free boot memory allocation
>   * @ptr: starting address of the  boot memory allocation
> @@ -1776,7 +1812,6 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
>  		totalram_pages_inc();
>  	}
>  }
> -
>  /*
>   * Remaining API functions
>   */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2d4b6f1a554e..df3d61253001 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6234,42 +6234,6 @@ void adjust_managed_page_count(struct page *page, long count)
>  }
>  EXPORT_SYMBOL(adjust_managed_page_count);
>  
> -unsigned long free_reserved_area(void *start, void *end, int poison, const char *s)
> -{
> -	void *pos;
> -	unsigned long pages = 0;
> -
> -	start = (void *)PAGE_ALIGN((unsigned long)start);
> -	end = (void *)((unsigned long)end & PAGE_MASK);
> -	for (pos = start; pos < end; pos += PAGE_SIZE, pages++) {
> -		struct page *page = virt_to_page(pos);
> -		void *direct_map_addr;
> -
> -		/*
> -		 * 'direct_map_addr' might be different from 'pos'
> -		 * because some architectures' virt_to_page()
> -		 * work with aliases.  Getting the direct map
> -		 * address ensures that we get a _writeable_
> -		 * alias for the memset().
> -		 */
> -		direct_map_addr = page_address(page);
> -		/*
> -		 * Perform a kasan-unchecked memset() since this memory
> -		 * has not been initialized.
> -		 */
> -		direct_map_addr = kasan_reset_tag(direct_map_addr);
> -		if ((unsigned int)poison <= 0xFF)
> -			memset(direct_map_addr, poison, PAGE_SIZE);
> -
> -		free_reserved_page(page);
> -	}
> -
> -	if (pages && s)
> -		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
> -
> -	return pages;
> -}
> -
>  void free_reserved_page(struct page *page)
>  {
>  	clear_page_tag_ref(page);


