Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 9B4E4B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Jul 2011 04:20:26 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 30 Jul 2011 12:20:08 -0600
In-Reply-To: <1311983933.8793.42.camel@pasglop>
References: <1311983933.8793.42.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312050011.2265.185.camel@x201.home>
Mime-Version: 1.0
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	David Gibson <dwg@au1.ibm.com>, aafabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>,
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

On Sat, 2011-07-30 at 09:58 +1000, Benjamin Herrenschmidt wrote:
> Hi folks !
> 
> So I promised Anthony I would try to summarize some of the comments &
> issues we have vs. VFIO after we've tried to use it for PCI pass-through
> on POWER. It's pretty long, there are various items with more or less
> impact, some of it is easily fixable, some are API issues, and we'll
> probably want to discuss them separately, but for now here's a brain
> dump.

Thanks Ben.  For those wondering what happened to VFIO and where it
lives now, Tom Lyon turned it over to me.  I've been continuing to hack
and bug fix and prep it for upstream.  My trees are here:

git://github.com/awilliam/linux-vfio.git vfio
git://github.com/awilliam/qemu-vfio.git vfio

I was hoping we were close to being ready for an upstream push, but we
obviously need to work through the issues Ben and company have been
hitting.

> David, Alexei, please make sure I haven't missed anything :-)
> 
> * Granularity of pass-through
> 
> So let's first start with what is probably the main issue and the most
> contentious, which is the problem of dealing with the various
> constraints which define the granularity of pass-through, along with
> exploiting features like the VTd iommu domains.
> 
> For the sake of clarity, let me first talk a bit about the "granularity"
> issue I've mentioned above.
> 
> There are various constraints that can/will force several devices to be
> "owned" by the same guest and on the same side of the host/guest
> boundary. This is generally because some kind of HW resource is shared
> and thus not doing so would break the isolation barrier and enable a
> guest to disrupt the operations of the host and/or another guest.
> 
> Some of those constraints are well know, such as shared interrupts. Some
> are more subtle, for example, if a PCIe->PCI bridge exist in the system,
> there is no way for the iommu to identify transactions from devices
> coming from the PCI segment of that bridge with a granularity other than
> "behind the bridge". So typically a EHCI/OHCI/OHCI combo (a classic)
> behind such a bridge must be treated as a single "entity" for
> pass-trough purposes.

On x86, the USB controllers don't typically live behind a PCIe-to-PCI
bridge, so don't suffer the source identifier problem, but they do often
share an interrupt.  But even then, we can count on most modern devices
supporting PCI2.3, and thus the DisINTx feature, which allows us to
share interrupts.  In any case, yes, it's more rare but we need to know
how to handle devices behind PCI bridges.  However I disagree that we
need to assign all the devices behind such a bridge to the guest.
There's a difference between removing the device from the host and
exposing the device to the guest.  If I have a NIC and HBA behind a
bridge, it's perfectly reasonable that I might only assign the NIC to
the guest, but as you describe, we then need to prevent the host, or any
other guest from making use of the HBA.

> In IBM POWER land, we call this a "partitionable endpoint" (the term
> "endpoint" here is historic, such a PE can be made of several PCIe
> "endpoints"). I think "partitionable" is a pretty good name tho to
> represent the constraints, so I'll call this a "partitionable group"
> from now on. 
> 
> Other examples of such HW imposed constraints can be a shared iommu with
> no filtering capability (some older POWER hardware which we might want
> to support fall into that category, each PCI host bridge is its own
> domain but doesn't have a finer granularity... however those machines
> tend to have a lot of host bridges :)
> 
> If we are ever going to consider applying some of this to non-PCI
> devices (see the ongoing discussions here), then we will be faced with
> the crazyness of embedded designers which probably means all sort of new
> constraints we can't even begin to think about
> 
> This leads me to those initial conclusions:
> 
> - The -minimum- granularity of pass-through is not always a single
> device and not always under SW control

But IMHO, we need to preserve the granularity of exposing a device to a
guest as a single device.  That might mean some devices are held hostage
by an agent on the host.

