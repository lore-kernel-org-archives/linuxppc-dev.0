Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0fvF1jlgzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 13:06:31 +1000 (AEST)
Received: by mail-pa0-x236.google.com with SMTP id iv1so30779483pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 May 2016 20:06:31 -0700 (PDT)
Subject: Re: [PATCH v9 18/26] powerpc/pci: Rename
 pcibios_{add,remove}_pci_devices()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-19-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, alistair@popple.id.au
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2ba6f114-1a53-1554-93c4-e29d3c9e2f99@ozlabs.ru>
Date: Thu, 5 May 2016 13:06:25 +1000
MIME-Version: 1.0
In-Reply-To: <1462254105-24128-19-git-send-email-gwshan@linux.vnet.ibm.com>
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
> This renames pcibios_{add,remove}_pci_devices() to avoid conflicts
> with names of the weak functions in PCI subsystem, which have the
> prefix "pcibios". No logical changes introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  arch/powerpc/include/asm/pci-bridge.h |  4 ++--
>  arch/powerpc/kernel/eeh_driver.c      | 12 ++++++------
>  arch/powerpc/kernel/pci-hotplug.c     | 15 +++++++--------
>  drivers/pci/hotplug/rpadlpar_core.c   |  2 +-
>  drivers/pci/hotplug/rpaphp_core.c     |  4 ++--
>  drivers/pci/hotplug/rpaphp_pci.c      |  2 +-
>  6 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 220129f..99027b8 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -260,10 +260,10 @@ static inline struct eeh_dev *pdn_to_eeh_dev(struct pci_dn *pdn)
>  extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn);
>
>  /** Remove all of the PCI devices under this bus */
> -extern void pcibios_remove_pci_devices(struct pci_bus *bus);
> +extern void pci_hp_remove_devices(struct pci_bus *bus);
>
>  /** Discover new pci devices under this bus, and add them */
> -extern void pcibios_add_pci_devices(struct pci_bus *bus);
> +extern void pci_hp_add_devices(struct pci_bus *bus);
>
>
>  extern void isa_bridge_find_early(struct pci_controller *hose);
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index fb6207d..618d13c 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -621,7 +621,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  	 * We don't remove the corresponding PE instances because
>  	 * we need the information afterwords. The attached EEH
>  	 * devices are expected to be attached soon when calling
> -	 * into pcibios_add_pci_devices().
> +	 * into pci_hp_add_devices().
>  	 */
>  	eeh_pe_state_mark(pe, EEH_PE_KEEP);
>  	if (bus) {
> @@ -630,7 +630,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  		} else {
>  			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
>  			pci_lock_rescan_remove();
> -			pcibios_remove_pci_devices(bus);
> +			pci_hp_remove_devices(bus);
>  			pci_unlock_rescan_remove();
>  		}
>  	} else if (frozen_bus) {
> @@ -681,7 +681,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  		if (pe->type & EEH_PE_VF)
>  			eeh_add_virt_device(edev, NULL);
>  		else
> -			pcibios_add_pci_devices(bus);
> +			pci_hp_add_devices(bus);
>  	} else if (frozen_bus && rmv_data->removed) {
>  		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
>  		ssleep(5);
> @@ -691,7 +691,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  		if (pe->type & EEH_PE_VF)
>  			eeh_add_virt_device(edev, NULL);
>  		else
> -			pcibios_add_pci_devices(frozen_bus);
> +			pci_hp_add_devices(frozen_bus);
>  	}
>  	eeh_pe_state_clear(pe, EEH_PE_KEEP);
>
> @@ -896,7 +896,7 @@ perm_error:
>  			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
>
>  			pci_lock_rescan_remove();
> -			pcibios_remove_pci_devices(frozen_bus);
> +			pci_hp_remove_devices(frozen_bus);
>  			pci_unlock_rescan_remove();
>  		}
>  	}
> @@ -981,7 +981,7 @@ static void eeh_handle_special_event(void)
>  				bus = eeh_pe_bus_get(phb_pe);
>  				eeh_pe_dev_traverse(pe,
>  					eeh_report_failure, NULL);
> -				pcibios_remove_pci_devices(bus);
> +				pci_hp_remove_devices(bus);
>  			}
>  			pci_unlock_rescan_remove();
>  		}
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 59c4361..2d108e5 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -38,20 +38,20 @@ void pcibios_release_device(struct pci_dev *dev)
>  }
>
>  /**
> - * pcibios_remove_pci_devices - remove all devices under this bus
> + * pci_hp_remove_devices - remove all devices under this bus
>   * @bus: the indicated PCI bus
>   *
>   * Remove all of the PCI devices under this bus both from the
>   * linux pci device tree, and from the powerpc EEH address cache.
>   */
> -void pcibios_remove_pci_devices(struct pci_bus *bus)
> +void pci_hp_remove_devices(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev, *tmp;
>  	struct pci_bus *child_bus;
>
>  	/* First go down child busses */
>  	list_for_each_entry(child_bus, &bus->children, node)
> -		pcibios_remove_pci_devices(child_bus);
> +		pci_hp_remove_devices(child_bus);
>
>  	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
>  		 pci_domain_nr(bus),  bus->number);
> @@ -60,11 +60,10 @@ void pcibios_remove_pci_devices(struct pci_bus *bus)
>  		pci_stop_and_remove_bus_device(dev);
>  	}
>  }
> -
> -EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
> +EXPORT_SYMBOL_GPL(pci_hp_remove_devices);
>
>  /**
> - * pcibios_add_pci_devices - adds new pci devices to bus
> + * pci_hp_add_devices - adds new pci devices to bus
>   * @bus: the indicated PCI bus
>   *
>   * This routine will find and fixup new pci devices under
> @@ -74,7 +73,7 @@ EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
>   * is how this routine differs from other, similar pcibios
>   * routines.)
>   */
> -void pcibios_add_pci_devices(struct pci_bus * bus)
> +void pci_hp_add_devices(struct pci_bus *bus)
>  {
>  	int slotno, mode, pass, max;
>  	struct pci_dev *dev;
> @@ -114,4 +113,4 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
>  	}
>  	pcibios_finish_adding_to_bus(bus);
>  }
> -EXPORT_SYMBOL_GPL(pcibios_add_pci_devices);
> +EXPORT_SYMBOL_GPL(pci_hp_add_devices);
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index b46b57d..b770d6d 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -380,7 +380,7 @@ int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
>  	}
>
>  	/* Remove all devices below slot */
> -	pcibios_remove_pci_devices(bus);
> +	pci_hp_remove_devices(bus);
>
>  	/* Unmap PCI IO space */
>  	if (pcibios_unmap_io_space(bus)) {
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index 611f605..8d13202 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -404,7 +404,7 @@ static int enable_slot(struct hotplug_slot *hotplug_slot)
>
>  	if (state == PRESENT) {
>  		pci_lock_rescan_remove();
> -		pcibios_add_pci_devices(slot->bus);
> +		pci_hp_add_devices(slot->bus);
>  		pci_unlock_rescan_remove();
>  		slot->state = CONFIGURED;
>  	} else if (state == EMPTY) {
> @@ -426,7 +426,7 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
>  		return -EINVAL;
>
>  	pci_lock_rescan_remove();
> -	pcibios_remove_pci_devices(slot->bus);
> +	pci_hp_remove_devices(slot->bus);
>  	pci_unlock_rescan_remove();
>  	vm_unmap_aliases();
>
> diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
> index 7836d69..137a892 100644
> --- a/drivers/pci/hotplug/rpaphp_pci.c
> +++ b/drivers/pci/hotplug/rpaphp_pci.c
> @@ -116,7 +116,7 @@ int rpaphp_enable_slot(struct slot *slot)
>  		}
>
>  		if (list_empty(&bus->devices))
> -			pcibios_add_pci_devices(bus);
> +			pci_hp_add_devices(bus);
>
>  		if (!list_empty(&bus->devices)) {
>  			info->adapter_status = CONFIGURED;
>


-- 
Alexey
