Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2E9B32C02AF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 16:26:04 +1000 (EST)
Message-ID: <1372573554.18612.116.camel@pasglop>
Subject: Re: [PATCH 8/8] powernv/eeh: Do hotplug on devices without EEH
 aware driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sun, 30 Jun 2013 16:25:54 +1000
In-Reply-To: <1372312009-13710-9-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372312009-13710-9-git-send-email-shangw@linux.vnet.ibm.com>
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

On Thu, 2013-06-27 at 13:46 +0800, Gavin Shan wrote:
> During recovery for EEH errors, the device driver requires reset
> explicitly (most of cases). The EEH core doesn't do hotplug during
> reset. However, there might have some device drivers that can't
> support EEH. So the deivce can't be put into quite state during
> the reset and possibly requesting PCI config or MMIO access. That
> would lead to the failure of the reset, and we don't expect that.
> 
> The patch intends to fix that by removing those devices whose drivers
> can't support EEH before reset and added into the system after reset.
> In the result, it would avoid the race condition mentioned as above.
> The idea was proposed by Ben.

Ok so, while the basic idea is sane, I have some problems with the
implementation.

First, you add a lot of code conditional to eeh_probe_mode_dev() and
I don't see why. There is no reason not to do the exact same remove/add
operations under pHyp.

This is actually a problem I have with the "new" EEH code overall, there
are too much gratuitous differences between the two "modes" and it's
very tricky to figure out exactly what and why, meaning this is going to
be a source of bugs. I think it's worthwhile trying to reconcile some of
that.

But then, there is *already* code to do a similar unplug/replug in EEH,
except that it's done inside eeh_reset_device() in the "other" case
(and indeed not necessarily in the best way).

Let's look a bit more:

> +extern void pcibios_setup_device(struct pci_dev *dev);

Unrelated: The above is gone as an exported symbol from upstream
as of today. I'll merge upstream in before applying your patches
so don't add that. You shouldn't need anyway, see below.

>  extern void pcibios_setup_bus_devices(struct pci_bus *bus);
>  extern void pcibios_setup_bus_self(struct pci_bus *bus);
>  extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 2b1ce17..cb3baab 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -244,6 +244,7 @@ static void *eeh_report_reset(void *data, void *userdata)
>  	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
>  	enum pci_ers_result rc, *res = userdata;
>  	struct pci_driver *driver;
> +	bool enable_irq = true;
>  
>  	if (!dev) return NULL;
>  	dev->error_state = pci_channel_io_normal;
> @@ -251,7 +252,21 @@ static void *eeh_report_reset(void *data, void *userdata)
>  	driver = eeh_pcid_get(dev);
>  	if (!driver) return NULL;
>  
> -	eeh_enable_irq(dev);

So I would very much like to understand a bit more that irq business,
for example, what does it do when MSIs are enabled, etc... but that
is also probably something to look at separately (you have a TODO
list ?)

> +	/*
> +	 * For those PCI devices just added, we reloaded its driver
> +	 * and needn't to enable the interrupt. The driver should
> +	 * take care of that. Otherwise, complaint raised from IRQ
> +	 * subsystem.
> +	 */
> +	if (eeh_probe_mode_dev() && (edev->mode & EEH_DEV_REMOVED)) {
> +		edev->mode &= ~(EEH_DEV_REMOVED | EEH_DEV_IRQ_DISABLED);
> +		edev->bus = NULL;
> +		enable_irq = false;
> +
> +	}

Ok, yet another eeh_probe_mode_dev() ... they irk me :-) There should be
no functional differences between EEH operations on powernv and pseries
at a high level and this is high level...

> +	if (enable_irq)
> +		eeh_enable_irq(dev);
>  
>  	if (!driver->err_handler ||
>  	    !driver->err_handler->slot_reset) {
> @@ -338,6 +353,115 @@ static void *eeh_report_failure(void *data, void *userdata)
>  	return NULL;
>  }
>  
> +static void *eeh_rmv_device(void *data, void *userdata)
> +{
> +	struct pci_driver *driver;
> +	struct eeh_dev *edev = (struct eeh_dev *)data;
> +	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
> +	int *removed = (int *)userdata;
> +
> +	/*
> +	 * Actually, we should remove the PCI bridges as well.
> +	 * However, that's lots of complexity to do that,
> +	 * particularly some of devices under the bridge might
> +	 * support EEH. So we just care about PCI devices for
> +	 * simplicity here.
> +	 */
> +	if (!dev || (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE))
> +		return NULL;
> +	driver = eeh_pcid_get(dev);
> +	if (driver && driver->err_handler)
> +		return NULL;

So here we end up basically re-inventing PCI hotplug:

> +	/* If the driver doesn't support EEH, remove it */
> +	pr_info("EEH: Removing device %s without EEH support\n",
> +		pci_name(dev));
> +
> +	/* Detach EEH device from PCI device */
> +	edev->pdev = NULL;
> +	dev->dev.archdata.edev = NULL;
> +	pci_dev_put(dev);
> +
> +	/* Remove and address cache */
> +	eeh_addr_cache_rmv_dev(dev);
> +	eeh_sysfs_remove_device(dev);
> +
> +	/* Remove it from PCI subsystem */
> +	edev->mode |= EEH_DEV_REMOVED;
> +	edev->bus = dev->bus;
> +	pci_stop_and_remove_bus_device(dev);
> +	(*removed)++;
> +
> +	return NULL;
> +}

And ...

