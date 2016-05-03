Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qzWPP1mPfzDvw9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:25:13 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v4 09/11] powerpc/powernv/npu: Add set/unset window
 helpers
Date: Tue, 03 May 2016 16:25 +1000
Message-ID: <1541287.tQu2vNHrMy@new-mexico>
In-Reply-To: <1461920124-21719-10-git-send-email-aik@ozlabs.ru>
References: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
 <1461920124-21719-10-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Fri, 29 Apr 2016 18:55:22 Alexey Kardashevskiy wrote:
> The upcoming NVLink passthrough support will require NPU code to cope
> with two DMA windows.
> 
> This adds a pnv_npu_set_window() helper which programs 32bit window to
> the hardware. This also adds multilevel TCE support.
> 
> This adds a pnv_npu_unset_window() helper which removes the DMA window
> from the hardware. This does not make difference now as the caller -
> pnv_npu_dma_set_bypass() - enables bypass in the hardware but the next
> patch will use it to manage TCE table lists for TCE Kill handling.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 65 
+++++++++++++++++++++++++++-----
>  1 file changed, 55 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c 
b/arch/powerpc/platforms/powernv/npu-dma.c
> index bec9267..800d70f 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -159,6 +159,56 @@ static struct pnv_ioda_pe 
*get_gpu_pci_dev_and_pe(struct pnv_ioda_pe *npe,
>  	return pe;
>  }
>  
> +static long pnv_npu_set_window(struct pnv_ioda_pe *npe,
> +		struct iommu_table *tbl)
> +{
> +	struct pnv_phb *phb = npe->phb;
> +	int64_t rc;
> +	const unsigned long size = tbl->it_indirect_levels ?
> +		tbl->it_level_size : tbl->it_size;
> +	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
> +	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
> +
> +	pe_info(npe, "Setting up window %llx..%llx pg=%lx\n",
> +			start_addr, start_addr + win_size - 1,
> +			IOMMU_PAGE_SIZE(tbl));
> +
> +	rc = opal_pci_map_pe_dma_window(phb->opal_id,
> +			npe->pe_number,
> +			npe->pe_number,
> +			tbl->it_indirect_levels + 1,
> +			__pa(tbl->it_base),
> +			size << 3,
> +			IOMMU_PAGE_SIZE(tbl));
> +	if (rc) {
> +		pe_err(npe, "Failed to configure TCE table, err %lld\n", rc);
> +		return rc;
> +	}
> +	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
> +
> +	return 0;
> +}
> +
> +static long pnv_npu_unset_window(struct pnv_ioda_pe *npe)
> +{
> +	struct pnv_phb *phb = npe->phb;
> +	int64_t rc;
> +
> +	pe_info(npe, "Removing DMA window\n");
> +
> +	rc = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
> +			npe->pe_number,
> +			0/* levels */, 0/* table address */,
> +			0/* table size */, 0/* page size */);
> +	if (rc) {
> +		pe_err(npe, "Unmapping failed, ret = %lld\n", rc);
> +		return rc;
> +	}
> +	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
> +
> +	return 0;
> +}
> +
>  void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe)
>  {
>  	struct pnv_ioda_pe *gpe;
> @@ -200,10 +250,8 @@ void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe)
>   */
>  static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
>  {
> -	struct pnv_phb *phb = npe->phb;
>  	struct pci_dev *gpdev;
>  	struct pnv_ioda_pe *gpe;
> -	struct iommu_table *tbl;
>  	int64_t rc;
>  
>  	/*
> @@ -217,14 +265,7 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
>  	if (!gpe)
>  		return;
>  
> -	tbl = gpe->table_group.tables[0];
> -	rc = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
> -					npe->pe_number, 1, __pa(tbl->it_base),
> -					tbl->it_size << 3,
> -					IOMMU_PAGE_SIZE(tbl));
> -	if (rc != OPAL_SUCCESS)
> -		pr_warn("%s: Error %lld setting DMA window on PHB#%d-PE#%d\n",
> -			__func__, rc, phb->hose->global_number, npe-
>pe_number);
> +	rc = pnv_npu_set_window(npe, gpe->table_group.tables[0]);
>  
>  	/*
>  	 * We don't initialise npu_pe->tce32_table as we always use
> @@ -248,6 +289,10 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe 
*npe)
>  	if (phb->type != PNV_PHB_NPU || !npe->pdev)
>  		return -EINVAL;
>  
> +	rc = pnv_npu_unset_window(npe);

As noted in the commit message you technically don't need to do this as the 
subsequent OPAL call to enable the bypass window below will just overwrite the 
same TVE. However I like the logic of clearing the existing TVE before writing 
a new one anyway as it also ensures the TCE cache gets properly invalidated.

Other than that this patch looks like it doesn't change any existing 
behaviour.

Reviewed-By: Alistair Popple <alistair@popple.id.au>

> +	if (rc != OPAL_SUCCESS)
> +		return rc;
> +
>  	/* Enable the bypass window */
>  
>  	top = roundup_pow_of_two(top);
> 
