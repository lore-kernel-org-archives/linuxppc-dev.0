Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B0D62C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 14:24:23 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 18 Mar 2013 23:24:18 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 318CEC90028
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 23:24:15 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2J3OFH5272680
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 23:24:15 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2J3OE5v020723
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 00:24:14 -0300
Date: Tue, 19 Mar 2013 11:24:10 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/3] VFIO: VFIO_DEVICE_SET_ADDR_MAPPING command
Message-ID: <20130319032410.GA22591@shangw.(null)>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1363332390-12754-3-git-send-email-shangw@linux.vnet.ibm.com>
 <1363375740.16793.12.camel@ul30vt.home>
 <20130316013417.GA3873@shangw.(null)>
 <1363412256.1244.20.camel@pasglop>
 <1363640474.24132.433.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363640474.24132.433.camel@bling.home>
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, kvm@vger.kernel.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 18, 2013 at 03:01:14PM -0600, Alex Williamson wrote:
>On Sat, 2013-03-16 at 06:37 +0100, Benjamin Herrenschmidt wrote:
>> On Sat, 2013-03-16 at 09:34 +0800, Gavin Shan wrote:
>> > >Could you explain further how this will be used?  How the device is
>> > >exposed to a guest is entirely a userspace construct, so why does vfio
>> > >need to know or care about this?  I had assumed for AER that QEMU would
>> > >do the translation from host to guest address space.
>> > >
>> > 
>> > The weak IOCTL function (vfio_pci_arch_ioctl) was introduced by previous
>> > patch. The PowerNV platform is going to override it to figure out the
>> > information for EEH core to use. On the other hand, QEMU will runs into
>> > the IOCTL command while opening (creating) one VFIO device.
>> > 
>> > Though I'm not familiar with AER very much. AER is quite different from
>> > EEH. The EEH functionality implemented in PHB instead of in PCI device
>> > core. So we don't care AER stuff in EEH directly :-)
>> 
>> To give Alex a bit more background...
>> 
>> EEH is our IBM specific error handling facility which is a superset of AER.
>> 
>> IE. In addition to AER's error detection and logging, it adds a layer of
>> error detection at the host bridge level (such as iommu violations etc...)
>> and a mechanism for handling and recovering from errors. This is tied to
>> our iommu domain stuff (our PE's) and our device "freezing" capability
>> among others.
>> 
>> With VFIO + KVM, we want to implement most of the EEH support for guests in
>> the host kernel. The reason is multipart and we can discuss this separately
>> as some of it might well be debatable (mostly it's more convenient that way
>> because we hook into the underlying HW/FW EEH which isn't directly userspace
>> accessible so we don't have to add a new layer of kernel -> user API in
>> addition to the VFIO stuff), but there's at least one aspect of it that drives
>> this requirement more strongly which is performance:
>> 
>> When EEH is enabled, whenever any MMIO returns all 1's, the kernel will do
>> a firmware call to query the EEH state of the device and check whether it
>> has been frozen. On some devices, that can be a performance issue, and
>> going all the way to qemu for that would be horribly expensive.
>> 
>> So we want at least a way to handle that call in the kernel and for that we
>> need at least some way of mapping things there.
>
>There's no notification mechanism when a PHB is frozen?  I suppose
>notification would be asynchronous so you risk data for every read that
>happens in the interim.  So the choices are a) tell the host kernel the
>mapping, b) tell the guest kernel the mapping, c) identity mapping, or
>d) qemu intercept?
>

We do have dedicated interrupts on detecting frozen PHB on host side.
However, the guest has to poll/check the frozen state (frozen PE) during
access to config or MMIO space. For the recommended methods, (a) is what
we want to do with the patchset. (b) seems infeasible since the guest
shouldn't be aware of hypervisor (e.g. KVM or PowerVM) it's running on
top of, it's hard to polish the guest to do it. (d) sounds applicable
since the QEMU should know the address (BDF) of host and guest devices.
However, we still need let the host EEH core know that which PCI device
has been passed to guest and the best place to do that would be when opening
the corresponding VFIO PCI device. In turn, it will still need weak function
for ppc platform to override it. Why we not directly take (a) to finish
everything in one VFIO IOCTL command?

Sorry, Alex. I didn't understand (c) well :-)

>Presumably your firmware call to query the EEH is not going through
>VFIO, so is VFIO the appropriate place to setup this mapping?  As you
>say, this seems like just a convenient place to put it even though it
>really has nothing to do with the VFIO kernel component.  QEMU has this
>information and could register it with the host kernel through other
>means if available.  Maybe the mapping should be registered with KVM if
>that's how the EEH data is accessed.  I'm not yet sold on why this
>mapping is registered here.  Thanks,
>

Yes, EEH firmware call needn't going through VFIO. However, EEH has
very close relationship with PCI and so VFIO-PCI does. Eventually, EEH
has close relationship with VFIO-PCI :-)

Thanks,
Gavin
