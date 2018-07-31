Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fjRx4rJqzF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 14:01:49 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6V3xpXa125061
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 00:01:46 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kjg6hgb6d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 00:01:46 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 31 Jul 2018 05:01:44 +0100
Subject: Re: [RFC 1/4] virtio: Define virtio_direct_dma_ops structure
To: Christoph Hellwig <hch@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-2-khandual@linux.vnet.ibm.com>
 <20180730092419.GA26245@infradead.org>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, mst@redhat.com,
 linuxram@us.ibm.com, haren@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 31 Jul 2018 09:31:33 +0530
MIME-Version: 1.0
In-Reply-To: <20180730092419.GA26245@infradead.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <fd5738a9-163c-f1ab-c646-12b6367eeded@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2018 02:54 PM, Christoph Hellwig wrote:
>> +/*
>> + * Virtio direct mapping DMA API operations structure
>> + *
>> + * This defines DMA API structure for all virtio devices which would not
>> + * either bring in their own DMA OPS from architecture or they would not
>> + * like to use architecture specific IOMMU based DMA OPS because QEMU
>> + * expects GPA instead of an IOVA in absence of VIRTIO_F_IOMMU_PLATFORM.
>> + */
>> +dma_addr_t virtio_direct_map_page(struct device *dev, struct page *page,
>> +			    unsigned long offset, size_t size,
>> +			    enum dma_data_direction dir,
>> +			    unsigned long attrs)
> 
> All these functions should probably be marked static.

Sure.

> 
>> +void virtio_direct_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>> +			size_t size, enum dma_data_direction dir,
>> +			unsigned long attrs)
>> +{
>> +}
> 
> No need to implement no-op callbacks in struct dma_map_ops.

Okay.

> 
>> +
>> +int virtio_direct_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
>> +{
>> +	return 0;
>> +}
> 
> Including this one.
> 
>> +void *virtio_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>> +		gfp_t gfp, unsigned long attrs)
>> +{
>> +	void *queue = alloc_pages_exact(PAGE_ALIGN(size), gfp);
>> +
>> +	if (queue) {
>> +		phys_addr_t phys_addr = virt_to_phys(queue);
>> +		*dma_handle = (dma_addr_t)phys_addr;
>> +
>> +		if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
>> +			free_pages_exact(queue, PAGE_ALIGN(size));
>> +			return NULL;
>> +		}
>> +	}
>> +	return queue;
> 
> queue is a very odd name in a generic memory allocator.

Will change it to addr.

> 
>> +void virtio_direct_free(struct device *dev, size_t size, void *vaddr,
>> +		dma_addr_t dma_addr, unsigned long attrs)
>> +{
>> +	free_pages_exact(vaddr, PAGE_ALIGN(size));
>> +}
>> +
>> +const struct dma_map_ops virtio_direct_dma_ops = {
>> +	.alloc			= virtio_direct_alloc,
>> +	.free			= virtio_direct_free,
>> +	.map_page		= virtio_direct_map_page,
>> +	.unmap_page		= virtio_direct_unmap_page,
>> +	.mapping_error		= virtio_direct_mapping_error,
>> +};
> 
> This is missing a dma_map_sg implementation.  In general this is
> mandatory for dma_ops.  So either you implement it or explain in
> a common why you think you can skip it.

Hmm. IIUC virtio core never used dma_map_sg(). Am I missing something
here ? The only reference to dma_map_sg() is inside a comment.

$git grep dma_map_sg drivers/virtio/
drivers/virtio/virtio_ring.c:    * We can't use dma_map_sg, because we don't use scatterlists in

> 
>> +EXPORT_SYMBOL(virtio_direct_dma_ops);
> 
> EXPORT_SYMBOL_GPL like all virtio symbols, please.

I am planning to drop EXPORT_SYMBOL from virtio_direct_dma_ops structure.
