Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B05D1A0CDB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 20:02:31 +1000 (AEST)
Received: by pdbfa8 with SMTP id fa8so29814807pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 03:02:29 -0700 (PDT)
Subject: Re: [PATCH v6 15/42] powerpc/powernv: PE oriented during configuration
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-16-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com, panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C876AC.5060205@ozlabs.ru>
Date: Mon, 10 Aug 2015 20:02:20 +1000
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-16-git-send-email-gwshan@linux.vnet.ibm.com>
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
> Several functions used to configure PE take pe_number to indentify
> PE instance. As the pe_number is included in PE instance after it
> is reserved or allocated. It's convienent for those functions to
> return PE instance which includes the required pe_number.

This is a description for the half of the patch but this patch also adds a 
return value to functions which did not have it before and I am not sure 
you need all of them to return something. It would be cleaner if you added 
"return" when/where you really need it, not just because it seems that it 
may be convenient later.


>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 51 ++++++++++++++++---------------
>   arch/powerpc/platforms/powernv/pci.h      |  2 +-
>   2 files changed, 27 insertions(+), 26 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 3094c61..9f53682 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -132,12 +132,12 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
>   		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
>   }
>
> -static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
> +static struct pnv_ioda_pe *pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>   {
>   	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe)) {
>   		pr_warn("%s: Invalid PE %d on PHB#%x\n",
>   			__func__, pe_no, phb->hose->global_number);
> -		return;
> +		return NULL;
>   	}
>
>   	if (test_and_set_bit(pe_no, phb->ioda.pe_alloc))
> @@ -146,9 +146,11 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>
>   	phb->ioda.pe_array[pe_no].phb = phb;
>   	phb->ioda.pe_array[pe_no].pe_number = pe_no;
> +
> +	return &phb->ioda.pe_array[pe_no];
>   }
>
> -static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
> +static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
>   {
>   	unsigned long pe;
>
> @@ -156,12 +158,12 @@ static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
>   		pe = find_next_zero_bit(phb->ioda.pe_alloc,
>   					phb->ioda.total_pe, 0);
>   		if (pe >= phb->ioda.total_pe)
> -			return IODA_INVALID_PE;
> +			return NULL;
>   	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
>
>   	phb->ioda.pe_array[pe].phb = phb;
>   	phb->ioda.pe_array[pe].pe_number = pe;
> -	return pe;
> +	return &phb->ioda.pe_array[pe];
>   }
>
>   static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
> @@ -334,7 +336,7 @@ static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
>   	}
>   }
>
> -static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
> +static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>   {
>   	struct pci_controller *hose = pci_bus_to_host(bus);
>   	struct pnv_phb *phb = hose->private_data;
> @@ -344,7 +346,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>
>   	/* Root bus shouldn't use M64 */
>   	if (pci_is_root_bus(bus))
> -		return IODA_INVALID_PE;
> +		return NULL;
>
>   	/* Allocate bitmap */
>   	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
> @@ -352,7 +354,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>   	if (!pe_alloc) {
>   		pr_warn("%s: Out of memory !\n",
>   			__func__);
> -		return IODA_INVALID_PE;
> +		return NULL;
>   	}
>
>   	/* Figure out reserved PE numbers by the PE */
> @@ -365,7 +367,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>   	 */
>   	if (bitmap_empty(pe_alloc, phb->ioda.total_pe)) {
>   		kfree(pe_alloc);
> -		return IODA_INVALID_PE;
> +		return NULL;
>   	}
>
>   	/*
> @@ -416,7 +418,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>   	}
>
>   	kfree(pe_alloc);
> -	return master_pe->pe_number;
> +	return master_pe;
>   }
>
>   static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
> @@ -1069,28 +1071,26 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
>    * subordinate PCI devices and buses. The second type of PE is normally
>    * orgiriated by PCIe-to-PCI bridge or PLX switch downstream ports.
>    */
> -static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
> +static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>   {
>   	struct pci_controller *hose = pci_bus_to_host(bus);
>   	struct pnv_phb *phb = hose->private_data;
> -	struct pnv_ioda_pe *pe;
> -	int pe_num = IODA_INVALID_PE;
> +	struct pnv_ioda_pe *pe = NULL;
>
>   	/* Check if PE is determined by M64 */
>   	if (phb->pick_m64_pe)
> -		pe_num = phb->pick_m64_pe(bus, all);
> +		pe = phb->pick_m64_pe(bus, all);
>
>   	/* The PE number isn't pinned by M64 */
> -	if (pe_num == IODA_INVALID_PE)
> -		pe_num = pnv_ioda_alloc_pe(phb);
> +	if (!pe)
> +		pe = pnv_ioda_alloc_pe(phb);
>
> -	if (pe_num == IODA_INVALID_PE) {
> -		pr_warning("%s: Not enough PE# available for PCI bus %04x:%02x\n",
> +	if (!pe) {
> +		pr_warning("%s: No enough PE# for PCI bus %04x:%02x\n",
>   			__func__, pci_domain_nr(bus), bus->number);
> -		return;
> +		return NULL;
>   	}
>
> -	pe = &phb->ioda.pe_array[pe_num];
>   	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
>   	pe->pbus = bus;
>   	pe->pdev = NULL;
> @@ -1101,17 +1101,16 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>
>   	if (all)
>   		pe_info(pe, "Secondary bus %d..%d associated with PE#%d\n",
> -			bus->busn_res.start, bus->busn_res.end, pe_num);
> +			bus->busn_res.start, bus->busn_res.end, pe->pe_number);
>   	else
>   		pe_info(pe, "Secondary bus %d associated with PE#%d\n",
> -			bus->busn_res.start, pe_num);
> +			bus->busn_res.start, pe->pe_number);
>
>   	if (pnv_ioda_configure_pe(phb, pe)) {
>   		/* XXX What do we do here ? */
> -		if (pe_num)
> -			pnv_ioda_free_pe(phb, pe_num);
> +		pnv_ioda_free_pe(phb, pe->pe_number);
>   		pe->pbus = NULL;
> -		return;
> +		return NULL;
>   	}
>
>   	/* Associate it with all child devices */
> @@ -1122,6 +1121,8 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>
>   	/* Link the PE */
>   	pnv_ioda_link_pe_by_weight(phb, pe);
> +
> +	return pe;
>   }
>
>   static void pnv_ioda_setup_PEs(struct pci_bus *bus)
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 6f8568e..c0bc57f 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -121,7 +121,7 @@ struct pnv_phb {
>   	int (*init_m64)(struct pnv_phb *phb);
>   	void (*reserve_m64_pe)(struct pci_bus *bus,
>   			       unsigned long *pe_bitmap, bool all);
> -	int (*pick_m64_pe)(struct pci_bus *bus, bool all);
> +	struct pnv_ioda_pe* (*pick_m64_pe)(struct pci_bus *bus, bool all);
>   	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
>   	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
>   	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
>


-- 
Alexey
