Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EEDDFDDE17
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 08:03:58 +1000 (EST)
Date: Tue, 9 Sep 2008 00:03:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH 4/4] POWERPC: Merge 32 and 64-bit dma code
Message-ID: <20080908220349.GD1175@lst.de>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-4-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -	if (unlikely(dev == NULL || dev->archdata.dma_ops == NULL))
> +
> +	if (unlikely(dev == NULL) || dev->archdata.dma_ops == NULL) {
> +#ifdef CONFIG_PPC64
>  		return NULL;
> +#else
> +		/* Use default on 32-bit if dma_ops is not set up */
> +		return &dma_direct_ops;
> +#endif
> +	}
> +

This is okay for the transition, but I think long-term it should
be setup for all busses.

>  }
>  
> @@ -132,7 +154,14 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev,
>  	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
>  
>  	BUG_ON(!dma_ops);
> -	return dma_ops->map_single(dev, cpu_addr, size, direction, attrs);
> +
> +	if (dma_ops->map_single)
> +		return dma_ops->map_single(dev, cpu_addr, size, direction,
> +					   attrs);
> +
> +	return dma_ops->map_page(dev, virt_to_page(cpu_addr),
> +				 (unsigned long)cpu_addr % PAGE_SIZE, size,
> +				 direction, attrs);

Why would a dma ops implementation not provide map_single/unmap_single?
