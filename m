Return-Path: <linuxppc-dev+bounces-18442-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCA2108E1F0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 11:33:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc3VJ3tX7z2ynW;
	Thu, 19 Mar 2026 22:33:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773920008;
	cv=none; b=USEoTzhFg3jDa11Qfu+fE3dhh5RGW+9abqu2jyUSTn2TA6mfQWh4jJ0CdKEFIkAup71vupRmbpeq2+JOMwmERxSkwPnfXrO4NnXR1N6SCH+kZAWQ2km+I7lvB8NVgDLWpKvo9Mqa1wGXWHj1uaqOnmWn6jUNFfAknvhCnYwS/xiHjhOQpmKOzsti1JMpsHh78vsT0N6aRxMOOSN1deJMgB2vAAh0zy4hfl4E8gdJKBglgsLSBKvS6YEoyVbY3xT0kxlYoB7wirrH+2QeUHyetr/p7V8nYTYaKVyFDMKYVPnf/BORG36n2WMrYLp1I9cgLHK+49QqWXlNAbM0x3raxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773920008; c=relaxed/relaxed;
	bh=Mk709h9QfQc31Mgzs3E6Rn/BwgzT7JyFrCPkHY171vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM+kRdccIFcSl/7ojIy1M09cJZ/xN7ekP2pglNBdpoArRTxSQYzXMamOaZKvvEh0GfD0aOyWFkpoLd+1z2RR0Ni21bOGK7v1oNSydRD4EpJOb0YR3qESvkwOGvFBx+MHbnu4qSU6ah+Wfj747LyYuM1/moGveToEpDOWKmwBWnag4TzKNsHcXTG2nuyLaStf5sRT9uO8JLDpQ/95sZLY8Gf9EgrWQ5k5Wlz48npOehBdkGt84QQ80PxvH45jDkeC+YUaGxz5oj2sg/Hz7TwEIWx0i3rvR1jmvVaI+j0ObVCOsseNYsWvTjALKEtZLFGceac6ktAFK/YHlSOjQeVveg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C5RAsODp; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C5RAsODp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc3VH3sD4z2yLG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 22:33:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6820B4013F;
	Thu, 19 Mar 2026 11:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A02EC19424;
	Thu, 19 Mar 2026 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920005;
	bh=d9ciODzpu+mpFYsWr5+dAHTFxxRafO6FyAjxRDFDoaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5RAsODpS2GkyED+enTEiBFq+aNwmkq3byYmpW6u8DjqN6x04s5ra+g2foF3lHDfP
	 09q9l45FghZx+GE9y/2fOJMu2e+A2NuuQB/jRCdVWLq+Kz/TuW8L0nWrf3if3t2jok
	 hPY3ztfM8xrxIS1Ex+VFrhyTltMtNjuqQHNw08d9272GUzVyYJKiZvCTPsVs2Q3uUc
	 iJZn0XUvYa5hlEjti3gjxL7A5jeyAJ0WFVJ8MabPChK/gzaf5s/dKfFKeXZ1Wiud1f
	 3L5kIqzT5ORF7KT+RXPSqHN3a7yUzWUvaNNvuKsyY7MMRz9LZmNMAvev6YXjafap09
	 PPKt2mBe15wjw==
Date: Thu, 19 Mar 2026 11:33:18 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] mm: change to return bool for
 pmdp_clear_flush_young()
Message-ID: <60e7cc1b-1459-44d8-8088-30b7ba3e9b44@lucifer.local>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <eb513ed809685f78e0abdeb7f7b6ebdec0fcca18.1773890510.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <eb513ed809685f78e0abdeb7f7b6ebdec0fcca18.1773890510.git.baolin.wang@linux.alibaba.com>

On Thu, Mar 19, 2026 at 11:24:03AM +0800, Baolin Wang wrote:
> The pmdp_clear_flush_young() is used to clear the young flag and flush the
> TLB, returning whether the young flag was set for this PMD entry. Change
> the return type to bool to make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Some nits, but otherwise LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  arch/s390/include/asm/pgtable.h |  4 ++--
>  arch/x86/include/asm/pgtable.h  |  4 ++--
>  arch/x86/mm/pgtable.c           |  6 +++---
>  include/linux/pgtable.h         | 10 +++++-----
>  mm/pgtable-generic.c            |  7 ++++---
>  5 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 1f5efb7be71d..90bba85ca4b8 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1693,8 +1693,8 @@ static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  }
>
>  #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
> -static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
> -					 unsigned long addr, pmd_t *pmdp)
> +static inline bool pmdp_clear_flush_young(struct vm_area_struct *vma,
> +					  unsigned long addr, pmd_t *pmdp)

Same indentation comment as with other patches, 2 tabs you know the drill :)
applies to all such in this patch.

>  {
>  	VM_BUG_ON(addr & ~HPAGE_MASK);
>  	return pmdp_test_and_clear_young(vma, addr, pmdp);
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index bd02ee730a23..f9439449c9bd 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1301,8 +1301,8 @@ extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
>  				     unsigned long addr, pud_t *pudp);
>
>  #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
> -extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
> -				  unsigned long address, pmd_t *pmdp);
> +extern bool pmdp_clear_flush_young(struct vm_area_struct *vma,
> +				   unsigned long address, pmd_t *pmdp);

Drop the extern please!

>
>
>  #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 10a5e0b2be36..8c336edf0e65 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -503,10 +503,10 @@ bool ptep_clear_flush_young(struct vm_area_struct *vma,
>  }
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -int pmdp_clear_flush_young(struct vm_area_struct *vma,
> -			   unsigned long address, pmd_t *pmdp)
> +bool pmdp_clear_flush_young(struct vm_area_struct *vma,
> +			    unsigned long address, pmd_t *pmdp)
>  {
> -	int young;
> +	bool young;
>
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e53220b0a9a3..8b8838f19af3 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -536,18 +536,18 @@ bool ptep_clear_flush_young(struct vm_area_struct *vma,
>
>  #ifndef __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
> -				  unsigned long address, pmd_t *pmdp);
> +bool pmdp_clear_flush_young(struct vm_area_struct *vma,
> +		unsigned long address, pmd_t *pmdp);

Ahh! Here you drop the extern :) AND use 2 tabs :)) thanks!

>  #else
>  /*
>   * Despite relevant to THP only, this API is called from generic rmap code
>   * under PageTransHuge(), hence needs a dummy implementation for !THP
>   */
> -static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
> -					 unsigned long address, pmd_t *pmdp)
> +static inline bool pmdp_clear_flush_young(struct vm_area_struct *vma,
> +		unsigned long address, pmd_t *pmdp)
>  {
>  	BUILD_BUG();
> -	return 0;
> +	return false;
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index db0ee918b08a..b91b1a98029c 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -124,10 +124,11 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
>  #endif
>
>  #ifndef __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
> -int pmdp_clear_flush_young(struct vm_area_struct *vma,
> -			   unsigned long address, pmd_t *pmdp)
> +bool pmdp_clear_flush_young(struct vm_area_struct *vma,
> +		unsigned long address, pmd_t *pmdp)
>  {
> -	int young;
> +	bool young;
> +
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  	young = pmdp_test_and_clear_young(vma, address, pmdp);
>  	if (young)
> --
> 2.47.3
>

