Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Wxwx4GR3zDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 14:00:01 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6K3xRsE118343
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 23:59:59 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kb17xwnpa-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 23:59:59 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 20 Jul 2018 04:59:56 +0100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, mst@redhat.com,
 hch@infradead.org, khandual@linux.vnet.ibm.com, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: [RFC 1/4] virtio: Define virtio_direct_dma_ops structure
Date: Fri, 20 Jul 2018 09:29:38 +0530
In-Reply-To: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
Message-Id: <20180720035941.6844-2-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current implementation of DMA API inside virtio core calls device's DMA OPS
callback functions when the flag VIRTIO_F_IOMMU_PLATFORM flag is set. But
in absence of the flag, virtio core falls back calling basic transformation
of the incoming SG addresses as GPA. Going forward virtio should only call
DMA API based transformations generating either GPA or IOVA depending on
QEMU expectations again based on VIRTIO_F_IOMMU_PLATFORM flag. It requires
removing existing fallback code path for GPA transformation and replacing
that with a direct map DMA OPS structure. This adds that direct mapping DMA
OPS structure to be used in later patches which will make virtio core call
DMA API all the time for all virtio devices.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 drivers/virtio/virtio.c            | 60 ++++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h |  3 ++
 2 files changed, 63 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 59e36ef..7907ad3 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -3,6 +3,7 @@
 #include <linux/virtio_config.h>
 #include <linux/module.h>
 #include <linux/idr.h>
+#include <linux/dma-mapping.h>
 #include <uapi/linux/virtio_ids.h>
 
 /* Unique numbering for virtio devices. */
@@ -442,3 +443,62 @@ core_initcall(virtio_init);
 module_exit(virtio_exit);
 
 MODULE_LICENSE("GPL");
+
+/*
+ * Virtio direct mapping DMA API operations structure
+ *
+ * This defines DMA API structure for all virtio devices which would not
+ * either bring in their own DMA OPS from architecture or they would not
+ * like to use architecture specific IOMMU based DMA OPS because QEMU
+ * expects GPA instead of an IOVA in absence of VIRTIO_F_IOMMU_PLATFORM.
+ */
+dma_addr_t virtio_direct_map_page(struct device *dev, struct page *page,
+			    unsigned long offset, size_t size,
+			    enum dma_data_direction dir,
+			    unsigned long attrs)
+{
+	return page_to_phys(page) + offset;
+}
+
+void virtio_direct_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs)
+{
+}
+
+int virtio_direct_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
+{
+	return 0;
+}
+
+void *virtio_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
+{
+	void *queue = alloc_pages_exact(PAGE_ALIGN(size), gfp);
+
+	if (queue) {
+		phys_addr_t phys_addr = virt_to_phys(queue);
+		*dma_handle = (dma_addr_t)phys_addr;
+
+		if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
+			free_pages_exact(queue, PAGE_ALIGN(size));
+			return NULL;
+		}
+	}
+	return queue;
+}
+
+void virtio_direct_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_addr, unsigned long attrs)
+{
+	free_pages_exact(vaddr, PAGE_ALIGN(size));
+}
+
+const struct dma_map_ops virtio_direct_dma_ops = {
+	.alloc			= virtio_direct_alloc,
+	.free			= virtio_direct_free,
+	.map_page		= virtio_direct_map_page,
+	.unmap_page		= virtio_direct_unmap_page,
+	.mapping_error		= virtio_direct_mapping_error,
+};
+EXPORT_SYMBOL(virtio_direct_dma_ops);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 135ee3c..ec44d2f 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -31,6 +31,9 @@
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 
+extern struct dma_map_ops virtio_direct_dma_ops;
+
+
 struct virtio_pci_vq_info {
 	/* the actual virtqueue */
 	struct virtqueue *vq;
-- 
2.9.3
