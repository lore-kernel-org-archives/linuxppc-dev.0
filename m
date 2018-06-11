Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413zDz37nWzF3Gd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 13:35:47 +1000 (AEST)
Message-ID: <59e60715f27b10bc6816193eaf324824eff69c46.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Ram Pai <linuxram@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, robh@kernel.org, pawel.moll@arm.com,
 Tom Lendacky <thomas.lendacky@amd.com>, aik@ozlabs.ru,
 jasowang@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com, "Rustad, Mark
 D" <mark.d.rustad@intel.com>,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 11 Jun 2018 13:34:50 +1000
In-Reply-To: <20180611060949-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
 <20180607185234-mutt-send-email-mst@kernel.org>
 <20180611023909.GA5726@ram.oc3035372033.ibm.com>
 <20180611060949-mutt-send-email-mst@kernel.org>
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

On Mon, 2018-06-11 at 06:28 +0300, Michael S. Tsirkin wrote:
> 
> > However if the administrator
> > ignores/forgets/deliberatey-decides/is-constrained to NOT enable the
> > flag, virtio will not be able to pass control to the DMA ops associated
> > with the virtio devices. Which means, we have no opportunity to share
> > the I/O buffers with the hypervisor/qemu.
> > 
> > How do you suggest, we handle this case?
> 
> As step 1, ignore it as a user error.

Ugh ... not again. Ram, don't bring that subject back we ALREADY
addressed it, and requiring the *user* to do special things is just
utterly and completely wrong.

The *user* has no bloody idea what that stuff is, will never know to
set whatver magic qemu flag etc... The user will just start a a VM
normally and expect things to work. Requiring the *user* to know things
like that iommu virtio flag is complete nonsense.

If by "user" you mean libvirt, then you are now requesting about 4 or 5
different projects to be patched to add speical cases for something
they know nothing about and is completely irrelevant, while it can be
entirely addressed with a 1-liner in virtio kernel side to allow the
arch to plumb alternate DMA ops.

So for some reason you seem to be dead set on a path that leads to
mountain of user pain, changes to many different projects and overall
havok while there is a much much simpler and elegant solution at hand
which I described (again) in the response to Ram I sent about 5mn ago.

> Further you can for example add per-device quirks in virtio so it can be
> switched to dma api. make extra decisions in platform code then.
> 
> > > 
> > > 
> > > 
> > > > Both in the flag naming and the implementation there is an implication
> > > > of DMA API == IOMMU, which is fundamentally wrong.
> > > 
> > > Maybe we need to extend the meaning of PLATFORM_IOMMU or rename it.
> > > 
> > > It's possible that some setups will benefit from a more
> > > fine-grained approach where some aspects of the DMA
> > > API are bypassed, others aren't.
> > > 
> > > This seems to be what was being asked for in this thread,
> > > with comments claiming IOMMU flag adds too much overhead.
> > > 
> > > 
> > > > The DMA API does a few different things:
> > > > 
> > > >  a) address translation
> > > > 
> > > > 	This does include IOMMUs.  But it also includes random offsets
> > > > 	between PCI bars and system memory that we see on various
> > > > 	platforms.
> > > 
> > > I don't think you mean bars. That's unrelated to DMA.
> > > 
> > > >  Worse so some of these offsets might be based on
> > > > 	banks, e.g. on the broadcom bmips platform.  It also deals
> > > > 	with bitmask in physical addresses related to memory encryption
> > > > 	like AMD SEV.  I'd be really curious how for example the
> > > > 	Intel virtio based NIC is going to work on any of those
> > > > 	plaforms.
> > > 
> > > SEV guys report that they just set the iommu flag and then it all works.
> > 
> > This is one of the fundamental difference between SEV architecture and
> > the ultravisor architecture. In SEV, qemu is aware of SEV.  In
> > ultravisor architecture, only the VM that runs within qemu is aware of
> > ultravisor;  hypervisor/qemu/administrator are untrusted entities.
> 
> Spo one option is to teach qemu that it's on a platform with an
> ultravisor, this might have more advantages.
> 
> > I hope, we can make virtio subsystem flexibe enough to support various
> > security paradigms.
> 
> So if you are worried about qemu attacking guests, I see
> more problems than just passing an incorrect iommu
> flag.
> 
> 
> > Apart from the above reason, Christoph and Ben point to so many other
> > reasons to make it flexibe. So why not, make it happen?
> > 
> 
> I don't see a flexibility argument.  I just don't think new platforms
> should use workarounds that we put in place for old ones.
> 
> 
> > > I guess if there's translation we can think of this as a kind of iommu.
> > > Maybe we should rename PLATFORM_IOMMU to PLARTFORM_TRANSLATION?
> > > 
> > > And apparently some people complain that just setting that flag makes
> > > qemu check translation on each access with an unacceptable performance
> > > overhead.  Forcing same behaviour for everyone on general principles
> > > even without the flag is unlikely to make them happy.
> > > 
> > > >   b) coherency
> > > > 
> > > > 	On many architectures DMA is not cache coherent, and we need
> > > > 	to invalidate and/or write back cache lines before doing
> > > > 	DMA.  Again, I wonder how this is every going to work with
> > > > 	hardware based virtio implementations.
> > > 
> > > 
> > > You mean dma_Xmb and friends?
> > > There's a new feature VIRTIO_F_IO_BARRIER that's being proposed
> > > for that.
> > > 
> > > 
> > > >  Even worse I think this
> > > > 	is actually broken at least for VIVT event for virtualized
> > > > 	implementations.  E.g. a KVM guest is going to access memory
> > > > 	using different virtual addresses than qemu, vhost might throw
> > > > 	in another different address space.
> > > 
> > > I don't really know what VIVT is. Could you help me please?
> > > 
> > > >   c) bounce buffering
> > > > 
> > > > 	Many DMA implementations can not address all physical memory
> > > > 	due to addressing limitations.  In such cases we copy the
> > > > 	DMA memory into a known addressable bounc buffer and DMA
> > > > 	from there.
> > > 
> > > Don't do it then?
> > > 
> > > 
> > > >   d) flushing write combining buffers or similar
> > > > 
> > > > 	On some hardware platforms we need workarounds to e.g. read
> > > > 	from a certain mmio address to make sure DMA can actually
> > > > 	see memory written by the host.
> > > 
> > > I guess it isn't an issue as long as WC isn't actually used.
> > > It will become an issue when virtio spec adds some WC capability -
> > > I suspect we can ignore this for now.
> > > 
> > > > 
> > > > All of this is bypassed by virtio by default despite generally being
> > > > platform issues, not particular to a given device.
> > > 
> > > It's both a device and a platform issue. A PV device is often more like
> > > another CPU than like a PCI device.
> > > 
> > > 
> > > 
> > > -- 
> > > MST
> > 
> > -- 
> > Ram Pai
