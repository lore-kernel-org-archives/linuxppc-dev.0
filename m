Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99AEC1A02F6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 28 Mar 2015 00:56:55 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DFA632CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:52 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2REui3Q45940764
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:52 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2REuJEq030949
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:19 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 27/31] powerpc/iommu/ioda2: Add get_table_size() to
 calculate the size of fiture table
Date: Sat, 28 Mar 2015 01:55:11 +1100
Message-Id: <1427468115-2224-28-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
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

This stores the allocated table size in pnv_pci_ioda2_create_table()
so the locked_vm counter can be updated correctly when a table is
being disposed.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h          |  5 +++
 arch/powerpc/platforms/powernv/pci-ioda.c | 54 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index a768a4d..9027b9e 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -94,6 +94,7 @@ struct iommu_table {
 	unsigned long  it_size;      /* Size of iommu table in entries */
 	unsigned long  it_indirect_levels;
 	unsigned long  it_level_size;
+	unsigned long  it_allocated_size;
 	unsigned long  it_offset;    /* Offset into global table */
 	unsigned long  it_base;      /* mapped address of tce table */
 	unsigned long  it_index;     /* which iommu table this is */
@@ -159,6 +160,10 @@ struct iommu_table_group_ops {
 	void (*set_ownership)(struct iommu_table_group *table_group,
 			bool enable);
 
+	unsigned long (*get_table_size)(
+			__u32 page_shift,
+			__u64 window_size,
+			__u32 levels);
 	long (*create_table)(struct iommu_table_group *table_group,
 			int num,
 			__u32 page_shift,
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 036f3c1..e3ee87d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1373,6 +1373,57 @@ static void pnv_free_tce_table(unsigned long addr, unsigned size,
 	free_pages(addr, get_order(size << 3));
 }
 
+static unsigned long pnv_get_tce_table_size(unsigned shift, unsigned levels,
+		unsigned long *left)
+{
+	unsigned long ret, chunk = 1UL << shift, i;
+
+	ret = chunk;
+
+	if (!*left)
+		return 0;
+
+	--levels;
+	if (!levels) {
+		/* This is last level, actual TCEs */
+		*left -= min(*left, chunk);
+		return chunk;
+	}
+
+	for (i = 0; i < (chunk >> 3); ++i) {
+		ret += pnv_get_tce_table_size(shift, levels, left);
+		if (!*left)
+			break;
+	}
+
+	return ret;
+}
+
+static unsigned long pnv_ioda2_get_table_size(__u32 page_shift, __u64 window_size,
+		__u32 levels)
+{
+	unsigned long tce_table_size, shift, ret;
+
+	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
+		return -EINVAL;
+
+	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
+		return -EINVAL;
+
+	tce_table_size = (window_size >> page_shift) * 8;
+	tce_table_size = max(0x1000UL, tce_table_size);
+
+	/* Allocate TCE table */
+	shift = ROUND_UP(ilog2(window_size) - page_shift, levels) / levels;
+	shift += 3;
+	shift = max_t(unsigned, shift, IOMMU_PAGE_SHIFT_4K);
+
+	ret = tce_table_size; /* tbl->it_userspace */
+	ret += pnv_get_tce_table_size(shift, levels, &tce_table_size);
+
+	return ret;
+}
+
 static __be64 *pnv_alloc_tce_table(int nid,
 		unsigned shift, unsigned levels, unsigned long *left)
 {
@@ -1452,6 +1503,8 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 		return -ENOMEM;
 
 	tbl->it_indirect_levels = levels - 1;
+	tbl->it_allocated_size = pnv_ioda2_get_table_size(page_shift,
+			window_size, levels);
 
 	/* Setup linux iommu table */
 	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size,
@@ -1679,6 +1732,7 @@ static long pnv_pci_ioda2_create_table_with_uas(
 
 static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
 	.set_ownership = pnv_ioda2_set_ownership,
+	.get_table_size = pnv_ioda2_get_table_size,
 	.create_table = pnv_pci_ioda2_create_table_with_uas,
 	.set_window = pnv_pci_ioda2_set_window,
 	.unset_window = pnv_pci_ioda2_unset_window,
-- 
2.0.0
