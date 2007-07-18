Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E5E33DDE1F
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:47:03 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6N0mDvs2744568
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:48:13 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6N0kSCZ065508
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:46:28 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6N0l2lv006294
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:47:02 +1000
Date: Wed, 18 Jul 2007 13:38:35 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 05/14] 40x MMU
Message-ID: <20070718033835.GI18251@localhost.localdomain>
References: <20070717181547.310201000@linux.vnet.ibm.com>>
	<20070717182621.437685000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070717182621.437685000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2007 at 01:15:52PM -0500, Josh Boyer wrote:
> Add MMU definitions for 40x platforms.  Also fixes two warnings in 40x_mmu.c.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> ---
>  arch/powerpc/mm/40x_mmu.c     |    4 +-
>  include/asm-powerpc/mmu-40x.h |   65 ++++++++++++++++++++++++++++++++++++++++++
>  include/asm-powerpc/mmu.h     |    3 +
>  3 files changed, 70 insertions(+), 2 deletions(-)
> 
> --- /dev/null
> +++ linux-2.6/include/asm-powerpc/mmu-40x.h
> @@ -0,0 +1,65 @@
> +#ifndef _ASM_POWERPC_MMU_40X_H_
> +#define _ASM_POWERPC_MMU_40X_H_
> +
> +/*
> + * PPC40x support
> + */
> +
> +#define PPC4XX_TLB_SIZE 64

This should probably be 40X, like other things.

> +
> +/*
> + * TLB entries are defined by a "high" tag portion and a "low" data
> + * portion.  On all architectures, the data portion is 32-bits.
> + *
> + * TLB entries are managed entirely under software control by reading,
> + * writing, and searchoing using the 4xx-specific tlbre, tlbwr, and tlbsx
> + * instructions.
> + */
> +
> +#define	TLB_LO          1
> +#define	TLB_HI          0
> +
> +#define	TLB_DATA        TLB_LO
> +#define	TLB_TAG         TLB_HI
> +
> +/* Tag portion */
> +
> +#define TLB_EPN_MASK    0xFFFFFC00      /* Effective Page Number */
> +#define TLB_PAGESZ_MASK 0x00000380
> +#define TLB_PAGESZ(x)   (((x) & 0x7) << 7)
> +#define   PAGESZ_1K		0
> +#define   PAGESZ_4K             1
> +#define   PAGESZ_16K            2
> +#define   PAGESZ_64K            3
> +#define   PAGESZ_256K           4
> +#define   PAGESZ_1M             5
> +#define   PAGESZ_4M             6
> +#define   PAGESZ_16M            7
> +#define TLB_VALID       0x00000040      /* Entry is valid */
> +
> +/* Data portion */
> +
> +#define TLB_RPN_MASK    0xFFFFFC00      /* Real Page Number */
> +#define TLB_PERM_MASK   0x00000300
> +#define TLB_EX          0x00000200      /* Instruction execution allowed */
> +#define TLB_WR          0x00000100      /* Writes permitted */
> +#define TLB_ZSEL_MASK   0x000000F0
> +#define TLB_ZSEL(x)     (((x) & 0xF) << 4)
> +#define TLB_ATTR_MASK   0x0000000F
> +#define TLB_W           0x00000008      /* Caching is write-through */
> +#define TLB_I           0x00000004      /* Caching is inhibited */
> +#define TLB_M           0x00000002      /* Memory is coherent */
> +#define TLB_G           0x00000001      /* Memory is guarded from prefetch */
> +
> +#ifndef __ASSEMBLY__
> +
> +typedef unsigned long phys_addr_t;
> +
> +typedef struct {
> +	unsigned long id;
> +	unsigned long vdso_base;
> +} mm_context_t;
> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* _ASM_POWERPC_MMU_40X_H_ */
> --- linux-2.6.orig/include/asm-powerpc/mmu.h
> +++ linux-2.6/include/asm-powerpc/mmu.h
> @@ -8,6 +8,9 @@
>  #elif defined(CONFIG_PPC_STD_MMU)
>  /* 32-bit classic hash table MMU */
>  #  include <asm/mmu-hash32.h>
> +#elif defined(CONFIG_40x)
> +/* 40x-style software loaded TLB */
> +#  include <asm/mmu-40x.h>
>  #elif defined(CONFIG_44x)
>  /* 44x-style software loaded TLB */
>  #  include <asm/mmu-44x.h>
> --- linux-2.6.orig/arch/powerpc/mm/40x_mmu.c
> +++ linux-2.6/arch/powerpc/mm/40x_mmu.c
> @@ -108,7 +108,7 @@ unsigned long __init mmu_mapin_ram(void)
>  		pmd_t *pmdp;
>  		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
>  
> -		pmdp = pmd_offset(pgd_offset_k(v), v);
> +		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
>  		pmd_val(*pmdp++) = val;
>  		pmd_val(*pmdp++) = val;
>  		pmd_val(*pmdp++) = val;
> @@ -123,7 +123,7 @@ unsigned long __init mmu_mapin_ram(void)
>  		pmd_t *pmdp;
>  		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC | _PAGE_HWWRITE;
>  
> -		pmdp = pmd_offset(pgd_offset_k(v), v);
> +		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
>  		pmd_val(*pmdp) = val;
>  
>  		v += LARGE_PAGE_SIZE_4M;
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
