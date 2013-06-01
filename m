Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CD01A2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 14:13:12 +1000 (EST)
Message-ID: <1370059983.3766.1.camel@pasglop>
Subject: Re: [PATCH 02/23] powerpc/eeh: Function to tranverse PCI devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 14:13:03 +1000
In-Reply-To: <1369902245-5886-3-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1369902245-5886-3-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-30 at 16:23 +0800, Gavin Shan wrote:
> For EEH on PowerNV platform, the PCI devices will be probed to
> check if they support EEH functionality. Different from the case
> of EEH for pSeries platform, we will probe real PCI device instead
> of device tree node for EEH capability on PowerNV platform.
> 
> The patch introduces function eeh_pci_dev_traverse() to traverse
> PCI devices for the indicated PCI bus from top to bottom.

This seems racy vs. hotplug etc... Any reason you can't use
pci_walk_bus() from drivers/pci/bus.c ?

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h           |    3 ++
>  arch/powerpc/platforms/pseries/eeh_dev.c |   35 ++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index e32c3c5..eeaeab6 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -183,6 +183,7 @@ static inline void eeh_unlock(void)
>  #define EEH_MAX_ALLOWED_FREEZES 5
>  
>  typedef void *(*eeh_traverse_func)(void *data, void *flag);
> +typedef void *(*eeh_pci_traverse_func)(struct pci_dev *dev, void *flag);
>  int eeh_phb_pe_create(struct pci_controller *phb);
>  int eeh_add_to_parent_pe(struct eeh_dev *edev);
>  int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
> @@ -191,6 +192,8 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,
>  void eeh_pe_restore_bars(struct eeh_pe *pe);
>  struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
>  
> +void eeh_pci_dev_traverse(struct pci_bus *bus,
> +		eeh_pci_traverse_func fn, void *flag);
>  void *eeh_dev_init(struct device_node *dn, void *data);
>  void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
>  int __init eeh_ops_register(struct eeh_ops *ops);
> diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
> index 1efa28f..12c445d 100644
> --- a/arch/powerpc/platforms/pseries/eeh_dev.c
> +++ b/arch/powerpc/platforms/pseries/eeh_dev.c
> @@ -41,6 +41,41 @@
>  #include <asm/pci-bridge.h>
>  #include <asm/ppc-pci.h>
>  
> +
> +/**
> + * eeh_pci_dev_traverse - Traverse PCI devices for the indicated bus
> + * @bus: PCI bus
> + * @fn: callback function
> + * @flag: extra flag
> + *
> + * The function traverses the PCI devices for the indicated PCI bus
> + * from top to bottom fashion until the supplied callback function
> + * returns non-zero value on the specific PCI device.
> + */
> +void eeh_pci_dev_traverse(struct pci_bus *bus,
> +		eeh_pci_traverse_func fn, void *flag)
> +{
> +	struct pci_dev *dev;
> +	void *ret;
> +
> +	if (!bus)
> +		return;
> +
> +	/*
> +	 * We should make sure the parent devices are scanned
> +	 * prior to the child devices so that the parent PE
> +	 * could be created before the child PEs.
> +	 */
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		ret = fn(dev, flag);
> +		if (ret)
> +			return;
> +
> +		if (dev->subordinate)
> +			eeh_pci_dev_traverse(dev->subordinate, fn, flag);
> +	}
> +}
> +
>  /**
>   * eeh_dev_init - Create EEH device according to OF node
>   * @dn: device node
