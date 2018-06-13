Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415Qww5qDMzDr9J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 22:26:56 +1000 (AEST)
Message-ID: <5dbcafa73b065bc619fd6adc9ef47eb6367b8378.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ram Pai <linuxram@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 robh@kernel.org, pawel.moll@arm.com, Tom Lendacky
 <thomas.lendacky@amd.com>, aik@ozlabs.ru,
 jasowang@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com, "Rustad, Mark
 D" <mark.d.rustad@intel.com>,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 13 Jun 2018 22:25:30 +1000
In-Reply-To: <20180613074141.GA12033@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
 <20180607185234-mutt-send-email-mst@kernel.org>
 <20180611023909.GA5726@ram.oc3035372033.ibm.com>
 <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
 <20180613074141.GA12033@infradead.org>
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

On Wed, 2018-06-13 at 00:41 -0700, Christoph Hellwig wrote:
> On Mon, Jun 11, 2018 at 01:29:18PM +1000, Benjamin Herrenschmidt wrote:
> > At the risk of repeating myself, let's just do the first pass which is
> > to switch virtio over to always using the DMA API in the actual data
> > flow code, with a hook at initialization time that replaces the DMA ops
> > with some home cooked "direct" ops in the case where the IOMMU flag
> > isn't set.
> > 
> > This will be equivalent to what we have today but avoids having 2
> > separate code path all over the driver.
> > 
> > Then a second stage, I think, is to replace this "hook" so that the
> > architecture gets a say in the matter.
> 
> I don't think we can actually use dma_direct_ops.  It still allows
> architectures to override parts of the dma setup, which virtio seems
> to blindly assume phys == dma and not cache flushing.

By direct ops I didn't mean *the* dma_direct_ops but a virtio-local
variants that effectively reproduces the existing expectations (ie,
virtio-dma-legacy-ops or something).

> I think the right way forward is to either add a new
> VIRTIO_F_IS_PCI_DEVICE (or redefine the existing iommu flag if deemed
> possible).  And then make sure recent qemu always sets it.

Ben.
