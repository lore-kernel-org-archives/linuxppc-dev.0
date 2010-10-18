Return-Path: <nacc@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 277C3B71A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 04:27:38 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9IHP9De004655
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:25:09 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9IHRHOB212526
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:27:17 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9IHRHAF007401
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:27:17 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 7/7] ppc64 iommu: use coherent_dma_mask for alloc_coherent
Date: Mon, 18 Oct 2010 10:27:04 -0700
Message-Id: <1287422825-14999-8-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1287422825-14999-1-git-send-email-nacc@us.ibm.com>
References: <1287422825-14999-1-git-send-email-nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, miltonm@bga.com,
	Paul Mackerras <paulus@samba.org>, Brian King <brking@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IOMMU code has been passing the dma-mask instead of the
coherent_dma_mask to the iommu allocator.  Coherent allocations should
be made using the coherent_dma_mask.

Also update the vio code to ensure the coherent_dma_mask is set. Without
this change drivers, such as ibmvscsi, fail to load with the corrected
dma_iommu_alloc_coherent().

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
We currently don't check the mask other than to warn when its being set,
so I don't think this is stable material.
---
 arch/powerpc/kernel/dma-iommu.c |    2 +-
 arch/powerpc/kernel/vio.c       |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 6e54a0f..e755415 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -19,7 +19,7 @@ static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
 				      dma_addr_t *dma_handle, gfp_t flag)
 {
 	return iommu_alloc_coherent(dev, get_iommu_table_base(dev), size,
-				    dma_handle, device_to_mask(dev), flag,
+				    dma_handle, dev->coherent_dma_mask, flag,
 				    dev_to_node(dev));
 }
 
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 3c3083f..f15b3df 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1259,6 +1259,10 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	viodev->dev.parent = &vio_bus_device.dev;
 	viodev->dev.bus = &vio_bus_type;
 	viodev->dev.release = vio_dev_release;
+        /* needed to ensure proper operation of coherent allocations
+         * later, in case driver doesn't set it explicitly */
+        dma_set_mask(&viodev->dev, DMA_BIT_MASK(64));
+        dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));
 
 	/* register with generic device framework */
 	if (device_register(&viodev->dev)) {
-- 
1.7.1