> - Having a magic heuristic in libvirt to figure out those constraints is
> WRONG. This reeks of XFree 4 PCI layer trying to duplicate the kernel
> knowledge of PCI resource management and getting it wrong in many many
> cases, something that took years to fix essentially by ripping it all
> out. This is kernel knowledge and thus we need the kernel to expose in a
> way or another what those constraints are, what those "partitionable
> groups" are.
> 
> - That does -not- mean that we cannot specify for each individual device
> within such a group where we want to put it in qemu (what devfn etc...).
> As long as there is a clear understanding that the "ownership" of the
> device goes with the group, this is somewhat orthogonal to how they are
> represented in qemu. (Not completely... if the iommu is exposed to the
> guest ,via paravirt for example, some of these constraints must be
> exposed but I'll talk about that more later).

Or we can choose not to expose all of the devices in the group to the
guest?

> The interface currently proposed for VFIO (and associated uiommu)
> doesn't handle that problem at all. Instead, it is entirely centered
> around a specific "feature" of the VTd iommu's for creating arbitrary
> domains with arbitrary devices (tho those devices -do- have the same
> constraints exposed above, don't try to put 2 legacy PCI devices behind
> the same bridge into 2 different domains !), but the API totally ignores
> the problem, leaves it to libvirt "magic foo" and focuses on something
> that is both quite secondary in the grand scheme of things, and quite
> x86 VTd specific in the implementation and API definition.

To be fair, libvirt's "magic foo" is built out of the necessity that
nobody else is defining the rules.

> Now, I'm not saying these programmable iommu domains aren't a nice
> feature and that we shouldn't exploit them when available, but as it is,
> it is too much a central part of the API.
> 
> I'll talk a little bit more about recent POWER iommu's here to
> illustrate where I'm coming from with my idea of groups:
> 
> On p7ioc (the IO chip used on recent P7 machines), there -is- a concept
> of domain and a per-RID filtering. However it differs from VTd in a few
> ways:
> 
> The "domains" (aka PEs) encompass more than just an iommu filtering
> scheme. The MMIO space and PIO space are also segmented, and those
> segments assigned to domains. Interrupts (well, MSI ports at least) are
> assigned to domains. Inbound PCIe error messages are targeted to
> domains, etc...
> 
> Basically, the PEs provide a very strong isolation feature which
> includes errors, and has the ability to immediately "isolate" a PE on
> the first occurence of an error. For example, if an inbound PCIe error
> is signaled by a device on a PE or such a device does a DMA to a
> non-authorized address, the whole PE gets into error state. All
> subsequent stores (both DMA and MMIO) are swallowed and reads return all
> 1's, interrupts are blocked. This is designed to prevent any propagation
> of bad data, which is a very important feature in large high reliability
> systems.
> 
> Software then has the ability to selectively turn back on MMIO and/or
> DMA, perform diagnostics, reset devices etc...
> 
> Because the domains encompass more than just DMA, but also segment the
> MMIO space, it is not practical at all to dynamically reconfigure them
> at runtime to "move" devices into domains. The firmware or early kernel
> code (it depends) will assign devices BARs using an algorithm that keeps
> them within PE segment boundaries, etc....
> 
> Additionally (and this is indeed a "restriction" compared to VTd, though
> I expect our future IO chips to lift it to some extent), PE don't get
> separate DMA address spaces. There is one 64-bit DMA address space per
> PCI host bridge, and it is 'segmented' with each segment being assigned
> to a PE. Due to the way PE assignment works in hardware, it is not
> practical to make several devices share a segment unless they are on the
> same bus. Also the resulting limit in the amount of 32-bit DMA space a
> device can access means that it's impractical to put too many devices in
> a PE anyways. (This is clearly designed for paravirt iommu, I'll talk
> more about that later).
> 
> The above essentially extends the granularity requirement (or rather is
> another factor defining what the granularity of partitionable entities
> is). You can think of it as "pre-existing" domains.
> 
> I believe the way to solve that is to introduce a kernel interface to
> expose those "partitionable entities" to userspace. In addition, it
> occurs to me that the ability to manipulate VTd domains essentially
> boils down to manipulating those groups (creating larger ones with
> individual components).
> 
> I like the idea of defining / playing with those groups statically
> (using a command line tool or sysfs, possibly having a config file
> defining them in a persistent way) rather than having their lifetime
> tied to a uiommu file descriptor.
> 
> It also makes it a LOT easier to have a channel to manipulate
> platform/arch specific attributes of those domains if any.
> 
> So we could define an API or representation in sysfs that exposes what
> the partitionable entities are, and we may add to it an API to
> manipulate them. But we don't have to and I'm happy to keep the
> additional SW grouping you can do on VTd as a sepparate "add-on" API
> (tho I don't like at all the way it works with uiommu). However, qemu
> needs to know what the grouping is regardless of the domains, and it's
> not nice if it has to manipulate two different concepts here so
> eventually those "partitionable entities" from a qemu standpoint must
> look like domains.
> 
> My main point is that I don't want the "knowledge" here to be in libvirt
> or qemu. In fact, I want to be able to do something as simple as passing
> a reference to a PE to qemu (sysfs path ?) and have it just pickup all
> the devices in there and expose them to the guest.
> 
> This can be done in a way that isn't PCI specific as well (the
> definition of the groups and what is grouped would would obviously be
> somewhat bus specific and handled by platform code in the kernel).
> 
> Maybe something like /sys/devgroups ? This probably warrants involving
> more kernel people into the discussion.

I don't yet buy into passing groups to qemu since I don't buy into the
idea of always exposing all of those devices to qemu.  Would it be
sufficient to expose iommu nodes in sysfs that link to the devices
behind them and describe properties and capabilities of the iommu
itself?  More on this at the end.

> * IOMMU
> 
> Now more on iommu. I've described I think in enough details how ours
> work, there are others, I don't know what freescale or ARM are doing,
> sparc doesn't quite work like VTd either, etc...
> 
> The main problem isn't that much the mechanics of the iommu but really
> how it's exposed (or not) to guests.
> 
> VFIO here is basically designed for one and only one thing: expose the
> entire guest physical address space to the device more/less 1:1.
> 
> This means:
> 
>   - It only works with iommu's that provide complete DMA address spaces
> to devices. Won't work with a single 'segmented' address space like we
> have on POWER.
> 
>   - It requires the guest to be pinned. Pass-through -> no more swap
> 
>   - The guest cannot make use of the iommu to deal with 32-bit DMA
> devices, thus a guest with more than a few G of RAM (I don't know the
> exact limit on x86, depends on your IO hole I suppose), and you end up
> back to swiotlb & bounce buffering.
> 
>   - It doesn't work for POWER server anyways because of our need to
> provide a paravirt iommu interface to the guest since that's how pHyp
> works today and how existing OSes expect to operate.
> 
> Now some of this can be fixed with tweaks, and we've started doing it
> (we have a working pass-through using VFIO, forgot to mention that, it's
> just that we don't like what we had to do to get there).

This is a result of wanting to support *unmodified* x86 guests.  We
don't have the luxury of having a predefined pvDMA spec that all x86
OSes adhere to.  The 32bit problem is unfortunate, but the priority use
case for assigning devices to guests is high performance I/O, which
usually entails modern, 64bit hardware.  I'd like to see us get to the
point of having emulated IOMMU hardware on x86, which could then be
backed by VFIO, but for now guest pinning is the most practical and
useful.

> Basically, what we do today is:
> 
> - We add an ioctl to VFIO to expose to qemu the segment information. IE.
> What is the DMA address and size of the DMA "window" usable for a given
> device. This is a tweak, that should really be handled at the "domain"
> level.
> 
> That current hack won't work well if two devices share an iommu. Note
> that we have an additional constraint here due to our paravirt
> interfaces (specificed in PAPR) which is that PE domains must have a
> common parent. Basically, pHyp makes them look like a PCIe host bridge
> per domain in the guest. I think that's a pretty good idea and qemu
> might want to do the same.
> 
> - We hack out the currently unconditional mapping of the entire guest
> space in the iommu. Something will have to be done to "decide" whether
> to do that or not ... qemu argument -> ioctl ?
> 
> - We hook up the paravirt call to insert/remove a translation from the
> iommu to the VFIO map/unmap ioctl's.
> 
> This limps along but it's not great. Some of the problems are:
> 
> - I've already mentioned, the domain problem again :-) 
> 
> - Performance sucks of course, the vfio map ioctl wasn't mean for that
> and has quite a bit of overhead. However we'll want to do the paravirt
> call directly in the kernel eventually ...
> 
>   - ... which isn't trivial to get back to our underlying arch specific
> iommu object from there. We'll probably need a set of arch specific
> "sideband" ioctl's to "register" our paravirt iommu "bus numbers" and
> link them to the real thing kernel-side.
> 
> - PAPR (the specification of our paravirt interface and the expectation
> of current OSes) wants iommu pages to be 4k by default, regardless of
> the kernel host page size, which makes things a bit tricky since our
> enterprise host kernels have a 64k base page size. Additionally, we have
> new PAPR interfaces that we want to exploit, to allow the guest to
> create secondary iommu segments (in 64-bit space), which can be used
> (under guest control) to do things like map the entire guest (here it
> is :-) or use larger iommu page sizes (if permitted by the host kernel,
> in our case we could allow 64k iommu page size with a 64k host kernel).
> 
> The above means we need arch specific APIs. So arch specific vfio
> ioctl's, either that or kvm ones going to vfio or something ... the
> current structure of vfio/kvm interaction doesn't make it easy.

FYI, we also have large page support for x86 VT-d, but it seems to only
be opportunistic right now.  I'll try to come back to the rest of this
below.

> * IO space
> 
> On most (if not all) non-x86 archs, each PCI host bridge provide a
> completely separate PCI address space. Qemu doesn't deal with that very
> well. For MMIO it can be handled since those PCI address spaces are
> "remapped" holes in the main CPU address space so devices can be
> registered by using BAR + offset of that window in qemu MMIO mapping.
> 
> For PIO things get nasty. We have totally separate PIO spaces and qemu
> doesn't seem to like that. We can try to play the offset trick as well,
> we haven't tried yet, but basically that's another one to fix. Not a
> huge deal I suppose but heh ...
> 
> Also our next generation chipset may drop support for PIO completely.
> 
> On the other hand, because PIO is just a special range of MMIO for us,
> we can do normal pass-through on it and don't need any of the emulation
> done qemu.

Maybe we can add mmap support to PIO regions on non-x86.

>   * MMIO constraints
> 
> The QEMU side VFIO code hard wires various constraints that are entirely
> based on various requirements you decided you have on x86 but don't
> necessarily apply to us :-)
> 
> Due to our paravirt nature, we don't need to masquerade the MSI-X table
> for example. At all. If the guest configures crap into it, too bad, it
> can only shoot itself in the foot since the host bridge enforce
> validation anyways as I explained earlier. Because it's all paravirt, we
> don't need to "translate" the interrupt vectors & addresses, the guest
> will call hyercalls to configure things anyways.

With interrupt remapping, we can allow the guest access to the MSI-X
table, but since that takes the host out of the loop, there's
effectively no way for the guest to correctly program it directly by
itself.

> We don't need to prevent MMIO pass-through for small BARs at all. This
> should be some kind of capability or flag passed by the arch. Our
> segmentation of the MMIO domain means that we can give entire segments
> to the guest and let it access anything in there (those segments are a
> multiple of the page size always). Worst case it will access outside of
> a device BAR within a segment and will cause the PE to go into error
> state, shooting itself in the foot, there is no risk of side effect
> outside of the guest boundaries.

Sure, this could be some kind of capability flag, maybe even implicit in
certain configurations.

> In fact, we don't even need to emulate BAR sizing etc... in theory. Our
> paravirt guests expect the BARs to have been already allocated for them
> by the firmware and will pick up the addresses from the device-tree :-)
> 
> Today we use a "hack", putting all 0's in there and triggering the linux
> code path to reassign unassigned resources (which will use BAR
> emulation) but that's not what we are -supposed- to do. Not a big deal
> and having the emulation there won't -hurt- us, it's just that we don't
> really need any of it.
> 
> We have a small issue with ROMs. Our current KVM only works with huge
> pages for guest memory but that is being fixed. So the way qemu maps the
> ROM copy into the guest address space doesn't work. It might be handy
> anyways to have a way for qemu to use MMIO emulation for ROM access as a
> fallback. I'll look into it.

