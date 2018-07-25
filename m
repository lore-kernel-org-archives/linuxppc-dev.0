Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 41b9TQ2k9RzDrHr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 19:50:50 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel RFC 2/3] powerpc/pseries/iommu: Force default DMA
 window removal
Date: Wed, 25 Jul 2018 19:50:31 +1000
Message-Id: <20180725095032.2196-3-aik@ozlabs.ru>
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

It is quite common for a device to support more than 32bit but less than
64bit for DMA, for example, GPUs often support 42..50bits. However
the pseries platform only allows huge DMA window (the one which allows
the use of more than 2GB of DMA space) for 64bit-capable devices mostly
because:

1. we may have 32bit and >32bit devices on the same IOMMU domain and
we cannot place the new big window where the 32bit one is located;

2. the existing hardware only supports the second window at very high
offset of 1<<59 == 0x0800.0000.0000.0000.

So in order to allow 33..59bit DMA, we have to remove the default DMA
window and place a huge one there instead.

The PAPR spec says that the platform may decide not to use the default
window and remove it using DDW RTAS calls. There are few possible ways
for the platform to decide:

1. look at the device IDs and decide in advance that such and such
devices are capable of more than 32bit DMA (powernv's sketchy bypass
does something like this - it drops the default window if all devices
on the PE are from the same vendor) - this is not great as involves
guessing because, unlike sketchy bypass, the GPU case involves 2 vendor
ids and does not scale;

2. advertise 1 available DMA window in the hypervisor via
ibm,query-pe-dma-window so the pseries platform could take it as a clue
that if more bits for DMA are needed, it has to remove the default
window - this is not great as it is implicit clue rather than direct
instruction;

3. removing the default DMA window at all it not really an option as
PAPR mandates its presense at the guest boot time;

4. make the hypervisor explicitly tell the guest that the default window
is better be removed so the guest does not have to think hard and can
simply do what requested and this is what this patch does.

This makes use of the latter approach and exploits a new
"qemu,dma-force-remove-default" flag in a vPHB.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9ece42f..840afe5 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -54,6 +54,7 @@
 #include "pseries.h"
 
 #define DDW_INVALID_OFFSET	((uint64_t)-1)
+#define DDW_INVALID_LIOBN	((uint32_t)-1)
 
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
@@ -977,7 +978,8 @@ static LIST_HEAD(failed_ddw_pdn_list);
  *
  * returns the dma offset for use by dma_set_mask
  */
-static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
+static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn,
+		u32 default_liobn)
 {
 	int len, ret;
 	struct ddw_query_response query;
@@ -1022,6 +1024,16 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	if (ret)
 		goto out_failed;
 
+	/*
+	 * The device tree has a request to force remove the default window,
+	 * do this.
+	 */
+	if (default_liobn != DDW_INVALID_LIOBN && (!ddw_avail[2] ||
+			rtas_call(ddw_avail[2], 1, 1, NULL, default_liobn))) {
+		dev_dbg(&dev->dev, "Could not remove window");
+		goto out_failed;
+	}
+
        /*
 	 * Query if there is a second window of size to map the
 	 * whole partition.  Query returns number of windows, largest
@@ -1212,7 +1224,7 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
 	pdev = to_pci_dev(dev);
 
 	/* only attempt to use a new window if 64-bit DMA is requested */
-	if (!disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
+	if (!disable_ddw && dma_mask > DMA_BIT_MASK(32)) {
 		dn = pci_device_to_OF_node(pdev);
 		dev_dbg(dev, "node is %pOF\n", dn);
 
@@ -1229,7 +1241,15 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
 				break;
 		}
 		if (pdn && PCI_DN(pdn)) {
-			dma_offset = enable_ddw(pdev, pdn);
+			u32 flag = 0, liobn = DDW_INVALID_LIOBN;
+			int ret = of_property_read_u32(pdn,
+					"qemu,dma-force-remove-default", &flag);
+
+			if (!ret && flag && dma_window &&
+					dma_mask != DMA_BIT_MASK(64))
+				liobn = be32_to_cpu(dma_window[0]);
+
+			dma_offset = enable_ddw(pdev, pdn, liobn);
 			if (dma_offset != DDW_INVALID_OFFSET) {
 				dev_info(dev, "Using 64-bit direct DMA at offset %llx\n", dma_offset);
 				set_dma_offset(dev, dma_offset);
-- 
2.11.0
