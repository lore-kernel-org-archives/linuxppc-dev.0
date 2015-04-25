Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 541E81A0B77
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7D1382CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGC2e48824550
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCFk7D014093
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:15:47 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 27/32] powerpc/iommu/ioda2: Add get_table_size() to
 calculate the size of future table
Date: Sat, 25 Apr 2015 22:14:51 +1000
Message-Id: <1429964096-11524-28-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
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

This stores the allocated table size in pnv_pci_create_table()
so the locked_vm counter can be updated correctly when a table is
being disposed.

This defines an iommu_table_group_ops callback to let VFIO know
how much memory will be locked if a table is created.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v9:
* reimplemented the whole patch
---
 arch/powerpc/include/asm/iommu.h          |  5 +++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++++
 arch/powerpc/platforms/powernv/pci.c      | 36 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |  2 ++
 4 files changed, 57 insertions(+)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 1472de3..9844c106 100644
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
@@ -155,6 +156,10 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
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
index e0be556..7f548b4 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2062,6 +2062,18 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
 }
 
 #ifdef CONFIG_IOMMU_API
+static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
+		__u64 window_size, __u32 levels)
+{
+	unsigned long ret = pnv_get_table_size(page_shift, window_size, levels);
+
+	if (!ret)
+		return ret;
+
+	/* Add size of it_userspace */
+	return ret + (window_size >> page_shift) * sizeof(unsigned long);
+}
+
 static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 		int num, __u32 page_shift, __u64 window_size, __u32 levels,
 		struct iommu_table *tbl)
@@ -2086,6 +2098,7 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 
 	BUG_ON(tbl->it_userspace);
 	tbl->it_userspace = uas;
+	tbl->it_allocated_size += uas_cb;
 	tbl->it_ops = &pnv_ioda2_iommu_ops;
 	if (pe->tce_inval_reg)
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
@@ -2160,6 +2173,7 @@ static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
 }
 
 static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
+	.get_table_size = pnv_pci_ioda2_get_table_size,
 	.create_table = pnv_pci_ioda2_create_table,
 	.set_window = pnv_pci_ioda2_set_window,
 	.unset_window = pnv_pci_ioda2_unset_window,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index fc129c4..1b5b48a 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -662,6 +662,38 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 	tbl->it_type = TCE_PCI;
 }
 
+unsigned long pnv_get_table_size(__u32 page_shift,
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
+	entries_shift = ROUND_UP(entries_shift, levels) / levels;
+	table_shift = entries_shift + 3;
+	table_shift = max_t(unsigned, table_shift, PAGE_SHIFT);
+	direct_table_size =  1UL << table_shift;
+
+	for ( ; levels; --levels) {
+		bytes += ROUND_UP(tce_table_size, direct_table_size);
+
+		tce_table_size /= direct_table_size;
+		tce_table_size <<= 3;
+		tce_table_size = ROUND_UP(tce_table_size, direct_table_size);
+	}
+
+	return bytes;
+}
+
 static __be64 *pnv_alloc_tce_table_pages(int nid, unsigned shift,
 		unsigned levels, unsigned long limit,
 		unsigned long *tce_table_allocated)
@@ -741,6 +773,10 @@ long pnv_pci_create_table(struct iommu_table_group *table_group, int nid,
 		return -ENOMEM;
 	}
 
+	tbl->it_allocated_size = pnv_get_table_size(page_shift, window_size,
+			levels);
+	WARN_ON(!tbl->it_allocated_size);
+
 	/* Setup linux iommu table */
 	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, bus_offset,
 			page_shift);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 3d1ff584..ce4bc3c 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -224,6 +224,8 @@ extern long pnv_pci_create_table(struct iommu_table_group *table_group, int nid,
 		__u64 bus_offset, __u32 page_shift, __u64 window_size,
 		__u32 levels, struct iommu_table *tbl);
 extern void pnv_pci_free_table(struct iommu_table *tbl);
+extern unsigned long pnv_get_table_size(__u32 page_shift,
+		__u64 window_size, __u32 levels);
 extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
 extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
-- 
2.0.0
