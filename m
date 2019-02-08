Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7A5C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 16:20:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B915A2084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 16:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ATqiyCLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B915A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43x0lK4H11zDqbq
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 03:20:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="ATqiyCLs"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43x0jF4ykxzDqZk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 03:18:24 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id y126so1884418pfb.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 08:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=rwttkLcB0E6Lz2B+tgr9+cijqY8fQQn5nOYWb3x5YWA=;
 b=ATqiyCLsID2FI6vHntKHhBzn+aar81HJ9Tv8JjbXVpIV9uG//cqIwTvcM2FbgcnACX
 f0uAkfpAXGLXmv0GAK9EfWCCUKhkuAfZdar46KltKoZijBTEMC1SXKiEQ6vroIqDVuU0
 YrlJ67WhEOIwLUUUeDD4/D/Sgjea59Kh+p4Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=rwttkLcB0E6Lz2B+tgr9+cijqY8fQQn5nOYWb3x5YWA=;
 b=SJUMa2Y8hbXhuoXNfpl3AC5iYXFrWmscEmS6VSSGpFEWPPt5B6IObK2Cq4jVlnShKv
 VCbP48umqJO2SsH7UUAprWCgRV396zZID5srvTqbzCG3lrFQT0s9su1heegFZGSNBoki
 aKTqHFp3eLA/Xo3RyDuU5uxxii1jyFVhiRaEOEwcSOWkVmUmH+ZfY4uhgQqx/B2h/Omm
 kVytpfVfYSAVverZCZTSaU4fnyn95+45ruTt6frWGPiI2LAvMf33FIMpRURlG8JVpEqD
 i5S2DirsE4QukDuWEmxAs/hgnnub1RXxpqB1zewXst2v25n5F8OD3q17Ztjuqbmo46pN
 XxVQ==
X-Gm-Message-State: AHQUAuZ4lpd7W7KSqBAgojIPdibtp+drXUDJZkhbefpX7pKo6kEvcxPA
 0i2hU3xyQ5IwEfPygX0mPurppg==
X-Google-Smtp-Source: AHgI3IYFm9qTo0YgHqGZSOhIItRjWouKqbzosTgd/PKnqIu7ryPVhhmeCqyP/F/uRP5+deEAfJDA9Q==
X-Received: by 2002:aa7:8d51:: with SMTP id s17mr8824013pfe.16.1549642702499; 
 Fri, 08 Feb 2019 08:18:22 -0800 (PST)
Received: from localhost (124-171-150-195.dyn.iinet.net.au. [124.171.150.195])
 by smtp.gmail.com with ESMTPSA id
 s71sm3704832pfa.122.2019.02.08.08.18.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 08:18:20 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v4 3/3] powerpc/32: Add KASAN support
In-Reply-To: <1f5629e03181d0e30efc603f00dad78912991a45.1548166824.git.christophe.leroy@c-s.fr>
References: <cover.1548166824.git.christophe.leroy@c-s.fr>
 <1f5629e03181d0e30efc603f00dad78912991a45.1548166824.git.christophe.leroy@c-s.fr>
Date: Sat, 09 Feb 2019 03:18:17 +1100
Message-ID: <87ef8i45km.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

I've been attempting to port this to 64-bit Book3e nohash (e6500),
although I think I've ended up with an approach more similar to Aneesh's
much earlier (2015) series for book3s.

Part of this is just due to the changes between 32 and 64 bits - we need
to hack around the discontiguous mappings - but one thing that I'm
particularly puzzled by is what the kasan_early_init is supposed to do.

> +void __init kasan_early_init(void)
> +{
> +	unsigned long addr = KASAN_SHADOW_START;
> +	unsigned long end = KASAN_SHADOW_END;
> +	unsigned long next;
> +	pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(addr), addr), addr);
> +	int i;
> +	phys_addr_t pa = __pa(kasan_early_shadow_page);
> +
> +	BUILD_BUG_ON(KASAN_SHADOW_START & ~PGDIR_MASK);
> +
> +	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
> +		panic("KASAN not supported with Hash MMU\n");
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++)
> +		__set_pte_at(&init_mm, (unsigned long)kasan_early_shadow_page,
> +			     kasan_early_shadow_pte + i,
> +			     pfn_pte(PHYS_PFN(pa), PAGE_KERNEL_RO), 0);
> +
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		pmd_populate_kernel(&init_mm, pmd, kasan_early_shadow_pte);
> +	} while (pmd++, addr = next, addr != end);
> +}

