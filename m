Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zvjv35lzzF13F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 22:43:15 +1000 (AEST)
Date: Mon, 4 Jun 2018 15:43:09 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, hch@infradead.org
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180604153558-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 24, 2018 at 08:27:04AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2018-05-23 at 21:50 +0300, Michael S. Tsirkin wrote:
> 
> > I re-read that discussion and I'm still unclear on the
> > original question, since I got several apparently
> > conflicting answers.
> > 
> > I asked:
> > 
> > 	Why isn't setting VIRTIO_F_IOMMU_PLATFORM on the
> > 	hypervisor side sufficient?
> 
> I thought I had replied to this...
> 
> There are a couple of reasons:
> 
> - First qemu doesn't know that the guest will switch to "secure mode"
> in advance. There is no difference between a normal and a secure
> partition until the partition does the magic UV call to "enter secure
> mode" and qemu doesn't see any of it. So who can set the flag here ?

The user should set it. You just tell user "to be able to use with
feature X, enable IOMMU".

> - Second, when using VIRTIO_F_IOMMU_PLATFORM, we also make qemu (or
> vhost) go through the emulated MMIO for every access to the guest,
> which adds additional overhead.
> 
> Cheers,
> Ben.

There are several answers to this.  One is that we are working hard to
make overhead small when the mappings are static (which they would be if
there's no actual IOMMU). So maybe especially given you are using
a bounce buffer on top it's not so bad - did you try to
benchmark?

Another is that given the basic functionality is in there, optimizations
can possibly wait until per-device quirks in DMA API are supported.


> > 
> > 
> > >  arch/powerpc/include/asm/dma-mapping.h |  6 ++++++
> > >  arch/powerpc/platforms/pseries/iommu.c | 11 +++++++++++
> > >  drivers/virtio/virtio_ring.c           | 10 ++++++++++
> > >  3 files changed, 27 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> > > index 8fa3945..056e578 100644
> > > --- a/arch/powerpc/include/asm/dma-mapping.h
> > > +++ b/arch/powerpc/include/asm/dma-mapping.h
> > > @@ -115,4 +115,10 @@ extern u64 __dma_get_required_mask(struct device *dev);
> > >  #define ARCH_HAS_DMA_MMAP_COHERENT
> > >  
> > >  #endif /* __KERNEL__ */
> > > +
> > > +#define platform_forces_virtio_dma platform_forces_virtio_dma
> > > +
> > > +struct virtio_device;
> > > +
> > > +extern bool platform_forces_virtio_dma(struct virtio_device *vdev);
> > >  #endif	/* _ASM_DMA_MAPPING_H */
> > > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > > index 06f0296..a2ec15a 100644
> > > --- a/arch/powerpc/platforms/pseries/iommu.c
> > > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > > @@ -38,6 +38,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/iommu.h>
> > >  #include <linux/rculist.h>
> > > +#include <linux/virtio.h>
> > >  #include <asm/io.h>
> > >  #include <asm/prom.h>
> > >  #include <asm/rtas.h>
> > > @@ -1396,3 +1397,13 @@ static int __init disable_multitce(char *str)
> > >  __setup("multitce=", disable_multitce);
> > >  
> > >  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
> > > +
> > > +bool platform_forces_virtio_dma(struct virtio_device *vdev)
> > > +{
> > > +	/*
> > > +	 * On protected guest platforms, force virtio core to use DMA
> > > +	 * MAP API for all virtio devices. But there can also be some
> > > +	 * exceptions for individual devices like virtio balloon.
> > > +	 */
> > > +	return (of_find_compatible_node(NULL, NULL, "ibm,ultravisor") != NULL);
> > > +}
> > 
> > Isn't this kind of slow?  vring_use_dma_api is on
> > data path and supposed to be very fast.
> > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 21d464a..47ea6c3 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -141,8 +141,18 @@ struct vring_virtqueue {
> > >   * unconditionally on data path.
> > >   */
> > >  
> > > +#ifndef platform_forces_virtio_dma
> > > +static inline bool platform_forces_virtio_dma(struct virtio_device *vdev)
> > > +{
> > > +	return false;
> > > +}
> > > +#endif
> > > +
> > >  static bool vring_use_dma_api(struct virtio_device *vdev)
> > >  {
> > > +	if (platform_forces_virtio_dma(vdev))
> > > +		return true;
> > > +
> > >  	if (!virtio_has_iommu_quirk(vdev))
> > >  		return true;
> > >  
> > > -- 
> > > 2.9.3
