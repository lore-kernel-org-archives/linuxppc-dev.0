Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD2AFB70FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 11:28:16 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4E356221.6010302@redhat.com>
References: <1311983933.8793.42.camel@pasglop> <4E356221.6010302@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Aug 2011 11:27:59 +1000
Message-ID: <1312248479.8793.827.camel@pasglop>
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

On Sun, 2011-07-31 at 17:09 +0300, Avi Kivity wrote:
> On 07/30/2011 02:58 AM, Benjamin Herrenschmidt wrote:
> > - Having a magic heuristic in libvirt to figure out those constraints is
> > WRONG. This reeks of XFree 4 PCI layer trying to duplicate the kernel
> > knowledge of PCI resource management and getting it wrong in many many
> > cases, something that took years to fix essentially by ripping it all
> > out. This is kernel knowledge and thus we need the kernel to expose in a
> > way or another what those constraints are, what those "partitionable
> > groups" are.
> 
> How about a sysfs entry partition=<partition-id>? then libvirt knows not 
> to assign devices from the same partition to different guests (and not 
> to let the host play with them, either).

That would work. On POWER I also need to expose the way that such
partitions also mean shared iommu domain but that's probably doable.

It would be easy for me to implement it that way since I would just pass
down my PE#.

However, it seems to be a bit of the "smallest possible tweak" to get it
to work. We keep a completely orthogonal iommu domain handling for x86
and there is no link between them.

I still personally prefer a way to statically define the grouping, but
it looks like you guys don't agree... oh well.

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
> 
> I have a feeling you'll be getting the same capabilities sooner or 
> later, or you won't be able to make use of S/R IOV VFs.

I'm not sure why you mean. We can do SR/IOV just fine (well, with some
limitations due to constraints with how our MMIO segmenting works and
indeed some of those are being lifted in our future chipsets but
overall, it works).

In -theory-, one could do the grouping dynamically with some kind of API
for us as well. However the constraints are such that it's not
practical. Filtering on RID is based on number of bits to match in the
bus number and whether to match the dev and fn. So it's not arbitrary
(but works fine for SR-IOV).

The MMIO segmentation is a bit special too. There is a single MMIO
region in 32-bit space (size is configurable but that's not very
practical so for now we stick it to 1G) which is evenly divided into N
segments (where N is the number of PE# supported by the host bridge,
typically 128 with the current bridges).

Each segment goes through a remapping table to select the actual PE# (so
large BARs use consecutive segments mapped to the same PE#).
 
For SR-IOV we plan to not use the M32 region. We also have 64-bit MMIO
regions which act as some kind of "accordions", they are evenly divided
into segments in different PE# and there's several of them which we can
"move around" and typically use to map VF BARs.

>  While we should 
> support the older hardware, the interfaces should be designed with the 
> newer hardware in mind.

Well, our newer hardware will relax some of our limitations, like the
way our 64-bit segments work (I didn't go into details but they have
some inconvenient size constraints that will be lifted), having more
PE#, supporting more MSI ports etc... but the basic scheme remains the
same. Oh and the newer IOMMU will support separate address spaces.

But as you said, we -do- need to support the older stuff.

> > My main point is that I don't want the "knowledge" here to be in libvirt
> > or qemu. In fact, I want to be able to do something as simple as passing
> > a reference to a PE to qemu (sysfs path ?) and have it just pickup all
> > the devices in there and expose them to the guest.
> 
> Such magic is nice for a developer playing with qemu but in general less 
> useful for a managed system where the various cards need to be exposed 
> to the user interface anyway.

Right but at least the code that does that exposure can work top-down,
picking groups and exposing their content.

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
> 
> A single level iommu cannot be exposed to guests.  Well, it can be 
> exposed as an iommu that does not provide per-device mapping.

Well, x86 ones can't maybe but on POWER we can and must thanks to our
essentially paravirt model :-) Even if it' wasn't and we used trapping
of accesses to the table, it would work because in practice, even with
filtering, what we end up having is a per-device (or rather per-PE#
table).

> A two level iommu can be emulated and exposed to the guest.  See 
> http://support.amd.com/us/Processor_TechDocs/48882.pdf for an example.

What you mean 2-level is two passes through two trees (ie 6 or 8 levels
right ?). We don't have that and probably never will. But again, because
we have a paravirt interface to the iommu, it's less of an issue.

> > This means:
> >
> >    - It only works with iommu's that provide complete DMA address spaces
> > to devices. Won't work with a single 'segmented' address space like we
> > have on POWER.
> >
> >    - It requires the guest to be pinned. Pass-through ->  no more swap
> 
> Newer iommus (and devices, unfortunately) (will) support I/O page faults 
> and then the requirement can be removed.

No. -Some- newer devices will. Out of these, a bunch will have so many
bugs in it it's not usable. Some never will. It's a mess really and I
wouldn't design my stuff based on those premises just yet. Making it
possible to support it for sure, having it in mind, but not making it
the fundation on which the whole API is designed. 

