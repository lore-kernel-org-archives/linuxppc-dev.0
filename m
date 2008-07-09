Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 092B1DDF83
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 06:06:38 +1000 (EST)
Subject: Re: [PATCH 0/3] ALSA fixes for non-coherent ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hlk0byneg.wl%tiwai@suse.de>
References: <s5h1w2vc9js.wl%tiwai@suse.de> <20080709083111.44860@gmx.net>
	<1215593735.8970.361.camel@pasglop>  <s5hlk0byneg.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Thu, 10 Jul 2008 06:06:28 +1000
Message-Id: <1215633988.8970.376.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The changes in ppc are only the patch below.  The others are in
> sound/*.  I wrote it as an inline function simply it's so short and I
> didn't want extra exports.

Thanks. I -may- do something nicer, we'll see, but in any case, I'll
try to have something in .27

Cheers,
Ben.

> 
> thanks,
> 
> Takashi
> 
> ---
> commit 2c8662fde57af4cf928d17e089dc3dd2096f4b30
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Tue Jun 17 16:39:04 2008 +0200
> 
>     ppc: Add dma_mmap_coherent() for PPC32
>     
>     A very lazy version of dma_mmap_coherent() implementation for ppc32.
>     
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
> index bbefb69..a6a9675 100644
> --- a/include/asm-powerpc/dma-mapping.h
> +++ b/include/asm-powerpc/dma-mapping.h
> @@ -306,6 +306,24 @@ static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>  	/* We don't do anything here. */
>  }
>  
> +/*
> + * A helper to mmap the pages allocated via dma_alloc_coherent()
> + */
> +static inline int dma_mmap_coherent(struct device *dev,
> +				    struct vm_area_struct *vma,
> +				    void *cpu_addr, dma_addr_t handle,
> +				    size_t size)
> +{
> +	struct page *pg;
> +#ifdef CONFIG_NOT_COHERENT_CACHE
> +	/* I'm too lazy and can't stop using bus_to_virt() here... */
> +	cpu_addr = bus_to_virt(handle);
> +#endif
> +	pg = virt_to_page(cpu_addr);
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       page_to_pfn(pg) + vma->vm_pgoff,
> +			       size, vma->vm_page_prot);
> +}
>  #endif /* CONFIG_PPC64 */
>  
>  static inline void dma_sync_single_for_cpu(struct device *dev,
