Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E3C41A0E05
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2015 20:24:23 +1000 (AEST)
Received: by pdbqd1 with SMTP id qd1so107832954pdb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2015 03:24:21 -0700 (PDT)
Message-ID: <554DE04E.8080900@ozlabs.ru>
Date: Sat, 09 May 2015 20:24:14 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 03/21] powerpc/powernv: M64 support improvement
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-4-git-send-email-gwshan@linux.vnet.ibm.com>
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
> We're having the hardware or enforced (on P7IOC) limitation: M64

I would think if it is enforced, then it is enforced by hardware but you 
say "hardware OR enforced" :)


> segment#x can only be assigned to PE#x. IO and M32 segment can be
> mapped to arbitrary PE# via IODT and M32DT. It means the PE number
> should be x if M64 segment#x has been assigned to the PE. Also, each
> PE own one M64 segment at most. Currently, we are reserving PE#
> according to root port's M64 window. It won't be reliable once we
> extend M64 windows of root port, or the upstream port of the PCIE
> switch behind root port to PHB's M64 window, in order to support
> PCI hotplug in future.
>
> The patch reserves PE# for M64 segments according to the M64 resources
> of the PCI devices (not bridges) contained in the PE. Besides, it's
> always worthy to trace the M64 segments consumed by the PE, which can
> be released at PCI unplugging time.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 190 ++++++++++++++++++------------
>   arch/powerpc/platforms/powernv/pci.h      |  10 +-
>   2 files changed, 122 insertions(+), 78 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 646962f..a994882 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -283,28 +283,78 @@ fail:
>   	return -EIO;
>   }
>
> -static void pnv_ioda_reserve_m64_pe(struct pnv_phb *phb)
> +/* We extend the M64 window of root port, or the upstream bridge port
> + * of the PCIE switch behind root port. So we shouldn't reserve PEs
> + * for M64 resources because there are no (normal) PCI devices consuming

"PCI devices"? Not "root ports or PCI bridges"?

> + * M64 resources on the PCI buses leading from root port, or the upstream
> + * bridge port.The function returns true if the indicated PCI bus needs
> + * reserved PEs because of M64 resources in advance. Otherwise, the
> + * function returns false.
> + */
> +static bool pnv_ioda_need_m64_pe(struct pnv_phb *phb,
> +				 struct pci_bus *bus)
>   {
> -	resource_size_t sgsz = phb->ioda.m64_segsize;
> +	/* Root bus */

The comment is too obvious as the call below is called "pci_is_root_bus" :)


> +	if (!bus || pci_is_root_bus(bus))
> +		return false;
> +
> +	/* Bus leading from root port. We need check what types of PCI
> +	 * devices on the bus. If it's connecting PCI bridge, we don't
> +	 * need reserve M64 PEs for it. Otherwise, we still need to do
> +	 * that.
> +	 */
> +	if (pci_is_root_bus(bus->self->bus)) {
> +		struct pci_dev *pdev;
> +
> +		list_for_each_entry(pdev, &bus->devices, bus_list) {
> +			if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL)
> +				return true;
> +		}
> +
> +		return false;
> +	}
> +
> +	/* Bus leading from the upstream bridge port on top level */
> +	if (pci_is_root_bus(bus->self->bus->self->bus))


Is it for second level bridges? Like root->bridge->bridge? And for 3 levels 
you will need a PE?


