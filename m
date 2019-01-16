Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB02C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 07:11:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A892082F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 07:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="D0QItE8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A892082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fdg94X7PzDqVj
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 18:11:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="unknown key hash" (0-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="D0QItE8C"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fddM3MYXzDqT4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 18:10:15 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43fddH0w2zzB09b6;
 Wed, 16 Jan 2019 08:10:11 +0100 (CET)
Authentication-Results: localhost; dkim=permerror reason="key not found"
 header.d=c-s.fr header.i=@c-s.fr header.b=D0QItE8C;
 dkim-adsp=none (insecure policy); dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 6aJsDZWqbaJq; Wed, 16 Jan 2019 08:10:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43fddG6Cp0zB09b3;
 Wed, 16 Jan 2019 08:10:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1547622610; bh=3UCdRO5bRJJ9Mtiyv3EAH509UCigV0IwADv0TgdKTd8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=D0QItE8ComOfUd6nZnYlVZKsNNPih7pFzONy55uKlZGAWkrNmKpcbFw4HId6RrwND
 HObmZvUM0jfzX2MyBKb4m//fh1vLMIK0uxY/RCi5OATvzh7VZPa/8Sv+b0G5dpzb3p
 qQ4bV9lVaJeaf0cNTv/Fkv+zUk6cAB476FkZZio7BIvLXpPoXyIdXEwdjQIZ1mymkI
 HPLxl2DR7dLSwFIGLSfHGaHRbC/vrXUqfThUtrlraDiean7LEjHN5Mj2MzR2UeE37k
 GU9F/vROOu4lrFhVd1vdoAgTuRzP39ERHKwrhksNMEF4jjbCmYRrmIIqRKqj7NRrfy
 xcKmQXH/LQz7UftUfQkUzIoAgs5okrnPB5SXJgWtoIH2CzBUyZNbyhVabo+ln1yyfb
 dBUdwBaZ99iCsFnl23Rxri5j3doGL1pvyZ25rB5ZlKuJJFuW7Lhqf9C4XA1xhJWKbx
 RL1aY+8mdJccBBWhX/HqTv9Fr9q59/VgIfX/Gtp5pN8CJdZkRrkmSGgylb/5ympMg+
 lvznj3Ha8XXFCoti4ww9Z1yQu2JvlXx1DWPzu0KQT6sJFy52YsYG4iRoKCD2bIlGov
 XMMLbCbLD2s3HHf5NDi+jE+szL/zmvsdIqGPT3vzpfX7HcVC9eOxdbiewNtUOWAySu
 Lm6u8L8wu6T+EGhlrOyrRMj4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A75ED8B804;
 Wed, 16 Jan 2019 08:10:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id EVJf7Cor6AFE; Wed, 16 Jan 2019 08:10:11 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 57B298B74B;
 Wed, 16 Jan 2019 08:10:09 +0100 (CET)
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-sh@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-riscv@lists.infradead.org
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <bc49c0d1-b46c-f03a-baf9-445c417fae8f@c-s.fr>
Date: Wed, 16 Jan 2019 08:10:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: mark.rutland@arm.com, mhocko@suse.com, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com,
 aneesh.kumar@linux.ibm.com, linux@armlinux.org.uk, mingo@redhat.com,
 rientjes@google.com, palmer@sifive.com, greentime@andestech.com,
 marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
 kirill@shutemov.name, tglx@linutronix.de, vbabka@suse.cz,
 ard.biesheuvel@linaro.org, steve.capper@arm.com, christoffer.dall@arm.com,
 james.morse@arm.com, robin.murphy@arm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 16/01/2019 à 07:21, Anshuman Khandual a écrit :
> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> __GFP_ZERO) and using it for allocating page table pages. This causes some
> code duplication which can be easily avoided. GFP_KERNEL allocated and
> cleared out pages (__GFP_ZERO) are required for page tables on any given
> architecture. This creates a new generic GFP flag flag which can be used
> for any page table page allocation. Does not cause any functional change.
> 
> GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
> generic page tabe header just to prevent it's potential misuse as a general
> allocation flag if included in include/linux/gfp.h.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Build tested on arm, arm64, powerpc, powerpc64le and x86.
> Boot tested on arm64 and x86.
> 
> Changes in V2:
> 
> - Moved GFP_PGTABLE into include/asm-generic/pgtable.h
> - On X86 added __GFP_ACCOUNT into GFP_PGTABLE at various places
> - Replaced possible flags on riscv and nds32 with GFP_PGTABLE

