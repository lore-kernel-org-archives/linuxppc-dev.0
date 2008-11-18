Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6816DDDD4
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 23:24:43 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add sync_*_for_* to dma_ops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <1226953165-19305-1-git-send-email-becky.bruce@freescale.com>
References: <1226953165-19305-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain
Date: Tue, 18 Nov 2008 23:22:29 +1100
Message-Id: <1227010949.7178.308.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  				dma_addr_t dma_address, size_t size,
>  				enum dma_data_direction direction,
>  				struct dma_attrs *attrs);
> +	void            (*sync_single_for_cpu)(struct device *hwdev,
> +				dma_addr_t dma_handle, size_t size,
> +				enum dma_data_direction direction);
> +	void            (*sync_single_for_device)(struct device *hwdev,
> +				dma_addr_t dma_handle, size_t size,
> +				enum dma_data_direction direction);
> +	void            (*sync_single_range_for_cpu)(struct device *hwdev,
> +				dma_addr_t dma_handle, unsigned long offset,
> +				size_t size,
> +				enum dma_data_direction direction);
> +	void            (*sync_single_range_for_device)(struct device *hwdev,
> +				dma_addr_t dma_handle, unsigned long offset,
> +				size_t size,
> +				enum dma_data_direction direction);

Can't we implement the first 2 using the next 2 and passing a 0 offset ?
I mean, we're going to go through a function pointer, it's not like
handling the offset was going to cost us something :-)

> +	void            (*sync_sg_for_cpu)(struct device *hwdev,
> +				struct scatterlist *sg, int nelems,
> +				enum dma_data_direction direction);
> +	void            (*sync_sg_for_device)(struct device *hwdev,
> +				struct scatterlist *sg, int nelems,
> +				enum dma_data_direction direction);
>  };
>  
>  /*
> @@ -286,42 +306,75 @@ static inline void dma_sync_single_for_cpu(struct device *dev,
>  		dma_addr_t dma_handle, size_t size,
>  		enum dma_data_direction direction)
>  {
> -	BUG_ON(direction == DMA_NONE);
> -	__dma_sync(bus_to_virt(dma_handle), size, direction);
> +	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
> +
> +	BUG_ON(!dma_ops);
> +	if (dma_ops->sync_single_for_cpu != NULL)
> +		dma_ops->sync_single_for_cpu(dev, dma_handle, size,
> +					     direction);
>  }

 .../...

The only objection that comes to mind here is that generally, you know
that your platform is going to be coherent or not at compile time, and
you don't want the above at all when it is (or won't need swiotlb).

So maybe we could have a Kconfig trickery so that
CONFIG_PPC_DMA_NEED_SYNC_OPS is set when either non coherent DMA is
select'ed or swiotlb support is select'ed by one of the enabled
platform. So if I enable only powermac, I get neither and don't get the
bloody inlines :-)

Cheers,
Ben.
