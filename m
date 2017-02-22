Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vSlBY5y2qzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 15:44:05 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH kernel] powerpc/powernv/ioda2: Gracefully fail if too many TCE
 levels requested
Date: Wed, 22 Feb 2017 15:43:59 +1100
Message-Id: <20170222044359.3663-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IODA2 specification says that a 64 DMA address cannot use top 4 bits
(3 are reserved and one is a "TVE select"); bottom page_shift bits
cannot be used for multilevel table addressing either.

The existing IODA2 table allocation code aligns the minimum TCE table
size to PAGE_SIZE so in the case of 64K system pages and 4K IOMMU pages,
we have 64-4-12=48 bits. Since 64K page stores 8192 TCEs, i.e. needs
13 bits, the maximum number of levels is 48/13 = 3 so we physically
cannot address more and EEH happens on DMA accesses.

This adds a check that too many levels were requested.

It is still possible to have 5 levels in the case of 4K system page size.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

The alternative would be allocating TCE tables as big as PAGE_SIZE but
only using parts of it but this would complicate a bit bits of code
responsible for overall amount of memory used for TCE table.

Or kmem_cache_create() could be used to allocate as big TCE table levels
as we really need but that API does not seem to support NUMA nodes.

In the reality, even 3 levels give us way too much addressable memory.
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 24fa2de2a0af..1e92ec954321 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2631,6 +2631,9 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	level_shift = entries_shift + 3;
 	level_shift = max_t(unsigned, level_shift, PAGE_SHIFT);
 
+	if ((level_shift - 3) * levels + page_shift >= 60)
+		return -EINVAL;
+
 	/* Allocate TCE table */
 	addr = pnv_pci_ioda2_table_do_alloc_pages(nid, level_shift,
 			levels, tce_table_size, &offset, &total_allocated);
-- 
2.11.0
