Return-Path: <linuxppc-dev+bounces-26766-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BDCC79FA0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 08:20:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfH1k69jlz2y8G;
	Tue, 08 Sep 2026 18:20:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::45"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788855626;
	cv=none; b=FKEydMQdn3/QGy9m4PAwjS6CNqphc5TYY+X2dtOK/GkXQGFHivpR4TI1STDVgudY8b9SSa7/2xuFxKeIQ0o35il/XWv2k9eTkG5rufVMENUyxOVU8ViymbAOuPdCvSsgHSS6hl4qajqkSnvMN5C5pnek+jm/XmPq/lNXO7ro4ppP0GdxIW/DtaErg1RmVKqvohk2Uc5RHHGR8GF5YnG/sBVEfgAjLc8Z0DppQhtN7EOxDWfeQvEbyls3gkSjIS00bDLGtEbiXYXKFoZVgTliH2AblH2jzy9ipQni5qc4PHtBz8ZhfKL9Nn5TQeHGruELCIFqAZ4+nEMi4E+hifvH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788855626; c=relaxed/relaxed;
	bh=5rULyjEYB8jc20wwyAECU26R5DmQW+vLixPMPPn/ka8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaVMkgSVfyA9ZW4g1ZYpFNMMT6qUZxco5gcCr7tBklj/GEqL7k7MTABIRhPIM19Js/CSwurmIvW6DOlpHcR5DH99E2quHLDE/QUdy34XWRe/h3hMSWeGgkEKJ6wdJX5+/gHGTMllFapE8rSm7J79HWTpdX6XRPT2zOOwdskHDNmLLRaLiHLnok/lIxGuoQh94F6fkfgWcCi3OpbNhIQCuwzn0zvrZYvXxKjfJh8Td671Dw8WonjrpoXTup/vthlPhw2coTUJvawtQ1WvvstFpl4ZhNmNoWsotVTgedbGJgIf9eDdrf0L5gYrlJhEFCJA0Z7jsC1n0CVNvnzVDLadOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xg67lryN; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::45; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xg67lryN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::45; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-69.mta0.migadu.com [IPv6:2001:41d0:1004:224b::45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfH1f4kdgz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 18:20:20 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=QMukAefZfPUgbpBQK+irv5yH2EpRpWK4MHebJsSatzY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788855601; v=1; x=1789460401;
 b=xg67lryNA+Q2GIQcWChikiwvGDVB5I/S93Sd26sq96BTE/kh8Rzxg/uGEcWxjtJJy7gQuO0Z
 6xh21eSrq0e+k+xIAZ/gtYqzg0+08NwhNoIF5ongyhDH1TtWg4V6NuWZVFPVq4033Ah9vbQj5KF
 1w/5fxtvwaUdKVlmf6c+WHic=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id e3be1945dc93c990;
	Tue, 08 Sep 2026 08:20:01 +0000
X-Mizu-Trace-ID: e3be1945dc93c990
X-Migadu-Flow: FLOW_OUT
Message-ID: <99aac41d-a68f-451b-ae10-f7132bb7a291@linux.dev>
Date: Tue, 8 Sep 2026 16:19:55 +0800
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
Subject: Re: [PATCH v2 07/11] mm/sparse-vmemmap: move HVO helpers to a public
 header
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
 <20260908030335.96549-8-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260908030335.96549-8-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/26 11:03 AM, Muchun Song wrote:
> The vmemmap optimization helpers currently live in mm/sparse.h,
> which is an internal MM header. That works for MM code, but
> prevents powerpc from using the same interfaces without including a
> private header.
> 
> Move the declarations and inline helpers to
> include/linux/vmemmap-optimization.h. This is a preparatory change for
> powerpc, which has its own vmemmap optimization implementation and
> needs to use the HVO interfaces from architecture code.

Make sense.

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2:
> - Fix missing header dependencies.
> ---
>   MAINTAINERS                          |  1 +
>   include/linux/vmemmap-optimization.h | 91 ++++++++++++++++++++++++++++
>   mm/hugetlb.c                         |  2 +-
>   mm/hugetlb_vmemmap.c                 |  2 +-
>   mm/memory_hotplug.c                  |  1 +
>   mm/sparse.h                          | 73 +---------------------
>   6 files changed, 96 insertions(+), 74 deletions(-)
>   create mode 100644 include/linux/vmemmap-optimization.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7aaa2e4790e..2985286cbbbf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12096,6 +12096,7 @@ F:	Documentation/mm/hugetlbfs_reserv.rst
>   F:	Documentation/mm/vmemmap_dedup.rst
>   F:	fs/hugetlbfs/
>   F:	include/linux/hugetlb.h
> +F:	include/linux/vmemmap-optimization.h
>   F:	include/trace/events/hugetlbfs.h
>   F:	mm/hugetlb.c
>   F:	mm/hugetlb_cgroup.c
> diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap-optimization.h
> new file mode 100644
> index 000000000000..492dc662aae7
> --- /dev/null
> +++ b/include/linux/vmemmap-optimization.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * vmemmap-optimization.h
> + *
> + * Generic vmemmap optimization declarations.
> + *
> + * Author: Muchun Song <songmuchun@bytedance.com>
> + */
> +#ifndef _LINUX_VMEMMAP_OPTIMIZATION_H
> +#define _LINUX_VMEMMAP_OPTIMIZATION_H
> +
> +#include <linux/align.h>
> +#include <linux/log2.h>
> +#include <linux/mmdebug.h>
> +#include <linux/mmzone.h>
> +
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
> +static inline unsigned int section_order(const struct mem_section *section)
> +{
> +	return section->order;
> +}
> +
> +static inline void section_set_order(struct mem_section *section, unsigned int order)
> +{
> +	VM_WARN_ON(section_order(section) && order && section_order(section) != order);
> +	section->order = order;
> +}
> +
> +static inline void section_set_order_range(unsigned long pfn, unsigned long nr_pages,
> +					   unsigned int order)
> +{
> +	unsigned long section_nr = pfn_to_section_nr(pfn);
> +
> +	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION))
> +		return;
> +
> +	for (unsigned long i = 0; i < nr_pages / PAGES_PER_SECTION; i++)
> +		section_set_order(__nr_to_section(section_nr + i), order);
> +}
> +
> +static inline unsigned int pfn_to_section_order(unsigned long pfn)
> +{
> +	return section_order(__pfn_to_section(pfn));
> +}
> +#else
> +static inline unsigned int section_order(const struct mem_section *section)
> +{
> +	return 0;
> +}
> +
> +static inline void section_set_order(struct mem_section *section, unsigned int order)
> +{
> +}
> +
> +static inline void section_set_order_range(unsigned long pfn, unsigned long nr_pages,
> +					   unsigned int order)
> +{
> +}
> +
> +static inline unsigned int pfn_to_section_order(unsigned long pfn)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION */
> +
> +static inline bool vmemmap_optimizable_pfn(unsigned long pfn)
> +{
> +	const unsigned int order = pfn_to_section_order(pfn);
> +	const unsigned long nr_pages = 1UL << order;
> +
> +	if (!is_power_of_2(sizeof(struct page)))
> +		return false;
> +
> +	return (pfn & (nr_pages - 1)) >= VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES;
> +}
> +
> +static inline bool vmemmap_optimizable_order(unsigned int order)
> +{
> +	if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION))
> +		return false;
> +
> +	if (!is_power_of_2(sizeof(struct page)))
> +		return false;
> +
> +	return order >= VMEMMAP_OPTIMIZATION_MIN_ORDER;
> +}
> +
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
> +#endif /* CONFIG_SPARSEMEM_VMEMMAP */
> +#endif /* _LINUX_VMEMMAP_OPTIMIZATION_H */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index fda525bccf50..dff915e6c48b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -38,6 +38,7 @@
>   #include <linux/mm_inline.h>
>   #include <linux/padata.h>
>   #include <linux/pgalloc.h>
> +#include <linux/vmemmap-optimization.h>
>   
>   #include <asm/page.h>
>   #include <asm/tlb.h>
> @@ -52,7 +53,6 @@
>   #include "hugetlb_cma.h"
>   #include "hugetlb_internal.h"
>   #include "mm_init.h"
> -#include "sparse.h"
>   #include <linux/page-isolation.h>
>   
>   #define HUGE_BOOTMEM_ZONES_VALID	BIT(0)
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 4a57e6c3352c..25c4e7d2664c 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -15,10 +15,10 @@
>   #include <linux/mmdebug.h>
>   #include <linux/pagewalk.h>
>   #include <linux/pgalloc.h>
> +#include <linux/vmemmap-optimization.h>
>   
>   #include <asm/tlbflush.h>
>   #include "hugetlb_vmemmap.h"
> -#include "sparse.h"
>   #include "internal.h"
>   
>   /**
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0db0379826df..d7a59167bec4 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -43,6 +43,7 @@
>   #include "mm_init.h"
>   #include "page_alloc.h"
>   #include "shuffle.h"
> +#include "sparse.h"
>   
>   enum {
>   	MEMMAP_ON_MEMORY_DISABLE = 0,
> diff --git a/mm/sparse.h b/mm/sparse.h
> index 59b825df83b9..e511d99fc26b 100644
> --- a/mm/sparse.h
> +++ b/mm/sparse.h
> @@ -9,77 +9,7 @@
>   #define __MM_SPARSE_H
>   
>   #include <linux/mmzone.h>
> -
> -#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
> -static inline unsigned int section_order(const struct mem_section *section)
> -{
> -	return section->order;
> -}
> -
> -static inline void section_set_order(struct mem_section *section, unsigned int order)
> -{
> -	VM_WARN_ON(section_order(section) && order && section_order(section) != order);
> -	section->order = order;
> -}
> -
> -static inline void section_set_order_range(unsigned long pfn, unsigned long nr_pages,
> -					   unsigned int order)
> -{
> -	unsigned long section_nr = pfn_to_section_nr(pfn);
> -
> -	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION))
> -		return;
> -
> -	for (unsigned long i = 0; i < nr_pages / PAGES_PER_SECTION; i++)
> -		section_set_order(__nr_to_section(section_nr + i), order);
> -}
> -
> -static inline unsigned int pfn_to_section_order(unsigned long pfn)
> -{
> -	return section_order(__pfn_to_section(pfn));
> -}
> -#else
> -static inline unsigned int section_order(const struct mem_section *section)
> -{
> -	return 0;
> -}
> -
> -static inline void section_set_order(struct mem_section *section, unsigned int order)
> -{
> -}
> -
> -static inline void section_set_order_range(unsigned long pfn, unsigned long nr_pages,
> -					   unsigned int order)
> -{
> -}
> -
> -static inline unsigned int pfn_to_section_order(unsigned long pfn)
> -{
> -	return 0;
> -}
> -#endif
> -
> -static inline bool vmemmap_optimizable_pfn(unsigned long pfn)
> -{
> -	const unsigned int order = pfn_to_section_order(pfn);
> -	const unsigned long nr_pages = 1UL << order;
> -
> -	if (!is_power_of_2(sizeof(struct page)))
> -		return false;
> -
> -	return (pfn & (nr_pages - 1)) >= VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES;
> -}
> -
> -static inline bool vmemmap_optimizable_order(unsigned int order)
> -{
> -	if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION))
> -		return false;
> -
> -	if (!is_power_of_2(sizeof(struct page)))
> -		return false;
> -
> -	return order >= VMEMMAP_OPTIMIZATION_MIN_ORDER;
> -}
> +#include <linux/vmemmap-optimization.h>
>   
>   /*
>    * mm/sparse.c
> @@ -139,7 +69,6 @@ static inline void sparse_sections_init(void) {}
>    * mm/sparse-vmemmap.c
>    */
>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -struct page *vmemmap_shared_tail_page(unsigned int order, struct zone *zone);
>   void sparse_init_subsection_map(void);
>   int section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
>   		struct vmem_altmap *altmap, struct dev_pagemap *pgmap);


