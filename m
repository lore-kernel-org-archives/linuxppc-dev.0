Return-Path: <pavel@ucw.cz>
Received: from amd.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id AFA7FDDE32
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 00:10:34 +1100 (EST)
Date: Tue, 6 Feb 2007 13:40:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [RFC 08/10] powerpc: dart iommu suspend
Message-ID: <20070206124047.GC8662@elf.ucw.cz>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185838.029827000@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070205185838.029827000@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org,
	Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> This implements suspend and resume code for the dart iommu.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> @@ -54,6 +54,9 @@ static unsigned long dart_tablesize;
>  
>  /* Virtual base address of the DART table */
>  static u32 *dart_vbase;
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +static u32 *dart_copy;
> +#endif
>  
>  /* Mapped base address for the dart */
>  static unsigned int __iomem *dart;
> @@ -346,6 +349,52 @@ void iommu_init_early_dart(void)
>  	pci_dma_ops = &dma_direct_ops;
>  }
>  
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +static int iommu_init_late_dart(void)
> +{
> +	unsigned long i;
> +	struct page *p;
> +
> +	/* this 16MB area is left unmapped because of caching
> +	 * considerations. that happens early so we can't mark
> +	 * it there, do it now instead */
> +	for (i = 0; i < (1<<24); i+= PAGE_SIZE)
> +		SetPageNosave(virt_to_page((void*)((unsigned long)dart_tablebase + i)));
> +

80 columns rule?

> --- mb-wireless.orig/include/asm-powerpc/iommu.h	2007-02-05 14:24:05.014526864 +0100
> +++ mb-wireless/include/asm-powerpc/iommu.h	2007-02-05 14:24:40.684526864 +0100
> @@ -108,6 +108,10 @@ static inline void pci_iommu_init(void) 
>  #endif
>  
>  extern void alloc_dart_table(void);
> +#if defined(CONFIG_SOFTWARE_SUSPEND) && defined(CONFIG_U3_DART)
> +extern void iommu_dart_save(void);
> +extern void iommu_dart_restore(void);
> +#endif

You can go without the ifdef; extra prototype does not do any harm.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
