Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0dZ82H2rzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 12:06:40 +1000 (AEST)
Received: by mail-pa0-x22f.google.com with SMTP id xk12so30559512pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 May 2016 19:06:40 -0700 (PDT)
Subject: Re: [PATCH v9 07/26] powerpc/powernv: Fix initial IO and M32 segmap
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-8-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, alistair@popple.id.au
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <3dadbc10-c44f-188c-a9a3-39c14df4abb7@ozlabs.ru>
Date: Thu, 5 May 2016 12:06:31 +1000
MIME-Version: 1.0
In-Reply-To: <1462254105-24128-8-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2016 03:41 PM, Gavin Shan wrote:
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

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 4aa6cdf..59b20e5 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3240,6 +3240,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	const __be64 *prop64;
>  	const __be32 *prop32;
>  	int len;
> +	unsigned int segno;
>  	u64 phb_id;
>  	void *aux;
>  	long rc;
> @@ -3334,8 +3335,13 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	aux = memblock_virt_alloc(size, 0);
>  	phb->ioda.pe_alloc = aux;
>  	phb->ioda.m32_segmap = aux + m32map_off;
> -	if (phb->type == PNV_PHB_IODA1)
> +	for (segno = 0; segno < phb->ioda.total_pe_num; segno++)
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


-- 
Alexey
