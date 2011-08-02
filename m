Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94AC4B71C6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 22:59:09 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4E37BF62.2060809@redhat.com>
References: <1311983933.8793.42.camel@pasglop> <4E356221.6010302@redhat.com>
	<1312248479.8793.827.camel@pasglop>  <4E37BF62.2060809@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Aug 2011 22:58:49 +1000
Message-ID: <1312289929.8793.890.camel@pasglop>
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

On Tue, 2011-08-02 at 12:12 +0300, Avi Kivity wrote:
> On 08/02/2011 04:27 AM, Benjamin Herrenschmidt wrote:
> > >
> > >  I have a feeling you'll be getting the same capabilities sooner or
> > >  later, or you won't be able to make use of S/R IOV VFs.
> >
> > I'm not sure why you mean. We can do SR/IOV just fine (well, with some
> > limitations due to constraints with how our MMIO segmenting works and
> > indeed some of those are being lifted in our future chipsets but
> > overall, it works).
> 
> Don't those limitations include "all VFs must be assigned to the same 
> guest"?

No, not at all. We put them in different PE# and because the HW is
SR-IOV we know we can trust it to the extent that it won't have nasty
hidden side effects between them. We have 64-bit windows for MMIO that
are also segmented and that we can "resize" to map over the VF BAR
region, the limitations are more about the allowed sizes, number of
segments supported etc...  for these things which can cause us to play
interesting games with the system page size setting to find a good
match.

> PCI on x86 has function granularity, SRIOV reduces this to VF 
> granularity, but I thought power has partition or group granularity 
> which is much coarser?

The granularity of a "Group" really depends on what the HW is like. On
pure PCIe SR-IOV we can go down to function granularity.

In fact I currently go down to function granularity on anything pure
PCIe as well, though as I explained earlier, that's a bit chancy since
some adapters -will- allow to create side effects such as side band
access to config space.

pHyp doesn't allow that granularity as far as I can tell, one slot is
always fully assigned to a PE.

However, we might have resource constraints as in reaching max number of
segments or iommu regions that may force us to group a bit more coarsly
under some circumstances.

The main point is that the grouping is pre-existing, so an API designed
around the idea of: 1- create domain, 2- add random devices to it, 3-
use it, won't work for us very well :-)

Since the grouping implies the sharing of iommu's, from a VFIO point of
view is really matches well with the idea of having the domains
pre-existing.

That's why I think a good fit is to have a static representation of the
grouping, with tools allowing to create/manipulate the groups (or
domains) for archs that allow this sort of manipulations, separately
from qemu/libvirt, avoiding those "on the fly" groups whose lifetime is
tied to an instance of a file descriptor.

> > In -theory-, one could do the grouping dynamically with some kind of API
> > for us as well. However the constraints are such that it's not
> > practical. Filtering on RID is based on number of bits to match in the
> > bus number and whether to match the dev and fn. So it's not arbitrary
> > (but works fine for SR-IOV).
> >
> > The MMIO segmentation is a bit special too. There is a single MMIO
> > region in 32-bit space (size is configurable but that's not very
> > practical so for now we stick it to 1G) which is evenly divided into N
> > segments (where N is the number of PE# supported by the host bridge,
> > typically 128 with the current bridges).
> >
> > Each segment goes through a remapping table to select the actual PE# (so
> > large BARs use consecutive segments mapped to the same PE#).
> >
> > For SR-IOV we plan to not use the M32 region. We also have 64-bit MMIO
> > regions which act as some kind of "accordions", they are evenly divided
> > into segments in different PE# and there's several of them which we can
> > "move around" and typically use to map VF BARs.
> 
> So, SRIOV VFs *don't* have the group limitation?  Sorry, I'm deluged by 
> technical details with no ppc background to put them to, I can't say I'm 
> making any sense of this.

:-)

Don't worry, it took me a while to get my head around the HW :-) SR-IOV
VFs will generally not have limitations like that no, but on the other
hand, they -will- still require 1 VF = 1 group, ie, you won't be able to
take a bunch of VFs and put them in the same 'domain'.

I think the main deal is that VFIO/qemu sees "domains" as "guests" and
tries to put all devices for a given guest into a "domain".

On POWER, we have a different view of things were domains/groups are
defined to be the smallest granularity we can (down to a single VF) and
we give several groups to a guest (ie we avoid sharing the iommu in most
cases)

This is driven by the HW design but that design is itself driven by the
idea that the domains/group are also error isolation groups and we don't
want to take all of the IOs of a guest down if one adapter in that guest
is having an error.

The x86 domains are conceptually different as they are about sharing the
iommu page tables with the clear long term intent of then sharing those
page tables with the guest CPU own. We aren't going in that direction
(at this point at least) on POWER..

> > >  >  VFIO here is basically designed for one and only one thing: expose the
> > >  >  entire guest physical address space to the device more/less 1:1.
> > >
> > >  A single level iommu cannot be exposed to guests.  Well, it can be
> > >  exposed as an iommu that does not provide per-device mapping.
> >
> > Well, x86 ones can't maybe but on POWER we can and must thanks to our
> > essentially paravirt model :-) Even if it' wasn't and we used trapping
> > of accesses to the table, it would work because in practice, even with
> > filtering, what we end up having is a per-device (or rather per-PE#
> > table).
> >
> > >  A two level iommu can be emulated and exposed to the guest.  See
> > >  http://support.amd.com/us/Processor_TechDocs/48882.pdf for an example.
> >
> > What you mean 2-level is two passes through two trees (ie 6 or 8 levels
> > right ?).
> 
> (16 or 25)

25 levels ? You mean 25 loads to get to a translation ? And you get any
kind of performance out of that ? :-)

