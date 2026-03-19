Return-Path: <linuxppc-dev+bounces-18441-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C847108E1F3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 11:32:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc3Sp1bVgz2ynW;
	Thu, 19 Mar 2026 22:32:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773919930;
	cv=none; b=HBddhnkgnJLWlqShJ77s7COkDNiKazu41tG0d8sPPaH3YQlSPFHyfy/uA2enK/7adAfoYc7agIVG4H21z+At7jQTAHtfzAZRqh/N4vZsOJhbVmQq9HiP+RIGB8SDSqRJqmvbZk2MjQJGE4zsLX97SAMMhHo3GjQKQK1tckf7kfWvjU5edSl1fegyGUKK0fY0OgX/72iZYR4a71NFGFUf9U/Ye87r1gXj7fPHPToT9gbbMXLwvPC/PcuPTiK8cGUEit630c157F1jm2PuVOAav4ZfaNUFfsYhTSeBkHHkk/HcbI8qzZ3DmmnBOf4pqP+LZmbyMmnWOrP+gH2+5tNUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773919930; c=relaxed/relaxed;
	bh=Y63+VS6Ui6u2uD65V7I/tnWHyuvPlwZc8zO/RDjC0zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9b8YpcZqdT26BbHI8K9Ly7rxSVDh17pyGGtwHEr1hwWkI2Rd/zJFZzFno+6q/aXd1SGPp8Pmn09rHZQkZiTA3z6KTtwjwj1FgxeY+1gw/DD07azOOQg+HCgoygRkoLuSVntxpdNBztvhmpTd3EUPXFZawNxaTC+MhPCXKff9haOKws4MnsOrLV1lVzaG0BXqpQVnIOGPXuji0PqwvSey9a1P9QrKj0ZxkCfGxiLEs8BKpdW3GdXgwxbAZ6MTo2SvgAbnQeCbIbA+v3AxBDF6CwFNRTPh3egHFocW7FvmmjHeX9CLiy+YZkDyyNlDjcWcGdbDyKswZtYvPKOYOK2lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X2OyEQky; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X2OyEQky;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc3Sn2kpsz2yLG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 22:32:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A9AFA600AD;
	Thu, 19 Mar 2026 11:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ECBC19424;
	Thu, 19 Mar 2026 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773919926;
	bh=ugQLkf+Im/G2ICHzfRRGmINpZCFsd5Ug2LKZKDtrCQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2OyEQkyM6gUfaXokm8qxkuv0WTQ10u+7Ts4unJj/PT1yGFvsITG7LB/Td5BC6kGR
	 kFrpofMPgQALPtj6R6PdXlViWz9aW87C/3LOV16eT02ve0oMBCkKvzVXVKrhF2MK+M
	 ljkDYbXZQ3ywYYxmHkIQigMocTVr+c+qn77LgA35CNdezZ0tk1MFeWl5oaPIyZEg+9
	 VphrsyzoEREy7BFbtc+/nj/sm3FQCeYEHDiNG3V2SIkxeqOf+iGj1ZEskGD9MDJkzt
	 CaE9smJJ38g5f7JqtzLcCFYJjDlVv5oq7rr2n6trUdfLlelwiW1/WeF+vw5SIetes6
	 YRHJNiULNqD4A==
Date: Thu, 19 Mar 2026 11:31:59 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: change to return bool for
 pmdp_test_and_clear_young()
Message-ID: <4cf8eac4-f601-4f39-8094-d904edbf454d@lucifer.local>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>

On Thu, Mar 19, 2026 at 11:24:02AM +0800, Baolin Wang wrote:
> Callers use pmdp_test_and_clear_young() to clear the young flag and check
> whether it was set for this PMD entry. Change the return type to bool to
> make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Some nits similar to before, otherwise LGTM so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  arch/arm64/include/asm/pgtable.h             |  6 +++---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
>  arch/riscv/include/asm/pgtable.h             |  2 +-
>  arch/s390/include/asm/pgtable.h              |  4 ++--
>  arch/x86/include/asm/pgtable.h               |  4 ++--
>  arch/x86/mm/pgtable.c                        |  6 +++---
>  include/linux/pgtable.h                      | 19 +++++++++----------
>  8 files changed, 27 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 393a9d1873f6..7ea16f6ad564 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1321,9 +1321,9 @@ static inline bool __ptep_clear_flush_young(struct vm_area_struct *vma,
>
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> -static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -					    unsigned long address,
> -					    pmd_t *pmdp)
> +static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +					     unsigned long address,
> +					     pmd_t *pmdp)

