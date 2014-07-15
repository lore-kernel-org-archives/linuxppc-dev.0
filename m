Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1ABA1A02C3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:48 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:48 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C85D32CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:44 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F98wsk66846784
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:08:58 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PhiE026591
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:44 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 13/13] KVM: PPC: Add support for IOMMU in-kernel handling
Date: Tue, 15 Jul 2014 19:25:33 +1000
Message-Id: <1405416333-12477-14-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
References: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
and H_STUFF_TCE requests targeted an IOMMU TCE table without passing
them to user space which saves time on switching to user space and back.

Both real and virtual modes are supported. The kernel tries to
handle a TCE request in the real mode, if fails it passes the request
to the virtual mode to complete the operation. If it a virtual mode
handler fails, the request is passed to user space.

The first user of this is VFIO on POWER. Trampolines to the VFIO external
user API functions are required for this patch.

This adds a "SPAPR TCE IOMMU" KVM device to associate a logical bus
number (LIOBN) with an VFIO IOMMU group fd and enable in-kernel handling
of map/unmap requests. The device supports a single attribute which is
a struct with LIOBN and IOMMU fd. When the attribute is set, the device
establishes the connection between KVM and VFIO.

Tests show that this patch increases transmission speed from 220MB/s
to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

---

Changes:
v12:
* reworked for the latest VFIO KVM device

v11:
* removed VFIO_IOMMU capability
* fixed comments from Gleb
* added @type to kvmppc_spapr_tce_table struct and split it into 2 parts
(emulated, iommu)

v10:
* all IOMMU TCE links are handled by one KVM device now
* KVM device has its own list of TCE descriptors
* the search-by-liobn function was extended to search through
emulated and IOMMU lists

v9:
* KVM_CAP_SPAPR_TCE_IOMMU ioctl to KVM replaced with "SPAPR TCE IOMMU"
KVM device
* release_spapr_tce_table() is not shared between different TCE types
* reduced the patch size by moving KVM device bits and VFIO external API
trampolines to separate patches
* moved documentation from Documentation/virtual/kvm/api.txt to
Documentation/virtual/kvm/devices/spapr_tce_iommu.txt

v8:
* fixed warnings from check_patch.pl

2013/07/11:
* removed multiple #ifdef IOMMU_API as IOMMU_API is always enabled
for KVM_BOOK3S_64
* kvmppc_gpa_to_hva_and_get also returns host phys address. Not much sense
for this here but the next patch for hugepages support will use it more.

2013/07/06:
* added realmode arch_spin_lock to protect TCE table from races
in real and virtual modes
* POWERPC IOMMU API is changed to support real mode
* iommu_take_ownership and iommu_release_ownership are protected by
iommu_table's locks
* VFIO external user API use rewritten
* multiple small fixes

2013/06/27:
* tce_list page is referenced now in order to protect it from accident
invalidation during H_PUT_TCE_INDIRECT execution
* added use of the external user VFIO API

2013/06/05:
* changed capability number
* changed ioctl number
* update the doc article number

2013/05/20:
* removed get_user() from real mode handlers
* kvm_vcpu_arch::tce_tmp usage extended. Now real mode handler puts there
translated TCEs, tries realmode_get_page() on those and if it fails, it
passes control over the virtual mode handler which tries to finish
the request handling
* kvmppc_lookup_pte() now does realmode_get_page() protected by BUSY bit
on a page
* The only reason to pass the request to user mode now is when the user mode
did not register TCE table in the kernel, in all other cases the virtual mode
handler is expected to do the job

Conflicts:
	arch/powerpc/include/asm/kvm_host.h
	arch/powerpc/kvm/book3s_64_vio.c
---
 arch/powerpc/include/asm/kvm_host.h |   1 +
 arch/powerpc/kvm/book3s_64_vio.c    | 177 ++++++++++++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_64_vio_hv.c | 130 ++++++++++++++++++++++++++
 3 files changed, 298 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 8d8eee9..6056114 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -726,6 +726,7 @@ struct kvm_vcpu_arch {
 		 */
 	} tce_rm_fail;			/* failed stage of request processing */
 	struct page *tce_rm_list_pg;	/* unreferenced page from realmode */
+	unsigned long tce_tmp_num;	/* valid entries number */
 #endif
 #if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE) || \
 	defined(CONFIG_KVM_BOOK3S_PR_POSSIBLE)
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index b7de38e..90e7ad1 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -21,7 +21,6 @@
 #include <linux/string.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
