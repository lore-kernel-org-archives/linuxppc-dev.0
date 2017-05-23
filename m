Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXBrg685SzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 20:40:51 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id u75so22260008qka.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 03:40:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170523040524.13717-4-oohall@gmail.com>
References: <20170523040524.13717-1-oohall@gmail.com>
 <20170523040524.13717-4-oohall@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 23 May 2017 20:40:48 +1000
Message-ID: <CAKTCnz=tbEYossD8X5z87UEYCLfz4ah+6hZSDRcnXbDmjRqN+Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] powerpc/mm: Add devmap support for ppc64
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, linux-mm <linux-mm@kvack.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 23, 2017 at 2:05 PM, Oliver O'Halloran <oohall@gmail.com> wrote:
> Add support for the devmap bit on PTEs and PMDs for PPC64 Book3S.  This
> is used to differentiate device backed memory from transparent huge
> pages since they are handled in more or less the same manner by the core
> mm code.
>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> v1 -> v2: Properly differentiate THP and PMD Devmap entries. The
> mm core assumes that pmd_trans_huge() and pmd_devmap() are mutually
> exclusive and v1 had pmd_trans_huge() being true on a devmap pmd.
>
> Aneesh, this has been fleshed out substantially since v1. Can you
> re-review it? Also no explicit gup support is required in this patch
> since devmap support was added generic GUP as a part of making x86 use
> the generic version.
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 37 ++++++++++++++++++++++++++-
>  arch/powerpc/include/asm/book3s/64/radix.h    |  2 +-
>  arch/powerpc/mm/hugetlbpage.c                 |  2 +-
>  arch/powerpc/mm/pgtable-book3s64.c            |  4 +--
>  arch/powerpc/mm/pgtable-hash64.c              |  4 ++-
>  arch/powerpc/mm/pgtable-radix.c               |  3 ++-
>  arch/powerpc/mm/pgtable_64.c                  |  2 +-
>  8 files changed, 47 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 9732837aaae8..eaaf613c5347 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -180,7 +180,7 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
>   */
>  static inline int hash__pmd_trans_huge(pmd_t pmd)
>  {
> -       return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE)) ==
> +       return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE | _PAGE_DEVMAP)) ==
>                   (_PAGE_PTE | H_PAGE_THP_HUGE));
>  }

Like Aneesh suggested, I think we can probably skip this check here

>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 85bc9875c3be..24634e92dd0b 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -79,6 +79,9 @@
>
>  #define _PAGE_SOFT_DIRTY       _RPAGE_SW3 /* software: software dirty tracking */
>  #define _PAGE_SPECIAL          _RPAGE_SW2 /* software: special page */
> +#define _PAGE_DEVMAP           _RPAGE_SW1
> +#define __HAVE_ARCH_PTE_DEVMAP
> +
>  /*
>   * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
>   * Instead of fixing all of them, add an alternate define which
> @@ -599,6 +602,16 @@ static inline pte_t pte_mkhuge(pte_t pte)
>         return pte;
>  }
>
> +static inline pte_t pte_mkdevmap(pte_t pte)
> +{
> +       return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
> +}
> +
> +static inline int pte_devmap(pte_t pte)
> +{
> +       return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DEVMAP));
> +}
> +
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {
>         /* FIXME!! check whether this need to be a conditional */
> @@ -963,6 +976,9 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
>  #define pmd_mk_savedwrite(pmd) pte_pmd(pte_mk_savedwrite(pmd_pte(pmd)))
>  #define pmd_clear_savedwrite(pmd)      pte_pmd(pte_clear_savedwrite(pmd_pte(pmd)))
>
> +#define pud_pfn(...) (0)
> +#define pgd_pfn(...) (0)
> +

Don't get these bits.. why are they zero?

>  #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>  #define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
>  #define pmd_mksoft_dirty(pmd)  pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
> @@ -1137,7 +1153,6 @@ static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
>         return true;
>  }
>
> -
>  #define arch_needs_pgtable_deposit arch_needs_pgtable_deposit
>  static inline bool arch_needs_pgtable_deposit(void)
>  {
> @@ -1146,6 +1161,26 @@ static inline bool arch_needs_pgtable_deposit(void)
>         return true;
>  }
>
> +static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> +{
> +       return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
> +}
> +
> +static inline int pmd_devmap(pmd_t pmd)
> +{
> +       return pte_devmap(pmd_pte(pmd));
> +}

This should be defined only if #ifdef __HAVE_ARCH_PTE_DEVMAP

The rest looks OK

Balbir Singh.
