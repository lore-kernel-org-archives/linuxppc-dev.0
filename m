Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2zj41l6yzDvjs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 14:51:19 +1100 (AEDT)
Date: Mon, 24 Oct 2016 22:51:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, benh@au1.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, clsoto@us.ibm.com
Subject: Re: [PATCH v2 2/2] PCI: Don't disable PF's memory decoding when
 enabling SRIOV
Message-ID: <20161025035113.GA21423@localhost>
References: <1475192870-7763-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1475192870-7763-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20161021165034.GE9007@localhost> <20161023232802.GA7215@gwshan>
 <20161024140316.GA14177@localhost> <20161025014728.GA32507@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161025014728.GA32507@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 25, 2016 at 12:47:28PM +1100, Gavin Shan wrote:
> On Mon, Oct 24, 2016 at 09:03:16AM -0500, Bjorn Helgaas wrote:
> >On Mon, Oct 24, 2016 at 10:28:02AM +1100, Gavin Shan wrote:
> >> On Fri, Oct 21, 2016 at 11:50:34AM -0500, Bjorn Helgaas wrote:
> >> >Hi Gavin,
> >> >
> >> >On Fri, Sep 30, 2016 at 09:47:50AM +1000, Gavin Shan wrote:
> >> >> pci_update_resource() might be called to update (shift) IOV BARs
> >> >> in PPC PowerNV specific pcibios_sriov_enable() when enabling PF's
> >> >> SRIOV capability. At that point, the PF have been functional if
> >> >> the SRIOV is enabled through sysfs entry "sriov_numvfs". The PF's
> >> >> memory decoding (0x2 in PCI_COMMAND) shouldn't be disabled when
> >> >> updating its IOV BARs with pci_update_resource(). Otherwise, we
> >> >> receives EEH error caused by MMIO access to PF's memory BARs during
> >> >> the window when PF's memory decoding is disabled.
> >> >
> >> >The fact that you get EEH errors is irrelevant.  We can't write code
> >> >simply to avoid errors -- we have to write code to make the system
> >> >work correctly.
> >> >
> >> >I do not want to add a "mmio_force_on" parameter to
> >> >pci_update_resource().  That puts the burden on the caller to
> >> >understand this subtle issue.  If the caller passes mmio_force_on=1
> >> >when it shouldn't, things will almost always work, but once in a blue
> >> >moon a half-updated BAR will conflict with some other device in the
> >> >system, and we'll have an unreproducible, undebuggable crash.
> >> >
> >> 
> >> Bjorn, thanks for your comments. Yes, the EEH error was caused by MMIO
> >> access to PF's normal BARs, not VF BARs. Yeah, I also had the conern
> >> that adding parameter to pci_update_resource() increases the visible
> >> complexity to the caller of the function.
> >> 
> >> >What you do need is an explanation of why it's safe to non-atomically
> >> >update a VF BARx in the SR-IOV capability.  I think this probably
> >> >involves the VF MSE bit, and you probably have to either disable VFs
> >> >completely or clear the MSE bit while you're updating the VF BARx.  We
> >> >should be able to do this inside pci_update_resource() without
> >> >changing the interface.
> >> >
> >> 
> >> Yes, It's what PATCH[1/2] does: (PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE)
> >> are set after VF BARs are updated with pci_update_resource() in this PPC
> >> specific scenario. There are other two situations where the IOV BARs are
> >> updated: PCI resource resizing and allocation during system booting or hot
> >> adding PF. The VF shouldn't be enabled in both cases when updating IOV BARs.
> >> 
> >> I think you suggest to add check in pci_update_resource(): Don't disable
> >> PF's memory decoding when updating VF BARs. I will send updated revision
> >> if it's what you want.
> >> 
> >> 	/*
> >> 	 * The PF might be functional when updating its IOV BARs. So PF's
> >> 	 * memory decoding shouldn't be disabled when updating its IOV BARs.
> >> 	 */
> >> 	disable = (res->flags & IORESOURCE_MEM_64) && !dev->mmio_always_on;
> >> #ifdef CONFIG_PCI_IOV
> >> 	disable &= !(resno >= PCI_IOV_RESOURCES &&
> >> 		     resno <= PCI_IOV_RESOURCE_END);
> >> #endif
> >> 	if (disable) {
> >> 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
> >> 		pci_write_config_word(dev, PCI_COMMAND,
> >> 				      cmd & ~PCI_COMMAND_MEMORY);
> >> 	}
> >
> >Not exactly.  A 64-bit BAR cannot be updated atomically.  The whole
> >point of this exercise is to make sure that when we update such a BAR,
> >whether it is a normal PCI BAR or an SR-IOV BAR, the transient state
> >does not conflict with anything else in the system.
> >
> >For example, consider two devices that do not conflict:
> >
> >  device A BAR 0: 0x00000000_20000000
> >  device B BAR 0: 0x00000000_40000000
> >
> >We want to update A's BAR 0 to 0x00000001_40000000.  We can't do the
> >update atomically, so we have this sequence:
> >
> >  before update:            device A BAR 0: 0x00000000_20000000
> >  after writing lower half: device A BAR 0: 0x00000000_40000000
> >  after writing upper half: device A BAR 0: 0x00000001_40000000
> >
> >If the driver for device B accesses B between the writes, both A and B
> >may respond, which is a fatal error.
> >
> 
> Thanks for the detailed explanation. Apart from pdev->mmio_always_on,
> the normal BARs are updated with PCI_COMMAND_MEMORY cleared. With
> PATCH[1/2], The IOV BARs are updated with PCI_SRIOV_CTRL_MSE and
> PCI_SRIOV_CTRL_VFE cleared in the problematic path the patch tried
> to address initially. However, I prefer your suggestion at end of
> the reply.
> 
> >Probably the *best* thing would be to make pci_update_resource()
> >return an error if it's asked to update a BAR that is enabled, but I
> >haven't looked at all the callers to see whether that's practical.
> >
> 
> It arguably enforces users to tackle the limitation: the memory
> decoding (PCI_COMMAND_MEMORY or PCI_SRIOV_CTRL_VFE) should be
> disabled before updating the BARs with pci_update_resource().
> It means user cannot call APIs in relatively relaxed order
> as before. For example, pci_enable_device() followed by
> pci_update_resource(), which is allowed previously, won't
> work.

