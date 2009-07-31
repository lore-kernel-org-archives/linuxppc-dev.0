Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A1925B7B76
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Aug 2009 08:25:24 +1000 (EST)
Subject: Re: [PATCH] Stop pci_set_dma_mask() from failing when RAM doesn't
	exceed the mask anyway
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1249069310.20192.220.camel@macbook.infradead.org>
References: <1249069310.20192.220.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Sat, 01 Aug 2009 08:25:05 +1000
Message-Id: <1249079105.1509.95.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-07-31 at 20:41 +0100, David Woodhouse wrote:
> On an iMac G5, the b43 driver is failing to initialise because trying to
> set the dma mask to 30-bit fails. Even though there's only 512MiB of RAM
> in the machine anyway:
> 	https://bugzilla.redhat.com/show_bug.cgi?id=514787
> 
> We should probably let it succeed if the available RAM in the system
> doesn't exceed the requested limit.
> 
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

Also, isn't our iommu code smart enough to clamp allocations to the DMA
mask nowadays ? In that case, we could probably just force iommu on
always...

Cheers,
Ben.

> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 20a60d6..1769a8e 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -90,11 +90,11 @@ static void dma_direct_unmap_sg(struct device *dev,
> struct scatterlist *sg,
>  static int dma_direct_dma_supported(struct device *dev, u64 mask)
>  {
>  #ifdef CONFIG_PPC64
> -	/* Could be improved to check for memory though it better be
> -	 * done via some global so platforms can set the limit in case
> +	extern unsigned long highest_memmap_pfn;
> +	/* Could be improved so platforms can set the limit in case
>  	 * they have limited DMA windows
>  	 */
> -	return mask >= DMA_BIT_MASK(32);
> +	return (mask >> PAGE_SHIFT) >= highest_memmap_pfn;
>  #else
>  	return 1;
>  #endif
> 