Similar comment as before re: indetation, let's use 2 tabs please, so this would
become:

static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
		unsigned long address, pmd_t *pmdp)

Thanks!

Same comment to all other cases here.

>  {
>  	/* Operation applies to PMD table entry only if FEAT_HAFT is enabled */
>  	VM_WARN_ON(pmd_table(READ_ONCE(*pmdp)) && !system_supports_haft());
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 25e3a86943e2..0f34011665a6 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1161,13 +1161,13 @@ pud_hugepage_update(struct mm_struct *mm, unsigned long addr, pud_t *pudp,
>   * For radix we should always find H_PAGE_HASHPTE zero. Hence
>   * the below will work for radix too
>   */
> -static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
> -					      unsigned long addr, pmd_t *pmdp)
> +static inline bool __pmdp_test_and_clear_young(struct mm_struct *mm,
> +					       unsigned long addr, pmd_t *pmdp)
>  {
>  	unsigned long old;
>
>  	if ((pmd_raw(*pmdp) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
> -		return 0;
> +		return false;
>  	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
>  	return ((old & _PAGE_ACCESSED) != 0);
>  }
> @@ -1300,8 +1300,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
>  				 pud_t entry, int dirty);
>
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> -extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -				     unsigned long address, pmd_t *pmdp);
> +extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +				      unsigned long address, pmd_t *pmdp);

Remove the extern please!

>  #define __HAVE_ARCH_PUDP_TEST_AND_CLEAR_YOUNG
>  extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
>  				     unsigned long address, pud_t *pudp);
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index 4b09c04654a8..aed39bba891e 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -98,8 +98,8 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>  }
>
>
> -int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -			      unsigned long address, pmd_t *pmdp)
> +bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +			       unsigned long address, pmd_t *pmdp)
>  {
>  	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
>  }
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 11f57ccf6dc9..bac559d29036 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -1015,7 +1015,7 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
>  }
>
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> -static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  					unsigned long address, pmd_t *pmdp)
>  {
>  	return ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index c9ab81caaf75..1f5efb7be71d 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1683,8 +1683,8 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
>  }
>
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> -static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -					    unsigned long addr, pmd_t *pmdp)
> +static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +					     unsigned long addr, pmd_t *pmdp)
>  {
>  	pmd_t pmd = *pmdp;
>
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 554dea93eb99..bd02ee730a23 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1295,8 +1295,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
>  				 pud_t entry, int dirty);
>
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> -extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -				     unsigned long addr, pmd_t *pmdp);
> +extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +				      unsigned long addr, pmd_t *pmdp);

Remove the extern please!

>  extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
>  				     unsigned long addr, pud_t *pudp);
>
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 0007dc3d739e..10a5e0b2be36 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -456,10 +456,10 @@ bool ptep_test_and_clear_young(struct vm_area_struct *vma,
>  }
>
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
> -int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -			      unsigned long addr, pmd_t *pmdp)
> +bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +			       unsigned long addr, pmd_t *pmdp)
>  {
> -	int ret = 0;
> +	bool ret = false;
>
>  	if (pmd_young(*pmdp))
>  		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 1198e216fde3..e53220b0a9a3 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -507,25 +507,24 @@ static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
>
>  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
> -static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -					    unsigned long address,
> -					    pmd_t *pmdp)
> +static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +		unsigned long address, pmd_t *pmdp)
>  {
>  	pmd_t pmd = *pmdp;
> -	int r = 1;
> +	bool young = true;
> +
>  	if (!pmd_young(pmd))
> -		r = 0;
> +		young = false;
>  	else
>  		set_pmd_at(vma->vm_mm, address, pmdp, pmd_mkold(pmd));
> -	return r;
> +	return young;
>  }
>  #else
> -static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -					    unsigned long address,
> -					    pmd_t *pmdp)
> +static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +		unsigned long address, pmd_t *pmdp)
>  {
>  	BUILD_BUG();
> -	return 0;
> +	return false;
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG */
>  #endif
> --
> 2.47.3
>