> >    - The guest cannot make use of the iommu to deal with 32-bit DMA
> > devices, thus a guest with more than a few G of RAM (I don't know the
> > exact limit on x86, depends on your IO hole I suppose), and you end up
> > back to swiotlb&  bounce buffering.
> 
> Is this a problem in practice?

Could be. It's an artificial limitation we don't need on POWER.

> >    - It doesn't work for POWER server anyways because of our need to
> > provide a paravirt iommu interface to the guest since that's how pHyp
> > works today and how existing OSes expect to operate.
> 
> Then you need to provide that same interface, and implement it using the 
> real iommu.

Yes. Working on it. It's not very practical due to how VFIO interacts in
terms of APIs but solvable. Eventually, we'll make the iommu Hcalls
almost entirely real-mode for performance reasons.

> > - Performance sucks of course, the vfio map ioctl wasn't mean for that
> > and has quite a bit of overhead. However we'll want to do the paravirt
> > call directly in the kernel eventually ...
> 
> Does the guest iomap each request?  Why?

Not sure what you mean... the guest calls h-calls for every iommu page
mapping/unmapping, yes. So the performance of these is critical. So yes,
we'll eventually do it in kernel. We just haven't yet.

> Emulating the iommu in the kernel is of course the way to go if that's 
> the case, still won't performance suck even then?

Well, we have HW on the field where we still beat intel on 10G
networking performances but heh, yeah, the cost of those h-calls is a
concern.

There are some new interfaces in pHyp that we'll eventually support that
allow to create additional iommu mappings in 64-bit space (the current
base mapping is 32-bit and 4K for backward compatibility) with larger
iommu page sizes.

This will eventually help. For guests backed with hugetlbfs we might be
able to map the whole guest in using 16M pages at the iommu level. 

But on the other hand, the current method means that we can support
pass-through without losing overcommit & paging which is handy.

> > The QEMU side VFIO code hard wires various constraints that are entirely
> > based on various requirements you decided you have on x86 but don't
> > necessarily apply to us :-)
> >
> > Due to our paravirt nature, we don't need to masquerade the MSI-X table
> > for example. At all. If the guest configures crap into it, too bad, it
> > can only shoot itself in the foot since the host bridge enforce
> > validation anyways as I explained earlier. Because it's all paravirt, we
> > don't need to "translate" the interrupt vectors&  addresses, the guest
> > will call hyercalls to configure things anyways.
> 
> So, you have interrupt redirection?  That is, MSI-x table values encode 
> the vcpu, not pcpu?

Not exactly. The MSI-X address is a real PCI address to an MSI port and
the value is a real interrupt number in the PIC.

However, the MSI port filters by RID (using the same matching as PE#) to
ensure that only allowed devices can write to it, and the PIC has a
matching PE# information to ensure that only allowed devices can trigger
the interrupt.

As for the guest knowing what values to put in there (what port address
and interrupt source numbers to use), this is part of the paravirt APIs.

So the paravirt APIs handles the configuration and the HW ensures that
the guest cannot do anything else than what it's allowed to.

> Alex, with interrupt redirection, we can skip this as well?  Perhaps 
> only if the guest enables interrupt redirection?
> 
> If so, it's not arch specific, it's interrupt redirection specific.
> 
> > We don't need to prevent MMIO pass-through for small BARs at all. This
> > should be some kind of capability or flag passed by the arch. Our
> > segmentation of the MMIO domain means that we can give entire segments
> > to the guest and let it access anything in there (those segments are a
> > multiple of the page size always). Worst case it will access outside of
> > a device BAR within a segment and will cause the PE to go into error
> > state, shooting itself in the foot, there is no risk of side effect
> > outside of the guest boundaries.
> 
> Does the BAR value contain the segment base address?  Or is that added 
> later?

It's a shared address space. With a basic configuration on p7ioc for
example we have MMIO going from 3G to 4G (PCI side addresses). BARs
contain the normal PCI address there. But that 1G is divided in 128
segments of equal size which can separately be assigned to PE#'s.

So BARs are allocated by firmware or the kernel PCI code so that devices
in different PEs don't share segments.

Of course there's always the risk that a device can be hacked via a
sideband access to BARs to move out of it's allocated segment. That
means that the guest owning that device won't be able to access it
anymore and can potentially disturb a guest or host owning whatever is
in that other segment.

The only way to enforce isolation here is to ensure that PE# are
entirely behind P2P bridges, since those would then ensure that even if
you put crap into your BARs you won't be able to walk over a neighbour.

I believe pHyp enforces that, for example, if you have a slot, all
devices & functions behind that slot pertain to the same PE# under pHyp.

That means you cannot put individual functions of a device into
different PE# with pHyp.

We plan to be a bit less restrictive here for KVM, assuming that if you
use a device that allows such a back-channel to the BARs, then it's your
problem to not trust such a device for virtualization. And most of the
time, you -will- have a P2P to protect you anyways.

The problem doesn't exist (or is assumed as non-existing) for SR-IOV
since in that case, the VFs are meant to be virtualized, so pHyp assumes
there is no such back-channel and it can trust them to be in different
PE#.

Cheers,
Ben.
