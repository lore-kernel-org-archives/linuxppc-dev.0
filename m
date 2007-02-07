Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDB2EDDE32
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 11:43:08 +1100 (EST)
Subject: Re: [PATCH 3/4] PS3: Fix DMA scatter-gather
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45BFD2C2.70000@am.sony.com>
References: <45BFD2C2.70000@am.sony.com>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 11:42:56 +1100
Message-Id: <1170808976.2620.268.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-30 at 15:20 -0800, Geoff Levand wrote:
> Add the missing pieces to support DMA scatter-gather on the PS3 system bus.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I'll help with the dynamic DMA stuff as soon as I find a minute free..

Ben.

> 
> ---
> 
> USB mass storage works properly now.
> 
>  arch/powerpc/platforms/ps3/system-bus.c |   23 +++++++++++++++++++++--
>  1 files changed, 21 insertions(+), 2 deletions(-)
> 
> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/system-bus.c
> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/system-bus.c
> @@ -272,10 +272,29 @@ static void ps3_unmap_single(struct devi
>  static int ps3_map_sg(struct device *_dev, struct scatterlist *sg, int nents,
>  	enum dma_data_direction direction)
>  {
> +	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
> +	int i;
> +
>  #if defined(CONFIG_PS3_DYNAMIC_DMA)
>  	BUG_ON("do");
> +	return -EPERM;
> +#else
> +	for (i = 0; i < nents; i++, sg++) {
> +		int result = ps3_dma_map(dev->d_region,
> +			page_to_phys(sg->page) + sg->offset, sg->length,
> +			&sg->dma_address);
> +
> +		if (result) {
> +			pr_debug("%s:%d: ps3_dma_map failed (%d)\n",
> +				__func__, __LINE__, result);
> +			return -EINVAL;
> +		}
> +
> +		sg->dma_length = sg->length;
> +	}
> +
> +	return nents;
>  #endif
> -	return 0;
>  }
>  
>  static void ps3_unmap_sg(struct device *_dev, struct scatterlist *sg,
> @@ -288,7 +307,7 @@ static void ps3_unmap_sg(struct device *
>  
>  static int ps3_dma_supported(struct device *_dev, u64 mask)
>  {
> -	return 1;
> +	return mask >= DMA_32BIT_MASK;
>  }
>  
>  static struct dma_mapping_ops ps3_dma_ops = {
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