-
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
@@ -29,6 +28,8 @@
 #include <linux/list.h>
 #include <linux/anon_inodes.h>
 #include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/file.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -347,6 +348,8 @@ fail:
  *
  * If pg!=NULL, tries to increase page counter via get_user_pages_fast()
  * and returns ERROR_ADDR if failed.
+ *
+ * if pg!=NULL&&phpa!=NULL, returns host physical address in *phpa.
  */
 static void __user *kvmppc_gpa_to_hva_and_get(struct kvm_vcpu *vcpu,
 		unsigned long gpa, struct page **pg, unsigned long *phpa)
@@ -384,6 +387,128 @@ static void __user *kvmppc_gpa_to_hva_and_get(struct kvm_vcpu *vcpu,
 	return (void *) hva;
 }
 
+long kvmppc_h_put_tce_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce)
+{
+	struct page *pg = NULL;
+	unsigned long hpa;
+	void __user *hva;
+	long idx, ret = H_HARDWARE;
+
+	/* Clear TCE */
+	if (!(tce & (TCE_PCI_READ | TCE_PCI_WRITE))) {
+		if (iommu_tce_clear_param_check(tbl, ioba, 0, 1))
+			return H_PARAMETER;
+
+		if (iommu_clear_tces_and_put_pages(tbl,
+				ioba >> tbl->it_page_shift,
+				1, false))
+			return H_HARDWARE;
+
+		return H_SUCCESS;
+	}
+
+	/* Put TCE */
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	/*
+	 * Real mode referenced the page but hpte changed
+	 * during this operation
+	 */
+	if (vcpu->arch.tce_rm_fail == TCERM_GETPAGE) {
+		put_page(pfn_to_page(vcpu->arch.tce_tmp_hpas[0] >> PAGE_SHIFT));
+		/* And try again */
+	}
+	vcpu->arch.tce_rm_fail = TCERM_NONE;
+#endif
+
+	if (iommu_tce_put_param_check(tbl, ioba, tce))
+		return H_PARAMETER;
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	hva = kvmppc_gpa_to_hva_and_get(vcpu, tce, &pg, &hpa);
+	if (hva == ERROR_ADDR)
+		goto unlock_exit;
+
+	if (iommu_tce_build(tbl, ioba >> tbl->it_page_shift, &hpa, 1, false)) {
+		if (pg && !PageCompound(pg))
+			put_page(pg);
+		goto unlock_exit;
+	}
+	ret = H_SUCCESS;
+
+unlock_exit:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	return ret;
+}
+
+static long kvmppc_h_put_tce_indirect_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long ioba,
+		unsigned long __user *tces, unsigned long npages)
+{
+	long i = 0;
+
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	if (vcpu->arch.tce_rm_fail == TCERM_GETPAGE) {
+		unsigned long tmp;
+
+		if (get_user(tmp, tces + vcpu->arch.tce_tmp_num))
+			return H_HARDWARE;
+		put_page(pfn_to_page(tmp >> PAGE_SHIFT));
+	}
+	i = vcpu->arch.tce_tmp_num;
+#endif
+	for ( ; i < npages; ++i) {
+		struct page *pg = NULL;
+		unsigned long gpa;
+		void __user *hva;
+
+		if (get_user(gpa, tces + i))
+			return H_HARDWARE;
+
+		if (iommu_tce_put_param_check(tbl, ioba +
+					(i << tbl->it_page_shift), gpa))
+			return H_PARAMETER;
+
+		hva = kvmppc_gpa_to_hva_and_get(vcpu, gpa, &pg,
+				&vcpu->arch.tce_tmp_hpas[i]);
+		if (hva == ERROR_ADDR)
+			goto putpages_flush_exit;
+	}
+
+	if (!iommu_tce_build(tbl, ioba >> tbl->it_page_shift,
+			vcpu->arch.tce_tmp_hpas, npages, false))
+		return H_SUCCESS;
+
+putpages_flush_exit:
+	for (--i; i >= 0; --i) {
+		struct page *pg;
+
+		pg = pfn_to_page(vcpu->arch.tce_tmp_hpas[i] >> PAGE_SHIFT);
+		if (pg && !PageCompound(pg))
+			put_page(pg);
+	}
+
+	return H_HARDWARE;
+}
+
+long kvmppc_h_stuff_tce_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	if (iommu_tce_clear_param_check(tbl, ioba, tce_value, npages))
+		return H_PARAMETER;
+
+	if (iommu_clear_tces_and_put_pages(tbl, ioba >> tbl->it_page_shift,
+				npages, false))
+		return H_HARDWARE;
+
+	return H_SUCCESS;
+}
+
 long kvmppc_h_put_tce(struct kvm_vcpu *vcpu,
 		unsigned long liobn, unsigned long ioba,
 		unsigned long tce)