So that means ROMs don't work for you on emulated devices either?  The
reason we read it once and map it into the guest is because Michael
Tsirkin found a section in the PCI spec that indicates devices can share
address decoders between BARs and ROM.  This means we can't just leave
the enabled bit set in the ROM BAR, because it could actually disable an
address decoder for a regular BAR.  We could slow-map the actual ROM,
enabling it around each read, but shadowing it seemed far more
efficient.

>   * EEH
> 
> This is the name of those fancy error handling & isolation features I
> mentioned earlier. To some extent it's a superset of AER, but we don't
> generally expose AER to guests (or even the host), it's swallowed by
> firmware into something else that provides a superset (well mostly) of
> the AER information, and allow us to do those additional things like
> isolating/de-isolating, reset control etc...
> 
> Here too, we'll need arch specific APIs through VFIO. Not necessarily a
> huge deal, I mention it for completeness.

We expect to do AER via the VFIO netlink interface, which even though
its bashed below, would be quite extensible to supporting different
kinds of errors.

>    * Misc
> 
> There's lots of small bits and pieces... in no special order:
> 
>  - netlink ? WTF ! Seriously, we don't need a hybrid API with a bit of
> netlink and a bit of ioctl's ... it's not like there's something
> fundamentally  better for netlink vs. ioctl... it really depends what
> you are doing, and in this case I fail to see what netlink brings you
> other than bloat and more stupid userspace library deps.

