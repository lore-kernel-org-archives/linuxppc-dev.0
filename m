Return-Path: <nacc@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63D5AB717D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 04:27:38 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9IHEWxo007113
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:14:32 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9IHRFEC158524
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:27:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9IHRErG007766
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:27:15 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 2/7] ppc/vio: use dma ops helpers
Date: Mon, 18 Oct 2010 10:26:59 -0700
Message-Id: <1287422825-14999-3-git-send-email-nacc@us.ibm.com>
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
1.7.1
