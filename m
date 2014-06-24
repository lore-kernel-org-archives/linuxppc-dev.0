Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C35A1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 20:06:50 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id md12so55556pbc.31
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 03:06:47 -0700 (PDT)
Message-ID: <53A94DA8.6020206@ozlabs.ru>
Date: Tue, 24 Jun 2014 20:06:32 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table dynamically
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=KOI8-R
Cc: linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 qiudayu@linux.vnet.ibm.com, bhelgaas@google.com, yan@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2014 11:56 AM, Wei Yang wrote:
> Current iommu_table of a PE is a static field. This will have a problem when
> iommu_free_table is called.

What kind of problem? This table is per PE and PE is not going anywhere.


> 
> This patch allocate iommu_table dynamically.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/iommu.h          |    3 +++
>  arch/powerpc/platforms/powernv/pci-ioda.c |   24 +++++++++++++-----------
>  arch/powerpc/platforms/powernv/pci.h      |    2 +-
>  3 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> index 42632c7..0fedacb 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -78,6 +78,9 @@ struct iommu_table {
>  	struct iommu_group *it_group;
>  #endif
>  	void (*set_bypass)(struct iommu_table *tbl, bool enable);
> +#ifdef CONFIG_PPC_POWERNV
> +	void           *data;
> +#endif
>  };
>  
>  /* Pure 2^n version of get_order */
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 9715351..8ca3926 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -608,6 +608,10 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
>  		return;
>  	}
>  
> +	pe->tce32_table = kzalloc_node(sizeof(struct iommu_table),
> +			GFP_KERNEL, hose->node);
> +	pe->tce32_table->data = pe;
> +
>  	/* Associate it with all child devices */
>  	pnv_ioda_setup_same_PE(bus, pe);
>  
> @@ -675,7 +679,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
>  
>  	pe = &phb->ioda.pe_array[pdn->pe_number];
>  	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
> -	set_iommu_table_base_and_group(&pdev->dev, &pe->tce32_table);
> +	set_iommu_table_base_and_group(&pdev->dev, pe->tce32_table);
>  }
>  
>  static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
> @@ -702,7 +706,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
>  	} else {
>  		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
>  		set_dma_ops(&pdev->dev, &dma_iommu_ops);
> -		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
> +		set_iommu_table_base(&pdev->dev, pe->tce32_table);
>  	}
>  	return 0;
>  }
> @@ -712,7 +716,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
>  	struct pci_dev *dev;
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		set_iommu_table_base_and_group(&dev->dev, &pe->tce32_table);
> +		set_iommu_table_base_and_group(&dev->dev, pe->tce32_table);
>  		if (dev->subordinate)
>  			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
>  	}
> @@ -798,8 +802,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
>  void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
>  				 __be64 *startp, __be64 *endp, bool rm)
>  {
> -	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
> -					      tce32_table);
> +	struct pnv_ioda_pe *pe = tbl->data;
>  	struct pnv_phb *phb = pe->phb;
>  
>  	if (phb->type == PNV_PHB_IODA1)
> @@ -862,7 +865,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>  	}
>  
>  	/* Setup linux iommu table */
> -	tbl = &pe->tce32_table;
> +	tbl = pe->tce32_table;
>  	pnv_pci_setup_iommu_table(tbl, addr, PNV_TCE32_TAB_SIZE * segs,
>  				  base << PNV_TCE32_SEG_SHIFT);
>  
> @@ -900,8 +903,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>  
>  static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
>  {
> -	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
> -					      tce32_table);
> +	struct pnv_ioda_pe *pe = tbl->data;
>  	uint16_t window_id = (pe->pe_number << 1 ) + 1;
>  	int64_t rc;
>  
> @@ -942,10 +944,10 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
>  	pe->tce_bypass_base = 1ull << 59;
>  
>  	/* Install set_bypass callback for VFIO */
> -	pe->tce32_table.set_bypass = pnv_pci_ioda2_set_bypass;
> +	pe->tce32_table->set_bypass = pnv_pci_ioda2_set_bypass;
>  
>  	/* Enable bypass by default */
> -	pnv_pci_ioda2_set_bypass(&pe->tce32_table, true);
> +	pnv_pci_ioda2_set_bypass(pe->tce32_table, true);
>  }
>  
>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> @@ -993,7 +995,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>  	}
>  
>  	/* Setup linux iommu table */
> -	tbl = &pe->tce32_table;
> +	tbl = pe->tce32_table;
>  	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0);
>  
>  	/* OPAL variant of PHB3 invalidated TCEs */
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 90f6da4..9fbf7c0 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -60,7 +60,7 @@ struct pnv_ioda_pe {
>  	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
>  	int			tce32_seg;
>  	int			tce32_segcount;
> -	struct iommu_table	tce32_table;
> +	struct iommu_table	*tce32_table;
>  	phys_addr_t		tce_inval_reg_phys;
>  
>  	/* 64-bit TCE bypass region */
> 


-- 
Alexey
