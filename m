Return-Path: <nacc@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DCCC1B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:06:42 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FHpoiL010408
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 13:51:50 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FI6bqs131716
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:06:37 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8FI6Z87009812
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:06:37 -0400
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 09/15] ppc/vio: use dma ops helpers
Date: Wed, 15 Sep 2010 11:05:52 -0700
Message-Id: <1284573958-8397-10-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
Cc: Milton Miller <miltonm@bga.com>, Paul Mackerras <paulus@samba.org>,
	Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the set_dma_ops helper. Instead of modifying vio_dma_mapping_ops,
just create a trivial wrapper for dma_supported.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/kernel/vio.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index d692989..3c3083f 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -602,6 +602,11 @@ static void vio_dma_iommu_unmap_sg(struct device *dev,
 	vio_cmo_dealloc(viodev, alloc_size);
 }
 
+static int vio_dma_iommu_dma_supported(struct device *dev, u64 mask)
+{
+        return dma_iommu_ops.dma_supported(dev, mask);
+}
+
 struct dma_map_ops vio_dma_mapping_ops = {
 	.alloc_coherent = vio_dma_iommu_alloc_coherent,
 	.free_coherent  = vio_dma_iommu_free_coherent,
@@ -609,6 +614,7 @@ struct dma_map_ops vio_dma_mapping_ops = {
 	.unmap_sg       = vio_dma_iommu_unmap_sg,
 	.map_page       = vio_dma_iommu_map_page,
 	.unmap_page     = vio_dma_iommu_unmap_page,
+	.dma_supported  = vio_dma_iommu_dma_supported,
 
 };
 
@@ -860,8 +866,7 @@ static void vio_cmo_bus_remove(struct vio_dev *viodev)
 
 static void vio_cmo_set_dma_ops(struct vio_dev *viodev)
 {
-	vio_dma_mapping_ops.dma_supported = dma_iommu_ops.dma_supported;
-	viodev->dev.archdata.dma_ops = &vio_dma_mapping_ops;
+	set_dma_ops(&viodev->dev, &vio_dma_mapping_ops);
 }
 
 /**
@@ -1246,7 +1251,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	if (firmware_has_feature(FW_FEATURE_CMO))
 		vio_cmo_set_dma_ops(viodev);
 	else
-		viodev->dev.archdata.dma_ops = &dma_iommu_ops;
+		set_dma_ops(&viodev->dev, &dma_iommu_ops);
 	set_iommu_table_base(&viodev->dev, vio_build_iommu_table(viodev));
 	set_dev_node(&viodev->dev, of_node_to_nid(of_node));
 
-- 
1.7.0.4
