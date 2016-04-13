Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlDGD3h92zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 16:21:16 +1000 (AEST)
Received: by mail-pa0-x232.google.com with SMTP id ot11so27769241pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 23:21:16 -0700 (PDT)
Subject: Re: [PATCH v8 08/45] powerpc/powernv: Fix initial IO and M32 segmap
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-9-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DE553.80708@ozlabs.ru>
Date: Wed, 13 Apr 2016 16:21:07 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-9-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:43 PM, Gavin Shan wrote:
> There are two arrays for IO and M32 segment maps on every PHB.
> The index of the arrays are segment number and the value stored
> in the corresponding element is PE number, indicating the segment
> is assigned to the PE. Initially, all elements in those two arrays
> are zeroes, meaning all segments are assigned to PE#0. It's wrong.
 >
> This fixes the initial values in the elements of those two arrays
> to IODA_INVALID_PE, meaning all segments aren't assigned to any
> PE.

This is ok.

> In order to use IODA_INVALID_PE (-1) to represent invalid PE
> number, the types of those two arrays are changed from "unsigned int"
> to "int".

"unsigned" can carry (-1) perfectly fine, just add a type cast to 
IODA_INVALID_PE:

#define IODA_INVALID_PE    (unsigned int)(-1)

Using "signed" type for indexes which cannot be negative does not make much 
sense - instead of checking for the upper boundary, you have to check for 
"< 0" too.

OPAL uses unsigned type for PE (uint64_t or uint32_t or uint16_t - this is 
quite funny).

pnv_ioda_pe::pe_number is "unsigned" and this pe_number is the same thing 
as I can see in pnv_ioda_setup_dev_PE().

Some printk() print the PE number as "%x" (which implies "unsigned").


I suggest changing the pci_dn::pe_number type from "int" to "unsigned int" 
to match pnv_ioda_pe::pe_number, in a separate patch. Or do not touch types 
for now.


> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++++++--
>   arch/powerpc/platforms/powernv/pci.h      | 4 ++--
>   2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 1d2514f..44cc5f3 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3239,7 +3239,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
>   	const __be64 *prop64;
>   	const __be32 *prop32;
> -	int len;
> +	int i, len;
>   	u64 phb_id;
>   	void *aux;
>   	long rc;
> @@ -3334,8 +3334,13 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   	aux = memblock_virt_alloc(size, 0);
>   	phb->ioda.pe_alloc = aux;
>   	phb->ioda.m32_segmap = aux + m32map_off;
> -	if (phb->type == PNV_PHB_IODA1)
> +	for (i = 0; i < phb->ioda.total_pe_num; i++)
> +		phb->ioda.m32_segmap[i] = IODA_INVALID_PE;
> +	if (phb->type == PNV_PHB_IODA1) {
>   		phb->ioda.io_segmap = aux + iomap_off;
> +		for (i = 0; i < phb->ioda.total_pe_num; i++)
> +			phb->ioda.io_segmap[i] = IODA_INVALID_PE;
> +	}
>   	phb->ioda.pe_array = aux + pemap_off;
>   	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
>
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 784882a..36c4965 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -146,8 +146,8 @@ struct pnv_phb {
>   		struct pnv_ioda_pe	*pe_array;
>
>   		/* M32 & IO segment maps */
> -		unsigned int		*m32_segmap;
> -		unsigned int		*io_segmap;
> +		int			*m32_segmap;
> +		int			*io_segmap;
>
>   		/* IRQ chip */
>   		int			irq_chip_init;
>


-- 
Alexey
