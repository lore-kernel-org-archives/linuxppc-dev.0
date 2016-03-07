Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66B741A0B54
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:43:12 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 7 Mar 2016 13:43:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C0E6B2BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:43:09 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u273h1uP58785918
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:43:09 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u273gble029601
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:37 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 8/9] KVM: PPC: Add in-kernel handling for VFIO
Date: Mon,  7 Mar 2016 14:41:16 +1100
Message-Id: <1457322077-26640-9-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
and H_STUFF_TCE requests targeted an IOMMU TCE table used for VFIO
without passing them to user space which saves time on switching
to user space and back.

Both real and virtual modes are supported. The kernel tries to
handle a TCE request in the real mode, if fails it passes the request
to the virtual mode to complete the operation. If it a virtual mode
handler fails, the request is passed to user space; this is not expected
to happen ever though.

The first user of this is VFIO on POWER. Trampolines to the VFIO external
user API functions are required for this patch.

This uses a VFIO KVM device to associate a logical bus number (LIOBN)
with an VFIO IOMMU group fd and enable in-kernel handling of map/unmap
requests.

To make use of the feature, the user space has to create a guest view
of the TCE table via KVM_CAP_SPAPR_TCE/KVM_CAP_SPAPR_TCE_64 and
then associate a LIOBN with this table via VFIO KVM device,
a KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN property (which is added in
the next patch).

Tests show that this patch increases transmission speed from 220MB/s
to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c    | 184 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c | 186 ++++++++++++++++++++++++++++++++++++
 2 files changed, 370 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 7965fc7..9417d12 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -33,6 +33,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/mmu-hash64.h>
+#include <asm/mmu_context.h>
 #include <asm/hvcall.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
@@ -317,11 +318,161 @@ fail:
 	return ret;
 }
 
