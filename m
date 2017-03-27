Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vs6bL1gv3zDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 19:27:41 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH kernel v2] powerpc/powernv: Check kzalloc() return value in
 pnv_pci_table_alloc
Date: Mon, 27 Mar 2017 19:27:37 +1100
Message-Id: <20170327082737.14448-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_pci_table_alloc() ignores possible failure from kzalloc_node(),
this adds a check. There are 2 callers of pnv_pci_table_alloc(),
one already checks for tbl!=NULL, this adds WARN_ON() to the other path
which only happens during boot time in IODA1 and not expected to fail.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* s/BUG_ON/WARN_ON/
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 +++
 arch/powerpc/platforms/powernv/pci.c      | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index e36738291c32..04ef03a5201b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2128,6 +2128,9 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 
 found:
 	tbl = pnv_pci_table_alloc(phb->hose->node);
+	if (WARN_ON(!tbl))
+		return;
+
 	iommu_register_group(&pe->table_group, phb->hose->global_number,
 			pe->pe_number);
 	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index eb835e977e33..9acdf6889c0d 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -766,6 +766,9 @@ struct iommu_table *pnv_pci_table_alloc(int nid)
 	struct iommu_table *tbl;
 
 	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, nid);
+	if (!tbl)
+		return NULL;
+
 	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
 
 	return tbl;
-- 
2.11.0
