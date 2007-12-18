Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B10ABDDE38
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 06:50:16 +1100 (EST)
Subject: Re: [POWERPC 06/18] Use archdata.dma_data in dma_direct_ops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: arnd@arndb.de
In-Reply-To: <20071218175104.638243000@arndb.de>
References: <20071218174852.112644000@arndb.de>
	<20071218175104.638243000@arndb.de>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 06:49:59 +1100
Message-Id: <1198007399.18908.4.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-12-18 at 18:48 +0100, arnd@arndb.de wrote:
> plain text document attachment
> (0016-Use-archdata.dma_data-in-dma_direct_ops.patch)
> Now that all platforms using dma_direct_offset setup the archdata.dma_data
> correctly, we can change the dma_direct_ops to retrieve the offset from
> the dma_data, rather than directly from the global.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Ack.

>  arch/powerpc/kernel/dma_64.c |   18 +++++++++++++++---
>  1 files changed, 15 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6-new/arch/powerpc/kernel/dma_64.c
> ===================================================================
> --- linux-2.6-new.orig/arch/powerpc/kernel/dma_64.c
> +++ linux-2.6-new/arch/powerpc/kernel/dma_64.c
> @@ -117,6 +117,18 @@ EXPORT_SYMBOL(dma_iommu_ops);
>   */
>  unsigned long dma_direct_offset;
>  
> +static unsigned long get_dma_direct_offset(struct device *dev)
> +{
> +	unsigned long *offset;
> +
> +	offset = dev->archdata.dma_data;
> +
> +	if (offset)
> +		return *offset;
> +
> +	return 0;
> +}
> +
>  static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
>  				       dma_addr_t *dma_handle, gfp_t flag)
>  {
> @@ -130,7 +142,7 @@ static void *dma_direct_alloc_coherent(s
>  		return NULL;
>  	ret = page_address(page);
>  	memset(ret, 0, size);
> -	*dma_handle = virt_to_abs(ret) | dma_direct_offset;
> +	*dma_handle = virt_to_abs(ret) | get_dma_direct_offset(dev);
>  
>  	return ret;
>  }
> @@ -145,7 +157,7 @@ static dma_addr_t dma_direct_map_single(
>  					size_t size,
>  					enum dma_data_direction direction)
>  {
> -	return virt_to_abs(ptr) | dma_direct_offset;
> +	return virt_to_abs(ptr) | get_dma_direct_offset(dev);
>  }
>  
>  static void dma_direct_unmap_single(struct device *dev, dma_addr_t dma_addr,
> @@ -161,7 +173,7 @@ static int dma_direct_map_sg(struct devi
>  	int i;
>  
>  	for_each_sg(sgl, sg, nents, i) {
> -		sg->dma_address = sg_phys(sg) | dma_direct_offset;
> +		sg->dma_address = sg_phys(sg) | get_dma_direct_offset(dev);
>  		sg->dma_length = sg->length;
>  	}
>  
> 
