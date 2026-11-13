Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCD606A890
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVa1pdaT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR5Pd4P2yz2xg9;
	Sat, 14 Nov 2026 05:29:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794594549;
	cv=none; b=aZj8RvOPk/t1tbdtJrNCiKwoVcuhXS+UGtyPCVIx2MMOBxl6d1Wogy8XWq5w3KWomwFf5xVuDj4F4ZydN0VvjRUmFMxGXZTlWSW5PxitdwHb+4y0F/9ptNoH7KP8tIXw7t8Sg8P7esA3YMWCDw/2rKpcW4gpN0TsO1Fd9jzodxAxrhYqW2h0UFqj/KyinKhZapOoIyoV0SNLJ705BRluTkvhurLNtbwjx0cAyxJctmdJNQduJaaHY4UKJAVJTdFKFCeGua2udcFFjT67J2Xlf/1r8h3afyPdhzS08ABEryi9/50Be2gD+Tbm6n4bXdYrEALgMpYlgp675zuedDypNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794594549; c=relaxed/relaxed;
	bh=VA8bk9ERwXuNEDBoJnHNSRw6hKUgevqXTx1c8nNVso8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc05kWSMdIHjs7BfPcJQ2K9VLi0vBU1X7jlMv1+rl5kPcfxKraeaGIoTbPspdPjGTKvNycHlTSS2XamS0LYTBP7CFXGq5E/hIloenf69SzHTDkvmdNqfr1tTgpqCUr2alILO1ggz9o+aqVLPULvnX1xkrbmyxlZF+LPMXiJMOjJX6XbUlK2qaE3Q3DtC6XQQc5lYPrHXAhb23sSI5XVxO3uTKQLMLMmxUe31+AA0L+0IonWCfo166jzyio2YK8SGJBfgFcAcoef7Bj+n2pZckYAGYJQuI38TgMEqY/E9Amo7Ak8sLaxhHY6te+kUO21S20mMCHvkHJtf7qLtIsJCOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVa1pdaT; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVa1pdaT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR5Pc3Dqgz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 05:29:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A73C7609ED;
	Fri, 13 Nov 2026 18:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B26B1F000C5;
	Fri, 13 Nov 2026 18:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794594545;
	bh=VA8bk9ERwXuNEDBoJnHNSRw6hKUgevqXTx1c8nNVso8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IVa1pdaTdvJPJW//quHT797JAknHetwTWP7XqIoxrHXy3p4kDfkDlbx/DJJxbKsog
	 rVFaQbg1Xck2HGSyWeu56XkGjrKwJPV0lS+xf5BDNqkkNmvShfyS2sbc1jFKZIOewA
	 dJiBcGQ9c5b79av0BG88cuTvdQG51W4RdcMPeVA/yOq6gfQ9JazFJwgKGV1TsFFpez
	 G3/qzHYX9Fsiu09GVI+/44p89d/EhN8NqzC+7WCjmY2yfIdF6US3wYkdAj9qcHtMmW
	 ulHbdzl8VNIr0omw2Ava7FxqFWAvagnGxDQdCSQB/MMZ6HIsYv3Bza2BR2Dz0h2hSV
	 Lt4YVL9fVueKA==
Date: Fri, 13 Nov 2026 18:28:58 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Matthew Wilcox <willy@infradead.org>, 
	Malin Jonsson <malin.jonsson@est.tech>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/6] ARM: remove support for highmem on VIVT