> > We don't have that and probably never will. But again, because
> > we have a paravirt interface to the iommu, it's less of an issue.
> 
> Well, then, I guess we need an additional interface to expose that to 
> the guest.
> 
> > >  >  This means:
> > >  >
> > >  >     - It only works with iommu's that provide complete DMA address spaces
> > >  >  to devices. Won't work with a single 'segmented' address space like we
> > >  >  have on POWER.
> > >  >
> > >  >     - It requires the guest to be pinned. Pass-through ->   no more swap
> > >
> > >  Newer iommus (and devices, unfortunately) (will) support I/O page faults
> > >  and then the requirement can be removed.
> >
> > No. -Some- newer devices will. Out of these, a bunch will have so many
> > bugs in it it's not usable. Some never will. It's a mess really and I
> > wouldn't design my stuff based on those premises just yet. Making it
> > possible to support it for sure, having it in mind, but not making it
> > the fundation on which the whole API is designed.
> 
> The API is not designed around pinning.  It's a side effect of how the 
> IOMMU works.  If your IOMMU only maps pages which are under active DMA, 
> then it would only pin those pages.
> 
> But I see what you mean, the API is designed around up-front 
> specification of all guest memory.

Right :-)

> > >  >     - It doesn't work for POWER server anyways because of our need to
> > >  >  provide a paravirt iommu interface to the guest since that's how pHyp
> > >  >  works today and how existing OSes expect to operate.
> > >
> > >  Then you need to provide that same interface, and implement it using the
> > >  real iommu.
> >
> > Yes. Working on it. It's not very practical due to how VFIO interacts in
> > terms of APIs but solvable. Eventually, we'll make the iommu Hcalls
> > almost entirely real-mode for performance reasons.
> 
> The original kvm device assignment code was (and is) part of kvm 
> itself.  We're trying to move to vfio to allow sharing with non-kvm 
> users, but it does reduce flexibility.  We can have an internal vfio-kvm 
> interface to update mappings in real time.
> 
> > >  >  - Performance sucks of course, the vfio map ioctl wasn't mean for that
> > >  >  and has quite a bit of overhead. However we'll want to do the paravirt
> > >  >  call directly in the kernel eventually ...
> > >
> > >  Does the guest iomap each request?  Why?
> >
> > Not sure what you mean... the guest calls h-calls for every iommu page
> > mapping/unmapping, yes. So the performance of these is critical. So yes,
> > we'll eventually do it in kernel. We just haven't yet.
> 
> I see.  x86 traditionally doesn't do it for every request.  We had some 
> proposals to do a pviommu that does map every request, but none reached 
> maturity.

It's quite performance critical, you don't want to go anywhere near a
full exit. On POWER we plan to handle that in "real mode" (ie MMU off)
straight off the interrupt handlers, with the CPU still basically
operating in guest context with HV permission. That is basically do the
permission check, translation and whack the HW iommu immediately. If for
some reason one step fails (!present PTE or something like that), we'd
then fallback to an exit to Linux to handle it in a more "common"
environment where we can handle page faults etc...

> > >  So, you have interrupt redirection?  That is, MSI-x table values encode
> > >  the vcpu, not pcpu?
> >
> > Not exactly. The MSI-X address is a real PCI address to an MSI port and
> > the value is a real interrupt number in the PIC.
> >
> > However, the MSI port filters by RID (using the same matching as PE#) to
> > ensure that only allowed devices can write to it, and the PIC has a
> > matching PE# information to ensure that only allowed devices can trigger
> > the interrupt.
> >
> > As for the guest knowing what values to put in there (what port address
> > and interrupt source numbers to use), this is part of the paravirt APIs.
> >
> > So the paravirt APIs handles the configuration and the HW ensures that
> > the guest cannot do anything else than what it's allowed to.
> 
> Okay, this is something that x86 doesn't have.  Strange that it can 
> filter DMA at a fine granularity but not MSI, which is practically the 
> same thing.

I wouldn't be surprised if it's actually a quite different path in HW.
There's some magic decoding based on top bits usually that decides it's
an MSI and it goes completely elsewhere from there in the bridge. 

> > >  Does the BAR value contain the segment base address?  Or is that added
> > >  later?
> >
> > It's a shared address space. With a basic configuration on p7ioc for
> > example we have MMIO going from 3G to 4G (PCI side addresses). BARs
> > contain the normal PCI address there. But that 1G is divided in 128
> > segments of equal size which can separately be assigned to PE#'s.
> >
> > So BARs are allocated by firmware or the kernel PCI code so that devices
> > in different PEs don't share segments.
> 
> Okay, and config space virtualization ensures that the guest can't remap?

Well, so it depends :-)

With KVM we currently use whatever config space virtualization you do
and so we somewhat rely on this but it's not very fool proof.

I believe pHyp doesn't even bother filtering config space. As I said in
another note, you can't trust adapters anyway. Plenty of them (video
cards come to mind) have ways to get to their own config space via MMIO
registers for example.

So what pHyp does is that it always create PE's (aka groups) that are
below a bridge. With PCIe, everything mostly is below a bridge so that's
easy, but that does mean that you always have all functions of a device
in the same PE (and thus in the same partition). SR-IOV is an exception
to this rule since in that case the HW is designed to be trusted.

That way, being behind a bridge, the bridge windows are going to define
what can be forwarded to the device, and thus the system is immune to
the guest putting crap into the BARs. It can't be remapped to overlap a
neighbouring device.

Note that the bridge itself isn't visible to the guest, so yes, config
space is -somewhat- virtualized, typically pHyp make every pass-through
PE look like a separate PCI host bridge with the devices below it.

Cheers,
Ben.
