Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/7] Add celleb_dma_dev_setup()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <4bdf881cfc1386c5167495a5e64bdb9dc3ca90d5.1200894155.git.michael@ellerman.id.au>
References: <2949748ba6ad7e14f0768ac3889267e42c050d7a.1200894155.git.michael@ellerman.id.au>
	<4bdf881cfc1386c5167495a5e64bdb9dc3ca90d5.1200894155.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Mon, 21 Jan 2008 17:20:38 +1100
Message-Id: <1200896438.7222.105.camel@pasglop>
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
> Celleb always uses dma_direct_ops, and sets dma_direct_offset, so it too
> should set dma_data to dma_direct_offset.
> 
> Currently there's no pci_dma_dev_setup() routine for Celleb so add one.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/celleb/iommu.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/celleb/iommu.c b/arch/powerpc/platforms/celleb/iommu.c
> index 41e1e6f..843a66f 100644
> --- a/arch/powerpc/platforms/celleb/iommu.c
> +++ b/arch/powerpc/platforms/celleb/iommu.c
> @@ -72,6 +72,17 @@ static void __init celleb_init_direct_mapping(void)
>  	dma_direct_offset = dma_base;
>  }
>  
> +static void celleb_dma_dev_setup(struct device *dev)
> +{
> +	dev->archdata.dma_ops = get_pci_dma_ops();
> +	dev->archdata.dma_data = (void *)dma_direct_offset;
> +}
> +
> +static void celleb_pci_dma_dev_setup(struct pci_dev *pdev)
> +{
> +	celleb_dma_dev_setup(&pdev->dev);
> +}
> +
>  static int celleb_of_bus_notify(struct notifier_block *nb,
>  				unsigned long action, void *data)
>  {
> @@ -81,7 +92,7 @@ static int celleb_of_bus_notify(struct notifier_block *nb,
>  	if (action != BUS_NOTIFY_ADD_DEVICE)
>  		return 0;
>  
> -	dev->archdata.dma_ops = get_pci_dma_ops();
> +	celleb_dma_dev_setup(dev);
>  
>  	return 0;
>  }
> @@ -94,6 +105,7 @@ static int __init celleb_init_iommu(void)
>  {
>  	celleb_init_direct_mapping();
>  	set_pci_dma_ops(&dma_direct_ops);
> +	ppc_md.pci_dma_dev_setup = celleb_pci_dma_dev_setup;
>  	bus_register_notifier(&of_platform_bus_type, &celleb_of_bus_notifier);
>  
>  	return 0;
