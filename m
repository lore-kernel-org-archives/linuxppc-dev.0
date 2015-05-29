Return-Path: <hmyneni@gmail.com>
Received: from mail-la0-x231.google.com (mail-la0-x231.google.com
 [IPv6:2a00:1450:4010:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 602011A05C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:09:58 +1000 (AEST)
Received: by laat2 with SMTP id t2so49969547laa.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 01:09:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1432871692-707-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1432871692-707-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1432871692-707-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 29 May 2015 01:09:53 -0700
Message-ID: <CACgMoi+DU_cso2Ovpen7ERWzE2qRKm_oDKRBgtx9CytcfnkD0w@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc/mm: Change the swap encoding in pte.
From: Haren Myneni <hmyneni@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested this patch on 16TB system and fixed the BUG_ON issue mentioned
here - https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-May/128767.html

I was able to reproduce this issue in all previous releases (tested
from 3.14). So this patch should be also in stable tree.

Acked-by: Haren Myneni <hbabu@us.ibm.com>

On 5/28/15, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> Current swap encoding in pte can't support large pfns
> above 4TB. Change the swap encoding such that we put
> the swap type in the PTE bits. Also add build checks
> to make sure we don't overlap with HPTEFLAGS.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pgtable-ppc64.h | 26 +++++++++++++++++++++-----
>  arch/powerpc/include/asm/pte-book3e.h    |  1 +
>  arch/powerpc/include/asm/pte-hash64.h    |  1 +
>  3 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h
> b/arch/powerpc/include/asm/pgtable-ppc64.h
> index 43e6ad424c7f..954ae1201e42 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -347,11 +347,27 @@ static inline void __ptep_set_access_flags(pte_t
> *ptep, pte_t entry)
>  	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
>
>  /* Encode and de-code a swap entry */
> -#define __swp_type(entry)	(((entry).val >> 1) & 0x3f)
> -#define __swp_offset(entry)	((entry).val >> 8)
> -#define __swp_entry(type, offset) ((swp_entry_t){((type)<<
> 1)|((offset)<<8)})
> -#define __pte_to_swp_entry(pte)	((swp_entry_t){pte_val(pte) >>
> PTE_RPN_SHIFT})
> -#define __swp_entry_to_pte(x)	((pte_t) { (x).val << PTE_RPN_SHIFT })
> +#define MAX_SWAPFILES_CHECK() do { \
> +	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS); \
> +	/*							\
> +	 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
> +	 * We filter HPTEFLAGS on set_pte.			\
> +	 */							\
> +	BUILD_BUG_ON(_PAGE_HPTEFLAGS & (0x1f << _PAGE_BIT_SWAP_TYPE)); \
> +	} while (0)
> +/*
> + * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
> + */
> +#define SWP_TYPE_BITS 5
> +#define __swp_type(x)		(((x).val >> _PAGE_BIT_SWAP_TYPE) \
> +				& ((1UL << SWP_TYPE_BITS) - 1))
> +#define __swp_offset(x)		((x).val >> PTE_RPN_SHIFT)
> +#define __swp_entry(type, offset)	((swp_entry_t) { \
> +					((type) << _PAGE_BIT_SWAP_TYPE) \
> +					| ((offset) << PTE_RPN_SHIFT) })
> +
> +#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
> +#define __swp_entry_to_pte(x)		__pte((x).val)
>
>  void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
>  void pgtable_cache_init(void);
> diff --git a/arch/powerpc/include/asm/pte-book3e.h
> b/arch/powerpc/include/asm/pte-book3e.h
> index 91a704952ca1..8d8473278d91 100644
> --- a/arch/powerpc/include/asm/pte-book3e.h
> +++ b/arch/powerpc/include/asm/pte-book3e.h
> @@ -11,6 +11,7 @@
>  /* Architected bits */
>  #define _PAGE_PRESENT	0x000001 /* software: pte contains a translation */
>  #define _PAGE_SW1	0x000002
> +#define _PAGE_BIT_SWAP_TYPE	2
>  #define _PAGE_BAP_SR	0x000004
>  #define _PAGE_BAP_UR	0x000008
>  #define _PAGE_BAP_SW	0x000010
> diff --git a/arch/powerpc/include/asm/pte-hash64.h
> b/arch/powerpc/include/asm/pte-hash64.h
> index fc852f7e7b3a..ef612c160da7 100644
> --- a/arch/powerpc/include/asm/pte-hash64.h
> +++ b/arch/powerpc/include/asm/pte-hash64.h
> @@ -16,6 +16,7 @@
>   */
>  #define _PAGE_PRESENT		0x0001 /* software: pte contains a translation */
>  #define _PAGE_USER		0x0002 /* matches one of the PP bits */
> +#define _PAGE_BIT_SWAP_TYPE	2
>  #define _PAGE_EXEC		0x0004 /* No execute on POWER4 and newer (we invert)
> */
>  #define _PAGE_GUARDED		0x0008
>  /* We can derive Memory coherence from _PAGE_NO_CACHE */
> --
> 2.1.4
>
>
