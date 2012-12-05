Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4029F2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2012 19:26:40 +1100 (EST)
Message-ID: <1354695989.2351.13.camel@pasglop>
Subject: Re: [linuxppc-release][PATCH] powerpc/pci-hotplug: fix init issue
 of rescanned pci device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chen Yuanquan-B41889 <B41889@freescale.com>
Date: Wed, 05 Dec 2012 19:26:29 +1100
In-Reply-To: <50BF03C1.2070304@freescale.com>
References: <1354674717-14426-1-git-send-email-B41889@freescale.com>
 <1354691878.2351.2.camel@pasglop> <50BF03C1.2070304@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, r61911@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-12-05 at 16:20 +0800, Chen Yuanquan-B41889 wrote:
> On 12/05/2012 03:17 PM, Benjamin Herrenschmidt wrote:
> > On Wed, 2012-12-05 at 10:31 +0800, Yuanquan Chen wrote:
> >> On powerpc arch, some fixup work of PCI/PCI-e device is just done during the
> >> first scan at booting time. For the PCI/PCI-e device rescanned after linux OS
> >> booting up, the fixup work won't be done, which leads to dma_set_mask error or
> >> irq related issue in rescanned PCI/PCI-e device's driver. So, it does the same
> >> fixup work for the rescanned device to avoid this issue.
> > Hrm, the patch is a bit gross. First the code shouldn't be copy/pasted
> > that way but factored out.

Please, at least format your email properly so I can try to undertand
without needing aspirin.

> There's a judgement "if (!bus->is_added)" before calling of 
> pcibios_fixup_bus in pci_scan_child_bus, so for the rescanned device,
> the fixup won't execute, which leads to fatal error in driver of rescanned
> device on freescale  powerpc, no this issues on x86 arch.

First, none of that invalidates my statement that you shouldn't
duplicate a whole block of code like this. Even if your approach is
correct (which is debated separately), at the very least you should
factor the code out into a common function between the two copies.

> Remove the judgement, let it to do the pcibios_fixup_bus
> directly, the error won't occur for the rescanned device. But it's 
> general code, not proper to change here, so copy the pcibios_fixup_bus
> work to  pcibios_enable_device.
>
> > I'm surprised also that is_added is false when pcibios_enable_device()
> > gets called ... that looks strange to me. At what point is that enable
> > happening in the hotplug sequence ?
> All devices are rescanned and then call the pci_enable_devices and 
> pci_bus_add_devices.

Where ? How ? What is the sequence happening ? In any case, I think if
we need a proper fixup done per-device like that after scan we ought to
create a new hook at the generic level rather than that sort of hack.

> The patch code will be called by pci_enable_devices. The "dev->is_added" 
> is set in pci_bus_add_device
> which is called by pci_bus_add_devices. So "dev->is_added" is false when 
> checking it in pcibios_enable_device
> for the rescanned device.

Who calls pci_enable_device() in the rescan case ? Why isn't it left to
the driver ? I don't think we can rely on that behaviour not to change.

> > How do you trigger the rescan anyway ?
> Use the interface under /sys :
> echo 1 > /sys/bus/pci/devices/xxx/remove
> 
> then echo 1 to the pci device which is the bus of the removed device
> echo 1 > /sys/bus/pci/devices/xxxx/rescan
> the removed device will be scanned and it's driver module will be loaded 
> automatically.

Yeah this code path are known to be fishy. I think the problem is at the
generic abstraction level and that's where it needs to be fixed.

Cheers,
Ben.

> Regards,
> yuanquan
> > I think the problem needs to be solve at a higher level, I'm adding
> > linux-pci & Bjorn to the CC list.
> >
> > Cheers,
> > Ben.
> >
> >> Signed-off-by: Yuanquan Chen <B41889@freescale.com>
> >> ---
> >>   arch/powerpc/kernel/pci-common.c |   20 ++++++++++++++++++++
> >>   1 file changed, 20 insertions(+)
> >>
> >> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> >> index 7f94f76..f0fb070 100644
> >> --- a/arch/powerpc/kernel/pci-common.c
> >> +++ b/arch/powerpc/kernel/pci-common.c
> >> @@ -1496,6 +1496,26 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
> >>   		if (ppc_md.pcibios_enable_device_hook(dev))
> >>   			return -EINVAL;
> >>   
> >> +	if (!dev->is_added) {
> >> +		/*
> >> +		 * Fixup NUMA node as it may not be setup yet by the generic
> >> +		 * code and is needed by the DMA init
> >> +		 */
> >> +		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
> >> +
> >> +		/* Hook up default DMA ops */
> >> +		set_dma_ops(&dev->dev, pci_dma_ops);
> >> +		set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
> >> +
> >> +		/* Additional platform DMA/iommu setup */
> >> +		if (ppc_md.pci_dma_dev_setup)
> >> +			ppc_md.pci_dma_dev_setup(dev);
> >> +
> >> +		/* Read default IRQs and fixup if necessary */
> >> +		pci_read_irq_line(dev);
> >> +		if (ppc_md.pci_irq_fixup)
> >> +			ppc_md.pci_irq_fixup(dev);
> >> +	}
> >>   	return pci_enable_resources(dev, mask);
> >>   }
> >>   
> >
> >
> >
> >
> 