The netlink interface is primarily for host->guest signaling.  I've only
implemented the remove command (since we're lacking a pcie-host in qemu
to do AER), but it seems to work quite well.  If you have suggestions
for how else we might do it, please let me know.  This seems to be the
sort of thing netlink is supposed to be used for.

>  - I don't like too much the fact that VFIO provides yet another
> different API to do what we already have at least 2 kernel APIs for, ie,
> BAR mapping and config space access. At least it should be better at
> using the backend infrastructure of the 2 others (sysfs & procfs). I
> understand it wants to filter in some case (config space) and -maybe-
> yet another API is the right way to go but allow me to have my doubts.

The use of PCI sysfs is actually one of my complaints about current
device assignment.  To do assignment with an unprivileged guest we need
to open the PCI sysfs config file for it, then change ownership on a
handful of other PCI sysfs files, then there's this other pci-stub thing
to maintain ownership, but the kvm ioctls don't actually require it and
can grab onto any free device...  We are duplicating some of that in
VFIO, but we also put the ownership of the device behind a single device
file.  We do have the uiommu problem that we can't give an unprivileged
user ownership of that, but your usage model may actually make that
easier.  More below...

> One thing I thought about but you don't seem to like it ... was to use
> the need to represent the partitionable entity as groups in sysfs that I
> talked about earlier. Those could have per-device subdirs with the usual
> config & resource files, same semantic as the ones in the real device,
> but when accessed via the group they get filtering. I might or might not
> be practical in the end, tbd, but it would allow apps using a slightly
> modified libpci for example to exploit some of this.

