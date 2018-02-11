Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfjzH6MRLzDqYv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 09:24:59 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1BMNcCY125427
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 17:24:57 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g2f3jbnsx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 17:24:57 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sun, 11 Feb 2018 22:24:55 -0000
Date: Sun, 11 Feb 2018 14:24:49 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 1/4] powerpc/mm: Fix crashes with PUD level hugetlb
 config
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180211150009.21297-1-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180211150009.21297-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180211222449.GD5559@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 11, 2018 at 08:30:06PM +0530, Aneesh Kumar K.V wrote:
> To support memory keys, we moved the hash pte slot information to the second
> half of the page table. This was ok with PTE entries at level 4 and level 3.
> We already allocate larger page table pages at those level to accomodate extra
> details. For level 4 we already have the extra space which was used to track
> 4k hash page table entry details and at pmd level the extra space was allocated
> to track the THP details.
> 
> With hugetlbfs PTE, we used this extra space at the PMD level to store the
> slot details. But we also support hugetlbfs PTE at PUD leve and PUD level page
> didn't allocate extra space. This resulted in memory corruption.
> 
> Fix this by allocating extra space at PUD level when HUGETLB is enabled. We
> may need further changes to allocate larger space at PMD level when we enable
> HUGETLB. That will be done in next patch.
> 
> Fixes:bf9a95f9a6481bc6e(" powerpc: Free up four 64K PTE bits in 64K backed HPTE pages")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/32/pgtable.h  |  1 +
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |  5 +++++
>  arch/powerpc/include/asm/book3s/64/hash.h     | 10 ++++++++++
>  arch/powerpc/include/asm/book3s/64/pgalloc.h  |  6 +++---
>  arch/powerpc/include/asm/book3s/64/pgtable.h  |  2 ++
>  arch/powerpc/include/asm/nohash/32/pgtable.h  |  1 +
>  arch/powerpc/include/asm/nohash/64/pgtable.h  |  1 +
>  arch/powerpc/mm/hash_utils_64.c               |  1 +
>  arch/powerpc/mm/init-common.c                 |  4 ++--
>  arch/powerpc/mm/pgtable-radix.c               |  1 +
>  arch/powerpc/mm/pgtable_64.c                  |  2 ++
>  11 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 30a155c0a6b0..c615abdce119 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -16,6 +16,7 @@
>  #define PGD_INDEX_SIZE	(32 - PGDIR_SHIFT)
> 
>  #define PMD_CACHE_INDEX	PMD_INDEX_SIZE
> +#define PUD_CACHE_INDEX	PUD_INDEX_SIZE
> 
>  #ifndef __ASSEMBLY__
>  #define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 338b7da468ce..c08b3b032ec0 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -146,7 +146,12 @@ static inline int hash__remap_4k_pfn(struct vm_area_struct *vma, unsigned long a
>  #else
>  #define H_PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
>  #endif
> +#ifdef CONFIG_HUGETLB_PAGE
> +#define H_PUD_TABLE_SIZE	((sizeof(pud_t) << PUD_INDEX_SIZE) +	\
> +				 (sizeof(unsigned long) << PUD_INDEX_SIZE))
> +#else
>  #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
> +#endif
>  #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
> 
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index 0920eff731b3..234f141fb151 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -32,6 +32,16 @@
>  #else
>  #define H_PMD_CACHE_INDEX	H_PMD_INDEX_SIZE
>  #endif
> +/*
> + * We not store the slot details in the second half of page table.

s/not//
We store....


Reviewed-by: Ram Pai <linuxram@us.ibm.com>
