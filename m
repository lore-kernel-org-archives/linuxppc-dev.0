Return-Path: <BATV+f68373395790e050ff16+5399+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410Kkq3YJ1zF1fm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 15:15:31 +1000 (AEST)
Date: Mon, 4 Jun 2018 21:52:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, hch@infradead.org,
 luto@amacapital.net
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180605045207.GA28447@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
 <20180604153558-mutt-send-email-mst@kernel.org>
 <e7ceddbec11711a89282e9b70b7fd3c8af10b030.camel@kernel.crashing.org>
 <20180604184035-mutt-send-email-mst@kernel.org>
 <6164442a718645a754879eac5c4c5fad9283c211.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6164442a718645a754879eac5c4c5fad9283c211.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 05, 2018 at 09:26:56AM +1000, Benjamin Herrenschmidt wrote:
> Sorry Michael, that doesn't click. Yes of course virtio is implemented
> in qemu, but the problem we are trying to solve is *not* a qemu problem
> (the fact that the Linux drivers bypass the DMA API is wrong, needs
> fixing, and isnt a qemu problem). The fact that the secure guests need
> bounce buffering is not a qemu problem either.
> 
> Whether qemu chose to use an iommu or not is, and should remain an
> orthogonal problem.

Agreed.  We have a problem with qemu (old qemu only?) punching a hole
into the VM abstraction by deciding that even if firmware tables
claim use of an IOMMU for a PCI bus it expects virtio to use physiscal
addresses.  So far so bad.  The answer to that should have been to
quirk the affected qemu versions and move on.  Instead we now have
virtio not use the DMA API by default and are creating a worse problem.

Let's fix this issue ASAP and quirk the buggy implementations instead
of letting everyone else suffer.  

> The DMA API itself isn't the one that needs to learn "per-device
> quirks", it's just plumbing into arch backends. The "quirk" is at the
> point of establishing the backend for a given device.
> 
> We can go a good way down that path simply by having virtio in Linux
> start with putting *itself* its own direct ops in there when
> VIRTIO_F_IOMMU_PLATFORM is not set, and removing all the special casing
> in the rest of the driver.

Yes.  And we have all the infrastructure for that now.  A few RDMA
drivers quirk to virt_dma_ops, and virtio could quirk to dma_direct_ops
anytime now.  In fact given how much time we are spending arguing here
I'm going to give it a spin today.

> Once that's done, we have a single point of establishing the dma ops,
> we can quirk in there if needed, that's rather nicely contained, or put
> an arch hook, or whatever is necessary.

Yes.
