Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FC2B1A2C5D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:45 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Sep 2015 20:50:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3895E3578054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8FAoUna57409566
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:39 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8FAo6Sf026330
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:06 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 3/9] KVM: PPC: Rework H_PUT_TCE/H_GET_TCE handlers
Date: Tue, 15 Sep 2015 20:49:33 +1000
Message-Id: <1442314179-9706-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reworks the existing H_PUT_TCE/H_GET_TCE handlers to have one
exit path. This allows next patch to add locks nicely.

This moves the ioba boundaries check to a helper and adds a check for
least bits which have to be zeros.

The patch is pretty mechanical (only check for least ioba bits is added)
so no change in behaviour is expected.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio_hv.c | 102 +++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 89e96b3..8ae12ac 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -35,71 +35,101 @@
 #include <asm/ppc-opcode.h>
 #include <asm/kvm_host.h>
 #include <asm/udbg.h>
+#include <asm/iommu.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
+/*
+ * Finds a TCE table descriptor by LIOBN.
+ *
+ * WARNING: This will be called in real or virtual mode on HV KVM and virtual
+ *          mode on PR KVM
+ */
+static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
+		unsigned long liobn)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvmppc_spapr_tce_table *stt;
+
+	list_for_each_entry_rcu_notrace(stt, &kvm->arch.spapr_tce_tables, list)
+		if (stt->liobn == liobn)
+			return stt;
+
+	return NULL;
+}
+
+/*
+ * Validates IO address.
+ *
+ * WARNING: This will be called in real-mode on HV KVM and virtual
+ *          mode on PR KVM
+ */
+static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
+		unsigned long ioba, unsigned long npages)
+{
+	unsigned long mask = (1ULL << IOMMU_PAGE_SHIFT_4K) - 1;
+	unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
+	unsigned long size = stt->window_size >> IOMMU_PAGE_SHIFT_4K;
+
+	if ((ioba & mask) || (size + npages <= idx))
+		return H_PARAMETER;
+
+	return H_SUCCESS;
+}
+
 /* WARNING: This will be called in real-mode on HV KVM and virtual
  *          mode on PR KVM
  */
 long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba, unsigned long tce)
 {
-	struct kvm *kvm = vcpu->kvm;
-	struct kvmppc_spapr_tce_table *stt;
+	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
+	long ret = H_TOO_HARD;
+	unsigned long idx;
+	struct page *page;
+	u64 *tbl;
 
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
 
-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
-		if (stt->liobn == liobn) {
-			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
-			struct page *page;
-			u64 *tbl;
+	if (!stt)
+		return ret;
 
-			/* udbg_printf("H_PUT_TCE: liobn 0x%lx => stt=%p  window_size=0x%x\n", */
-			/* 	    liobn, stt, stt->window_size); */
-			if (ioba >= stt->window_size)
-				return H_PARAMETER;
+	ret = kvmppc_ioba_validate(stt, ioba, 1);
+	if (ret)
+		return ret;
 
-			page = stt->pages[idx / TCES_PER_PAGE];
-			tbl = (u64 *)page_address(page);
+	idx = ioba >> SPAPR_TCE_SHIFT;
+	page = stt->pages[idx / TCES_PER_PAGE];
+	tbl = (u64 *)page_address(page);
 
-			/* FIXME: Need to validate the TCE itself */
-			/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
-			tbl[idx % TCES_PER_PAGE] = tce;
-			return H_SUCCESS;
-		}
-	}
+	/* FIXME: Need to validate the TCE itself */
+	/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
+	tbl[idx % TCES_PER_PAGE] = tce;
 
-	/* Didn't find the liobn, punt it to userspace */
-	return H_TOO_HARD;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
 
 long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba)
 {
-	struct kvm *kvm = vcpu->kvm;
-	struct kvmppc_spapr_tce_table *stt;
+	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
+	long ret = H_TOO_HARD;
 
-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
-		if (stt->liobn == liobn) {
+
+	if (stt) {
+		ret = kvmppc_ioba_validate(stt, ioba, 1);
+		if (!ret) {
 			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
-			struct page *page;
-			u64 *tbl;
-
-			if (ioba >= stt->window_size)
-				return H_PARAMETER;
-
-			page = stt->pages[idx / TCES_PER_PAGE];
-			tbl = (u64 *)page_address(page);
+			struct page *page = stt->pages[idx / TCES_PER_PAGE];
+			u64 *tbl = (u64 *)page_address(page);
 
 			vcpu->arch.gpr[4] = tbl[idx % TCES_PER_PAGE];
-			return H_SUCCESS;
 		}
 	}
 
-	/* Didn't find the liobn, punt it to userspace */
-	return H_TOO_HARD;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);
-- 
2.4.0.rc3.8.gfb3e7d5
