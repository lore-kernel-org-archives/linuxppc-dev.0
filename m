Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2F371A0006
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 08:08:03 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0105.outbound.protection.outlook.com [207.46.100.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 29B3914009B
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 08:08:02 +1100 (AEDT)
Message-ID: <1424810077.4698.30.camel@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/dma: Support 32-bit coherent mask with
 64-bit dma_mask
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Feb 2015 14:34:37 -0600
In-Reply-To: <1424421330.27448.42.camel@kernel.crashing.org>
References: <1424421330.27448.42.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>, Brian J
 King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-20 at 19:35 +1100, Benjamin Herrenschmidt wrote:
> @@ -149,14 +141,13 @@ static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
>  
>  static int dma_direct_dma_supported(struct device *dev, u64 mask)
>  {
> -#ifdef CONFIG_PPC64
> -	/* Could be improved so platforms can set the limit in case
> -	 * they have limited DMA windows
> -	 */
> -	return mask >= get_dma_offset(dev) + (memblock_end_of_DRAM() - 1);
> -#else
> -	return 1;
> +	u64 offset = get_dma_offset(dev);
> +	u64 limit = offset + memblock_end_of_DRAM() - 1;
> +
> +#if defined(CONFIG_ZONE_DMA32)
> +	limit = offset + dma_get_zone_limit(ZONE_DMA32);
>  #endif
> +	return mask >= limit;
>  }

I'm confused as to whether dma_supported() is supposed to be testing a
coherent mask or regular mask...  The above suggests coherent, as does
the call to dma_supported() in dma_set_coherent_mask(), but if swiotlb
is used, swiotlb_dma_supported() will only check for a mask that can
accommodate io_tlb_end, without regard for coherent allocations.

>  static u64 dma_direct_get_required_mask(struct device *dev)
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index f146ef0..a7f15e2 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -277,6 +277,11 @@ int dma_pfn_limit_to_zone(u64 pfn_limit)
>  	return -EPERM;
>  }
>  
> +u64 dma_get_zone_limit(int zone)
> +{
> +	return max_zone_pfns[zone] << PAGE_SHIFT;
> +}

If you must do this in terms of bytes rather than pfn, cast to u64
before shifting -- and even then the result will be PAGE_SIZE - 1 too
small.

-Scott
