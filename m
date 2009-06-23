Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D9818B711D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 19:13:48 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C77DCDDDE1
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 19:13:48 +1000 (EST)
Subject: Swiotlb breaks pseries
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Tue, 23 Jun 2009 19:13:48 +1000
Message-Id: <1245748428.4550.411.camel@concordia>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Turning on SWIOTLB selects or enables PPC_NEED_DMA_SYNC_OPS, which means
we get the non empty versions of dma_sync_* in asm/dma-mapping.h

On my pseries machine the dma_ops have no such routines and we die with
a null pointer - this patch gets it booting, is there a more elegant way
to do it?

cheers

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 3d9e887..b44aaab 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -309,7 +309,9 @@ static inline void dma_sync_single_for_cpu(struct device *dev,
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
-	dma_ops->sync_single_range_for_cpu(dev, dma_handle, 0,
+
+	if (dma_ops->sync_single_range_for_cpu)
+		dma_ops->sync_single_range_for_cpu(dev, dma_handle, 0,
 					   size, direction);
 }
 
@@ -320,7 +322,9 @@ static inline void dma_sync_single_for_device(struct device *dev,
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
-	dma_ops->sync_single_range_for_device(dev, dma_handle,
+
+	if (dma_ops->sync_single_range_for_device)
+		dma_ops->sync_single_range_for_device(dev, dma_handle,
 					      0, size, direction);
 }
 
@@ -331,7 +335,9 @@ static inline void dma_sync_sg_for_cpu(struct device *dev,
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
-	dma_ops->sync_sg_for_cpu(dev, sgl, nents, direction);
+
+	if (dma_ops->sync_sg_for_cpu)
+		dma_ops->sync_sg_for_cpu(dev, sgl, nents, direction);
 }
 
 static inline void dma_sync_sg_for_device(struct device *dev,
@@ -341,7 +347,9 @@ static inline void dma_sync_sg_for_device(struct device *dev,
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
-	dma_ops->sync_sg_for_device(dev, sgl, nents, direction);
+
+	if (dma_ops->sync_sg_for_device)
+		dma_ops->sync_sg_for_device(dev, sgl, nents, direction);
 }
 
 static inline void dma_sync_single_range_for_cpu(struct device *dev,
@@ -351,7 +359,9 @@ static inline void dma_sync_single_range_for_cpu(struct device *dev,
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
-	dma_ops->sync_single_range_for_cpu(dev, dma_handle,
+
+	if (dma_ops->sync_single_range_for_cpu)
+		dma_ops->sync_single_range_for_cpu(dev, dma_handle,
 					   offset, size, direction);
 }
 
@@ -362,7 +372,9 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
-	dma_ops->sync_single_range_for_device(dev, dma_handle, offset,
+
+	if (dma_ops->sync_single_range_for_device)
+		dma_ops->sync_single_range_for_device(dev, dma_handle, offset,
 					      size, direction);
 }
 #else /* CONFIG_PPC_NEED_DMA_SYNC_OPS */
-- 
1.6.2.1
