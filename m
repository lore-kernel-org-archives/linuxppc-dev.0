Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3w3Wyh21YxzDqFy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 17:05:32 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel] powerpc/powernv: Fix iommu table size calculation hook
 for small tables
Date: Thu, 13 Apr 2017 17:05:27 +1000
Message-Id: <20170413070527.16989-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the userspace requests a small TCE table (which takes less than
the system page size) and more than 1 TCE level, the existing code
returns a single page size which is a bug as each additional TCE level
requires at least one page and this is what
pnv_pci_ioda2_table_alloc_pages() does. And we end up seeing
WARN_ON(!ret && ((*ptbl)->it_allocated_size != table_size))
in drivers/vfio/vfio_iommu_spapr_tce.c.

This replaces incorrect _ALIGN_UP() (which aligns zero up to zero) with
max_t() to fix the bug.

Besides removing WARN_ON(), there should be no other changes in
behaviour.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6d0da5dfc955..a0d046adcf45 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2538,7 +2538,8 @@ static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
 
 		tce_table_size /= direct_table_size;
 		tce_table_size <<= 3;
-		tce_table_size = _ALIGN_UP(tce_table_size, direct_table_size);
+		tce_table_size = max_t(unsigned long,
+				tce_table_size, direct_table_size);
 	}
 
 	return bytes;
-- 
2.11.0
