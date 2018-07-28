Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41dJY94PJqzF0yB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 07:16:29 +1000 (AEST)
Date: Sun, 29 Jul 2018 00:16:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, hch@infradead.org,
 linuxram@us.ibm.com, haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
Message-ID: <20180729001344-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
 <c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 28, 2018 at 02:26:24PM +0530, Anshuman Khandual wrote:
> On 07/20/2018 09:29 AM, Anshuman Khandual wrote:
> > Now that virtio core always needs all virtio devices to have DMA OPS, we
> > need to make sure that the structure it points is the right one. In the
> > absence of VIRTIO_F_IOMMU_PLATFORM flag QEMU expects GPA from guest kernel.
> > In such case, virtio device must use default virtio_direct_dma_ops DMA OPS
> > structure which transforms scatter gather buffer addresses as GPA. This
> > DMA OPS override must happen as early as possible during virtio device
> > initializatin sequence before virtio core starts using given device's DMA
> > OPS callbacks for I/O transactions. This change detects device's IOMMU flag
> > and does the override in case the flag is cleared.
> > 
> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> > ---
> >  drivers/virtio/virtio.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 7907ad3..6b13987 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -166,6 +166,8 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_add_status);
> > 
> > +const struct dma_map_ops virtio_direct_dma_ops;
> > +
> >  int virtio_finalize_features(struct virtio_device *dev)
> >  {
> >  	int ret = dev->config->finalize_features(dev);
> > @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
> >  	if (ret)
> >  		return ret;
> 
> 
> The previous patch removed the code block for XEN guests which forced
> the use of DMA API all the time irrespective of VIRTIO_F_IOMMU_PLATFORM
> flag on the device. Here is what I have removed with patch 2/4 which
> breaks the existing semantics on XEN guests.
> 
> -static bool vring_use_dma_api(struct virtio_device *vdev)
> -{
> -	if (!virtio_has_iommu_quirk(vdev))
> -		return true;
> -
> -	/* Otherwise, we are left to guess. */
> -	/*
> -	 * In theory, it's possible to have a buggy QEMU-supposed
> -	 * emulated Q35 IOMMU and Xen enabled at the same time.  On
> -	 * such a configuration, virtio has never worked and will
> -	 * not work without an even larger kludge.  Instead, enable
> -	 * the DMA API if we're a Xen guest, which at least allows
> -	 * all of the sensible Xen configurations to work correctly.
> -	 */
> -	if (xen_domain())
> -		return true;
> -
> -	return false;
> -}
> 
> XEN guests would not like override with virtio_direct_dma_ops in any
> case irrespective of the flag VIRTIO_F_IOMMU_PLATFORM. So the existing
> semantics can be preserved with something like this. It just assumes
> that dev->dma_ops is non-NULL and a valid one set by the architecture.
> If required we can add those tests here before skipping the override.
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 7907ad3..6b13987 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -166,6 +166,8 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>  }
>  EXPORT_SYMBOL_GPL(virtio_add_status);
> 
> +const struct dma_map_ops virtio_direct_dma_ops;
> +
>  int virtio_finalize_features(struct virtio_device *dev)
>  {
>  	int ret = dev->config->finalize_features(dev);
> @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret)
>  		return ret;
> +
> +	if (xen_domain())
> +		goto skip_override;
> +
> +	if (virtio_has_iommu_quirk(dev))
> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
> +
> + skip_override:
> +

I prefer normal if scoping as opposed to goto spaghetti pls.
Better yet move vring_use_dma_api here and use it.
Less of a chance something will break.

>  	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>  		return 0
> 
> Will incorporate these changes in the next version.
