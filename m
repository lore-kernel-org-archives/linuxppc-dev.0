Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 412BJC5pj7zF36V
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 15:47:23 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH kernel 6/6] powerpc/powernv/ioda: Allocate indirect TCE levels
 on demand
Date: Fri,  8 Jun 2018 15:46:33 +1000
Message-Id: <20180608054633.18659-7-aik@ozlabs.ru>
In-Reply-To: <20180608054633.18659-1-aik@ozlabs.ru>
References: <20180608054633.18659-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment we allocate the entire TCE table, twice (hardware part and
userspace translation cache). This normally works as we normally have
contigous memory and the guest will map entire RAM for 64bit DMA.

However if we have sparse RAM (one example is a memory device), then
we will allocate TCEs which will never be used as the guest only maps
actual memory for DMA. If it is a single level TCE table, there is nothing
we can really do but if it a multilevel table, we can skip allocating
TCEs we know we won't need.

This adds ability to allocate only first level, saving memory.

This changes iommu_table::free() to avoid allocating of an extra level;
iommu_table::set() will do this when needed.

This adds @alloc parameter to iommu_table::exchange() to tell the callback
if it can allocate an extra level; the flag is set to "false" for
the realmode KVM handlers of H_PUT_TCE hcalls and the callback returns
H_TOO_HARD.

This still requires the entire table to be counted in mm::locked_vm.

To be conservative, this only does on-demand allocation when
the usespace cache table is requested which is the case of VFIO.

The example math for a system replicating a powernv setup with NVLink2
in a guest:
16GB RAM mapped at 0x0
128GB GPU RAM window (16GB of actual RAM) mapped at 0x244000000000

the table to cover that all with 64K pages takes:
(((0x244000000000 + 0x2000000000) >> 16)*8)>>20 = 4556MB

If we allocate only necessary TCE levels, we will only need:
(((0x400000000 + 0x400000000) >> 16)*8)>>20 = 4MB (plus some for indirect
levels).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h              |  7 ++-
 arch/powerpc/platforms/powernv/pci.h          |  6 ++-
 arch/powerpc/kvm/book3s_64_vio_hv.c           |  4 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 69 ++++++++++++++++++++-------
 arch/powerpc/platforms/powernv/pci-ioda.c     |  8 ++--
 drivers/vfio/vfio_iommu_spapr_tce.c           |  2 +-
 6 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 4bdcf22..daa3ee5 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -70,7 +70,7 @@ struct iommu_table_ops {
 			unsigned long *hpa,
 			enum dma_data_direction *direction);
 
-	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index);
+	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index, bool alloc);
 #endif
 	void (*clear)(struct iommu_table *tbl,
 			long index, long npages);
@@ -122,10 +122,13 @@ struct iommu_table {
 	__be64 *it_userspace; /* userspace view of the table */
 	struct iommu_table_ops *it_ops;
 	struct kref    it_kref;
+	int it_nid;
 };
 
+#define IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry) \
+		((tbl)->it_ops->useraddrptr((tbl), (entry), false))
 #define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
-		((tbl)->it_ops->useraddrptr((tbl), (entry)))
+		((tbl)->it_ops->useraddrptr((tbl), (entry), true))
 
 /* Pure 2^n version of get_order */
 static inline __attribute_const__
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 5e02408..1fa5590 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -267,8 +267,10 @@ extern int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 		unsigned long attrs);
 extern void pnv_tce_free(struct iommu_table *tbl, long index, long npages);
 extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
-		unsigned long *hpa, enum dma_data_direction *direction);
-extern __be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index);
+		unsigned long *hpa, enum dma_data_direction *direction,
+		bool alloc);
+extern __be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index,
+		bool alloc);
 extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
 
 extern long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index db0490c..05b4865 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -200,7 +200,7 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
 {
 	struct mm_iommu_table_group_mem_t *mem = NULL;
 	const unsigned long pgsize = 1ULL << tbl->it_page_shift;
-	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry);
 
 	if (!pua)
 		/* it_userspace allocation might be delayed */
@@ -264,7 +264,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 {
 	long ret;
 	unsigned long hpa = 0;
-	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry);
 	struct mm_iommu_table_group_mem_t *mem;
 
 	if (!pua)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index 36c2eb0..a7debfb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -48,7 +48,7 @@ static __be64 *pnv_alloc_tce_level(int nid, unsigned int shift)
 	return addr;
 }
 
