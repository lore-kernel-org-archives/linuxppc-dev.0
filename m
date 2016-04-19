Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpqJs1PxmzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 12:51:09 +1000 (AEST)
Received: by mail-pf0-x233.google.com with SMTP id c20so1574011pfc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 19:51:09 -0700 (PDT)
Subject: Re: [PATCH v8 19/45] powerpc/powernv: Use PE instead of number during
 setup and release
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-20-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <57159D11.9050808@ozlabs.ru>
Date: Tue, 19 Apr 2016 12:50:57 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-20-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> In current implementation, the PEs that are allocated or picked
> from the reserved list are identified by PE number. The PE instance
> has to be picked according to the PE number eventually. We have
> same issue when PE is released.
>
> For pnv_ioda_pick_m64_pe() and pnv_ioda_alloc_pe(), this returns
> PE instance so that pnv_ioda_setup_bus_PE() can use the allocated
> or reserved PE instance directly. Also, pnv_ioda_setup_bus_PE()
> returns the reserved/allocated PE instance to be used in subsequent
> patches. On the other hand, pnv_ioda_free_pe() uses PE instance
> (not number) as its argument. No logical changes introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 104 +++++++++++++++++-------------
>   arch/powerpc/platforms/powernv/pci.h      |   2 +-
>   2 files changed, 59 insertions(+), 47 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 7800897..f182ca7 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -119,6 +119,14 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
>   		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
>   }
>
> +static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
> +{
> +	phb->ioda.pe_array[pe_no].phb = phb;
> +	phb->ioda.pe_array[pe_no].pe_number = pe_no;
> +
> +	return &phb->ioda.pe_array[pe_no];
> +}
> +
>   static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>   {
>   	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe_num)) {
> @@ -131,11 +139,10 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>   		pr_debug("%s: PE %d was reserved on PHB#%x\n",
>   			 __func__, pe_no, phb->hose->global_number);
>
> -	phb->ioda.pe_array[pe_no].phb = phb;
> -	phb->ioda.pe_array[pe_no].pe_number = pe_no;
> +	pnv_ioda_init_pe(phb, pe_no);
>   }
>
> -static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
> +static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
>   {
>   	unsigned long pe;
>
> @@ -143,20 +150,20 @@ static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
>   		pe = find_next_zero_bit(phb->ioda.pe_alloc,
>   					phb->ioda.total_pe_num, 0);
>   		if (pe >= phb->ioda.total_pe_num)
> -			return IODA_INVALID_PE;
> +			return NULL;
>   	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
>
> -	phb->ioda.pe_array[pe].phb = phb;
> -	phb->ioda.pe_array[pe].pe_number = pe;
> -	return pe;
> +	return pnv_ioda_init_pe(phb, pe);
>   }
>
> -static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
> +static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe)
>   {
> -	WARN_ON(phb->ioda.pe_array[pe].pdev);
> +	struct pnv_phb *phb = pe->phb;
>
> -	memset(&phb->ioda.pe_array[pe], 0, sizeof(struct pnv_ioda_pe));
> -	clear_bit(pe, phb->ioda.pe_alloc);
> +	WARN_ON(pe->pdev);
> +
> +	memset(pe, 0, sizeof(struct pnv_ioda_pe));
> +	clear_bit(pe->pe_number, phb->ioda.pe_alloc);
>   }
>
>   /* The default M64 BAR is shared by all PEs */
> @@ -316,7 +323,7 @@ static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
>   	}
>   }
>
> -static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
> +static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>   {
>   	struct pci_controller *hose = pci_bus_to_host(bus);
>   	struct pnv_phb *phb = hose->private_data;
> @@ -326,7 +333,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>
>   	/* Root bus shouldn't use M64 */
>   	if (pci_is_root_bus(bus))
> -		return IODA_INVALID_PE;
> +		return NULL;
>
>   	/* Allocate bitmap */
>   	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
> @@ -334,7 +341,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>   	if (!pe_alloc) {
>   		pr_warn("%s: Out of memory !\n",
>   			__func__);
> -		return IODA_INVALID_PE;
> +		return NULL;
>   	}
>
>   	/* Figure out reserved PE numbers by the PE */
> @@ -347,7 +354,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>   	 */
>   	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num)) {
>   		kfree(pe_alloc);
> -		return IODA_INVALID_PE;
> +		return NULL;
>   	}
>
>   	/*
> @@ -393,7 +400,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>   	}
>
>   	kfree(pe_alloc);
> -	return master_pe->pe_number;
> +	return master_pe;
>   }
>
>   static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
> @@ -959,7 +966,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
>   	struct pnv_phb *phb = hose->private_data;
>   	struct pci_dn *pdn = pci_get_pdn(dev);
>   	struct pnv_ioda_pe *pe;
> -	int pe_num;
>
>   	if (!pdn) {
>   		pr_err("%s: Device tree node not associated properly\n",
> @@ -969,8 +975,8 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
>   	if (pdn->pe_number != IODA_INVALID_PE)
>   		return NULL;
>
> -	pe_num = pnv_ioda_alloc_pe(phb);
> -	if (pe_num == IODA_INVALID_PE) {
> +	pe = pnv_ioda_alloc_pe(phb);
> +	if (!pe) {
>   		pr_warning("%s: Not enough PE# available, disabling device\n",
>   			   pci_name(dev));
>   		return NULL;
> @@ -983,10 +989,9 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
>   	 *
>   	 * At some point we want to remove the PDN completely anyways
>   	 */
> -	pe = &phb->ioda.pe_array[pe_num];
>   	pci_dev_get(dev);
>   	pdn->pcidev = dev;
> -	pdn->pe_number = pe_num;
> +	pdn->pe_number = pe->pe_number;
>   	pe->flags = PNV_IODA_PE_DEV;
>   	pe->pdev = dev;
>   	pe->pbus = NULL;
> @@ -997,8 +1002,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
>
>   	if (pnv_ioda_configure_pe(phb, pe)) {
>   		/* XXX What do we do here ? */
> -		if (pe_num)
> -			pnv_ioda_free_pe(phb, pe_num);
> +		pnv_ioda_free_pe(pe);
>   		pdn->pe_number = IODA_INVALID_PE;
>   		pe->pdev = NULL;
>   		pci_dev_put(dev);
> @@ -1033,28 +1037,26 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
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
> +	if (!pe) {
>   		pr_warning("%s: Not enough PE# available for PCI bus %04x:%02x\n",
>   			__func__, pci_domain_nr(bus), bus->number);
> -		return;
> +		return NULL;
>   	}
>
> -	pe = &phb->ioda.pe_array[pe_num];
>   	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
>   	pe->pbus = bus;
>   	pe->pdev = NULL;
> @@ -1063,17 +1065,16 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
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
> +		pnv_ioda_free_pe(pe);
>   		pe->pbus = NULL;
> -		return;
> +		return NULL;
>   	}
>
>   	/* Associate it with all child devices */
> @@ -1081,6 +1082,8 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>
>   	/* Put PE to the list */
>   	list_add_tail(&pe->list, &phb->ioda.pe_list);
> +
> +	return pe;
>   }
>
>   static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
> @@ -1392,7 +1395,7 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
>
>   		pnv_ioda_deconfigure_pe(phb, pe);
>
> -		pnv_ioda_free_pe(phb, pe->pe_number);
> +		pnv_ioda_free_pe(pe);
>   	}
>   }
>
> @@ -1401,6 +1404,7 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
>   	struct pci_bus        *bus;
>   	struct pci_controller *hose;
>   	struct pnv_phb        *phb;
> +	struct pnv_ioda_pe    *pe;
>   	struct pci_dn         *pdn;
>   	struct pci_sriov      *iov;
>   	u16                    num_vfs, i;
> @@ -1425,8 +1429,11 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
>   		/* Release PE numbers */
>   		if (pdn->m64_single_mode) {
>   			for (i = 0; i < num_vfs; i++) {
> -				if (pdn->pe_num_map[i] != IODA_INVALID_PE)
> -					pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
> +				if (pdn->pe_num_map[i] == IODA_INVALID_PE)
> +					continue;
> +
> +				pe = &phb->ioda.pe_array[pdn->pe_num_map[i]];
> +				pnv_ioda_free_pe(pe);
>   			}
>   		} else
>   			bitmap_clear(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
> @@ -1479,8 +1486,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>
>   		if (pnv_ioda_configure_pe(phb, pe)) {
>   			/* XXX What do we do here ? */
> -			if (pe_num)
> -				pnv_ioda_free_pe(phb, pe_num);
> +			pnv_ioda_free_pe(pe);
>   			pe->pdev = NULL;
>   			continue;
>   		}
> @@ -1499,6 +1505,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   	struct pci_bus        *bus;
>   	struct pci_controller *hose;
>   	struct pnv_phb        *phb;
> +	struct pnv_ioda_pe    *pe;
>   	struct pci_dn         *pdn;
>   	int                    ret;
>   	u16                    i;
> @@ -1541,11 +1548,13 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   		/* Calculate available PE for required VFs */
>   		if (pdn->m64_single_mode) {
>   			for (i = 0; i < num_vfs; i++) {
> -				pdn->pe_num_map[i] = pnv_ioda_alloc_pe(phb);
> -				if (pdn->pe_num_map[i] == IODA_INVALID_PE) {
> +				pe = pnv_ioda_alloc_pe(phb);
> +				if (!pe) {
>   					ret = -EBUSY;
>   					goto m64_failed;
>   				}
> +
> +				pdn->pe_num_map[i] = pe->pe_number;
>   			}
>   		} else {
>   			mutex_lock(&phb->ioda.pe_alloc_mutex);
> @@ -1590,8 +1599,11 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   m64_failed:
>   	if (pdn->m64_single_mode) {
>   		for (i = 0; i < num_vfs; i++) {
> -			if (pdn->pe_num_map[i] != IODA_INVALID_PE)
> -				pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
> +			if (pdn->pe_num_map[i] == IODA_INVALID_PE)
> +				continue;
> +
> +			pe = &phb->ioda.pe_array[pdn->pe_num_map[i]];
> +			pnv_ioda_free_pe(pe);
>   		}
>   	} else
>   		bitmap_clear(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 928cf81..ef9924a 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -109,7 +109,7 @@ struct pnv_phb {
>   	int (*init_m64)(struct pnv_phb *phb);
>   	void (*reserve_m64_pe)(struct pci_bus *bus,
>   			       unsigned long *pe_bitmap, bool all);
> -	int (*pick_m64_pe)(struct pci_bus *bus, bool all);
> +	struct pnv_ioda_pe *(*pick_m64_pe)(struct pci_bus *bus, bool all);
>   	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
>   	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
>   	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
>


-- 
Alexey
