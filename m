Return-Path: <dgibson@ozlabs.org>
Date: Fri, 12 Sep 2008 13:48:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
Message-ID: <20080912034814.GE22288@yookeroo.seuss>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1221083587-8091-2-git-send-email-yanok@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 11, 2008 at 01:53:06AM +0400, Ilya Yanok wrote:
> This patch adds support for page sizes bigger than 4KB (16KB/64KB/256KB) on
> PPC 44x.

[snip]
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 587da5e..ca93157 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -413,6 +413,29 @@ config PPC_64K_PAGES
>  	  while on hardware with such support, it will be used to map
>  	  normal application pages.
>  
> +choice
> +	prompt "Page size"
> +	depends on 44x && PPC32
> +	default PPC32_4K_PAGES
> +	help
> +	  The PAGE_SIZE definition. Increasing the page size may
> +	  improve the system performance in some dedicated cases.
> +	  If unsure, set it to 4 KB.
> +
> +config PPC32_4K_PAGES
> +	bool "4k page size"
> +
> +config PPC32_16K_PAGES
> +	bool "16k page size"
> +
> +config PPC32_64K_PAGES
> +	bool "64k page size"
> +
> +config PPC32_256K_PAGES
> +	bool "256k page size"
> +

I don't see any reason to have a separate set of config options for 32
and 64-bit.  Just make the once choice, but only have the individual
pagesize options enabled on machines that support them.

[snip]
> index e088545..1de90b4 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -15,12 +15,17 @@
>  #include <asm/types.h>
>  
>  /*
> - * On PPC32 page size is 4K. For PPC64 we support either 4K or 64K software
> + * On regular PPC32 page size is 4K (but we support 4K/16K/64K/256K pages
> + * on PPC44x). For PPC64 we support either 4K or 64K software
>   * page size. When using 64K pages however, whether we are really supporting
>   * 64K pages in HW or not is irrelevant to those definitions.
>   */
> -#ifdef CONFIG_PPC_64K_PAGES
> +#if defined(CONFIG_PPC32_256K_PAGES)
> +#define PAGE_SHIFT		18
> +#elif defined(CONFIG_PPC32_64K_PAGES) || defined(CONFIG_PPC_64K_PAGES)
>  #define PAGE_SHIFT		16
> +#elif defined(CONFIG_PPC32_16K_PAGES)
> +#define PAGE_SHIFT		14
>  #else
>  #define PAGE_SHIFT		12
>  #endif
> @@ -140,11 +145,19 @@ typedef struct { pte_basic_t pte; } pte_t;
>  /* 64k pages additionally define a bigger "real PTE" type that gathers
>   * the "second half" part of the PTE for pseudo 64k pages
>   */
> +#ifdef CONFIG_PPC64
>  #ifdef CONFIG_PPC_64K_PAGES
>  typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
>  #else
>  typedef struct { pte_t pte; } real_pte_t;
>  #endif
> +#else
> +#ifdef CONFIG_PPC32_4K_PAGES
> +typedef struct { pte_t pte; } real_pte_t;
> +#else
> +typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;

I don't think you should need a real_pte_t type for the 32-bit
implementation.  It's just there because of how we implement
64k granularity page allocation on hardware that only does 4k
translations.

[snip]
> diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
> index ebfae53..d176270 100644
> --- a/arch/powerpc/include/asm/page_32.h
> +++ b/arch/powerpc/include/asm/page_32.h
> @@ -20,7 +20,11 @@
>   */
>  #ifdef CONFIG_PTE_64BIT
>  typedef unsigned long long pte_basic_t;
> +#ifdef CONFIG_PPC32_256K_PAGES
> +#define PTE_SHIFT	(PAGE_SHIFT - 7)

This doesn't look right.  You should be eliding one of the levels of
page table if you don't need it, rather than leaving the bottom level
PTE page largely empty.

[snip]
> +#if (PAGE_SHIFT == 12)
> +/*
> + * PAGE_SIZE  4K
> + * PAGE_SHIFT 12
> + * PTE_SHIFT   9
> + * PMD_SHIFT  21
> + */
> +#define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
> +#define PPC44x_PGD_OFF_SH	13 /*(32 - PMD_SHIFT + 2)*/
> +#define PPC44x_PGD_OFF_M1	19 /*(PMD_SHIFT - 2)*/
> +#define PPC44x_PTE_ADD_SH	23 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
> +#define PPC44x_PTE_ADD_M1	20 /*32 - 3 - PTE_SHIFT*/
> +#define PPC44x_RPN_M2		19 /*31 - PAGE_SHIFT*/

Uh.. you have the formulae for these things right there in the
comments, so why aren't you using those and avoiding this nasty
multiway ifdef...

[snip]
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 9665a26..4e7cd1f 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -15,8 +15,12 @@
>  #ifdef CONFIG_PPC64
>  #define THREAD_SHIFT		14
>  #else
> +#if defined(CONFIG_PPC32_256K_PAGES)
> +#define THREAD_SHIFT		15

Hrm.. more peculiar special cases for 256K pages.  I think it might be
clearer if you split the patch into one which supports page sizes up
to 64k, then another that does the extra hacks for 256k pages.

[snip]
> @@ -391,12 +392,14 @@ interrupt_base:
>  	rlwimi	r13,r12,10,30,30
>  
>  	/* Load the PTE */
> -	rlwinm 	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
> +	/* Compute pgdir/pmd offset */
> +	rlwinm  r12, r10, PPC44x_PGD_OFF_SH, PPC44x_PGD_OFF_M1, 29

I agree with others that these constants need better names.  Or even
derive the values from PMD_SHIFT or whatnot right here inline, rather
than defining special constants.

[snip]
> diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
> index fce2df9..4f802df 100644
> --- a/arch/powerpc/kernel/head_booke.h
> +++ b/arch/powerpc/kernel/head_booke.h
> @@ -20,7 +20,9 @@
>  	beq	1f;							     \
>  	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
>  	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
> -	addi	r1,r1,THREAD_SIZE;					     \
> +	lis	r11,THREAD_SIZE@h;					     \
> +	ori	r11,r11,THREAD_SIZE@l;					     \
> +	add	r1,r1,r11;
> \

It would be nice if we could avoid the extra instruction here when the
page sizes isn't big enough to require it.

>  1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
>  	mr	r11,r1;							     \
>  	stw	r10,_CCR(r11);          /* save various registers	   */\
> @@ -112,7 +114,8 @@
>  	andi.	r10,r10,MSR_PR;						     \
>  	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
>  	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
> -	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
> +	addis	r11,r11,EXC_LVL_FRAME_OVERHEAD@ha; /* allocate stack frame */\
> +	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD@l;  /* allocate stack frame */\

And here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
