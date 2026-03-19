Return-Path: <linuxppc-dev+bounces-18443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD72D108E1F3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 11:34:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc3WN1y6mz2ynW;
	Thu, 19 Mar 2026 22:34:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773920064;
	cv=none; b=KUb9aY/1mrNpKB7n8QTcWWQVFRCaB74MLvtrIkdqAw9WlVFnStK6L9wwpyTo5V9p35AIgMYydGO6EWbT4nWPHJE8NxBoRWPMci3vMmKHMz+VjL9xzkNR+Sim01X9H/XEitYOTrLLGYje1fGdLkHjwvOXNP1rldGpI8/NbVyk0zGX2j3vuJJU8+0ux0c9XvxBD2A3FIbsCubnW5TTICMZYm3KSx8Bk9n7px4ZNlJHUaGZy9msJMOWk0aAayzXJeDum+k0r03HKyRjthgWJuzKE2U1HQBQded25qf4wrdQMO4p4Gc6pbHz9ro0zDOji7uheXn/CO17oURJ7/DYjeo5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773920064; c=relaxed/relaxed;
	bh=cP2v8J77qhH7+P6f3MKSn1tr8varIjm4aeTGVT+Ue4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfQsaBxPgt9oCFd38SEmjyDBUaOq00gbjUsd6SwF9jdYros+sm8NpSc2SINkCM1I8vllHEq23TN7o4rNsKCPZoXY+lpX6atmp1iKOASmc04uJqPwFCMyHaLptQxpl1wjTaDCJRoq7CggmrS7rCx1WKmfD//E+ys9oJD6TempByvJ82GX5ae0PtQmCh8p9awpAn1nYKk0fj6HFET+Tjsr7WkTZXKbfLLYirv7fIplrSZ3TBu/YXe94eN8PvPWsQw+M/5PfhF0N7b/f3e+zyuriNGrei86sHtn4tO4rVIXW8f1Bj0l/NFvFkRo/2OjXuvcRuRgf9UjPb3ZgirA4ZQctw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HXR9V298; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HXR9V298;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc3WM365sz2yLG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 22:34:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 52D9E600AD;
	Thu, 19 Mar 2026 11:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5F2C2BCB0;
	Thu, 19 Mar 2026 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920061;
	bh=vGPmcqAhZCk0gdlr+wYCcpNO1tqWQw2RngJu1gW9hIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXR9V298CpUtMI8uiUfzgXIhpTXpgltg84qzhP5tYL999s9u38RdIf5/+znO/AKE1
	 nqdW9Kq54pTvI4cGRFD2fUy4wjnBRVN+hAoSlkhQipxY5QwpDm0qw/h962PSLEsbLR
	 v6RwuOsIJQst5wZaS5ybKMq5k9XUSGo1qyD2DHzUbCEZzYDzvgPHeP/Dx+E4/aQnpy
	 yVeQFdy4I9jGYcI7u2KCScFjvcb5MeSUYYiTwA5vTmdH/rrgzTC2wcNRsJt4VgQH5M
	 eNJt8KcZbP8/OhTnGatWrUV8VPU4EftxdWW/1OF1NI646J0TpK4aNS9v3S1zz09OW3
	 LuZU7ah4P9Amg==
Date: Thu, 19 Mar 2026 11:34:14 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mm: change to return bool for
 pudp_test_and_clear_young()
Message-ID: <522588b0-1172-4cc6-9011-f077e94011df@lucifer.local>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <2711ec4bf6c30182004e34027fb31a2e8e24749e.1773890510.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <2711ec4bf6c30182004e34027fb31a2e8e24749e.1773890510.git.baolin.wang@linux.alibaba.com>

On Thu, Mar 19, 2026 at 11:24:04AM +0800, Baolin Wang wrote:
> The pudp_test_and_clear_young() is used to clear the young flag,
> returning whether the young flag was set for this PUD entry. Change
> the return type to bool to make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Some nits but otherwise loogs good so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
>  arch/riscv/include/asm/pgtable.h             |  4 ++--
>  arch/x86/include/asm/pgtable.h               |  4 ++--
>  arch/x86/mm/pgtable.c                        |  6 +++---
>  5 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 0f34011665a6..083c4b9ed5b3 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1172,13 +1172,13 @@ static inline bool __pmdp_test_and_clear_young(struct mm_struct *mm,
>  	return ((old & _PAGE_ACCESSED) != 0);
>  }
>
> -static inline int __pudp_test_and_clear_young(struct mm_struct *mm,
> -					      unsigned long addr, pud_t *pudp)
> +static inline bool __pudp_test_and_clear_young(struct mm_struct *mm,
> +					       unsigned long addr, pud_t *pudp)

Formatting yada yada you know the drill, 2 tabs etc. :))

>  {
>  	unsigned long old;
>
>  	if ((pud_raw(*pudp) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
> -		return 0;
> +		return false;
>  	old = pud_hugepage_update(mm, addr, pudp, _PAGE_ACCESSED, 0);
>  	return ((old & _PAGE_ACCESSED) != 0);
>  }
> @@ -1303,8 +1303,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
>  extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  				      unsigned long address, pmd_t *pmdp);
>  #define __HAVE_ARCH_PUDP_TEST_AND_CLEAR_YOUNG
> -extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
> -				     unsigned long address, pud_t *pudp);
> +extern bool pudp_test_and_clear_young(struct vm_area_struct *vma,
> +				      unsigned long address, pud_t *pudp);

Drop the extern please!

>
>
>  #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index aed39bba891e..838cb4a8e2cf 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -104,8 +104,8 @@ bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
>  }
>
> -int pudp_test_and_clear_young(struct vm_area_struct *vma,
> -			      unsigned long address, pud_t *pudp)
> +bool pudp_test_and_clear_young(struct vm_area_struct *vma,
> +			       unsigned long address, pud_t *pudp)
>  {
>  	return __pudp_test_and_clear_young(vma->vm_mm, address, pudp);
>  }
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index bac559d29036..88fa63186ca5 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -1109,8 +1109,8 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
>  	return ptep_set_access_flags(vma, address, (pte_t *)pudp, pud_pte(entry), dirty);
>  }
>
> -static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
> -					    unsigned long address, pud_t *pudp)
> +static inline bool pudp_test_and_clear_young(struct vm_area_struct *vma,
> +					     unsigned long address, pud_t *pudp)
>  {
>  	return ptep_test_and_clear_young(vma, address, (pte_t *)pudp);
>  }
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index f9439449c9bd..6ca1fdd25191 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1297,8 +1297,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  				      unsigned long addr, pmd_t *pmdp);
> -extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
> -				     unsigned long addr, pud_t *pudp);
> +extern bool pudp_test_and_clear_young(struct vm_area_struct *vma,
> +				      unsigned long addr, pud_t *pudp);

Drop the extern please!

>
>  #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
>  extern bool pmdp_clear_flush_young(struct vm_area_struct *vma,
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 8c336edf0e65..2677dcf0bbce 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -470,10 +470,10 @@ bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  #endif
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -int pudp_test_and_clear_young(struct vm_area_struct *vma,
> -			      unsigned long addr, pud_t *pudp)
> +bool pudp_test_and_clear_young(struct vm_area_struct *vma,
> +			       unsigned long addr, pud_t *pudp)
>  {
> -	int ret = 0;
> +	bool ret = false;
>
>  	if (pud_young(*pudp))
>  		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
> --
> 2.47.3
>

