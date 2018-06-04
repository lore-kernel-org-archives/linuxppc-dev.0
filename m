Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410B1P6HWfzF1S9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 09:27:37 +1000 (AEST)
Message-ID: <6164442a718645a754879eac5c4c5fad9283c211.camel@kernel.crashing.org>
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
Date: Tue, 05 Jun 2018 09:26:56 +1000
In-Reply-To: <20180604184035-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
 <20180604153558-mutt-send-email-mst@kernel.org>
 <e7ceddbec11711a89282e9b70b7fd3c8af10b030.camel@kernel.crashing.org>
 <20180604184035-mutt-send-email-mst@kernel.org>
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

On Mon, 2018-06-04 at 19:21 +0300, Michael S. Tsirkin wrote:
> 
> > > > - First qemu doesn't know that the guest will switch to "secure mode"
> > > > in advance. There is no difference between a normal and a secure
> > > > partition until the partition does the magic UV call to "enter secure
> > > > mode" and qemu doesn't see any of it. So who can set the flag here ?
> > > 
> > > The user should set it. You just tell user "to be able to use with
> > > feature X, enable IOMMU".
> > 
> > That's completely backwards. The user has no idea what that stuff is.
> > And it would have to percolate all the way up the management stack,
> > libvirt, kimchi, whatever else ... that's just nonsense.
> > 
> > Especially since, as I explained in my other email, this is *not* a
> > qemu problem and thus the solution shouldn't be messing around with
> > qemu.
> 
> virtio is implemented in qemu though. If you prefer to stick
> all your code in either guest or the UV that's your decision
> but it looks like qemu could be helpful here.

Sorry Michael, that doesn't click. Yes of course virtio is implemented
in qemu, but the problem we are trying to solve is *not* a qemu problem
(the fact that the Linux drivers bypass the DMA API is wrong, needs
fixing, and isnt a qemu problem). The fact that the secure guests need
bounce buffering is not a qemu problem either.

Whether qemu chose to use an iommu or not is, and should remain an
orthogonal problem.

Forcing qemu to use the iommu to work around a linux side lack of
proper use of the DMA API is not only just papering over the problem,
it's also forcing changes up 3 or 4 levels of the SW stack to create
that new option that no user will understand the meaning of and that
would otherwise be unnecessary.

> For example what if you have a guest that passes physical addresses
> to qemu bypassing swiotlb? Don't you want to detect
> that and fail gracefully rather than crash the guest?

