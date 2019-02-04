Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA77AC282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 10:26:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AEF2075D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 10:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AEF2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tP4v6YHtzDqHV
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 21:26:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tP2k5N49zDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 21:24:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43tP2k0MZ9z9s3l;
 Mon,  4 Feb 2019 21:24:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] powerpc: drop page_is_ram() and walk_system_ram_range()
In-Reply-To: <a14aac5408f98cf8ad8723ffa874764ccb42d4d4.1548978750.git.christophe.leroy@c-s.fr>
References: <a14aac5408f98cf8ad8723ffa874764ccb42d4d4.1548978750.git.christophe.leroy@c-s.fr>
Date: Mon, 04 Feb 2019 21:24:26 +1100
Message-ID: <875ztzonqd.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Since commit c40dd2f76644 ("powerpc: Add System RAM to /proc/iomem")
> it is possible to use the generic walk_system_ram_range() and
> the generic page_is_ram().
>
> To enable the use of walk_system_ram_range() by the IBM EHEA
> ethernet driver, the generic function has to be exported.

I'm not sure if we have a policy on that, but I suspect we'd rather not
add a new export on all arches unless we need to. Especially seeing as
the only user is the EHEA code which is heavily in maintenance mode.

I'll put the export in powerpc code and make sure that builds.

> As powerpc was the only (last?) user of CONFIG_ARCH_HAS_WALK_MEMORY,
> the #ifdef around the generic walk_system_ram_range() has become
> useless and can be dropped.

Yes it was the only user:

a99824f327c7 ("[POWERPC] Add arch-specific walk_memory_remove() for 64-bit powerpc")

I'll update the changelog.

cheers


> Fixes: c40dd2f76644 ("powerpc: Add System RAM to /proc/iomem")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/Kconfig            |  3 ---
>  arch/powerpc/include/asm/page.h |  1 -
>  arch/powerpc/mm/mem.c           | 33 ---------------------------------
>  kernel/resource.c               |  5 +----
>  4 files changed, 1 insertion(+), 41 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2890d36eb531..f92e6754edf1 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -478,9 +478,6 @@ config ARCH_CPU_PROBE_RELEASE
>  config ARCH_ENABLE_MEMORY_HOTPLUG
>  	def_bool y
>  
> -config ARCH_HAS_WALK_MEMORY
> -	def_bool y
> -
>  config ARCH_ENABLE_MEMORY_HOTREMOVE
>  	def_bool y
>  
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 5c5ea2413413..aa4497175bd3 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -326,7 +326,6 @@ struct page;
>  extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
>  extern void copy_user_page(void *to, void *from, unsigned long vaddr,
>  		struct page *p);
> -extern int page_is_ram(unsigned long pfn);
>  extern int devmem_is_allowed(unsigned long pfn);
>  
>  #ifdef CONFIG_PPC_SMLPAR
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 33cc6f676fa6..fa9916c2c662 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -80,11 +80,6 @@ static inline pte_t *virt_to_kpte(unsigned long vaddr)
>  #define TOP_ZONE ZONE_NORMAL
>  #endif
>  
> -int page_is_ram(unsigned long pfn)
> -{
> -	return memblock_is_memory(__pfn_to_phys(pfn));
> -}
> -
>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  			      unsigned long size, pgprot_t vma_prot)
>  {
> @@ -176,34 +171,6 @@ int __meminit arch_remove_memory(int nid, u64 start, u64 size,
>  #endif
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
> -/*
> - * walk_memory_resource() needs to make sure there is no holes in a given
> - * memory range.  PPC64 does not maintain the memory layout in /proc/iomem.
> - * Instead it maintains it in memblock.memory structures.  Walk through the
> - * memory regions, find holes and callback for contiguous regions.
> - */
> -int
> -walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
> -		void *arg, int (*func)(unsigned long, unsigned long, void *))
> -{
> -	struct memblock_region *reg;
> -	unsigned long end_pfn = start_pfn + nr_pages;
> -	unsigned long tstart, tend;
> -	int ret = -1;
> -
> -	for_each_memblock(memory, reg) {
> -		tstart = max(start_pfn, memblock_region_memory_base_pfn(reg));
> -		tend = min(end_pfn, memblock_region_memory_end_pfn(reg));
> -		if (tstart >= tend)
> -			continue;
> -		ret = (*func)(tstart, tend - tstart, arg);
> -		if (ret)
> -			break;
> -	}
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(walk_system_ram_range);
> -
>  #ifndef CONFIG_NEED_MULTIPLE_NODES
>  void __init mem_topology_setup(void)
>  {
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 915c02e8e5dd..2e1636041508 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -448,8 +448,6 @@ int walk_mem_res(u64 start, u64 end, void *arg,
>  				     arg, func);
>  }
>  
> -#if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
> -
>  /*
>   * This function calls the @func callback against all memory ranges of type
>   * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.
> @@ -480,8 +478,7 @@ int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
>  	}
>  	return ret;
>  }
> -
> -#endif
> +EXPORT_SYMBOL_GPL(walk_system_ram_range);
>  
>  static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
>  {
> -- 
> 2.13.3
