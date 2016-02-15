Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 527751A03CD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:57:11 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 15 Feb 2016 11:57:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DFCBC357803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:57:08 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1F1v0ks33882264
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:57:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1F1ua7b008307
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:36 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v3 7/7] KVM: PPC: Add support for multiple-TCE hcalls
Date: Mon, 15 Feb 2016 12:55:09 +1100
Message-Id: <1455501309-47200-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds real and virtual mode handlers for the H_PUT_TCE_INDIRECT and
H_STUFF_TCE hypercalls for user space emulated devices such as IBMVIO
devices or emulated PCI. These calls allow adding multiple entries
(up to 512) into the TCE table in one call which saves time on
transition between kernel and user space.

The current implementation of kvmppc_h_stuff_tce() allows it to be
executed in both real and virtual modes so there is one helper.
The kvmppc_rm_h_put_tce_indirect() needs to translate the guest address
to the host address and since the translation is different, there are
2 helpers - one for each mode.

This implements the KVM_CAP_PPC_MULTITCE capability. When present,
the kernel will try handling H_PUT_TCE_INDIRECT and H_STUFF_TCE if these
are enabled by the userspace via KVM_CAP_PPC_ENABLE_HCALL.
If they can not be handled by the kernel, they are passed on to
the user space. The user space still has to have an implementation
for these.

Both HV and PR-syle KVM are supported.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* remove virtual mode copy of kvmppc_h_stuff_tce and
kvmppc_h_put_tce, will add them in another patch

v2:
* compare @ret with H_SUCCESS instead of assuming H_SUCCESS is zero
* s/~IOMMU_PAGE_MASK_4K/SZ_4K-1/ when testing @tce_list
---
 Documentation/virtual/kvm/api.txt       |  25 ++++++
 arch/powerpc/include/asm/kvm_ppc.h      |  12 +++
 arch/powerpc/kvm/book3s_64_vio.c        |  60 ++++++++++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c     | 150 +++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv.c            |  26 +++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   4 +-
 arch/powerpc/kvm/book3s_pr_papr.c       |  35 ++++++++
 arch/powerpc/kvm/powerpc.c              |   3 +
 8 files changed, 306 insertions(+), 9 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 07e4cdf..da39435 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3035,6 +3035,31 @@ Returns: 0 on success, -1 on error
 
 Queues an SMI on the thread's vcpu.
 
+4.97 KVM_CAP_PPC_MULTITCE
+
+Capability: KVM_CAP_PPC_MULTITCE
+Architectures: ppc
+Type: vm
+
+This capability means the kernel is capable of handling hypercalls
+H_PUT_TCE_INDIRECT and H_STUFF_TCE without passing those into the user
+space. This significantly accelerates DMA operations for PPC KVM guests.
+User space should expect that its handlers for these hypercalls
+are not going to be called if user space previously registered LIOBN
+in KVM (via KVM_CREATE_SPAPR_TCE or similar calls).
+
+In order to enable H_PUT_TCE_INDIRECT and H_STUFF_TCE use in the guest,
+user space might have to advertise it for the guest. For example,
+IBM pSeries (sPAPR) guest starts using them if "hcall-multi-tce" is
+present in the "ibm,hypertas-functions" device-tree property.
+
+The hypercalls mentioned above may or may not be processed successfully
+in the kernel based fast path. If they can not be handled by the kernel,
+they will get passed on to user space. So user space still has to have
+an implementation for these despite the in kernel acceleration.
+
+This capability is always enabled.
+
 5. The kvm_run structure
 ------------------------
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 9513911..4cadee5 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -166,12 +166,24 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce *args);
+extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
+		struct kvm_vcpu *vcpu, unsigned long liobn);
 extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 		unsigned long ioba, unsigned long npages);
 extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
 		unsigned long tce);
+extern long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
+		unsigned long *ua, unsigned long **prmap);
+extern void kvmppc_tce_put(struct kvmppc_spapr_tce_table *tt,
+		unsigned long idx, unsigned long tce);
 extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			     unsigned long ioba, unsigned long tce);
