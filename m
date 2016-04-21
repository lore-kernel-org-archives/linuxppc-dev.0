Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrGxy3bNvzDqZK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 21:39:50 +1000 (AEST)
Received: by mail-pa0-x22c.google.com with SMTP id r5so25804943pag.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 04:39:50 -0700 (PDT)
Subject: Re: [PATCH V2 30/68] powerpc/mm/radix: Add radix callback for pmd
 accessors
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-31-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5718BBE9.5010205@gmail.com>
Date: Thu, 21 Apr 2016 21:39:21 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-31-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> This only does 64k linux page support for now. 64k hash linux config
> THP need to differentiate it from hugetlb huge page because with THP
> we need to track hash pte slot information with respect to each subpage.
> This is not needed with hugetlb hugepage, because we don't do MPSS with

MPSS?

> hugetlb.
> 
> Radix doesn't have any such restrictions.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h    |  9 ++++-----
>  arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 23 +++++++++++++++++++++++
>  arch/powerpc/include/asm/book3s/64/radix.h       |  9 +++++++++
>  3 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 173f35e9faef..ad797a8cc615 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -97,8 +97,8 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
>  
>  extern int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
>  			   unsigned long pfn, unsigned long size, pgprot_t);
> -static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
> -			       unsigned long pfn, pgprot_t prot)
> +static inline int hlremap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
> +				 unsigned long pfn, pgprot_t prot)
>  {
>  	if (pfn > (PTE_RPN_MASK >> PAGE_SHIFT)) {
>  		WARN(1, "remap_4k_pfn called with wrong pfn value\n");
> @@ -182,14 +182,13 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
>   * that for explicit huge pages.
>   *
>   */
> -static inline int pmd_trans_huge(pmd_t pmd)
> +static inline int hlpmd_trans_huge(pmd_t pmd)
>  {
>  	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE)) ==
>  		  (_PAGE_PTE | H_PAGE_THP_HUGE));
>  }
>  
> -#define __HAVE_ARCH_PMD_SAME
> -static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
> +static inline int hlpmd_same(pmd_t pmd_a, pmd_t pmd_b)
>  {
>  	return (((pmd_val(pmd_a) ^ pmd_val(pmd_b)) & ~_PAGE_HPTEFLAGS) == 0);
>  }
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> index ceadc2fd408f..028b8f6e002b 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
> @@ -89,6 +89,29 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
>  }
>  
> +static inline int pmd_trans_huge(pmd_t pmd)
> +{
> +	if (radix_enabled())
> +		return rpmd_trans_huge(pmd);
> +	return hlpmd_trans_huge(pmd);
> +}
> +
> +#define __HAVE_ARCH_PMD_SAME
> +static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
> +{
> +	if (radix_enabled())
> +		return rpmd_same(pmd_a, pmd_b);
> +	return hlpmd_same(pmd_a, pmd_b);
> +}
>  #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
> +			       unsigned long pfn, pgprot_t prot)
> +{
> +	if (radix_enabled())
> +		BUG();
> +	return hlremap_4k_pfn(vma, addr, pfn, prot);
> +
> +}

So bsr_mmap() driver will BUG() with 64K Radix page size? Is this fixed later?

Balbir
