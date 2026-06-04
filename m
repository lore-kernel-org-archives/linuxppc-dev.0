Return-Path: <linuxppc-dev+bounces-21994-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D85DCD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 07:43:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWGlQ5wqJz2y1Y;
	Thu, 04 Jun 2026 17:43:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780559010;
	cv=none; b=GQaM8PSCqVYuoWiJ9KyO5RxGL3FmqympTkhKeETFgaQ+Q2R9Ig8FnlENCPGSxZuYMaTyc7CdXV7F6pkOo79ijF73o2T02rIyAPfuRptwuUm0AKBn23iloFdm+f9r2EC1mLgVjUETBh55ZHkjiOuL2GyfGF76tnMZbi6sJ0IKK+vOIKoUuE5HBKng57GdA6mluks7INyY4xme3QFKRZ9SpfPJ4DKygRo7qwNYtFG68fbv2eW0T9wFS2nNVmfDMNdBlAIvqFo94xCrzQ1NzCh5aXai9e5ahH60Ba55m0QGLEcRqJsoJvkoNABHmuAfuCQyTtsippZfI71FiWCZLtn6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780559010; c=relaxed/relaxed;
	bh=FcphQ0Rw2o1L4ixWXv1z/UyHZdPxmHTlt/k525r269U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WY0hnvAk8nHokKL08YmTSA7l29EUUEc1O4hyjbipBkCmFhpND6XccRpzXQwbHSoSHUD8acw9DeprQ6mGOleyhYJbNU/vs6NGXBYqBEYNEv56DedvXqw/+384iY5DY1tR3LMZMA7WDEhB/Am+oOFwu4tAZlvTTCgD4t0ZAOb9fAbbnAzSprFhIP6vcE80aASdE5tcgDih5oscGvn2iS8RoVjt9CT3bT6p3jUPzACD1J5tD9fb/UtL/VbPUQCCiAoRbwbGAJac7jKomc60Vu+PfbZQP+aqbchFX/v3JKzGx4prOT+Y1fAZoiLxADX2oFVGCcprsQVMF0GyCRcPseErGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FP8b2xGD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FP8b2xGD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWGlP4F0Kz2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 17:43:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E62760126;
	Thu,  4 Jun 2026 07:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BE01F00893;
	Thu,  4 Jun 2026 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780559006;
	bh=FcphQ0Rw2o1L4ixWXv1z/UyHZdPxmHTlt/k525r269U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FP8b2xGDkzxHJ7n2qYYxpH1CybRl8kL3CD+0OVxwkPI/nHpC05YEnca4gvdN7gNb/
	 lNynqq4CtTAoVYy5gcVYxgxcyR+ySL7wGXlUJl7SXYUt+iBE7iVmXvpBBM+2ZqjF6g
	 S6HCf1RdhXjHRVgAnWsNT2IkrrMof03Tzon8NrSOG7oG6Q7iIrM9GW/GzpfWV+Z0QD
	 x0c9tYofo+wlJFnOT8RyGrdU6BkUBheELnytF2mQlTwMYTlA7KUDyyB2PVRQFlSBgg
	 rBdpIxXTBVVqbhtHf77+iowcjPoA1Dv5MyERvxzSPC/DKi6Z0ThqJoDesIlgePnZYK
	 2LCn5WB81zLvw==
Message-ID: <11d2f0bd-baca-42aa-89ce-328a9d555f7e@kernel.org>
Date: Thu, 4 Jun 2026 09:43:19 +0200
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
Subject: Re: [PATCH v7 11/15] powerpc/code-patching: Avoid r/w mapping of the
 zero page
To: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Liz Prucka <lizprucka@google.com>,
 Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-28-ardb+git@google.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260529150150.1670604-28-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/05/2026 à 17:02, Ard Biesheuvel a écrit :
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
> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20260520085423.485402-1-ardb%40kernel.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Ca75a9b5e25f14d0d9b2208debd935266%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639156637598013085%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Q82ykchJOsuWlbmq%2BKFb2cTWIU4wGXbR53VQjNvgOCk%3D&reserved=0
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>

> ---
>   arch/powerpc/lib/code-patching.c | 52 +-------------------
>   1 file changed, 2 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index f84e0337cc02..44ff9f684bef 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -60,9 +60,6 @@ struct patch_context {
>   
>   static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
>   
> -static int map_patch_area(void *addr, unsigned long text_poke_addr);
> -static void unmap_patch_area(unsigned long addr);
> -
>   static bool mm_patch_enabled(void)
>   {
>   	return IS_ENABLED(CONFIG_SMP) && radix_enabled();
> @@ -117,11 +114,11 @@ static int text_area_cpu_up(unsigned int cpu)
>   
>   	// Map/unmap the area to ensure all page tables are pre-allocated
>   	addr = (unsigned long)area->addr;
> -	err = map_patch_area(empty_zero_page, addr);
> +	err = map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KERNEL_RO);
>   	if (err)
>   		return err;
>   
> -	unmap_patch_area(addr);
> +	unmap_kernel_page(addr);
>   
>   	this_cpu_write(cpu_patching_context.area, area);
>   	this_cpu_write(cpu_patching_context.addr, addr);
> @@ -233,51 +230,6 @@ static unsigned long get_patch_pfn(void *addr)
>   		return __pa_symbol(addr) >> PAGE_SHIFT;
>   }
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
>   static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
>   {
>   	int err;