Could also replace the flags in 
arch/powerpc/include/asm/nohash/64/pgalloc.h with GFP_PGTABLE in 
pte_alloc_one_kernel() and pte_alloc_one()

Christophe

> 
> Original V1: https://lkml.org/lkml/2019/1/12/54
> 
>   arch/arm/include/asm/pgalloc.h               |  8 +++-----
>   arch/arm/mm/mmu.c                            |  2 +-
>   arch/arm64/include/asm/pgalloc.h             |  9 ++++-----
>   arch/arm64/mm/mmu.c                          |  2 +-
>   arch/arm64/mm/pgd.c                          |  4 ++--
>   arch/nds32/include/asm/pgalloc.h             |  3 +--
>   arch/powerpc/include/asm/book3s/64/pgalloc.h |  6 +++---
>   arch/powerpc/include/asm/pgalloc.h           |  2 --
>   arch/powerpc/kvm/book3s_64_mmu_hv.c          |  2 +-
>   arch/powerpc/mm/pgtable-frag.c               |  4 ++--
>   arch/riscv/include/asm/pgalloc.h             |  8 +++-----
>   arch/sh/mm/pgtable.c                         |  6 ++----
>   arch/unicore32/include/asm/pgalloc.h         |  6 ++----
>   arch/x86/kernel/espfix_64.c                  |  6 ++----
>   arch/x86/mm/pgtable.c                        | 15 +++++++--------
>   include/asm-generic/pgtable.h                |  2 ++
>   virt/kvm/arm/mmu.c                           |  2 +-
>   17 files changed, 37 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
> index 17ab72f..72be6f5 100644
> --- a/arch/arm/include/asm/pgalloc.h
> +++ b/arch/arm/include/asm/pgalloc.h
> @@ -57,8 +57,6 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
>   extern pgd_t *pgd_alloc(struct mm_struct *mm);
>   extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
>   
> -#define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
> -
>   static inline void clean_pte_table(pte_t *pte)
>   {
>   	clean_dcache_area(pte + PTE_HWTABLE_PTRS, PTE_HWTABLE_SIZE);
> @@ -85,7 +83,7 @@ pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   
> -	pte = (pte_t *)__get_free_page(PGALLOC_GFP);
> +	pte = (pte_t *)__get_free_page(GFP_PGTABLE);
>   	if (pte)
>   		clean_pte_table(pte);
>   
> @@ -98,9 +96,9 @@ pte_alloc_one(struct mm_struct *mm)
>   	struct page *pte;
>   
>   #ifdef CONFIG_HIGHPTE
> -	pte = alloc_pages(PGALLOC_GFP | __GFP_HIGHMEM, 0);
> +	pte = alloc_pages(GFP_PGTABLE | __GFP_HIGHMEM, 0);
>   #else
> -	pte = alloc_pages(PGALLOC_GFP, 0);
> +	pte = alloc_pages(GFP_PGTABLE, 0);
>   #endif
>   	if (!pte)
>   		return NULL;
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index f5cc1cc..6d47784 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -733,7 +733,7 @@ static void __init *early_alloc(unsigned long sz)
>   
>   static void *__init late_alloc(unsigned long sz)
>   {
> -	void *ptr = (void *)__get_free_pages(PGALLOC_GFP, get_order(sz));
> +	void *ptr = (void *)__get_free_pages(GFP_PGTABLE, get_order(sz));
>   
>   	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
>   		BUG();
> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> index 52fa47c..d5c75bf 100644
> --- a/arch/arm64/include/asm/pgalloc.h
> +++ b/arch/arm64/include/asm/pgalloc.h
> @@ -26,14 +26,13 @@
>   
>   #define check_pgt_cache()		do { } while (0)
>   
> -#define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
>   #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
>   
>   #if CONFIG_PGTABLE_LEVELS > 2
>   
>   static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>   {
> -	return (pmd_t *)__get_free_page(PGALLOC_GFP);
> +	return (pmd_t *)__get_free_page(GFP_PGTABLE);
>   }
>   
>   static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
> @@ -62,7 +61,7 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
>   
>   static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>   {
> -	return (pud_t *)__get_free_page(PGALLOC_GFP);
> +	return (pud_t *)__get_free_page(GFP_PGTABLE);
>   }
>   
>   static inline void pud_free(struct mm_struct *mm, pud_t *pudp)
> @@ -93,7 +92,7 @@ extern void pgd_free(struct mm_struct *mm, pgd_t *pgdp);
>   static inline pte_t *
>   pte_alloc_one_kernel(struct mm_struct *mm)
>   {
> -	return (pte_t *)__get_free_page(PGALLOC_GFP);
> +	return (pte_t *)__get_free_page(GFP_PGTABLE);
>   }
>   
>   static inline pgtable_t
> @@ -101,7 +100,7 @@ pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> -	pte = alloc_pages(PGALLOC_GFP, 0);
> +	pte = alloc_pages(GFP_PGTABLE, 0);
>   	if (!pte)
>   		return NULL;
>   	if (!pgtable_page_ctor(pte)) {
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b6f5aa5..07b1c0f 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -372,7 +372,7 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>   
>   static phys_addr_t pgd_pgtable_alloc(void)
>   {
> -	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> +	void *ptr = (void *)__get_free_page(GFP_PGTABLE);
>   	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
>   		BUG();
>   
> diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> index 289f911..5b28e2b 100644
> --- a/arch/arm64/mm/pgd.c
> +++ b/arch/arm64/mm/pgd.c
> @@ -31,9 +31,9 @@ static struct kmem_cache *pgd_cache __ro_after_init;
>   pgd_t *pgd_alloc(struct mm_struct *mm)
>   {
>   	if (PGD_SIZE == PAGE_SIZE)
> -		return (pgd_t *)__get_free_page(PGALLOC_GFP);
> +		return (pgd_t *)__get_free_page(GFP_PGTABLE);
>   	else
> -		return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
> +		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE);
>   }
>   
>   void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
> index 3c5fee5..e1137ce 100644
> --- a/arch/nds32/include/asm/pgalloc.h
> +++ b/arch/nds32/include/asm/pgalloc.h
> @@ -27,8 +27,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   	pte_t *pte;
>   
>   	pte =
> -	    (pte_t *) __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> -				      __GFP_ZERO);
> +	    (pte_t *) __get_free_page(GFP_PGTABLE | __GFP_RETRY_MAYFAIL);
>   
>   	return pte;
>   }
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index 9c11732..71704e5 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -52,11 +52,11 @@ void pte_frag_destroy(void *pte_frag);
>   static inline pgd_t *radix__pgd_alloc(struct mm_struct *mm)
>   {
>   #ifdef CONFIG_PPC_64K_PAGES
> -	return (pgd_t *)__get_free_page(pgtable_gfp_flags(mm, PGALLOC_GFP));
> +	return (pgd_t *)__get_free_page(pgtable_gfp_flags(mm, GFP_PGTABLE));
>   #else
>   	struct page *page;
> -	page = alloc_pages(pgtable_gfp_flags(mm, PGALLOC_GFP | __GFP_RETRY_MAYFAIL),
> -				4);
> +	page = alloc_pages(pgtable_gfp_flags(mm, GFP_PGTABLE |
> +				__GFP_RETRY_MAYFAIL), 4);
>   	if (!page)
>   		return NULL;
>   	return (pgd_t *) page_address(page);
> diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
> index e11f030..3b11e8b 100644
> --- a/arch/powerpc/include/asm/pgalloc.h
> +++ b/arch/powerpc/include/asm/pgalloc.h
> @@ -18,8 +18,6 @@ static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm, gfp_t gfp)
>   }
>   #endif /* MODULE */
>   
> -#define PGALLOC_GFP (GFP_KERNEL | __GFP_ZERO)
> -
>   #ifdef CONFIG_PPC_BOOK3S
>   #include <asm/book3s/pgalloc.h>
>   #else
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index bd2dcfb..b419878 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -97,7 +97,7 @@ int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order)
>   	}
>   
>   	if (!hpt)
> -		hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_RETRY_MAYFAIL
> +		hpt = __get_free_pages(GFP_PGTABLE | __GFP_RETRY_MAYFAIL
>   				       |__GFP_NOWARN, order - PAGE_SHIFT);
>   
>   	if (!hpt)
> diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> index a7b0521..211aaa7 100644
> --- a/arch/powerpc/mm/pgtable-frag.c
> +++ b/arch/powerpc/mm/pgtable-frag.c
> @@ -58,7 +58,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
>   	struct page *page;
>   
>   	if (!kernel) {
> -		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
> +		page = alloc_page(GFP_PGTABLE | __GFP_ACCOUNT);
>   		if (!page)
>   			return NULL;
>   		if (!pgtable_page_ctor(page)) {
> @@ -66,7 +66,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
>   			return NULL;
>   		}
>   	} else {
> -		page = alloc_page(PGALLOC_GFP);
> +		page = alloc_page(GFP_PGTABLE);
>   		if (!page)
>   			return NULL;
>   	}
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index 94043cf..7ff1cd7 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -69,8 +69,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>   
>   static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>   {
> -	return (pmd_t *)__get_free_page(
> -		GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
> +	return (pmd_t *)__get_free_page(GFP_PGTABLE | __GFP_RETRY_MAYFAIL);
>   }
>   
>   static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
> @@ -84,15 +83,14 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>   
>   static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
> -	return (pte_t *)__get_free_page(
> -		GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
> +	return (pte_t *)__get_free_page(GFP_PGTABLE | __GFP_RETRY_MAYFAIL);
>   }
>   
>   static inline struct page *pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> -	pte = alloc_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
> +	pte = alloc_page(GFP_PGTABLE | __GFP_RETRY_MAYFAIL);
>   	if (likely(pte != NULL))
>   		pgtable_page_ctor(pte);
>   	return pte;
> diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
> index 5c8f924..324732dc5 100644
> --- a/arch/sh/mm/pgtable.c
> +++ b/arch/sh/mm/pgtable.c
> @@ -2,8 +2,6 @@
>   #include <linux/mm.h>
>   #include <linux/slab.h>
>   
> -#define PGALLOC_GFP GFP_KERNEL | __GFP_ZERO
> -
>   static struct kmem_cache *pgd_cachep;
>   #if PAGETABLE_LEVELS > 2
>   static struct kmem_cache *pmd_cachep;
> @@ -32,7 +30,7 @@ void pgtable_cache_init(void)
>   
>   pgd_t *pgd_alloc(struct mm_struct *mm)
>   {
> -	return kmem_cache_alloc(pgd_cachep, PGALLOC_GFP);
> +	return kmem_cache_alloc(pgd_cachep, GFP_PGTABLE);
>   }
>   
>   void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> @@ -48,7 +46,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
>   
>   pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>   {
> -	return kmem_cache_alloc(pmd_cachep, PGALLOC_GFP);
> +	return kmem_cache_alloc(pmd_cachep, GFP_PGTABLE);
>   }
>   
>   void pmd_free(struct mm_struct *mm, pmd_t *pmd)
> diff --git a/arch/unicore32/include/asm/pgalloc.h b/arch/unicore32/include/asm/pgalloc.h
> index 7cceabe..a3506e5 100644
> --- a/arch/unicore32/include/asm/pgalloc.h
> +++ b/arch/unicore32/include/asm/pgalloc.h
> @@ -28,8 +28,6 @@ extern void free_pgd_slow(struct mm_struct *mm, pgd_t *pgd);
>   #define pgd_alloc(mm)			get_pgd_slow(mm)
>   #define pgd_free(mm, pgd)		free_pgd_slow(mm, pgd)
>   
> -#define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
> -
>   /*
>    * Allocate one PTE table.
>    */
> @@ -38,7 +36,7 @@ pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   
> -	pte = (pte_t *)__get_free_page(PGALLOC_GFP);
> +	pte = (pte_t *)__get_free_page(GFP_PGTABLE);
>   	if (pte)
>   		clean_dcache_area(pte, PTRS_PER_PTE * sizeof(pte_t));
>   
> @@ -50,7 +48,7 @@ pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> -	pte = alloc_pages(PGALLOC_GFP, 0);
> +	pte = alloc_pages(GFP_PGTABLE, 0);
>   	if (!pte)
>   		return NULL;
>   	if (!PageHighMem(pte)) {
> diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
> index aebd0d5..dae28cc 100644
> --- a/arch/x86/kernel/espfix_64.c
> +++ b/arch/x86/kernel/espfix_64.c
> @@ -57,8 +57,6 @@
>   # error "Need more virtual address space for the ESPFIX hack"
>   #endif
>   
> -#define PGALLOC_GFP (GFP_KERNEL | __GFP_ZERO)
> -
>   /* This contains the *bottom* address of the espfix stack */
>   DEFINE_PER_CPU_READ_MOSTLY(unsigned long, espfix_stack);
>   DEFINE_PER_CPU_READ_MOSTLY(unsigned long, espfix_waddr);
> @@ -172,7 +170,7 @@ void init_espfix_ap(int cpu)
>   	pud_p = &espfix_pud_page[pud_index(addr)];
>   	pud = *pud_p;
>   	if (!pud_present(pud)) {
> -		struct page *page = alloc_pages_node(node, PGALLOC_GFP, 0);
> +		struct page *page = alloc_pages_node(node, GFP_PGTABLE, 0);
>   
>   		pmd_p = (pmd_t *)page_address(page);
>   		pud = __pud(__pa(pmd_p) | (PGTABLE_PROT & ptemask));
> @@ -184,7 +182,7 @@ void init_espfix_ap(int cpu)
>   	pmd_p = pmd_offset(&pud, addr);
>   	pmd = *pmd_p;
>   	if (!pmd_present(pmd)) {
> -		struct page *page = alloc_pages_node(node, PGALLOC_GFP, 0);
> +		struct page *page = alloc_pages_node(node, GFP_PGTABLE, 0);
>   
>   		pte_p = (pte_t *)page_address(page);
>   		pmd = __pmd(__pa(pte_p) | (PGTABLE_PROT & ptemask));
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 7bd0170..a5b1672 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -13,19 +13,17 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>   EXPORT_SYMBOL(physical_mask);
>   #endif
>   
> -#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
> -
>   #ifdef CONFIG_HIGHPTE
>   #define PGALLOC_USER_GFP __GFP_HIGHMEM
>   #else
>   #define PGALLOC_USER_GFP 0
>   #endif
>   
> -gfp_t __userpte_alloc_gfp = PGALLOC_GFP | PGALLOC_USER_GFP;
> +gfp_t __userpte_alloc_gfp = GFP_PGTABLE | __GFP_ACCOUNT | PGALLOC_USER_GFP;
>   
>   pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
> -	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
> +	return (pte_t *)__get_free_page(GFP_PGTABLE);
>   }
>   
>   pgtable_t pte_alloc_one(struct mm_struct *mm)
> @@ -235,7 +233,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
>   {
>   	int i;
>   	bool failed = false;
> -	gfp_t gfp = PGALLOC_GFP;
> +	gfp_t gfp = GFP_PGTABLE | __GFP_ACCOUNT;
>   
>   	if (mm == &init_mm)
>   		gfp &= ~__GFP_ACCOUNT;
> @@ -401,14 +399,14 @@ static inline pgd_t *_pgd_alloc(void)
>   	 * We allocate one page for pgd.
>   	 */
>   	if (!SHARED_KERNEL_PMD)
> -		return (pgd_t *)__get_free_pages(PGALLOC_GFP,
> +		return (pgd_t *)__get_free_pages(GFP_PGTABLE | __GFP_ACCOUNT,
>   						 PGD_ALLOCATION_ORDER);
>   
>   	/*
>   	 * Now PAE kernel is not running as a Xen domain. We can allocate
>   	 * a 32-byte slab for pgd to save memory space.
>   	 */
> -	return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
> +	return kmem_cache_alloc(pgd_cache, GFP_PGTABLE | __GFP_ACCOUNT);
>   }
>   
>   static inline void _pgd_free(pgd_t *pgd)
> @@ -422,7 +420,8 @@ static inline void _pgd_free(pgd_t *pgd)
>   
>   static inline pgd_t *_pgd_alloc(void)
>   {
> -	return (pgd_t *)__get_free_pages(PGALLOC_GFP, PGD_ALLOCATION_ORDER);
> +	return (pgd_t *)__get_free_pages(GFP_PGTABLE | __GFP_ACCOUNT,
> +						PGD_ALLOCATION_ORDER);
>   }
>   
>   static inline void _pgd_free(pgd_t *pgd)
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 05e61e6..3d9cde6 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1186,4 +1186,6 @@ static inline bool arch_has_pfn_modify_check(void)
>   #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
>   #endif
>   
> +#define GFP_PGTABLE	(GFP_KERNEL | __GFP_ZERO)
> +
>   #endif /* _ASM_GENERIC_PGTABLE_H */
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index fbdf3ac..f60a5b8 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -143,7 +143,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
>   	if (cache->nobjs >= min)
>   		return 0;
>   	while (cache->nobjs < max) {
> -		page = (void *)__get_free_page(PGALLOC_GFP);
> +		page = (void *)__get_free_page(GFP_PGTABLE);
>   		if (!page)
>   			return -ENOMEM;
>   		cache->objects[cache->nobjs++] = page;
> 
