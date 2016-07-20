Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rvP5Y6X2CzDqQN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 14:27:29 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, stable@vger.kernel.org,
 #@ozlabs.ru, 4.2+@ozlabs.ru
Subject: [PATCH kernel] powerpc/powernv/ioda: Fix endianness when reading TCEs
Date: Wed, 20 Jul 2016 14:26:51 +1000
Message-Id: <1468988811-49142-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The iommu_table_ops::exchange() callback writes new TCE to the table
and returns old value and permission mask. The old TCE value is
correctly converted from BE to CPU endian; however permission mask
was calculated from BE value and therefore always returned DMA_NONE
which could cause memory leak on LE systems using VFIO SPAPR TCE IOMMU v1
driver.

This fixes pnv_tce_xchg() to have @oldtce a CPU endian.

Fixes: 05c6cfb9dce0d13d37e9d007ee6a4af36f1c0a58
Cc: stable@vger.kernel.org # 4.2+
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 1d92bd9..7b17f88 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -620,8 +620,8 @@ int pnv_tce_xchg(struct iommu_table *tbl, long index,
 	if (newtce & TCE_PCI_WRITE)
 		newtce |= TCE_PCI_READ;
 
-	oldtce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
-	*hpa = be64_to_cpu(oldtce) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+	oldtce = be64_to_cpu(xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce)));
+	*hpa = oldtce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
 	*direction = iommu_tce_direction(oldtce);
 
 	return 0;
-- 
2.5.0.rc3
