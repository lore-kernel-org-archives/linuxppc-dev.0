Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E57C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 20:11:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56B320850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 20:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56B320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gpv74YqWzDqT8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 06:11:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gps56JbkzDqSw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 06:09:44 +1000 (AEST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Apr 2019 13:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,342,1549958400"; d="scan'208";a="291124058"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga004.jf.intel.com with ESMTP; 12 Apr 2019 13:09:32 -0700
Date: Fri, 12 Apr 2019 13:09:30 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/3] mm: introduce ARCH_HAS_PTE_DEVMAP
Message-ID: <20190412200930.GA26371@iweiny-DESK2.sc.intel.com>
References: <cover.1555093412.git.robin.murphy@arm.com>
 <25525e4dab6ebc49e233f21f7c29821223431647.1555093412.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25525e4dab6ebc49e233f21f7c29821223431647.1555093412.git.robin.murphy@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: anshuman.khandual@arm.com, ohall@gmail.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 12, 2019 at 07:56:02PM +0100, Robin Murphy wrote:
> ARCH_HAS_ZONE_DEVICE is somewhat meaningless in itself, and combined
> with the long-out-of-date comment can lead to the impression than an
> architecture may just enable it (since __add_pages() now "comprehends
> device memory" for itself) and expect things to work.
> 
> In practice, however, ZONE_DEVICE users have little chance of
> functioning correctly without __HAVE_ARCH_PTE_DEVMAP, so let's clean
> that up the same way as ARCH_HAS_PTE_SPECIAL and make it the proper
> dependency so the real situation is clearer.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  arch/powerpc/Kconfig                         | 2 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 1 -
>  arch/x86/Kconfig                             | 2 +-
>  arch/x86/include/asm/pgtable.h               | 4 ++--
>  arch/x86/include/asm/pgtable_types.h         | 1 -
>  include/linux/mm.h                           | 4 ++--
>  include/linux/pfn_t.h                        | 4 ++--
>  mm/Kconfig                                   | 5 ++---
>  mm/gup.c                                     | 2 +-
>  9 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 5e3d0853c31d..77e1993bba80 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -135,6 +135,7 @@ config PPC
>  	select ARCH_HAS_MMIOWB			if PPC64
>  	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_PMEM_API                if PPC64
> +	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_MEMBARRIER_CALLBACKS
>  	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC64
> @@ -142,7 +143,6 @@ config PPC
>  	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
> -	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_MIGHT_HAVE_PC_SERIO
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 581f91be9dd4..02c22ac8f387 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -90,7 +90,6 @@
>  #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
>  #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
>  #define _PAGE_DEVMAP		_RPAGE_SW1 /* software: ZONE_DEVICE page */
> -#define __HAVE_ARCH_PTE_DEVMAP
>  
>  /*
>   * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5ad92419be19..ffd50f27f395 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -60,6 +60,7 @@ config X86
>  	select ARCH_HAS_KCOV			if X86_64
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_PMEM_API		if X86_64
> +	select ARCH_HAS_PTE_DEVMAP		if X86_64
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_REFCOUNT
>  	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
> @@ -69,7 +70,6 @@ config X86
>  	select ARCH_HAS_STRICT_MODULE_RWX
>  	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
> -	select ARCH_HAS_ZONE_DEVICE		if X86_64
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 2779ace16d23..89a1f6fd48bf 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -254,7 +254,7 @@ static inline int has_transparent_hugepage(void)
>  	return boot_cpu_has(X86_FEATURE_PSE);
>  }
>  
> -#ifdef __HAVE_ARCH_PTE_DEVMAP
> +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
>  static inline int pmd_devmap(pmd_t pmd)
>  {
>  	return !!(pmd_val(pmd) & _PAGE_DEVMAP);
> @@ -715,7 +715,7 @@ static inline int pte_present(pte_t a)
>  	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
>  }
>  
> -#ifdef __HAVE_ARCH_PTE_DEVMAP
> +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP


>  static inline int pte_devmap(pte_t a)
>  {
>  	return (pte_flags(a) & _PAGE_DEVMAP) == _PAGE_DEVMAP;
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index d6ff0bbdb394..b5e49e6bac63 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -103,7 +103,6 @@
>  #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
>  #define _PAGE_NX	(_AT(pteval_t, 1) << _PAGE_BIT_NX)
>  #define _PAGE_DEVMAP	(_AT(u64, 1) << _PAGE_BIT_DEVMAP)
> -#define __HAVE_ARCH_PTE_DEVMAP
>  #else
>  #define _PAGE_NX	(_AT(pteval_t, 0))
>  #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d76dfb7ac617..fe05c94f23e9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -504,7 +504,7 @@ struct inode;
>  #define page_private(page)		((page)->private)
>  #define set_page_private(page, v)	((page)->private = (v))
>  
> -#if !defined(__HAVE_ARCH_PTE_DEVMAP) || !defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +#if !defined(CONFIG_ARCH_HAS_PTE_DEVMAP) || !defined(CONFIG_TRANSPARENT_HUGEPAGE)
>  static inline int pmd_devmap(pmd_t pmd)
>  {
>  	return 0;
> @@ -1698,7 +1698,7 @@ static inline void sync_mm_rss(struct mm_struct *mm)
>  }
>  #endif
>  
> -#ifndef __HAVE_ARCH_PTE_DEVMAP
> +#ifndef CONFIG_ARCH_HAS_PTE_DEVMAP
>  static inline int pte_devmap(pte_t pte)
>  {
>  	return 0;
> diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
> index 7bb77850c65a..de8bc66b10a4 100644
> --- a/include/linux/pfn_t.h
> +++ b/include/linux/pfn_t.h
> @@ -104,7 +104,7 @@ static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
>  #endif
>  #endif
>  
> -#ifdef __HAVE_ARCH_PTE_DEVMAP
> +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
>  static inline bool pfn_t_devmap(pfn_t pfn)
>  {
>  	const u64 flags = PFN_DEV|PFN_MAP;
> @@ -122,7 +122,7 @@ pmd_t pmd_mkdevmap(pmd_t pmd);
>  	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>  pud_t pud_mkdevmap(pud_t pud);
>  #endif
> -#endif /* __HAVE_ARCH_PTE_DEVMAP */
> +#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
>  
>  #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>  static inline bool pfn_t_special(pfn_t pfn)
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 25c71eb8a7db..fcb7ab08e294 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -655,8 +655,7 @@ config IDLE_PAGE_TRACKING
>  	  See Documentation/admin-guide/mm/idle_page_tracking.rst for
>  	  more details.
>  
> -# arch_add_memory() comprehends device memory
> -config ARCH_HAS_ZONE_DEVICE
> +config ARCH_HAS_PTE_DEVMAP
>  	bool
>  
>  config ZONE_DEVICE
> @@ -664,7 +663,7 @@ config ZONE_DEVICE
>  	depends on MEMORY_HOTPLUG
>  	depends on MEMORY_HOTREMOVE
>  	depends on SPARSEMEM_VMEMMAP
> -	depends on ARCH_HAS_ZONE_DEVICE
> +	depends on ARCH_HAS_PTE_DEVMAP
>  	select XARRAY_MULTI
>  
>  	help
> diff --git a/mm/gup.c b/mm/gup.c
> index f84e22685aaa..72a5c7d1e1a7 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1623,7 +1623,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  }
>  #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
>  
> -#if defined(__HAVE_ARCH_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
>  static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  		unsigned long end, struct page **pages, int *nr)
>  {
> -- 
> 2.21.0.dirty
> 
