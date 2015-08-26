Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448801A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:52:32 +1000 (AEST)
Received: by pacti10 with SMTP id ti10so81489380pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 01:52:30 -0700 (PDT)
Subject: Re: [PATCH 2/3] powerpc/iommu: Cleanup setting of DMA base/offset
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <1435123527.3996.30.camel@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Wei Yang <weiyang@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55DD7E49.6010709@ozlabs.ru>
Date: Wed, 26 Aug 2015 18:52:25 +1000
MIME-Version: 1.0
In-Reply-To: <1435123527.3996.30.camel@kernel.crashing.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2015 03:25 PM, Benjamin Herrenschmidt wrote:
> Now that the table and the offset can co-exist, we no longer need
> to flip/flop, we can just establish both once at boot time.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c |  3 +--
>   arch/powerpc/platforms/pseries/iommu.c    |  3 +--
>   arch/powerpc/sysdev/dart_iommu.c          | 16 +++-------------
>   3 files changed, 5 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 5738d31..2c286b57 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1620,11 +1620,9 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
>   	if (bypass) {
>   		dev_info(&pdev->dev, "Using 64-bit DMA iommu bypass\n");
>   		set_dma_ops(&pdev->dev, &dma_direct_ops);
> -		set_dma_offset(&pdev->dev, pe->tce_bypass_base);


This particular change breaks SRIOV. So some SRIOV code relies on that but 
I could not spot this place quickly.


Also, this specific patch in powerpc/next tree just does not compile 
because of "powerpc/iommu: Remove dma_data union" but this is another story :)




>   	} else {
>   		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
>   		set_dma_ops(&pdev->dev, &dma_iommu_ops);
> -		set_iommu_table_base(&pdev->dev, pe->table_group.tables[0]);
>   	}
>   	*pdev->dev.dma_mask = dma_mask;
>   	return 0;
> @@ -1659,6 +1657,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
>
>   	list_for_each_entry(dev, &bus->devices, bus_list) {
>   		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
> +		set_dma_offset(&dev->dev, pe->tce_bypass_base);
>   		iommu_add_device(&dev->dev);
>
>   		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 10510de..0946b98 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -1253,11 +1253,10 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
>   		}
>   	}
>
> -	/* fall back on iommu ops, restore table pointer with ops */
> +	/* fall back on iommu ops */
>   	if (!ddw_enabled && get_dma_ops(dev) != &dma_iommu_ops) {
>   		dev_info(dev, "Restoring 32-bit DMA via iommu\n");
>   		set_dma_ops(dev, &dma_iommu_ops);
> -		pci_dma_dev_setup_pSeriesLP(pdev);
>   	}
>
>   check_mask:
> diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
> index 90bcdfe..b734863 100644
> --- a/arch/powerpc/sysdev/dart_iommu.c
> +++ b/arch/powerpc/sysdev/dart_iommu.c
> @@ -313,20 +313,11 @@ static void iommu_table_dart_setup(void)
>   	set_bit(iommu_table_dart.it_size - 1, iommu_table_dart.it_map);
>   }
>
> -static void dma_dev_setup_dart(struct device *dev)
> -{
> -	/* We only have one iommu table on the mac for now, which makes
> -	 * things simple. Setup all PCI devices to point to this table
> -	 */
> -	if (get_dma_ops(dev) == &dma_direct_ops)
> -		set_dma_offset(dev, DART_U4_BYPASS_BASE);
> -	else
> -		set_iommu_table_base(dev, &iommu_table_dart);
> -}
> -
>   static void pci_dma_dev_setup_dart(struct pci_dev *dev)
>   {
> -	dma_dev_setup_dart(&dev->dev);
> +	if (dart_is_u4)
> +		set_dma_offset(&dev->dev, DART_U4_BYPASS_BASE);
> +	set_iommu_table_base(&dev->dev, &iommu_table_dart);
>   }
>
>   static void pci_dma_bus_setup_dart(struct pci_bus *bus)
> @@ -370,7 +361,6 @@ static int dart_dma_set_mask(struct device *dev, u64 dma_mask)
>   		dev_info(dev, "Using 32-bit DMA via iommu\n");
>   		set_dma_ops(dev, &dma_iommu_ops);
>   	}
> -	dma_dev_setup_dart(dev);
>
>   	*dev->dma_mask = dma_mask;
>   	return 0;
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>


-- 
Alexey
