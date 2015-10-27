Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 931F81A03AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 16:56:21 +1100 (AEDT)
Received: by pabla5 with SMTP id la5so18586461pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 22:56:18 -0700 (PDT)
Subject: Re: [PATCH 4/7 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205925.GF10197@linux.vnet.ibm.com>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Gibson
 <david@gibson.dropbear.id.au>, Christoph Hellwig <hch@infradead.org>,
 "David S. Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <562F11FA.9090805@ozlabs.ru>
Date: Tue, 27 Oct 2015 16:56:10 +1100
MIME-Version: 1.0
In-Reply-To: <20151023205925.GF10197@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/24/2015 07:59 AM, Nishanth Aravamudan wrote:
> When DDW (Dynamic DMA Windows) are present for a device, we have stored
> the TCE (Translation Control Entry) size in a special device tree
> property. Check if we have enabled DDW for the device and return the TCE
> size from that property if present. If the property isn't present,
> fallback to looking the value up in struct iommu_table. If we don't find
> a iommu_table, fallback to the kernel's page size.
>
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/iommu.c | 36 ++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 0946b98..1bf6471 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -1292,6 +1292,40 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
>   	return dma_iommu_ops.get_required_mask(dev);
>   }
>
> +static unsigned long dma_get_page_shift_pSeriesLP(struct device *dev)
> +{
> +	struct iommu_table *tbl;
> +
> +	if (!disable_ddw && dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		struct device_node *dn;
> +
> +		dn = pci_device_to_OF_node(pdev);
> +
> +		/* search upwards for ibm,dma-window */
> +		for (; dn && PCI_DN(dn) && !PCI_DN(dn)->table_group;
> +				dn = dn->parent)
> +			if (of_get_property(dn, "ibm,dma-window", NULL))
> +				break;
> +		/*
> +		 * if there is a DDW configuration, the TCE shift is stored in
> +		 * the property
> +		 */
> +		if (dn && PCI_DN(dn)) {
> +			const struct dynamic_dma_window_prop *direct64 =
> +				of_get_property(dn, DIRECT64_PROPNAME, NULL);


This DIRECT64_PROPNAME property is only present under pHyp, QEMU/KVM does 
not set it as 64bit windows are dynamic there so something like 
find_existing_ddw() needs to be used here.



> +			if (direct64)
> +				return be32_to_cpu(direct64->tce_shift);
> +		}
> +	}
> +
> +	tbl = get_iommu_table_base(dev);
> +	if (tbl)
> +		return tbl->it_page_shift;
> +
> +	return PAGE_SHIFT;
> +}
> +
>   #else  /* CONFIG_PCI */
>   #define pci_dma_bus_setup_pSeries	NULL
>   #define pci_dma_dev_setup_pSeries	NULL
> @@ -1299,6 +1333,7 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
>   #define pci_dma_dev_setup_pSeriesLP	NULL
>   #define dma_set_mask_pSeriesLP		NULL
>   #define dma_get_required_mask_pSeriesLP	NULL
> +#define dma_get_page_shift_pSeriesLP	NULL
>   #endif /* !CONFIG_PCI */
>
>   static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
> @@ -1395,6 +1430,7 @@ void iommu_init_early_pSeries(void)
>   		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeriesLP;
>   		ppc_md.dma_set_mask = dma_set_mask_pSeriesLP;
>   		ppc_md.dma_get_required_mask = dma_get_required_mask_pSeriesLP;
> +		ppc_md.dma_get_page_shift = dma_get_page_shift_pSeriesLP;
>   	} else {
>   		pseries_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pSeries;
>   		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeries;
>


-- 
Alexey
