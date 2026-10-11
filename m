Return-Path: <linuxppc-dev+bounces-29194-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78A5CA9EC7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2026 14:30:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2jfz4kLDz2yY0;
	Mon, 12 Oct 2026 01:30:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791729003;
	cv=none; b=nf2SxR6igym5qDaShiVOv0vz2BcNoC/1TyKU8PcWLpuxfpXeEofsS/PgTOi3Zp4DbyH4nyzx5PDdR8+JikMtRFUM1sFPnWfCXoVw0at7CFV75YLCr26WhvVAmXEVgAD/+b3CisYKsEDDRMgcy611XLi/zZTRIbagpCIuXDubMbR15bOuVOJ4uknmPCAKuOFs9UtfzrlOwtV8npEKpCwOjP4KiLDOczHGT1tsl7P2smqL+1KXUG0dbIXKnj11ZRdWmKHs1UQlNkR+Qm6/Bwihfm5D7fGYwm/xroEhkHX55p+wfwHjFoVgo1qGCkk7uYATp4wjdI3eEPvfl9lGckUy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791729003; c=relaxed/relaxed;
	bh=tDlRoiYs+oXn7JVOx13TUze+GLTM7H/QsH7PUCzNbOI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlI898YFeBb+R+6d1PxmZs32CvIKsPwgqBwVr2ozr85zyHbaF+qK0S+ZZ3DSF0CMtjFeYGnlCkLvhSZmrYb88QNjPLsRl8Wh3FXSHP4rGwboB3+8Gtyf4FNdpqHNAN7w9RJzuS/Y3WUs5Zxy8941hwT4NzwkEh8VfUn5rkHFFy2eFwsm15kDV2ylna9psZcFuyIeUnRzQ9EFzJ4T8EL1CvVXV1wB6LDWYIy6l7wyYrz0hIwUlrSYKQEun0UIS8R/JVESHRnLuJ7/tyuf8GhZvDw+TKi0gjZlbbtIofwU8o5756RTUIz9h2bMgAhk223NC9XdDrDCQRfADczBOzRtBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B6vsr7NT; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B6vsr7NT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2jfx6Ns4z2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 01:30:01 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c2e5d08214dso149438066b.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791728998; x=1792333798; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tDlRoiYs+oXn7JVOx13TUze+GLTM7H/QsH7PUCzNbOI=;
        b=B6vsr7NTk9+E53+D8RfNEkfmX0UL3UVwh9Me7B4by/Uxgs6AdbLbwsj4ICWo8inag6
         GHY/EdpDj6OrNZR2p+7Y8Bgg3ma3Tg0ImPXDeDwt+NI6JCJE1sHgN1TgYrYcozrrHAvx
         LvRa4GhPU4S2icePIjAdi2BtTDvNQPmaJcaHuk2faTBdkNvGSaI3ITYpEQRXaGIxInwp
         0evAFLhH32IkGcybZb+NkQle8T6KQUzHLqSqi4XcDskF3JoSHeQlcKVW1P+ZsWcmS7YZ
         RIHsv66GFP/u+e9GaWKCGu9svVoGGTzRJoINWuvnPCF7JayeM/GsovoUhpPuLF/heGtN
         0BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791728998; x=1792333798;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDlRoiYs+oXn7JVOx13TUze+GLTM7H/QsH7PUCzNbOI=;
        b=C+sPXwHNeQlC5v7xpRljIOM+9xG1/JR/fH/TIk5G3k5MkefrtbPVcNkhXAg2yiod2I
         k94BHLP8nzYI+FeLMHPGQcjSgD2VMyH6xLKgF0n8Og1gafgU+L5wdzAksCQ56zh5r/+e
         T5fRq/CNVa6He36Zvp3qdocl/ijEZm/PKBHpl3FMvl0udkVWc7gm0+mZB/YEG8lGvl2u
         Padm7/te8La7XgVuDkl/dd5WQs/JJ7B+Q9hJXWsnDTNX3TGe/zbQG731JGjS8yyXr4Ms
         HTrom//Jm+zAB4WtcBIIXIYwWRZ0SyOZE9rL7CWCzaji4zTsPbmQvmsWZ6zVI2dhNKMc
         EpTQ==
X-Forwarded-Encrypted: i=1; AKwUvByF8nCiHVXZqUR40King6Cuzx70LnuuVr+/ijYkG3X/O1z9F829e00r8flU5bAQwhI6s6Quaz6dRUg/7Ag=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI7T6HvC92MuirmQP5j+0vYzDnfyfU6uqPFT65QTPow7bcNAz1v
	7H1lqQPYphsZCWGaswjUAogdGC5fwLUKJMY1ckRZsQ2ahzkLFXDyJ2CV
X-Gm-Gg: AYBFou25B712b36pB2Ssz3bwhoYwJ1e6HK1k5YL6KK3UDMnQPNyMQT3ZqnGw70MPVv6
	OeFFUxi5IcKYWW8EjWT+ASWIERy9/qsPv9G+0+r7upRtdO9HYqZ/wVcqqwxGAe/pswyJn8ztqj5
	Vi1HLc6MgO3cWi7A0rHK0qlHr8DSd9pAGPcQd+DEvneC51OvLOiIsmFaaeRA52NiwIL9PRkEomC
	hnNxMSpBpsnmf8s1gnxElnuN4xZ7A7GXUpT6lmw2busBuRtzVPqLljKiTdeZnKKBa4u2ryiVGLV
	+ak0SesfhpaMMYotpw+kXQ42Ewe9myVcPwZ2n1r2iFDCxk1SFJcahpApvDXC13WVrwq/dRCPk6c
	fT3JmTW9fcLVlRUF4jTgdhvH1QaCfzXES1jMl24Vpemq72geBRF1Rg36oHIu4VllvxmLD6iS7Fn
	lY+9rwIZFAx3qi8mzVU80zKj8HNTxhgjhqU2nV
