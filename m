Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs5fk1DCDzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 18:45:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv: Check kzalloc() return in
 pnv_pci_table_alloc
In-Reply-To: <20170327032803.18775-1-aik@ozlabs.ru>
References: <20170327032803.18775-1-aik@ozlabs.ru>
Date: Mon, 27 Mar 2017 18:45:30 +1100
Message-ID: <87d1d3f9id.fsf@concordia.ellerman.id.au>
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

> pnv_pci_table_alloc() ignores posible failure from kzalloc_node(),
> this adds a check. There are 2 callers of pnv_pci_table_alloc(),
> one already checks for tbl!=NULL, this adds BUG_ON() to the other path
> which only happens during boot time in IODA1 and not expected to fail.
>
> Fixes: 0eaf4defc7c4 ("powerpc/spapr: vfio: Switch from iommu_table to new iommu_table_group")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 1 +
>  arch/powerpc/platforms/powernv/pci.c      | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index e36738291c32..dcda3f6b7d36 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2128,6 +2128,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>  
>  found:
>  	tbl = pnv_pci_table_alloc(phb->hose->node);
> +	BUG_ON(!tbl);
>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
>  			pe->pe_number);
>  	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);

Please don't add BUG_ON()'s for non-critical things like this.

I know memory allocation isn't expected to fail during boot, but don't
make people's life harder by BUG'ing.

Ideally you'd just return failure to the caller and eventually we'd
print a message at some higher level. In a case like this where the
function returns void, rather than restructuring everything to pass
a return value you can just do:

if (WARN_ON(!tbl))
	return;

cheers
