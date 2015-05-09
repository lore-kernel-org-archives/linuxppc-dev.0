Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D3971A0E09
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2015 20:53:46 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so70736300pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2015 03:53:44 -0700 (PDT)
Message-ID: <554DE732.5060002@ozlabs.ru>
Date: Sat, 09 May 2015 20:53:38 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 04/21] powerpc/powernv: Improve IO and M32 mapping
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-5-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/01/2015 04:02 PM, Gavin Shan wrote:
> The PHB's IO or M32 window is divided evenly to segments, each of
> them can be mapped to arbitrary PE# by IODT or M32DT. Current code
> figures out the consumed IO and M32 segments by one particular PE
> from the windows of the PE's upstream bridge. It won't be reliable
> once we extend M64 windows of root port, or the upstream port of
> the PCIE switch behind root port to PHB's IO or M32 window, in order
> to support PCI hotplug in future.
>
> The patch improves pnv_ioda_setup_pe_seg() to calculate PE's consumed
> IO or M32 segments from its contained devices, no bridge involved any
> more. Also, the logic to mapping IO and M32 segments are combined to
> simplify the code. Besides, it's always worthy to trace the IO and M32
> segments consumed by one PE, which can be released at PCI unplugging
> time.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 150 ++++++++++++++++--------------
>   arch/powerpc/platforms/powernv/pci.h      |  13 +--
>   2 files changed, 85 insertions(+), 78 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index a994882..7e6e266 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2543,77 +2543,92 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>   }
>   #endif /* CONFIG_PCI_IOV */
>
> -/*
> - * This function is supposed to be called on basis of PE from top
> - * to bottom style. So the the I/O or MMIO segment assigned to
> - * parent PE could be overrided by its child PEs if necessary.
> - */
> -static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
> -				  struct pnv_ioda_pe *pe)
> +static int pnv_ioda_map_pe_one_res(struct pci_controller *hose,
> +				   struct pnv_ioda_pe *pe,
> +				   struct resource *res)
>   {
>   	struct pnv_phb *phb = hose->private_data;
>   	struct pci_bus_region region;
> -	struct resource *res;
> -	int i, index;
> -	int rc;
> +	unsigned int segsize, index;
> +	unsigned long *segmap, *pe_segmap;
> +	uint16_t win_type;
> +	int64_t rc;
>
> -	/*
> -	 * NOTE: We only care PCI bus based PE for now. For PCI
> -	 * device based PE, for example SRIOV sensitive VF should
> -	 * be figured out later.
> -	 */
> -	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
> +	/* Check if we need map the resource */
> +	if (!res->parent || !res->flags ||
> +	    res->start > res->end ||
> +	    pnv_pci_is_mem_pref_64(res->flags))
> +		return 0;
>
> -	pci_bus_for_each_resource(pe->pbus, res, i) {
> -		if (!res || !res->flags ||
> -		    res->start > res->end)
> -			continue;
> +	if (res->flags & IORESOURCE_IO) {
> +		segmap = phb->ioda.io_segmap;
> +		pe_segmap = pe->io_segmap;
> +		region.start = res->start - phb->ioda.io_pci_base;
> +		region.end = res->end - phb->ioda.io_pci_base;
> +		segsize = phb->ioda.io_segsize;
> +		win_type = OPAL_IO_WINDOW_TYPE;
> +	} else {
> +		segmap = phb->ioda.m32_segmap;
> +		pe_segmap = pe->m32_segmap;
> +		region.start = res->start -
> +			       hose->mem_offset[0] -
> +			       phb->ioda.m32_pci_base;
> +		region.end = res->end -
> +			     hose->mem_offset[0] -
> +			     phb->ioda.m32_pci_base;
> +		segsize = phb->ioda.m32_segsize;
> +		win_type = OPAL_M32_WINDOW_TYPE;
> +	}
> +
> +	index = region.start / segsize;
> +	while (index < phb->ioda.total_pe &&
> +	       region.start <= region.end) {
> +		rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> +				pe->pe_number, win_type, 0, index);
> +		if (rc != OPAL_SUCCESS) {
> +			pr_warn("%s: Error %lld mapping (%d) seg#%d to PE#%d\n",
> +				__func__, rc, win_type, index, pe->pe_number);
> +			return -EIO;
> +		}
>
> -		if (res->flags & IORESOURCE_IO) {
> -			region.start = res->start - phb->ioda.io_pci_base;
> -			region.end   = res->end - phb->ioda.io_pci_base;
> -			index = region.start / phb->ioda.io_segsize;
> +		set_bit(index, segmap);
> +		set_bit(index, pe_segmap);
> +		region.start += segsize;
> +		index++;
> +	}
>
> -			while (index < phb->ioda.total_pe &&
> -			       region.start <= region.end) {
> -				phb->ioda.io_segmap[index] = pe->pe_number;
> -				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> -					pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
> -				if (rc != OPAL_SUCCESS) {
> -					pr_err("%s: OPAL error %d when mapping IO "
> -					       "segment #%d to PE#%d\n",
> -					       __func__, rc, index, pe->pe_number);
> -					break;
> -				}
> +	return 0;
> +}
>
> -				region.start += phb->ioda.io_segsize;
> -				index++;
> -			}
> -		} else if ((res->flags & IORESOURCE_MEM) &&
> -			   !pnv_pci_is_mem_pref_64(res->flags)) {
> -			region.start = res->start -
> -				       hose->mem_offset[0] -
> -				       phb->ioda.m32_pci_base;
> -			region.end   = res->end -
> -				       hose->mem_offset[0] -
> -				       phb->ioda.m32_pci_base;
> -			index = region.start / phb->ioda.m32_segsize;
> -
> -			while (index < phb->ioda.total_pe &&
> -			       region.start <= region.end) {
> -				phb->ioda.m32_segmap[index] = pe->pe_number;
> -				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> -					pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
> -				if (rc != OPAL_SUCCESS) {
> -					pr_err("%s: OPAL error %d when mapping M32 "
> -					       "segment#%d to PE#%d",
> -					       __func__, rc, index, pe->pe_number);
> -					break;
> -				}
> +static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
> +				  struct pnv_ioda_pe *pe)
> +{
> +	struct pci_dev *pdev;
> +	struct resource *res;
> +	int i;
>
> -				region.start += phb->ioda.m32_segsize;
> -				index++;
> -			}
> +	/* This function only works for bus dependent PE */
> +	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
> +
> +	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
> +		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> +			res = &pdev->resource[i];
> +			if (pnv_ioda_map_pe_one_res(hose, pe, res))
> +				return;
> +		}
> +
> +		/* If the PE contains all subordinate PCI buses, the
> +		 * resources of the child bridges should be mapped
> +		 * to the PE as well.
> +		 */
> +		if (!(pe->flags & PNV_IODA_PE_BUS_ALL) ||
> +		    (pdev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
> +			continue;
> +
> +		for (i = 0; i <= PCI_BRIDGE_RESOURCE_NUM; i++) {
> +			res = &pdev->resource[PCI_BRIDGE_RESOURCES + i];
> +			if (pnv_ioda_map_pe_one_res(hose, pe, res))
> +				return;


This chunk is really hard to review. Looks like you completely 
reimplemented the function instead of patching it. For review-ability and 
bisect-ability it would help to split it to several simpler patches.



>   		}
>   	}
>   }
> @@ -2780,7 +2795,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   {
>   	struct pci_controller *hose;
>   	struct pnv_phb *phb;
> -	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
> +	unsigned long size, pemap_off;
>   	const __be64 *prop64;
>   	const __be32 *prop32;
>   	int len;
> @@ -2865,19 +2880,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>
>   	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
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
>   	phb->ioda.pe_alloc = aux;
> -	phb->ioda.m32_segmap = aux + m32map_off;
> -	if (phb->type == PNV_PHB_IODA1)
> -		phb->ioda.io_segmap = aux + iomap_off;
>   	phb->ioda.pe_array = aux + pemap_off;
>   	set_bit(phb->ioda.reserved_pe, phb->ioda.pe_alloc);
>
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 19022cf..f604bb7 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -54,6 +54,8 @@ struct pnv_ioda_pe {
>   	 * by slave PEs will be contributed to the master PE. One
>   	 * PE can own multiple IO and M32 segments.
>   	 */
> +	unsigned long		io_segmap[8];
> +	unsigned long		m32_segmap[8];
>   	unsigned long		m64_segmap[8];
>
>   	/* "Weight" assigned to the PE for the sake of DMA resource
> @@ -154,16 +156,15 @@ struct pnv_phb {
>   			unsigned int		io_segsize;
>   			unsigned int		io_pci_base;
>
> -			/* PE allocation bitmap */
> +			/* PE allocation */
> +			struct pnv_ioda_pe	*pe_array;
>   			unsigned long		*pe_alloc;
> -			/* PE allocation mutex */
>   			struct mutex		pe_alloc_mutex;
>
> -			/* M32 & IO segment maps */
> +			/* IO/M32/M64 segment bitmaps */
> +			unsigned long		io_segmap[8];
> +			unsigned long		m32_segmap[8];
>   			unsigned long		m64_segmap[8];


Is this a copy of the same name fields above, in pnv_ioda_pe? Why 8?


> -			unsigned int		*m32_segmap;
> -			unsigned int		*io_segmap;
> -			struct pnv_ioda_pe	*pe_array;
>

Why moved this?


>   			/* IRQ chip */
>   			int			irq_chip_init;
>


-- 
Alexey