+extern long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_list, unsigned long npages);
+extern long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages);
 extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			     unsigned long ioba);
 extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 84993d1..0b1fd98 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -14,6 +14,7 @@
  *
  * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
  * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
+ * Copyright 2016 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
  */
 
 #include <linux/types.h>
@@ -37,8 +38,7 @@
 #include <asm/kvm_host.h>
 #include <asm/udbg.h>
 #include <asm/iommu.h>
-
-#define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
+#include <asm/tce.h>
 
 static unsigned long kvmppc_tce_pages(unsigned long window_size)
 {
@@ -204,3 +204,59 @@ fail:
 	}
 	return ret;
 }
+
+long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_list, unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *stt;
+	long i, ret = H_SUCCESS, idx;
+	unsigned long entry, ua = 0;
+	u64 __user *tces, tce;
+
+	stt = kvmppc_find_table(vcpu, liobn);
+	if (!stt)
+		return H_TOO_HARD;
+
+	entry = ioba >> IOMMU_PAGE_SHIFT_4K;
+	/*
+	 * SPAPR spec says that the maximum size of the list is 512 TCEs
+	 * so the whole table fits in 4K page
+	 */
+	if (npages > 512)
+		return H_PARAMETER;
+
+	if (tce_list & (SZ_4K - 1))
+		return H_PARAMETER;
+
+	ret = kvmppc_ioba_validate(stt, ioba, npages);
+	if (ret != H_SUCCESS)
+		return ret;
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL)) {
+		ret = H_TOO_HARD;
+		goto unlock_exit;
+	}
+	tces = (u64 __user *) ua;
+
+	for (i = 0; i < npages; ++i) {
+		if (get_user(tce, tces + i)) {
+			ret = H_PARAMETER;
+			goto unlock_exit;
+		}
+		tce = be64_to_cpu(tce);
+
+		ret = kvmppc_tce_validate(stt, tce);
+		if (ret != H_SUCCESS)
+			goto unlock_exit;
+
+		kvmppc_tce_put(stt, entry + i, tce);
+	}
+
+unlock_exit:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvmppc_h_put_tce_indirect);
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index b608fdd..0486aa2 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -14,6 +14,7 @@
  *
  * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
  * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
+ * Copyright 2016 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
  */
 
 #include <linux/types.h>
@@ -30,6 +31,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
 #include <asm/mmu-hash64.h>
+#include <asm/mmu_context.h>
 #include <asm/hvcall.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
@@ -37,6 +39,7 @@
 #include <asm/udbg.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
+#include <asm/iommu.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
@@ -46,7 +49,7 @@
  * WARNING: This will be called in real or virtual mode on HV KVM and virtual
  *          mode on PR KVM
  */
