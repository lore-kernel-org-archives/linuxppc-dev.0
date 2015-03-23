Return-Path: <alex.williamson@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4704B1A2AC5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 08:08:18 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2E3D61400B6
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 08:08:16 +1100 (AEDT)
Message-ID: <1427144881.3643.680.camel@redhat.com>
Subject: Re: [PATCH v3 1/2] PCI: One more parameter to
 pci_set_pcie_reset_state()
From: Alex Williamson <alex.williamson@redhat.com>
To: cascardo@linux.vnet.ibm.com
Date: Mon, 23 Mar 2015 15:08:01 -0600
In-Reply-To: <20150323200729.GB1368@oc0812247204.ltc.br.ibm.com>
References: <1427079771-18472-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427081673.3643.547.camel@redhat.com> <20150323035656.GA27802@shangw>
 <1427083561.3643.551.camel@redhat.com> <20150323044033.GA1874@shangw>
 <1427114434.3643.554.camel@redhat.com>
 <20150323200729.GB1368@oc0812247204.ltc.br.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, Brian King <brking@us.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>, bhelgaas@google.com,
 Frank Haverkamp <haver@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-23 at 17:07 -0300, cascardo@linux.vnet.ibm.com wrote:
> On Mon, Mar 23, 2015 at 06:40:34AM -0600, Alex Williamson wrote:
> > On Mon, 2015-03-23 at 15:40 +1100, Gavin Shan wrote:
> > > On Sun, Mar 22, 2015 at 10:06:01PM -0600, Alex Williamson wrote:
> > > >On Mon, 2015-03-23 at 14:56 +1100, Gavin Shan wrote:
> > > >> On Sun, Mar 22, 2015 at 09:34:33PM -0600, Alex Williamson wrote:
> > > >> >On Mon, 2015-03-23 at 14:02 +1100, Gavin Shan wrote:
> > > >> >> The patch adds one more parameter ("probe") to pci_set_pcie_reset_state(),
> > > >> >> which allows to check if one particular PCI device can be resetted by the
> > > >> >> function. The function will be reused to support PCI device specific methods
> > > >> >> maintained in pci_dev_reset_methods[] in subsequent patch.
> > > >> >> 
> > > >> >> Cc: Brian King <brking@us.ibm.com>
> > > >> >> Cc: Frank Haverkamp <haver@linux.vnet.ibm.com>
> > > >> >> Cc: Ian Munsie <imunsie@au1.ibm.com>
> > > >> >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > > >> >> ---
> > > >> >> v3: Fix arguments of pci_set_pcie_reset_state() in cxl driver
> > > >> >> v2: Reimplemented based on pci_set_pcie_reset_state()
> > > >> >> ---
> > > >> >>  arch/powerpc/kernel/eeh.c       | 14 ++++++++++----
> > > >> >>  drivers/misc/cxl/pci.c          |  2 +-
> > > >> >>  drivers/misc/genwqe/card_base.c |  9 +++++++--
> > > >> >>  drivers/pci/pci.c               | 15 +++++++++------
> > > >> >>  drivers/scsi/ipr.c              |  5 +++--
> > > >> >>  include/linux/pci.h             |  5 +++--
> > > >> >>  6 files changed, 33 insertions(+), 17 deletions(-)
> > > >> >
> > > >> >
> > > >> >Argh, you're trying to make pci_set_pcie_reset_state() compatible with
> > > >> >pci_dev_specific_reset(), so it can be called via pci_reset_function(),
> > > >> >but the whole point of the pci_reset_function() interface is to reset a
> > > >> >*single* function without disturbing anything else.  These patches make
> > > >> >no effort at all to limit the set of affected devices to a single
> > > >> >function and take great liberties using PCI_ANY_ID for vendors.  My take
> > > >> >on the powerpc version of pcibios_set_pcie_reset_state() is that it's
> > > >> >effectively a slot reset, so why not hook into the
> > > >> >pci_reset_hotplug_slot() via the hotplug slot ops?  Please also use
> > > >> >cover letters.  Thanks,
> > > >> >
> > > >> 
> > > >> Yep, that's the point and intention of the patches. pcibios_set_pcie_reset_state()
> > > >> isn't equal to pci_reset_hotplug_slot(). The later one depends on PCI slot, which
> > > >> wasn't populated on PowerNV platform yet, but pcibios_set_pcie_reseet_state() doesn't.
> > > >> 
> > > >> The patchset depends on improved pcibios_set_pcie_reset_state(), which can be seen
> > > >> from following linked. With it, we don't affect any PCI devices as the config space
> > > >> is saved/restored accordingly before/after reset:
> > > >> 
> > > >> https://patchwork.ozlabs.org/patch/438598/
> > > >
> > > >Sorry, that's wrong.  pci_reset_function() can be called while other
> > > >devices in the same multifunction package are actively in use.  It
> > > >doesn't matter that you're saving and restoring the external state of
> > > >the device, the internal state is lost and operation of the device is
> > > >interrupted.  That is not how pci_reset_function() is supposed to work.
> > > >Thanks,
> > > >
> > > 
> > > pcibios_set_pcie_reset_state() applies hot reset on PCI bus, or PCI
> > > slot fundamental reset essentially. It's potentially affecting multiple
> > > PCI devices (not functions).
> > > 
> > > Yes. It's not safe to call pcibios_set_pcie_reset_state() if some of
> > > the target functions are actively and in use. I also suspect if it
> > > works to reset function#0 via pci_reset_function() while function#1
> > > is actively in use? I guess the caller of pci_reset_function() perhaps
> > > has to ensure there are no active functions/devices.
> > > 
> > > One of the issues the patches try to fix: some of broadcom adapters have
> > > multile functions, which can't support FLR, AF FLR, PM reset. Also, reset
> > > on parent PCI bus and the corresponding reset can't be applied because of
> > > they're multi-function package. In summary, pci_reset_function() doesn't
> > > work on the adapters. That won't give clean state when passing device from
> > > host to guest, or return it back to host. Sometimes, the host memory gets
> > > corrupted when destorying the guest. Occasionally, the patches with improved
> > > pcibios_set_pcie_reset_state() avoided the issue.
> > > 
> > > Some adapters might require fundamental reset on the PCI slot, or hot reset
> > > on parent bus explicitly, in order to successfully reload its firmware after
> > > reset.
> > 
> > This is exactly why we have pci_reset_slot() and pci_reset_bus(), so
> > that the caller can manage the scope of the reset.  You cannot change
> > the semantics of pci_reset_function() simply because it's convenient for
> > your implementation.  This series is wrong and should not be applied.
> > Thanks,
> > 
> > Alex
> > 
> 
> 
> Alex,
> 
> I agree with you here. I think the bigger issue is that we are not
> making sure VFIO is secure, allowing functions to be assigned separately
> to different guests, even when we cannot guarantee we can safely reset a
> single function, and also ignoring the possibility of internal
> communication between functions. This second problem is real, since some
> adapters will allow firmware to be loaded or reset, which will affect
> other functions.
> 
> We need to either have in written that this is acceptable and that
> higher layers should take care of these possibilities, if they care
> about them, or we need to fix this, by making VFIO only accept a whole
> group of functions to be assigned to a guest, which will allow the
> problem described by Gavin to be properly handled, by using slot reset
> functions, or another way of grouping devices that may be specific to
> the platform.
> 
> Does it make sense?

