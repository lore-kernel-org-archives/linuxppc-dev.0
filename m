Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 00843B70F8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 19:32:38 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29E7DDDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 19:32:36 +1000 (EST)
Subject: Re: Swiotlb breaks pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1245748428.4550.411.camel@concordia>
References: <1245748428.4550.411.camel@concordia>
Content-Type: text/plain
Date: Tue, 23 Jun 2009 19:32:23 +1000
Message-Id: <1245749543.4017.69.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-06-23 at 19:13 +1000, Michael Ellerman wrote:
> Hi all,
> 
> Turning on SWIOTLB selects or enables PPC_NEED_DMA_SYNC_OPS, which means
> we get the non empty versions of dma_sync_* in asm/dma-mapping.h
> 
> On my pseries machine the dma_ops have no such routines and we die with
> a null pointer - this patch gets it booting, is there a more elegant way
> to do it?

No that's the best way (checking for NULL in the inlines), avoids
calling through a function pointer when not needed, since this can
be a fairly hot path, especially with networking.

Cheers,
Ben.

> cheers
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index 3d9e887..b44aaab 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -309,7 +309,9 @@ static inline void dma_sync_single_for_cpu(struct device *dev,
>  	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
>  
>  	BUG_ON(!dma_ops);
> -	dma_ops->sync_single_range_for_cpu(dev, dma_handle, 0,
> +
> +	if (dma_ops->sync_single_range_for_cpu)
> +		dma_ops->sync_single_range_for_cpu(dev, dma_handle, 0,
>  					   size, direction);
>  }
>  
> @@ -320,7 +322,9 @@ static inline void dma_sync_single_for_device(struct device *dev,
>  	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
>  
>  	BUG_ON(!dma_ops);
> -	dma_ops->sync_single_range_for_device(dev, dma_handle,
> +
> +	if (dma_ops->sync_single_range_for_device)
> +		dma_ops->sync_single_range_for_device(dev, dma_handle,
>  					      0, size, direction);
>  }
>  
> @@ -331,7 +335,9 @@ static inline void dma_sync_sg_for_cpu(struct device *dev,
>  	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
>  
>  	BUG_ON(!dma_ops);
> -	dma_ops->sync_sg_for_cpu(dev, sgl, nents, direction);
> +
> +	if (dma_ops->sync_sg_for_cpu)
> +		dma_ops->sync_sg_for_cpu(dev, sgl, nents, direction);
>  }
>  
>  static inline void dma_sync_sg_for_device(struct device *dev,
> @@ -341,7 +347,9 @@ static inline void dma_sync_sg_for_device(struct device *dev,
>  	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
>  
>  	BUG_ON(!dma_ops);
> -	dma_ops->sync_sg_for_device(dev, sgl, nents, direction);
> +
> +	if (dma_ops->sync_sg_for_device)
> +		dma_ops->sync_sg_for_device(dev, sgl, nents, direction);
>  }
>  
>  static inline void dma_sync_single_range_for_cpu(struct device *dev,
> @@ -351,7 +359,9 @@ static inline void dma_sync_single_range_for_cpu(struct device *dev,
>  	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
>  
>  	BUG_ON(!dma_ops);
> -	dma_ops->sync_single_range_for_cpu(dev, dma_handle,
> +
> +	if (dma_ops->sync_single_range_for_cpu)
> +		dma_ops->sync_single_range_for_cpu(dev, dma_handle,
>  					   offset, size, direction);
>  }
>  
> @@ -362,7 +372,9 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
>  	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
>  
>  	BUG_ON(!dma_ops);
> -	dma_ops->sync_single_range_for_device(dev, dma_handle, offset,
> +
> +	if (dma_ops->sync_single_range_for_device)
> +		dma_ops->sync_single_range_for_device(dev, dma_handle, offset,
>  					      size, direction);
>  }
>  #else /* CONFIG_PPC_NEED_DMA_SYNC_OPS */