> +		return false;
> +
> +	return true;
> +}
> +
> +static void pnv_ioda_reserve_m64_pe(struct pnv_phb *phb,
> +				    struct pci_bus *bus)
> +{
> +	resource_size_t segsz = phb->ioda.m64_segsize;
>   	struct pci_dev *pdev;
>   	struct resource *r;
> -	int base, step, i;
> +	unsigned long pe_no, limit;
> +	int i;
>
> -	/*
> -	 * Root bus always has full M64 range and root port has
> -	 * M64 range used in reality. So we're checking root port
> -	 * instead of root bus.
> +	if (!pnv_ioda_need_m64_pe(phb, bus))
> +		return;
> +
> +	/* The bridge's M64 window might have been extended to the
> +	 * PHB's M64 window in order to support PCI hotplug. So the
> +	 * bridge's M64 window isn't reliable to be used for picking
> +	 * PE# for its leading PCI bus. We have to check the M64
> +	 * resources consumed by the PCI devices, which seat on the
> +	 * PCI bus.
>   	 */
> -	list_for_each_entry(pdev, &phb->hose->bus->devices, bus_list) {
> -		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
> -			r = &pdev->resource[PCI_BRIDGE_RESOURCES + i];
> -			if (!r->parent ||
> -			    !pnv_pci_is_mem_pref_64(r->flags))
> +	list_for_each_entry(pdev, &bus->devices, bus_list) {
> +		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +#ifdef CONFIG_PCI_IOV
> +			if (i >= PCI_IOV_RESOURCES && i <= PCI_IOV_RESOURCE_END)
> +				continue;
> +#endif
> +			r = &pdev->resource[i];
> +			if (!r->flags || r->start >= r->end ||
> +			    !r->parent || !pnv_pci_is_mem_pref_64(r->flags))
>   				continue;
>
> -			base = (r->start - phb->ioda.m64_base) / sgsz;
> -			for (step = 0; step < resource_size(r) / sgsz; step++)
> -				pnv_ioda_reserve_pe(phb, base + step);
> +			pe_no = (r->start - phb->ioda.m64_base) / segsz;
> +			limit = ALIGN(r->end - phb->ioda.m64_base, segsz) / segsz;
> +			for (; pe_no < limit; pe_no++)
> +				pnv_ioda_reserve_pe(phb, pe_no);
>   		}
>   	}
>   }
> @@ -316,85 +366,64 @@ static int pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
>   	struct pci_dev *pdev;
>   	struct resource *r;
>   	struct pnv_ioda_pe *master_pe, *pe;
> -	unsigned long size, *pe_alloc;
> -	bool found;
> -	int start, i, j;
> -
> -	/* Root bus shouldn't use M64 */
> -	if (pci_is_root_bus(bus))
> -		return IODA_INVALID_PE;
> -
> -	/* We support only one M64 window on each bus */
> -	found = false;
> -	pci_bus_for_each_resource(bus, r, i) {
> -		if (r && r->parent &&
> -		    pnv_pci_is_mem_pref_64(r->flags)) {
> -			found = true;
> -			break;
> -		}
> -	}
> +	unsigned long size, *pe_bitsmap;

s/pe_bitsmap/pe_bitmap/


