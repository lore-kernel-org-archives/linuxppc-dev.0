Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 262281A03BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 17:40:22 +1000 (AEST)
Received: by pdbfa8 with SMTP id fa8so28461197pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 00:40:20 -0700 (PDT)
Subject: Re: [PATCH v6 07/42] powerpc/powernv: Improve IO and M32 mapping
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-8-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com, panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C85558.2050300@ozlabs.ru>
Date: Mon, 10 Aug 2015 17:40:08 +1000
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-8-git-send-email-gwshan@linux.vnet.ibm.com>
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
> There're 3 windows (IO, M32 and M64) for PHB, root port and upstream

These are actually IO, non-prefetchable and prefetchable windows which 
happen to be IO, 32bit and 64bit windows but this has nothing to do with 
the M32/M64 BAR registers in P7IOC/PHB3, do I understand this correctly?


> port of the PCIE switch behind root port. In order to support PCI
> hotplug, we extend the start/end address of those 3 windows of root
> port or upstream port to the start/end address of the 3 PHB's windows.
> The current implementation, assigning IO or M32 segment based on the
> bridge's windows, isn't reliable.
>
> The patch fixes above issue by calculating PE's consumed IO or M32
> segments from its contained devices, no PCI bridge windows involved
> if the PE doesn't contain all the subordinate PCI buses.

Please, rephrase it. How can PCI bridges be involved in PE consumption?


> Otherwise,
> the PCI bridge windows still contribute to PE's consumed IO or M32
> segments.

PCI bridge windows themselves consume PEs? Is that correct?


>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 136 +++++++++++++++++-------------
>   1 file changed, 79 insertions(+), 57 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 488a53e..713f4b4 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2844,75 +2844,97 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
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
> +static int pnv_ioda_setup_one_res(struct pci_controller *hose,
> +				  struct pnv_ioda_pe *pe,
> +				  struct resource *res)
>   {
>   	struct pnv_phb *phb = hose->private_data;
>   	struct pci_bus_region region;
> -	struct resource *res;
> -	int i, index;
> -	unsigned int segsize;
> +	unsigned int index, segsize;
>   	unsigned long *segmap, *pe_segmap;
>   	uint16_t win;
>   	int64_t rc;
>
> -	/*
> -	 * NOTE: We only care PCI bus based PE for now. For PCI
> -	 * device based PE, for example SRIOV sensitive VF should
> -	 * be figured out later.
> -	 */
> -	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
> +	/* Check if we need map the resource */
> +	if (!res->parent || !res->flags || res->start > res->end)

res->start >= res->end ?


> +		return 0;
>
> -	pci_bus_for_each_resource(pe->pbus, res, i) {
> -		if (!res || !res->flags ||
> -		    res->start > res->end)
> -			continue;
> +	if (res->flags & IORESOURCE_IO) {
> +		region.start = res->start - phb->ioda.io_pci_base;
> +		region.end   = res->end - phb->ioda.io_pci_base;
> +		segsize      = phb->ioda.io_segsize;
> +		segmap       = phb->ioda.io_segmap;
> +		pe_segmap    = pe->io_segmap;
> +		win          = OPAL_IO_WINDOW_TYPE;
> +	} else if ((res->flags & IORESOURCE_MEM) &&
> +		   !pnv_pci_is_mem_pref_64(res->flags)) {
> +		region.start = res->start -
> +			       hose->mem_offset[0] -
> +			       phb->ioda.m32_pci_base;
> +		region.end   = res->end -
> +			       hose->mem_offset[0] -
> +			       phb->ioda.m32_pci_base;
> +		segsize      = phb->ioda.m32_segsize;
> +		segmap       = phb->ioda.m32_segmap;
> +		pe_segmap    = pe->m32_segmap;
> +		win          = OPAL_M32_WINDOW_TYPE;
> +	} else {
> +		return 0;
> +	}
>
> -		if (res->flags & IORESOURCE_IO) {
> -			region.start = res->start - phb->ioda.io_pci_base;
> -			region.end   = res->end - phb->ioda.io_pci_base;
> -			segsize      = phb->ioda.io_segsize;
> -			segmap       = phb->ioda.io_segmap;
> -			pe_segmap    = pe->io_segmap;
> -			win          = OPAL_IO_WINDOW_TYPE;
> -		} else if ((res->flags & IORESOURCE_MEM) &&
> -			   !pnv_pci_is_mem_pref_64(res->flags)) {
> -			region.start = res->start -
> -				       hose->mem_offset[0] -
> -				       phb->ioda.m32_pci_base;
> -			region.end   = res->end -
> -				       hose->mem_offset[0] -
> -				       phb->ioda.m32_pci_base;
> -			segsize      = phb->ioda.m32_segsize;
> -			segmap       = phb->ioda.m32_segmap;
> -			pe_segmap    = pe->m32_segmap;
> -			win          = OPAL_M32_WINDOW_TYPE;
> -		} else {
> -			continue;
> +	region.start = _ALIGN_DOWN(region.start, segsize);
> +	region.end   = _ALIGN_UP(region.end, segsize);
> +	index = region.start / segsize;
> +	while (index < phb->ioda.total_pe &&
> +	       region.start < region.end) {
> +		rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> +				pe->pe_number, win, 0, index);
> +		if (rc != OPAL_SUCCESS) {
> +			pr_warn("%s: Error %lld mapping (%d) seg#%d to PHB#%d-PE#%d\n",
> +				__func__, rc, win, index,
> +				pe->phb->hose->global_number,
> +				pe->pe_number);
> +			return -EIO;
>   		}
>
> -		index = region.start / phb->ioda.io_segsize;
> -		while (index < phb->ioda.total_pe &&
> -		       region.start <= region.end) {
> -			set_bit(index, segmap);
> -			set_bit(index, pe_segmap);
> -			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> -					pe->pe_number, win, 0, index);
> -			if (rc != OPAL_SUCCESS) {
> -				pr_warn("%s: Error %lld mapping (%d) seg#%d to PHB#%d-PE#%d\n",
> -					__func__, rc, win, index,
> -					pe->phb->hose->global_number,
> -					pe->pe_number);
> -				break;
> -			}
> +		set_bit(index, segmap);
> +		set_bit(index, pe_segmap);
> +		region.start += segsize;
> +		index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
> +				  struct pnv_ioda_pe *pe)
> +{
> +	struct pci_dev *pdev;
> +	struct resource *res;
> +	int i;
> +
> +	/* This function only works for bus dependent PE */
> +	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
> +
> +	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
> +		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> +			res = &pdev->resource[i];
> +			if (pnv_ioda_setup_one_res(hose, pe, res))
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
>
> -			region.start += segsize;
> -			index++;
> +		for (i = 0; i <= PCI_BRIDGE_RESOURCE_NUM; i++) {
> +			res = &pdev->resource[PCI_BRIDGE_RESOURCES + i];
> +			if (pnv_ioda_setup_one_res(hose, pe, res))
> +				return;
>   		}
>   	}
>   }
>


-- 
Alexey
