Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB0751A06D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 11:14:04 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so24446629pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 16:14:03 -0800 (PST)
Subject: Re: [PATCH v7 23/50] powerpc/powernv: Use PE instead of number during
 setup and release
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-24-git-send-email-gwshan@linux.vnet.ibm.com>
 <564AB64E.6060208@ozlabs.ru> <20151117090302.GD16586@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, panto@antoniou-consulting.com,
 grant.likely@linaro.org, robherring2@gmail.com, bhelgaas@google.com,
 frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564BC2C3.4060908@ozlabs.ru>
Date: Wed, 18 Nov 2015 11:13:55 +1100
MIME-Version: 1.0
In-Reply-To: <20151117090302.GD16586@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2015 08:03 PM, Gavin Shan wrote:
> On Tue, Nov 17, 2015 at 04:08:30PM +1100, Alexey Kardashevskiy wrote:
>> On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>> In current implementation, the PEs that are allocated or picked
>> >from the reserved list are identified by PE number. The PE instance
>>> has to be picked according to the PE number eventually. We have
>>> same issue when PE is released.
>>>
>>> For pnv_ioda_pick_m64_pe() and pnv_ioda_alloc_pe(), this returns
>>> PE instance so that pnv_ioda_setup_bus_PE() can use the allocated
>>> or reserved PE instance directly. Also, pnv_ioda_setup_bus_PE()
>>> returns the reserved/allocated PE instance to be used in subsequent
>>> patches. On the other hand, pnv_ioda_free_pe() uses PE instance
>>> (not number) as its argument. No logical changes introduced.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/platforms/powernv/pci-ioda.c | 81 +++++++++++++++++--------------
>>>   arch/powerpc/platforms/powernv/pci.h      |  2 +-
>>>   2 files changed, 46 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> index 488e0f8..ae82df1 100644
>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> @@ -152,7 +152,7 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>>>   	pnv_ioda_init_pe(phb, pe_no);
>>>   }
>>>
>>> -static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
>>> +static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
>>>   {
>>>   	unsigned long pe;
>>>
>>> @@ -160,19 +160,20 @@ static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
>>>   		pe = find_next_zero_bit(phb->ioda.pe_alloc,
>>>   					phb->ioda.total_pe_num, 0);
>>>   		if (pe >= phb->ioda.total_pe_num)
>>> -			return IODA_INVALID_PE;
>>> +			return NULL;
>>>   	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
>>>
>>> -	pnv_ioda_init_pe(phb, pe);
>>> -	return pe;
>>> +	return pnv_ioda_init_pe(phb, pe);
>>>   }
>>>
>>> -static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
>>> +static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe)
>>>   {
>>> -	WARN_ON(phb->ioda.pe_array[pe].pdev);
>>> +	struct pnv_phb *phb = pe->phb;
>>> +
>>> +	WARN_ON(pe->pdev);
>>>
>>> -	memset(&phb->ioda.pe_array[pe], 0, sizeof(struct pnv_ioda_pe));
>>> -	clear_bit(pe, phb->ioda.pe_alloc);
>>> +	memset(pe, 0, sizeof(struct pnv_ioda_pe));
>>> +	clear_bit(pe->pe_number, phb->ioda.pe_alloc);
>>>   }
>>>
>>>   /* The default M64 BAR is shared by all PEs */
>>> @@ -332,7 +333,7 @@ static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
>>>   	}
>>>   }
>>>
>>> -static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>>> +static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>>>   {
>>>   	struct pci_controller *hose = pci_bus_to_host(bus);
>>>   	struct pnv_phb *phb = hose->private_data;
>>> @@ -342,7 +343,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>>>
>>>   	/* Root bus shouldn't use M64 */
>>>   	if (pci_is_root_bus(bus))
>>> -		return IODA_INVALID_PE;
>>> +		return NULL;
>>>
>>>   	/* Allocate bitmap */
>>>   	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
>>> @@ -350,7 +351,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>>>   	if (!pe_alloc) {
>>>   		pr_warn("%s: Out of memory !\n",
>>>   			__func__);
>>> -		return IODA_INVALID_PE;
>>> +		return NULL;
>>>   	}
>>>
>>>   	/* Figure out reserved PE numbers by the PE */
>>> @@ -363,7 +364,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>>>   	 */
>>>   	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num)) {
>>>   		kfree(pe_alloc);
>>> -		return IODA_INVALID_PE;
>>> +		return NULL;
>>>   	}
>>>
>>>   	/*
>>> @@ -409,7 +410,7 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>>>   	}
>>>
>>>   	kfree(pe_alloc);
>>> -	return master_pe->pe_number;
>>> +	return master_pe;
>>>   }
>>>
>>>   static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>> @@ -988,28 +989,26 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
>>>    * subordinate PCI devices and buses. The second type of PE is normally
>>>    * orgiriated by PCIe-to-PCI bridge or PLX switch downstream ports.
>>>    */
>>> -static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>>> +static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>>>   {
>>>   	struct pci_controller *hose = pci_bus_to_host(bus);
>>>   	struct pnv_phb *phb = hose->private_data;
>>> -	struct pnv_ioda_pe *pe;
>>> -	int pe_num = IODA_INVALID_PE;
>>> +	struct pnv_ioda_pe *pe = NULL;
>>>
>>>   	/* Check if PE is determined by M64 */
>>>   	if (phb->pick_m64_pe)
>>> -		pe_num = phb->pick_m64_pe(bus, all);
>>> +		pe = phb->pick_m64_pe(bus, all);
>>>
>>>   	/* The PE number isn't pinned by M64 */
>>> -	if (pe_num == IODA_INVALID_PE)
>>> -		pe_num = pnv_ioda_alloc_pe(phb);
>>> +	if (!pe)
>>> +		pe = pnv_ioda_alloc_pe(phb);
>>>
>>> -	if (pe_num == IODA_INVALID_PE) {
>>> +	if (!pe) {
>>>   		pr_warning("%s: Not enough PE# available for PCI bus %04x:%02x\n",
>>>   			__func__, pci_domain_nr(bus), bus->number);
>>> -		return;
>>> +		return NULL;
>>>   	}
>>>
>>> -	pe = &phb->ioda.pe_array[pe_num];
>>>   	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
>>>   	pe->pbus = bus;
>>>   	pe->pdev = NULL;
>>> @@ -1018,17 +1017,16 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>>>
>>>   	if (all)
>>>   		pe_info(pe, "Secondary bus %d..%d associated with PE#%d\n",
>>> -			bus->busn_res.start, bus->busn_res.end, pe_num);
>>> +			bus->busn_res.start, bus->busn_res.end, pe->pe_number);
>>>   	else
>>>   		pe_info(pe, "Secondary bus %d associated with PE#%d\n",
>>> -			bus->busn_res.start, pe_num);
>>> +			bus->busn_res.start, pe->pe_number);
>>>
>>>   	if (pnv_ioda_configure_pe(phb, pe)) {
>>>   		/* XXX What do we do here ? */
>>> -		if (pe_num)
>>> -			pnv_ioda_free_pe(phb, pe_num);
>>> +		pnv_ioda_free_pe(pe);
>>>   		pe->pbus = NULL;
>>> -		return;
>>> +		return NULL;
>>>   	}
>>>
>>>   	/* Associate it with all child devices */
>>> @@ -1036,6 +1034,8 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>>>
>>>   	/* Put PE to the list */
>>>   	list_add_tail(&pe->list, &phb->ioda.pe_list);
>>> +
>>> +	return pe;
>>>   }
>>>
>>>   static void pnv_ioda_setup_PEs(struct pci_bus *bus)
>>> @@ -1267,7 +1267,7 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
>>>
>>>   		pnv_ioda_deconfigure_pe(phb, pe);
>>>
>>> -		pnv_ioda_free_pe(phb, pe->pe_number);
>>> +		pnv_ioda_free_pe(pe);
>>>   	}
>>>   }
>>>
>>> @@ -1276,6 +1276,7 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
>>>   	struct pci_bus        *bus;
>>>   	struct pci_controller *hose;
>>>   	struct pnv_phb        *phb;
>>> +	struct pnv_ioda_pe    *pe;
>>>   	struct pci_dn         *pdn;
>>>   	struct pci_sriov      *iov;
>>>   	u16                    num_vfs, i;
>>> @@ -1300,8 +1301,11 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
>>>   		/* Release PE numbers */
>>>   		if (pdn->m64_single_mode) {
>>>   			for (i = 0; i < num_vfs; i++) {
>>> -				if (pdn->pe_num_map[i] != IODA_INVALID_PE)
>>> -					pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
>>> +				if (pdn->pe_num_map[i] == IODA_INVALID_PE)
>>> +					continue;
>>> +
>>> +				pe = &phb->ioda.pe_array[pdn->pe_num_map[i]];
>>> +				pnv_ioda_free_pe(pe);
>>>   			}
>>>   		} else
>>>   			bitmap_clear(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
>>> @@ -1354,9 +1358,8 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>>>
>>>   		if (pnv_ioda_configure_pe(phb, pe)) {
>>>   			/* XXX What do we do here ? */
>>> -			if (pe_num)
>>> -				pnv_ioda_free_pe(phb, pe_num);
>>>   			pe->pdev = NULL;
>>> +			pnv_ioda_free_pe(pe);
>>
>>
>>
>> pnv_ioda_free_pe() does WARN_ON(pdev). Before this patch you would free PE
>> first and then reset pe->pdev, now you reset it first, then call
>> pnv_ioda_free_pe(). This change is not just about "Use PE instead of number
>> during setup and release", is/was that a bug?
>>
>> And I fail to see when pe->pdev could get initialized in
>> pnv_ioda_configure_pe() as pnv_pci_dma_dev_setup() should not be called while
>> pnv_ioda_setup_vf_PE() is working.
>>
>
> It wasn't or isn't a bug as


There is an unexplained change in behavior - after the patch pe->pdev gets 
cleaned before pnv_ioda_free_pe(), before the patch it was opposite. Your 
options are:
- remove "No logical changes introduced" from the commit log and explain 
the change or
- move "pe->pdev = NULL;" after pnv_ioda_free_pe().



> pe->pdev is initialized in arch/powerpc/platform/powernv/pci.c::
> pnv_pci_dma_dev_setup()

So when pnv_ioda_setup_vf_PE() starts working, it is valid for pe->pdev to 
have not-NULL pointer? Because nothing in pnv_ioda_setup_vf_PE() calls 
pnv_pci_dma_dev_setup(), explicitly or implicitly.




>>
>>>   			continue;
>>>   		}
>>>
>>> @@ -1374,6 +1377,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>>>   	struct pci_bus        *bus;
>>>   	struct pci_controller *hose;
>>>   	struct pnv_phb        *phb;
>>> +	struct pnv_ioda_pe    *pe;
>>>   	struct pci_dn         *pdn;
>>>   	int                    ret;
>>>   	u16                    i;
>>> @@ -1416,11 +1420,13 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>>>   		/* Calculate available PE for required VFs */
>>>   		if (pdn->m64_single_mode) {
>>>   			for (i = 0; i < num_vfs; i++) {
>>> -				pdn->pe_num_map[i] = pnv_ioda_alloc_pe(phb);
>>> -				if (pdn->pe_num_map[i] == IODA_INVALID_PE) {
>>> +				pe = pnv_ioda_alloc_pe(phb);
>>> +				if (!pe) {
>>>   					ret = -EBUSY;
>>>   					goto m64_failed;
>>>   				}
>>> +
>>> +				pdn->pe_num_map[i] = pe->pe_number;
>>>   			}
>>>   		} else {
>>>   			mutex_lock(&phb->ioda.pe_alloc_mutex);
>>> @@ -1465,8 +1471,11 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>>>   m64_failed:
>>>   	if (pdn->m64_single_mode) {
>>>   		for (i = 0; i < num_vfs; i++) {
>>> -			if (pdn->pe_num_map[i] != IODA_INVALID_PE)
>>> -				pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
>>> +			if (pdn->pe_num_map[i] == IODA_INVALID_PE)
>>> +				continue;
>>> +
>>> +			pe = &phb->ioda.pe_array[pdn->pe_num_map[i]];
>>> +			pnv_ioda_free_pe(pe);
>>>   		}
>>>   	} else
>>>   		bitmap_clear(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
>>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>> index 5df945f..e55ab0e 100644
>>> --- a/arch/powerpc/platforms/powernv/pci.h
>>> +++ b/arch/powerpc/platforms/powernv/pci.h
>>> @@ -105,7 +105,7 @@ struct pnv_phb {
>>>   	int (*init_m64)(struct pnv_phb *phb);
>>>   	void (*reserve_m64_pe)(struct pci_bus *bus,
>>>   			       unsigned long *pe_bitmap, bool all);
>>> -	int (*pick_m64_pe)(struct pci_bus *bus, bool all);
>>> +	struct pnv_ioda_pe *(*pick_m64_pe)(struct pci_bus *bus, bool all);
>>>   	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
>>>   	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
>>>   	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
>>>
>
> Thanks,
> Gavin
>


-- 
Alexey
