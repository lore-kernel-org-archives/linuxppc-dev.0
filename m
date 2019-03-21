Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04742C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 10:43:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290FA218B0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 10:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="MloDulJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290FA218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Q3LC6FcNzDqS9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 21:43:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="MloDulJC"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Q3JY0zJDzDqRS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 21:42:20 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Q3JS200tz9v0B8;
 Thu, 21 Mar 2019 11:42:16 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=MloDulJC; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id LBoym5aw1n9X; Thu, 21 Mar 2019 11:42:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Q3JS0l5tz9v0B7;
 Thu, 21 Mar 2019 11:42:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553164936; bh=hWhV83rjkz3EivB2em33ZdXjItgzDWsKrPC2D7mXuuY=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=MloDulJCXrG3HhEM/uguvR/vPTx+aWUYKkaYn1krNra5bFBbd689WkQ2mlOjZmXP+
 QP5ktezrY7eDGaN+UVxFH2tSuDNxRlp6IufUint2SXsroHitdJA1dW7uiRDfdlowOk
 H8opQK/FuFrxJJcxca5q4xGl5lVwKEq7B7OCiLLg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A9DE8B966;
 Thu, 21 Mar 2019 11:42:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id sPGQ8qN0i2X5; Thu, 21 Mar 2019 11:42:17 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6AC938B955;
 Thu, 21 Mar 2019 11:42:16 +0100 (CET)
Subject: Re: [PATCH v1 11/27] powerpc/mm: split asm/hugetlb.h into dedicated
 subarch files
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.ibm.com, Russell Currey <ruscur@russell.cc>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
 <0049d5686df8fe29cc7a6f45461fe2550d8a4685.1553076180.git.christophe.leroy@c-s.fr>
Message-ID: <1e0db736-f30b-b70d-94b7-a68f95edbceb@c-s.fr>
Date: Thu, 21 Mar 2019 11:42:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <0049d5686df8fe29cc7a6f45461fe2550d8a4685.1553076180.git.christophe.leroy@c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

snowpatch fails applying this.

I usually base my patches on branch merge. Shouldn't snowpatch use merge 
branch as well instead of next branch ?

Christophe

