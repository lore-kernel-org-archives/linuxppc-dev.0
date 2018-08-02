Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hFqs26DyzF21L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 02:24:25 +1000 (AEST)
Message-ID: <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com,
 robin.murphy@arm.com, jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date: Thu, 02 Aug 2018 11:01:26 -0500
In-Reply-To: <20180802182959-mutt-send-email-mst@kernel.org>
References: <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com> <20180801083639.GF26378@infradead.org>
 <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
 <20180802182959-mutt-send-email-mst@kernel.org>
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

On Thu, 2018-08-02 at 18:41 +0300, Michael S. Tsirkin wrote:
> 
> > I don't completely agree:
> > 
> > 1 - VIRTIO_F_IOMMU_PLATFORM is a property of the "other side", ie qemu
> > for example. It indicates that the peer bypasses the normal platform
> > iommu. The platform code in the guest has no real way to know that this
> > is the case, this is a specific "feature" of the qemu implementation.
> > 
> > 2 - VIRTIO_F_PLATFORM_DMA (or whatever you want to call it), is a
> > property of the guest platform itself (not qemu), there's no way the
> > "peer" can advertize it via the virtio negociated flags. At least for
> > us. I don't know for sure whether that would be workable for the ARM
> > case. In our case, qemu has no idea at VM creation time that the VM
> > will turn itself into a secure VM and thus will require bounce
> > buffering for IOs (including virtio).
> > 
> > So unless we have another hook for the arch code to set
> > VIRTIO_F_PLATFORM_DMA on selected (or all) virtio devices from the
> > guest itself, I don't see that as a way to deal with it.
> > 
> > >  The other issue is VIRTIO_F_IO_BARRIER
> > > which is very vaguely defined, and which needs a better definition.
> > > And last but not least we'll need some text explaining the challenges
> > > of hardware devices - I think VIRTIO_F_PLATFORM_DMA + VIRTIO_F_IO_BARRIER
> > > is what would basically cover them, but a good description including
> > > an explanation of why these matter.
> > 
> > Ben.
> > 
> 
> So is it true that from qemu point of view there is nothing special
> going on?  You pass in a PA, host writes there.

Yes, qemu doesn't see a different. It's the guest that will bounce the
pages via a pool of "insecure" pages that qemu can access. Normal pages
in a secure VM come from PAs that qemu cannot physically access.

Cheers,
Ben.