That specific case (pci_enable_device() followed by
pci_update_resource()) should *not* work.  pci_enable_device() is
normally called by a driver's .probe() method, and after we call a
.probe() method, the PCI core shouldn't touch the device at all
because there's no means of mutual exclusion between the driver and
the PCI core.

I think pci_update_resource() should only be called in situations
where the caller already knows that nobody is using the device.  For
regular PCI BARs, that doesn't necessarily mean PCI_COMMAND_MEMORY is
turned off, because firmware leaves PCI_COMMAND_MEMORY enabled for
many devices, even though nobody is using them.

Anyway, I think that's a project for another day.  That's too much to
tackle for the limited problem you're trying to solve.

> We can hide the limitation inside pci_update_resource() because
> nobody accesses the device's memory space that is being updated
> by pci_update_resource(). 
> 
> >The current strategy in pci_update_resource() is to clear
> >PCI_COMMAND_MEMORY when updating a 64-bit memory BAR.  This only
> >applies to the regular PCI BARs 0-5.
> >
> >Extending that strategy to SR-IOV would mean clearing
> >PCI_SRIOV_CTRL_MSE when updating a 64-bit VF BAR.  Obviously you
> >wouldn't clear PCI_COMMAND_MEMORY in this case because
> >PCI_COMMAND_MEMORY doesn't affect the VF BARs.
> >
> 
> Yeah, it would be the solution to have. If you agree, I will post
> updatd version according to this: Clearing PCI_SRIOV_CTRL_MSE when
> updating IOV BARs. The bit won't be touched if pdev->mmio_always_on
> is true.

I think you should ignore pdev->mmio_always_on for IOV BARs.
mmio_always_on is basically a workaround for devices that either don't
follow the spec or where we didn't completely understand the problem.
I don't think there's any reason to set mmio_always_on for SR-IOV
devices.

Bjorn
