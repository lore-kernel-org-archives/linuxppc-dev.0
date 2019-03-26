Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898ADC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 16:59:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B6A2070D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 16:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rMUjOLqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B6A2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44THRx0p9PzDqM6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 03:59:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="rMUjOLqZ"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44THQ253RtzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 03:58:17 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44THPv5XQvz9tyyq;
 Tue, 26 Mar 2019 17:58:11 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=rMUjOLqZ; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id mRPEEK1aMQ5F; Tue, 26 Mar 2019 17:58:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44THPv4Cmfz9tyyn;
 Tue, 26 Mar 2019 17:58:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553619491; bh=LD6hSdcwvQiyOzYMP5lSb0ibAdI5w/B0bCTvzjdJMOI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=rMUjOLqZISmdIE6B1jHtMrvKQEmm5vf8LcThjXGq2uQq5zmFsrMSqhX0wMZorCflN
 VvdQUOuwY4vEKk/LZROBr/v73HEkV1zvQ78GtkgVSZt/jS/eaJri/J7XoR09cUPO6r
 zysNlRLaNu/T1pa6nA5aGrAf3ynsBBmA3yhzfW2Y=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F196D8B8DB;
 Tue, 26 Mar 2019 17:58:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Yk3sBN4yLD5x; Tue, 26 Mar 2019 17:58:10 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 645E58B8D0;
 Tue, 26 Mar 2019 17:58:09 +0100 (CET)
Subject: Re: [PATCH v6 04/19] powerpc: mm: Add p?d_large() definitions
To: Steven Price <steven.price@arm.com>, linux-mm@kvack.org
References: <20190326162624.20736-1-steven.price@arm.com>
 <20190326162624.20736-5-steven.price@arm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8a2efe07-b99f-3caa-fab9-47e49043bf66@c-s.fr>
Date: Tue, 26 Mar 2019 17:58:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190326162624.20736-5-steven.price@arm.com>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
 James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, "Liang,
 Kan" <kan.liang@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/03/2019 à 17:26, Steven Price a écrit :
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For powerpc pmd_large() was already implemented, so hoist it out of the
> CONFIG_TRANSPARENT_HUGEPAGE condition and implement the other levels.
> 
> Also since we now have a pmd_large always implemented we can drop the
> pmd_is_leaf() function.

Wouldn't it be better to drop the pmd_is_leaf() in a second patch ?

Christophe

> 
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: kvm-ppc@vger.kernel.org
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   arch/powerpc/include/asm/book3s/64/pgtable.h | 30 ++++++++++++++------
>   arch/powerpc/kvm/book3s_64_mmu_radix.c       | 12 ++------
>   2 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 581f91be9dd4..f6d1ac8b832e 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -897,6 +897,12 @@ static inline int pud_present(pud_t pud)
>   	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
>   }
>   
> +#define pud_large	pud_large
> +static inline int pud_large(pud_t pud)
> +{
> +	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
> +}
> +
>   extern struct page *pud_page(pud_t pud);
>   extern struct page *pmd_page(pmd_t pmd);
>   static inline pte_t pud_pte(pud_t pud)
> @@ -940,6 +946,12 @@ static inline int pgd_present(pgd_t pgd)
>   	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
>   }
>   
> +#define pgd_large	pgd_large
> +static inline int pgd_large(pgd_t pgd)
> +{
> +	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
> +}
> +
>   static inline pte_t pgd_pte(pgd_t pgd)
>   {
>   	return __pte_raw(pgd_raw(pgd));
> @@ -1093,6 +1105,15 @@ static inline bool pmd_access_permitted(pmd_t pmd, bool write)
>   	return pte_access_permitted(pmd_pte(pmd), write);
>   }
>   
> +#define pmd_large	pmd_large
> +/*
> + * returns true for pmd migration entries, THP, devmap, hugetlb
> + */
> +static inline int pmd_large(pmd_t pmd)
> +{
> +	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> +}
> +
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
>   extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
> @@ -1119,15 +1140,6 @@ pmd_hugepage_update(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp,
>   	return hash__pmd_hugepage_update(mm, addr, pmdp, clr, set);
>   }
>   
> -/*
> - * returns true for pmd migration entries, THP, devmap, hugetlb
> - * But compile time dependent on THP config
> - */
> -static inline int pmd_large(pmd_t pmd)
> -{
> -	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
> -}
> -
>   static inline pmd_t pmd_mknotpresent(pmd_t pmd)
>   {
>   	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> index f55ef071883f..1b57b4e3f819 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> @@ -363,12 +363,6 @@ static void kvmppc_pte_free(pte_t *ptep)
>   	kmem_cache_free(kvm_pte_cache, ptep);
>   }
>   
> -/* Like pmd_huge() and pmd_large(), but works regardless of config options */
> -static inline int pmd_is_leaf(pmd_t pmd)
> -{
> -	return !!(pmd_val(pmd) & _PAGE_PTE);
> -}
> -
>   static pmd_t *kvmppc_pmd_alloc(void)
>   {
>   	return kmem_cache_alloc(kvm_pmd_cache, GFP_KERNEL);
> @@ -460,7 +454,7 @@ static void kvmppc_unmap_free_pmd(struct kvm *kvm, pmd_t *pmd, bool full,
>   	for (im = 0; im < PTRS_PER_PMD; ++im, ++p) {
>   		if (!pmd_present(*p))
>   			continue;
> -		if (pmd_is_leaf(*p)) {
> +		if (pmd_large(*p)) {
>   			if (full) {
>   				pmd_clear(p);
>   			} else {
> @@ -593,7 +587,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
>   	else if (level <= 1)
>   		new_pmd = kvmppc_pmd_alloc();
>   
> -	if (level == 0 && !(pmd && pmd_present(*pmd) && !pmd_is_leaf(*pmd)))
> +	if (level == 0 && !(pmd && pmd_present(*pmd) && !pmd_large(*pmd)))
>   		new_ptep = kvmppc_pte_alloc();
>   
>   	/* Check if we might have been invalidated; let the guest retry if so */
> @@ -662,7 +656,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
>   		new_pmd = NULL;
>   	}
>   	pmd = pmd_offset(pud, gpa);
> -	if (pmd_is_leaf(*pmd)) {
> +	if (pmd_large(*pmd)) {
>   		unsigned long lgpa = gpa & PMD_MASK;
>   
>   		/* Check if we raced and someone else has set the same thing */
> 
