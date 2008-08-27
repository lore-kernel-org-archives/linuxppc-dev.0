Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3AF5DDEE3
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 09:50:27 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m7RNhrPB026729
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 16:43:53 -0700 (MST)
Message-ID: <48B5E6B7.3000903@freescale.com>
Date: Wed, 27 Aug 2008 18:43:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support 36-bit
	physical
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
In-Reply-To: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce wrote:
>  #if _PAGE_HASHPTE != 0
> +#ifndef CONFIG_PTE_64BIT
>  	pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte) & ~_PAGE_HASHPTE);
>  #else
> +	/*
> +	 * We have to do the write of the 64b pte as 2 stores.  This
> +	 * code assumes that the entry we're storing to is currently
> +	 * not valid and that all callers have the page table lock.
> +	 * Having the entry be not valid protects readers who might read
> +	 * between the first and second stores.
> +	 */
> +	unsigned int tmp;
> +
> +	__asm__ __volatile__("\
> +1:	lwarx	%0,0,%4\n\
> +	rlwimi	%L2,%0,0,30,30\n\
> +	stw	%2,0(%3)\n\
> +	eieio\n\
> +	stwcx.  %L2,0,%4\n\
> +	bne-	1b"
> +	: "=&r" (tmp), "=m" (*ptep)
> +	: "r" (pte), "r" (ptep), "r" ((unsigned long)(ptep) + 4), "m" (*ptep)
> +	: "cc");
> +#endif	/* CONFIG_PTE_64BIT */

Could the stw to the same reservation granule as the stwcx cancel the 
reservation on some implementations?  Plus, if you're assuming that the 
entry is currently invalid and all callers have the page table lock, do 
we need the lwarx/stwcx at all?  At the least, it should check 
PTE_ATOMIC_UPDATES.

%2 should be "+&r", not "r".

> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 7f65127..ca5b58b 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -128,18 +128,22 @@ config FSL_EMB_PERFMON
>  
>  config PTE_64BIT
>  	bool
> -	depends on 44x || E500
> +	depends on 44x || E500 || 6xx
>  	default y if 44x
> -	default y if E500 && PHYS_64BIT
> +	default y if PHYS_64BIT

How is this different from PHYS_64BIT?

>  config PHYS_64BIT
> -	bool 'Large physical address support' if E500
> -	depends on 44x || E500
> +	bool 'Large physical address support' if E500 || 6xx

Maybe "if !44x", or have 44x "select" this, rather than listing all 
arches where it's optional.

> +	depends on 44x || E500 || 6xx
>  	select RESOURCES_64BIT
>  	default y if 44x
>  	---help---
>  	  This option enables kernel support for larger than 32-bit physical
> -	  addresses.  This features is not be available on all e500 cores.
> +	  addresses.  This features is not be available on all cores.

"This features is not be"?

-Scott
