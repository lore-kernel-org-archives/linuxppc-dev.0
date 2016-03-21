Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qT0qy3xKLzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 13:57:50 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel 05/10] powerpc/powernv/npu: Use the correct IOMMU
 page size
Date: Mon, 21 Mar 2016 13:57:45 +1100
Message-ID: <8632459.Qva2dseSrC@new-mexico>
In-Reply-To: <1457504946-40649-6-git-send-email-aik@ozlabs.ru>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-6-git-send-email-aik@ozlabs.ru>
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

Thanks for fixing Alexey!

On Wed, 9 Mar 2016 17:29:01 Alexey Kardashevskiy wrote:
> This uses the page size from iommu_table instead of hard-coded 4K.
> This should cause no change in behavior.
> 
> While we are here, move bits around to prepare for further rework
> which will define and use iommu_table_group_ops.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Alistair Popple <alistair@popple.id.au>

> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index 778570c..5bd5fee 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -204,8 +204,7 @@ static void pnv_npu_disable_bypass(struct pnv_ioda_pe *npe)
>  	struct pnv_phb *phb = npe->phb;
>  	struct pci_dev *gpdev;
>  	struct pnv_ioda_pe *gpe;
> -	void *addr;
> -	unsigned int size;
> +	struct iommu_table *tbl;
>  	int64_t rc;
>  
>  	/*
> @@ -219,11 +218,11 @@ static void pnv_npu_disable_bypass(struct pnv_ioda_pe *npe)
>  	if (!gpe)
>  		return;
>  
> -	addr = (void *)gpe->table_group.tables[0]->it_base;
> -	size = gpe->table_group.tables[0]->it_size << 3;
> +	tbl = gpe->table_group.tables[0];
>  	rc = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
> -					npe->pe_number, 1, __pa(addr),
> -					size, 0x1000);
> +					npe->pe_number, 1, __pa(tbl->it_base),
> +					tbl->it_size << 3,
> +					IOMMU_PAGE_SIZE(tbl));
>  	if (rc != OPAL_SUCCESS)
>  		pr_warn("%s: Error %lld setting DMA window on PHB#%d-PE#%d\n",
>  			__func__, rc, phb->hose->global_number, npe->pe_number);
> 
