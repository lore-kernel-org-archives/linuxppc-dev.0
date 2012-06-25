Return-Path: <anton@samba.org>
Date: Mon, 25 Jun 2012 14:23:53 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 miltonm@bga.com, nacc@us.ibm.com, brking@linux.vnet.ibm.com,
 rcj@linux.vnet.ibm.com
Subject: [PATCH 1/4] powerpc: vio: Remove dma not supported warnings
Message-ID: <20120625142353.0a92791a@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


During boot we see a number of these warnings:

vio 30000000: Warning: IOMMU dma not supported: mask 0xffffffffffffffff, table unavailable

The reason for this is that we set IOMMU properties for all VIO
devices even if they are not DMA capable.

Only set DMA ops, table and mask for devices with a DMA window.

Signed-off-by: Anton Blanchard <anton@samba.org>  
---

Index: linux-build/arch/powerpc/kernel/vio.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/vio.c	2012-06-08 14:02:05.548512941 +1000
+++ linux-build/arch/powerpc/kernel/vio.c	2012-06-25 13:49:54.349806390 +1000
@@ -1397,21 +1397,27 @@ struct vio_dev *vio_register_device_node
 	viodev->name = of_node->name;
 	viodev->dev.of_node = of_node_get(of_node);
 
-	if (firmware_has_feature(FW_FEATURE_CMO))
-		vio_cmo_set_dma_ops(viodev);
-	else
-		set_dma_ops(&viodev->dev, &dma_iommu_ops);
-	set_iommu_table_base(&viodev->dev, vio_build_iommu_table(viodev));
 	set_dev_node(&viodev->dev, of_node_to_nid(of_node));
 
 	/* init generic 'struct device' fields: */
 	viodev->dev.parent = &vio_bus_device.dev;
 	viodev->dev.bus = &vio_bus_type;
 	viodev->dev.release = vio_dev_release;
-        /* needed to ensure proper operation of coherent allocations
-         * later, in case driver doesn't set it explicitly */
-        dma_set_mask(&viodev->dev, DMA_BIT_MASK(64));
-        dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));
+
+	if (of_get_property(viodev->dev.of_node, "ibm,my-dma-window", NULL)) {
+		if (firmware_has_feature(FW_FEATURE_CMO))
+			vio_cmo_set_dma_ops(viodev);
+		else
+			set_dma_ops(&viodev->dev, &dma_iommu_ops);
+
+		set_iommu_table_base(&viodev->dev,
+				     vio_build_iommu_table(viodev));
+
+		/* needed to ensure proper operation of coherent allocations
+		 * later, in case driver doesn't set it explicitly */
+		dma_set_mask(&viodev->dev, DMA_BIT_MASK(64));
+		dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));
+	}
 
 	/* register with generic device framework */
 	if (device_register(&viodev->dev)) {
