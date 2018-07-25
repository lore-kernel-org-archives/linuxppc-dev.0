Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 41b9TT1zX5zDrHN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 19:50:53 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel RFC 3/3] powerpc/pseries/iommu: Use memory@ nodes in
 max RAM address calculation
Date: Wed, 25 Jul 2018 19:50:32 +1000
Message-Id: <20180725095032.2196-4-aik@ozlabs.ru>
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

We might have memory@ nodes with "linux,usable-memory" set to zero
(for example, to replicate powernv's behaviour for GPU coherent memory)
which means that the memory needs an extra initialization but since
it can be used afterwards, the pseries platform will try mapping it
for DMA so the DMA window needs to cover those memory regions too.

This walks through the memory nodes to find the highest RAM address to
let a huge DMA window cover that too in case this memory gets onlined
later.

The existing memory_hotplug_max() does not do the job as it calls:

1. memblock_end_of_DRAM() which looks at memory blocks and
GPU RAM is not there because of size==0 in linux,usable-memory
property of the memory node;

2. hot_add_drconf_memory_max() does not support sparse memory
if we want to map this memory in the guest where it is mapped
on the host (and it looks like we have to), the drconf chunk
is easily getting bigger that a megabyte.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 43 +++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 840afe5..74404f8 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -967,6 +967,47 @@ struct failed_ddw_pdn {
 
 static LIST_HEAD(failed_ddw_pdn_list);
 
+static unsigned long read_n_cells(int n, const __be32 **buf)
+{
+	unsigned long result = 0;
+
+	while (n--) {
+		result = (result << 32) | of_read_number(*buf, 1);
+		(*buf)++;
+	}
+	return result;
+}
+
+static phys_addr_t ddw_memory_hotplug_max(void)
+{
+	phys_addr_t max_addr = memory_hotplug_max();
+	struct device_node *memory;
+
+	for_each_node_by_type(memory, "memory") {
+		unsigned long start, size;
+		int ranges, n_mem_addr_cells, n_mem_size_cells, len;
+		const __be32 *memcell_buf;
+
+		memcell_buf = of_get_property(memory, "reg", &len);
+		if (!memcell_buf || len <= 0)
+			continue;
+
+		n_mem_addr_cells = of_n_addr_cells(memory);
+		n_mem_size_cells = of_n_size_cells(memory);
+
+		/* ranges in cell */
+		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
+
+		/* these are order-sensitive, and modify the buffer pointer */
+		start = read_n_cells(n_mem_addr_cells, &memcell_buf);
+		size = read_n_cells(n_mem_size_cells, &memcell_buf);
+
+		max_addr = max_t(phys_addr_t, max_addr, start + size);
+	}
+
+	return max_addr;
+}
+
 /*
  * If the PE supports dynamic dma windows, and there is space for a table
  * that can map all pages in a linear offset, then setup such a table,
@@ -1067,7 +1108,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn,
 	}
 	/* verify the window * number of ptes will map the partition */
 	/* check largest block * page size > max memory hotplug addr */
-	max_addr = memory_hotplug_max();
+	max_addr = ddw_memory_hotplug_max();
 	if (query.largest_available_block < (max_addr >> page_shift)) {
 		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %u "
 			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
-- 
2.11.0
