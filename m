Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id E37DCB71C2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 19:12:13 +1000 (EST)
Message-ID: <4E37BF62.2060809@redhat.com>
Date: Tue, 02 Aug 2011 12:12:02 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kvm PCI assignment & VFIO ramblings
References: <1311983933.8793.42.camel@pasglop> <4E356221.6010302@redhat.com>
	<1312248479.8793.827.camel@pasglop>
In-Reply-To: <1312248479.8793.827.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 08/02/2011 04:27 AM, Benjamin Herrenschmidt wrote:
> >
> >  I have a feeling you'll be getting the same capabilities sooner or
> >  later, or you won't be able to make use of S/R IOV VFs.
>
> I'm not sure why you mean. We can do SR/IOV just fine (well, with some
> limitations due to constraints with how our MMIO segmenting works and
> indeed some of those are being lifted in our future chipsets but
> overall, it works).

Don't those limitations include "all VFs must be assigned to the same 
guest"?

PCI on x86 has function granularity, SRIOV reduces this to VF 
granularity, but I thought power has partition or group granularity 
which is much coarser?

> In -theory-, one could do the grouping dynamically with some kind of API
> for us as well. However the constraints are such that it's not
> practical. Filtering on RID is based on number of bits to match in the
> bus number and whether to match the dev and fn. So it's not arbitrary
> (but works fine for SR-IOV).
>
> The MMIO segmentation is a bit special too. There is a single MMIO
> region in 32-bit space (size is configurable but that's not very
> practical so for now we stick it to 1G) which is evenly divided into N
> segments (where N is the number of PE# supported by the host bridge,
> typically 128 with the current bridges).
>
> Each segment goes through a remapping table to select the actual PE# (so
> large BARs use consecutive segments mapped to the same PE#).
>
> For SR-IOV we plan to not use the M32 region. We also have 64-bit MMIO
> regions which act as some kind of "accordions", they are evenly divided
> into segments in different PE# and there's several of them which we can
> "move around" and typically use to map VF BARs.

So, SRIOV VFs *don't* have the group limitation?  Sorry, I'm deluged by 
technical details with no ppc background to put them to, I can't say I'm 
making any sense of this.

> >  >
> >  >  VFIO here is basically designed for one and only one thing: expose the
> >  >  entire guest physical address space to the device more/less 1:1.
> >
> >  A single level iommu cannot be exposed to guests.  Well, it can be
> >  exposed as an iommu that does not provide per-device mapping.
>
> Well, x86 ones can't maybe but on POWER we can and must thanks to our
> essentially paravirt model :-) Even if it' wasn't and we used trapping
> of accesses to the table, it would work because in practice, even with
> filtering, what we end up having is a per-device (or rather per-PE#
> table).
>
> >  A two level iommu can be emulated and exposed to the guest.  See
> >  http://support.amd.com/us/Processor_TechDocs/48882.pdf for an example.
>
> What you mean 2-level is two passes through two trees (ie 6 or 8 levels
> right ?).

(16 or 25)

> We don't have that and probably never will. But again, because
> we have a paravirt interface to the iommu, it's less of an issue.

Well, then, I guess we need an additional interface to expose that to 
the guest.

> >  >  This means:
> >  >
> >  >     - It only works with iommu's that provide complete DMA address spaces
> >  >  to devices. Won't work with a single 'segmented' address space like we
> >  >  have on POWER.
> >  >
> >  >     - It requires the guest to be pinned. Pass-through ->   no more swap
> >
> >  Newer iommus (and devices, unfortunately) (will) support I/O page faults
> >  and then the requirement can be removed.
>
> No. -Some- newer devices will. Out of these, a bunch will have so many
> bugs in it it's not usable. Some never will. It's a mess really and I
> wouldn't design my stuff based on those premises just yet. Making it
> possible to support it for sure, having it in mind, but not making it
> the fundation on which the whole API is designed.

The API is not designed around pinning.  It's a side effect of how the 
IOMMU works.  If your IOMMU only maps pages which are under active DMA, 
then it would only pin those pages.

But I see what you mean, the API is designed around up-front 
specification of all guest memory.

> >  >     - It doesn't work for POWER server anyways because of our need to
> >  >  provide a paravirt iommu interface to the guest since that's how pHyp
> >  >  works today and how existing OSes expect to operate.
> >
> >  Then you need to provide that same interface, and implement it using the
> >  real iommu.
>
> Yes. Working on it. It's not very practical due to how VFIO interacts in
> terms of APIs but solvable. Eventually, we'll make the iommu Hcalls
> almost entirely real-mode for performance reasons.

The original kvm device assignment code was (and is) part of kvm 
itself.  We're trying to move to vfio to allow sharing with non-kvm 
users, but it does reduce flexibility.  We can have an internal vfio-kvm 
interface to update mappings in real time.

> >  >  - Performance sucks of course, the vfio map ioctl wasn't mean for that
> >  >  and has quite a bit of overhead. However we'll want to do the paravirt
> >  >  call directly in the kernel eventually ...
> >
> >  Does the guest iomap each request?  Why?
>
> Not sure what you mean... the guest calls h-calls for every iommu page
> mapping/unmapping, yes. So the performance of these is critical. So yes,
> we'll eventually do it in kernel. We just haven't yet.

I see.  x86 traditionally doesn't do it for every request.  We had some 
proposals to do a pviommu that does map every request, but none reached 
maturity.

> >
> >  So, you have interrupt redirection?  That is, MSI-x table values encode
> >  the vcpu, not pcpu?
>
> Not exactly. The MSI-X address is a real PCI address to an MSI port and
> the value is a real interrupt number in the PIC.
>
> However, the MSI port filters by RID (using the same matching as PE#) to
> ensure that only allowed devices can write to it, and the PIC has a
> matching PE# information to ensure that only allowed devices can trigger
> the interrupt.
>
> As for the guest knowing what values to put in there (what port address
> and interrupt source numbers to use), this is part of the paravirt APIs.
>
> So the paravirt APIs handles the configuration and the HW ensures that
> the guest cannot do anything else than what it's allowed to.

Okay, this is something that x86 doesn't have.  Strange that it can 
filter DMA at a fine granularity but not MSI, which is practically the 
same thing.

> >
> >  Does the BAR value contain the segment base address?  Or is that added
> >  later?
>
> It's a shared address space. With a basic configuration on p7ioc for
> example we have MMIO going from 3G to 4G (PCI side addresses). BARs
> contain the normal PCI address there. But that 1G is divided in 128
> segments of equal size which can separately be assigned to PE#'s.
>
> So BARs are allocated by firmware or the kernel PCI code so that devices
> in different PEs don't share segments.

Okay, and config space virtualization ensures that the guest can't remap?

-- 
error compiling committee.c: too many arguments to function
