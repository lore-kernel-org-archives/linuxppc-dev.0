Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkVHP0K8kzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 11:49:53 +1000 (AEST)
Received: by mail-pa0-x236.google.com with SMTP id zm5so3293857pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 18:49:52 -0700 (PDT)
Subject: Re: [PATCH V2 23/68] powerpc/mm: Make page table size a variable
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-24-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <570C5437.1070900@gmail.com>
Date: Tue, 12 Apr 2016 11:49:43 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-24-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> Radix and hash MMU models support different page table sizes. Make
> the #defines a variable so that existing code can work with variable
> sizes
> 
> Slice related code is only used by hash, so use hash constants there
> We will replicate some of the boundary conditions with resepct to
> TASK_SIZE using radix values too. Right now we do boundary condition
> check using hash constants
> 
> Swapper pgdir size is initialized in asm code. We select the max pgd
> size to keep it simpler. For now we select hash pgdir. When adding radix
> we will switch that to radix pgdir which is 64K.
> 
> BUILD_BUG_ON check which is removed is already done in hugepage_init using
> MAYBE_BUILD_BUG_ON()
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  | 45 ++++----------------
>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 46 +++++---------------
>  arch/powerpc/include/asm/book3s/64/hash.h     | 14 ++++---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  4 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 60 +++++++++++++++++++++++++++
>  arch/powerpc/include/asm/page_64.h            |  2 +-
>  arch/powerpc/kernel/asm-offsets.c             |  4 ++
>  arch/powerpc/mm/hash_utils_64.c               | 12 ++++++
>  arch/powerpc/mm/init_64.c                     |  4 +-
>  arch/powerpc/mm/pgtable-book3e.c              |  1 +
>  arch/powerpc/mm/pgtable-hash64.c              |  1 +
>  arch/powerpc/mm/pgtable_64.c                  | 33 ++++++++++-----
>  arch/powerpc/mm/slb_low.S                     |  2 +-
>  arch/powerpc/mm/slice.c                       |  4 +-
>  14 files changed, 135 insertions(+), 97 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> index 2f818cbd8aa6..dcb9d6e94a0c 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -5,48 +5,20 @@
>   * for each page table entry.  The PMD and PGD level use a 32b record for
>   * each entry by assuming that each entry is page aligned.
>   */
> -#define PTE_INDEX_SIZE  9
> -#define PMD_INDEX_SIZE  7
> -#define PUD_INDEX_SIZE  9
> -#define PGD_INDEX_SIZE  9
> +#define H_PTE_INDEX_SIZE  9
> +#define H_PMD_INDEX_SIZE  7
> +#define H_PUD_INDEX_SIZE  9
> +#define H_PGD_INDEX_SIZE  9
>  

Any comments on where these numbers came from?

>From these numbers for 4K pages we have

Each PMD is 2M
Each PUD is 256M
Each PGD is 128G


>  #ifndef __ASSEMBLY__
> -#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
> -#define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
> -#define PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
> -#define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
> -#endif	/* __ASSEMBLY__ */
> -
> -#define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
> -#define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
> -#define PTRS_PER_PUD	(1 << PUD_INDEX_SIZE)
> -#define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
> -
> -/* PMD_SHIFT determines what a second-level page table entry can map */
> -#define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
> -#define PMD_SIZE	(1UL << PMD_SHIFT)
> -#define PMD_MASK	(~(PMD_SIZE-1))
> +#define H_PTE_TABLE_SIZE	(sizeof(pte_t) << H_PTE_INDEX_SIZE)
> +#define H_PMD_TABLE_SIZE	(sizeof(pmd_t) << H_PMD_INDEX_SIZE)
> +#define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
> +#define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
>  
>  /* With 4k base page size, hugepage PTEs go at the PMD level */
>  #define MIN_HUGEPTE_SHIFT	PMD_SHIFT
>  
> -/* PUD_SHIFT determines what a third-level page table entry can map */
> -#define PUD_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
> -#define PUD_SIZE	(1UL << PUD_SHIFT)
> -#define PUD_MASK	(~(PUD_SIZE-1))
> -
> -/* PGDIR_SHIFT determines what a fourth-level page table entry can map */
> -#define PGDIR_SHIFT	(PUD_SHIFT + PUD_INDEX_SIZE)
> -#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
> -#define PGDIR_MASK	(~(PGDIR_SIZE-1))
> -
> -/* Bits to mask out from a PMD to get to the PTE page */
> -#define PMD_MASKED_BITS		0
> -/* Bits to mask out from a PUD to get to the PMD page */
> -#define PUD_MASKED_BITS		0
> -/* Bits to mask out from a PGD to get to the PUD page */
> -#define PGD_MASKED_BITS		0
> -
>  /* PTE flags to conserve for HPTE identification */
>  #define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | \
>  			 H_PAGE_F_SECOND | H_PAGE_F_GIX)
> @@ -56,7 +28,6 @@
>  #define H_PAGE_4K_PFN	0x0
>  #define H_PAGE_THP_HUGE 0x0
>  #define H_PAGE_COMBO	0x0
> -#ifndef __ASSEMBLY__
>  /*
>   * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range()
>   */
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 93bef8162d66..d60c431c96cb 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -1,34 +1,14 @@
>  #ifndef _ASM_POWERPC_BOOK3S_64_HASH_64K_H
>  #define _ASM_POWERPC_BOOK3S_64_HASH_64K_H
>  
> -#define PTE_INDEX_SIZE  8
> -#define PMD_INDEX_SIZE  5
> -#define PUD_INDEX_SIZE	5
> -#define PGD_INDEX_SIZE  12
> -

Each PMD is 16M
Each PUD is 512M
Each PGD is 16G


Looks good! We need some more comments eventually :)

Balbir Singh.
