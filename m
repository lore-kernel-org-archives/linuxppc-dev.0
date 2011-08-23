Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18A56B6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 12:58:38 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7N2wax1011729
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2011 12:58:36 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7N2vJCd1323030
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2011 12:57:19 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7N2wYCr007743
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2011 12:58:35 +1000
Date: Tue, 23 Aug 2011 12:38:22 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110823023822.GO30097@yookeroo.fritz.box>
References: <20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822055509.GI30097@yookeroo.fritz.box>
	<1314027950.6866.242.camel@x201.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314027950.6866.242.camel@x201.home>
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, aafabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, benve@cisco.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 22, 2011 at 09:45:48AM -0600, Alex Williamson wrote:
> On Mon, 2011-08-22 at 15:55 +1000, David Gibson wrote:
> > On Sat, Aug 20, 2011 at 09:51:39AM -0700, Alex Williamson wrote:
> > > We had an extremely productive VFIO BoF on Monday.  Here's my attempt to
> > > capture the plan that I think we agreed to:
> > > 
> > > We need to address both the description and enforcement of device
> > > groups.  Groups are formed any time the iommu does not have resolution
> > > between a set of devices.  On x86, this typically happens when a
> > > PCI-to-PCI bridge exists between the set of devices and the iommu.  For
> > > Power, partitionable endpoints define a group.  Grouping information
> > > needs to be exposed for both userspace and kernel internal usage.  This
> > > will be a sysfs attribute setup by the iommu drivers.  Perhaps:
> > > 
> > > # cat /sys/devices/pci0000:00/0000:00:19.0/iommu_group
> > > 42
> > > 
> > > (I use a PCI example here, but attribute should not be PCI specific)
> > 
> > Ok.  Am I correct in thinking these group IDs are representing the
> > minimum granularity, and are therefore always static, defined only by
> > the connected hardware, not by configuration?
> 
> Yes, that's the idea.  An open question I have towards the configuration
> side is whether we might add iommu driver specific options to the
> groups.  For instance on x86 where we typically have B:D.F granularity,
> should we have an option not to trust multi-function devices and use a
> B:D granularity for grouping?

Right.  And likewise I can see a place for configuration parameters
like the present 'allow_unsafe_irqs'.  But these would be more-or-less
global options which affected the overall granularity, rather than
detailed configuration such as explicitly binding some devices into a
group, yes?

> > > >From there we have a few options.  In the BoF we discussed a model where
> > > binding a device to vfio creates a /dev/vfio$GROUP character device
> > > file.  This "group" fd provides provides dma mapping ioctls as well as
> > > ioctls to enumerate and return a "device" fd for each attached member of
> > > the group (similar to KVM_CREATE_VCPU).  We enforce grouping by
> > > returning an error on open() of the group fd if there are members of the
> > > group not bound to the vfio driver.  Each device fd would then support a
> > > similar set of ioctls and mapping (mmio/pio/config) interface as current
> > > vfio, except for the obvious domain and dma ioctls superseded by the
> > > group fd.
> > 
> > It seems a slightly strange distinction that the group device appears
> > when any device in the group is bound to vfio, but only becomes usable
> > when all devices are bound.
> > 
> > > Another valid model might be that /dev/vfio/$GROUP is created for all
> > > groups when the vfio module is loaded.  The group fd would allow open()
> > > and some set of iommu querying and device enumeration ioctls, but would
> > > error on dma mapping and retrieving device fds until all of the group
> > > devices are bound to the vfio driver.
> > 
> > Which is why I marginally prefer this model, although it's not a big
> > deal.
> 
> Right, we can also combine models.  Binding a device to vfio
> creates /dev/vfio$GROUP, which only allows a subset of ioctls and no
> device access until all the group devices are also bound.  I think
> the /dev/vfio/$GROUP might help provide an enumeration interface as well
> though, which could be useful.

I'm not entirely sure what you mean here.  But, that's now several
weak votes in favour of the always-present group devices, and none in
favour of the created-when-first-device-bound model, so I suggest we
take the /dev/vfio/$GROUP as our tentative approach.

