Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zgWry1SlLzDqpc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 16:52:15 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alistair Popple <alistair@popple.id.au>, Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel] powerpc/npu: Do not try invalidating 32bit table when
 64bit table is enabled
Date: Tue, 13 Feb 2018 16:51:35 +1100
Message-Id: <20180213055135.25639-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

GPUs and the corresponding NVLink bridges get different PEs as they have
separate translation validation entries (TVEs). We put these PEs to
the same IOMMU group so they cannot be passed through separately.
So the iommu_table_group_ops::set_window/unset_window for GPUs do set
tables to the NPU PEs as well which means that iommu_table's list of
attached PEs (iommu_table_group_link) has both GPU and NPU PEs linked.
This list is used for TCE cache invalidation.

The problem is that NPU PE has just a single TVE and can be programmed
to point to 32bit or 64bit windows while GPU PE has two (as any other PCI
device). So we end up having an 32bit iommu_table struct linked to both
PEs even though only the 64bit TCE table cache can be invalidated on NPU.
And a relatively recent skiboot detects this and prints errors.

This changes GPU's iommu_table_group_ops::set_window/unset_window to make
sure that NPU PE is only linked to the table actually used by the hardware.
If there are two tables used by an IOMMU group, the NPU PE will use
the last programmed one which with the current use scenarios is expected
to be a 64bit one.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Do we need BUG_ON(IOMMU_TABLE_GROUP_MAX_TABLES != 2)?


This is an example for:

0004:04:00.0 3D: NVIDIA Corporation Device 1db1 (rev a1)
0006:00:00.0 Bridge: IBM Device 04ea (rev 01)
0006:00:00.1 Bridge: IBM Device 04ea (rev 01)

Before the patch (npu2_tce_kill messages are from skiboot):

pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=1000
pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=1000
pci 0004:04     : [PE# 00] Setting up window#1 800000000000000..8000000ffffffff pg=10000
pci 0006:00:00.0: [PE# 0d] Setting up window 800000000000000..8000000ffffffff pg=10000
NPU6: npu2_tce_kill: Unexpected TCE size (got 0x1000 expected 0x10000)
NPU6: npu2_tce_kill: Unexpected TCE size (got 0x1000 expected 0x10000)
NPU6: npu2_tce_kill: Unexpected TCE size (got 0x1000 expected 0x10000)
NPU6: npu2_tce_kill: Unexpected TCE size (got 0x1000 expected 0x10000)
NPU6: npu2_tce_kill: Unexpected TCE size (got 0x1000 expected 0x10000)
...
pci 0004:04     : [PE# 00] Removing DMA window #0
pci 0006:00:00.0: [PE# 0d] Removing DMA window
pci 0004:04     : [PE# 00] Removing DMA window #1
pci 0006:00:00.0: [PE# 0d] Removing DMA window
pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=1000
pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=1000
pci 0004:04     : [PE# 00] Setting up window#1 800000000000000..8000000ffffffff pg=10000
pci 0006:00:00.0: [PE# 0d] Setting up window 800000000000000..8000000ffffffff pg=10000

After the patch (no errors here):

pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=1000
pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=1000
pci 0004:04     : [PE# 00] Setting up window#1 800000000000000..8000000ffffffff pg=10000
pci 0006:00:00.0: [PE# 0d] Removing DMA window
pci 0006:00:00.0: [PE# 0d] Setting up window 800000000000000..8000000ffffffff pg=10000
pci 0004:04     : [PE# 00] Removing DMA window #0
pci 0004:04     : [PE# 00] Removing DMA window #1
pci 0006:00:00.0: [PE# 0d] Removing DMA window
pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=1000
pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=1000
pci 0004:04     : [PE# 00] Setting up window#1 800000000000000..8000000ffffffff pg=10000
pci 0006:00:00.0: [PE# 0d] Removing DMA window
pci 0006:00:00.0: [PE# 0d] Setting up window 800000000000000..8000000ffffffff pg=10000
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 496e476..2f91815 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2681,14 +2681,23 @@ static struct pnv_ioda_pe *gpe_table_group_to_npe(
 static long pnv_pci_ioda2_npu_set_window(struct iommu_table_group *table_group,
 		int num, struct iommu_table *tbl)
 {
+	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
+	int num2 = (num == 0) ? 1 : 0;
 	long ret = pnv_pci_ioda2_set_window(table_group, num, tbl);
 
 	if (ret)
 		return ret;
 
-	ret = pnv_npu_set_window(gpe_table_group_to_npe(table_group), num, tbl);
-	if (ret)
+	if (table_group->tables[num2])
+		pnv_npu_unset_window(npe, num2);
+
+	ret = pnv_npu_set_window(npe, num, tbl);
+	if (ret) {
 		pnv_pci_ioda2_unset_window(table_group, num);
+		if (table_group->tables[num2])
+			pnv_npu_set_window(npe, num2,
+					table_group->tables[num2]);
+	}
 
 	return ret;
 }
@@ -2697,12 +2706,24 @@ static long pnv_pci_ioda2_npu_unset_window(
 		struct iommu_table_group *table_group,
 		int num)
 {
+	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
+	int num2 = (num == 0) ? 1 : 0;
 	long ret = pnv_pci_ioda2_unset_window(table_group, num);
 
 	if (ret)
 		return ret;
 
-	return pnv_npu_unset_window(gpe_table_group_to_npe(table_group), num);
+	if (!npe->table_group.tables[num])
+		return 0;
+
+	ret = pnv_npu_unset_window(npe, num);
+	if (ret)
+		return ret;
+
+	if (table_group->tables[num2])
+		ret = pnv_npu_set_window(npe, num2, table_group->tables[num2]);
+
+	return ret;
 }
 
 static void pnv_ioda2_npu_take_ownership(struct iommu_table_group *table_group)
-- 
2.11.0
