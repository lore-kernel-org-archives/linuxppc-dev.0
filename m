Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61FAC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 03:59:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3A42084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 03:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3A42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438lP73Z2dzDqkj
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 14:59:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438lM01v5qzDqfk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 14:58:03 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 438lLv2KFFz9v08m;
 Wed,  5 Dec 2018 04:57:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Kk38z_MC9Tk2; Wed,  5 Dec 2018 04:57:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 438lLv1lX0z9v080;
 Wed,  5 Dec 2018 04:57:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DBEA38B829;
 Wed,  5 Dec 2018 04:57:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id CcdkBvj6wnPm; Wed,  5 Dec 2018 04:57:59 +0100 (CET)
Received: from [192.168.232.3] (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2654B8B755;
 Wed,  5 Dec 2018 04:57:59 +0100 (CET)
Subject: Re: [PATCH V3 5/5] arch/powerpc/mm/hugetlb: NestMMU workaround for
 hugetlb mprotect RW upgrade
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org
References: <20181205030931.12037-1-aneesh.kumar@linux.ibm.com>
 <20181205030931.12037-6-aneesh.kumar@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3b87e008-eb08-f41c-ef70-1986360c5df9@c-s.fr>
Date: Wed, 5 Dec 2018 04:57:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181205030931.12037-6-aneesh.kumar@linux.ibm.com>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 05/12/2018 à 04:09, Aneesh Kumar K.V a écrit :
> NestMMU requires us to mark the pte invalid and flush the tlb when we do a
> RW upgrade of pte. We fixed a variant of this in the fault path in commit
> Fixes: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/book3s/64/hugetlb.h | 12 ++++++++
>   arch/powerpc/mm/hugetlbpage-radix.c          | 17 ++++++++++++
>   arch/powerpc/mm/hugetlbpage.c                | 29 ++++++++++++++++++++
>   3 files changed, 58 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> index 5b0177733994..66c1e4f88d65 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -13,6 +13,10 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   				unsigned long len, unsigned long pgoff,
>   				unsigned long flags);
>   
> +extern void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
> +						unsigned long addr, pte_t *ptep,
> +						pte_t old_pte, pte_t pte);
> +
>   static inline int hstate_get_psize(struct hstate *hstate)
>   {
>   	unsigned long shift;
> @@ -42,4 +46,12 @@ static inline bool gigantic_page_supported(void)
>   /* hugepd entry valid bit */
>   #define HUGEPD_VAL_BITS		(0x8000000000000000UL)
>   
> +#define huge_ptep_modify_prot_start huge_ptep_modify_prot_start
> +extern pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
> +					 unsigned long addr, pte_t *ptep);
> +
> +#define huge_ptep_modify_prot_commit huge_ptep_modify_prot_commit
> +extern void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
> +					 unsigned long addr, pte_t *ptep,
> +					 pte_t old_pte, pte_t new_pte);
>   #endif
> diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
> index 2486bee0f93e..11d9ea28a816 100644
> --- a/arch/powerpc/mm/hugetlbpage-radix.c
> +++ b/arch/powerpc/mm/hugetlbpage-radix.c
> @@ -90,3 +90,20 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   
>   	return vm_unmapped_area(&info);
>   }
> +
> +void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
> +					 unsigned long addr, pte_t *ptep,
> +					 pte_t old_pte, pte_t pte)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +
> +	/*
> +	 * To avoid NMMU hang while relaxing access we need to flush the tlb before
> +	 * we set the new value.
> +	 */
> +	if (is_pte_rw_upgrade(pte_val(old_pte), pte_val(pte)) &&
> +	    (atomic_read(&mm->context.copros) > 0))
> +		radix__flush_hugetlb_page(vma, addr);
> +
> +	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
> +}
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 8cf035e68378..39d33a3d0dc6 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -912,3 +912,32 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>   
>   	return 1;
>   }
> +
> +#ifdef CONFIG_PPC_BOOK3S_64

Could this go in hugetlbpage-hash64.c instead to avoid the #ifdef sequence ?

Christophe

> +pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
> +				  unsigned long addr, pte_t *ptep)
> +{
> +	unsigned long pte_val;
> +	/*
> +	 * Clear the _PAGE_PRESENT so that no hardware parallel update is
> +	 * possible. Also keep the pte_present true so that we don't take
> +	 * wrong fault.
> +	 */
> +	pte_val = pte_update(vma->vm_mm, addr, ptep,
> +			     _PAGE_PRESENT, _PAGE_INVALID, 1);
> +
> +	return __pte(pte_val);
> +}
> +EXPORT_SYMBOL(huge_ptep_modify_prot_start);
> +
> +void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
> +				  pte_t *ptep, pte_t old_pte, pte_t pte)
> +{
> +
> +	if (radix_enabled())
> +		return radix__huge_ptep_modify_prot_commit(vma, addr, ptep,
> +							   old_pte, pte);
> +	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
> +}
> +EXPORT_SYMBOL(huge_ptep_modify_prot_commit);
> +#endif
> 
