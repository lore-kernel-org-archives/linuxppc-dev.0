Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0107.outbound.protection.outlook.com [207.46.100.107])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 451B21A02D7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 18:40:43 +1100 (EST)
Message-ID: <1413272346.2878.2.camel@aoeu.buserror.net>
Subject: Re: [PATCH 1/4] powerpc: Dynamic DMA zone limits
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 14 Oct 2014 09:39:06 +0200
In-Reply-To: <1413190849.21457.4.camel@concordia>
References: <1407541245-27617-1-git-send-email-scottwood@freescale.com>
 <20141013181436.300988c8@kryten> <1413190849.21457.4.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-10-13 at 20:00 +1100, Michael Ellerman wrote:
> On Mon, 2014-10-13 at 18:14 +1100, Anton Blanchard wrote:
> > Hi Scott,
> > 
> > > Platform code can call limit_zone_pfn() to set appropriate limits
> > > for ZONE_DMA and ZONE_DMA32, and dma_direct_alloc_coherent() will
> > > select a suitable zone based on a device's mask and the pfn limits
> > > that platform code has configured.
> > 
> > This patch breaks my POWER8 box:
> > 
> > ipr 0001:08:00.0: Using 64-bit DMA iommu bypass
> > ipr 0001:08:00.0: dma_direct_alloc_coherent: No suitable zone for pfn 0x10000
> > ipr 0001:08:00.0: Couldn't allocate enough memory for device driver! 
> > ipr: probe of 0001:08:00.0 failed with error -12
> > 
> > ipr isn't setting a coherent mask, but we shouldn't care on these boxes.
> > Could we ignore the coherent mask or copy the dma mask to it?
> 
> Talking to Ben the answer seems to be "it's complicated".
> 
> We shouldn't be ignoring the coherent mask, but we have been, and have been
> getting away with it.
> 
> The PCI code sets a default 32-bit mask, so we can't even detect when a device
> hasn't set it. Though maybe the powernv PCI code could be initialising it to
> 64-bit ?
> 
> For this cycle I'm thinking of the below patch.
> 
> Scott & Anton can you test please?
> 
> Also the depends on FSL_PCI was totally a guess, so please correct that if it's
> wrong Scott.

We need the DMA zone for non-PCI devices, so FSL_SOC would be a better
choice.

> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index adac9dc54aee..bd443a2e4426 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -53,6 +53,7 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
>  #else
>  	struct page *page;
>  	int node = dev_to_node(dev);
> +#ifdef CONFIG_ZONE_DMA32
>  	u64 pfn = get_pfn_limit(dev);
>  	int zone;
>  
> @@ -67,12 +68,11 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
>  	case ZONE_DMA:
>  		flag |= GFP_DMA;
>  		break;
> -#ifdef CONFIG_ZONE_DMA32
>  	case ZONE_DMA32:
>  		flag |= GFP_DMA32;
>  		break;
> -#endif
>  	};
> +#endif /* CONFIG_ZONE_DMA32 */

For a short-term workaround, I'd rather leave CONFIG_ZONE_DMA32 where it
is and put #ifdef CONFIG_FSL_SOC (with a comment) around the whole
thing.

-Scott
