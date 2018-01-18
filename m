Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zMT4W6c8CzF0kG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 13:51:39 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Russell Currey <ruscur@russell.cc>, Jonas Pfefferle1 <JPF@zurich.ibm.com>
Subject: [PATCH kernel] powerpc/powernv/ioda: Finish removing explicit max
 window size check
Date: Thu, 18 Jan 2018 13:51:03 +1100
Message-Id: <20180118025103.9684-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

9003a2498 removed checn from the DMA window pages allocator, however
the VFIO driver tests limits before doing so by calling
the get_table_size hook which was left behind; this fixes it.

Fixes: 9003a2498 "powerpc/powernv/ioda: Remove explicit max window size check"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

It is properly tested now. Only affected folks for now are DPDK guys
with machines with non-power-of-two physical RAM amount.
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b9146d5..1069f9c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2572,7 +2572,6 @@ static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
 	unsigned long direct_table_size;
 
 	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS) ||
-			(window_size > memory_hotplug_max()) ||
 			!is_power_of_2(window_size))
 		return 0;
 
-- 
2.11.0
