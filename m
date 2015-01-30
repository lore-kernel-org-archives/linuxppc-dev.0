Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BFCF1A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 13:17:36 +1100 (AEDT)
In-Reply-To: <1402385530-23091-1-git-send-email-zhouzhouyi@gmail.com>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <aik@ozlabs.ru>, <anton@samba.org>,
 <nacc@linux.vnet.ibm.com>, <alistair@popple.id.au>,
 <deepthi@linux.vnet.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/1] powerpc/iommu: Handling null return of kzalloc_node
Message-Id: <20150130021736.7635F1402B0@ozlabs.org>
Date: Fri, 30 Jan 2015 13:17:36 +1100 (AEDT)
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>, Zhouyi Zhou <yizhouzhou@ict.ac.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-10-06 at 07:32:10 UTC, Zhouyi Zhou wrote:
> NULL return of kzalloc_node should be handled 

Yeah it should.

But just returning doesn't seem like it's going to end well. We end up with a
device that's not properly setup.

I think we need to rework that further so that either the error is propagated
up the stack, or the device is left in a working but degraded state.

cheers


 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 33b552f..593cd3d 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -613,7 +613,11 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
>  
>  	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
>  			   pci->phb->node);
> -
> +	if (!tbl) {
> +		pr_debug(" out of memory, can't create iommu_table !\n");
> +		return;
> +	}
> +
>  	iommu_table_setparms(pci->phb, dn, tbl);
>  	pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
>  	iommu_register_group(tbl, pci_domain_nr(bus), 0);
> @@ -659,6 +663,10 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
>  	if (!ppci->iommu_table) {
>  		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
>  				   ppci->phb->node);
> +		if (!tbl) {
> +			pr_debug(" out of memory, can't create iommu_table !\n");
> +			return;
> +		}
>  		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
>  		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
>  		iommu_register_group(tbl, pci_domain_nr(bus), 0);
> @@ -686,6 +694,11 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
>  		pr_debug(" --> first child, no bridge. Allocating iommu table.\n");
>  		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
>  				   phb->node);
> +		if (!tbl) {
> +			pr_debug(" out of memory, can't create iommu_table !\n");
> +			return;
> +		}
> +
>  		iommu_table_setparms(phb, dn, tbl);
>  		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
>  		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
> @@ -1102,6 +1116,10 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
>  	if (!pci->iommu_table) {
>  		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
>  				   pci->phb->node);
> +		if (!tbl) {
> +			pr_debug(" out of memory, can't create iommu_table !\n");
> +			return;
> +		}
>  		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
>  		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
>  		iommu_register_group(tbl, pci_domain_nr(pci->phb->bus), 0);
