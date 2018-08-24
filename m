Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xQy30BGPzDqnF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 13:00:26 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7O2wrd8085066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 23:00:25 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m28mfa0jk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 23:00:24 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 23 Aug 2018 23:00:23 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Anshuman Khandual <anshuman.linux@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Anderson <andmike@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 06/11] powerpc/svm: Use SWIOTLB DMA API for all virtio
 devices
Date: Thu, 23 Aug 2018 23:59:28 -0300
In-Reply-To: <20180824025933.24319-1-bauerman@linux.ibm.com>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
Message-Id: <20180824025933.24319-7-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Secure guest memory (GPA range) is isolated and inaccessible from the host.
But virtio ring transactions require the back end drivers to process
incoming scatter gather buffers which require their access in host. Hence a
portion of guest memory can be converted to shared memory and all buffers
need to be bounced into the pool before being passed on to the host.

SWIOTLB buffers can be pre-allocated and converted as shared memory during
early boot. Generic SWIOTLB DMA API (swiotlb_dma_ops) callbacks can be used
to bounce each incoming scatter gather I/O buffer addresses into this pool
of shared memory before being passed on to the host. All virtio devices on
secure guest platform need to use generic SWIOTLB DMA API. Utilize the new
virtio core platform hook platform_override_dma_ops() to achieve this.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 5773bc7eb4bd..56b894d65dba 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -39,6 +39,7 @@
 #include <linux/iommu.h>
 #include <linux/rculist.h>
 #include <linux/virtio.h>
+#include <linux/virtio_config.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -51,6 +52,7 @@
 #include <asm/udbg.h>
 #include <asm/mmzone.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/svm.h>
 
 #include "pseries.h"
 
@@ -1400,5 +1402,7 @@ machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
 
 void platform_override_dma_ops(struct virtio_device *vdev)
 {
-	/* Override vdev->parent.dma_ops if required */
+	if (is_svm_platform() &&
+			!virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
+		set_dma_ops(vdev->dev.parent, &swiotlb_dma_ops);
 }
