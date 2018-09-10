Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 4281ST1VXzzF3F0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 18:30:01 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel v2 4/6] KVM: PPC: Validate TCEs against preregistered
 memory page sizes
Date: Mon, 10 Sep 2018 18:29:10 +1000
Message-Id: <20180910082912.13255-5-aik@ozlabs.ru>
In-Reply-To: <20180910082912.13255-1-aik@ozlabs.ru>
References: <20180910082912.13255-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The userspace can request an arbitrary supported page size for a DMA
window and this works fine as long as the mapped memory is backed with
the pages of the same or bigger size; if this is not the case,
mm_iommu_ua_to_hpa{_rm}() fail and tables do not populated with
dangerously incorrect TCEs.

However since it is quite easy to misconfigure the KVM and we do not do
reverts to all changes made to TCE tables if an error happens in a middle,
we better do the acceptable page size validation before we even touch
the tables.

This enhances kvmppc_tce_validate() to check the hardware IOMMU page sizes
against the preregistered memory page sizes.

Since the new check uses real/virtual mode helpers, this renames
kvmppc_tce_validate() to kvmppc_rm_tce_validate() to handle the real mode
case and mirrors it for the virtual mode under the old name. The real
mode handler is not used for the virtual mode as:
1. it uses _lockless() list traversing primitives instead of RCU;
2. realmode's mm_iommu_ua_to_hpa_rm() uses vmalloc_to_phys() which
virtual mode does not have to use and since on POWER9+radix only virtual
mode handlers actually work, we do not want to slow down that path even
a bit.

This removes EXPORT_SYMBOL_GPL(kvmppc_tce_validate) as the validators
are static now.

>From now on the attempts on mapping IOMMU pages bigger than allowed will
result in KVM exit.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v2:
* updated commit log
---
 arch/powerpc/include/asm/kvm_ppc.h  |  2 --
 arch/powerpc/kvm/book3s_64_vio.c    | 35 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c | 30 +++++++++++++++++++++++-------
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index e991821..2f5d431 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -194,8 +194,6 @@ extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
 		(iommu_tce_check_ioba((stt)->page_shift, (stt)->offset, \
 				(stt)->size, (ioba), (npages)) ?        \
 				H_PARAMETER : H_SUCCESS)
-extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
-		unsigned long tce);
 extern long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
 		unsigned long *ua, unsigned long **prmap);
 extern void kvmppc_tce_put(struct kvmppc_spapr_tce_table *tt,
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 984cec8..01e1994 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -363,6 +363,41 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	return ret;
 }
 
+static long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt,
+		unsigned long tce)
+{
+	unsigned long gpa = tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+	enum dma_data_direction dir = iommu_tce_direction(tce);
+	struct kvmppc_spapr_tce_iommu_table *stit;
+	unsigned long ua = 0;
+
+	/* Allow userspace to poison TCE table */
+	if (dir == DMA_NONE)
+		return H_SUCCESS;
+
+	if (iommu_tce_check_gpa(stt->page_shift, gpa))
+		return H_TOO_HARD;
+
+	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
+				&ua, NULL))
+		return H_TOO_HARD;
+
+	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
+		unsigned long hpa = 0;
+		struct mm_iommu_table_group_mem_t *mem;
+		long shift = stit->tbl->it_page_shift;
+
+		mem = mm_iommu_lookup(stt->kvm->mm, ua, 1ULL << shift);
+		if (!mem)
+			return H_TOO_HARD;
+
+		if (mm_iommu_ua_to_hpa(mem, ua, shift, &hpa))
+			return H_TOO_HARD;
+	}
+
+	return H_SUCCESS;
+}
+
 static void kvmppc_clear_tce(struct iommu_table *tbl, unsigned long entry)
 {
 	unsigned long hpa = 0;
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 7388b66..977e95a 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -94,14 +94,14 @@ EXPORT_SYMBOL_GPL(kvmppc_find_table);
  * to the table and user space is supposed to process them), we can skip
  * checking other things (such as TCE is a guest RAM address or the page
  * was actually allocated).
- *
- * WARNING: This will be called in real-mode on HV KVM and virtual
- *          mode on PR KVM
  */
-long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned long tce)
+static long kvmppc_rm_tce_validate(struct kvmppc_spapr_tce_table *stt,
+		unsigned long tce)
 {
 	unsigned long gpa = tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
 	enum dma_data_direction dir = iommu_tce_direction(tce);
+	struct kvmppc_spapr_tce_iommu_table *stit;
+	unsigned long ua = 0;
 
 	/* Allow userspace to poison TCE table */
 	if (dir == DMA_NONE)
@@ -110,9 +110,25 @@ long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned long tce)
 	if (iommu_tce_check_gpa(stt->page_shift, gpa))
 		return H_PARAMETER;
 
+	if (kvmppc_gpa_to_ua(stt->kvm, tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
+				&ua, NULL))
+		return H_TOO_HARD;
+
+	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+		unsigned long hpa = 0;
+		struct mm_iommu_table_group_mem_t *mem;
+		long shift = stit->tbl->it_page_shift;
+
+		mem = mm_iommu_lookup_rm(stt->kvm->mm, ua, 1ULL << shift);
+		if (!mem)
+			return H_TOO_HARD;
+
+		if (mm_iommu_ua_to_hpa_rm(mem, ua, shift, &hpa))
+			return H_TOO_HARD;
+	}
+
 	return H_SUCCESS;
 }
-EXPORT_SYMBOL_GPL(kvmppc_tce_validate);
 
 /* Note on the use of page_address() in real mode,
  *
@@ -368,7 +384,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	ret = kvmppc_tce_validate(stt, tce);
+	ret = kvmppc_rm_tce_validate(stt, tce);
 	if (ret != H_SUCCESS)
 		return ret;
 
@@ -521,7 +537,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	for (i = 0; i < npages; ++i) {
 		unsigned long tce = be64_to_cpu(((u64 *)tces)[i]);
 
-		ret = kvmppc_tce_validate(stt, tce);
+		ret = kvmppc_rm_tce_validate(stt, tce);
 		if (ret != H_SUCCESS)
 			goto unlock_exit;
 	}
-- 
2.11.0
