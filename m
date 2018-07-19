Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WLNn5WKTzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 14:18:33 +1000 (AEST)
Message-ID: <65dd986d0b8b2ebe5132b365dabb2dbaaed9177f.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] PCI: Data corruption happening due to race condition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, ray.jui@broadcom.com,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 19 Jul 2018 14:18:09 +1000
In-Reply-To: <20180718232904.GJ128988@bhelgaas-glaptop.roam.corp.google.com>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <1530608741-30664-2-git-send-email-hari.vyas@broadcom.com>
 <20180718232904.GJ128988@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-18 at 18:29 -0500, Bjorn Helgaas wrote:
> [+cc Paul, Michael, linuxppc-dev]
> 

   ..../...

> > Debugging revealed a race condition between pcie core driver
> > enabling is_added bit(pci_bus_add_device()) and nvme driver
> > reset work-queue enabling is_busmaster bit (by pci_set_master()).
> > As both fields are not handled in atomic manner and that clears
> > is_added bit.
> > 
> > Fix moves device addition is_added bit to separate private flag
> > variable and use different atomic functions to set and retrieve
> > device addition state. As is_added shares different memory
> > location so race condition is avoided.
> 
> Really nice bit of debugging!

Indeed. However I'm not fan of the solution. Shouldn't we instead have
some locking for the content of pci_dev ? I've always been wary of us
having other similar races in there.

As for the powerpc bits, I'm probably the one who wrote them, however,
I'm on vacation this week and right now, no bandwidth to context switch
all that back in :-) So give me a few days and/or ping me next week.

The powerpc PCI code contains a lot of cruft coming from the depth of
history, including rather nasty assumptions. We want to progressively
clean it up, starting with EEH, but it will take time.

Cheers,
Ben.

> > Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
> > ---
> >  arch/powerpc/kernel/pci-common.c          |  4 +++-
> >  arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
> >  arch/powerpc/platforms/pseries/setup.c    |  3 ++-
> >  drivers/pci/bus.c                         |  6 +++---
> >  drivers/pci/hotplug/acpiphp_glue.c        |  2 +-
> >  drivers/pci/pci.h                         | 11 +++++++++++
> >  drivers/pci/probe.c                       |  4 ++--
> >  drivers/pci/remove.c                      |  5 +++--
> >  include/linux/pci.h                       |  1 -
> >  9 files changed, 27 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > index fe9733f..471aac3 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -42,6 +42,8 @@
> >  #include <asm/ppc-pci.h>
> >  #include <asm/eeh.h>
> >  
> > +#include "../../../drivers/pci/pci.h"
> 
> I see why you need it, but this include path is really ugly.  Outside
> of bootloaders and tools, there are very few instances of includes
> like this that reference a different top-level directory, and I'm not
> very keen about adding more.
> 
> Obviously powerpc is the only arch that needs dev->is_added.  It seems
> to be because "We can only call pcibios_setup_device() after bus setup
> is complete, since some of the platform specific DMA setup code
> depends on it."
> 
> I don't know powerpc, but it does raise the question in my mind of
> whether powerpc could be changed to do the DMA setup more like other
> arches do to remove this ordering dependency and the need to use
> dev->is_added.
> 
> That sounds like a lot of work, but it would have the benefit of
> unifying some code that is probably needlessly arch-specific.
> 
> >  /* hose_spinlock protects accesses to the the phb_bitmap. */
> >  static DEFINE_SPINLOCK(hose_spinlock);
> >  LIST_HEAD(hose_list);
> > @@ -1014,7 +1016,7 @@ void pcibios_setup_bus_devices(struct pci_bus *bus)
> >  		/* Cardbus can call us to add new devices to a bus, so ignore
> >  		 * those who are already fully discovered
> >  		 */
> > -		if (dev->is_added)
> > +		if (pci_dev_is_added(dev))
> >  			continue;
> >  
> >  		pcibios_setup_device(dev);
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index 5bd0eb6..70b2e1e 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -46,6 +46,7 @@
> >  
> >  #include "powernv.h"
> >  #include "pci.h"
> > +#include "../../../../drivers/pci/pci.h"
> >  
> >  #define PNV_IODA1_M64_NUM	16	/* Number of M64 BARs	*/
> >  #define PNV_IODA1_M64_SEGS	8	/* Segments per M64 BAR	*/
> > @@ -3138,7 +3139,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> >  	struct pci_dn *pdn;
> >  	int mul, total_vfs;
> >  
> > -	if (!pdev->is_physfn || pdev->is_added)
> > +	if (!pdev->is_physfn || pci_dev_is_added(pdev))
> >  		return;
> >  
> >  	pdn = pci_get_pdn(pdev);
> > diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> > index 139f0af..8a4868a 100644
> > --- a/arch/powerpc/platforms/pseries/setup.c
> > +++ b/arch/powerpc/platforms/pseries/setup.c
> > @@ -71,6 +71,7 @@
> >  #include <asm/security_features.h>
> >  
> >  #include "pseries.h"
> > +#include "../../../../drivers/pci/pci.h"
> >  
> >  int CMO_PrPSP = -1;
> >  int CMO_SecPSP = -1;
> > @@ -664,7 +665,7 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
> >  	const int *indexes;
> >  	struct device_node *dn = pci_device_to_OF_node(pdev);
> >  
> > -	if (!pdev->is_physfn || pdev->is_added)
> > +	if (!pdev->is_physfn || pci_dev_is_added(pdev))
> >  		return;
> >  	/*Firmware must support open sriov otherwise dont configure*/
> >  	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 35b7fc8..5cb40b2 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -330,7 +330,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> >  		return;
> >  	}
> >  
> > -	dev->is_added = 1;
> > +	pci_dev_assign_added(dev, true);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_bus_add_device);
> >  
> > @@ -347,14 +347,14 @@ void pci_bus_add_devices(const struct pci_bus *bus)
> >  
> >  	list_for_each_entry(dev, &bus->devices, bus_list) {
> >  		/* Skip already-added devices */
> > -		if (dev->is_added)
> > +		if (pci_dev_is_added(dev))
> >  			continue;
> >  		pci_bus_add_device(dev);
> >  	}
> >  
> >  	list_for_each_entry(dev, &bus->devices, bus_list) {
> >  		/* Skip if device attach failed */
> > -		if (!dev->is_added)
> > +		if (!pci_dev_is_added(dev))
> >  			continue;
> >  		child = dev->subordinate;
> >  		if (child)
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index 3a17b29..ef0b1b6 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -509,7 +509,7 @@ static void enable_slot(struct acpiphp_slot *slot)
> >  
> >  	list_for_each_entry(dev, &bus->devices, bus_list) {
> >  		/* Assume that newly added devices are powered on already. */
> > -		if (!dev->is_added)
> > +		if (!pci_dev_is_added(dev))
> >  			dev->current_state = PCI_D0;
> >  	}
> >  
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 882f1f9..0881725 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -288,6 +288,7 @@ struct pci_sriov {
> >  
> >  /* pci_dev priv_flags */
> >  #define PCI_DEV_DISCONNECTED 0
> > +#define PCI_DEV_ADDED 1
> >  
> >  static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> >  {
> > @@ -300,6 +301,16 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
> >  	return test_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
> >  }
> >  
> > +static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
> > +{
> > +	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
> > +}
> > +
> > +static inline bool pci_dev_is_added(const struct pci_dev *dev)
> > +{
> > +	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
> > +}
> > +
> >  #ifdef CONFIG_PCI_ATS
> >  void pci_restore_ats_state(struct pci_dev *dev);
> >  #else
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index ac876e3..611adcd 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2433,13 +2433,13 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
> >  	dev = pci_scan_single_device(bus, devfn);
> >  	if (!dev)
> >  		return 0;
> > -	if (!dev->is_added)
> > +	if (!pci_dev_is_added(dev))
> >  		nr++;
> >  
> >  	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
> >  		dev = pci_scan_single_device(bus, devfn + fn);
> >  		if (dev) {
> > -			if (!dev->is_added)
> > +			if (!pci_dev_is_added(dev))
> >  				nr++;
> >  			dev->multifunction = 1;
> >  		}
> > diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> > index 6f072ea..5e3d0dc 100644
> > --- a/drivers/pci/remove.c
> > +++ b/drivers/pci/remove.c
> > @@ -19,11 +19,12 @@ static void pci_stop_dev(struct pci_dev *dev)
> >  {
> >  	pci_pme_active(dev, false);
> >  
> > -	if (dev->is_added) {
> > +	if (pci_dev_is_added(dev)) {
> >  		device_release_driver(&dev->dev);
> >  		pci_proc_detach_device(dev);
> >  		pci_remove_sysfs_dev_files(dev);
> > -		dev->is_added = 0;
> > +
> > +		pci_dev_assign_added(dev, false);
> >  	}
> >  
> >  	if (dev->bus->self)
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 340029b..506125b 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -368,7 +368,6 @@ struct pci_dev {
> >  	unsigned int	transparent:1;		/* Subtractive decode bridge */
> >  	unsigned int	multifunction:1;	/* Multi-function device */
> >  
> > -	unsigned int	is_added:1;
> >  	unsigned int	is_busmaster:1;		/* Is busmaster */
> >  	unsigned int	no_msi:1;		/* May not use MSI */
> >  	unsigned int	no_64bit_msi:1; 	/* May only use 32-bit MSIs */
> > -- 
> > 1.9.1
> > 
