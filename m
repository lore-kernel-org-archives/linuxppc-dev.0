Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rhQp2G7ZzF15L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 04:50:07 +1000 (AEST)
Date: Wed, 23 May 2018 21:50:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, hch@infradead.org
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180523213703-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

subj: s/virito/virtio/

On Tue, May 22, 2018 at 12:03:17PM +0530, Anshuman Khandual wrote:
> This adds a hook which a platform can define in order to allow it to
> force the use of the DMA API for all virtio devices even if they don't
> have the VIRTIO_F_IOMMU_PLATFORM flag set.  We want to use this to do
> bounce-buffering of data on the new secure pSeries platform, currently
> under development, where a KVM host cannot access all of the memory
> space of a secure KVM guest.  The host can only access the pages which
> the guest has explicitly requested to be shared with the host, thus
> the virtio implementation in the guest has to copy data to and from
> shared pages.
> 
> With this hook, the platform code in the secure guest can force the
> use of swiotlb for virtio buffers, with a back-end for swiotlb which
> will use a pool of pre-allocated shared pages.  Thus all data being
> sent or received by virtio devices will be copied through pages which
> the host has access to.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> Changes in V2:
> 
> The arch callback has been enabled through an weak symbol defintion
> so that it is enabled only for those architectures subscribing to
> this new framework. Clarified the patch description. The primary
> objective for this RFC has been to get an in principle agreement
> on this approach.
> 
> Original V1:
> 
> Original RFC and discussions https://patchwork.kernel.org/patch/10324405/

I re-read that discussion and I'm still unclear on the
original question, since I got several apparently
conflicting answers.

I asked:

	Why isn't setting VIRTIO_F_IOMMU_PLATFORM on the
	hypervisor side sufficient?



>  arch/powerpc/include/asm/dma-mapping.h |  6 ++++++
>  arch/powerpc/platforms/pseries/iommu.c | 11 +++++++++++
>  drivers/virtio/virtio_ring.c           | 10 ++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index 8fa3945..056e578 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -115,4 +115,10 @@ extern u64 __dma_get_required_mask(struct device *dev);
>  #define ARCH_HAS_DMA_MMAP_COHERENT
>  
>  #endif /* __KERNEL__ */
> +
> +#define platform_forces_virtio_dma platform_forces_virtio_dma
> +
> +struct virtio_device;
> +
> +extern bool platform_forces_virtio_dma(struct virtio_device *vdev);
>  #endif	/* _ASM_DMA_MAPPING_H */
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 06f0296..a2ec15a 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -38,6 +38,7 @@
>  #include <linux/of.h>
>  #include <linux/iommu.h>
>  #include <linux/rculist.h>
> +#include <linux/virtio.h>
>  #include <asm/io.h>
>  #include <asm/prom.h>
>  #include <asm/rtas.h>
> @@ -1396,3 +1397,13 @@ static int __init disable_multitce(char *str)
>  __setup("multitce=", disable_multitce);
>  
>  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
> +
> +bool platform_forces_virtio_dma(struct virtio_device *vdev)
> +{
> +	/*
> +	 * On protected guest platforms, force virtio core to use DMA
> +	 * MAP API for all virtio devices. But there can also be some
> +	 * exceptions for individual devices like virtio balloon.
> +	 */
> +	return (of_find_compatible_node(NULL, NULL, "ibm,ultravisor") != NULL);
> +}

Isn't this kind of slow?  vring_use_dma_api is on
data path and supposed to be very fast.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 21d464a..47ea6c3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -141,8 +141,18 @@ struct vring_virtqueue {
>   * unconditionally on data path.
>   */
>  
> +#ifndef platform_forces_virtio_dma
> +static inline bool platform_forces_virtio_dma(struct virtio_device *vdev)
> +{
> +	return false;
> +}
> +#endif
> +
>  static bool vring_use_dma_api(struct virtio_device *vdev)
>  {
> +	if (platform_forces_virtio_dma(vdev))
> +		return true;
> +
>  	if (!virtio_has_iommu_quirk(vdev))
>  		return true;
>  
> -- 
> 2.9.3
