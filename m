Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 40wlWd5w7RzDrJB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 19:23:25 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Russell Currey <ruscur@russell.cc>,
 Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH kernel] powerpc/powernv/ioda2: Remove redundand free of TCE
 pages
Date: Wed, 30 May 2018 19:22:50 +1000
Message-Id: <20180530092250.28981-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When IODA2 creates a PE, it creates an IOMMU table with it_ops::free
set to pnv_ioda2_table_free() which calls pnv_pci_ioda2_table_free_pages().

Since iommu_tce_table_put() calls it_ops::free when the last reference
to the table is released, explicit call to pnv_pci_ioda2_table_free_pages()
is not needed so let's remove it.

This should fix double free in the case of PCI hotuplug as
pnv_pci_ioda2_table_free_pages() does not reset neither
iommu_table::it_base nor ::it_size.

This was not exposed by SRIOV as it uses different code path via
pnv_pcibios_sriov_disable().

IODA1 does not inialize it_ops::free so it does not have this issue.

Fixes: c5f7700bb "powerpc/powernv: Dynamically release PE"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

We have not seen any bug reports because we have not tested the actual
PCI hotunplug in hardware very well.


---
 arch/powerpc/platforms/powernv/pci-ioda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9731098..92ca662 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3670,7 +3670,6 @@ static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
 		WARN_ON(pe->table_group.group);
 	}
 
-	pnv_pci_ioda2_table_free_pages(tbl);
 	iommu_tce_table_put(tbl);
 }
 
-- 
2.11.0
