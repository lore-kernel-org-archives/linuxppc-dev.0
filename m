Return-Path: <linuxppc-dev+bounces-29455-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEB0CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 06:04:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4LJK3hnsz2yYK;
	Wed, 14 Oct 2026 17:04:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791957873;
	cv=none; b=Eu8Agvm2UE0ofvBKmbPAf7ZQPa5aNf4dQFmfdKUQCPCf7FTYmgwhBWZJpVtGY3YK6BpUx60FTBs3ffMSK+CIGDwA0n7blrY3A3cLXMJ5KHG+LavN81bX5kpq4Sad952MRrJALUoMycCp4tSoiYxOW8o32ja8sHvyjV2h32KyFtB5QZH8OhXkhHIWoBPJsZZ2z8qFQ7pKnSypcrOggUY+AtYr4G26nLc9aGpCDf4omasE5TviO63oySUoW+Y/fwTx3lekUyDTUUO+ZbzZIPkPuSAzlUn5I5IxY9V9qtbz3zs05tF+xcU+9Q+orZh3zv5OFPnoHM8YiX39aIbfealsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791957873; c=relaxed/relaxed;
	bh=ESeptom+XdILDBZ1SV9z+qsZLUlrAdxL/MtsJa3zQY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gg38l/ZY1IpzL63doVL6TAZbFQJTMRZiHoZTNv+xdd801BIi/G3mmXjO0H4urhgHtHwmXknTPanNSIdKpe4IR8qHuXSXFWqMHIGpu3fG5x+ax4lb7ZixXBFyZY8tJkAf1/Ln9nGtP4bDzoxjCMaKQwDtPaUfqoygO8q73jz5maHySmxhEt5KFyqSn7btclgATEEE7lYMUBGhu4GsR8Oj4kwaPCGxCKUydJoMCEJsimi8hIJ17iIso6z8NULYlaSmGlRZKyYMA2raurOOrHH6dgYI2Ukxm35JbsWTqc0YEUosVB7nFth5+KbSuUN/puUHXzY0IH+g4OuD/LgPVuAPUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NGFOsBqQ; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NGFOsBqQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4LJG5cnlz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 17:04:28 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98CEA15A1;
	Tue, 13 Oct 2026 23:03:52 -0700 (PDT)
Received: from [10.164.19.62] (unknown [10.164.19.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D3F03F7B4;
	Tue, 13 Oct 2026 23:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791957835; bh=a+ePuoScWznFCdZL7kuuIwctTxuRzsdaAnI868FjqvY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NGFOsBqQlkYzYRc6c9oeI62OwONXctPXAWs1X+w9O0ZGSX08mzBFLCRloqvuXoEcs
	 l+RKSocjuhfxG9ajTVLYRvJo74qsxS3Fa4vk2551oznUYNciNmnhrtaKCzGd4OvWLE
	 xxJq6dznjLsg4ngtYlAUgjw44+L1Kvxk1pfNNxrY=
Message-ID: <7b3c3a39-4cf3-430d-9fd3-ba83e5175e72@arm.com>
Date: Wed, 14 Oct 2026 11:33:47 +0530
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
Subject: Re: [PATCH v10 01/10] arm64/mm: add pte_set_huge() and
 pte_clear_huge()
To: Wen Jiang <jiangwenxiaomi@gmail.com>, akpm@linux-foundation.org,
 catalin.marinas@arm.com, linux-mm@kvack.org, urezki@gmail.com,
 will@kernel.org
Cc: Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, anshuman.khandual@arm.com,
 baohua@kernel.org, chleroy@kernel.org, david@kernel.org,
 jiangwen6@xiaomi.com, leo.yan@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
 ryan.roberts@arm.com
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
 <20261002090947.869220-2-jiangwen6@xiaomi.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261002090947.869220-2-jiangwen6@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/10/26 2:39 pm, Wen Jiang wrote:
> vmap installs PTE-level block mappings (PTE_CONT on arm64) by reusing
> set_huge_pte_at() and huge_ptep_get_and_clear(), which are HugeTLB
> helpers gated by CONFIG_HUGETLB_PAGE. This makes the feature silently
> unavailable on CONFIG_HUGETLB_PAGE=n kernels and couples mm/vmalloc.c to
> HugeTLB internals it does not otherwise need.
> 
> Add pte_set_huge()/pte_clear_huge() to arm64, joining the existing
> pmd_set_huge()/pud_set_huge() family in mm/mmu.c. They build on
> __set_ptes() and __get_and_clear_full_ptes() directly, so they do not
> depend on CONFIG_HUGETLB_PAGE.
> 
> There is no caller yet: mm/vmalloc.c is converted later in this series,
> once the generic fallbacks are in place.
> 
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable.h |  6 ++++++
>  arch/arm64/mm/mmu.c              | 23 +++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 6000905a2e865..9b762eb68cff0 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1978,6 +1978,12 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
>  
>  #endif /* CONFIG_ARM64_CONTPTE */
>  
> +#define __HAVE_ARCH_PTE_SET_HUGE
> +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
> +		  pgprot_t prot, unsigned long size);
> +#define __HAVE_ARCH_PTE_CLEAR_HUGE
> +pte_t pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size);
> +
>  #endif /* !__ASSEMBLER__ */
>  
>  #endif /* __ASM_PGTABLE_H */
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 79d90226fd5dc..ae2f15618c97d 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1912,6 +1912,29 @@ int pmd_clear_huge(pmd_t *pmdp)
>  	return 1;
>  }
>  
> +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
> +		  pgprot_t prot, unsigned long size)
> +{
> +	unsigned long pfn = __phys_to_pfn(phys);
> +	pte_t pte = pte_mkcont(pfn_pte(pfn, prot));
> +	unsigned int nr = size >> PAGE_SHIFT;
> +
> +	VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));
> +	VM_WARN_ON(!IS_ALIGNED(addr, CONT_PTE_SIZE));
> +	VM_WARN_ON(!IS_ALIGNED(pfn, CONT_PTES));
> +
> +	/* For vmap, there is no valid -> valid transition */
> +	VM_WARN_ON(pte_valid(__ptep_get(ptep)));
> +
> +	__set_ptes(&init_mm, addr, ptep, pte, nr);
> +}
> +
> +pte_t pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size)
> +{
> +	return __get_and_clear_full_ptes(&init_mm, addr, ptep,
> +					 size >> PAGE_SHIFT, 0);
> +}

I think we should have the same VM_WARN_ON() checks here, as for
pte_clear_huge(), in addition to also warning for
current->mm != &init_mm.

We should make it clear that pte_clear_huge() gets called only for
kernel mappings, and the range we operate on is definitely an aligned
CONT range - which is why we do not go through get_and_clear_full_ptes ->
contpte_get_and_clear_full_ptes, and possibly contpte_try_unfold(), but
directly use __get_and_clear_full_ptes.


> +
>  int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>  {
>  	pte_t *table;