A guest bug then ? Well it wouldn't so much crash as force the pages to
become encrypted and cause horrible ping/pong between qemu and the
guest (the secure pages aren't accessible to qemu directly).

> That's what VIRTIO_F_IOMMU_PLATFORM will do for you.

Again this is orthogonal. Using an iommu will indeed provide a modicum
of protection against buggy drivers, like it does on HW PCI platforms,
whether those guests are secure or not.

Note however that in practice, we tend to disable the iommu even on
real HW whenever we want performance (of course we can't for guests but
for bare metal systems we do, the added RAS isn't worth the performance
lost for very fast networking for example).

> Still that's hypervisor's decision. What isn't up to the hypervisor is
> the way we structure code. We made an early decision to merge a hack
> with xen, among discussion about how with time DMA API will learn to
> support per-device quirks and we'll be able to switch to that.
> So let's do that now?

The DMA API itself isn't the one that needs to learn "per-device
quirks", it's just plumbing into arch backends. The "quirk" is at the
point of establishing the backend for a given device.

We can go a good way down that path simply by having virtio in Linux
start with putting *itself* its own direct ops in there when
VIRTIO_F_IOMMU_PLATFORM is not set, and removing all the special casing
in the rest of the driver.

Once that's done, we have a single point of establishing the dma ops,
we can quirk in there if needed, that's rather nicely contained, or put
an arch hook, or whatever is necessary.

I would like to keep however the ability to bypass the iommu for
performance reasons, and also because it's qemu default mode of
operation and my secure guest has no clean way to force qemu to turn
the iommu on. The hypervisor *could* return something to qemu when the
guest switch to secure as we do know that, and qemu could walk all of
it's virtio devices as a result and "switch" them over but that's
almost grosser from a qemu perspective.

.../...

> > The point is that requiring specific qemu command line arguments isn't
> > going to fly. We have additional problems due to the fact that our
> > firmware (SLOF) inside qemu doesn't currently deal with iommu's etc...
> > though those can be fixed.
> > 
> > Overall, however, this seems to be the most convoluted way of achieving
> > things, require user interventions where none should be needed etc...
> > 
> > Again, what's wrong with a 2 lines hook instead that solves it all and
> > completely avoids involving qemu ?
> > 
> > Ben.
> 
> That each platform wants to add hacks in this data path function.

Sure, then add a single platform hook and the platforms can do what
they want here.

But as I said, it should all be done at initialization time rather than
in the data path, this we absolutely agree. We should just chose the
right set of dma_ops, and have the data path always use the DMA API.

Cheers,
Ben.


> > > 
> > > > > 
> > > > > 
> > > > > >  arch/powerpc/include/asm/dma-mapping.h |  6 ++++++
> > > > > >  arch/powerpc/platforms/pseries/iommu.c | 11 +++++++++++
> > > > > >  drivers/virtio/virtio_ring.c           | 10 ++++++++++
> > > > > >  3 files changed, 27 insertions(+)
> > > > > > 
> > > > > > diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> > > > > > index 8fa3945..056e578 100644
> > > > > > --- a/arch/powerpc/include/asm/dma-mapping.h
> > > > > > +++ b/arch/powerpc/include/asm/dma-mapping.h
> > > > > > @@ -115,4 +115,10 @@ extern u64 __dma_get_required_mask(struct device *dev);
> > > > > >  #define ARCH_HAS_DMA_MMAP_COHERENT
> > > > > >  
> > > > > >  #endif /* __KERNEL__ */
> > > > > > +
> > > > > > +#define platform_forces_virtio_dma platform_forces_virtio_dma
> > > > > > +
> > > > > > +struct virtio_device;
> > > > > > +
> > > > > > +extern bool platform_forces_virtio_dma(struct virtio_device *vdev);
> > > > > >  #endif	/* _ASM_DMA_MAPPING_H */
> > > > > > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > > > > > index 06f0296..a2ec15a 100644
> > > > > > --- a/arch/powerpc/platforms/pseries/iommu.c
> > > > > > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > > > > > @@ -38,6 +38,7 @@
> > > > > >  #include <linux/of.h>
> > > > > >  #include <linux/iommu.h>
> > > > > >  #include <linux/rculist.h>
> > > > > > +#include <linux/virtio.h>
> > > > > >  #include <asm/io.h>
> > > > > >  #include <asm/prom.h>
> > > > > >  #include <asm/rtas.h>
> > > > > > @@ -1396,3 +1397,13 @@ static int __init disable_multitce(char *str)
> > > > > >  __setup("multitce=", disable_multitce);
> > > > > >  
> > > > > >  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
> > > > > > +
> > > > > > +bool platform_forces_virtio_dma(struct virtio_device *vdev)
> > > > > > +{
> > > > > > +	/*
> > > > > > +	 * On protected guest platforms, force virtio core to use DMA
> > > > > > +	 * MAP API for all virtio devices. But there can also be some
> > > > > > +	 * exceptions for individual devices like virtio balloon.
> > > > > > +	 */
> > > > > > +	return (of_find_compatible_node(NULL, NULL, "ibm,ultravisor") != NULL);
> > > > > > +}
> > > > > 
> > > > > Isn't this kind of slow?  vring_use_dma_api is on
> > > > > data path and supposed to be very fast.
> > > > > 
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > index 21d464a..47ea6c3 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -141,8 +141,18 @@ struct vring_virtqueue {
> > > > > >   * unconditionally on data path.
> > > > > >   */
> > > > > >  
> > > > > > +#ifndef platform_forces_virtio_dma
> > > > > > +static inline bool platform_forces_virtio_dma(struct virtio_device *vdev)
> > > > > > +{
> > > > > > +	return false;
> > > > > > +}
> > > > > > +#endif
> > > > > > +
> > > > > >  static bool vring_use_dma_api(struct virtio_device *vdev)
> > > > > >  {
> > > > > > +	if (platform_forces_virtio_dma(vdev))
> > > > > > +		return true;
> > > > > > +
> > > > > >  	if (!virtio_has_iommu_quirk(vdev))
> > > > > >  		return true;
> > > > > >  
> > > > > > -- 
> > > > > > 2.9.3
