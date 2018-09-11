Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 428YcJ0kPSzF37J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 15:38:40 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH kernel] powerpc/powernv/ioda2: Reduce upper limit for DMA
 window size (retry)
Date: Tue, 11 Sep 2018 15:38:05 +1000
Message-Id: <20180911053805.5345-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use PHB in mode1 which uses bit 59 to select a correct DMA window.
However there is mode2 which uses bits 59:55 and allows up to 32 DMA
windows per a PE.

Even though documentation does not clearly specify that, it seems that
the actual hardware does not support bits 59:55 even in mode1, in other
words we can create a window as big as 1<<58 but DMA simply won't work.

This reduces the upper limit from 59 to 55 bits to let the userspace know
about the hardware limits.

Fixes: ce57c6610cc2 "Merge branch 'topic/ppc-kvm' into next"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

The merge commit says  d3d4ffaae439 (the original of this one) was
propagated but it was not:

[vpl1 kernel]$ git s ce57c6610cc2:arch/powerpc/platforms/powernv/pci-ioda-tce.c | grep 'page_shift >= '
        if ((level_shift - 3) * levels + page_shift >= 60)

---
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index 6c5db1a..fe96910 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -276,7 +276,7 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	level_shift = entries_shift + 3;
 	level_shift = max_t(unsigned int, level_shift, PAGE_SHIFT);
 
-	if ((level_shift - 3) * levels + page_shift >= 60)
+	if ((level_shift - 3) * levels + page_shift >= 55)
 		return -EINVAL;
 
 	/* Allocate TCE table */
-- 
2.11.0
