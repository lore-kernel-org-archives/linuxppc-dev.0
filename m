Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DhQg3rYrzF0wf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 08:59:39 +1000 (AEST)
Date: Mon, 17 Sep 2018 17:59:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc: Sam Bobroff <sbobroff@linux.ibm.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux@yadro.com,
 Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: Re: [PATCH RFC 1/4] PCI: hotplug: Add parameter to put devices to
 reset during rescan
Message-ID: <20180917225935.GD54859@bhelgaas-glaptop.roam.corp.google.com>
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
 <20180914161404.4685-2-s.miroshnichenko@yadro.com>
 <20180917052800.GA7315@tungsten.ozlabs.ibm.com>
 <6b913e12-e8c8-30c1-5269-3029ddb00a4d@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6b913e12-e8c8-30c1-5269-3029ddb00a4d@yadro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc Russell, Ben, Oliver, linuxppc-dev]

On Mon, Sep 17, 2018 at 11:55:43PM +0300, Sergey Miroshnichenko wrote:
> Hello Sam,
> 
> On 9/17/18 8:28 AM, Sam Bobroff wrote:
> > Hi Sergey,
> > 
> > On Fri, Sep 14, 2018 at 07:14:01PM +0300, Sergey Miroshnichenko wrote:
> >> Introduce a new command line option "pci=pcie_movable_bars" that indicates
> >> support of PCIe hotplug without prior reservation of memory regions by
> >> BIOS/bootloader.
> >>
> >> If a new PCIe device has been hot-plugged between two active ones, which
> >> have no (or not big enough) gap between their BARs, allocating new BARs
> >> requires to move BARs of the following working devices:
> >>
> >> 1)                   dev 4
> >>                        |
> >>                        v
> >> .. |  dev 3  |  dev 3  |  dev 5  |  dev 7  |
> >> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
> >>
> >> 2)                             dev 4
> >>                                  |
> >>                                  v
> >> .. |  dev 3  |  dev 3  | -->           --> |  dev 5  |  dev 7  |
> >> .. |  BAR 0  |  BAR 1  | -->           --> |  BAR 0  |  BAR 0  |
> >>
> >> 3)
> >>
> >> .. |  dev 3  |  dev 3  |  dev 4  |  dev 4  |  dev 5  |  dev 7  |
> >> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
> >>
> >> Not only BARs, but also bridge windows can be updated during a PCIe rescan,
> >> threatening all memory transactions during this procedure, so the PCI
> >> subsystem will instruct the drivers to pause by calling the reset_prepare()
> >> and reset_done() callbacks.
> >>
> >> If a device may be affected by BAR movement, the BAR changes tracking must
> >> be implemented in its driver.
> >>
> >> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> >> ---
> >>  .../admin-guide/kernel-parameters.txt         |  6 +++
> >>  drivers/pci/pci.c                             |  2 +
> >>  drivers/pci/probe.c                           | 43 +++++++++++++++++++
> >>  include/linux/pci.h                           |  1 +
> >>  4 files changed, 52 insertions(+)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index 64a3bf54b974..f8132a709061 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -3311,6 +3311,12 @@
> >>  				bridges without forcing it upstream. Note:
> >>  				this removes isolation between devices and
> >>  				may put more devices in an IOMMU group.
> >> +		pcie_movable_bars	Arrange a space at runtime for BARs of
> >> +				hotplugged PCIe devices - usable if bootloader
> >> +				doesn't reserve memory regions for them. Freeing
> >> +				a space may require moving BARs of active devices
> >> +				to higher addresses, so device drivers will be
> >> +				paused during rescan.
> >>  
> >>  	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
> >>  			Management.
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 1835f3a7aa8d..5f07a59b5924 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -6105,6 +6105,8 @@ static int __init pci_setup(char *str)
> >>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
> >>  			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
> >>  				disable_acs_redir_param = str + 18;
> >> +			} else if (!strncmp(str, "pcie_movable_bars", 17)) {
> >> +				pci_add_flags(PCI_MOVABLE_BARS);
> >>  			} else {
> >>  				printk(KERN_ERR "PCI: Unknown option `%s'\n",
> >>  						str);
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index 201f9e5ff55c..bdaafc48dc4c 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -3138,6 +3138,45 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
> >>  	return max;
> >>  }
> >>  
> >> +/*
> >> + * Put all devices of the bus and its children to reset
> >> + */
> >> +static void pci_bus_reset_prepare(struct pci_bus *bus)
> >> +{
> >> +	struct pci_dev *dev;
> >> +
> >> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> >> +		struct pci_bus *child = dev->subordinate;
> >> +
> >> +		if (child) {
> >> +			pci_bus_reset_prepare(child);
> >> +		} else if (dev->driver &&
> >> +			   dev->driver->err_handler &&
> >> +			   dev->driver->err_handler->reset_prepare) {
> >> +			dev->driver->err_handler->reset_prepare(dev);
> >> +		}
> > 
> > What about devices with drivers that don't have reset_prepare()?  It
> > looks like it will just reconfigure them anyway. Is that right?
> > 
> 
> It is possible that unprepared driver without these hooks will get BARs
> moved, I should put a warning message there. There three ways we can see
> to make this safe:
>  - add the reset_prepare()/reset_done() hooks to *every* PCIe driver;
>  - refuse BAR movement if at least one unprepared driver has been
> encountered during rescan;
>  - reduce the number of drivers which can be affected to some
> controllable value and prepare them on demand.
> 
> Applying the second proposal as a major restriction seems fairly
> reasonable, but for our particular setups and use-cases it is probably
> too stiff:
>  - we've noticed that devices connected directly to the root bridge
> don't get moved BARs, and this covers our x86_64 servers: we only
> insert/remove devices into "second-level" and "lower" bridges there, but
> not root;
>  - on PowerNV we have system devices (network interfaces, USB hub, etc.)
> grouped into dedicated domain, with all other domains ready for hotplug,
> and only these domains can be rescanned.
> 
> With our scenarios currently reduced to these two, we can live with just
> a few drivers "prepared" for now: NVME and few Ethernet adapters, this
> gives us a possibility to use this feature before "converting" *all* the
> drivers, and even have the NVidia cards running on a closed proprietary
> driver.
> 
> Should we make this behavior adjustable with something like
> "pcie_movable_bars=safe" and "pcie_movable_bars=always" ?

I like the overall idea of this a lot.

  - Why do we need a command line parameter to enable this?  Can't we
    do it unconditionally and automatically when it's possible?  We
    could have a chicken switch to *disable* it in case this breaks
    something horribly, but I would like this functionality to be
    always available without a special option.

  - I'm not sure the existence of .reset_done() is evidence that a
    driver is prepared for its BARs to move.  I don't see any
    documentation that refers to BAR movement, and I doubt it's been
    tested.  But I only see 5 implementations in the tree, so it'd be
    easy to verify.
    
  - I think your second proposal above sounds right: we should regard
    any device whose driver lacks .reset_done() as immovable.  We will
    likely be able to move some devices but not others.  Implementing
    .reset_done() will increase flexibility but it shouldn't be a
    requirement for all drivers.

> >> +	}
> >> +}
> >> +
> >> +/*
> >> + * Complete the reset of all devices for the bus and its children
> >> + */
> >> +static void pci_bus_reset_done(struct pci_bus *bus)
> >> +{
> >> +	struct pci_dev *dev;
> >> +
> >> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> >> +		struct pci_bus *child = dev->subordinate;
> >> +
> >> +		if (child) {
> >> +			pci_bus_reset_done(child);
> >> +		} else if (dev->driver && dev->driver->err_handler &&
> >> +			   dev->driver->err_handler->reset_done) {
> >> +			dev->driver->err_handler->reset_done(dev);
> >> +		}
> >> +	}
> >> +}
> >> +
> >>  /**
> >>   * pci_rescan_bus - Scan a PCI bus for devices
> >>   * @bus: PCI bus to scan
> >> @@ -3151,8 +3190,12 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
> >>  {
> >>  	unsigned int max;
> >>  
> >> +	if (pci_has_flag(PCI_MOVABLE_BARS))
> >> +		pci_bus_reset_prepare(bus);
> >>  	max = pci_scan_child_bus(bus);
> >>  	pci_assign_unassigned_bus_resources(bus);
> >> +	if (pci_has_flag(PCI_MOVABLE_BARS))
> >> +		pci_bus_reset_done(bus);
> >>  	pci_bus_add_devices(bus);
> >>  
> >>  	return max;
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index 6925828f9f25..a8cb1a367c34 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -847,6 +847,7 @@ enum {
> >>  	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,	/* Enable domains in /proc */
> >>  	PCI_COMPAT_DOMAIN_0	= 0x00000020,	/* ... except domain 0 */
> >>  	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
> >> +	PCI_MOVABLE_BARS	= 0x00000080,	/* Runtime BAR reassign after hotplug */
> >>  };
> >>  
> >>  /* These external functions are only available when PCI support is enabled */
> >> -- 
> >> 2.17.1
> >>