-static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx)
+static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx, bool alloc)
 {
 	__be64 *tmp = user ? tbl->it_userspace : (__be64 *) tbl->it_base;
 	int  level = tbl->it_indirect_levels;
@@ -57,7 +57,20 @@ static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx)
 
 	while (level) {
 		int n = (idx & mask) >> (level * shift);
-		unsigned long tce = be64_to_cpu(tmp[n]);
+		unsigned long tce;
+
+		if (tmp[n] == 0) {
+			__be64 *tmp2;
+
+			if (!alloc)
+				return NULL;
+
+			tmp2 = pnv_alloc_tce_level(tbl->it_nid,
+					ilog2(tbl->it_level_size) + 3);
+			tmp[n] = cpu_to_be64(__pa(tmp2) |
+					TCE_PCI_READ | TCE_PCI_WRITE);
+		}
+		tce = be64_to_cpu(tmp[n]);
 
 		tmp = __va(tce & ~(TCE_PCI_READ | TCE_PCI_WRITE));
 		idx &= ~mask;
@@ -84,7 +97,7 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 			((rpn + i) << tbl->it_page_shift);
 		unsigned long idx = index - tbl->it_offset + i;
 
-		*(pnv_tce(tbl, false, idx)) = cpu_to_be64(newtce);
+		*(pnv_tce(tbl, false, idx, true)) = cpu_to_be64(newtce);
 	}
 
 	return 0;
@@ -92,31 +105,45 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 
 #ifdef CONFIG_IOMMU_API
 int pnv_tce_xchg(struct iommu_table *tbl, long index,
-		unsigned long *hpa, enum dma_data_direction *direction)
+		unsigned long *hpa, enum dma_data_direction *direction,
+		bool alloc)
 {
 	u64 proto_tce = iommu_direction_to_tce_perm(*direction);
 	unsigned long newtce = *hpa | proto_tce, oldtce;
 	unsigned long idx = index - tbl->it_offset;
+	__be64 *ptce;
 
 	BUG_ON(*hpa & ~IOMMU_PAGE_MASK(tbl));
 
 	if (newtce & TCE_PCI_WRITE)
 		newtce |= TCE_PCI_READ;
 
-	oldtce = be64_to_cpu(xchg(pnv_tce(tbl, false, idx),
-				  cpu_to_be64(newtce)));
+	ptce = pnv_tce(tbl, false, idx, alloc);
+	if (!ptce) {
+		if (*direction == DMA_NONE) {
+			*hpa = 0;
+			return 0;
+		}
+		/* It is likely to be realmode */
+		if (!alloc)
+			return H_TOO_HARD;
+
+		return H_HARDWARE;
+	}
+
+	oldtce = be64_to_cpu(xchg(ptce, cpu_to_be64(newtce)));
 	*hpa = oldtce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
 	*direction = iommu_tce_direction(oldtce);
 
 	return 0;
 }
 
-__be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index)
+__be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index, bool alloc)
 {
 	if (WARN_ON_ONCE(!tbl->it_userspace))
 		return NULL;
 
-	return pnv_tce(tbl, true, index - tbl->it_offset);
+	return pnv_tce(tbl, true, index - tbl->it_offset, alloc);
 }
 #endif
 
@@ -126,14 +153,19 @@ void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 
 	for (i = 0; i < npages; i++) {
 		unsigned long idx = index - tbl->it_offset + i;
+		__be64 *ptce = pnv_tce(tbl, false, idx,	false);
 
-		*(pnv_tce(tbl, false, idx)) = cpu_to_be64(0);
+		if (ptce)
+			*ptce = cpu_to_be64(0);
 	}
 }
 
 unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
 {
-	__be64 *ptce = pnv_tce(tbl, false, index - tbl->it_offset);
+	__be64 *ptce = pnv_tce(tbl, false, index - tbl->it_offset, false);
+
+	if (!ptce)
+		return 0;
 
 	return be64_to_cpu(*ptce);
 }
@@ -224,6 +256,7 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	unsigned int table_shift = max_t(unsigned int, entries_shift + 3,
 			PAGE_SHIFT);
 	const unsigned long tce_table_size = 1UL << table_shift;
+	unsigned int tmplevels = levels;
 
 	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
 		return -EINVAL;
@@ -231,6 +264,9 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	if (!is_power_of_2(window_size))
 		return -EINVAL;
 