I may be tainted by our disagreement that all the devices in a group
need to be exposed to the guest and qemu could just take a pointer to a
sysfs directory.  That seems very unlike qemu and pushes more of the
policy into qemu, which seems like the wrong direction.

>  - The qemu vfio code hooks directly into ioapic ... of course that
> won't fly with anything !x86

I spent a lot of time looking for an architecture neutral solution here,
but I don't think it exists.  Please prove me wrong.  The problem is
that we have to disable INTx on an assigned device after it fires (VFIO
does this automatically).  If we don't do this, a non-responsive or
malicious guest could sit on the interrupt, causing it to fire
repeatedly as a DoS on the host.  The only indication that we can rely
on to re-enable INTx is when the guest CPU writes an EOI to the APIC.
We can't just wait for device accesses because a) the device CSRs are
(hopefully) direct mapped and we'd have to slow map them or attempt to
do some kind of dirty logging to detect when they're accesses b) what
constitutes an interrupt service is device specific.

That means we need to figure out how PCI interrupt 'A' (or B...)
translates to a GSI (Global System Interrupt - ACPI definition, but
hopefully a generic concept).  That GSI identifies a pin on an IOAPIC,
which will also see the APIC EOI.  And just to spice things up, the
guest can change the PCI to GSI mappings via ACPI.  I think the set of
callbacks I've added are generic (maybe I left ioapic in the name), but
yes they do need to be implemented for other architectures.  Patches
appreciated from those with knowledge of the systems and/or access to
device specs.  This is the only reason that I make QEMU VFIO only build
for x86.

>  - The various "objects" dealt with here, -especially- interrupts and
> iommu, need a better in-kernel API so that fast in-kernel emulation can
> take over from qemu based emulation. The way we need to do some of this
> on POWER differs from x86. We can elaborate later, it's not necessarily
> a killer either but essentially we'll take the bulk of interrupt
> handling away from VFIO to the point where it won't see any of it at
> all.