-static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
+struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
 		unsigned long liobn)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -58,6 +61,7 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(kvmppc_find_table);
 
 /*
  * Validates IO address.
@@ -151,9 +155,29 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
 }
 EXPORT_SYMBOL_GPL(kvmppc_tce_put);
 
-/* WARNING: This will be called in real-mode on HV KVM and virtual
- *          mode on PR KVM
- */
+long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
+		unsigned long *ua, unsigned long **prmap)
+{
+	unsigned long gfn = gpa >> PAGE_SHIFT;
+	struct kvm_memory_slot *memslot;
+
+	memslot = search_memslots(kvm_memslots(kvm), gfn);
+	if (!memslot)
+		return -EINVAL;
+
+	*ua = __gfn_to_hva_memslot(memslot, gfn) |
+		(gpa & ~(PAGE_MASK | TCE_PCI_READ | TCE_PCI_WRITE));
+
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	if (prmap)
+		*prmap = &memslot->arch.rmap[gfn - memslot->base_gfn];
+#endif
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
+
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba, unsigned long tce)
 {
@@ -180,6 +204,122 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
 
+static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
+		unsigned long ua, unsigned long *phpa)
+{
+	pte_t *ptep, pte;
+	unsigned shift = 0;
+
+	ptep = __find_linux_pte_or_hugepte(vcpu->arch.pgdir, ua, NULL, &shift);
+	if (!ptep || !pte_present(*ptep))
+		return -ENXIO;
+	pte = *ptep;
+
+	if (!shift)
+		shift = PAGE_SHIFT;
+
+	/* Avoid handling anything potentially complicated in realmode */
+	if (shift > PAGE_SHIFT)
+		return -EAGAIN;
+
+	if (!pte_young(pte))
+		return -EAGAIN;
+
+	*phpa = (pte_pfn(pte) << PAGE_SHIFT) | (ua & ((1ULL << shift) - 1)) |
+			(ua & ~PAGE_MASK);
+
+	return 0;
+}
+
+long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_list,	unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *stt;
+	long i, ret = H_SUCCESS;
+	unsigned long tces, entry, ua = 0;
+	unsigned long *rmap = NULL;
+
+	stt = kvmppc_find_table(vcpu, liobn);
+	if (!stt)
+		return H_TOO_HARD;
+
+	entry = ioba >> IOMMU_PAGE_SHIFT_4K;
+	/*
+	 * The spec says that the maximum size of the list is 512 TCEs
+	 * so the whole table addressed resides in 4K page
+	 */
+	if (npages > 512)
+		return H_PARAMETER;
+
+	if (tce_list & (SZ_4K - 1))
+		return H_PARAMETER;
+
+	ret = kvmppc_ioba_validate(stt, ioba, npages);
+	if (ret != H_SUCCESS)
+		return ret;
+
+	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
+		return H_TOO_HARD;
+
+	rmap = (void *) vmalloc_to_phys(rmap);
+
+	/*
+	 * Synchronize with the MMU notifier callbacks in
+	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
+	 * While we have the rmap lock, code running on other CPUs
+	 * cannot finish unmapping the host real page that backs
+	 * this guest real page, so we are OK to access the host
+	 * real page.
+	 */
+	lock_rmap(rmap);
+	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
+		ret = H_TOO_HARD;
+		goto unlock_exit;
+	}
+
+	for (i = 0; i < npages; ++i) {
+		unsigned long tce = be64_to_cpu(((u64 *)tces)[i]);
+
+		ret = kvmppc_tce_validate(stt, tce);
+		if (ret != H_SUCCESS)
+			goto unlock_exit;
+
+		kvmppc_tce_put(stt, entry + i, tce);
+	}
+
+unlock_exit:
+	unlock_rmap(rmap);
+
+	return ret;
+}
+
+long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *stt;
+	long i, ret;
+
+	stt = kvmppc_find_table(vcpu, liobn);
+	if (!stt)
+		return H_TOO_HARD;
+
+	ret = kvmppc_ioba_validate(stt, ioba, npages);
+	if (ret != H_SUCCESS)
+		return ret;
+
+	/* Check permission bits only to allow userspace poison TCE for debug */
+	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE_4K)
+		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
+
+	return H_SUCCESS;
+}
+EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
+
 long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba)
 {
@@ -205,3 +345,5 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	return H_SUCCESS;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);
+
+#endif /* KVM_BOOK3S_HV_POSSIBLE */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index baeddb0..33b491e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -768,7 +768,31 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		if (kvmppc_xics_enabled(vcpu)) {
 			ret = kvmppc_xics_hcall(vcpu, req);
 			break;
-		} /* fallthrough */
+		}
+		return RESUME_HOST;
+	case H_PUT_TCE:
+		ret = kvmppc_h_put_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
+						kvmppc_get_gpr(vcpu, 5),
+						kvmppc_get_gpr(vcpu, 6));
+		if (ret == H_TOO_HARD)
+			return RESUME_HOST;
+		break;
+	case H_PUT_TCE_INDIRECT:
+		ret = kvmppc_h_put_tce_indirect(vcpu, kvmppc_get_gpr(vcpu, 4),
+						kvmppc_get_gpr(vcpu, 5),
+						kvmppc_get_gpr(vcpu, 6),
+						kvmppc_get_gpr(vcpu, 7));
+		if (ret == H_TOO_HARD)
+			return RESUME_HOST;
+		break;
+	case H_STUFF_TCE:
+		ret = kvmppc_h_stuff_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
+						kvmppc_get_gpr(vcpu, 5),
+						kvmppc_get_gpr(vcpu, 6),
+						kvmppc_get_gpr(vcpu, 7));
+		if (ret == H_TOO_HARD)
+			return RESUME_HOST;
+		break;
 	default:
 		return RESUME_HOST;
 	}
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 6ee26de..ed16182 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2006,8 +2006,8 @@ hcall_real_table:
 	.long	0		/* 0x12c */
 	.long	0		/* 0x130 */
 	.long	DOTSYM(kvmppc_h_set_xdabr) - hcall_real_table