@@ -403,6 +528,13 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu,
 	if (ret)
 		return ret;
 
+	if (stt->tbl) {
+		ret = kvmppc_h_put_tce_iommu(vcpu, stt->tbl, liobn, ioba, tce);
+		if (ret)
+			return ret;
+	}
+
+	/* Update guest version of TCE table */
 	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
 
 	return H_SUCCESS;
@@ -455,22 +587,39 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	if (vcpu->arch.tce_rm_fail == TCERM_PUTLISTPAGE)
 		goto unlock_exit;
 #endif
+	/* Validate TCEs, do not touch tce_tmp_hpas */
+	for (i = vcpu->arch.tce_tmp_num; i < npages; ++i) {
+		unsigned long tce;
 
+		if (get_user(tce, tces + i)) {
+			ret = H_PARAMETER;
+			goto unlock_exit;
+		}
+
+		ret = kvmppc_tce_validate(stt, tce);
+		if (ret)
+			goto unlock_exit;
+	}
+
+	/* Update TCE table if it is VFIO */
+	if (stt->tbl) {
+		ret = kvmppc_h_put_tce_indirect_iommu(vcpu,
+				stt->tbl, ioba, tces, npages);
+		if (ret)
+			goto unlock_exit;
+	}
+
+	/* Update guest version of TCE table */
 	for (i = 0; i < npages; ++i) {
-		if (get_user(vcpu->arch.tce_tmp_hpas[i], tces + i)) {
+		unsigned long tce;
+
+		if (get_user(tce, tces + i)) {
 			ret = H_PARAMETER;
 			goto unlock_exit;
 		}
-
-		ret = kvmppc_tce_validate(stt, vcpu->arch.tce_tmp_hpas[i]);
-		if (ret)
-			goto unlock_exit;
+		kvmppc_tce_put(stt, (ioba >> stt->page_shift) + i, tce);
 	}
 
-	for (i = 0; i < npages; ++i)
-		kvmppc_tce_put(stt, (ioba >> stt->page_shift) + i,
-				vcpu->arch.tce_tmp_hpas[i]);
-
 unlock_exit:
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
@@ -497,6 +646,14 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (ret || (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ)))
 		return H_PARAMETER;
 
+	if (stt->tbl) {
+		ret = kvmppc_h_stuff_tce_iommu(vcpu, stt->tbl, liobn, ioba,
+				tce_value, npages);
+		if (ret)
+			return ret;
+	}
+
+	/* Update guest version of TCE table */
 	for (i = 0; i < npages; ++i, ioba += (1 << stt->page_shift))
 		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 99bac58..47b76a7 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
 #include <linux/list.h>
+#include <linux/iommu.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -247,6 +248,107 @@ static unsigned long kvmppc_rm_gpa_to_hpa_and_get(struct kvm_vcpu *vcpu,
 	return hpa;
 }
 
