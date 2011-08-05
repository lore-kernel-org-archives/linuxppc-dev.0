Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C0EEB6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Aug 2011 20:42:57 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joerg Roedel <joro@8bytes.org>
In-Reply-To: <20110804102752.GA22329@8bytes.org>
References: <1311983933.8793.42.camel@pasglop>
	<20110804102752.GA22329@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Aug 2011 20:42:38 +1000
Message-ID: <1312540958.8598.46.camel@pasglop>
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Gibson <dwg@au1.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-08-04 at 12:27 +0200, Joerg Roedel wrote:
> Hi Ben,
> 
> thanks for your detailed introduction to the requirements for POWER. Its
> good to know that the granularity problem is not x86-only.

I'm happy to see your reply :-) I had the feeling I was a bit alone
here...

> On Sat, Jul 30, 2011 at 09:58:53AM +1000, Benjamin Herrenschmidt wrote:
> > In IBM POWER land, we call this a "partitionable endpoint" (the term
> > "endpoint" here is historic, such a PE can be made of several PCIe
> > "endpoints"). I think "partitionable" is a pretty good name tho to
> > represent the constraints, so I'll call this a "partitionable group"
> > from now on.
> 
> On x86 this is mostly an issue of the IOMMU and which set of devices use
> the same request-id. I used to call that an alias-group because the
> devices have a request-id alias to the pci-bridge.

Right. In fact to try to clarify the problem for everybody, I think we
can distinguish two different classes of "constraints" that can
influence the grouping of devices:

 1- Hard constraints. These are typically devices using the same RID or
where the RID cannot be reliably guaranteed (the later is the case with
some PCIe-PCIX bridges which will take ownership of "some" transactions
such as split but not all). Devices like that must be in the same
domain. This is where PowerPC adds to what x86 does today the concept
that the domains are pre-existing, since we use the RID for error
isolation & MMIO segmenting as well. so we need to create those domains
at boot time.

 2- Softer constraints. Those constraints derive from the fact that not
applying them risks enabling the guest to create side effects outside of
its "sandbox". To some extent, there can be "degrees" of badness between
the various things that can cause such constraints. Examples are shared
LSIs (since trusting DisINTx can be chancy, see earlier discussions),
potentially any set of functions in the same device can be problematic
due to the possibility to get backdoor access to the BARs etc...

Now, what I derive from the discussion we've had so far, is that we need
to find a proper fix for #1, but Alex and Avi seem to prefer that #2
remains a matter of libvirt/user doing the right thing (basically
keeping a loaded gun aimed at the user's foot with a very very very
sweet trigger but heh, let's not start a flamewar here :-)

So let's try to find a proper solution for #1 now, and leave #2 alone
for the time being.

Maybe the right option is for x86 to move toward pre-existing domains
like powerpc does, or maybe we can just expose some kind of ID.

Because #1 is a mix of generic constraints (nasty bridges) and very
platform specific ones (whatever capacity limits in our MMIO segmenting
forced us to put two devices in the same hard domain on power), I
believe it's really something the kernel must solve, not libvirt nor
qemu user or anything else.

I am open to suggestions here. I can easily expose my PE# (it's just a
number) somewhere in sysfs, in fact I'm considering doing it in the PCI
devices sysfs directory, simply because it can/will be useful for other
things such as error reporting, so we could maybe build on that.

The crux for me is really the need for pre-existence of the iommu
domains as my PE's imply a shared iommu space.

> > - The -minimum- granularity of pass-through is not always a single
> > device and not always under SW control
> 
> Correct.
>  
> > - Having a magic heuristic in libvirt to figure out those constraints is
> > WRONG. This reeks of XFree 4 PCI layer trying to duplicate the kernel
> > knowledge of PCI resource management and getting it wrong in many many
> > cases, something that took years to fix essentially by ripping it all
> > out. This is kernel knowledge and thus we need the kernel to expose in a
> > way or another what those constraints are, what those "partitionable
> > groups" are.
> 
> I agree. Managing the ownership of a group should be done in the kernel.
> Doing this in userspace is just too dangerous.
> 
> The problem to be solved here is how to present these PEs inside the
> kernel and to userspace. I thought a bit about making this visbible
> through the iommu-api for in-kernel users. That is probably the most
> logical place.