+static long kvmppc_tce_iommu_mapped_dec(struct iommu_table *tbl,
+		unsigned long entry)
+{
+	struct mm_iommu_table_group_mem_t *mem = NULL;
+	const unsigned long pgsize = 1ULL << tbl->it_page_shift;
+	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+
+	if (!pua)
+		return H_HARDWARE;
+
+	mem = mm_iommu_lookup(*pua, pgsize);
+	if (!mem)
+		return H_HARDWARE;
+
+	mm_iommu_mapped_dec(mem);
+
+	*pua = 0;
+
+	return H_SUCCESS;
+}
+
+static long kvmppc_tce_iommu_unmap(struct iommu_table *tbl,
+		unsigned long entry)
+{
+	enum dma_data_direction dir = DMA_NONE;
+	unsigned long hpa = 0;
+
+	if (iommu_tce_xchg(tbl, entry, &hpa, &dir))
+		return H_HARDWARE;
+
+	if (dir == DMA_NONE)
+		return H_SUCCESS;
+
+	return kvmppc_tce_iommu_mapped_dec(tbl, entry);
+}
+
+long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
+		unsigned long entry, unsigned long gpa,
+		enum dma_data_direction dir)
+{
+	long ret;
+	unsigned long hpa, ua, *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	struct mm_iommu_table_group_mem_t *mem;
+
+	if (!pua)
+		return H_HARDWARE;
+
+	if (kvmppc_gpa_to_ua(kvm, gpa, &ua, NULL))
+		return H_HARDWARE;
+
+	mem = mm_iommu_lookup(ua, 1ULL << tbl->it_page_shift);
+	if (!mem)
+		return H_HARDWARE;
+
+	if (mm_iommu_ua_to_hpa(mem, ua, &hpa))
+		return H_HARDWARE;
+
+	if (mm_iommu_mapped_inc(mem))
+		return H_HARDWARE;
+
+	ret = iommu_tce_xchg(tbl, entry, &hpa, &dir);
+	if (ret) {
+		mm_iommu_mapped_dec(mem);
+		return H_TOO_HARD;
+	}
+
+	if (dir != DMA_NONE)
+		kvmppc_tce_iommu_mapped_dec(tbl, entry);
+
+	*pua = ua;
+
+	return 0;
+}
+
+long kvmppc_h_put_tce_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce)
+{
+	long idx, ret = H_HARDWARE;
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+	const unsigned long gpa = tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+	const enum dma_data_direction dir = iommu_tce_direction(tce);
+
+	/* Clear TCE */
+	if (dir == DMA_NONE) {
+		if (iommu_tce_clear_param_check(tbl, ioba, 0, 1))
+			return H_PARAMETER;
+
+		return kvmppc_tce_iommu_unmap(tbl, entry);
+	}
+
+	/* Put TCE */
+	if (iommu_tce_put_param_check(tbl, ioba, tce))
+		return H_PARAMETER;
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	ret = kvmppc_tce_iommu_map(vcpu->kvm, tbl, entry, gpa, dir);
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	return ret;
+}
+
+static long kvmppc_h_put_tce_indirect_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long ioba,
+		u64 __user *tces, unsigned long npages)
+{
+	unsigned long i, ret, tce, gpa;
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+
+	for (i = 0; i < npages; ++i) {
+		gpa = be64_to_cpu(tces[i]) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+
+		if (iommu_tce_put_param_check(tbl, ioba +
+				(i << tbl->it_page_shift), gpa))
+			return H_PARAMETER;
+	}
+
+	for (i = 0; i < npages; ++i) {
+		tce = be64_to_cpu(tces[i]);
+		gpa = tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+
+		ret = kvmppc_tce_iommu_map(vcpu->kvm, tbl, entry + i, gpa,
+				iommu_tce_direction(tce));
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
+	return H_SUCCESS;
+}
+
+long kvmppc_h_stuff_tce_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	unsigned long i;
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+
+	if (iommu_tce_clear_param_check(tbl, ioba, tce_value, npages))
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i)
+		kvmppc_tce_iommu_unmap(tbl, entry + i);
+
+	return H_SUCCESS;
+}
+
 long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba, unsigned long tce)
 {
 	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
 	long ret;
+	struct kvmppc_spapr_tce_group *kg;
+	struct iommu_table *tbltmp = NULL;
 
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
@@ -337,6 +488,15 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
+	list_for_each_entry_lockless(kg, &stt->groups, next) {
+		if (kg->tbl == tbltmp)
+			continue;
+		tbltmp = kg->tbl;
+		ret = kvmppc_h_put_tce_iommu(vcpu, kg->tbl, liobn, ioba, tce);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
 
 	return H_SUCCESS;
@@ -351,6 +511,8 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	long i, ret = H_SUCCESS, idx;
 	unsigned long entry, ua = 0;
 	u64 __user *tces, tce;
+	struct kvmppc_spapr_tce_group *kg;
+	struct iommu_table *tbltmp = NULL;
 
 	stt = kvmppc_find_table(vcpu, liobn);
 	if (!stt)
@@ -378,6 +540,16 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	}
 	tces = (u64 __user *) ua;
 
+	list_for_each_entry_lockless(kg, &stt->groups, next) {
+		if (kg->tbl == tbltmp)
+			continue;
+		tbltmp = kg->tbl;
+		ret = kvmppc_h_put_tce_indirect_iommu(vcpu,
+				kg->tbl, ioba, tces, npages);
+		if (ret != H_SUCCESS)
+			goto unlock_exit;
+	}
+
 	for (i = 0; i < npages; ++i) {
 		if (get_user(tce, tces + i)) {
 			ret = H_TOO_HARD;
@@ -405,6 +577,8 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 {
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret;
+	struct kvmppc_spapr_tce_group *kg;
+	struct iommu_table *tbltmp = NULL;
 
 	stt = kvmppc_find_table(vcpu, liobn);
 	if (!stt)
@@ -418,6 +592,16 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
 		return H_PARAMETER;
 
+	list_for_each_entry_lockless(kg, &stt->groups, next) {
+		if (kg->tbl == tbltmp)
+			continue;
+		tbltmp = kg->tbl;
+		ret = kvmppc_h_stuff_tce_iommu(vcpu, kg->tbl, liobn, ioba,
+				tce_value, npages);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
 		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 11163ae..6567d6c 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
 #include <linux/list.h>
+#include <linux/iommu.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -212,11 +213,162 @@ static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
 	return mm_iommu_lookup_rm(mm, ua, size);
 }
 
+static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long entry)
+{
+	struct mm_iommu_table_group_mem_t *mem = NULL;
+	const unsigned long pgsize = 1ULL << tbl->it_page_shift;
+	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+
+	if (!pua)
+		return H_SUCCESS;
+
+	pua = (void *) vmalloc_to_phys(pua);
+	if (!pua)
+		return H_SUCCESS;
+
+	mem = kvmppc_rm_iommu_lookup(vcpu, *pua, pgsize);
+	if (!mem)
+		return H_HARDWARE;
+
+	mm_iommu_mapped_dec(mem);
+
+	*pua = 0;
+
+	return H_SUCCESS;
+}
+
+static long kvmppc_rm_tce_iommu_unmap(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long entry)
+{
+	enum dma_data_direction dir = DMA_NONE;
+	unsigned long hpa = 0;
+
+	if (iommu_tce_xchg_rm(tbl, entry, &hpa, &dir))
+		return H_HARDWARE;
+
+	if (dir == DMA_NONE)
+		return H_SUCCESS;
+
+	return kvmppc_rm_tce_iommu_mapped_dec(vcpu, tbl, entry);
+}
+
+long kvmppc_rm_tce_iommu_map(struct kvm_vcpu *vcpu, struct iommu_table *tbl,
+		unsigned long entry, unsigned long gpa,
+		enum dma_data_direction dir)
+{
+	long ret;
+	unsigned long hpa = 0, ua;
+	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	struct mm_iommu_table_group_mem_t *mem;
+
+	if (kvmppc_gpa_to_ua(vcpu->kvm, gpa, &ua, NULL))
+		return H_HARDWARE;
+
+	mem = kvmppc_rm_iommu_lookup(vcpu, ua, 1ULL << tbl->it_page_shift);
+	if (!mem)
+		return H_HARDWARE;
+
+	if (mm_iommu_rm_ua_to_hpa(mem, ua, &hpa))
+		return H_HARDWARE;
+
+	pua = (void *) vmalloc_to_phys(pua);
+	if (!pua)
+		return H_HARDWARE;
+
+	if (mm_iommu_mapped_inc(mem))
+		return H_HARDWARE;
+
+	ret = iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
+	if (ret) {
+		mm_iommu_mapped_dec(mem);
+		return H_TOO_HARD;
+	}
+
+	if (dir != DMA_NONE)
+		kvmppc_rm_tce_iommu_mapped_dec(vcpu, tbl, entry);
+
+	*pua = ua;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvmppc_rm_tce_iommu_map);
+
+static long kvmppc_rm_h_put_tce_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long liobn,
+		unsigned long ioba, unsigned long tce)
+{
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+	const unsigned long gpa = tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+	const enum dma_data_direction dir = iommu_tce_direction(tce);
+
+	/* Clear TCE */
+	if (dir == DMA_NONE) {
+		if (iommu_tce_clear_param_check(tbl, ioba, 0, 1))
+			return H_PARAMETER;
+
+		return kvmppc_rm_tce_iommu_unmap(vcpu, tbl, entry);
+	}
+
+	/* Put TCE */
+	if (iommu_tce_put_param_check(tbl, ioba, gpa))
+		return H_PARAMETER;
+
+	return kvmppc_rm_tce_iommu_map(vcpu, tbl, entry, gpa, dir);
+}
+
+static long kvmppc_rm_h_put_tce_indirect_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long ioba,
+		u64 *tces, unsigned long npages)
+{
+	unsigned long i, ret, tce, gpa;
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+
+	for (i = 0; i < npages; ++i) {
+		gpa = be64_to_cpu(tces[i]) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+
+		if (iommu_tce_put_param_check(tbl, ioba +
+				(i << tbl->it_page_shift), gpa))
+			return H_PARAMETER;
+	}
+
+	for (i = 0; i < npages; ++i) {
+		tce = be64_to_cpu(tces[i]);
+		gpa = tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+
+		ret = kvmppc_rm_tce_iommu_map(vcpu, tbl, entry + i, gpa,
+				iommu_tce_direction(tce));
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
+	return H_SUCCESS;
+}
+
+static long kvmppc_rm_h_stuff_tce_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	unsigned long i;
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+
+	if (iommu_tce_clear_param_check(tbl, ioba, tce_value, npages))
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i)
+		kvmppc_rm_tce_iommu_unmap(vcpu, tbl, entry + i);
+
+	return H_SUCCESS;
+}
+
 long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		unsigned long ioba, unsigned long tce)
 {
 	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
 	long ret;
+	struct kvmppc_spapr_tce_group *kg;
+	struct iommu_table *tbltmp = NULL;
 
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
@@ -232,6 +384,16 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
+	list_for_each_entry_lockless(kg, &stt->groups, next) {
+		if (kg->tbl == tbltmp)
+			continue;
+		tbltmp = kg->tbl;
+		ret = kvmppc_rm_h_put_tce_iommu(vcpu, kg->tbl,
+				liobn, ioba, tce);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
 
 	return H_SUCCESS;
@@ -272,6 +434,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	long i, ret = H_SUCCESS;
 	unsigned long tces, entry, ua = 0;
 	unsigned long *rmap = NULL;
+	struct iommu_table *tbltmp = NULL;
 
 	stt = kvmppc_find_table(vcpu, liobn);
 	if (!stt)
@@ -299,6 +462,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		 * depend on hpt.
 		 */
 		struct mm_iommu_table_group_mem_t *mem;
+		struct kvmppc_spapr_tce_group *kg;
 
 		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
 			return H_TOO_HARD;
@@ -306,6 +470,16 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		mem = kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
 		if (!mem || mm_iommu_rm_ua_to_hpa(mem, ua, &tces))
 			return H_TOO_HARD;
+
+		list_for_each_entry_lockless(kg, &stt->groups, next) {
+			if (kg->tbl == tbltmp)
+				continue;
+			tbltmp = kg->tbl;
+			ret = kvmppc_rm_h_put_tce_indirect_iommu(vcpu,
+					kg->tbl, ioba, (u64 *)tces, npages);
+			if (ret != H_SUCCESS)
+				return ret;
+		}
 	} else {
 		/*
 		 * This is emulated devices case.
@@ -355,6 +529,8 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 {
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret;
+	struct kvmppc_spapr_tce_group *kg;
+	struct iommu_table *tbltmp = NULL;
 
 	stt = kvmppc_find_table(vcpu, liobn);
 	if (!stt)
@@ -368,6 +544,16 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
 		return H_PARAMETER;
 
+	list_for_each_entry_lockless(kg, &stt->groups, next) {
+		if (kg->tbl == tbltmp)
+			continue;
+		tbltmp = kg->tbl;
+		ret = kvmppc_rm_h_stuff_tce_iommu(vcpu, kg->tbl,
+				liobn, ioba, tce_value, npages);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
 		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
-- 
2.5.0.rc3