+static long kvmppc_rm_h_put_tce_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long liobn,
+		unsigned long ioba, unsigned long tce)
+{
+	int ret = 0;
+	unsigned long hpa;
+	struct page *pg = NULL;
+
+	/* Clear TCE */
+	if (!(tce & (TCE_PCI_READ | TCE_PCI_WRITE))) {
+		if (iommu_tce_clear_param_check(tbl, ioba, 0, 1))
+			return H_PARAMETER;
+
+		if (iommu_clear_tces_and_put_pages(tbl,
+				ioba >> tbl->it_page_shift, 1, true))
+			return H_TOO_HARD;
+
+		return H_SUCCESS;
+	}
+
+	/* Put TCE */
+	if (iommu_tce_put_param_check(tbl, ioba, tce))
+		return H_PARAMETER;
+
+	hpa = kvmppc_rm_gpa_to_hpa_and_get(vcpu, tce, &pg);
+
+	if (hpa == ERROR_ADDR) {
+		vcpu->arch.tce_tmp_hpas[0] = hpa;
+		vcpu->arch.tce_rm_fail = pg ? TCERM_GETPAGE : TCERM_NONE;
+		return H_TOO_HARD;
+	}
+
+	ret = iommu_tce_build(tbl, ioba >> tbl->it_page_shift,
+			      &hpa, 1, true);
+
+	if (ret) {
+		vcpu->arch.tce_tmp_hpas[0] = hpa;
+		vcpu->arch.tce_rm_fail = pg ? TCERM_GETPAGE : TCERM_NONE;
+		return H_TOO_HARD;
+	}
+
+	return H_SUCCESS;
+}
+
+static long kvmppc_rm_h_put_tce_indirect_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long ioba,
+		unsigned long *tces, unsigned long npages)
+{
+	int i, ret;
+	unsigned long hpa;
+
+	/* Check all TCEs */
+	for (i = 0; i < npages; ++i) {
+		if (iommu_tce_put_param_check(tbl, ioba +
+				(i << tbl->it_page_shift), tces[i]))
+			return H_PARAMETER;
+	}
+
+	/* Translate TCEs and go get_page() */
+	for (i = 0; i < npages; ++i) {
+		struct page *pg = NULL;
+
+		hpa = kvmppc_rm_gpa_to_hpa_and_get(vcpu, tces[i], &pg);
+		if (hpa == ERROR_ADDR) {
+			vcpu->arch.tce_tmp_hpas[i] = 0xBAADF00D; /* poison */
+			vcpu->arch.tce_tmp_num = i;
+			vcpu->arch.tce_rm_fail = pg ?
+					TCERM_GETPAGE : TCERM_NONE;
+			return H_TOO_HARD;
+		}
+		vcpu->arch.tce_tmp_hpas[i] = hpa;
+	}
+
+	/* Put TCEs to the table */
+	ret = iommu_tce_build(tbl, (ioba >> tbl->it_page_shift),
+			vcpu->arch.tce_tmp_hpas, npages, true);
+	if (ret == -EAGAIN) {
+		vcpu->arch.tce_rm_fail = TCERM_PUTTCE;
+		return H_TOO_HARD;
+	} else if (ret) {
+		return H_HARDWARE;
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
+	if (iommu_tce_clear_param_check(tbl, ioba, tce_value, npages))
+		return H_PARAMETER;
+
+	if (iommu_clear_tces_and_put_pages(tbl, ioba >> tbl->it_page_shift,
+				npages, true))
+		return H_TOO_HARD;
+
+	return H_SUCCESS;
+}
+
 long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		unsigned long ioba, unsigned long tce)
 {
@@ -262,6 +364,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		return H_TOO_HARD;
 
 	vcpu->arch.tce_rm_fail = TCERM_NONE;
+	vcpu->arch.tce_tmp_num = 0;
 
 	ret = kvmppc_ioba_validate(stt, ioba, 1);
 	if (ret)
@@ -271,6 +374,14 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret)
 		return ret;
 
+	if (stt->tbl) {
+		ret = kvmppc_rm_h_put_tce_iommu(vcpu, stt->tbl, liobn,
+				ioba, tce);
+		if (ret)
+			return ret;
+	}
+
+	/* Update guest version of TCE table */
 	idx = ioba >> stt->page_shift;
 	kvmppc_tce_put(stt, idx, tce);
 
@@ -306,6 +417,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 
 	vcpu->arch.tce_rm_fail = TCERM_NONE;
 	vcpu->arch.tce_rm_list_pg = NULL;
+	vcpu->arch.tce_tmp_num = 0;
 	tces = kvmppc_rm_gpa_to_hpa_and_get(vcpu, tce_list, &pg);
 	if (tces == ERROR_ADDR) {
 		vcpu->arch.tce_rm_fail = pg ? TCERM_NONE : TCERM_GETLISTPAGE;
@@ -322,6 +434,16 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		vcpu->arch.tce_tmp_hpas[i] = tce;
 	}
 
+	if (stt->tbl) {
+		ret = kvmppc_rm_h_put_tce_indirect_iommu(vcpu,
+				stt->tbl, ioba, (unsigned long *)tces, npages);
+		if (ret == H_TOO_HARD)
+			return ret;
+		if (ret)
+			goto put_page_exit;
+	}
+
+	/* Update guest version of TCE table */
 	for (i = 0; i < npages; ++i)
 		kvmppc_tce_put(stt, (ioba >> stt->page_shift) + i,
 				vcpu->arch.tce_tmp_hpas[i]);
@@ -354,6 +476,14 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (ret || (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ)))
 		return H_PARAMETER;
 
+	if (stt->tbl) {
+		ret = kvmppc_rm_h_stuff_tce_iommu(vcpu, stt->tbl, liobn, ioba,
+				tce_value, npages);
+		if (ret)
+			return ret;
+	}
+
+	/* Update guest version of TCE table */
 	for (i = 0; i < npages; ++i, ioba += (1 << stt->page_shift))
 		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
-- 
2.0.0
