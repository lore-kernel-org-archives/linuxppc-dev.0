Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lsR948CCzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 23:19:01 +1000 (AEST)
Message-ID: <b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com,
 robin.murphy@arm.com, jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date: Wed, 08 Aug 2018 23:18:13 +1000
In-Reply-To: <20180808123036.GA2525@infradead.org>
References: <20180805072930.GB23288@infradead.org>
 <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
 <20180806094243.GA16032@infradead.org>
 <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
 <20180807062117.GD32709@infradead.org>
 <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
 <20180807135505.GA29034@infradead.org>
 <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
 <20180808063158.GA2474@infradead.org>
 <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
 <20180808123036.GA2525@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-08-08 at 05:30 -0700, Christoph Hellwig wrote:
> On Wed, Aug 08, 2018 at 08:07:49PM +1000, Benjamin Herrenschmidt wrote:
> > Qemu virtio bypasses that iommu when the VIRTIO_F_IOMMU_PLATFORM flag
> > is not set (default) but there's nothing in the device-tree to tell the
> > guest about this since it's a violation of our pseries architecture, so
> > we just rely on Linux virtio "knowing" that it happens. It's a bit
> > yucky but that's now history...
> 
> That is ugly as hell, but it is how virtio works everywhere, so nothing
> special so far.

Yup.

> > Essentially pseries "architecturally" does not have the concept of not
> > having an iommu in the way and qemu violates that architecture today.
> > 
> > (Remember it comes from pHyp, our priorietary HV, which we are somewhat
> > mimmicing here).
> 
> It shouldnt be too hard to have a dt property that communicates this,
> should it?

We could invent something I suppose. The additional problem then (yeah
I know ... what a mess) is that qemu doesn't create the DT for PCI
devices, the firmware (SLOF) inside the guest does using normal PCI
probing.

That said, that FW could know about all the virtio vendor/device IDs,
check the VIRTIO_F_IOMMU_PLATFORM and set that property accordingly...
messy but doable. It's not a bus property (see my other reply below as
this could complicate things with your bus mask).

But we are drifting from the problem at hand :-) You propose we do set
VIRTIO_F_IOMMU_PLATFORM so we aren't in the above case, and the bypass
stuff works, so no need to touch it.

See my recap at the end of the email to make sure I understand fully
what you suggest.

> > So if we always set VIRTIO_F_IOMMU_PLATFORM, it *will* force all virtio
> > through that iommu and performance will suffer (esp vhost I suspect),
> > especially since adding/removing translations in the iommu is a
> > hypercall.

> Well, we'd nee to make sure that for this particular bus we skip the
> actualy iommu.

It's not a bus property. Qemu will happily mix up everything on the
same bus, that includes emulated devices that go through the emulated
iommu, real VFIO devices that go through an actual HW iommu and virtio
that bypasses everything.

This makes things tricky in general (not just in my powerpc secure VM
case) since, at least on powerpc but I suppose elsewhere too, iommu
related properties tend to be per "bus" while here, qemu will mix and
match.

But again, I think we are drifting away from the topic, see below

> > > It would not be the same effect.  The problem with that is that you must
> > > now assumes that your qemu knows that for example you might be passing
> > > a dma offset if the bus otherwise requires it. 
> > 
> > I would assume that arch_virtio_wants_dma_ops() only returns true when
> > no such offsets are involved, at least in our case that would be what
> > happens.
> 
> That would work, but we're really piling hacĸs ontop of hacks here.

Sort-of :-) At least none of what we are discussing now involves
touching the dma_ops themselves so we are not in the way of your big
cleanup operation here. But yeah, let's continue discussing your other
solution below.

> > >  Or in other words:
> > > you potentially break the contract between qemu and the guest of always
> > > passing down physical addresses.  If we explicitly change that contract
> > > through using a flag that says you pass bus address everything is fine.
> > 
> > For us a "bus address" is behind the iommu so that's what
> > VIRTIO_F_IOMMU_PLATFORM does already. We don't have the concept of a
> > bus address that is different. I suppose it's an ARMism to have DMA
> > offsets that are separate from iommus ? 
> 
> No, a lot of platforms support a bus address that has an offset from
> the physical address. including a lot of power platforms:

