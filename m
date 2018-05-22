Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qm7L5BGXzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 16:33:31 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4M6T6mR120604
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 02:33:29 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j48mut8nv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 02:33:28 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 22 May 2018 07:33:26 +0100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, mst@redhat.com,
 hch@infradead.org
Subject: [RFC V2] virtio: Add platform specific DMA API translation for virito
 devices
Date: Tue, 22 May 2018 12:03:17 +0530
Message-Id: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a hook which a platform can define in order to allow it to
force the use of the DMA API for all virtio devices even if they don't
have the VIRTIO_F_IOMMU_PLATFORM flag set.  We want to use this to do
bounce-buffering of data on the new secure pSeries platform, currently
under development, where a KVM host cannot access all of the memory
space of a secure KVM guest.  The host can only access the pages which
the guest has explicitly requested to be shared with the host, thus
the virtio implementation in the guest has to copy data to and from
shared pages.

With this hook, the platform code in the secure guest can force the
use of swiotlb for virtio buffers, with a back-end for swiotlb which
will use a pool of pre-allocated shared pages.  Thus all data being
sent or received by virtio devices will be copied through pages which
the host has access to.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V2:

The arch callback has been enabled through an weak symbol defintion
so that it is enabled only for those architectures subscribing to
this new framework. Clarified the patch description. The primary
objective for this RFC has been to get an in principle agreement
on this approach.

Original V1:

Original RFC and discussions https://patchwork.kernel.org/patch/10324405/

 arch/powerpc/include/asm/dma-mapping.h |  6 ++++++
 arch/powerpc/platforms/pseries/iommu.c | 11 +++++++++++
 drivers/virtio/virtio_ring.c           | 10 ++++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 8fa3945..056e578 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -115,4 +115,10 @@ extern u64 __dma_get_required_mask(struct device *dev);
 #define ARCH_HAS_DMA_MMAP_COHERENT
 
 #endif /* __KERNEL__ */
+
+#define platform_forces_virtio_dma platform_forces_virtio_dma
+
+struct virtio_device;
+
+extern bool platform_forces_virtio_dma(struct virtio_device *vdev);
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 06f0296..a2ec15a 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -38,6 +38,7 @@
 #include <linux/of.h>
 #include <linux/iommu.h>
 #include <linux/rculist.h>
+#include <linux/virtio.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -1396,3 +1397,13 @@ static int __init disable_multitce(char *str)
 __setup("multitce=", disable_multitce);
 
 machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
+
+bool platform_forces_virtio_dma(struct virtio_device *vdev)
+{
+	/*
+	 * On protected guest platforms, force virtio core to use DMA
+	 * MAP API for all virtio devices. But there can also be some
+	 * exceptions for individual devices like virtio balloon.
+	 */
+	return (of_find_compatible_node(NULL, NULL, "ibm,ultravisor") != NULL);
+}
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 21d464a..47ea6c3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -141,8 +141,18 @@ struct vring_virtqueue {
  * unconditionally on data path.
  */
 
+#ifndef platform_forces_virtio_dma
+static inline bool platform_forces_virtio_dma(struct virtio_device *vdev)
+{
+	return false;
+}
+#endif
+
 static bool vring_use_dma_api(struct virtio_device *vdev)
 {
+	if (platform_forces_virtio_dma(vdev))
+		return true;
+
 	if (!virtio_has_iommu_quirk(vdev))
 		return true;
 
-- 
2.9.3
