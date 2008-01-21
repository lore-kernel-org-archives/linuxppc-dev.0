Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/7] Use archdata.dma_data in dma_direct_ops and add
	the offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <651e15968afb5bbd9eeafb0b66cd5b59eabcf8d9.1200894155.git.michael@ellerman.id.au>
References: <2949748ba6ad7e14f0768ac3889267e42c050d7a.1200894155.git.michael@ellerman.id.au>
	<651e15968afb5bbd9eeafb0b66cd5b59eabcf8d9.1200894155.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Mon, 21 Jan 2008 17:21:11 +1100
Message-Id: <1200896471.7222.107.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-01-21 at 16:42 +1100, Michael Ellerman wrote:
> Now that all platforms using dma_direct_offset setup the archdata.dma_data
> correctly, we can change the dma_direct_ops to retrieve the offset from
> the dma_data, rather than directly from the global.
> 
> While we're here, change the way the offset is used - instead of or'ing it
> into the value, add it. This should have no effect on current implementations
> where the offset is far larger than memory, however in future we may want
> to use smaller offsets.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/dma_64.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
> index 14206e3..a2d076d 100644
> --- a/arch/powerpc/kernel/dma_64.c
> +++ b/arch/powerpc/kernel/dma_64.c
> @@ -117,6 +117,11 @@ EXPORT_SYMBOL(dma_iommu_ops);
>   */
>  unsigned long dma_direct_offset;
>  
> +static unsigned long get_dma_direct_offset(struct device *dev)
> +{
> +	return (unsigned long)dev->archdata.dma_data;
> +}
> +
>  static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
>  				       dma_addr_t *dma_handle, gfp_t flag)
>  {
> @@ -130,7 +135,7 @@ static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
>  		return NULL;
>  	ret = page_address(page);
>  	memset(ret, 0, size);
> -	*dma_handle = virt_to_abs(ret) | dma_direct_offset;
> +	*dma_handle = virt_to_abs(ret) + get_dma_direct_offset(dev);
>  
>  	return ret;
>  }
> @@ -145,7 +150,7 @@ static dma_addr_t dma_direct_map_single(struct device *dev, void *ptr,
>  					size_t size,
>  					enum dma_data_direction direction)
>  {
> -	return virt_to_abs(ptr) | dma_direct_offset;
> +	return virt_to_abs(ptr) + get_dma_direct_offset(dev);
>  }
>  
>  static void dma_direct_unmap_single(struct device *dev, dma_addr_t dma_addr,
> @@ -161,7 +166,7 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
>  	int i;
>  
>  	for_each_sg(sgl, sg, nents, i) {
> -		sg->dma_address = sg_phys(sg) | dma_direct_offset;
> +		sg->dma_address = sg_phys(sg) + get_dma_direct_offset(dev);
>  		sg->dma_length = sg->length;
>  	}
>  
