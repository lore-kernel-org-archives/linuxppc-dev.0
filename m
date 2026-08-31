Return-Path: <linuxppc-dev+bounces-26289-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80258C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 12:24:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYSpY0qRyz2xpn;
	Mon, 31 Aug 2026 22:24:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::73"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788169600;
	cv=none; b=KgoTNzL3qsa8CVAhGg4Q+aKARIlsQ3mG5ndZJwWNTJet8hJrQsqXXk2ZE2pD8Bvrh1ZCBE+FVa9GdpY4nvj6yaoDQWk4pvxhrPsvLG8Kpb7fL/7Gc/lb8HCn3a9M+UTtXLVn97ntqEk2cOu5pdu6b+YqWeD7/G94SvhRdfAly92Pch8FYFTiBHQgkLqnFTNc5ym60zyiniyv7PZDf1DnnBGhbWH2lLiYMZ5mKzIbrN37iebdvTx90PRvK50uTUWu62K/OZgUIz0SQCT1MyIGXtphVs00j3UYQ6P4rSIfMB39inSgS7ijrYUxzVXQ2vKJf6JWHHL4bHLasZUQ8Vye8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788169600; c=relaxed/relaxed;
	bh=lssN/+g4CsD3iBF3KDZ0/HynoTt5PqQamjTFAdGkwv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPPVjKxDi+uqK5li95haph7PenDBmKhRugrTnBseLAqPq1d2RgBuYTmxWuvaJHFRar/nFYkdc2xATcdsEnTyXkBP5ZaJCcfgJ/CsofPec0H4n7Iq+G6zc7EXN724j5ntLDhPc2VvAPtbo51BfGwA8poKxH4kPRKtYwaRvsscXhvYqiBYcfy/YVNVE6PcU0doREoe1vxXRrS9xrqndHFAVcA52X/+ly0RY+p9MLOMgFKfoqRU2ur8JysGgsu6TxK/5B46SMi/JYaLRAENcyNEdUDYTFBlMLR4sMWaUBSmqgNMsD//dP5wPztKWbI9jhwR6qCcJMaPbzvXrCMT9bJBwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d/xv5z2o; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::73; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d/xv5z2o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::73; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 79 seconds by postgrey-1.37 at boromir; Mon, 31 Aug 2026 19:46:36 AEST
