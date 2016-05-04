Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r05LZ68XMzDqcy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 14:54:46 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 May 2016 14:54:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5724A3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 14:54:43 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u444sY3R3670288
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:54:42 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u444s91r010823
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:54:09 +1000
Date: Wed, 4 May 2016 14:53:43 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru
Subject: Re: [PATCH v9 18/26] powerpc/pci: Rename
 pcibios_{add,remove}_pci_devices()
Message-ID: <20160504045343.GA13070@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-19-git-send-email-gwshan@linux.vnet.ibm.com>
 <3359283.T9UEaccSoe@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3359283.T9UEaccSoe@new-mexico>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 04, 2016 at 02:10:47PM +1000, Alistair Popple wrote:
>On Tue, 3 May 2016 15:41:37 Gavin Shan wrote:
>> This renames pcibios_{add,remove}_pci_devices() to avoid conflicts
>> with names of the weak functions in PCI subsystem, which have the
>> prefix "pcibios". No logical changes introduced.
>
>I'm guessing this is just protecting against future weak PCI subsystem 
>functions that may get these names? In other words none of these functions 
>currently exist as weak PCI subsystem functions and hence aren't called from 
>the PCI subsystem?
>
>If so this just looks like a simple rename.
>

Thanks for review, Alistair. Yes, it's simple rename. In PCI subsystem,
the weak funtion names have prefix pcibios_. Those functions are not weak
functions. Also, The functions are exported so that they can be used in PCI
hotplug driver (module) and it's worthy to have better names for them.

Those functions are called in PCI hotplug path to accomodate request from
EEH or PCI hotplug driver.

Thanks,
Gavin

