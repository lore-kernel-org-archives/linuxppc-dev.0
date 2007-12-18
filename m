Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB51ADDEAB
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 06:51:00 +1100 (EST)
Subject: Re: [POWERPC 07/18] Have cell use its own dma_direct_offset variable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: arnd@arndb.de
In-Reply-To: <20071218175104.846274000@arndb.de>
References: <20071218174852.112644000@arndb.de>
	<20071218175104.846274000@arndb.de>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 06:50:42 +1100
Message-Id: <1198007442.18908.6.camel@pasglop>
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
> (0017-Have-cell-use-its-own-dma_direct_offset-variable.patch)
> Rather than using the global variable, have cell use its own variable to
> store the direct DMA offset.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Ack.

>  arch/powerpc/platforms/cell/iommu.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6-new/arch/powerpc/platforms/cell/iommu.c
> ===================================================================
> --- linux-2.6-new.orig/arch/powerpc/platforms/cell/iommu.c
> +++ linux-2.6-new/arch/powerpc/platforms/cell/iommu.c
> @@ -490,6 +490,8 @@ static struct cbe_iommu *cell_iommu_for_
>  	return NULL;
>  }
>  
> +static unsigned long cell_dma_direct_offset;
> +
>  static void cell_dma_dev_setup(struct device *dev)
>  {
>  	struct iommu_window *window;
> @@ -497,7 +499,7 @@ static void cell_dma_dev_setup(struct de
>  	struct dev_archdata *archdata = &dev->archdata;
>  
>  	if (get_pci_dma_ops() == &dma_direct_ops) {
> -		archdata->dma_data = &dma_direct_offset;
> +		archdata->dma_data = &cell_dma_direct_offset;
>  		return;
>  	}
>  
> @@ -655,7 +657,7 @@ static int __init cell_iommu_init_disabl
>  
>  	/* If we have no Axon, we set up the spider DMA magic offset */
>  	if (of_find_node_by_name(NULL, "axon") == NULL)
> -		dma_direct_offset = SPIDER_DMA_OFFSET;
> +		cell_dma_direct_offset = SPIDER_DMA_OFFSET;
>  
>  	/* Now we need to check to see where the memory is mapped
>  	 * in PCI space. We assume that all busses use the same dma
> @@ -689,10 +691,10 @@ static int __init cell_iommu_init_disabl
>  		return -ENODEV;
>  	}
>  
> -	dma_direct_offset += base;
> +	cell_dma_direct_offset += base;
>  
>  	printk("iommu: disabled, direct DMA offset is 0x%lx\n",
> -	       dma_direct_offset);
> +	       cell_dma_direct_offset);
>  
>  	return 0;
>  }
> 
