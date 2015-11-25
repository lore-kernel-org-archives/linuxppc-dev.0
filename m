Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85E751A0338
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 16:26:35 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 10:56:33 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 16255E005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 10:57:05 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAP5QT2J60555304
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 10:56:29 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAP5QSME010836
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 10:56:28 +0530
Message-ID: <56554683.6070105@linux.vnet.ibm.com>
Date: Wed, 25 Nov 2015 10:56:27 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 08/31] powerpc/mm: Drop pte-common.h from BOOK3S 64
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2015 03:52 PM, Aneesh Kumar K.V wrote:
> We copy only needed PTE bits define from pte-common.h to respective
> hash related header. This should greatly simply later patches in which
                     
           Will it be simplify            ^^^^^^^^

> we are going to change the pte format for hash config
> 
> Acked-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h |   1 +
>  arch/powerpc/include/asm/book3s/64/hash.h    |   2 +
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 106 ++++++++++++++++++++++++++-
>  arch/powerpc/include/asm/book3s/pgtable.h    |  16 ++--
>  4 files changed, 113 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> index f2c51cd61f69..15518b620f5a 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -62,6 +62,7 @@
>  /* shift to put page number into pte */
>  #define PTE_RPN_SHIFT	(17)
>  
> +#define _PAGE_4K_PFN		0
>  #ifndef __ASSEMBLY__
>  /*
>   * 4-level page tables related bits
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index 8e60d4fa434d..7deb5063ff8c 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -20,6 +20,7 @@
>  #define _PAGE_EXEC		0x0004 /* No execute on POWER4 and newer (we invert) */
>  #define _PAGE_GUARDED		0x0008
>  /* We can derive Memory coherence from _PAGE_NO_CACHE */
> +#define _PAGE_COHERENT		0x0
>  #define _PAGE_NO_CACHE		0x0020 /* I: cache inhibit */
>  #define _PAGE_WRITETHRU		0x0040 /* W: cache write-through */
>  #define _PAGE_DIRTY		0x0080 /* C: page changed */
> @@ -30,6 +31,7 @@
>  /* No separate kernel read-only */
>  #define _PAGE_KERNEL_RW		(_PAGE_RW | _PAGE_DIRTY) /* user access blocked by key */
>  #define _PAGE_KERNEL_RO		 _PAGE_KERNEL_RW
> +#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_EXEC)
>  
>  /* Strong Access Ordering */
>  #define _PAGE_SAO		(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index ddc08bf22709..e41b9d47cc32 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -94,11 +94,111 @@
>  #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
>  			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
>  			 _PAGE_THP_HUGE)
> +#define _PTE_NONE_MASK	_PAGE_HPTEFLAGS
>  /*
> - * Default defines for things which we don't use.
> - * We should get this removed.
> + * The mask convered by the RPN must be a ULL on 32-bit platforms with
> + * 64-bit PTEs
> + * FIXME!! double check the RPN_MAX May be not used
>   */
> -#include <asm/pte-common.h>
> +//#define PTE_RPN_MAX	(1UL << (32 - PTE_RPN_SHIFT))

Why this commented definition, this was not part of original PTE
definitions in pte-common.h

>  /*
> diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
> index fa270cfcf30a..87333618af3b 100644
> --- a/arch/powerpc/include/asm/book3s/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/pgtable.h
> @@ -11,10 +11,7 @@
>  #ifndef __ASSEMBLY__
>  
>  /* Generic accessors to PTE bits */
> -static inline int pte_write(pte_t pte)
> -{
> -	return (pte_val(pte) & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO;
> -}
> +static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}


>  /* Generic modifiers for PTE bits */
> -static inline pte_t pte_wrprotect(pte_t pte) {
> -	pte_val(pte) &= ~(_PAGE_RW | _PAGE_HWWRITE);
> -	pte_val(pte) |= _PAGE_RO; return pte; }
> +static inline pte_t pte_wrprotect(pte_t pte)
> +{
> +	pte_val(pte) &= ~_PAGE_RW;
> +	return pte;
> +}
>  static inline pte_t pte_mkclean(pte_t pte) {
> -	pte_val(pte) &= ~(_PAGE_DIRTY | _PAGE_HWWRITE); return pte; }
> +	pte_val(pte) &= ~_PAGE_DIRTY; return pte; }


Should not these changes in function definitions happen in a separate patch.
The commit message here does not speak about these changes happening.
