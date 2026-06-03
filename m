Return-Path: <linuxppc-dev+bounces-21988-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38125CD6E69
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:03:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVwY15HWFz2ySJ;
	Thu, 04 Jun 2026 04:03:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780509797;
	cv=none; b=agnyqGjIVDmsDYHSUljHHfRtMvgwxy5qkzOH9+NgE816nTOq1EoEpYebHZJUAIjdW0E6md2nypMrJxETynLp/t9WfkuBsTSvFTdjw+b81VLwefyVgb5dlR8w6R//CEXDgN2Ww1bZY40jRdn7VsyqwQskOmQRroypB2cXbebVLQeThb2fDTo5Dtcmm4524HtTsCI9P+9LSTq7BUfdXEPtvlMT0XdhTZmNzZ3HntfRRV0SW04sIwxjU7PQ2DUeh7c+dLkHFB3eJCmKteytzo1awhSjmg1gZus2eeWf+K3mCS9SZurfaqi5WRcYqlWQGmO2MQaaWEVxaVaP0lHJw2XL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780509797; c=relaxed/relaxed;
	bh=hrbiXUlsk45eySsbtONrBewq/djyZBhyYFXfnKgyx7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI2QrWzrcIlVxJNrfwDtkfDbNgNad8RXtqv4drWv/egzCrRL83OEO1mXRc7dzpeTnYFjS/NDoWnHMyR2H34XZ7tHlMnddk0aNRwd9YYFRz5Jh0Ia/UyCN+5yqFJekGq9YAt/auhrtMO+EC6vv0xLxMsMHlKavgL675Ij6URT3lt7H7CLcMsq98nTtSi55Ki/sNk98f7ZQXrRUsqdtsQJciTIIEnio6IEXKE33RuarLj7Bxk1ToH4LfFGjG8FvSau4+ISS98/LKeFuT+XCgWCFqhRZWV/vNqNWSwGCmZJSpc5DvZcVOlxKISW4TI1qWfnmYKSGsBfGx1EdntbL6HJNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nP3eSljT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nP3eSljT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVwY06x8pz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 04:03:16 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-36da8439078so3462927a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 11:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780509794; x=1781114594; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrbiXUlsk45eySsbtONrBewq/djyZBhyYFXfnKgyx7M=;
        b=nP3eSljT7Kskyb2Zx9FaQBrqSyBXBM5g6qrOwYrdQqOzB138vxmDBYv7+6jGSz8Elq
         ySYtT4xhAKzyVLZkxYGzR4F+nMbm/MpqyI9QRUsITvjrqiVn1Bj4jKDFxlv7MBcT40qw
         8O/guL+nH/OzTTmSmsMONrTca1TL1UTJk0v+qumMTsQKQ6RS1qCVNzgRwFIEGWH9MpbY
         BhWg9a64UJGeAnD9uaK8tVjaxFlZaca984gtjlumPN7HRuP26dNXXAPfo/LP8+Cc31t4
         qE9Iir22TPfxYFdwerkH83hhaoSOYYj+GM+n+wkBzjAZ2Qu1pzcYjNg877tYBbhlmhrq
         1XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780509794; x=1781114594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrbiXUlsk45eySsbtONrBewq/djyZBhyYFXfnKgyx7M=;
        b=gPugN473zZmhkph9MRheyJpQA9Y9rSM4Upec2G3pN1TEWFbYnv7UKr/qihbGx3NPYj
         YzDCz5mMhWath/3jL9u6MdHESh4f8Porq549ACf+QGZUQjfG0UPqSjBPvmj6uRzI5u8s
         IvD2CtxxGh5lCTcy8jMdika88YxWXvYi3PXGOOj80Qao1vVUZyyq+HA7aLfjomBF16gd
         WUSvXyD4TFUWMvJxMPMwabZjUTtlx4IqU4P5QyQ6tsbeOOCLNfd/vwz6pGh2wdsa2f2O
         M2ZmoWe5dDXs40rPIehyZCLHHiWVyhLiA1HXVArptz1bq+/VrsNijRp5jbGpZ9mO19g4
         Khbw==
X-Forwarded-Encrypted: i=1; AFNElJ+knncQpXLfLg1FRK9OUYRyHmWrwe+BmcwG7wAOUYFRCtxTezCalierF+sDEfberPQCgYUKPgI88mKu9hs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YycOLSbJWT0vwsnp1YQSpYxun6aJ0XirxqHlL6q2R6B2rdPjoE/
	ebfeElnSOlONn++cNmzgdKVqNpAfTsot3vFyHSKa+zxRXVcPx6/OMu5A
