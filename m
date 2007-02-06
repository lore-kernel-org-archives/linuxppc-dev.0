Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D95A6DDEBA
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 12:12:15 +1100 (EST)
Date: Mon, 5 Feb 2007 19:19:49 -0600
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 08/10] powerpc: dart iommu suspend
Message-ID: <20070206011949.GA15434@lixom.net>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185838.029827000@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070205185838.029827000@sipsolutions.net>
From: olof@lixom.net (Olof Johansson)
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

On Mon, Feb 05, 2007 at 07:30:35PM +0100, Johannes Berg wrote:
> This implements suspend and resume code for the dart iommu.

It's a good start, but it would be even nicer to have more generic iommu
suspend/resume hooks instead, and do the alloc/copy there. Add the hooks
to ppc_md together with the rest of the iommu/tce ops.

Minor code comment below.

> --- mb-wireless.orig/arch/powerpc/sysdev/dart_iommu.c	2007-02-05 14:24:04.834526864 +0100
> +++ mb-wireless/arch/powerpc/sysdev/dart_iommu.c	2007-02-05 14:24:40.684526864 +0100
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

Please do a local void * instead, makes for much less casting in the loop. :)

> +
> +	/* if no dart table exists then we don't need to save it */
> +	if (!dart_tablebase)
> +		return 0;
> +
> +	/* For suspend we need to copy the dart contents because
> +	 * it is not part of the regular mapping (see above) and
> +	 * thus not saved automatically. The memory for this copy
> +	 * must be allocated early because we need 2 MB. */
> +	p = alloc_pages(GFP_KERNEL, 21 - PAGE_SHIFT);
> +	BUG_ON(!p);
> +	dart_copy = page_address(p);
> +
> +	return 0;
> +}
> +
> +late_initcall(iommu_init_late_dart);
> +
> +void iommu_dart_save(void)
> +{
> +	if (!dart_tablebase)
> +		return;
> +
> +	memcpy(dart_copy, dart_vbase, 2*1024*1024);
> +}
> +
> +void iommu_dart_restore(void)
> +{
> +	if (!dart_tablebase)
> +		return;
> +
> +	memcpy(dart_vbase, dart_copy, 2*1024*1024);
> +	dart_tlb_invalidate_all();
> +}
> +#endif
>  
>  void __init alloc_dart_table(void)
>  {
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
>  
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_IOMMU_H */
> 
> --
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