> > > In either case, the uiommu interface is removed entirely since dma
> > > mapping is done via the group fd.  As necessary in the future, we can
> > > define a more high performance dma mapping interface for streaming dma
> > > via the group fd.  I expect we'll also include architecture specific
> > > group ioctls to describe features and capabilities of the iommu.  The
> > > group fd will need to prevent concurrent open()s to maintain a 1:1 group
> > > to userspace process ownership model.
> > 
> > A 1:1 group<->process correspondance seems wrong to me. But there are
> > many ways you could legitimately write the userspace side of the code,
> > many of them involving some sort of concurrency.  Implementing that
> > concurrency as multiple processes (using explicit shared memory and/or
> > other IPC mechanisms to co-ordinate) seems a valid choice that we
> > shouldn't arbitrarily prohibit.
> > 
> > Obviously, only one UID may be permitted to have the group open at a
> > time, and I think that's enough to prevent them doing any worse than
> > shooting themselves in the foot.
> 
> 1:1 group<->process is probably too strong.  Not allowing concurrent
> open()s on the group file enforces a single userspace entity is
> responsible for that group.  Device fds can be passed to other
> processes, but only retrieved via the group fd.  I suppose we could even
> branch off the dma interface into a different fd, but it seems like we
> would logically want to serialize dma mappings at each iommu group
> anyway.  I'm open to alternatives, this just seemed an easy way to do
> it.  Restricting on UID implies that we require isolated qemu instances
> to run as different UIDs.

Well.. yes and know.  It means guests which need to be isolated from
malicious interference with each other need different UIDs, but given
that if they have the same UID one qemu can kill() or ptrace() the
other, they're not isolated in that sense anyway.

It seems to me that running as the same UIDs with different device
groups assigned, the guests are still pretty well isolated from
accidental interference with each other.

>  I know that's a goal, but I don't know if we
> want to make it an assumption in the group security model.
> 
> > > Also on the table is supporting non-PCI devices with vfio.  To do this,
> > > we need to generalize the read/write/mmap and irq eventfd interfaces.
> > > We could keep the same model of segmenting the device fd address space,
> > > perhaps adding ioctls to define the segment offset bit position or we
> > > could split each region into it's own fd (VFIO_GET_PCI_BAR_FD(0),
> > > VFIO_GET_PCI_CONFIG_FD(), VFIO_GET_MMIO_FD(3)), though we're already
> > > suffering some degree of fd bloat (group fd, device fd(s), interrupt
> > > event fd(s), per resource fd, etc).  For interrupts we can overload
> > > VFIO_SET_IRQ_EVENTFD to be either PCI INTx or non-PCI irq 
> > 
> > Sounds reasonable.
> > 
> > > (do non-PCI
> > > devices support MSI?).
> > 
> > They can.  Obviously they might not have exactly the same semantics as
> > PCI MSIs, but I know we have SoC systems with (non-PCI) on-die devices
> > whose interrupts are treated by the (also on-die) root interrupt
> > controller in the same way as PCI MSIs.
> 
> Ok, I suppose we can define ioctls to enable these as we go.  We also
> need to figure out how non-PCI resources, interrupts, and iommu mapping
> restrictions are described via vfio.

Yeah.  On device tree platforms we'd want it to be bound to the device
tree representation in some way.

For platform devices, at least, could we have the index into the array
of resources take the place of BAR number for PCI?
> 
> > > For qemu, these changes imply we'd only support a model where we have a
> > > 1:1 group to iommu domain.  The current vfio driver could probably
> > > become vfio-pci as we might end up with more target specific vfio
> > > drivers for non-pci.  PCI should be able to maintain a simple -device
> > > vfio-pci,host=bb:dd.f to enable hotplug of individual devices.  We'll
> > > need to come up with extra options when we need to expose groups to
> > > guest for pvdma.
> > 
> > Are you saying that you'd no longer support the current x86 usage of
> > putting all of one guest's devices into a single domain?
> 
> Yes.  I'm not sure there's a good ROI to prioritize that model.  We have
> to assume >1 device per guest is a typical model and that the iotlb is
> large enough that we might improve thrashing to see both a resource and
> performance benefit from it.  I'm open to suggestions for how we could
> include it though.

Creating supergroups of some sort seems to be what we need, but I'm
not sure what's the best interface for doing that.

> > If that's
> > not what you're saying, how would the domains - now made up of a
> > user's selection of groups, rather than individual devices - be
> > configured?
> > 
> > > Hope that captures it, feel free to jump in with corrections and
> > > suggestions.  Thanks,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
