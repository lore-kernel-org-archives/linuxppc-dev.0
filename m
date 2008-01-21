Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/7] Have cell use its own dma_direct_offset variable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <0a87a8672c76341044ebb0231ff0c1fba4e82c36.1200894155.git.michael@ellerman.id.au>
References: <2949748ba6ad7e14f0768ac3889267e42c050d7a.1200894155.git.michael@ellerman.id.au>
	<0a87a8672c76341044ebb0231ff0c1fba4e82c36.1200894155.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Mon, 21 Jan 2008 17:21:19 +1100
Message-Id: <1200896479.7222.109.camel@pasglop>
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
> Rather than using the global variable, have cell use its own variable to
> store the direct DMA offset.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

> ---
>  arch/powerpc/platforms/cell/iommu.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index 9682b63..7f45d59 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -490,6 +490,8 @@ static struct cbe_iommu *cell_iommu_for_node(int nid)
>  	return NULL;
>  }
>  
> +static unsigned long cell_dma_direct_offset;
> +
>  static void cell_dma_dev_setup(struct device *dev)
>  {
>  	struct iommu_window *window;
> @@ -497,7 +499,7 @@ static void cell_dma_dev_setup(struct device *dev)
>  	struct dev_archdata *archdata = &dev->archdata;
>  
>  	if (get_pci_dma_ops() == &dma_direct_ops) {
> -		archdata->dma_data = (void *)dma_direct_offset;
> +		archdata->dma_data = (void *)cell_dma_direct_offset;
>  		return;
>  	}
>  
> @@ -655,7 +657,7 @@ static int __init cell_iommu_init_disabled(void)
>  
>  	/* If we have no Axon, we set up the spider DMA magic offset */
>  	if (of_find_node_by_name(NULL, "axon") == NULL)
> -		dma_direct_offset = SPIDER_DMA_OFFSET;
> +		cell_dma_direct_offset = SPIDER_DMA_OFFSET;
>  
>  	/* Now we need to check to see where the memory is mapped
>  	 * in PCI space. We assume that all busses use the same dma
> @@ -689,13 +691,13 @@ static int __init cell_iommu_init_disabled(void)
>  		return -ENODEV;
>  	}
>  
> -	dma_direct_offset += base;
> +	cell_dma_direct_offset += base;
>  
> -	if (dma_direct_offset != 0)
> +	if (cell_dma_direct_offset != 0)
>  		ppc_md.pci_dma_dev_setup = cell_pci_dma_dev_setup;
>  
>  	printk("iommu: disabled, direct DMA offset is 0x%lx\n",
> -	       dma_direct_offset);
> +	       cell_dma_direct_offset);
>  
>  	return 0;
>  }
