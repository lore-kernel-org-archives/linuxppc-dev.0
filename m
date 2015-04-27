Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0AE41A024B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 07:05:16 +1000 (AEST)
Message-ID: <1430168702.4472.116.camel@redhat.com>
Subject: Re: [PATCH kernel v9 02/32] Revert "powerpc/powernv: Allocate
 struct pnv_ioda_pe iommu_table dynamically"
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 27 Apr 2015 15:05:02 -0600
In-Reply-To: <1429964096-11524-3-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-3-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-04-25 at 22:14 +1000, Alexey Kardashevskiy wrote:
> This reverts commit 9e8d4a19ab66ec9e132d405357b9108a4f26efd3 as
> tce32_table has exactly the same life time as the whole PE.

scripts/checkpatch.pl would like your commit reference to appear as:

commit 9e8d4a19ab66 ("powerpc/powernv: Allocate struct pnv_ioda_pe
iommu_table dynamically")

> 
> This makes use of a new iommu_reset_table() helper instead.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/iommu.h          |  3 ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 35 +++++++++++++------------------
>  arch/powerpc/platforms/powernv/pci.h      |  2 +-
>  3 files changed, 15 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> index e2cef38..9d320e0 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -79,9 +79,6 @@ struct iommu_table {
>  	struct iommu_group *it_group;
>  #endif
>  	void (*set_bypass)(struct iommu_table *tbl, bool enable);
> -#ifdef CONFIG_PPC_POWERNV
> -	void           *data;
> -#endif
>  };
>  
>  /* Pure 2^n version of get_order */
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 920c252..eff26ed 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1086,10 +1086,6 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
>  		return;
>  	}
>  
> -	pe->tce32_table = kzalloc_node(sizeof(struct iommu_table),
> -			GFP_KERNEL, hose->node);
> -	pe->tce32_table->data = pe;
> -
>  	/* Associate it with all child devices */
>  	pnv_ioda_setup_same_PE(bus, pe);
>  
> @@ -1295,7 +1291,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
>  	bus = dev->bus;
>  	hose = pci_bus_to_host(bus);
>  	phb = hose->private_data;
> -	tbl = pe->tce32_table;
> +	tbl = &pe->tce32_table;
>  	addr = tbl->it_base;
>  
>  	opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
> @@ -1310,9 +1306,8 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
>  	if (rc)
>  		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
>  
> -	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
> +	iommu_reset_table(tbl, of_node_full_name(dev->dev.of_node));
>  	free_pages(addr, get_order(TCE32_TABLE_SIZE));
> -	pe->tce32_table = NULL;
>  }
>  
>  static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
> @@ -1460,10 +1455,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>  			continue;
>  		}
>  
> -		pe->tce32_table = kzalloc_node(sizeof(struct iommu_table),
> -				GFP_KERNEL, hose->node);
> -		pe->tce32_table->data = pe;
> -
>  		/* Put PE to the list */
>  		mutex_lock(&phb->ioda.pe_list_mutex);
>  		list_add_tail(&pe->list, &phb->ioda.pe_list);
> @@ -1598,7 +1589,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
>  
>  	pe = &phb->ioda.pe_array[pdn->pe_number];
>  	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
> -	set_iommu_table_base_and_group(&pdev->dev, pe->tce32_table);
> +	set_iommu_table_base_and_group(&pdev->dev, &pe->tce32_table);
>  }
>  
>  static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
> @@ -1625,7 +1616,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
>  	} else {
>  		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
>  		set_dma_ops(&pdev->dev, &dma_iommu_ops);
> -		set_iommu_table_base(&pdev->dev, pe->tce32_table);
> +		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
>  	}
>  	*pdev->dev.dma_mask = dma_mask;
>  	return 0;
> @@ -1662,9 +1653,9 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		if (add_to_iommu_group)
>  			set_iommu_table_base_and_group(&dev->dev,
> -						       pe->tce32_table);
> +						       &pe->tce32_table);
>  		else
> -			set_iommu_table_base(&dev->dev, pe->tce32_table);
> +			set_iommu_table_base(&dev->dev, &pe->tce32_table);
>  
>  		if (dev->subordinate)
>  			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
> @@ -1754,7 +1745,8 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
>  void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
>  				 __be64 *startp, __be64 *endp, bool rm)
>  {
> -	struct pnv_ioda_pe *pe = tbl->data;
> +	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
> +					      tce32_table);
>  	struct pnv_phb *phb = pe->phb;
>  
>  	if (phb->type == PNV_PHB_IODA1)
> @@ -1817,7 +1809,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>  	}
>  
>  	/* Setup linux iommu table */
> -	tbl = pe->tce32_table;
> +	tbl = &pe->tce32_table;
>  	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
>  				  base << 28, IOMMU_PAGE_SHIFT_4K);
>  
> @@ -1862,7 +1854,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>  
>  static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
>  {
> -	struct pnv_ioda_pe *pe = tbl->data;
> +	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
> +					      tce32_table);
>  	uint16_t window_id = (pe->pe_number << 1 ) + 1;
>  	int64_t rc;
>  
> @@ -1907,10 +1900,10 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
>  	pe->tce_bypass_base = 1ull << 59;
>  
>  	/* Install set_bypass callback for VFIO */
> -	pe->tce32_table->set_bypass = pnv_pci_ioda2_set_bypass;
> +	pe->tce32_table.set_bypass = pnv_pci_ioda2_set_bypass;
>  
>  	/* Enable bypass by default */
> -	pnv_pci_ioda2_set_bypass(pe->tce32_table, true);
> +	pnv_pci_ioda2_set_bypass(&pe->tce32_table, true);
>  }
>  
>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> @@ -1958,7 +1951,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>  	}
>  
>  	/* Setup linux iommu table */
> -	tbl = pe->tce32_table;
> +	tbl = &pe->tce32_table;
>  	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
>  			IOMMU_PAGE_SHIFT_4K);
>  
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 070ee88..c954c64 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -57,7 +57,7 @@ struct pnv_ioda_pe {
>  	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
>  	int			tce32_seg;
>  	int			tce32_segcount;
> -	struct iommu_table	*tce32_table;
> +	struct iommu_table	tce32_table;
>  	phys_addr_t		tce_inval_reg_phys;
>  
>  	/* 64-bit TCE bypass region */
