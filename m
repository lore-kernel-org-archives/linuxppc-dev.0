Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1CB4DDF70
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 13:49:16 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix _PAGE_CHG_MASK
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: rpm@xenomai.org
In-Reply-To: <4994A046.2080806@xenomai.org>
References: <4994A046.2080806@xenomai.org>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 13:49:10 +1100
Message-Id: <1234493350.29851.80.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-12 at 23:18 +0100, Philippe Gerum wrote:
> Fix _PAGE_CHG_MASK so that pte_modify() does not affect the _PAGE_SPECIAL bit.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>

Good catch ! Thanks !

Ben.

> --
> 
>  arch/powerpc/include/asm/pgtable-4k.h    |    2 +-
>  arch/powerpc/include/asm/pgtable-64k.h   |    2 +-
>  arch/powerpc/include/asm/pgtable-ppc32.h |    4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pgtable-4k.h b/arch/powerpc/include/asm/pgtable-4k.h
> index 6b18ba9..1dbca4e 100644
> --- a/arch/powerpc/include/asm/pgtable-4k.h
> +++ b/arch/powerpc/include/asm/pgtable-4k.h
> @@ -60,7 +60,7 @@
>  /* It should be preserving the high 48 bits and then specifically */
>  /* preserving _PAGE_SECONDARY | _PAGE_GROUP_IX */
>  #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | \
> -                         _PAGE_HPTEFLAGS)
> +                         _PAGE_HPTEFLAGS | _PAGE_SPECIAL)
> 
>  /* Bits to mask out from a PMD to get to the PTE page */
>  #define PMD_MASKED_BITS		0
> diff --git a/arch/powerpc/include/asm/pgtable-64k.h b/arch/powerpc/include/asm/pgtable-64k.h
> index 07b0d8f..7389003 100644
> --- a/arch/powerpc/include/asm/pgtable-64k.h
> +++ b/arch/powerpc/include/asm/pgtable-64k.h
> @@ -114,7 +114,7 @@ static inline struct subpage_prot_table *pgd_subpage_prot(pgd_t *pgd)
>   * pgprot changes
>   */
>  #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
> -                         _PAGE_ACCESSED)
> +                         _PAGE_ACCESSED | _PAGE_SPECIAL)
> 
>  /* Bits to mask out from a PMD to get to the PTE page */
>  #define PMD_MASKED_BITS		0x1ff
> diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
> index 75dded6..8298afc 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc32.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc32.h
> @@ -428,8 +428,8 @@ extern int icache_44x_need_flush;
>  #define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
>  #endif
> 
> -#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_SPECIAL)
> -
> +#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | \
> +			 _PAGE_SPECIAL)
> 
>  #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
>  			 _PAGE_WRITETHRU | _PAGE_ENDIAN | \
> 
