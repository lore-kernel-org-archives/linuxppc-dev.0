Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31FEE1A03BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 17:16:50 +1000 (AEST)
Received: by pawu10 with SMTP id u10so134145197paw.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 00:16:48 -0700 (PDT)
Subject: Re: [PATCH v6 05/42] powerpc/powernv: Track IO/M32/M64 segments from
 PE
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-6-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com, panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C84FD8.302@ozlabs.ru>
Date: Mon, 10 Aug 2015 17:16:40 +1000
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-6-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/2015 02:11 PM, Gavin Shan wrote:
> The patch is adding 6 bitmaps, three to PE and three to PHB, to track

The patch is also removing 2 arrays (io_segmap and m32_segmap), what is 
that all about? Also, there was no m64_segmap, now there is, needs an 
explanation may be.


> the consumed by one particular PE, which can be released once the PE
> is destroyed during PCI unplugging time. Also, we're using fixed
> quantity of bits to trace the used IO, M32 and M64 segments by PEs
> in one particular PHB.
>

Out of curiosity - have you considered having just 3 arrays, in PHB, 
storing PE numbers, and ditching PE's arrays? Does PE itself need to know 
what PEs it is using? Not sure about this master/slave PEs though.

It would be easier to read patches if this one was right before
[PATCH v6 23/42] powerpc/powernv: Release PEs dynamically



> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 29 +++++++++++++++--------------
>   arch/powerpc/platforms/powernv/pci.h      | 18 ++++++++++++++----
>   2 files changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index e4ac703..78b49a1 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -388,6 +388,12 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>   			list_add_tail(&pe->list, &master_pe->slaves);
>   		}
>
> +		/* M64 segments consumed by slave PEs are tracked
> +		 * by master PE
> +		 */
> +		set_bit(pe->pe_number, master_pe->m64_segmap);
> +		set_bit(pe->pe_number, phb->ioda.m64_segmap);
> +
>   		/* P7IOC supports M64DT, which helps mapping M64 segment
>   		 * to one particular PE#. However, PHB3 has fixed mapping
>   		 * between M64 segment and PE#. In order to have same logic
> @@ -2871,9 +2877,11 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>
>   			while (index < phb->ioda.total_pe &&
>   			       region.start <= region.end) {
> -				phb->ioda.io_segmap[index] = pe->pe_number;
> +				set_bit(index, pe->io_segmap);
> +				set_bit(index, phb->ioda.io_segmap);
>   				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> -					pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
> +					pe->pe_number, OPAL_IO_WINDOW_TYPE,
> +					0, index);

Unrelated change.


>   				if (rc != OPAL_SUCCESS) {
>   					pr_err("%s: OPAL error %d when mapping IO "
>   					       "segment #%d to PE#%d\n",
> @@ -2896,9 +2904,11 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>
>   			while (index < phb->ioda.total_pe &&
>   			       region.start <= region.end) {
> -				phb->ioda.m32_segmap[index] = pe->pe_number;
> +				set_bit(index, pe->m32_segmap);
> +				set_bit(index, phb->ioda.m32_segmap);
>   				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> -					pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
> +					pe->pe_number, OPAL_M32_WINDOW_TYPE,
> +					0, index);

Unrelated change.


>   				if (rc != OPAL_SUCCESS) {
>   					pr_err("%s: OPAL error %d when mapping M32 "
>   					       "segment#%d to PE#%d",
> @@ -3090,7 +3100,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   {
>   	struct pci_controller *hose;
>   	struct pnv_phb *phb;
> -	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
> +	unsigned long size, pemap_off;
>   	const __be64 *prop64;
>   	const __be32 *prop32;
>   	int len;
> @@ -3175,19 +3185,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>
>   	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */


This comment came with if(IODA1) below, since you are removing the 
condition below, makes sense to remove the comment as well or move it where 
people will look for it (arch/powerpc/platforms/powernv/pci.h ?)


>   	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
> -	m32map_off = size;
> -	size += phb->ioda.total_pe * sizeof(phb->ioda.m32_segmap[0]);
> -	if (phb->type == PNV_PHB_IODA1) {
> -		iomap_off = size;
> -		size += phb->ioda.total_pe * sizeof(phb->ioda.io_segmap[0]);
> -	}
>   	pemap_off = size;
>   	size += phb->ioda.total_pe * sizeof(struct pnv_ioda_pe);
>   	aux = memblock_virt_alloc(size, 0);


After adding static arrays to PE and PHB, do you still need this "aux"?


>   	phb->ioda.pe_alloc = aux;
> -	phb->ioda.m32_segmap = aux + m32map_off;
> -	if (phb->type == PNV_PHB_IODA1)
> -		phb->ioda.io_segmap = aux + iomap_off;
>   	phb->ioda.pe_array = aux + pemap_off;
>   	set_bit(phb->ioda.reserved_pe, phb->ioda.pe_alloc);
>
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 62239b1..08a4e57 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -49,6 +49,15 @@ struct pnv_ioda_pe {
>   	/* PE number */
>   	unsigned int		pe_number;
>
> +	/* IO/M32/M64 segments consumed by the PE. Each PE can
> +	 * have one M64 segment at most, but M64 segments consumed
> +	 * by slave PEs will be contributed to the master PE. One
> +	 * PE can own multiple IO and M32 segments.


A PE can have multiple IO and M32 segments but just one M64 segment? Is 
this correct for IODA1 or IODA2 or both? Is this a limitation of this 
implementation or it comes from P7IOC/PHB3 hardware?


> +	 */
> +	unsigned long		io_segmap[8];
> +	unsigned long		m32_segmap[8];
> +	unsigned long		m64_segmap[8];

Magic constant "8", 64bit*8 = 512 PEs - where did this come from?

Anyway,

#define PNV_IODA_MAX_PE_NUM	512

unsigned long io_segmap[PNV_IODA_MAX_PE_NUM/BITS_PER_LONG]




> +
>   	/* "Weight" assigned to the PE for the sake of DMA resource
>   	 * allocations
>   	 */
> @@ -145,15 +154,16 @@ struct pnv_phb {
>   			unsigned int		io_segsize;
>   			unsigned int		io_pci_base;
>
> +			/* IO, M32, M64 segment maps */
> +			unsigned long		io_segmap[8];
> +			unsigned long		m32_segmap[8];
> +			unsigned long		m64_segmap[8];
> +
>   			/* PE allocation */
>   			struct mutex		pe_alloc_mutex;
>   			unsigned long		*pe_alloc;
>   			struct pnv_ioda_pe	*pe_array;
>
> -			/* M32 & IO segment maps */
> -			unsigned int		*m32_segmap;
> -			unsigned int		*io_segmap;
> -
>   			/* IRQ chip */
>   			int			irq_chip_init;
>   			struct irq_chip		irq_chip;
>


-- 
Alexey
