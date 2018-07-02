Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 41Jzjb0HrpzF1LQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 17:42:11 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Russell Currey <ruscur@russell.cc>,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel] powerpc/powernv/ioda2: Add 256M IOMMU page size to the
 default POWER8 case
Date: Mon,  2 Jul 2018 17:42:05 +1000
Message-Id: <20180702074205.12837-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The sketchy bypass uses 256M pages so add this page size as well.

This should cause no behavioral change but will be used later.

Fixes: 477afd6ea6 "powerpc/ioda: Use ibm,supported-tce-sizes for IOMMU page size mask"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5bd0eb6..557c11d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2925,7 +2925,7 @@ static unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
 		/* Add 16M for POWER8 by default */
 		if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
 				!cpu_has_feature(CPU_FTR_ARCH_300))
-			mask |= SZ_16M;
+			mask |= SZ_16M | SZ_256M;
 		return mask;
 	}
 
-- 
2.11.0