-	.long	0		/* 0x138 */
-	.long	0		/* 0x13c */
+	.long	DOTSYM(kvmppc_h_stuff_tce) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_put_tce_indirect) - hcall_real_table
 	.long	0		/* 0x140 */
 	.long	0		/* 0x144 */
 	.long	0		/* 0x148 */
diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
index f2c75a1..02176fd 100644
--- a/arch/powerpc/kvm/book3s_pr_papr.c
+++ b/arch/powerpc/kvm/book3s_pr_papr.c
@@ -280,6 +280,37 @@ static int kvmppc_h_pr_logical_ci_store(struct kvm_vcpu *vcpu)
 	return EMULATE_DONE;
 }
 
+static int kvmppc_h_pr_put_tce_indirect(struct kvm_vcpu *vcpu)
+{
+	unsigned long liobn = kvmppc_get_gpr(vcpu, 4);
+	unsigned long ioba = kvmppc_get_gpr(vcpu, 5);
+	unsigned long tce = kvmppc_get_gpr(vcpu, 6);
+	unsigned long npages = kvmppc_get_gpr(vcpu, 7);
+	long rc;
+
+	rc = kvmppc_h_put_tce_indirect(vcpu, liobn, ioba,
+			tce, npages);
+	if (rc == H_TOO_HARD)
+		return EMULATE_FAIL;
+	kvmppc_set_gpr(vcpu, 3, rc);
+	return EMULATE_DONE;
+}
+
+static int kvmppc_h_pr_stuff_tce(struct kvm_vcpu *vcpu)
+{
+	unsigned long liobn = kvmppc_get_gpr(vcpu, 4);
+	unsigned long ioba = kvmppc_get_gpr(vcpu, 5);
+	unsigned long tce_value = kvmppc_get_gpr(vcpu, 6);
+	unsigned long npages = kvmppc_get_gpr(vcpu, 7);
+	long rc;
+
+	rc = kvmppc_h_stuff_tce(vcpu, liobn, ioba, tce_value, npages);
+	if (rc == H_TOO_HARD)
+		return EMULATE_FAIL;
+	kvmppc_set_gpr(vcpu, 3, rc);
+	return EMULATE_DONE;
+}
+
 static int kvmppc_h_pr_xics_hcall(struct kvm_vcpu *vcpu, u32 cmd)
 {
 	long rc = kvmppc_xics_hcall(vcpu, cmd);
@@ -306,6 +337,10 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
 		return kvmppc_h_pr_bulk_remove(vcpu);
 	case H_PUT_TCE:
 		return kvmppc_h_pr_put_tce(vcpu);
+	case H_PUT_TCE_INDIRECT:
+		return kvmppc_h_pr_put_tce_indirect(vcpu);
+	case H_STUFF_TCE:
+		return kvmppc_h_pr_stuff_tce(vcpu);
 	case H_CEDE:
 		kvmppc_set_msr_fast(vcpu, kvmppc_get_msr(vcpu) | MSR_EE);
 		kvm_vcpu_block(vcpu);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index a3b182d..69f897d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -569,6 +569,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_PPC_GET_SMMU_INFO:
 		r = 1;
 		break;
+	case KVM_CAP_SPAPR_MULTITCE:
+		r = 1;
+		break;
 #endif
 	default:
 		r = 0;
-- 
2.5.0.rc3