I don't know what you're doing on POWER, I thought groups were
equivalent to PEs, but on x86 we learn about isolation of PCI functions
by standard PCI properties.  Devices need to tell us that they're
isolated via ACS capabilities (or quirks, with vendor approval).
Otherwise we assume there is no isolation and multi-function devices
will be grouped together, preventing the individual functions from being
assigned to separate userspace instances.  VFIO does not ignore the
problem of internal communication between functions, it uses ACS... at
least on most platforms.

Firmware shared between functions is an unsolvable problem outside of
restricting device assignment only to SR-IOV virtual functions.  We
cannot know the programming method to block firmware updates of an
assigned device nor can we control which functions share the firmware.
If you're worried about this level of attack against the hardware, use
VFs exclusively.

If you're unsatisfied with the grouping of devices on your platform,
this is entirely within your control since VFIO relies on IOMMU groups,
which are managed via the platform IOMMU driver.  If your IOMMU driver
is arbitrarily splitting each PCI function into a separate group without
testing the isolation, that's a problem with IOMMU groups on your
platform.  If you would like to add a reset requirement to a group, you
have the ability to do that.  On x86, I expect this would be far too
restrictive.

VFIO also knows how to do bus and slot resets, the pci_reset_bus() and
pci_reset_slot() interfaces were added by me with vfio-pci as the first
user.  Resets are generally handled as best effort though and this is
sometimes a property of a device that might make it unsuitable for
device assignment.

The fact that you're implying above that the devices covered by the
device specific reset proposed in this series can be assigned separately
makes ignoring the scope of pci_reset_function() all the more wrong.  If
you want to change grouping on POWER to require that a group can be
reset, that's an IOMMU driver issue.  If you want to make a change to
VFIO to require an opt-in/out of allowing access to groups without a
reset, then propose something.  Just please don't ignore the semantics
of existing functions because it's a quicker and easier hack than doing
it correctly.  Thanks,

Alex
