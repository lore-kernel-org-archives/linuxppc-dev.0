Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gnFK1mW5zF1Qn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 07:56:21 +1000 (AEST)
Date: Thu, 2 Aug 2018 00:56:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
 jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180802003823-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 31, 2018 at 03:36:22PM -0500, Benjamin Herrenschmidt wrote:
> On Tue, 2018-07-31 at 10:30 -0700, Christoph Hellwig wrote:
> > > However the question people raise is that DMA API is already full of
> > > arch-specific tricks the likes of which are outlined in your post linked
> > > above. How is this one much worse?
> > 
> > None of these warts is visible to the driver, they are all handled in
> > the architecture (possibly on a per-bus basis).
> > 
> > So for virtio we really need to decide if it has one set of behavior
> > as specified in the virtio spec, or if it behaves exactly as if it
> > was on a PCI bus, or in fact probably both as you lined up.  But no
> > magic arch specific behavior inbetween.
> 
> The only arch specific behaviour is needed in the case where it doesn't
> behave like PCI. In this case, the PCI DMA ops are not suitable, but in
> our secure VMs, we still need to make it use swiotlb in order to bounce
> through non-secure pages.
> 
> It would be nice if "real PCI" was the default

I think you are mixing "real PCI" which isn't coded up yet and IOMMU
bypass which is. IOMMU bypass will maybe with time become unnecessary
since it seems that one can just program an IOMMU in a bypass mode
instead.

It's hard to blame you since right now if you disable IOMMU bypass
you get a real PCI mode. But they are distinct and to allow people
to enable IOMMU by default we will need to teach someone
(virtio or DMA API) about this mode that does follow
translation and protection rules in the IOMMU but runs
on a CPU and so does not need cache flushes and whatnot.

OTOH real PCI mode as opposed to default hypervisor mode does not perform as
well when what you actually have is a hypervisor.

So we'll likely have a mix of these two modes for a while.

> but it's not, VMs are
> created in "legacy" mode all the times and we don't know at VM creation
> time whether it will become a secure VM or not. The way our secure VMs
> work is that they start as a normal VM, load a secure "payload" and
> call the Ultravisor to "become" secure.
> 
> So we're in a bit of a bind here. We need that one-liner optional arch
> hook to make virtio use swiotlb in that "IOMMU bypass" case.
> 
> Ben.

And just to make sure I understand, on your platform DMA APIs do include
some of the cache flushing tricks and this is why you don't want to
declare iommu support in the hypervisor?

-- 
MST
