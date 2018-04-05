Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H5TL6zWYzF1pD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 00:54:43 +1000 (AEST)
Date: Thu, 5 Apr 2018 17:54:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, aik@ozlabs.ru, jasowang@redhat.com,
 joe@perches.com, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, david@gibson.dropbear.id.au
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Message-ID: <20180405175326-mutt-send-email-mst@kernel.org>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
 <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 05, 2018 at 08:09:30PM +0530, Anshuman Khandual wrote:
> On 04/05/2018 04:26 PM, Anshuman Khandual wrote:
> > There are certian platforms which would like to use SWIOTLB based DMA API
> > for bouncing purpose without actually requiring an IOMMU back end. But the
> > virtio core does not allow such mechanism. Right now DMA MAP API is only
> > selected for devices which have an IOMMU and then the QEMU/host back end
> > will process all incoming SG buffer addresses as IOVA instead of simple
> > GPA which is the case for simple bounce buffers after being processed with
> > SWIOTLB API. To enable this usage, it introduces an architecture specific
> > function which will just make virtio core front end select DMA operations
> > structure.
> > 
> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> + "Michael S. Tsirkin" <mst@redhat.com>

I'm confused by this.

static bool vring_use_dma_api(struct virtio_device *vdev)
{
        if (!virtio_has_iommu_quirk(vdev))
                return true;


Why doesn't setting VIRTIO_F_IOMMU_PLATFORM on the
hypervisor side sufficient?
