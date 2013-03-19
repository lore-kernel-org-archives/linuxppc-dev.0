Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 81E1A2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 15:20:05 +1100 (EST)
Message-ID: <1363666721.24132.472.camel@bling.home>
Subject: Re: [PATCH 2/3] VFIO: VFIO_DEVICE_SET_ADDR_MAPPING command
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 18 Mar 2013 22:18:41 -0600
In-Reply-To: <20130319032410.GA22591@shangw.(null)>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1363332390-12754-3-git-send-email-shangw@linux.vnet.ibm.com>
 <1363375740.16793.12.camel@ul30vt.home>
 <20130316013417.GA3873@shangw.(null)> <1363412256.1244.20.camel@pasglop>
 <1363640474.24132.433.camel@bling.home>
 <20130319032410.GA22591@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-03-19 at 11:24 +0800, Gavin Shan wrote:
> On Mon, Mar 18, 2013 at 03:01:14PM -0600, Alex Williamson wrote:
> >On Sat, 2013-03-16 at 06:37 +0100, Benjamin Herrenschmidt wrote:
> >> On Sat, 2013-03-16 at 09:34 +0800, Gavin Shan wrote:
> >> > >Could you explain further how this will be used?  How the device is
> >> > >exposed to a guest is entirely a userspace construct, so why does vfio
> >> > >need to know or care about this?  I had assumed for AER that QEMU would
> >> > >do the translation from host to guest address space.
> >> > >
> >> > 
> >> > The weak IOCTL function (vfio_pci_arch_ioctl) was introduced by previous
> >> > patch. The PowerNV platform is going to override it to figure out the
> >> > information for EEH core to use. On the other hand, QEMU will runs into
> >> > the IOCTL command while opening (creating) one VFIO device.
> >> > 
> >> > Though I'm not familiar with AER very much. AER is quite different from
> >> > EEH. The EEH functionality implemented in PHB instead of in PCI device
> >> > core. So we don't care AER stuff in EEH directly :-)
> >> 
> >> To give Alex a bit more background...
> >> 
> >> EEH is our IBM specific error handling facility which is a superset of AER.
> >> 
> >> IE. In addition to AER's error detection and logging, it adds a layer of
> >> error detection at the host bridge level (such as iommu violations etc...)
> >> and a mechanism for handling and recovering from errors. This is tied to
> >> our iommu domain stuff (our PE's) and our device "freezing" capability
> >> among others.
> >> 
> >> With VFIO + KVM, we want to implement most of the EEH support for guests in
> >> the host kernel. The reason is multipart and we can discuss this separately
> >> as some of it might well be debatable (mostly it's more convenient that way
> >> because we hook into the underlying HW/FW EEH which isn't directly userspace
> >> accessible so we don't have to add a new layer of kernel -> user API in
> >> addition to the VFIO stuff), but there's at least one aspect of it that drives
> >> this requirement more strongly which is performance:
> >> 
> >> When EEH is enabled, whenever any MMIO returns all 1's, the kernel will do
> >> a firmware call to query the EEH state of the device and check whether it
> >> has been frozen. On some devices, that can be a performance issue, and
> >> going all the way to qemu for that would be horribly expensive.
> >> 
> >> So we want at least a way to handle that call in the kernel and for that we
> >> need at least some way of mapping things there.
> >
> >There's no notification mechanism when a PHB is frozen?  I suppose
> >notification would be asynchronous so you risk data for every read that
> >happens in the interim.  So the choices are a) tell the host kernel the
> >mapping, b) tell the guest kernel the mapping, c) identity mapping, or
> >d) qemu intercept?
> >
> 
> We do have dedicated interrupts on detecting frozen PHB on host side.
> However, the guest has to poll/check the frozen state (frozen PE) during
> access to config or MMIO space.

Can you make use of something like this to notify the guest:

https://github.com/awilliam/linux-vfio/commit/dad9f8972e04cd081a028d8fb1249d746d97fc03

As a first step this only notifies QEMU, but the plan is to forward that
on to the guest.  If we can leverage similar interfaces between AER and
EEH, I'd obviously like to do that.

> For the recommended methods, (a) is what
> we want to do with the patchset. (b) seems infeasible since the guest
> shouldn't be aware of hypervisor (e.g. KVM or PowerVM) it's running on
> top of, it's hard to polish the guest to do it. (d) sounds applicable
> since the QEMU should know the address (BDF) of host and guest devices.
> However, we still need let the host EEH core know that which PCI device
> has been passed to guest and the best place to do that would be when opening
> the corresponding VFIO PCI device. In turn, it will still need weak function
> for ppc platform to override it. Why we not directly take (a) to finish
> everything in one VFIO IOCTL command?

Because it seems like VFIO is just being used as a relay and has no
purpose knowing this information on it's own.  It's just a convenient
place to host the ioctl, but that alone is not a good enough reason to
put it there.

> Sorry, Alex. I didn't understand (c) well :-)

(c) is if the buid/bus/slot/func exposed to the guest matches the same
for the host, then there's no need for mapping translation.

> >Presumably your firmware call to query the EEH is not going through
> >VFIO, so is VFIO the appropriate place to setup this mapping?  As you
> >say, this seems like just a convenient place to put it even though it
> >really has nothing to do with the VFIO kernel component.  QEMU has this
> >information and could register it with the host kernel through other
> >means if available.  Maybe the mapping should be registered with KVM if
> >that's how the EEH data is accessed.  I'm not yet sold on why this
> >mapping is registered here.  Thanks,
> >
> 
> Yes, EEH firmware call needn't going through VFIO. However, EEH has
> very close relationship with PCI and so VFIO-PCI does. Eventually, EEH
> has close relationship with VFIO-PCI :-)

Is there some plan to do more with EEH through VFIO in the future or are
we just talking about some kind of weird associative property to sell
this ioctl?  Thanks,

Alex