> +static void *eeh_add_device(void *data, void *userdata)
> +{
> +	struct eeh_dev *edev = (struct eeh_dev *)data;
> +	struct pci_dev *dev;
> +	struct pci_bus *bus;
> +	struct resource *r;
> +	int *removed = (int *)userdata;
> +	int devfn, i;
> +
> +	if (!edev || !(edev->mode & EEH_DEV_REMOVED))
> +		return NULL;
> +	if (*removed <= 0)
> +		return edev;
> +
> +	/*
> +	 * We don't clear EEH_DEV_REMOVED flag here.
> +	 * Instead, do that before enabling IRQ to
> +	 * avoid complain from IRQ subsystem.
> +	 */
> +	*removed -= 1;
> +	bus = edev->bus;
> +	devfn = edev->config_addr & 0xFF;
> +	pr_info("EEH: Adding PCI device %04x:%02x:%02x.%01x\n",
> +		edev->phb->global_number, bus->number,
> +		PCI_SLOT(devfn), PCI_FUNC(devfn));
> +
> +	/* Scan PCI function */
> +	dev = pci_scan_single_device(bus, devfn);
> +	if (!dev) {
> +		pr_err("%s: Can't scan PCI function %02x:%02x.%01x\n",
> +		       __func__, bus->number, PCI_SLOT(devfn),
> +		       PCI_FUNC(devfn));
> +		return NULL;
> +	}

Wow, that's a hard scan ... we shouldn't do that on pseries (which you
don't since you don't use that code but still ...). See below for more
details.

> +	/*
> +	 * Setup the PCI device. It's not enough to
> +	 * claim the resource and we need assign or
> +	 * reassign that.
> +	 */
> +	pcibios_setup_device(dev);
> +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +		r = &dev->resource[i];
> +		if (r->parent || !r->flags)
> +			continue;
> +		if (pci_assign_resource(dev, i)) {

Are we really supposed to play with resource assignment here ? We should
just restore the BARs to their former values which are normally cached
in the eeh dev...

> +			pr_err("%s: Can't allocate %pR for %s\n",
> +			       __func__, r, pci_name(dev));
> +			/* Clear it out */
> +			r->start = 0;
> +			r->end = 0;
> +			r->flags = 0;
> +		}
> +	}
> +
> +	/* Associate EEH device with PCI device */
> +	pci_dev_get(dev);
> +	edev->pdev = dev;
> +	dev->dev.archdata.edev = edev;
> +	eeh_addr_cache_insert_dev(dev);
> +
> +	pci_bus_add_devices(bus);
> +	eeh_sysfs_add_device(dev);

So all that is a duplicate of:

> +	return NULL;
> +}
> +
>  /**
>   * eeh_reset_device - Perform actual reset of a pci slot
>   * @pe: EEH PE
> @@ -351,6 +475,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
>  {
>  	struct timeval tstamp;
>  	int cnt, rc;
> +	int removed = 0;
>  
>  	/* pcibios will clear the counter; save the value */
>  	cnt = pe->freeze_count;
> @@ -364,6 +489,8 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
>  	 */
>  	if (bus)
>       		__pcibios_remove_pci_devices(bus, 0);
                  ^^^^^^^^^^ this

and ...

> +	else if (eeh_probe_mode_dev())
> +		eeh_pe_dev_traverse(pe, eeh_rmv_device, &removed);
>  
>  	/* Reset the pci controller. (Asserts RST#; resets config space).
>  	 * Reconfigure bridges and devices. Don't try to bring the system
> @@ -384,8 +511,13 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
>  	 * potentially weird things happen.
>  	 */
>  	if (bus) {
> +		pr_info("EEH: Hold for 5 seconds after reset\n");
>  		ssleep(5);
>  		pcibios_add_pci_devices(bus);
                  ^^^^^^^^^^^^^ this

Except of course that the above are working on a "full bus" basis while
you try to deal with individual devices. More discussion about that
further down. Note also that the 2 above functions are in
arch/powerpc/platform/pseries. They should probably be moved (along with
their dependents) somewhere else such as in
arch/powerpc/kernel/pci-common.c as they are generally useful for
anything doing hotplug and as-is, it may not build with pseries enabled
in the .config

> +	} else if (eeh_probe_mode_dev() && removed) {
> +		pr_info("EEH: Hold for 5 seconds after reset\n");
> +		ssleep(5);
> +		eeh_pe_dev_traverse(pe, eeh_add_device, &removed);
>  	}
>  
>  	pe->tstamp = tstamp;

So, basically, the existing code tries to unplug the whole PE (which is
always a bus) under pseries, if *any* device in the PE doesn't do EEH.

Your new code tries to handle individual devices in the PE (does it ?)
and remove only those who don't handle EEH (am I correct ?) in case of
an EEH error, and re-plug them.

I don't see a reason why the latter shouldn't work for the former case.

IE Why can't we also do individual devices instead of removing the whole
lot on pseries ?

Also, the code to do the actual removal and adding which is currently
in pci_dlpar.c properly handles "device-tree" style probing *provided*
that you restore the BARs before you call it.

So at this point, I suggest you consider one of two approaches:

 - You can either break down the code in pci_dlpar.c to handle
individual devices instead of entire busses (and still provide a wrapper
for entire busses since that's used by the PCI hotplug code). Then you
use that for both pseries and powernv.

 - Or you can make powernv do like pseries and unplug the entire PE
which is always a bus for now (at least until we do SR-IOV) and use the
existing pci_dlpar.c functions more/less unmodified... but you probably
will have to switch to the first option when we do SR-IOV.

Cheers,
Ben.