Message-ID: <avdWJOWX3X2KlZfr@gremlin>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-2-arnd@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112112528.1116405-2-arnd@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:25:23PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> As Jason Gunthorpe noticed, supporting VIVT caches adds some complications
> to highmem that can be avoided these days:
>
> While all ARMv4 and ARMv5 CPUs use virtually indexed caches, they no
> longer really need highmem because we have practically discontinued
> support for large-memory configurations already.  The only machines I
> could find anywhere for memory on ARMv5 are:
>
>  - The Intel IOP platform was used on relatively large memory
>    configurations but we dropped kernel support in 2019 and 2022,
>    respectively.
>
>  - The Marvell mv78xx0 platform was the initial user of Arm highmem,
>    with the DB-78x00-BP supporting 2GB of memory. The only remaining
>    board file is for Buffalo WLX (Terastation Duo), which has only
>    512MB and is going to be removed soon.
>
>  - The Kirkwood platform supports 2GB, and there are actually boards
>    with that configuration that can still work. However, there are
>    no known users of the OpenBlocks A7, and the Freebox V6 is already
>    using CONFIG_VMSPLIT_2G to avoid enabling highmem.
>
> Remove the Arm specific portions here, making CONFIG_HIGHMEM conditional
> on modern caches. Since the cache type is enforced by Kconfig, no
> boot time check is needed here.
>
> Link: https://lore.kernel.org/all/20251219171412.GG254720@nvidia.com/
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Really lovely! All looks reasonable AFAICT so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/arm/Kconfig                    |  1 +
>  arch/arm/configs/gemini_defconfig   |  1 -
>  arch/arm/configs/multi_v5_defconfig |  1 -
>  arch/arm/configs/mvebu_v5_defconfig |  1 -
>  arch/arm/include/asm/highmem.h      | 56 ++---------------------------
>  arch/arm/mach-omap2/Kconfig         |  2 +-
>  arch/arm/mm/cache-feroceon-l2.c     | 31 ++--------------
>  arch/arm/mm/cache-xsc3l2.c          | 47 +++---------------------
>  arch/arm/mm/dma-mapping.c           | 12 ++-----
>  arch/arm/mm/flush.c                 | 19 +++-------
>  10 files changed, 17 insertions(+), 154 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0cc289a7184a..fd01ccab9c12 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1208,6 +1208,7 @@ config ARCH_SPARSEMEM_ENABLE
>  config HIGHMEM
>  	bool "High Memory Support"
>  	depends on MMU
> +	depends on !CPU_CACHE_VIVT
>  	select KMAP_LOCAL
>  	select KMAP_LOCAL_NON_LINEAR_PTE_ARRAY
>  	help
> diff --git a/arch/arm/configs/gemini_defconfig b/arch/arm/configs/gemini_defconfig
> index 5860b2fe7d1f..95debf46581b 100644
> --- a/arch/arm/configs/gemini_defconfig
> +++ b/arch/arm/configs/gemini_defconfig
> @@ -11,7 +11,6 @@ CONFIG_KEXEC=y
>  CONFIG_ARCH_MULTI_V4=y
>  # CONFIG_ARCH_MULTI_V7 is not set
>  CONFIG_ARCH_GEMINI=y
> -CONFIG_HIGHMEM=y
>  CONFIG_CMDLINE="console=ttyS0,115200n8"
>  CONFIG_PM=y
>  CONFIG_PARTITION_ADVANCED=y
> diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> index a0d2fb2fcf9a..bc34b6026e37 100644
> --- a/arch/arm/configs/multi_v5_defconfig
> +++ b/arch/arm/configs/multi_v5_defconfig
> @@ -27,7 +27,6 @@ CONFIG_MACH_D2NET_DT=y
>  CONFIG_MACH_MSS2_DT=y
>  CONFIG_ARCH_SUNXI=y
>  CONFIG_ARCH_VERSATILE=y
> -CONFIG_HIGHMEM=y
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CPU_FREQ=y
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index dbc6c511e70b..5adf6c75304e 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -13,7 +13,6 @@ CONFIG_MACH_RD88F5182_DT=y
>  CONFIG_MACH_LINKSTATION_MINI=y
>  CONFIG_MACH_D2NET_DT=y
>  CONFIG_MACH_MSS2_DT=y
> -CONFIG_HIGHMEM=y
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CPU_FREQ=y
> diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
> index bdb209e002a4..67ed46d1922b 100644
> --- a/arch/arm/include/asm/highmem.h
> +++ b/arch/arm/include/asm/highmem.h
> @@ -11,66 +11,14 @@
>  #define PKMAP_NR(virt)		(((virt) - PKMAP_BASE) >> PAGE_SHIFT)
>  #define PKMAP_ADDR(nr)		(PKMAP_BASE + ((nr) << PAGE_SHIFT))
>
> -#define flush_cache_kmaps() \
> -	do { \
> -		if (cache_is_vivt()) \
> -			flush_cache_all(); \
> -	} while (0)
> +#define flush_cache_kmaps() do { } while (0)
>
>  extern pte_t *pkmap_page_table;
>
> -/*
> - * The reason for kmap_high_get() is to ensure that the currently kmap'd
> - * page usage count does not decrease to zero while we're using its
> - * existing virtual mapping in an atomic context.  With a VIVT cache this
> - * is essential to do, but with a VIPT cache this is only an optimization
> - * so not to pay the price of establishing a second mapping if an existing
> - * one can be used.  However, on platforms without hardware TLB maintenance
> - * broadcast, we simply cannot use ARCH_NEEDS_KMAP_HIGH_GET at all since
> - * the locking involved must also disable IRQs which is incompatible with
> - * the IPI mechanism used by global TLB operations.
> - */
> -#define ARCH_NEEDS_KMAP_HIGH_GET
> -#if defined(CONFIG_SMP) && defined(CONFIG_CPU_TLB_V6)
> -#undef ARCH_NEEDS_KMAP_HIGH_GET
> -#if defined(CONFIG_HIGHMEM) && defined(CONFIG_CPU_CACHE_VIVT)
> -#error "The sum of features in your kernel config cannot be supported together"
> -#endif
> -#endif
> -
> -/*
> - * Needed to be able to broadcast the TLB invalidation for kmap.
> - */
> -#ifdef CONFIG_ARM_ERRATA_798181
> -#undef ARCH_NEEDS_KMAP_HIGH_GET
> -#endif
> -
> -#ifdef ARCH_NEEDS_KMAP_HIGH_GET
> -extern void *kmap_high_get(const struct page *page);
> -
> -static inline void *arch_kmap_local_high_get(const struct page *page)
> -{
> -	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !cache_is_vivt())
> -		return NULL;
> -	return kmap_high_get(page);
> -}
> -#define arch_kmap_local_high_get arch_kmap_local_high_get
> -
> -#else /* ARCH_NEEDS_KMAP_HIGH_GET */
> -static inline void *kmap_high_get(const struct page *page)
> -{
> -	return NULL;
> -}
> -#endif /* !ARCH_NEEDS_KMAP_HIGH_GET */
> -
>  #define arch_kmap_local_post_map(vaddr, pteval)				\
>  	local_flush_tlb_kernel_page(vaddr)
>
> -#define arch_kmap_local_pre_unmap(vaddr)				\
> -do {									\
> -	if (cache_is_vivt())						\
> -		__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);	\
> -} while (0)
> +#define arch_kmap_local_pre_unmap(vaddr) do { } while (0)
>
>  #define arch_kmap_local_post_unmap(vaddr)				\
>  	local_flush_tlb_kernel_page(vaddr)
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 79f8afe3a6bf..f0f1d7a8640c 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -135,7 +135,7 @@ config ARCH_OMAP2PLUS_TYPICAL
>  	bool "Typical OMAP configuration"
>  	default y
>  	select AEABI
> -	select HIGHMEM
> +	select HIGHMEM if !CPU_CACHE_VIVT
>  	select I2C
>  	select I2C_OMAP
>  	select MENELAUS if ARCH_OMAP2
> diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
> index 2bfefb252ffd..1316b6ab295a 100644
> --- a/arch/arm/mm/cache-feroceon-l2.c
> +++ b/arch/arm/mm/cache-feroceon-l2.c
> @@ -12,7 +12,6 @@
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/highmem.h>
>  #include <linux/io.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cp15.h>
> @@ -38,30 +37,6 @@
>   * between which we don't want to be preempted.
>   */
>
> -static inline unsigned long l2_get_va(unsigned long paddr)
> -{
> -#ifdef CONFIG_HIGHMEM
> -	/*
> -	 * Because range ops can't be done on physical addresses,
> -	 * we simply install a virtual mapping for it only for the
> -	 * TLB lookup to occur, hence no need to flush the untouched
> -	 * memory mapping afterwards (note: a cache flush may happen
> -	 * in some circumstances depending on the path taken in kunmap_atomic).
> -	 */
> -	void *vaddr = kmap_atomic_pfn(paddr >> PAGE_SHIFT);
> -	return (unsigned long)vaddr + (paddr & ~PAGE_MASK);
> -#else
> -	return __phys_to_virt(paddr);
> -#endif
> -}
> -
> -static inline void l2_put_va(unsigned long vaddr)
> -{
> -#ifdef CONFIG_HIGHMEM
> -	kunmap_atomic((void *)vaddr);
> -#endif
> -}
> -
>  static inline void l2_clean_pa(unsigned long addr)
>  {
>  	__asm__("mcr p15, 1, %0, c15, c9, 3" : : "r" (addr));
> @@ -78,14 +53,13 @@ static inline void l2_clean_pa_range(unsigned long start, unsigned long end)
>  	 */
>  	BUG_ON((start ^ end) >> PAGE_SHIFT);
>
> -	va_start = l2_get_va(start);
> +	va_start = __phys_to_virt(start);
>  	va_end = va_start + (end - start);
>  	raw_local_irq_save(flags);
>  	__asm__("mcr p15, 1, %0, c15, c9, 4\n\t"
>  		"mcr p15, 1, %1, c15, c9, 5"
>  		: : "r" (va_start), "r" (va_end));
>  	raw_local_irq_restore(flags);
> -	l2_put_va(va_start);
>  }
>
>  static inline void l2_clean_inv_pa(unsigned long addr)
> @@ -109,14 +83,13 @@ static inline void l2_inv_pa_range(unsigned long start, unsigned long end)
>  	 */
>  	BUG_ON((start ^ end) >> PAGE_SHIFT);
>
> -	va_start = l2_get_va(start);
> +	va_start = __phys_to_virt(start);
>  	va_end = va_start + (end - start);
>  	raw_local_irq_save(flags);
>  	__asm__("mcr p15, 1, %0, c15, c11, 4\n\t"
>  		"mcr p15, 1, %1, c15, c11, 5"
>  		: : "r" (va_start), "r" (va_end));
>  	raw_local_irq_restore(flags);
> -	l2_put_va(va_start);
>  }
>
>  static inline void l2_inv_all(void)
> diff --git a/arch/arm/mm/cache-xsc3l2.c b/arch/arm/mm/cache-xsc3l2.c
> index d20d7af02d10..477077387039 100644
> --- a/arch/arm/mm/cache-xsc3l2.c
> +++ b/arch/arm/mm/cache-xsc3l2.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2007 ARM Limited
>   */
>  #include <linux/init.h>
> -#include <linux/highmem.h>
>  #include <asm/cp15.h>
>  #include <asm/cputype.h>
>  #include <asm/cacheflush.h>
> @@ -55,34 +54,6 @@ static inline void xsc3_l2_inv_all(void)
>  	dsb();
>  }
>
> -static inline void l2_unmap_va(unsigned long va)
> -{
> -#ifdef CONFIG_HIGHMEM
> -	if (va != -1)
> -		kunmap_atomic((void *)va);
> -#endif
> -}
> -
> -static inline unsigned long l2_map_va(unsigned long pa, unsigned long prev_va)
> -{
> -#ifdef CONFIG_HIGHMEM
> -	unsigned long va = prev_va & PAGE_MASK;
> -	unsigned long pa_offset = pa << (32 - PAGE_SHIFT);
> -	if (unlikely(pa_offset < (prev_va << (32 - PAGE_SHIFT)))) {
> -		/*
> -		 * Switching to a new page.  Because cache ops are
> -		 * using virtual addresses only, we must put a mapping
> -		 * in place for it.
> -		 */
> -		l2_unmap_va(prev_va);
> -		va = (unsigned long)kmap_atomic_pfn(pa >> PAGE_SHIFT);
> -	}
> -	return va + (pa_offset >> (32 - PAGE_SHIFT));
> -#else
> -	return __phys_to_virt(pa);
> -#endif
> -}
> -
>  static void xsc3_l2_inv_range(unsigned long start, unsigned long end)
>  {
>  	unsigned long vaddr;
> @@ -92,13 +63,11 @@ static void xsc3_l2_inv_range(unsigned long start, unsigned long end)
>  		return;
>  	}
>
> -	vaddr = -1;  /* to force the first mapping */
> -
>  	/*
>  	 * Clean and invalidate partial first cache line.
>  	 */
>  	if (start & (CACHE_LINE_SIZE - 1)) {
> -		vaddr = l2_map_va(start & ~(CACHE_LINE_SIZE - 1), vaddr);
> +		vaddr = __phys_to_virt(start & ~(CACHE_LINE_SIZE - 1));
>  		xsc3_l2_clean_mva(vaddr);
>  		xsc3_l2_inv_mva(vaddr);
>  		start = (start | (CACHE_LINE_SIZE - 1)) + 1;
> @@ -108,7 +77,7 @@ static void xsc3_l2_inv_range(unsigned long start, unsigned long end)
>  	 * Invalidate all full cache lines between 'start' and 'end'.
>  	 */
>  	while (start < (end & ~(CACHE_LINE_SIZE - 1))) {
> -		vaddr = l2_map_va(start, vaddr);
> +		vaddr = __phys_to_virt(start);
>  		xsc3_l2_inv_mva(vaddr);
>  		start += CACHE_LINE_SIZE;
>  	}
> @@ -117,13 +86,11 @@ static void xsc3_l2_inv_range(unsigned long start, unsigned long end)
>  	 * Clean and invalidate partial last cache line.
>  	 */
>  	if (start < end) {
> -		vaddr = l2_map_va(start, vaddr);
> +		vaddr = __phys_to_virt(start);
>  		xsc3_l2_clean_mva(vaddr);
>  		xsc3_l2_inv_mva(vaddr);
>  	}
>
> -	l2_unmap_va(vaddr);
> -
>  	dsb();
>  }
>
> @@ -135,13 +102,11 @@ static void xsc3_l2_clean_range(unsigned long start, unsigned long end)
>
>  	start &= ~(CACHE_LINE_SIZE - 1);
>  	while (start < end) {
> -		vaddr = l2_map_va(start, vaddr);
> +		vaddr = __phys_to_virt(start);
>  		xsc3_l2_clean_mva(vaddr);
>  		start += CACHE_LINE_SIZE;
>  	}
>
> -	l2_unmap_va(vaddr);
> -
>  	dsb();
>  }
>
> @@ -178,14 +143,12 @@ static void xsc3_l2_flush_range(unsigned long start, unsigned long end)
>
>  	start &= ~(CACHE_LINE_SIZE - 1);
>  	while (start < end) {
> -		vaddr = l2_map_va(start, vaddr);
> +		vaddr = __phys_to_virt(start);
>  		xsc3_l2_clean_mva(vaddr);
>  		xsc3_l2_inv_mva(vaddr);
>  		start += CACHE_LINE_SIZE;
>  	}
>
> -	l2_unmap_va(vaddr);
> -
>  	dsb();
>  }
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index fb2eb0ed7bb8..917a546af0b9 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -647,18 +647,10 @@ static void dma_cache_maint_page(phys_addr_t phys, size_t size,
>  			if (len + offset > PAGE_SIZE)
>  				len = PAGE_SIZE - offset;
>
> -			if (cache_is_vipt_nonaliasing()) {
> -				vaddr = kmap_atomic_pfn(pfn);
> +			vaddr = kmap_atomic(phys_to_page(phys));
> +			if (vaddr) {
>  				op(vaddr + offset, len, dir);
>  				kunmap_atomic(vaddr);
> -			} else {
> -				struct page *page = phys_to_page(phys);
> -
> -				vaddr = kmap_high_get(page);
> -				if (vaddr) {
> -					op(vaddr + offset, len, dir);
> -					kunmap_high(page);
> -				}
>  			}
>  		} else {
>  			phys += offset;
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 66270904f874..e21c5af6f34c 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -208,21 +208,10 @@ void __flush_dcache_folio(struct address_space *mapping, struct folio *folio)
>  					folio_size(folio));
>  	} else {
>  		unsigned long i;
> -		if (cache_is_vipt_nonaliasing()) {
> -			for (i = 0; i < folio_nr_pages(folio); i++) {
> -				void *addr = kmap_local_folio(folio,
> -								i * PAGE_SIZE);
> -				__cpuc_flush_dcache_area(addr, PAGE_SIZE);
> -				kunmap_local(addr);
> -			}
> -		} else {
> -			for (i = 0; i < folio_nr_pages(folio); i++) {
> -				void *addr = kmap_high_get(folio_page(folio, i));
> -				if (addr) {
> -					__cpuc_flush_dcache_area(addr, PAGE_SIZE);
> -					kunmap_high(folio_page(folio, i));
> -				}
> -			}
> +		for (i = 0; i < folio_nr_pages(folio); i++) {
> +			void *addr = kmap_local_folio(folio, i * PAGE_SIZE);
> +			__cpuc_flush_dcache_area(addr, PAGE_SIZE);
> +			kunmap_local(addr);
>  		}
>  	}
>
> --
> 2.53.0
>

--
Cheers, Lorenzo