> +	unsigned long pe_no, limit;
> +	int i;
>
> -	/* No M64 window found ? */
> -	if (!found)
> +	if (!pnv_ioda_need_m64_pe(phb, bus))
>   		return IODA_INVALID_PE;
>
> -	/* Allocate bitmap */
> +        /* Allocate bitmap */
>   	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
> -	pe_alloc = kzalloc(size, GFP_KERNEL);
> -	if (!pe_alloc) {
> -		pr_warn("%s: Out of memory !\n",
> -			__func__);
> +	pe_bitsmap = kzalloc(size, GFP_KERNEL);
> +	if (!pe_bitsmap) {
> +		pr_warn("%s: Out of memory !\n", __func__);
>   		return IODA_INVALID_PE;
>   	}
>
> -	/*
> -	 * Figure out reserved PE numbers by the PE
> -	 * the its child PEs.
> -	 */
> -	start = (r->start - phb->ioda.m64_base) / segsz;
> -	for (i = 0; i < resource_size(r) / segsz; i++)
> -		set_bit(start + i, pe_alloc);
> -
> -	if (all)
> -		goto done;
> -
> -	/*
> -	 * If the PE doesn't cover all subordinate buses,
> -	 * we need subtract from reserved PEs for children.
> +	/* The bridge's M64 window might be extended to PHB's M64
> +	 * window by intention to support PCI hotplug. So we have
> +	 * to check the M64 resources consumed by the PCI devices
> +	 * on the PCI bus.
>   	 */
>   	list_for_each_entry(pdev, &bus->devices, bus_list) {
> -		if (!pdev->subordinate)
> -			continue;
> +		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +#ifdef CONFIG_PCI_IOV
> +			if (i >= PCI_IOV_RESOURCES &&
> +			    i <= PCI_IOV_RESOURCE_END)
> +				continue;
> +#endif
> +			/* Don't scan bridge's window if the PE
> +			 * doesn't contain its subordinate bus.
> +			 */
> +			if (!all && i >= PCI_BRIDGE_RESOURCES &&
> +			    i <= PCI_BRIDGE_RESOURCE_END)
> +				continue;
>
> -		pci_bus_for_each_resource(pdev->subordinate, r, i) {
> -			if (!r || !r->parent ||
> -			    !pnv_pci_is_mem_pref_64(r->flags))
> +			r = &pdev->resource[i];
> +			if (!r->flags || r->start >= r->end ||
> +			    !r->parent || !pnv_pci_is_mem_pref_64(r->flags))
>   				continue;
>
> -			start = (r->start - phb->ioda.m64_base) / segsz;
> -			for (j = 0; j < resource_size(r) / segsz ; j++)
> -				clear_bit(start + j, pe_alloc);
> -                }
> -        }
> +			pe_no = (r->start - phb->ioda.m64_base) / segsz;
> +			limit = ALIGN(r->end - phb->ioda.m64_base, segsz) / segsz;
> +			for (; pe_no < limit; pe_no++)
> +				set_bit(pe_no, pe_bitsmap);
> +		}
> +	}
>
> -	/*
> -	 * the current bus might not own M64 window and that's all
> -	 * contributed by its child buses. For the case, we needn't
> -	 * pick M64 dependent PE#.
> -	 */
> -	if (bitmap_empty(pe_alloc, phb->ioda.total_pe)) {
> -		kfree(pe_alloc);
> +	/* No M64 window found ? */
> +	if (bitmap_empty(pe_bitsmap, phb->ioda.total_pe)) {
> +		kfree(pe_bitsmap);
>   		return IODA_INVALID_PE;
>   	}
>
> -	/*
> -	 * Figure out the master PE and put all slave PEs to master
> -	 * PE's list to form compound PE.
> +	/* Figure out the master PE and put all slave PEs
> +	 * to master PE's list to form compound PE.
>   	 */
> -done:
>   	master_pe = NULL;
>   	i = -1;
> -	while ((i = find_next_bit(pe_alloc, phb->ioda.total_pe, i + 1)) <
> +	while ((i = find_next_bit(pe_bitsmap, phb->ioda.total_pe, i + 1)) <
>   		phb->ioda.total_pe) {
>   		pe = &phb->ioda.pe_array[i];
>
> @@ -408,6 +437,13 @@ done:
>   			list_add_tail(&pe->list, &master_pe->slaves);
>   		}
>
> +		/* Pick the M64 segment, which should be available. Also,

test_and_set_bit() does not pick or choose, it just marks PE#pe_number used.

> +		 * those M64 segments consumed by slave PEs are contributed
> +		 * to the master PE.
> +		 */
> +		BUG_ON(test_and_set_bit(pe->pe_number, phb->ioda.m64_segmap));
> +		BUG_ON(test_and_set_bit(pe->pe_number, master_pe->m64_segmap));
> +
>   		/* P7IOC supports M64DT, which helps mapping M64 segment
>   		 * to one particular PE#. Unfortunately, PHB3 has fixed
>   		 * mapping between M64 segment and PE#. In order for same
> @@ -431,7 +467,7 @@ done:
>   		}
>   	}
>
> -	kfree(pe_alloc);
> +	kfree(pe_bitsmap);
>   	return master_pe->pe_number;
>   }
>
> @@ -1233,7 +1269,7 @@ static void pnv_pci_ioda_setup_PEs(void)
>
>   		/* M64 layout might affect PE allocation */
>   		if (phb->reserve_m64_pe)
> -			phb->reserve_m64_pe(phb);
> +			phb->reserve_m64_pe(phb, phb->hose->bus);
>
>   		pnv_ioda_setup_PEs(hose->bus);
>   	}
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 070ee88..19022cf 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -49,6 +49,13 @@ struct pnv_ioda_pe {
>   	/* PE number */
>   	unsigned int		pe_number;
>
> +	/* IO/M32/M64 segments consumed by the PE. Each PE can
> +	 * have one M64 segment at most, but M64 segments consumed
> +	 * by slave PEs will be contributed to the master PE. One
> +	 * PE can own multiple IO and M32 segments.
> +	 */
> +	unsigned long		m64_segmap[8];


Why 8? 64*8 = 512 segments?  s'8'512/sizeof(unsigned long)' may be?


> +
>   	/* "Weight" assigned to the PE for the sake of DMA resource
>   	 * allocations
>   	 */
> @@ -114,7 +121,7 @@ struct pnv_phb {
>   	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
>   	void (*shutdown)(struct pnv_phb *phb);
>   	int (*init_m64)(struct pnv_phb *phb);
> -	void (*reserve_m64_pe)(struct pnv_phb *phb);
> +	void (*reserve_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus);
>   	int (*pick_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus, int all);
>   	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
>   	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
> @@ -153,6 +160,7 @@ struct pnv_phb {
>   			struct mutex		pe_alloc_mutex;
>
>   			/* M32 & IO segment maps */
> +			unsigned long		m64_segmap[8];
>   			unsigned int		*m32_segmap;
>   			unsigned int		*io_segmap;
>   			struct pnv_ioda_pe	*pe_array;
>


-- 
Alexey
