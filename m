Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 417s8K03KczF0wM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 21:15:12 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel v2 3/6] KVM: PPC: Make iommu_table::it_userspace big
 endian
Date: Sun, 17 Jun 2018 21:14:25 +1000
Message-Id: <20180617111428.24349-4-aik@ozlabs.ru>
In-Reply-To: <20180617111428.24349-1-aik@ozlabs.ru>
References: <20180617111428.24349-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are going to reuse multilevel TCE code for the userspace copy of
the TCE table and since it is big endian, let's make the copy big endian
too.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h    |  2 +-
 arch/powerpc/kvm/book3s_64_vio.c    | 11 ++++++-----
 arch/powerpc/kvm/book3s_64_vio_hv.c | 10 +++++-----
 drivers/vfio/vfio_iommu_spapr_tce.c | 19 +++++++++----------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 20febe0..803ac70 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -117,7 +117,7 @@ struct iommu_table {
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
 	unsigned long  it_page_shift;/* table iommu page size */
 	struct list_head it_group_list;/* List of iommu_table_group_link */
-	unsigned long *it_userspace; /* userspace view of the table */
+	__be64 *it_userspace; /* userspace view of the table */
 	struct iommu_table_ops *it_ops;
 	struct kref    it_kref;
 };
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 80ead38..1dbca4b 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -378,19 +378,19 @@ static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
 {
 	struct mm_iommu_table_group_mem_t *mem = NULL;
 	const unsigned long pgsize = 1ULL << tbl->it_page_shift;
-	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
 
 	if (!pua)
 		/* it_userspace allocation might be delayed */
 		return H_TOO_HARD;
 
-	mem = mm_iommu_lookup(kvm->mm, *pua, pgsize);
+	mem = mm_iommu_lookup(kvm->mm, be64_to_cpu(*pua), pgsize);
 	if (!mem)
 		return H_TOO_HARD;
 
 	mm_iommu_mapped_dec(mem);
 
-	*pua = 0;
+	*pua = cpu_to_be64(0);
 
 	return H_SUCCESS;
 }
@@ -437,7 +437,8 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 		enum dma_data_direction dir)
 {
 	long ret;
-	unsigned long hpa, *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	unsigned long hpa;
+	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
 	struct mm_iommu_table_group_mem_t *mem;
 
 	if (!pua)
@@ -464,7 +465,7 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 	if (dir != DMA_NONE)
 		kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
 
-	*pua = ua;
+	*pua = cpu_to_be64(ua);
 
 	return 0;
 }
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 635f3ca..18109f3 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -200,7 +200,7 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
 {
 	struct mm_iommu_table_group_mem_t *mem = NULL;
 	const unsigned long pgsize = 1ULL << tbl->it_page_shift;
-	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
 
 	if (!pua)
 		/* it_userspace allocation might be delayed */
@@ -210,13 +210,13 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
 	if (WARN_ON_ONCE_RM(!pua))
 		return H_HARDWARE;
 
-	mem = mm_iommu_lookup_rm(kvm->mm, *pua, pgsize);
+	mem = mm_iommu_lookup_rm(kvm->mm, be64_to_cpu(*pua), pgsize);
 	if (!mem)
 		return H_TOO_HARD;
 
 	mm_iommu_mapped_dec(mem);
 
-	*pua = 0;
+	*pua = cpu_to_be64(0);
 
 	return H_SUCCESS;
 }
@@ -268,7 +268,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 {
 	long ret;
 	unsigned long hpa = 0;
-	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
 	struct mm_iommu_table_group_mem_t *mem;
 
 	if (!pua)
@@ -302,7 +302,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 	if (dir != DMA_NONE)
 		kvmppc_rm_tce_iommu_mapped_dec(kvm, tbl, entry);
 
-	*pua = ua;
+	*pua = cpu_to_be64(ua);
 
 	return 0;
 }
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 451284e0..8283a4a 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -231,7 +231,7 @@ static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl,
 		decrement_locked_vm(mm, cb >> PAGE_SHIFT);
 		return -ENOMEM;
 	}
-	tbl->it_userspace = uas;
+	tbl->it_userspace = (__be64 *) uas;
 
 	return 0;
 }
@@ -490,20 +490,20 @@ static void tce_iommu_unuse_page_v2(struct tce_container *container,
 	struct mm_iommu_table_group_mem_t *mem = NULL;
 	int ret;
 	unsigned long hpa = 0;
-	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
 
 	if (!pua)
 		return;
 
-	ret = tce_iommu_prereg_ua_to_hpa(container, *pua, IOMMU_PAGE_SIZE(tbl),
-			&hpa, &mem);
+	ret = tce_iommu_prereg_ua_to_hpa(container, be64_to_cpu(*pua),
+			IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
 	if (ret)
-		pr_debug("%s: tce %lx at #%lx was not cached, ret=%d\n",
-				__func__, *pua, entry, ret);
+		pr_debug("%s: tce %llx at #%lx was not cached, ret=%d\n",
+				__func__, be64_to_cpu(*pua), entry, ret);
 	if (mem)
 		mm_iommu_mapped_dec(mem);
 
-	*pua = 0;
+	*pua = cpu_to_be64(0);
 }
 
 static int tce_iommu_clear(struct tce_container *container,
@@ -612,8 +612,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
 
 	for (i = 0; i < pages; ++i) {
 		struct mm_iommu_table_group_mem_t *mem = NULL;
-		unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl,
-				entry + i);
+		__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry + i);
 
 		ret = tce_iommu_prereg_ua_to_hpa(container,
 				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
@@ -646,7 +645,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		if (dirtmp != DMA_NONE)
 			tce_iommu_unuse_page_v2(container, tbl, entry + i);
 
-		*pua = tce;
+		*pua = cpu_to_be64(tce);
 
 		tce += IOMMU_PAGE_SIZE(tbl);
 	}
-- 
2.11.0
