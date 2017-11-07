Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yWFdl36WBzDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 14:43:39 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Russell Currey <ruscur@russell.cc>, Jonas Pfefferle1 <JPF@zurich.ibm.com>
Subject: [PATCH kernel v2] powerpc/powernv/ioda: Remove explicit max window
 size check
Date: Tue,  7 Nov 2017 14:43:01 +1100
Message-Id: <20171107034301.35120-1-aik@ozlabs.ru>
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

This removes the check as the platform code does this check in
pnv_pci_ioda2_setup_default_config() anyway; the other client is VFIO
and that thing checks against locked_vm limit which prevents the userspace
from locking too much memory.

It is expected to impact DPDK on machines with non-power-of-two RAM size,
mostly. KVM guests are less likely to be affected as usually guests get
less than half of hosts RAM.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* instead of relaxing the check, this simply removes it
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1de94fb..433cf84 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2776,7 +2776,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
 		return -EINVAL;
 
-	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
+	if (!is_power_of_2(window_size))
 		return -EINVAL;
 
 	/* Adjust direct table size from window_size and levels */
-- 
2.11.0
