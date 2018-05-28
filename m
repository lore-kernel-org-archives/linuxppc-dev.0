Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vtqh51LwzDr3M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 09:49:20 +1000 (AEST)
Message-ID: <6fff9f5d67361653e6072570a857cf0d1009a123.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
 jasowang@redhat.com, mpe@ellerman.id.au, hch@infradead.org
Date: Tue, 29 May 2018 09:48:17 +1000
In-Reply-To: <20180525202300-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
 <20180525202300-mutt-send-email-mst@kernel.org>
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

On Fri, 2018-05-25 at 20:45 +0300, Michael S. Tsirkin wrote:
> On Thu, May 24, 2018 at 08:27:04AM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2018-05-23 at 21:50 +0300, Michael S. Tsirkin wrote:
> > 
> > > I re-read that discussion and I'm still unclear on the
> > > original question, since I got several apparently
> > > conflicting answers.
> > > 
> > > I asked:
> > > 
> > > 	Why isn't setting VIRTIO_F_IOMMU_PLATFORM on the
> > > 	hypervisor side sufficient?
> > 
> > I thought I had replied to this...
> > 
> > There are a couple of reasons:
> > 
> > - First qemu doesn't know that the guest will switch to "secure mode"
> > in advance. There is no difference between a normal and a secure
> > partition until the partition does the magic UV call to "enter secure
> > mode" and qemu doesn't see any of it. So who can set the flag here ?
> 
> Not sure I understand. Just set the flag e.g. on qemu command line.
> I might be wrong, but these secure mode things usually
> a. require hypervisor side tricks anyway

The way our secure mode architecture is designed, there doesn't need at
this point to be any knowledge at qemu level whatsoever. Well at least
until we do migration but that's a different kettle of fish. In any
case, the guest starts normally (which means as a non-secure guest, and
thus expects normal virtio, our FW today doesn't handle
VIRTIO_F_IOMMU_PLATFORM, though granted, we can fix this), and later
that guest issues some special Ultravisor call that turns it into a
secure guest.

There is some involvement of the hypervisor, but not qemu at this
stage. We would very much like to avoid that, as it would be a hassle
for users to have to use different libvirt options etc... bcs the guest
might turn itself into a secure VM.

> > - Second, when using VIRTIO_F_IOMMU_PLATFORM, we also make qemu (or
> > vhost) go through the emulated MMIO for every access to the guest,
> > which adds additional overhead.
> > 
> > Cheers,
> > Ben.
> 
> Well it's not supposed to be much slower for the static case.
> 
> vhost has a cache so should be fine.
> 
> A while ago Paolo implemented a translation cache which should be
> perfect for this case - most of the code got merged but
> never enabled because of stability issues.
> 
> If all else fails, we could teach QEMU to handle the no-iommu case
> as if VIRTIO_F_IOMMU_PLATFORM was off.

Any serious reason why not just getting that 2 line patch allowing our
arch code to force virtio to use the DMA API ?

It's not particularly invasive and solves our problem rather nicely
without adding overhead or additional knowledge to qemu/libvirt/mgmnt
tools etc... that it doesn't need etc....

The guest knows it's going secure so the guest arch code can do the
right thing rather trivially.

Long term we should probably make virtio always use the DMA API anyway,
and interpose "1:1" dma_ops for the traditional virtio case, that would
reduce code clutter significantly. In that case, it would become just a
matter of having a platform hook to override the dma_ops used.

Cheers,
Ben.

> 
> 
> > > 
> > > 
> > > >  arch/powerpc/include/asm/dma-mapping.h |  6 ++++++
> > > >  arch/powerpc/platforms/pseries/iommu.c | 11 +++++++++++
> > > >  drivers/virtio/virtio_ring.c           | 10 ++++++++++
> > > >  3 files changed, 27 insertions(+)
> > > > 
> > > > diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> > > > index 8fa3945..056e578 100644
> > > > --- a/arch/powerpc/include/asm/dma-mapping.h
> > > > +++ b/arch/powerpc/include/asm/dma-mapping.h
> > > > @@ -115,4 +115,10 @@ extern u64 __dma_get_required_mask(struct device *dev);
> > > >  #define ARCH_HAS_DMA_MMAP_COHERENT
> > > >  
> > > >  #endif /* __KERNEL__ */
> > > > +
> > > > +#define platform_forces_virtio_dma platform_forces_virtio_dma
> > > > +
> > > > +struct virtio_device;
> > > > +
> > > > +extern bool platform_forces_virtio_dma(struct virtio_device *vdev);
> > > >  #endif	/* _ASM_DMA_MAPPING_H */
> > > > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > > > index 06f0296..a2ec15a 100644
> > > > --- a/arch/powerpc/platforms/pseries/iommu.c
> > > > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > > > @@ -38,6 +38,7 @@
> > > >  #include <linux/of.h>
> > > >  #include <linux/iommu.h>
> > > >  #include <linux/rculist.h>
> > > > +#include <linux/virtio.h>
> > > >  #include <asm/io.h>
> > > >  #include <asm/prom.h>
> > > >  #include <asm/rtas.h>
> > > > @@ -1396,3 +1397,13 @@ static int __init disable_multitce(char *str)
> > > >  __setup("multitce=", disable_multitce);
> > > >  
> > > >  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
> > > > +
> > > > +bool platform_forces_virtio_dma(struct virtio_device *vdev)
> > > > +{
> > > > +	/*
> > > > +	 * On protected guest platforms, force virtio core to use DMA
> > > > +	 * MAP API for all virtio devices. But there can also be some
> > > > +	 * exceptions for individual devices like virtio balloon.
> > > > +	 */
> > > > +	return (of_find_compatible_node(NULL, NULL, "ibm,ultravisor") != NULL);
> > > > +}
> > > 
> > > Isn't this kind of slow?  vring_use_dma_api is on
> > > data path and supposed to be very fast.
> > > 
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 21d464a..47ea6c3 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -141,8 +141,18 @@ struct vring_virtqueue {
> > > >   * unconditionally on data path.
> > > >   */
> > > >  
> > > > +#ifndef platform_forces_virtio_dma
> > > > +static inline bool platform_forces_virtio_dma(struct virtio_device *vdev)
> > > > +{
> > > > +	return false;
> > > > +}
> > > > +#endif
> > > > +
> > > >  static bool vring_use_dma_api(struct virtio_device *vdev)
> > > >  {
> > > > +	if (platform_forces_virtio_dma(vdev))
> > > > +		return true;
> > > > +
> > > >  	if (!virtio_has_iommu_quirk(vdev))
> > > >  		return true;
> > > >  
> > > > -- 
> > > > 2.9.3
