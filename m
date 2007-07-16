Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1759DDD06
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 07:50:36 +1000 (EST)
Subject: Re: [PATCH] cell: CONFIG_SPE_BASE is a typo (was: Re: possible
	dead CONFIG-related content under arch/powerpc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0707161831090.1072@pademelon.sonytel.be>
References: <Pine.LNX.4.64.0707141816470.9751@localhost.localdomain>
	<Pine.LNX.4.62.0707161116280.1072@pademelon.sonytel.be>
	<1184591114.17330.1.camel@concordia.ozlabs.ibm.com>
	<Pine.LNX.4.62.0707161831090.1072@pademelon.sonytel.be>
Content-Type: text/plain; charset=utf-8
Date: Tue, 17 Jul 2007 07:50:27 +1000
Message-Id: <1184622627.25235.93.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-16 at 18:35 +0200, Geert Uytterhoeven wrote:
> The config symbol for SPE support is called CONFIG_SPU_BASE, not
> CONFIG_SPE_BASE.

Oops... Arnd, we need to check the distro kernels here.

> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 4f2f453..0b25d42 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -609,7 +609,7 @@ static void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
>  	mm->context.sllp = SLB_VSID_USER | mmu_psize_defs[MMU_PAGE_4K].sllp;
>  #endif /* CONFIG_PPC_MM_SLICES */
>  
> -#ifdef CONFIG_SPE_BASE
> +#ifdef CONFIG_SPU_BASE
>  	spu_flush_all_slbs(mm);
>  #endif
>  }
> @@ -744,7 +744,7 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>  			       "to 4kB pages because of "
>  			       "non-cacheable mapping\n");
>  			psize = mmu_vmalloc_psize = MMU_PAGE_4K;
> -#ifdef CONFIG_SPE_BASE
> +#ifdef CONFIG_SPU_BASE
>  			spu_flush_all_slbs(mm);
>  #endif
>  		}
> 
> With kind regards,
>  
> Geert Uytterhoeven
> Software Architect
> 
> Sony Network and Software Technology Center Europe
> The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
>  
> Phone:    +32 (0)2 700 8453	
> Fax:      +32 (0)2 700 8622	
> E-mail:   Geert.Uytterhoeven@sonycom.com	
> Internet: http://www.sony-europe.com/
>  	
> Sony Network and Software Technology Center Europe	
> A division of Sony Service Centre (Europe) N.V.	
> Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
> VAT BE 0413.825.160 · RPR Brussels	
> Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
> _______________________________________________ Linuxppc-dev mailing list Linuxppc-dev@ozlabs.org https://ozlabs.org/mailman/listinfo/linuxppc-dev
