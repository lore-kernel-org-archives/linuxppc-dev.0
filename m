Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6BBE7DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 12:18:57 +1000 (EST)
Message-Id: <7B3D2AD1-DBC4-41DB-91EE-D070CA4B47AD@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: benh@kernel.crashing.org
In-Reply-To: <1213145431.25745.42.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC/PATCH] powerpc: rework 4xx PTE access and TLB miss
Date: Tue, 10 Jun 2008 21:18:41 -0500
References: <1213145431.25745.42.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> Index: linux-work/include/asm-powerpc/pgtable-ppc32.h
> ===================================================================
> --- linux-work.orig/include/asm-powerpc/pgtable-ppc32.h	2008-06-10  
> 18:13:47.000000000 +1000
> +++ linux-work/include/asm-powerpc/pgtable-ppc32.h	2008-06-10  
> 18:16:49.000000000 +1000
> @@ -182,6 +182,9 @@ extern int icache_44x_need_flush;
> #define _PMD_SIZE_16M	0x0e0
> #define PMD_PAGE_SIZE(pmdval)	(1024 << (((pmdval) & _PMD_SIZE) >> 4))
>
> +/* Until my rework is finished, 40x still needs atomic PTE updates */
> +#define PTE_ATOMIC_UPDATES	1
> +
> #elif defined(CONFIG_44x)
> /*
>  * Definitions for PPC440
> @@ -253,17 +256,17 @@ extern int icache_44x_need_flush;
>  */
>
> #define _PAGE_PRESENT	0x00000001		/* S: PTE valid */
> -#define	_PAGE_RW	0x00000002		/* S: Write permission */
> +#define _PAGE_RW	0x00000002		/* S: Write permission */
> #define _PAGE_FILE	0x00000004		/* S: nonlinear file mapping */
> +#define _PAGE_HWEXEC	0x00000004		/* H: Execute permission */

I'm sure this is ok, but why can we overlay _PAGE_HWEXEC and _PAGE_FILE?

> #define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
> -#define _PAGE_HWWRITE	0x00000010		/* H: Dirty & RW */
> -#define _PAGE_HWEXEC	0x00000020		/* H: Execute permission */
> -#define	_PAGE_USER	0x00000040		/* S: User page */
> -#define	_PAGE_ENDIAN	0x00000080		/* H: E bit */
> -#define	_PAGE_GUARDED	0x00000100		/* H: G bit */
> -#define	_PAGE_DIRTY	0x00000200		/* S: Page dirty */
> -#define	_PAGE_NO_CACHE	0x00000400		/* H: I bit */
> -#define	_PAGE_WRITETHRU	0x00000800		/* H: W bit */
> +#define _PAGE_DIRTY	0x00000010		/* S: Page dirty */

why the gap?
>
> +#define _PAGE_USER	0x00000040		/* S: User page */
> +#define _PAGE_ENDIAN	0x00000080		/* H: E bit */
> +#define _PAGE_GUARDED	0x00000100		/* H: G bit */
> +#define _PAGE_COHERENT	0x00000200		/* H: M bit */
> +#define _PAGE_NO_CACHE	0x00000400		/* H: I bit */
> +#define _PAGE_WRITETHRU	0x00000800		/* H: W bit */
>
> /* TODO: Add large page lowmem mapping support */
> #define _PMD_PRESENT	0
> @@ -273,6 +276,7 @@ extern int icache_44x_need_flush;
> /* ERPN in a PTE never gets cleared, ignore it */
> #define _PTE_NONE_MASK	0xffffffff00000000ULL
>
> +
> #elif defined(CONFIG_FSL_BOOKE)
> /*
>    MMU Assist Register 3:
> @@ -315,6 +319,9 @@ extern int icache_44x_need_flush;
> #define _PMD_PRESENT_MASK (PAGE_MASK)
> #define _PMD_BAD	(~PAGE_MASK)
>
> +/* Until my rework is finished, 40x still needs atomic PTE updates */
> +#define PTE_ATOMIC_UPDATES	1

