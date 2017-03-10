Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vfYKM2LD4zDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 14:53:59 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v8 09/10] KVM: PPC: iommu: Unify TCE checking
Date: Fri, 10 Mar 2017 14:53:36 +1100
Message-Id: <20170310035337.22091-10-aik@ozlabs.ru>
In-Reply-To: <20170310035337.22091-1-aik@ozlabs.ru>
References: <20170310035337.22091-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reworks helpers for checking TCE update parameters in way they
can be used in KVM.

This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v6:
* s/tce/gpa/ as TCE without permission bits is a GPA and this is what is
passed everywhere
---
 arch/powerpc/include/asm/iommu.h    | 20 +++++++++++++++-----
 arch/powerpc/include/asm/kvm_ppc.h  |  6 ++++--
 arch/powerpc/kernel/iommu.c         | 37 +++++++++++++------------------------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 31 +++++++------------------------
 4 files changed, 39 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 82e77ebf85f4..1e6b03339a68 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -296,11 +296,21 @@ static inline void iommu_restore(void)
 #endif
 
 /* The API to support IOMMU operations for VFIO */
-extern int iommu_tce_clear_param_check(struct iommu_table *tbl,
-		unsigned long ioba, unsigned long tce_value,
-		unsigned long npages);
-extern int iommu_tce_put_param_check(struct iommu_table *tbl,
-		unsigned long ioba, unsigned long tce);
+extern int iommu_tce_check_ioba(unsigned long page_shift,
+		unsigned long offset, unsigned long size,
+		unsigned long ioba, unsigned long npages);
+extern int iommu_tce_check_gpa(unsigned long page_shift,
+		unsigned long gpa);
+
+#define iommu_tce_clear_param_check(tbl, ioba, tce_value, npages) \
+		(iommu_tce_check_ioba((tbl)->it_page_shift,       \
+				(tbl)->it_offset, (tbl)->it_size, \
+				(ioba), (npages)) || (tce_value))
+#define iommu_tce_put_param_check(tbl, ioba, gpa)                 \
+		(iommu_tce_check_ioba((tbl)->it_page_shift,       \
+				(tbl)->it_offset, (tbl)->it_size, \
+				(ioba), 1) ||                     \
+		iommu_tce_check_gpa((tbl)->it_page_shift, (gpa)))
 
 extern void iommu_flush_tce(struct iommu_table *tbl);
 extern int iommu_take_ownership(struct iommu_table *tbl);
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index eba8988d8443..72c2a155641f 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -169,8 +169,10 @@ extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce_64 *args);
 extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
 		struct kvm *kvm, unsigned long liobn);
-extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
-		unsigned long ioba, unsigned long npages);
+#define kvmppc_ioba_validate(stt, ioba, npages)                         \
+		(iommu_tce_check_ioba((stt)->page_shift, (stt)->offset, \
+				(stt)->size, (ioba), (npages)) ?        \
+				H_PARAMETER : H_SUCCESS)
 extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
 		unsigned long tce);
 extern long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index d02b8d22fb50..4269f9f1623b 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -960,47 +960,36 @@ void iommu_flush_tce(struct iommu_table *tbl)
 }
 EXPORT_SYMBOL_GPL(iommu_flush_tce);
 
-int iommu_tce_clear_param_check(struct iommu_table *tbl,
-		unsigned long ioba, unsigned long tce_value,
-		unsigned long npages)
+int iommu_tce_check_ioba(unsigned long page_shift,
+		unsigned long offset, unsigned long size,
+		unsigned long ioba, unsigned long npages)
 {
-	/* tbl->it_ops->clear() does not support any value but 0 */
-	if (tce_value)
-		return -EINVAL;
+	unsigned long mask = (1UL << page_shift) - 1;
 
-	if (ioba & ~IOMMU_PAGE_MASK(tbl))
+	if (ioba & mask)
 		return -EINVAL;
 
-	ioba >>= tbl->it_page_shift;
-	if (ioba < tbl->it_offset)
+	ioba >>= page_shift;
+	if (ioba < offset)
 		return -EINVAL;
 
-	if ((ioba + npages) > (tbl->it_offset + tbl->it_size))
+	if ((ioba + 1) > (offset + size))
 		return -EINVAL;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iommu_tce_clear_param_check);
+EXPORT_SYMBOL_GPL(iommu_tce_check_ioba);
 
-int iommu_tce_put_param_check(struct iommu_table *tbl,
-		unsigned long ioba, unsigned long tce)
+int iommu_tce_check_gpa(unsigned long page_shift, unsigned long gpa)
 {
-	if (tce & ~IOMMU_PAGE_MASK(tbl))
-		return -EINVAL;
-
-	if (ioba & ~IOMMU_PAGE_MASK(tbl))
-		return -EINVAL;
-
-	ioba >>= tbl->it_page_shift;
-	if (ioba < tbl->it_offset)
-		return -EINVAL;
+	unsigned long mask = (1UL << page_shift) - 1;
 
-	if ((ioba + 1) > (tbl->it_offset + tbl->it_size))
+	if (gpa & mask)
 		return -EINVAL;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iommu_tce_put_param_check);
+EXPORT_SYMBOL_GPL(iommu_tce_check_gpa);
 
 long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
 		unsigned long *hpa, enum dma_data_direction *direction)
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 0f145fc7a3a5..440d3ab5dc32 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -62,27 +62,6 @@ struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(kvmppc_find_table);
 
 /*
- * Validates IO address.
- *
- * WARNING: This will be called in real-mode on HV KVM and virtual
- *          mode on PR KVM
- */
-long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
-		unsigned long ioba, unsigned long npages)
-{
-	unsigned long mask = (1ULL << stt->page_shift) - 1;
-	unsigned long idx = ioba >> stt->page_shift;
-
-	if ((ioba & mask) || (idx < stt->offset) ||
-			(idx - stt->offset + npages > stt->size) ||
-			(idx + npages < idx))
-		return H_PARAMETER;
-
-	return H_SUCCESS;
-}
-EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
-
-/*
  * Validates TCE address.
  * At the moment flags and page mask are validated.
  * As the host kernel does not access those addresses (just puts them
@@ -95,10 +74,14 @@ EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
  */
 long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned long tce)
 {
-	unsigned long page_mask = ~((1ULL << stt->page_shift) - 1);
-	unsigned long mask = ~(page_mask | TCE_PCI_WRITE | TCE_PCI_READ);
+	unsigned long gpa = tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+	enum dma_data_direction dir = iommu_tce_direction(tce);
 
-	if (tce & mask)
+	/* Allow userspace to poison TCE table */
+	if (dir == DMA_NONE)
+		return H_SUCCESS;
+
+	if (iommu_tce_check_gpa(stt->page_shift, gpa))
 		return H_PARAMETER;
 
 	return H_SUCCESS;
-- 
2.11.0
