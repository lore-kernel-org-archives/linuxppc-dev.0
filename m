Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 41b9TP1NmnzDrHN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 19:50:47 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel RFC 1/3] powerpc/pseries/iommu: Allow dynamic window to
 start from zero
Date: Wed, 25 Jul 2018 19:50:30 +1000
Message-Id: <20180725095032.2196-2-aik@ozlabs.ru>
In-Reply-To: <20180725095032.2196-1-aik@ozlabs.ru>
References: <20180725095032.2196-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the kernel does not expect dynamic windows to ever start
at zero on a PCI bus as PAPR requires the hypervisor to create a 32bit
default window which starts from zero and the pseries kernel only
creates additional windows.

However PAPR permits removing the default window and creating another
one instead, starting from zero as well. In fact, the kernel used to
remove the default window after sha1 25ebc45b934 but this has been
reverted later.

Since there are devices capable of more than 32 bits for DMA but less than
50, and currently available hardware allows the second window only
at 1<<59, we will need to be able to create bigger windows starting from
zero. This does the initial preparation and should not cause any
behavioral changes.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 06f0296..9ece42f 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -53,6 +53,8 @@
 
 #include "pseries.h"
 
+#define DDW_INVALID_OFFSET	((uint64_t)-1)
+
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
 	struct iommu_table_group *table_group;
@@ -844,7 +846,7 @@ static u64 find_existing_ddw(struct device_node *pdn)
 {
 	struct direct_window *window;
 	const struct dynamic_dma_window_prop *direct64;
-	u64 dma_addr = 0;
+	u64 dma_addr = DDW_INVALID_OFFSET;
 
 	spin_lock(&direct_window_list_lock);
 	/* check if we already created a window and dupe that config if so */
@@ -992,7 +994,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	mutex_lock(&direct_window_init_mutex);
 
 	dma_addr = find_existing_ddw(pdn);
-	if (dma_addr != 0)
+	if (dma_addr != DDW_INVALID_OFFSET)
 		goto out_unlock;
 
 	/*
@@ -1228,7 +1230,7 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
 		}
 		if (pdn && PCI_DN(pdn)) {
 			dma_offset = enable_ddw(pdev, pdn);
-			if (dma_offset != 0) {
+			if (dma_offset != DDW_INVALID_OFFSET) {
 				dev_info(dev, "Using 64-bit direct DMA at offset %llx\n", dma_offset);
 				set_dma_offset(dev, dma_offset);
 				set_dma_ops(dev, &dma_nommu_ops);
-- 
2.11.0
