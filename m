Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yQyR61ldgzDqwZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 15:04:33 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel] powerpc/powernv/ioda: Relax max DMA window size check
Date: Tue, 31 Oct 2017 15:04:27 +1100
Message-Id: <20171031040427.10909-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DMA windows can only have a size of power of two on IODA2 hardware and
using memory_hotplug_max() to determine the upper limit won't work
correcly if it returns not power of two value.

This relaxes the check by rounding up the value returned by
memory_hotplug_max().

It is expected to impact DPDK on machines with non-power-of-two RAM size,
mostly. KVM guests are less likely to be affected as usually guests get
less than half of hosts RAM.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 269f119e4b3c..4c62162da181 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2769,7 +2769,8 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
 		return -EINVAL;
 
-	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
+	if ((window_size > roundup_pow_of_two(memory_hotplug_max())) ||
+			!is_power_of_2(window_size))
 		return -EINVAL;
 
 	/* Adjust direct table size from window_size and levels */
-- 
2.11.0
