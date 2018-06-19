Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 4191jx4QJ9zF0x4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 18:44:53 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel 2/2] KVM: PPC: Check if IOMMU page is contained in the
 pinned physical page
Date: Tue, 19 Jun 2018 18:44:14 +1000
Message-Id: <20180619084414.808-3-aik@ozlabs.ru>
In-Reply-To: <20180619084414.808-1-aik@ozlabs.ru>
References: <20180619084414.808-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c that
an IOMMU page is contained in the physical page so the PCI hardware won't
get access to unassigned host memory.

However we do not have this check in KVM fastpath (H_PUT_TCE accelerated
code) so the user space can pin memory backed with 64k pages and create
a hardware TCE table with a bigger page size. We were lucky so far and
did not hit this yet as the very first time the mapping happens
we do not have tbl::it_userspace allocated yet and fall back to
the userspace which in turn calls VFIO IOMMU driver and that fails
because of the check in vfio_iommu_spapr_tce.c which is really
sustainable solution.

This stores the smallest preregistered page size in the preregistered
region descriptor and changes the mm_iommu_xxx API to check this against
the IOMMU page size.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

The bug is: run QEMU _without_ hugepages (no -mempath) and tell it to
advertise 16MB pages to the guest; a typical pseries guest will use 16MB
for IOMMU pages without checking the mmu pagesize and this will fail
at https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/common.c;h=fb396cf00ac40eb35967a04c9cc798ca896eed57;hb=refs/heads/master#l256

With the change, mapping will fail in KVM and the guest will print:

mlx5_core 0000:00:00.0: ibm,create-pe-dma-window(2027) 0 8000000 20000000 18 1f returned 0 (liobn = 0x80000001 starting addr = 8000000 0)
mlx5_core 0000:00:00.0: created tce table LIOBN 0x80000001 for /pci@800000020000000/ethernet@0
mlx5_core 0000:00:00.0: failed to map direct window for /pci@800000020000000/ethernet@0: -1
---
 arch/powerpc/include/asm/mmu_context.h |  4 ++--
 arch/powerpc/kvm/book3s_64_vio.c       |  2 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c    |  6 ++++--
 arch/powerpc/mm/mmu_context_iommu.c    | 16 ++++++++++++++--
 drivers/vfio/vfio_iommu_spapr_tce.c    |  2 +-
 5 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 896efa5..79d570c 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -35,9 +35,9 @@ extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(
 extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries);
 extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
-		unsigned long ua, unsigned long *hpa);
+		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
 extern long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
-		unsigned long ua, unsigned long *hpa);
+		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
 extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
 extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
 #endif
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index d066e37..8c456fa 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -449,7 +449,7 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 		/* This only handles v2 IOMMU type, v1 is handled via ioctl() */
 		return H_TOO_HARD;
 
-	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, &hpa)))
+	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, tbl->it_page_shift, &hpa)))
 		return H_HARDWARE;
 
 	if (mm_iommu_mapped_inc(mem))
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 925fc31..5b298f5 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -279,7 +279,8 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 	if (!mem)
 		return H_TOO_HARD;
 
-	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, &hpa)))
+	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, tbl->it_page_shift,
+			&hpa)))
 		return H_HARDWARE;
 
 	pua = (void *) vmalloc_to_phys(pua);
@@ -469,7 +470,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 
 		mem = mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
 		if (mem)
-			prereg = mm_iommu_ua_to_hpa_rm(mem, ua, &tces) == 0;
+			prereg = mm_iommu_ua_to_hpa_rm(mem, ua,
+					IOMMU_PAGE_SHIFT_4K, &tces) == 0;
 	}
 
 	if (!prereg) {
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index abb4364..18cdf7f 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -27,6 +27,7 @@ struct mm_iommu_table_group_mem_t {
 	struct rcu_head rcu;
 	unsigned long used;
 	atomic64_t mapped;
+	unsigned int pageshift;
 	u64 ua;			/* userspace address */
 	u64 entries;		/* number of entries in hpas[] */
 	u64 *hpas;		/* vmalloc'ed */
@@ -166,6 +167,8 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 		goto unlock_exit;
 	}
 
+	mem->pageshift = 30; /* start from 1G pages - the biggest we have */
+
 	for (i = 0; i < entries; ++i) {
 		if (1 != get_user_pages_fast(ua + (i << PAGE_SHIFT),
 					1/* pages */, 1/* iswrite */, &page)) {
@@ -199,6 +202,9 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 			}
 		}
 populate:
+		mem->pageshift = min_t(unsigned int, mem->pageshift,
+				PAGE_SHIFT +
+				compound_order(compound_head(page)));
 		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
 	}
 
@@ -349,7 +355,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
 EXPORT_SYMBOL_GPL(mm_iommu_find);
 
 long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
-		unsigned long ua, unsigned long *hpa)
+		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
 {
 	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
 	u64 *va = &mem->hpas[entry];
@@ -357,6 +363,9 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 	if (entry >= mem->entries)
 		return -EFAULT;
 
+	if (pageshift > mem->pageshift)
+		return -EFAULT;
+
 	*hpa = *va | (ua & ~PAGE_MASK);
 
 	return 0;
@@ -364,7 +373,7 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
 
 long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
-		unsigned long ua, unsigned long *hpa)
+		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
 {
 	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
 	void *va = &mem->hpas[entry];
@@ -373,6 +382,9 @@ long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
 	if (entry >= mem->entries)
 		return -EFAULT;
 
+	if (pageshift > mem->pageshift)
+		return -EFAULT;
+
 	pa = (void *) vmalloc_to_phys(va);
 	if (!pa)
 		return -EFAULT;
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 2da5f05..7cd63b0 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -467,7 +467,7 @@ static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container,
 	if (!mem)
 		return -EINVAL;
 
-	ret = mm_iommu_ua_to_hpa(mem, tce, phpa);
+	ret = mm_iommu_ua_to_hpa(mem, tce, shift, phpa);
 	if (ret)
 		return -EINVAL;
 
-- 
2.11.0