Ah you started answering to my above questions :-)

We could do what you propose. It depends what we want to do with
domains. Practically speaking, we could make domains pre-existing (with
the ability to group several PEs into larger domains) or we could keep
the concepts different, possibly with the limitation that on powerpc, a
domain == a PE.

I suppose we -could- make arbitrary domains on ppc as well by making the
various PE's iommu's in HW point to the same in-memory table, but that's
a bit nasty in practice due to the way we manage those, and it would to
some extent increase the risk of a failing device/driver stomping on
another one and thus taking it down with itself. IE. isolation of errors
is an important feature for us.

So I'd rather avoid the whole domain thing for now and keep the
constraint, for powerpc at least, that a domain == a PE, and thus find a
proper way to expose that to qemu/libvirt.

> For userspace I would like to propose a new device attribute in sysfs.
> This attribute contains the group number. All devices with the same
> group number belong to the same PE. Libvirt needs to scan the whole
> device tree to build the groups but that is probalbly not a big deal.

That's trivial for me to map that to my existing PE number. Should we
define the number space to be within a PCI domain (ie a host bridge). Or
should it be a global space ? In the later case I can construct them
using domain << 16 | PE# or something like that.

Cheers,
Ben.

>	Joerg
> 
> > 
> > - That does -not- mean that we cannot specify for each individual device
> > within such a group where we want to put it in qemu (what devfn etc...).
> > As long as there is a clear understanding that the "ownership" of the
> > device goes with the group, this is somewhat orthogonal to how they are
> > represented in qemu. (Not completely... if the iommu is exposed to the
> > guest ,via paravirt for example, some of these constraints must be
> > exposed but I'll talk about that more later).
> > 
> > The interface currently proposed for VFIO (and associated uiommu)
> > doesn't handle that problem at all. Instead, it is entirely centered
> > around a specific "feature" of the VTd iommu's for creating arbitrary
> > domains with arbitrary devices (tho those devices -do- have the same
> > constraints exposed above, don't try to put 2 legacy PCI devices behind
> > the same bridge into 2 different domains !), but the API totally ignores
> > the problem, leaves it to libvirt "magic foo" and focuses on something
> > that is both quite secondary in the grand scheme of things, and quite
> > x86 VTd specific in the implementation and API definition.
> > 
> > Now, I'm not saying these programmable iommu domains aren't a nice
> > feature and that we shouldn't exploit them when available, but as it is,
> > it is too much a central part of the API.
> > 
> > I'll talk a little bit more about recent POWER iommu's here to
> > illustrate where I'm coming from with my idea of groups:
> > 
> > On p7ioc (the IO chip used on recent P7 machines), there -is- a concept
> > of domain and a per-RID filtering. However it differs from VTd in a few
> > ways:
> > 
> > The "domains" (aka PEs) encompass more than just an iommu filtering
> > scheme. The MMIO space and PIO space are also segmented, and those
> > segments assigned to domains. Interrupts (well, MSI ports at least) are
> > assigned to domains. Inbound PCIe error messages are targeted to
> > domains, etc...
> > 
> > Basically, the PEs provide a very strong isolation feature which
> > includes errors, and has the ability to immediately "isolate" a PE on
> > the first occurence of an error. For example, if an inbound PCIe error
> > is signaled by a device on a PE or such a device does a DMA to a
> > non-authorized address, the whole PE gets into error state. All
> > subsequent stores (both DMA and MMIO) are swallowed and reads return all
> > 1's, interrupts are blocked. This is designed to prevent any propagation
> > of bad data, which is a very important feature in large high reliability
> > systems.
> > 
> > Software then has the ability to selectively turn back on MMIO and/or
> > DMA, perform diagnostics, reset devices etc...
> > 
> > Because the domains encompass more than just DMA, but also segment the
> > MMIO space, it is not practical at all to dynamically reconfigure them
> > at runtime to "move" devices into domains. The firmware or early kernel
> > code (it depends) will assign devices BARs using an algorithm that keeps
> > them within PE segment boundaries, etc....
> > 
> > Additionally (and this is indeed a "restriction" compared to VTd, though
> > I expect our future IO chips to lift it to some extent), PE don't get
> > separate DMA address spaces. There is one 64-bit DMA address space per
> > PCI host bridge, and it is 'segmented' with each segment being assigned
> > to a PE. Due to the way PE assignment works in hardware, it is not
> > practical to make several devices share a segment unless they are on the
> > same bus. Also the resulting limit in the amount of 32-bit DMA space a
> > device can access means that it's impractical to put too many devices in
> > a PE anyways. (This is clearly designed for paravirt iommu, I'll talk
> > more about that later).
> > 
> > The above essentially extends the granularity requirement (or rather is
> > another factor defining what the granularity of partitionable entities
> > is). You can think of it as "pre-existing" domains.
> > 
> > I believe the way to solve that is to introduce a kernel interface to
> > expose those "partitionable entities" to userspace. In addition, it
> > occurs to me that the ability to manipulate VTd domains essentially
> > boils down to manipulating those groups (creating larger ones with
> > individual components).
> > 
> > I like the idea of defining / playing with those groups statically
> > (using a command line tool or sysfs, possibly having a config file
> > defining them in a persistent way) rather than having their lifetime
> > tied to a uiommu file descriptor.
> > 
> > It also makes it a LOT easier to have a channel to manipulate
> > platform/arch specific attributes of those domains if any.
> > 
> > So we could define an API or representation in sysfs that exposes what
> > the partitionable entities are, and we may add to it an API to
> > manipulate them. But we don't have to and I'm happy to keep the
> > additional SW grouping you can do on VTd as a sepparate "add-on" API
> > (tho I don't like at all the way it works with uiommu). However, qemu
> > needs to know what the grouping is regardless of the domains, and it's
> > not nice if it has to manipulate two different concepts here so
> > eventually those "partitionable entities" from a qemu standpoint must
> > look like domains.
> > 
> > My main point is that I don't want the "knowledge" here to be in libvirt
> > or qemu. In fact, I want to be able to do something as simple as passing
> > a reference to a PE to qemu (sysfs path ?) and have it just pickup all
> > the devices in there and expose them to the guest.
> > 
> > This can be done in a way that isn't PCI specific as well (the
> > definition of the groups and what is grouped would would obviously be
> > somewhat bus specific and handled by platform code in the kernel).
> > 
> > Maybe something like /sys/devgroups ? This probably warrants involving
> > more kernel people into the discussion.
> > 
> > * IOMMU
> > 
> > Now more on iommu. I've described I think in enough details how ours
> > work, there are others, I don't know what freescale or ARM are doing,
> > sparc doesn't quite work like VTd either, etc...
> > 
> > The main problem isn't that much the mechanics of the iommu but really
> > how it's exposed (or not) to guests.
> > 
> > VFIO here is basically designed for one and only one thing: expose the
> > entire guest physical address space to the device more/less 1:1.
> > 
> > This means:
> > 
> >   - It only works with iommu's that provide complete DMA address spaces
> > to devices. Won't work with a single 'segmented' address space like we
> > have on POWER.
> > 
> >   - It requires the guest to be pinned. Pass-through -> no more swap
> > 
> >   - The guest cannot make use of the iommu to deal with 32-bit DMA
> > devices, thus a guest with more than a few G of RAM (I don't know the
> > exact limit on x86, depends on your IO hole I suppose), and you end up
> > back to swiotlb & bounce buffering.
> > 
> >   - It doesn't work for POWER server anyways because of our need to
> > provide a paravirt iommu interface to the guest since that's how pHyp
> > works today and how existing OSes expect to operate.
> > 
> > Now some of this can be fixed with tweaks, and we've started doing it
> > (we have a working pass-through using VFIO, forgot to mention that, it's
> > just that we don't like what we had to do to get there).
> > 
> > Basically, what we do today is:
> > 
> > - We add an ioctl to VFIO to expose to qemu the segment information. IE.
> > What is the DMA address and size of the DMA "window" usable for a given
> > device. This is a tweak, that should really be handled at the "domain"
> > level.
> > 
> > That current hack won't work well if two devices share an iommu. Note
> > that we have an additional constraint here due to our paravirt
> > interfaces (specificed in PAPR) which is that PE domains must have a
> > common parent. Basically, pHyp makes them look like a PCIe host bridge
> > per domain in the guest. I think that's a pretty good idea and qemu
> > might want to do the same.
> > 
> > - We hack out the currently unconditional mapping of the entire guest
> > space in the iommu. Something will have to be done to "decide" whether
> > to do that or not ... qemu argument -> ioctl ?
> > 
> > - We hook up the paravirt call to insert/remove a translation from the
> > iommu to the VFIO map/unmap ioctl's.
> > 
> > This limps along but it's not great. Some of the problems are:
> > 
> > - I've already mentioned, the domain problem again :-) 
> > 
> > - Performance sucks of course, the vfio map ioctl wasn't mean for that
> > and has quite a bit of overhead. However we'll want to do the paravirt
> > call directly in the kernel eventually ...
> > 
> >   - ... which isn't trivial to get back to our underlying arch specific
> > iommu object from there. We'll probably need a set of arch specific
> > "sideband" ioctl's to "register" our paravirt iommu "bus numbers" and
> > link them to the real thing kernel-side.
> > 
> > - PAPR (the specification of our paravirt interface and the expectation
> > of current OSes) wants iommu pages to be 4k by default, regardless of
> > the kernel host page size, which makes things a bit tricky since our
> > enterprise host kernels have a 64k base page size. Additionally, we have
> > new PAPR interfaces that we want to exploit, to allow the guest to
> > create secondary iommu segments (in 64-bit space), which can be used
> > (under guest control) to do things like map the entire guest (here it
> > is :-) or use larger iommu page sizes (if permitted by the host kernel,
> > in our case we could allow 64k iommu page size with a 64k host kernel).
> > 
> > The above means we need arch specific APIs. So arch specific vfio
> > ioctl's, either that or kvm ones going to vfio or something ... the
> > current structure of vfio/kvm interaction doesn't make it easy.
> > 
> > * IO space
> > 
> > On most (if not all) non-x86 archs, each PCI host bridge provide a
> > completely separate PCI address space. Qemu doesn't deal with that very
> > well. For MMIO it can be handled since those PCI address spaces are
> > "remapped" holes in the main CPU address space so devices can be
> > registered by using BAR + offset of that window in qemu MMIO mapping.
> > 
> > For PIO things get nasty. We have totally separate PIO spaces and qemu
> > doesn't seem to like that. We can try to play the offset trick as well,
> > we haven't tried yet, but basically that's another one to fix. Not a
> > huge deal I suppose but heh ...
> > 
> > Also our next generation chipset may drop support for PIO completely.
> > 
> > On the other hand, because PIO is just a special range of MMIO for us,
> > we can do normal pass-through on it and don't need any of the emulation
> > done qemu.
> > 
> >   * MMIO constraints
> > 
> > The QEMU side VFIO code hard wires various constraints that are entirely
> > based on various requirements you decided you have on x86 but don't
> > necessarily apply to us :-)
> > 
> > Due to our paravirt nature, we don't need to masquerade the MSI-X table
> > for example. At all. If the guest configures crap into it, too bad, it
> > can only shoot itself in the foot since the host bridge enforce
> > validation anyways as I explained earlier. Because it's all paravirt, we
> > don't need to "translate" the interrupt vectors & addresses, the guest
> > will call hyercalls to configure things anyways.
> > 
> > We don't need to prevent MMIO pass-through for small BARs at all. This
> > should be some kind of capability or flag passed by the arch. Our
> > segmentation of the MMIO domain means that we can give entire segments
> > to the guest and let it access anything in there (those segments are a
> > multiple of the page size always). Worst case it will access outside of
> > a device BAR within a segment and will cause the PE to go into error
> > state, shooting itself in the foot, there is no risk of side effect
> > outside of the guest boundaries.
> > 
> > In fact, we don't even need to emulate BAR sizing etc... in theory. Our
> > paravirt guests expect the BARs to have been already allocated for them
> > by the firmware and will pick up the addresses from the device-tree :-)
> > 
> > Today we use a "hack", putting all 0's in there and triggering the linux
> > code path to reassign unassigned resources (which will use BAR
> > emulation) but that's not what we are -supposed- to do. Not a big deal
> > and having the emulation there won't -hurt- us, it's just that we don't
> > really need any of it.
> > 
> > We have a small issue with ROMs. Our current KVM only works with huge
> > pages for guest memory but that is being fixed. So the way qemu maps the
> > ROM copy into the guest address space doesn't work. It might be handy
> > anyways to have a way for qemu to use MMIO emulation for ROM access as a
> > fallback. I'll look into it.
> > 
> >   * EEH
> > 
> > This is the name of those fancy error handling & isolation features I
> > mentioned earlier. To some extent it's a superset of AER, but we don't
> > generally expose AER to guests (or even the host), it's swallowed by
> > firmware into something else that provides a superset (well mostly) of
> > the AER information, and allow us to do those additional things like
> > isolating/de-isolating, reset control etc...
> > 
> > Here too, we'll need arch specific APIs through VFIO. Not necessarily a
> > huge deal, I mention it for completeness.
> > 
> >    * Misc
> > 
> > There's lots of small bits and pieces... in no special order:
> > 
> >  - netlink ? WTF ! Seriously, we don't need a hybrid API with a bit of
> > netlink and a bit of ioctl's ... it's not like there's something
> > fundamentally  better for netlink vs. ioctl... it really depends what
> > you are doing, and in this case I fail to see what netlink brings you
> > other than bloat and more stupid userspace library deps.
> > 
> >  - I don't like too much the fact that VFIO provides yet another
> > different API to do what we already have at least 2 kernel APIs for, ie,
> > BAR mapping and config space access. At least it should be better at
> > using the backend infrastructure of the 2 others (sysfs & procfs). I
> > understand it wants to filter in some case (config space) and -maybe-
> > yet another API is the right way to go but allow me to have my doubts.
> > 
> > One thing I thought about but you don't seem to like it ... was to use
> > the need to represent the partitionable entity as groups in sysfs that I
> > talked about earlier. Those could have per-device subdirs with the usual
> > config & resource files, same semantic as the ones in the real device,
> > but when accessed via the group they get filtering. I might or might not
> > be practical in the end, tbd, but it would allow apps using a slightly
> > modified libpci for example to exploit some of this.
> > 
> >  - The qemu vfio code hooks directly into ioapic ... of course that
> > won't fly with anything !x86
> > 
> >  - The various "objects" dealt with here, -especially- interrupts and
> > iommu, need a better in-kernel API so that fast in-kernel emulation can
> > take over from qemu based emulation. The way we need to do some of this
> > on POWER differs from x86. We can elaborate later, it's not necessarily
> > a killer either but essentially we'll take the bulk of interrupt
> > handling away from VFIO to the point where it won't see any of it at
> > all.
> > 
> >   - Non-PCI devices. That's a hot topic for embedded. I think the vast
> > majority here is platform devices. There's quite a bit of vfio that
> > isn't intrinsically PCI specific. We could have an in-kernel platform
> > driver like we have an in-kernel PCI driver to attach to. The mapping of
> > resources to userspace is rather generic, as goes for interrupts. I
> > don't know whether that idea can be pushed much further, I don't have
> > the bandwidth to look into it much at this point, but maybe it would be
> > possible to refactor vfio a bit to better separate what is PCI specific
> > to what is not. The idea would be to move the PCI specific bits to
> > inside the "placeholder" PCI driver, and same goes for platform bits.
> > "generic" ioctl's go to VFIO core, anything that doesn't handle, it
> > passes them to the driver which allows the PCI one to handle things
> > differently than the platform one, maybe an amba one while at it,
> > etc.... just a thought, I haven't gone into the details at all.
> > 
> > I think that's all I had on my plate today, it's a long enough email
> > anyway :-) Anthony suggested we put that on a wiki, I'm a bit
> > wiki-disabled myself so he proposed to pickup my email and do that. We
> > should probably discuss the various items in here separately as
> > different threads to avoid too much confusion.
> > 
> > One other thing we should do on our side is publish somewhere our
> > current hacks to get you an idea of where we are going and what we had
> > to do (code speaks more than words). We'll try to do that asap, possibly
> > next week.
> > 
> > Note that I'll be on/off the next few weeks, travelling and doing
> > bringup. So expect latency in my replies.
> > 
> > Cheers,
> > Ben.
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