Received: from mta0.migadu.com (out-115.mta0.migadu.com [IPv6:2001:41d0:1004:224b::73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYPJr5Vd5z2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 19:46:36 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=fQebo7Azp0AKIE2puaSGtaPeAdhrfMBt6pp9DjsjoIY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788169578; v=1; x=1788774378;
 b=d/xv5z2oTErHPmEyKM3NtxKBEzR7SXmSemyKCQ0vf6EM7wlXaZbSFZVmdNqnFKMqxps+EIlB
 MjvYsUI7/jBfvWtXHhBYL0m07Eyhm103KmdHHM9MoNkxS6/5+GsYAGRutQOlgc1V9RJ7n3pY3oe
 DCAhRkVerq5TJVt/+lIJuZco=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 9880a24a06b3ebf9;
	Mon, 31 Aug 2026 09:44:55 +0000
X-Mizu-Trace-ID: 9880a24a06b3ebf9
X-Migadu-Flow: FLOW_OUT
Message-ID: <0e1c3bb8-49a4-479e-adb3-17c21261d409@linux.dev>
Date: Mon, 31 Aug 2026 17:44:46 +0800
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
Subject: Re: [PATCH 01/11] mm/sparse-vmemmap: introduce
 CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
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
References: <20260831075342.57563-1-songmuchun@bytedance.com>
 <20260831075342.57563-2-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260831075342.57563-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/26 3:53 PM, Muchun Song wrote:
> The section-based vmemmap optimization infrastructure is still guarded by
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP, but it also can be used by device
> DAX. Introduce CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION as a common config
> for the shared infrastructure.
> 
> Select the new option from HUGETLB_PAGE_OPTIMIZE_VMEMMAP and from
> DEV_DAX when the architecture opts in to DAX vmemmap optimization, and
> use it to guard the generic sparse-vmemmap state and helpers.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   arch/x86/entry/vdso/vdso32/fake_32bit_build.h |  2 +-
>   drivers/dax/Kconfig                           |  1 +
>   fs/Kconfig                                    |  1 +
>   include/linux/mm.h                            |  3 +++
>   include/linux/mmzone.h                        | 13 +++++++------
>   include/linux/page-flags.h                    |  5 ++---
>   mm/Kconfig                                    |  3 +++
>   mm/sparse.h                                   |  4 ++--
>   8 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
> index bc3e549795c3..5f8424eade2b 100644
> --- a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
> +++ b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
> @@ -11,7 +11,7 @@
>   #undef CONFIG_PGTABLE_LEVELS
>   #undef CONFIG_ILLEGAL_POINTER_VALUE
>   #undef CONFIG_SPARSEMEM_VMEMMAP
> -#undef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +#undef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
>   #undef CONFIG_NR_CPUS
>   #undef CONFIG_PARAVIRT_XXL
>   
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index 602f9a0839a9..85ad4c135cdd 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -8,6 +8,7 @@ if DAX
>   config DEV_DAX
>   	tristate "Device DAX: direct access mapping device"
>   	depends on TRANSPARENT_HUGEPAGE
> +	select SPARSEMEM_VMEMMAP_OPTIMIZATION if ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
>   	help
>   	  Support raw access to differentiated (persistence, bandwidth,
>   	  latency...) memory via an mmap(2) capable character
> diff --git a/fs/Kconfig b/fs/Kconfig
> index d1c210c6508f..9b32ce79cc80 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -278,6 +278,7 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>   	def_bool HUGETLB_PAGE
>   	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>   	depends on SPARSEMEM_VMEMMAP
> +	select SPARSEMEM_VMEMMAP_OPTIMIZATION
>   
>   config HUGETLB_PMD_PAGE_TABLE_SHARING
>   	def_bool HUGETLB_PAGE
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a9fbe26536f4..edadd7549b72 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -5188,6 +5188,9 @@ static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
>   	unsigned long nr_pages;
>   	unsigned long nr_vmemmap_pages;
>   
> +	if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION))
> +		return false;
> +
>   	if (!pgmap || !is_power_of_2(sizeof(struct page)))
>   		return false;
>   
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index c9ae7991a8b2..e9b54ea0eff0 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -102,9 +102,9 @@
>    *
>    * HVO which is only active if the size of struct page is a power of 2.
>    */
> -#define MAX_FOLIO_VMEMMAP_ALIGN \
> -	(IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) && \
> -	 is_power_of_2(sizeof(struct page)) ? \
> +#define MAX_FOLIO_VMEMMAP_ALIGN					\
> +	(IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION) &&	\
> +	 is_power_of_2(sizeof(struct page)) ?			\
>   	 MAX_FOLIO_NR_PAGES * sizeof(struct page) : 0)
>   
>   /* The number of retained vmemmap pages with HVO enabled. */
> @@ -116,7 +116,8 @@
>   #define __VMEMMAP_OPTIMIZATION_NR_ORDERS	\
>   	(MAX_FOLIO_ORDER - VMEMMAP_OPTIMIZATION_MIN_ORDER + 1)
>   #define VMEMMAP_OPTIMIZATION_NR_ORDERS		\
> -	(__VMEMMAP_OPTIMIZATION_NR_ORDERS > 0 ? __VMEMMAP_OPTIMIZATION_NR_ORDERS : 0)
> +	((__VMEMMAP_OPTIMIZATION_NR_ORDERS > 0 &&	\
> +	  IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION)) ? __VMEMMAP_OPTIMIZATION_NR_ORDERS : 0)
>   
>   enum migratetype {
>   	MIGRATE_UNMOVABLE,
> @@ -1155,7 +1156,7 @@ struct zone {
>   	/* Zone statistics */
>   	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
>   	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
> -#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
>   	struct page *vmemmap_tails[VMEMMAP_OPTIMIZATION_NR_ORDERS];
>   #endif
>   } ____cacheline_internodealigned_in_smp;
> @@ -2019,7 +2020,7 @@ struct mem_section {
>   	unsigned long section_mem_map;
>   
>   	struct mem_section_usage *usage;
> -#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
>   	/*
>   	 * Normally, sections hold regular (order-0) pages. However, for
>   	 * sections with HVO enabled, this tracks the compound page order
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index ae2ebaed6d4d..de3c06062bc6 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -208,14 +208,13 @@ enum pageflags {
>   static __always_inline bool compound_info_has_mask(void)
>   {
>   	/*
> -	 * Limit mask usage to HugeTLB vmemmap optimization (HVO) where it
> -	 * makes a difference.
> +	 * Limit mask usage to HVO where it makes a difference.
>   	 *
>   	 * The approach with mask would work in the wider set of conditions,
>   	 * but it requires validating that struct pages are naturally aligned
>   	 * for all orders up to the MAX_FOLIO_ORDER, which can be tricky.
>   	 */
> -	if (!IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP))
> +	if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION))
>   		return false;
>   
>   	return is_power_of_2(sizeof(struct page));
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c1ddf59c0d71..b5f8372cd164 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -461,6 +461,9 @@ config SPARSEMEM_VMEMMAP
>   	  pfn_to_page and page_to_pfn operations.  This is the most
>   	  efficient option when sufficient kernel resources are available.
>   
> +config SPARSEMEM_VMEMMAP_OPTIMIZATION
> +	bool

As sashiko was concerned about [1], it seems we need to add

         depends on SPARSEMEM_VMEMMAP

here.

Apart from that, LGTM. With this fix included:

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi

[1]. 
https://sashiko.dev/#/patchset/20260831075342.57563-1-songmuchun%40bytedance.com

> +
>   #
>   # Select this config option from the architecture Kconfig, if it is preferred
>   # to enable the feature of HugeTLB/dev_dax vmemmap optimization.
> diff --git a/mm/sparse.h b/mm/sparse.h
> index 049272aba84e..b408d15baf7b 100644
> --- a/mm/sparse.h
> +++ b/mm/sparse.h
> @@ -10,7 +10,7 @@
>   
>   #include <linux/mmzone.h>
>   
> -#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
>   static inline unsigned int section_order(const struct mem_section *section)
>   {
>   	return section->order;
> @@ -72,7 +72,7 @@ static inline bool vmemmap_optimizable_pfn(unsigned long pfn)
>   
>   static inline bool vmemmap_optimizable_order(unsigned int order)
>   {
> -	if (!IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP))
> +	if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION))
>   		return false;
>   
>   	if (!is_power_of_2(sizeof(struct page)))