As far as I can tell it's mapping the early shadow page, read-only, over
the KASAN_SHADOW_START->KASAN_SHADOW_END range, and it's using the early
shadow PTE array from the generic code.

I haven't been able to find an answer to why this is in the docs, so I
was wondering if you or anyone else could explain the early part of
kasan init a bit better.

At the moment, I don't do any early init, and like Aneesh's series for
book3s, I end up needing a special flag to disable kasan until after
kasan_init. Also, as with Balbir's seris for Radix, some tests didn't
fire, although my missing tests are a superset of his. I suspect the
early init has something to do with these...?

(I'm happy to collate answers into a patch to the docs, btw!)

In the long term I hope to revive Aneesh's and Balbir's series for hash
and radix as well.

Regards,
Daniel

> +
> +static void __init kasan_init_region(struct memblock_region *reg)
> +{
> +	void *start = __va(reg->base);
> +	void *end = __va(reg->base + reg->size);
> +	unsigned long k_start, k_end, k_cur, k_next;
> +	pmd_t *pmd;
> +
> +	if (start >= end)
> +		return;
> +
> +	k_start = (unsigned long)kasan_mem_to_shadow(start);
> +	k_end = (unsigned long)kasan_mem_to_shadow(end);
> +	pmd = pmd_offset(pud_offset(pgd_offset_k(k_start), k_start), k_start);
> +
> +	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd++) {
> +		k_next = pgd_addr_end(k_cur, k_end);
> +		if ((void *)pmd_page_vaddr(*pmd) == kasan_early_shadow_pte) {
> +			pte_t *new = pte_alloc_one_kernel(&init_mm);
> +
> +			if (!new)
> +				panic("kasan: pte_alloc_one_kernel() failed");
> +			memcpy(new, kasan_early_shadow_pte, PTE_TABLE_SIZE);
> +			pmd_populate_kernel(&init_mm, pmd, new);
> +		}
> +	};
> +
> +	for (k_cur = k_start; k_cur < k_end; k_cur += PAGE_SIZE) {
> +		void *va = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +		pte_t pte = pfn_pte(PHYS_PFN(__pa(va)), PAGE_KERNEL);
> +
> +		if (!va)
> +			panic("kasan: memblock_alloc() failed");
> +		pmd = pmd_offset(pud_offset(pgd_offset_k(k_cur), k_cur), k_cur);
> +		pte_update(pte_offset_kernel(pmd, k_cur), ~0, pte_val(pte));
> +	}
> +	flush_tlb_kernel_range(k_start, k_end);
> +}
> +
> +void __init kasan_init(void)
> +{
> +	struct memblock_region *reg;
> +
> +	for_each_memblock(memory, reg)
> +		kasan_init_region(reg);
> +
> +	kasan_init_tags();
> +
> +	/* At this point kasan is fully initialized. Enable error messages */
> +	init_task.kasan_depth = 0;
> +	pr_info("KASAN init done\n");
> +}
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 33cc6f676fa6..ae7db88b72d6 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -369,6 +369,10 @@ void __init mem_init(void)
>  	pr_info("  * 0x%08lx..0x%08lx  : highmem PTEs\n",
>  		PKMAP_BASE, PKMAP_ADDR(LAST_PKMAP));
>  #endif /* CONFIG_HIGHMEM */
> +#ifdef CONFIG_KASAN
> +	pr_info("  * 0x%08lx..0x%08lx  : kasan shadow mem\n",
> +		KASAN_SHADOW_START, KASAN_SHADOW_END);
> +#endif
>  #ifdef CONFIG_NOT_COHERENT_CACHE
>  	pr_info("  * 0x%08lx..0x%08lx  : consistent mem\n",
>  		IOREMAP_TOP, IOREMAP_TOP + CONFIG_CONSISTENT_SIZE);
> -- 
> 2.13.3
