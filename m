Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Wxx43MdpzDqCF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 14:00:08 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6K3x12C142841
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 00:00:06 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kb1h24qv4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 00:00:05 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 20 Jul 2018 05:00:03 +0100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
 joe@perches.com, elfring@users.sourceforge.net,
 david@gibson.dropbear.id.au, jasowang@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, mst@redhat.com,
 hch@infradead.org, khandual@linux.vnet.ibm.com, linuxram@us.ibm.com,
 haren@linux.vnet.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
Date: Fri, 20 Jul 2018 09:29:39 +0530
In-Reply-To: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
Message-Id: <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that virtio core always needs all virtio devices to have DMA OPS, we
need to make sure that the structure it points is the right one. In the
absence of VIRTIO_F_IOMMU_PLATFORM flag QEMU expects GPA from guest kernel.
In such case, virtio device must use default virtio_direct_dma_ops DMA OPS
structure which transforms scatter gather buffer addresses as GPA. This
DMA OPS override must happen as early as possible during virtio device
initializatin sequence before virtio core starts using given device's DMA
OPS callbacks for I/O transactions. This change detects device's IOMMU flag
and does the override in case the flag is cleared.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 drivers/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 7907ad3..6b13987 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -166,6 +166,8 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
+const struct dma_map_ops virtio_direct_dma_ops;
+
 int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
@@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
 	if (ret)
 		return ret;
 
+	if (virtio_has_iommu_quirk(dev))
+		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
+
 	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
 		return 0;
 
-- 
2.9.3
