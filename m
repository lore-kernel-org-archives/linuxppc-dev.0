Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fL2B24zJzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 23:26:41 +1000 (AEST)
Date: Mon, 30 Jul 2018 16:26:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxram@us.ibm.com, haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
 jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180730155633-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730111802.GA9830@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2018 at 04:18:02AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 30, 2018 at 01:28:03PM +0300, Michael S. Tsirkin wrote:
> > Let me reply to the "crappy" part first:
> > So virtio devices can run on another CPU or on a PCI bus. Configuration
> > can happen over mupltiple transports.  There is a discovery protocol to
> > figure out where it is. It has some warts but any real system has warts.
> > 
> > So IMHO virtio running on another CPU isn't "legacy virtual crappy
> > virtio". virtio devices that actually sit on a PCI bus aren't "sane"
> > simply because the DMA is more convoluted on some architectures.
> 
> All of what you said would be true if virtio didn't claim to be
> a PCI device.  

There's nothing virtio claims to be.  It's a PV device that uses PCI for
its configuration.  Configuration is enumerated on the virtual PCI bus.
That part of the interface is emulated PCI. Data path is through a
PV device enumerated on the virtio bus.

> Once it claims to be a PCI device and we also see
> real hardware written to the interface I stand to all what I said
> above.

Real hardware would reuse parts of the interface but by necessity it
needs to behave slightly differently on some platforms.  However for
some platforms (such as x86) a PV virtio driver will by luck work with a
PCI device backend without changes. As these platforms and drivers are
widely deployed, some people will deploy hardware like that.  Should be
a non issue as by definition it's transparent to guests.

> > With this out of my system:
> > I agree these approaches are hacky. I think it is generally better to
> > have virtio feature negotiation tell you whether device runs on a CPU or
> > not rather than rely on platform specific ways for this. To this end
> > there was a recent proposal to rename VIRTIO_F_IO_BARRIER to
> > VIRTIO_F_REAL_DEVICE.  It got stuck since "real" sounds vague to people,
> > e.g.  what if it's a VF - is that real or not? But I can see something
> > like e.g. VIRTIO_F_PLATFORM_DMA gaining support.
> > 
> > We would then rename virtio_has_iommu_quirk to virtio_has_dma_quirk
> > and test VIRTIO_F_PLATFORM_DMA in addition to the IOMMU thing.
> 
> I don't really care about the exact naming, and indeed a device that
> sets the flag doesn't have to be a 'real' device - it just has to act
> like one.  I explained all the issues that this means (at least relating
> to DMA) in one of the previous threads.

I believe you refer to this:
https://lkml.org/lkml/2018/6/7/15
that was a very helpful list outlining the problems we need to solve,
thanks a lot for that!

> The important bit is that we can specify exact behavior for both
> devices that sets the "I'm real!" flag and that ones that don't exactly
> in the spec.

I would very much like that, yes.

> And that very much excludes arch-specific (or
> Xen-specific) overrides.

We already committed to a xen specific hack but generally I prefer
devices that describe how they work instead of platforms magically
guessing, yes.

However the question people raise is that DMA API is already full of
arch-specific tricks the likes of which are outlined in your post linked
above. How is this one much worse?

-- 
MST
