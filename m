Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WxxF42HxzDqGH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 14:00:17 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6K3wt1b121120
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 00:00:15 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kb6t0tjc1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 00:00:14 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 20 Jul 2018 05:00:12 +0100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, mst@redhat.com,
 hch@infradead.org, khandual@linux.vnet.ibm.com, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: [RFC 4/4] virtio: Add platform specific DMA API translation for
 virito devices
Date: Fri, 20 Jul 2018 09:29:41 +0530
In-Reply-To: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
Message-Id: <20180720035941.6844-5-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a hook which a platform can define in order to allow it to
override virtio device's DMA OPS irrespective of whether it has the
flag VIRTIO_F_IOMMU_PLATFORM set or not. We want to use this to do
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
 arch/powerpc/include/asm/dma-mapping.h | 6 ++++++
 arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
 drivers/virtio/virtio.c                | 7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 8fa3945..bc5a9d3 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -116,3 +116,9 @@ extern u64 __dma_get_required_mask(struct device *dev);
 
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
+
+#define platform_override_dma_ops platform_override_dma_ops
+
+struct virtio_device;
+
+extern void platform_override_dma_ops(struct virtio_device *vdev);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 06f0296..5773bc7 100644
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
@@ -1396,3 +1397,8 @@ static int __init disable_multitce(char *str)
 __setup("multitce=", disable_multitce);
 
 machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
+
+void platform_override_dma_ops(struct virtio_device *vdev)
+{
+	/* Override vdev->parent.dma_ops if required */
+}
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 6b13987..432c332 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -168,6 +168,12 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
 
 const struct dma_map_ops virtio_direct_dma_ops;
 
+#ifndef platform_override_dma_ops
+static inline void platform_override_dma_ops(struct virtio_device *vdev)
+{
+}
+#endif
+
 int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
@@ -179,6 +185,7 @@ int virtio_finalize_features(struct virtio_device *dev)
 	if (virtio_has_iommu_quirk(dev))
 		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
 
+	platform_override_dma_ops(dev);
 	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
 		return 0;
 
-- 
2.9.3
