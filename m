Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74C401A1D76
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:37:28 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 5 Jun 2015 16:37:25 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 896AC357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:37:22 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t556bEqs33882276
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 16:37:22 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556anDT029958
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 16:36:50 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel v12 30/34] powerpc/iommu/ioda2: Add get_table_size() to
 calculate the size of future table
Date: Fri,  5 Jun 2015 16:35:22 +1000
Message-Id: <1433486126-23551-31-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a way for the IOMMU user to know how much a new table will
use so it can be accounted in the locked_vm limit before allocation
happens.

This stores the allocated table size in pnv_pci_ioda2_get_table_size()
so the locked_vm counter can be updated correctly when a table is
being disposed.

This defines an iommu_table_group_ops callback to let VFIO know
how much memory will be locked if a table is created.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v10:
* s/ROUND_UP/_ALIGN_UP/
* fixed rounding up for @entries_shift (used to use ROUND_UP)

v9:
* reimplemented the whole patch
---
 arch/powerpc/include/asm/iommu.h          |  5 +++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 34 +++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index e554175..9d37492 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -99,6 +99,7 @@ struct iommu_table {
 	unsigned long  it_size;      /* Size of iommu table in entries */
 	unsigned long  it_indirect_levels;
 	unsigned long  it_level_size;
+	unsigned long  it_allocated_size;
 	unsigned long  it_offset;    /* Offset into global table */
 	unsigned long  it_base;      /* mapped address of tce table */
 	unsigned long  it_index;     /* which iommu table this is */
@@ -147,6 +148,10 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 struct iommu_table_group;
 
 struct iommu_table_group_ops {
+	unsigned long (*get_table_size)(
+			__u32 page_shift,
+			__u64 window_size,
+			__u32 levels);
 	long (*create_table)(struct iommu_table_group *table_group,
 			int num,
 			__u32 page_shift,
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 612ab23..1cb96f0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2073,6 +2073,38 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 }
 
 #ifdef CONFIG_IOMMU_API
+static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
+		__u64 window_size, __u32 levels)
+{
+	unsigned long bytes = 0;
+	const unsigned window_shift = ilog2(window_size);
+	unsigned entries_shift = window_shift - page_shift;
+	unsigned table_shift = entries_shift + 3;
+	unsigned long tce_table_size = max(0x1000UL, 1UL << table_shift);
+	unsigned long direct_table_size;
+
+	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS) ||
+			(window_size > memory_hotplug_max()) ||
+			!is_power_of_2(window_size))
+		return 0;
+
+	/* Calculate a direct table size from window_size and levels */
+	entries_shift = (entries_shift + levels - 1) / levels;
+	table_shift = entries_shift + 3;
+	table_shift = max_t(unsigned, table_shift, PAGE_SHIFT);
+	direct_table_size =  1UL << table_shift;
+
+	for ( ; levels; --levels) {
+		bytes += _ALIGN_UP(tce_table_size, direct_table_size);
+
+		tce_table_size /= direct_table_size;
+		tce_table_size <<= 3;
+		tce_table_size = _ALIGN_UP(tce_table_size, direct_table_size);
+	}
+
+	return bytes;
+}
+
 static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 		int num)
 {
@@ -2116,6 +2148,7 @@ static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
 }
 
 static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
+	.get_table_size = pnv_pci_ioda2_get_table_size,
 	.create_table = pnv_pci_ioda2_create_table,
 	.set_window = pnv_pci_ioda2_set_window,
 	.unset_window = pnv_pci_ioda2_unset_window,
@@ -2227,6 +2260,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 			page_shift);
 	tbl->it_level_size = 1ULL << (level_shift - 3);
 	tbl->it_indirect_levels = levels - 1;
+	tbl->it_allocated_size = offset;
 
 	pr_devel("Created TCE table: ws=%08llx ts=%lx @%08llx\n",
 			window_size, tce_table_size, bus_offset);
-- 
2.4.0.rc3.8.gfb3e7d5
