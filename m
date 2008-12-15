Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF6BBDDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:54:59 +1100 (EST)
Message-Id: <8F38D1CB-D389-4065-A309-3126B6D482DB@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081215054611.3C3C1474E1@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 15/16] powerpc/mm: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED
Date: Mon, 15 Dec 2008 14:54:52 -0600
References: <20081215054611.3C3C1474E1@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> --- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc32.h	 
> 2008-11-24 14:48:55.000000000 +1100
> +++ linux-work/arch/powerpc/include/asm/pgtable-ppc32.h	2008-12-15  
> 15:34:16.000000000 +1100

[snip]

>
> @@ -436,20 +437,23 @@ extern int icache_44x_need_flush;
> 			 _PAGE_USER | _PAGE_ACCESSED | \
> 			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | \
> 			 _PAGE_EXEC | _PAGE_HWEXEC)
> +
> /*
> - * Note: the _PAGE_COHERENT bit automatically gets set in the  
> hardware
> - * PTE if CONFIG_SMP is defined (hash_page does this); there is no  
> need
> - * to have it in the Linux PTE, and in fact the bit could be reused  
> for
> - * another purpose.  -- paulus.
> + * We define 2 sets of base prot bits, one for basic pages (ie,
> + * cacheable kernel and user pages) and one for non cacheable
> + * pages. We always set _PAGE_COHERENT when SMP is enabled or
> + * the processor might need it for DMA coherency.
>  */
> -
> -#ifdef CONFIG_44x
> -#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_GUARDED)
> +#if defined(CONFIG_SMP) || defined(CONFIG_PPC_STD_MMU)
> +#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
> #else
> #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED)
> #endif
> +#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
> +
> #define _PAGE_WRENABLE	(_PAGE_RW | _PAGE_DIRTY | _PAGE_HWWRITE)
> #define _PAGE_KERNEL	(_PAGE_BASE | _PAGE_SHARED | _PAGE_WRENABLE)
> +#define _PAGE_KERNEL_NC	(_PAGE_BASE_NC | _PAGE_SHARED |  
> _PAGE_WRENABLE | _PAGE_NO_CACHE)

Either _BASE_NC should have _PAGE_NO_CACHE set or you need a different  
name here for _PAGE_KERNEL_NC

> #ifdef CONFIG_PPC_STD_MMU
> /* On standard PPC MMU, no user access implies kernel read/write  
> access,
> @@ -459,7 +463,7 @@ extern int icache_44x_need_flush;
> #define _PAGE_KERNEL_RO	(_PAGE_BASE | _PAGE_SHARED)
> #endif
>
> -#define _PAGE_IO	(_PAGE_KERNEL | _PAGE_NO_CACHE | _PAGE_GUARDED)
> +#define _PAGE_IO	(_PAGE_KERNEL_NC | _PAGE_GUARDED)
> #define _PAGE_RAM	(_PAGE_KERNEL | _PAGE_HWEXEC)

I think we should do:

#define _PAGE_KERNEL_NC	(_PAGE_BASE_NC | _PAGE_SHARED | _PAGE_WRENABLE)
#define _PAGE_IO	(_PAGE_KERNEL_NC | _PAGE_NO_CACHE | _PAGE_GUARDED)

> Index: linux-work/arch/powerpc/include/asm/pgtable.h
> ===================================================================
> --- linux-work.orig/arch/powerpc/include/asm/pgtable.h	2008-09-29  
> 14:21:37.000000000 +1000
> +++ linux-work/arch/powerpc/include/asm/pgtable.h	2008-12-15  
> 14:38:00.000000000 +1100
> @@ -16,6 +16,32 @@ struct mm_struct;
> #endif
>
> #ifndef __ASSEMBLY__
> +
> +/*
> + * Macro to mark a page protection value as "uncacheable".
> + */
> +
> +#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_COHERENT |  
> _PAGE_COHERENT | \
> + 			 _PAGE_WRITETHRU)

we like coherent so much we set it thrice?

- k
