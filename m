Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tT1Bb231kzDvpd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 11:14:47 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id e9so17777141pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:14:47 -0800 (PST)
Subject: Re: [PATCH v7 3/7] powerpc/mm: Introduce _PAGE_LARGE software pte bits
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20161128061704.4914-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161128061704.4914-4-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <2b65879e-e0c7-f915-b622-290899e41031@gmail.com>
Date: Wed, 30 Nov 2016 11:14:38 +1100
MIME-Version: 1.0
In-Reply-To: <20161128061704.4914-4-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28/11/16 17:17, Aneesh Kumar K.V wrote:
> This patch adds a new software defined pte bit. We use the reserved
> fields of ISA 3.0 pte definition since we will only be using this
> on DD1 code paths. We can possibly look at removing this code later.
> 
> The software bit will be used to differentiate between 64K/4K and 2M ptes.
> This helps in finding the page size mapping by a pte so that we can do efficient
> tlb flush.
> 
> We don't support 1G hugetlb pages yet. So we add a DEBUG WARN_ON to catch
> wrong usage.
> 

I thought we do in hugetlb_page_init() don't we register sizes for every size
from 0 to MMU_PAGE_COUNT?

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hugetlb.h | 20 ++++++++++++++++++++
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  9 +++++++++
>  arch/powerpc/include/asm/book3s/64/radix.h   |  2 ++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> index d9c283f95e05..c62f14d0bec1 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -30,4 +30,24 @@ static inline int hstate_get_psize(struct hstate *hstate)
>  		return mmu_virtual_psize;
>  	}
>  }
> +
> +#define arch_make_huge_pte arch_make_huge_pte
> +static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
> +				       struct page *page, int writable)
> +{
> +	unsigned long page_shift;
> +
> +	if (!cpu_has_feature(CPU_FTR_POWER9_DD1))
> +		return entry;
> +
> +	page_shift = huge_page_shift(hstate_vma(vma));
> +	/*
> +	 * We don't support 1G hugetlb pages yet.
> +	 */
> +	VM_WARN_ON(page_shift == mmu_psize_defs[MMU_PAGE_1G].shift);
> +	if (page_shift == mmu_psize_defs[MMU_PAGE_2M].shift)
> +		return __pte(pte_val(entry) | _PAGE_LARGE);
> +	else
> +		return entry;
> +}
>  #endif
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 86870c11917b..6f39b9d134a2 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -26,6 +26,11 @@
>  #define _RPAGE_SW1		0x00800
>  #define _RPAGE_SW2		0x00400
>  #define _RPAGE_SW3		0x00200
> +#define _RPAGE_RSV1		0x1000000000000000UL
> +#define _RPAGE_RSV2		0x0800000000000000UL
> +#define _RPAGE_RSV3		0x0400000000000000UL
> +#define _RPAGE_RSV4		0x0200000000000000UL
> +

We use the top 4 bits and not the _SW bits?

>  #ifdef CONFIG_MEM_SOFT_DIRTY
>  #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
>  #else
> @@ -34,6 +39,10 @@
>  #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
>  #define _PAGE_DEVMAP		_RPAGE_SW1
>  #define __HAVE_ARCH_PTE_DEVMAP
> +/*
> + * For DD1 only, we need to track whether the pte huge

For POWER9_DD1 only

> + */
> +#define _PAGE_LARGE	_RPAGE_RSV1
>  
>  
>  #define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> index 2a46dea8e1b1..d2c5c064e266 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -243,6 +243,8 @@ static inline int radix__pmd_trans_huge(pmd_t pmd)
>  
>  static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
>  {
> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
> +		return __pmd(pmd_val(pmd) | _PAGE_PTE | _PAGE_LARGE);
>  	return __pmd(pmd_val(pmd) | _PAGE_PTE);
>  }
>  static inline void radix__pmdp_huge_split_prepare(struct vm_area_struct *vma,
> 
