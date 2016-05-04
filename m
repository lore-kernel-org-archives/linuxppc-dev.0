Return-Path: <alistair@popple.id.au>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r04jm3qHlzDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 14:26:20 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 aik@ozlabs.ru
Subject: Re: [PATCH v9 07/26] powerpc/powernv: Fix initial IO and M32 segmap
Date: Wed, 04 May 2016 13:31:04 +1000
Message-ID: <2708321.yBECSdbB51@new-mexico>
In-Reply-To: <1462254105-24128-8-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-8-git-send-email-gwshan@linux.vnet.ibm.com>
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

On Tue, 3 May 2016 15:41:26 Gavin Shan wrote:
> There are two arrays for IO and M32 segment maps on every PHB.
> The index of the arrays are segment number and the value stored
> in the corresponding element is PE number, indicating the segment
> is assigned to the PE. Initially, all elements in those two arrays
> are zeroes, meaning all segments are assigned to PE#0. It's wrong.
> 
> This fixes the initial values in the elements of those two arrays
> to IODA_INVALID_PE, meaning all segments aren't assigned to any
> PE.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c 
b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 4aa6cdf..59b20e5 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3240,6 +3240,7 @@ static void __init pnv_pci_init_ioda_phb(struct 
device_node *np,
>  	const __be64 *prop64;
>  	const __be32 *prop32;
>  	int len;
> +	unsigned int segno;
>  	u64 phb_id;
>  	void *aux;
>  	long rc;
> @@ -3334,8 +3335,13 @@ static void __init pnv_pci_init_ioda_phb(struct 
device_node *np,
>  	aux = memblock_virt_alloc(size, 0);
>  	phb->ioda.pe_alloc = aux;
>  	phb->ioda.m32_segmap = aux + m32map_off;
> -	if (phb->type == PNV_PHB_IODA1)
> +	for (segno = 0; segno < phb->ioda.total_pe_num; segno++)

These arrays are indexed by segment number but the upper bound is the total 
number of PEs. Does IODA1 & IODA2 hardware always have the same number of PE#s 
and segments? Is there any chance there could be more or less PE#s 
(total_pe_num) than segments?

- Alistair

> +		phb->ioda.m32_segmap[segno] = IODA_INVALID_PE;
> +	if (phb->type == PNV_PHB_IODA1) {
>  		phb->ioda.io_segmap = aux + iomap_off;
> +		for (segno = 0; segno < phb->ioda.total_pe_num; segno++)
> +			phb->ioda.io_segmap[segno] = IODA_INVALID_PE;
> +	}
>  	phb->ioda.pe_array = aux + pemap_off;
>  	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
>  
> 
