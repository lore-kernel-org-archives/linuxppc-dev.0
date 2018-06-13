Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415T021CfJzDr9J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 23:59:45 +1000 (AEST)
Date: Wed, 13 Jun 2018 16:59:41 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ram Pai <linuxram@us.ibm.com>, robh@kernel.org, pawel.moll@arm.com,
 Tom Lendacky <thomas.lendacky@amd.com>, aik@ozlabs.ru,
 jasowang@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com,
 "Rustad, Mark D" <mark.d.rustad@intel.com>,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180613164500-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613074141.GA12033@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2018 at 12:41:41AM -0700, Christoph Hellwig wrote:
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
> 
> I think the right way forward is to either add a new
> VIRTIO_F_IS_PCI_DEVICE (or redefine the existing iommu flag if deemed
> possible).

Given this is exactly what happens now, this seems possible, but maybe
we want a non-PCI specific name.

>  And then make sure recent qemu always sets it.

I don't think that part is going to happen, sorry.

Hypervisors can set it when they *actually have* a real PCI device.
People emulate systems which have a bunch of overhead in the DMA API
which is required for real DMA. Your proposal would double that overhead
by first doing it in guest then re-doing it in host.

I don't think it's justified when 99% of the world doesn't need it.
-- 
MST
