Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gy9Z5JV4zF2MK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 23:38:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel v2] powerpc/ioda: Use ibm,
 supported-tce-sizes for IOMMU page size mask
In-Reply-To: <20180503042924.27308-1-aik@ozlabs.ru>
References: <20180503042924.27308-1-aik@ozlabs.ru>
Date: Wed, 09 May 2018 23:38:22 +1000
Message-ID: <87in7xymnl.fsf@concordia.ellerman.id.au>
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
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * added quirk for POWER8 to advertise 16M if skiboot has not provided info
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 3f9c69d..891b4b6 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2910,6 +2910,30 @@ static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
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
> +	if (!r || !len) {
> +		mask = SZ_4K | SZ_64K;
> +		/* Add 16M for POWER8 by default */
> +		if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
> +				!cpu_has_feature(CPU_FTR_ARCH_300))
> +			mask |= SZ_16M;
> +		return mask;
> +	}
> +
> +	for (i = 0; i < len / sizeof(*r); ++i)
> +		mask |= 1ULL << be32_to_cpu(r[i]);
> +
> +	return mask;
> +}

Can we use the modern device tree accessors?

eg:


static unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
{
	struct pci_controller *hose = phb->hose;
	struct device_node *dn = hose->dn;
	unsigned long mask = 0;
	int i, rc, count;
	u32 val;

	count = of_property_count_u32_elems(dn, "ibm,supported-tce-sizes");
	if (count <= 0) {
		mask = SZ_4K | SZ_64K;
		/* Add 16M for POWER8 by default */
		if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
				!cpu_has_feature(CPU_FTR_ARCH_300))
			mask |= SZ_16M;
		return mask;
	}

	for (i = 0; i < count; i++) {
		rc = of_property_read_u32_index(dn, "ibm,supported-tce-sizes",
						i, &val);
		if (rc == 0)
			mask |= 1ULL << val;
	}

	return mask;
}

cheers