Ok, just talking past each other :-) For all the powerpc ones, these
*do* go through the iommu, which is what I meant. It's just a window of
the iommu that provides some kind of direct mapping of memory.

For pseries, there is no such thing however. What we do to avoid
constant map/unmap of iommu PTEs in pseries guests is that we use
hypercalls to create a 64-bit window and populate all its PTEs with an
identity mapping. But that's not as efficient as a real bypass.

There are good historical reasons for that, since pseries is a guest
platform, its memory is never really where the guest thinks it is, so
you always need an iommu to remap. Even for virtual devices, since for
most of them, in the "IBM" pHyp model, the "peer" is actually another
partition, so the virtual iommu handles translating accross the two
partitions.

Same goes with cell in HW, no real bypass, just the iommu being
confiured with very large pages and a fixed mapping.

powernv has a separate physical window that can be configured as a real
bypass though, so does the U4 DART. Not sure about the FSL one.

But yeah, your point stands, this is just implementation details.

> arch/powerpc/kernel/pci-common.c:       set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
> arch/powerpc/platforms/cell/iommu.c:            set_dma_offset(dev, cell_dma_nommu_offset);
> arch/powerpc/platforms/cell/iommu.c:            set_dma_offset(dev, addr);
> arch/powerpc/platforms/powernv/pci-ioda.c:      set_dma_offset(&pdev->dev, pe->tce_bypass_base);
> arch/powerpc/platforms/powernv/pci-ioda.c:                      set_dma_offset(&pdev->dev, (1ULL << 32));
> arch/powerpc/platforms/powernv/pci-ioda.c:              set_dma_offset(&dev->dev, pe->tce_bypass_base);
> arch/powerpc/platforms/pseries/iommu.c:                         set_dma_offset(dev, dma_offset);
> arch/powerpc/sysdev/dart_iommu.c:               set_dma_offset(&dev->dev, DART_U4_BYPASS_BASE);
> arch/powerpc/sysdev/fsl_pci.c:          set_dma_offset(dev, pci64_dma_offset);
> 
> to make things worse some platforms (at least on arm/arm64/mips/x86) can
> also require additional banking where it isn't even a single linear map
> but multiples windows.

Sure, but all of this is just the configuration of the iommu. But I
think we agree here, and your point remains valid, indeed my proposed
hack:

>       if ((flags & VIRTIO_F_IOMMU_PLATFORM) || arch_virtio_wants_dma_ops())

Will only work if the IOMMU and non-IOMMU path are completely equivalent.

We can provide that guarantee for our secure VM case, but not generally so if
we were to go down the route of a quirk in virtio, it might be better to
make it painfully obvious that it's specific to that one case with a different
kind of turd:

-	if (xen_domain())
+	if (xen_domain() || pseries_secure_vm())
		return true;

So to summarize, and make sure I'm not missing something, the two approaches
at hand are either:

 1- The above, which is a one liner and contained in the guest, so that's nice, but
also means another turd in virtio which isn't ...

 2- We force pseries to always set VIRTIO_F_IOMMU_PLATFORM, but with the current
architecture on our side that will force virtio to always go through an emulated
iommu, as pseries doesn't have the concept of a real bypass window, and thus will
impact performance for both secure and non-secure VMs.

 3- Invent a property that can be put in selected PCI device tree nodes that
indicates that for that device specifically, the iommu can be bypassed, along with
a hypercall to turn that bypass on/off. Virtio would then use VIRTIO_F_IOMMU_PLATFORM
but its DT nodes would also have that property and Linux would notice it and turn
bypass on.

The resulting properties of those options are:

1- Is what I want because it's the simplest, provides the best performance now,
   and works without code changes to qemu or non-secure Linux. However it does
   add a tiny turd to virtio which is annoying.

2- This works but it puts the iommu in the way always, thus reducing virtio performance
   accross the board for pseries unless we only do that for secure VMs but that is
   difficult (as discussed earlier).

3- This would recover the performance lost in -2-, however it requires qemu *and*
   guest changes. Specifically, existing guests (RHEL 7 etc...) would get the
   performance hit of -2- unless modified to call that 'enable bypass' call, which
   isn't great.

So imho we have to chose one of 3 not-great solutions here... Unless I missed
something in your ideas of course.

Cheers,
Ben.