The plan for x86 is to connect VFIO eventfds directly to KVM irqfds and
bypass QEMU.  This is exactly what VHOST does today and fairly trivial
to enable for MSI once we get it merged.  INTx would require us to be
able to define a level triggered irqfd in KVM and it's not yet clear if
we care that much about INTx performance.

We don't currently have a plan for accelerating IOMMU access since our
current usage model doesn't need one.  We also need to consider MSI-X
table acceleration for x86.  I hope we'll be able to use the new KVM
ioctls for this.

>   - Non-PCI devices. That's a hot topic for embedded. I think the vast
> majority here is platform devices. There's quite a bit of vfio that
> isn't intrinsically PCI specific. We could have an in-kernel platform
> driver like we have an in-kernel PCI driver to attach to. The mapping of
> resources to userspace is rather generic, as goes for interrupts. I
> don't know whether that idea can be pushed much further, I don't have
> the bandwidth to look into it much at this point, but maybe it would be
> possible to refactor vfio a bit to better separate what is PCI specific
> to what is not. The idea would be to move the PCI specific bits to
> inside the "placeholder" PCI driver, and same goes for platform bits.
> "generic" ioctl's go to VFIO core, anything that doesn't handle, it
> passes them to the driver which allows the PCI one to handle things
> differently than the platform one, maybe an amba one while at it,
> etc.... just a thought, I haven't gone into the details at all.

This is on my radar, but I don't have a good model for it either.  I
suspect there won't be a whole lot left of VFIO if we make all the PCI
bits optional.  The right approach might be to figure out what's missing
between UIO and VFIO for non-PCI, implement that as a driver, then see
if we can base VFIO on using that for MMIO/PIO/INTx, leaving config and
MSI as a VFIO layer on top of the new UIO driver.

> I think that's all I had on my plate today, it's a long enough email
> anyway :-) Anthony suggested we put that on a wiki, I'm a bit
> wiki-disabled myself so he proposed to pickup my email and do that. We
> should probably discuss the various items in here separately as
> different threads to avoid too much confusion.
> 
> One other thing we should do on our side is publish somewhere our
> current hacks to get you an idea of where we are going and what we had
> to do (code speaks more than words). We'll try to do that asap, possibly
> next week.
> 
> Note that I'll be on/off the next few weeks, travelling and doing
> bringup. So expect latency in my replies.

Thanks for the write up, I think it will be good to let everyone digest
it before we discuss this at KVM forum.

Rather than your "groups" idea, I've been mulling over whether we can
just expose the dependencies, configuration, and capabilities in sysfs
and build qemu commandlines to describe it.  For instance, if we simply
start with creating iommu nodes in sysfs, we could create links under
each iommu directory to the devices behind them.  Some kind of
capability file could define properties like whether it's page table
based or fixed iova window or the granularity of mapping the devices
behind it.  Once we have that, we could probably make uiommu attach to
each of those nodes.

That means we know /dev/uiommu7 (random example) is our access to a
specific iommu with a given set of devices behind it.  If that iommu is
a PE (via those capability files), then a user space entity (trying hard
not to call it libvirt) can unbind all those devices from the host,
maybe bind the ones it wants to assign to a guest to vfio and bind the
others to pci-stub for safe keeping.  If you trust a user with
everything in a PE, bind all the devices to VFIO, chown all
the /dev/vfioX entries for those devices, and the /dev/uiommuX device.

We might then come up with qemu command lines to describe interesting
configurations, such as:

-device iommu,model=PAPR,uiommu=/dev/uiommu7,id=iommu.0 \
-device pci-bus,...,iommu=iommu0,id=pci.0 \
-device vfio,host=ssss:bb:dd.f,bus=pci.0,addr=dd.f,id=hostdev0

The userspace entity would obviously need to put things in the same PE
in the right place, but it doesn't seem to take a lot of sysfs info to
get that right.

Today we do DMA mapping via the VFIO device because the capabilities of
the IOMMU domains change depending on which devices are connected (for
VT-d, the least common denominator of the IOMMUs in play).  Forcing the
DMA mappings through VFIO naturally forces the call order.  If we moved
to something like above, we could switch the DMA mapping to the uiommu
device, since the IOMMU would have fixed capabilities.

What gaps would something like this leave for your IOMMU granularity
problems?  I'll need to think through how it works when we don't want to
expose the iommu to the guest, maybe a model=none (default) that doesn't
need to be connected to a pci bus and maps all guest memory.  Thanks,

Alex