X-Received: by 2002:a17:907:3f25:b0:c31:82aa:dd4c with SMTP id a640c23a62f3a-c31a9d15f06mr712746366b.24.1791728997857;
        Sun, 11 Oct 2026 07:29:57 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c34f8bd471dsm13420566b.9.2026.10.11.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 07:29:57 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Sun, 11 Oct 2026 16:29:55 +0200
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org,
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org,
	chleroy@kernel.org, david@kernel.org, dev.jain@arm.com,
	jiangwen6@xiaomi.com, leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v10 03/10] mm/vmalloc: use
 pte_set_huge()/pte_clear_huge() for PTE-level block mappings
Message-ID: <asudY_EhrT5fZGmZ@milan>
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
 <20261002090947.869220-4-jiangwen6@xiaomi.com>
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
In-Reply-To: <20261002090947.869220-4-jiangwen6@xiaomi.com>

On Fri, Oct 02, 2026 at 05:09:40PM +0800, Wen Jiang wrote:
> vmap installs PTE-level block mappings by reusing set_huge_pte_at() and
> huge_ptep_get_and_clear() under #ifdef CONFIG_HUGETLB_PAGE. This makes
> the feature silently unavailable on CONFIG_HUGETLB_PAGE=n kernels and
> couples mm/vmalloc.c to HugeTLB internals it does not otherwise need.
> 
> Now that arm64 and powerpc/8xx provide pte_set_huge() and
> pte_clear_huge(), add the generic fallbacks next to the existing
> pmd/pud_set_huge() family and convert vmap_pte_range() and
> vunmap_pte_range() to the new helpers. The CONFIG_HUGETLB_PAGE guards
> around the block-mapping paths are dropped, so PTE-level block mappings
> now also work on CONFIG_HUGETLB_PAGE=n kernels, and mm/vmalloc.c no
> longer includes <linux/hugetlb.h>.
> 
> The fallbacks exist only to keep the build working on architectures
> without PTE-level block mapping support. They are unreachable there:
> the callers only run when arch_vmap_pte_range_map_size() or
> arch_vmap_pte_range_unmap_size() return a size other than PAGE_SIZE,
> which requires an arch implementation. BUILD_BUG() makes that
> explicit rather than silently doing nothing.
> 
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---
>  include/linux/pgtable.h | 29 +++++++++++++++++++++++++++++
>  mm/vmalloc.c            | 19 ++++++-------------
>  2 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8c093c119e5a8..a7fd51fec8a17 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -2204,6 +2204,35 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>  }
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
>  
> +/*
> + * PTE-level block mappings for vmap.
> + *
> + * pte_set_huge() only has to be implemented by architectures whose
> + * arch_vmap_pte_range_map_size() can return a size other than PAGE_SIZE.
> + */
> +#ifndef __HAVE_ARCH_PTE_SET_HUGE
> +static inline void pte_set_huge(pte_t *ptep, unsigned long addr,
> +				phys_addr_t phys, pgprot_t prot,
> +				unsigned long size)
> +{
> +	BUILD_BUG();
> +}
> +#endif
> +
> +/*
> + * Likewise, pte_clear_huge() only has to be implemented by architectures
> + * whose arch_vmap_pte_range_unmap_size() can return a size other than
> + * PAGE_SIZE.
> + */
> +#ifndef __HAVE_ARCH_PTE_CLEAR_HUGE
> +static inline pte_t pte_clear_huge(pte_t *ptep, unsigned long addr,
> +				   unsigned long size)
> +{
> +	BUILD_BUG();
> +	return __pte(0);
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  /*
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index bea9f76ed7e74..fb757d95bde25 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -38,7 +38,6 @@
>  #include <linux/rbtree_augmented.h>
>  #include <linux/overflow.h>
>  #include <linux/pgtable.h>
> -#include <linux/hugetlb.h>
>  #include <linux/sched/mm.h>
>  #include <asm/tlbflush.h>
>  #include <asm/shmparam.h>
> @@ -100,7 +99,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	pte_t *pte;
>  	u64 pfn;
>  	struct page *page;
> -	unsigned long size = PAGE_SIZE;
> +	unsigned long size;
>  
>  	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
>  		return -EINVAL;
> @@ -121,17 +120,12 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  			BUG();
>  		}
>  
> -#ifdef CONFIG_HUGETLB_PAGE
>  		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
>  		if (size != PAGE_SIZE) {
> -			pte_t entry = pfn_pte(pfn, prot);
> -
> -			entry = arch_make_huge_pte(entry, ilog2(size), 0);
> -			set_huge_pte_at(&init_mm, addr, pte, entry, size);
> +			pte_set_huge(pte, addr, PFN_PHYS(pfn), prot, size);
>
As far as i understand, X86_64 arches do not use this path. This
specifically is only for ARM64 or powerpc. pte_set_huge() makes me
thinking about huge-page mappings(PMD/PUD/hugetlb). This helper is
about mutli page mapping on the PTE level.

Better naming? pte_set_large()?

Any thoughts?

Other then that:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