>Reviewed-By: Alistair Popple <alistair@popple.id.au>
>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/pci-bridge.h |  4 ++--
>>  arch/powerpc/kernel/eeh_driver.c      | 12 ++++++------
>>  arch/powerpc/kernel/pci-hotplug.c     | 15 +++++++--------
>>  drivers/pci/hotplug/rpadlpar_core.c   |  2 +-
>>  drivers/pci/hotplug/rpaphp_core.c     |  4 ++--
>>  drivers/pci/hotplug/rpaphp_pci.c      |  2 +-
>>  6 files changed, 19 insertions(+), 20 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/pci-bridge.h 
>b/arch/powerpc/include/asm/pci-bridge.h
>> index 220129f..99027b8 100644
>> --- a/arch/powerpc/include/asm/pci-bridge.h
>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>> @@ -260,10 +260,10 @@ static inline struct eeh_dev *pdn_to_eeh_dev(struct 
>pci_dn *pdn)
>>  extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn);
>>  
>>  /** Remove all of the PCI devices under this bus */
>> -extern void pcibios_remove_pci_devices(struct pci_bus *bus);
>> +extern void pci_hp_remove_devices(struct pci_bus *bus);
>>  
>>  /** Discover new pci devices under this bus, and add them */
>> -extern void pcibios_add_pci_devices(struct pci_bus *bus);
>> +extern void pci_hp_add_devices(struct pci_bus *bus);
>>  
>>  
>>  extern void isa_bridge_find_early(struct pci_controller *hose);
>> diff --git a/arch/powerpc/kernel/eeh_driver.c 
>b/arch/powerpc/kernel/eeh_driver.c
>> index fb6207d..618d13c 100644
>> --- a/arch/powerpc/kernel/eeh_driver.c
>> +++ b/arch/powerpc/kernel/eeh_driver.c
>> @@ -621,7 +621,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct 
>pci_bus *bus,
>>  	 * We don't remove the corresponding PE instances because
>>  	 * we need the information afterwords. The attached EEH
>>  	 * devices are expected to be attached soon when calling
>> -	 * into pcibios_add_pci_devices().
>> +	 * into pci_hp_add_devices().
>>  	 */
>>  	eeh_pe_state_mark(pe, EEH_PE_KEEP);
>>  	if (bus) {
>> @@ -630,7 +630,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct 
>pci_bus *bus,
>>  		} else {
>>  			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
>>  			pci_lock_rescan_remove();
>> -			pcibios_remove_pci_devices(bus);
>> +			pci_hp_remove_devices(bus);
>>  			pci_unlock_rescan_remove();
>>  		}
>>  	} else if (frozen_bus) {
>> @@ -681,7 +681,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct 
>pci_bus *bus,
>>  		if (pe->type & EEH_PE_VF)
>>  			eeh_add_virt_device(edev, NULL);
>>  		else
>> -			pcibios_add_pci_devices(bus);
>> +			pci_hp_add_devices(bus);
>>  	} else if (frozen_bus && rmv_data->removed) {
>>  		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
>>  		ssleep(5);
>> @@ -691,7 +691,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct 
>pci_bus *bus,
>>  		if (pe->type & EEH_PE_VF)
>>  			eeh_add_virt_device(edev, NULL);
>>  		else
>> -			pcibios_add_pci_devices(frozen_bus);
>> +			pci_hp_add_devices(frozen_bus);
>>  	}
>>  	eeh_pe_state_clear(pe, EEH_PE_KEEP);
>>  
>> @@ -896,7 +896,7 @@ perm_error:
>>  			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
>>  
>>  			pci_lock_rescan_remove();
>> -			pcibios_remove_pci_devices(frozen_bus);
>> +			pci_hp_remove_devices(frozen_bus);
>>  			pci_unlock_rescan_remove();
>>  		}
>>  	}
>> @@ -981,7 +981,7 @@ static void eeh_handle_special_event(void)
>>  				bus = eeh_pe_bus_get(phb_pe);
>>  				eeh_pe_dev_traverse(pe,
>>  					eeh_report_failure, NULL);
>> -				pcibios_remove_pci_devices(bus);
>> +				pci_hp_remove_devices(bus);
>>  			}
>>  			pci_unlock_rescan_remove();
>>  		}
>> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-
>hotplug.c
>> index 59c4361..2d108e5 100644
>> --- a/arch/powerpc/kernel/pci-hotplug.c
>> +++ b/arch/powerpc/kernel/pci-hotplug.c
>> @@ -38,20 +38,20 @@ void pcibios_release_device(struct pci_dev *dev)
>>  }
>>  
>>  /**
>> - * pcibios_remove_pci_devices - remove all devices under this bus
>> + * pci_hp_remove_devices - remove all devices under this bus
>>   * @bus: the indicated PCI bus
>>   *
>>   * Remove all of the PCI devices under this bus both from the
>>   * linux pci device tree, and from the powerpc EEH address cache.
>>   */
>> -void pcibios_remove_pci_devices(struct pci_bus *bus)
>> +void pci_hp_remove_devices(struct pci_bus *bus)
>>  {
>>  	struct pci_dev *dev, *tmp;
>>  	struct pci_bus *child_bus;
>>  
>>  	/* First go down child busses */
>>  	list_for_each_entry(child_bus, &bus->children, node)
>> -		pcibios_remove_pci_devices(child_bus);
>> +		pci_hp_remove_devices(child_bus);
>>  
>>  	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
>>  		 pci_domain_nr(bus),  bus->number);
>> @@ -60,11 +60,10 @@ void pcibios_remove_pci_devices(struct pci_bus *bus)
>>  		pci_stop_and_remove_bus_device(dev);
>>  	}
>>  }
>> -
>> -EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
>> +EXPORT_SYMBOL_GPL(pci_hp_remove_devices);
>>  
>>  /**
>> - * pcibios_add_pci_devices - adds new pci devices to bus
>> + * pci_hp_add_devices - adds new pci devices to bus
>>   * @bus: the indicated PCI bus
>>   *
>>   * This routine will find and fixup new pci devices under
>> @@ -74,7 +73,7 @@ EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
>>   * is how this routine differs from other, similar pcibios
>>   * routines.)
>>   */
>> -void pcibios_add_pci_devices(struct pci_bus * bus)
>> +void pci_hp_add_devices(struct pci_bus *bus)
>>  {
>>  	int slotno, mode, pass, max;
>>  	struct pci_dev *dev;
>> @@ -114,4 +113,4 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
>>  	}
>>  	pcibios_finish_adding_to_bus(bus);
>>  }
>> -EXPORT_SYMBOL_GPL(pcibios_add_pci_devices);
>> +EXPORT_SYMBOL_GPL(pci_hp_add_devices);
>> diff --git a/drivers/pci/hotplug/rpadlpar_core.c 
>b/drivers/pci/hotplug/rpadlpar_core.c
>> index b46b57d..b770d6d 100644
>> --- a/drivers/pci/hotplug/rpadlpar_core.c
>> +++ b/drivers/pci/hotplug/rpadlpar_core.c
>> @@ -380,7 +380,7 @@ int dlpar_remove_pci_slot(char *drc_name, struct 
>device_node *dn)
>>  	}
>>  
>>  	/* Remove all devices below slot */
>> -	pcibios_remove_pci_devices(bus);
>> +	pci_hp_remove_devices(bus);
>>  
>>  	/* Unmap PCI IO space */
>>  	if (pcibios_unmap_io_space(bus)) {
>> diff --git a/drivers/pci/hotplug/rpaphp_core.c 
>b/drivers/pci/hotplug/rpaphp_core.c
>> index 611f605..8d13202 100644
>> --- a/drivers/pci/hotplug/rpaphp_core.c
>> +++ b/drivers/pci/hotplug/rpaphp_core.c
>> @@ -404,7 +404,7 @@ static int enable_slot(struct hotplug_slot 
>*hotplug_slot)
>>  
>>  	if (state == PRESENT) {
>>  		pci_lock_rescan_remove();
>> -		pcibios_add_pci_devices(slot->bus);
>> +		pci_hp_add_devices(slot->bus);
>>  		pci_unlock_rescan_remove();
>>  		slot->state = CONFIGURED;
>>  	} else if (state == EMPTY) {
>> @@ -426,7 +426,7 @@ static int disable_slot(struct hotplug_slot 
>*hotplug_slot)
>>  		return -EINVAL;
>>  
>>  	pci_lock_rescan_remove();
>> -	pcibios_remove_pci_devices(slot->bus);
>> +	pci_hp_remove_devices(slot->bus);
>>  	pci_unlock_rescan_remove();
>>  	vm_unmap_aliases();
>>  
>> diff --git a/drivers/pci/hotplug/rpaphp_pci.c 
>b/drivers/pci/hotplug/rpaphp_pci.c
>> index 7836d69..137a892 100644
>> --- a/drivers/pci/hotplug/rpaphp_pci.c
>> +++ b/drivers/pci/hotplug/rpaphp_pci.c
>> @@ -116,7 +116,7 @@ int rpaphp_enable_slot(struct slot *slot)
>>  		}
>>  
>>  		if (list_empty(&bus->devices))
>> -			pcibios_add_pci_devices(bus);
>> +			pci_hp_add_devices(bus);
>>  
>>  		if (!list_empty(&bus->devices)) {
>>  			info->adapter_status = CONFIGURED;
>> 
>