X-Gm-Gg: Acq92OH7AB3j1Yh30SolYuPoi6HYL8UdO8vMBJSKxFXpQk+ABDbK8vZIZiY7hNHcvqd
	tMSgYK+/WdbAkPhbGaCMdaBQMOvz9SOIfzQrnNq4kVnpjYYZqro5ZlZNg6hUisurIxKRY8XqcNL
	xm6Fai4gMfx3V4aOy9MD9ZqSgCJfmFqvlRv4ZBkGJ0M02A5cSfGZ0Cn0E0TzjKrh1+LeMzbV5gA
	7M4N+6fo1u2pPzwKJimeN+SlYtJj0ZYgmpokmuvJIz2hjZN3W1/3OvlUqBAKUSEqy1GmFEWEHcj
	j1wl0f5N9POHV2ICGPr4kwFYePe553kaDXOw8RxYRgOnbMVAdILsc+lJ+pHqggxozrV5JBlj4Ar
	pd2Sku2yz3xhwMH+6/YiSmGfZjiVBDeE51GIB+iXA/5MqYNc0J4iTyXf8OGKFiuKkMSzVFcOscQ
	PMKEgVHFbTqD0jO75OfwD37ABHjm2+T2FTNRWFhGMrt/x6uAo93O2izyXTwi16x9Bsvu7yOKw7o
	um5RmKm/w==
X-Received: by 2002:a17:90b:3f90:b0:367:db13:aca6 with SMTP id 98e67ed59e1d1-36e319bff94mr4221552a91.26.1780509794151;
        Wed, 03 Jun 2026 11:03:14 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d1fec5asm331867a91.10.2026.06.03.11.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:03:13 -0700 (PDT)
Date: Wed, 3 Jun 2026 23:33:03 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH v7 11/15] powerpc/code-patching: Avoid r/w mapping of the
 zero page
Message-ID: <aiBsMg9WdDy-dRk_@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-28-ardb+git@google.com>
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
In-Reply-To: <20260529150150.1670604-28-ardb+git@google.com>

On Fri, May 29, 2026 at 05:02:02PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The only remaining use of map_patch_area() is mapping the zero page, and
> immediately unmapping it again so that the intermediate page table
> levels are all guaranteed to be populated.
> 
> The use of the zero page here is completely arbitrary, and not harmful
> per se, but currently, it creates a writable mapping, and does so in a
> manner that requires that the empty_zero_page[] symbol is not
> const-qualified.
> 
> Given that this is about to change, and that map_patch_area() now never
> maps anything other than the zero page, let's simplify the code and
> - remove the helpers and call [un]map_kernel_page() directly
> - take the PA of empty_zero_page directly
> - create a read-only temporary mapping.
> 
> This allows empty_zero_page[] to be repainted as const u8[] in a
> subsequent patch, without making substantial changes to this code
> patching logic.
> 
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Link: https://lore.kernel.org/all/20260520085423.485402-1-ardb@kernel.org/
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/powerpc/lib/code-patching.c | 52 +-------------------
>  1 file changed, 2 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index f84e0337cc02..44ff9f684bef 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -60,9 +60,6 @@ struct patch_context {
>  
>  static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
>  
> -static int map_patch_area(void *addr, unsigned long text_poke_addr);
> -static void unmap_patch_area(unsigned long addr);
> -
>  static bool mm_patch_enabled(void)
>  {
>  	return IS_ENABLED(CONFIG_SMP) && radix_enabled();
> @@ -117,11 +114,11 @@ static int text_area_cpu_up(unsigned int cpu)
>  
>  	// Map/unmap the area to ensure all page tables are pre-allocated
>  	addr = (unsigned long)area->addr;
> -	err = map_patch_area(empty_zero_page, addr);
> +	err = map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KERNEL_RO);
>  	if (err)
>  		return err;
>  
> -	unmap_patch_area(addr);
> +	unmap_kernel_page(addr);
>  
>  	this_cpu_write(cpu_patching_context.area, area);
>  	this_cpu_write(cpu_patching_context.addr, addr);
> @@ -233,51 +230,6 @@ static unsigned long get_patch_pfn(void *addr)
>  		return __pa_symbol(addr) >> PAGE_SHIFT;
>  }
>  
> -/*
> - * This can be called for kernel text or a module.
> - */
> -static int map_patch_area(void *addr, unsigned long text_poke_addr)
> -{
> -	unsigned long pfn = get_patch_pfn(addr);
> -
> -	return map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
> -}
> -
> -static void unmap_patch_area(unsigned long addr)
> -{
> -	pte_t *ptep;
> -	pmd_t *pmdp;
> -	pud_t *pudp;
> -	p4d_t *p4dp;
> -	pgd_t *pgdp;
> -
> -	pgdp = pgd_offset_k(addr);
> -	if (WARN_ON(pgd_none(*pgdp)))
> -		return;
> -
> -	p4dp = p4d_offset(pgdp, addr);
> -	if (WARN_ON(p4d_none(*p4dp)))
> -		return;
> -
> -	pudp = pud_offset(p4dp, addr);
> -	if (WARN_ON(pud_none(*pudp)))
> -		return;
> -
> -	pmdp = pmd_offset(pudp, addr);
> -	if (WARN_ON(pmd_none(*pmdp)))
> -		return;
> -
> -	ptep = pte_offset_kernel(pmdp, addr);
> -	if (WARN_ON(pte_none(*ptep)))
> -		return;
> -
> -	/*
> -	 * In hash, pte_clear flushes the tlb, in radix, we have to
> -	 */
> -	pte_clear(&init_mm, addr, ptep);
> -	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -}
> -
>  static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
>  {
>  	int err;
> -- 
> 2.54.0.823.g6e5bcc1fc9-goog
> 
I don't see any functional change.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