fix comment
>
> +
> #elif defined(CONFIG_8xx)
> /* Definitions for 8xx embedded chips. */
> #define _PAGE_PRESENT	0x0001	/* Page is valid */
> @@ -345,6 +352,9 @@ extern int icache_44x_need_flush;
>
> #define _PTE_NONE_MASK _PAGE_ACCESSED
>
> +/* Until my rework is finished, 40x still needs atomic PTE updates */
> +#define PTE_ATOMIC_UPDATES	1
> +
fix comment
>
> #else /* CONFIG_6xx */
> /* Definitions for 60x, 740/750, etc. */
> #define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
> @@ -365,6 +375,10 @@ extern int icache_44x_need_flush;
> #define _PMD_PRESENT	0
> #define _PMD_PRESENT_MASK (PAGE_MASK)
> #define _PMD_BAD	(~PAGE_MASK)
> +
> +/* Hash tbale based platforms need atomic updates of the linux PTE */

tbale?

>
> +#define PTE_ATOMIC_UPDATES	1
> +
> #endif
>
> /*
> @@ -557,9 +571,11 @@ extern void add_hash_page(unsigned conte
>  * low PTE word since we expect ALL flag bits to be there
>  */
> #ifndef CONFIG_PTE_64BIT
> -static inline unsigned long pte_update(pte_t *p, unsigned long clr,
> +static inline unsigned long pte_update(pte_t *p,
> +				       unsigned long clr,
> 				       unsigned long set)
> {
> +#ifdef PTE_ATOMIC_UPDATES
> 	unsigned long old, tmp;
>
> 	__asm__ __volatile__("\
> @@ -572,16 +588,26 @@ static inline unsigned long pte_update(p
> 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
> 	: "r" (p), "r" (clr), "r" (set), "m" (*p)
> 	: "cc" );
> +#else /* PTE_ATOMIC_UPDATES */
> +	unsigned long old = pte_val(*p);
> +	*p = __pte((old & ~clr) | set);
> +#endif /* !PTE_ATOMIC_UPDATES */
> +
> #ifdef CONFIG_44x
> 	if ((old & _PAGE_USER) && (old & _PAGE_HWEXEC))
> 		icache_44x_need_flush = 1;
> #endif
> 	return old;
> }
> -#else
> -static inline unsigned long long pte_update(pte_t *p, unsigned long  
> clr,
> -				       unsigned long set)
> +#else /* CONFIG_PTE_64BIT */
> +/* TODO: Change that to only modify the low word and move  
> set_pte_at()
> + * out of line
> + */
> +static inline unsigned long long pte_update(pte_t *p,
> +					    unsigned long clr,
> +					    unsigned long set)
> {
> +#ifdef PTE_ATOMIC_UPDATES
> 	unsigned long long old;
> 	unsigned long tmp;
>
> @@ -596,13 +622,18 @@ static inline unsigned long long pte_upd
> 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
> 	: "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set),  
> "m" (*p)
> 	: "cc" );
> +#else /* PTE_ATOMIC_UPDATES */
> +	unsigned long long old = pte_val(*p);
> +	*p = __pte((old & ~clr) | set);
> +#endif /* !PTE_ATOMIC_UPDATES */
> +
> #ifdef CONFIG_44x
> 	if ((old & _PAGE_USER) && (old & _PAGE_HWEXEC))
> 		icache_44x_need_flush = 1;
> #endif
> 	return old;
> }
> -#endif
> +#endif /* CONFIG_PTE_64BIT */
>
> /*
>  * set_pte stores a linux PTE into the linux page table.
> @@ -665,7 +696,7 @@ static inline void __ptep_set_access_fla
> ({									   \
> 	int __changed = !pte_same(*(__ptep), __entry);			   \
> 	if (__changed) {						   \
> -		__ptep_set_access_flags(__ptep, __entry, __dirty);    	   \
> +		__ptep_set_access_flags(__ptep, __entry, __dirty);         \
> 		flush_tlb_page_nohash(__vma, __address);		   \
> 	}								   \
> 	__changed;							   \