Le 20/03/2019 à 11:06, Christophe Leroy a écrit :
> Three subarches support hugepages:
> - fsl book3e
> - book3s/64
> - 8xx
> 
> This patch splits asm/hugetlb.h to reduce the #ifdef mess.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/book3s/64/hugetlb.h     | 41 +++++++++++
>   arch/powerpc/include/asm/hugetlb.h               | 89 ++----------------------
>   arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h | 32 +++++++++
>   arch/powerpc/include/asm/nohash/hugetlb-book3e.h | 31 +++++++++
>   4 files changed, 108 insertions(+), 85 deletions(-)
>   create mode 100644 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
>   create mode 100644 arch/powerpc/include/asm/nohash/hugetlb-book3e.h
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> index ec2a55a553c7..2f9cf2bc601c 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -62,4 +62,45 @@ extern pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
>   extern void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
>   					 unsigned long addr, pte_t *ptep,
>   					 pte_t old_pte, pte_t new_pte);
> +/*
> + * This should work for other subarchs too. But right now we use the
> + * new format only for 64bit book3s
> + */
> +static inline pte_t *hugepd_page(hugepd_t hpd)
> +{
> +	if (WARN_ON(!hugepd_ok(hpd)))
> +		return NULL;
> +	/*
> +	 * We have only four bits to encode, MMU page size
> +	 */
> +	BUILD_BUG_ON((MMU_PAGE_COUNT - 1) > 0xf);
> +	return __va(hpd_val(hpd) & HUGEPD_ADDR_MASK);
> +}
> +
> +static inline unsigned int hugepd_mmu_psize(hugepd_t hpd)
> +{
> +	return (hpd_val(hpd) & HUGEPD_SHIFT_MASK) >> 2;
> +}
> +
> +static inline unsigned int hugepd_shift(hugepd_t hpd)
> +{
> +	return mmu_psize_to_shift(hugepd_mmu_psize(hpd));
> +}
> +static inline void flush_hugetlb_page(struct vm_area_struct *vma,
> +				      unsigned long vmaddr)
> +{
> +	if (radix_enabled())
> +		return radix__flush_hugetlb_page(vma, vmaddr);
> +}
> +
> +static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
> +				    unsigned int pdshift)
> +{
> +	unsigned long idx = (addr & ((1UL << pdshift) - 1)) >> hugepd_shift(hpd);
> +
> +	return hugepd_page(hpd) + idx;
> +}
> +
> +void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
> +
>   #endif
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 48c29686c78e..fd5c0873a57d 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -6,85 +6,13 @@
>   #include <asm/page.h>
>   
>   #ifdef CONFIG_PPC_BOOK3S_64
> -
>   #include <asm/book3s/64/hugetlb.h>
> -/*
> - * This should work for other subarchs too. But right now we use the
> - * new format only for 64bit book3s
> - */
> -static inline pte_t *hugepd_page(hugepd_t hpd)
> -{
> -	if (WARN_ON(!hugepd_ok(hpd)))
> -		return NULL;
> -	/*
> -	 * We have only four bits to encode, MMU page size
> -	 */
> -	BUILD_BUG_ON((MMU_PAGE_COUNT - 1) > 0xf);
> -	return __va(hpd_val(hpd) & HUGEPD_ADDR_MASK);
> -}
> -
> -static inline unsigned int hugepd_mmu_psize(hugepd_t hpd)
> -{
> -	return (hpd_val(hpd) & HUGEPD_SHIFT_MASK) >> 2;
> -}
> -
> -static inline unsigned int hugepd_shift(hugepd_t hpd)
> -{
> -	return mmu_psize_to_shift(hugepd_mmu_psize(hpd));
> -}
> -static inline void flush_hugetlb_page(struct vm_area_struct *vma,
> -				      unsigned long vmaddr)
> -{
> -	if (radix_enabled())
> -		return radix__flush_hugetlb_page(vma, vmaddr);
> -}
> -
> -#else
> -
> -static inline pte_t *hugepd_page(hugepd_t hpd)
> -{
> -	if (WARN_ON(!hugepd_ok(hpd)))
> -		return NULL;
> -#ifdef CONFIG_PPC_8xx
> -	return (pte_t *)__va(hpd_val(hpd) & ~HUGEPD_SHIFT_MASK);
> -#else
> -	return (pte_t *)((hpd_val(hpd) &
> -			  ~HUGEPD_SHIFT_MASK) | PD_HUGE);
> -#endif
> -}
> -
> -static inline unsigned int hugepd_shift(hugepd_t hpd)
> -{
> -#ifdef CONFIG_PPC_8xx
> -	return ((hpd_val(hpd) & _PMD_PAGE_MASK) >> 1) + 17;
> -#else
> -	return hpd_val(hpd) & HUGEPD_SHIFT_MASK;
> -#endif
> -}
> -
> +#elif defined(CONFIG_PPC_FSL_BOOK3E)
> +#include <asm/nohash/hugetlb-book3e.h>
> +#elif defined(CONFIG_PPC_8xx)
> +#include <asm/nohash/32/hugetlb-8xx.h>
>   #endif /* CONFIG_PPC_BOOK3S_64 */
>   
> -
> -static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
> -				    unsigned pdshift)
> -{
> -	/*
> -	 * On FSL BookE, we have multiple higher-level table entries that
> -	 * point to the same hugepte.  Just use the first one since they're all
> -	 * identical.  So for that case, idx=0.
> -	 */
> -	unsigned long idx = 0;
> -
> -	pte_t *dir = hugepd_page(hpd);
> -#ifdef CONFIG_PPC_8xx
> -	idx = (addr & ((1UL << pdshift) - 1)) >> PAGE_SHIFT;
> -#elif !defined(CONFIG_PPC_FSL_BOOK3E)
> -	idx = (addr & ((1UL << pdshift) - 1)) >> hugepd_shift(hpd);
> -#endif
> -
> -	return dir + idx;
> -}
> -
>   void flush_dcache_icache_hugepage(struct page *page);
>   
>   int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
> @@ -101,15 +29,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>   
>   void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
>   			    pte_t pte);
> -#ifdef CONFIG_PPC_8xx
> -static inline void flush_hugetlb_page(struct vm_area_struct *vma,
> -				      unsigned long vmaddr)
> -{
> -	flush_tlb_page(vma, vmaddr);
> -}
> -#else
> -void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
> -#endif
>   
>   #define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
>   void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
> diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
> new file mode 100644
> index 000000000000..209e6a219835
> --- /dev/null
> +++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_NOHASH_32_HUGETLB_8XX_H
> +#define _ASM_POWERPC_NOHASH_32_HUGETLB_8XX_H
> +
> +static inline pte_t *hugepd_page(hugepd_t hpd)
> +{
> +	if (WARN_ON(!hugepd_ok(hpd)))
> +		return NULL;
> +
> +	return (pte_t *)__va(hpd_val(hpd) & ~HUGEPD_SHIFT_MASK);
> +}
> +
> +static inline unsigned int hugepd_shift(hugepd_t hpd)
> +{
> +	return ((hpd_val(hpd) & _PMD_PAGE_MASK) >> 1) + 17;
> +}
> +
> +static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
> +				    unsigned int pdshift)
> +{
> +	unsigned long idx = (addr & ((1UL << pdshift) - 1)) >> PAGE_SHIFT;
> +
> +	return hugepd_page(hpd) + idx;
> +}
> +
> +static inline void flush_hugetlb_page(struct vm_area_struct *vma,
> +				      unsigned long vmaddr)
> +{
> +	flush_tlb_page(vma, vmaddr);
> +}
> +
> +#endif /* _ASM_POWERPC_NOHASH_32_HUGETLB_8XX_H */
> diff --git a/arch/powerpc/include/asm/nohash/hugetlb-book3e.h b/arch/powerpc/include/asm/nohash/hugetlb-book3e.h
> new file mode 100644
> index 000000000000..e94f1cd048ee
> --- /dev/null
> +++ b/arch/powerpc/include/asm/nohash/hugetlb-book3e.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_NOHASH_HUGETLB_BOOK3E_H
> +#define _ASM_POWERPC_NOHASH_HUGETLB_BOOK3E_H
> +
> +static inline pte_t *hugepd_page(hugepd_t hpd)
> +{
> +	if (WARN_ON(!hugepd_ok(hpd)))
> +		return NULL;
> +
> +	return (pte_t *)((hpd_val(hpd) & ~HUGEPD_SHIFT_MASK) | PD_HUGE);
> +}
> +
> +static inline unsigned int hugepd_shift(hugepd_t hpd)
> +{
> +	return hpd_val(hpd) & HUGEPD_SHIFT_MASK;
> +}
> +
> +static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
> +				    unsigned int pdshift)
> +{
> +	/*
> +	 * On FSL BookE, we have multiple higher-level table entries that
> +	 * point to the same hugepte.  Just use the first one since they're all
> +	 * identical.  So for that case, idx=0.
> +	 */
> +	return hugepd_page(hpd);
> +}
> +
> +void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
> +
> +#endif /* _ASM_POWERPC_NOHASH_HUGETLB_BOOK3E_H */
> 
