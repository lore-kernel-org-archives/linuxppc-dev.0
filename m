Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bdwP1w1RzF2TR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 23:12:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel] powerpc/ioda: Use ibm,
 supported-tce-sizes for IOMMU page size mask
In-Reply-To: <20180502061239.36398-1-aik@ozlabs.ru>
References: <20180502061239.36398-1-aik@ozlabs.ru>
Date: Wed, 02 May 2018 23:12:00 +1000
Message-ID: <87muxidwwv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> At the moment we assume that IODA2 and newer PHBs can always do 4K/64K/16M
> IOMMU pages, however this is not the case for POWER9 and now skiboot
> advertises the supported sizes via the device so we use that instead
> of hard coding the mask.
>
> This falls back to the default mask if no "ibm,supported-tce-sizes"
> is provided. This removes 16MB from the defaults as it is not supported
> everywhere; the downside of this is that hugepages backed POWER8 guests
> will fall back to 64K IOMMU pages until skiboot is updated.

That's probably not really an acceptable solution is it?

I think we need to add a quirk if we're on power8 to put 16M back.

cheers

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 3f9c69d..e02a8a9 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2910,6 +2910,24 @@ static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
>  			tbl->it_indirect_levels);
>  }
>  
> +static unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
> +{
> +	struct pci_controller *hose = phb->hose;
> +	struct device_node *dn = hose->dn;
> +	int i, len = 0;
> +	const __be32 *r;
> +	unsigned long mask = 0;
> +
> +	r = of_get_property(dn, "ibm,supported-tce-sizes", &len);
> +	if (!r || !len)
> +		return SZ_4K | SZ_64K;
> +
> +	for (i = 0; i < len / sizeof(*r); ++i)
> +		mask |= 1ULL << be32_to_cpu(r[i]);
> +
> +	return mask;
> +}
> +
>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>  				       struct pnv_ioda_pe *pe)
>  {
> @@ -2934,7 +2952,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>  	pe->table_group.max_dynamic_windows_supported =
>  			IOMMU_TABLE_GROUP_MAX_TABLES;
>  	pe->table_group.max_levels = POWERNV_IOMMU_MAX_LEVELS;
> -	pe->table_group.pgsizes = SZ_4K | SZ_64K | SZ_16M;
> +	pe->table_group.pgsizes = pnv_ioda_parse_tce_sizes(phb);
>  #ifdef CONFIG_IOMMU_API
>  	pe->table_group.ops = &pnv_pci_ioda2_ops;
>  #endif
> -- 
> 2.11.0