+	if (alloc_userspace_copy && (window_size > (1ULL << 32)))
+		tmplevels = 1;
+
 	/* Adjust direct table size from window_size and levels */
 	entries_shift = (entries_shift + levels - 1) / levels;
 	level_shift = entries_shift + 3;
@@ -241,7 +277,7 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 
 	/* Allocate TCE table */
 	addr = pnv_pci_ioda2_table_do_alloc_pages(nid, level_shift,
-			levels, tce_table_size, &offset, &total_allocated);
+			tmplevels, tce_table_size, &offset, &total_allocated);
 
 	/* addr==NULL means that the first level allocation failed */
 	if (!addr)
@@ -252,7 +288,7 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	 * we did not allocate as much as we wanted,
 	 * release partially allocated table.
 	 */
-	if (offset < tce_table_size)
+	if (tmplevels == levels && offset < tce_table_size)
 		goto free_tces_exit;
 
 	/* Allocate userspace view of the TCE table */
@@ -263,8 +299,8 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 				&total_allocated_uas);
 		if (!uas)
 			goto free_tces_exit;
-		if (offset < tce_table_size ||
-				total_allocated_uas != total_allocated)
+		if (tmplevels == levels && (offset < tce_table_size ||
+				total_allocated_uas != total_allocated))
 			goto free_uas_exit;
 	}
 
@@ -275,10 +311,11 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	tbl->it_indirect_levels = levels - 1;
 	tbl->it_allocated_size = total_allocated;
 	tbl->it_userspace = uas;
+	tbl->it_nid = nid;
 
-	pr_debug("Created TCE table: ws=%08llx ts=%lx @%08llx base=%lx uas=%p levels=%d\n",
+	pr_debug("Created TCE table: ws=%08llx ts=%lx @%08llx base=%lx uas=%p levels=%d/%d\n",
 			window_size, tce_table_size, bus_offset, tbl->it_base,
-			tbl->it_userspace, levels);
+			tbl->it_userspace, tmplevels, levels);
 
 	return 0;
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c61c04d..d9df620 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2010,7 +2010,7 @@ static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
 static int pnv_ioda1_tce_xchg(struct iommu_table *tbl, long index,
 		unsigned long *hpa, enum dma_data_direction *direction)
 {
-	long ret = pnv_tce_xchg(tbl, index, hpa, direction);
+	long ret = pnv_tce_xchg(tbl, index, hpa, direction, true);
 
 	if (!ret)
 		pnv_pci_p7ioc_tce_invalidate(tbl, index, 1, false);
@@ -2021,7 +2021,7 @@ static int pnv_ioda1_tce_xchg(struct iommu_table *tbl, long index,
 static int pnv_ioda1_tce_xchg_rm(struct iommu_table *tbl, long index,
 		unsigned long *hpa, enum dma_data_direction *direction)
 {
-	long ret = pnv_tce_xchg(tbl, index, hpa, direction);
+	long ret = pnv_tce_xchg(tbl, index, hpa, direction, false);
 
 	if (!ret)
 		pnv_pci_p7ioc_tce_invalidate(tbl, index, 1, true);
@@ -2175,7 +2175,7 @@ static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
 static int pnv_ioda2_tce_xchg(struct iommu_table *tbl, long index,
 		unsigned long *hpa, enum dma_data_direction *direction)
 {
-	long ret = pnv_tce_xchg(tbl, index, hpa, direction);
+	long ret = pnv_tce_xchg(tbl, index, hpa, direction, true);
 
 	if (!ret)
 		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, false);
@@ -2186,7 +2186,7 @@ static int pnv_ioda2_tce_xchg(struct iommu_table *tbl, long index,
 static int pnv_ioda2_tce_xchg_rm(struct iommu_table *tbl, long index,
 		unsigned long *hpa, enum dma_data_direction *direction)
 {
-	long ret = pnv_tce_xchg(tbl, index, hpa, direction);
+	long ret = pnv_tce_xchg(tbl, index, hpa, direction, false);
 
 	if (!ret)
 		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, true);
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 628a948..f040ab1 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -639,7 +639,7 @@ static long tce_iommu_create_table(struct tce_container *container,
 			page_shift, window_size, levels, ptbl);
 
 	WARN_ON(!ret && !(*ptbl)->it_ops->free);
-	WARN_ON(!ret && ((*ptbl)->it_allocated_size != table_size));
+	WARN_ON(!ret && ((*ptbl)->it_allocated_size > table_size));
 
 	return ret;
 }
-- 
2.11.0
