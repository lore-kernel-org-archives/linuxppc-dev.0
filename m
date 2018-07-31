Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fmyR4dt0zF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 16:39:59 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6V6dO7u091793
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 02:39:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kjhrkhx3v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 02:39:56 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 31 Jul 2018 07:39:54 +0100
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
To: Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
 <c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
 <20180729001344-mutt-send-email-mst@kernel.org>
 <20180730093027.GC26245@infradead.org>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 31 Jul 2018 12:09:45 +0530
MIME-Version: 1.0
In-Reply-To: <20180730093027.GC26245@infradead.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <52dcdcf5-971f-a53d-6cee-603668033596@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2018 03:00 PM, Christoph Hellwig wrote:
>>> +
>>> +	if (xen_domain())
>>> +		goto skip_override;
>>> +
>>> +	if (virtio_has_iommu_quirk(dev))
>>> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
>>> +
>>> + skip_override:
>>> +
>>
>> I prefer normal if scoping as opposed to goto spaghetti pls.
>> Better yet move vring_use_dma_api here and use it.
>> Less of a chance something will break.
> 
> I agree about avoid pointless gotos here, but we can do things
> perfectly well without either gotos or a confusing helper here
> if we structure it right. E.g.:
> 
> 	// suitably detailed comment here
> 	if (!xen_domain() &&
> 	    !virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
> 		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);

I had updated this patch calling vring_use_dma_api() as a helper
as suggested by Michael but yes we can have the above condition
with a comment block. I will change this patch accordingly.

> 
> and while we're at it - modifying dma ops for the parent looks very
> dangerous.  I don't think we can do that, as it could break iommu
> setup interactions.  IFF we set a specific dma map ops it has to be
> on the virtio device itself, of which we have full control.

I understand your concern. At present virtio core calls parent's DMA
ops callbacks when device has VIRTIO_F_IOMMU_PLATFORM flag set. Most
likely those DMA OPS are architecture specific ones which can really
configure IOMMU. Most probably all devices and their parents share
the same DMA ops callback. IIUC as long as the entire system has a
single DMA ops structure, it should be okay. But I may be missing
other implications. I tried changing virtio core so that it always
calls device's DMA ops instead of it's parent DMA ops, it hit the
following WARN_ON for devices without IOMMU flag and hit both the
WARN_ON and BUG_ON for devices with the IOMMU flag.

static inline void *dma_alloc_attrs(struct device *dev, size_t size,
                                       dma_addr_t *dma_handle, gfp_t flag,
                                       unsigned long attrs)
{
        const struct dma_map_ops *ops = get_dma_ops(dev);
        void *cpu_addr;

        BUG_ON(!ops);
        WARN_ON_ONCE(dev && !dev->coherent_dma_mask);

--------

Seems like virtio device's DMA ops and coherent_dma_mask was never
set correctly assuming that virtio core always called parent's DMA
OPS all the time. We may have to change virtio device init to fix
this. Any thoughts ?
