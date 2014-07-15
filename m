Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CD6A1A01E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:25 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:24 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A942A3578047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F98Zco65667118
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:08:35 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PKkO005901
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:21 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 6/7] KVM: PPC: Add kvmppc_find_tce_table()
Date: Tue, 15 Jul 2014 19:25:10 +1000
Message-Id: <1405416311-12429-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416311-12429-1-git-send-email-aik@ozlabs.ru>
References: <1405416311-12429-1-git-send-email-aik@ozlabs.ru>
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

This adds a common helper to search for a kvmppc_spapr_tce_table by
LIOBN.

This makes H_PUT_TCE and H_GET_TCE handler use this new helper.

The helper will be also used in H_PUT_TCE_INDIRECT and H_STUFF_TCE handlers.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio_hv.c | 79 ++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index ab3f50f..79406f1 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -40,6 +40,20 @@
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
+struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(struct kvm *kvm,
+		unsigned long liobn)
+{
+	struct kvmppc_spapr_tce_table *stt;
+
+	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
+		if (stt->liobn == liobn)
+			return stt;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kvmppc_find_tce_table);
+
 /*
  * Validates IO address.
  *
@@ -138,62 +152,55 @@ EXPORT_SYMBOL_GPL(kvmppc_tce_put);
 long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba, unsigned long tce)
 {
-	struct kvm *kvm = vcpu->kvm;
 	struct kvmppc_spapr_tce_table *stt;
+	long ret;
+	unsigned long idx;
 
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
 
-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
-		if (stt->liobn == liobn) {
-			unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
-			/* udbg_printf("H_PUT_TCE: liobn 0x%lx => stt=%p  window_size=0x%x\n", */
-			/* 	    liobn, stt, stt->window_size); */
-			long ret = kvmppc_ioba_validate(stt, ioba, 1);
+	stt = kvmppc_find_tce_table(vcpu->kvm, liobn);
+	if (!stt)
+		return H_TOO_HARD;
 
-			if (ret)
-				return ret;
+	ret = kvmppc_ioba_validate(stt, ioba, 1);
+	if (ret)
+		return ret;
 
-			ret = kvmppc_tce_validate(stt, tce);
-			if (ret)
-				return ret;
+	ret = kvmppc_tce_validate(stt, tce);
+	if (ret)
+		return ret;
 
-			kvmppc_tce_put(stt, idx, tce);
+	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
+	kvmppc_tce_put(stt, idx, tce);
 
-			return H_SUCCESS;
-		}
-	}
-
-	/* Didn't find the liobn, punt it to userspace */
-	return H_TOO_HARD;
+	return H_SUCCESS;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
 
 long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba)
 {
-	struct kvm *kvm = vcpu->kvm;
 	struct kvmppc_spapr_tce_table *stt;
+	long ret;
+	unsigned long idx;
+	struct page *page;
+	u64 *tbl;
 
-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
-		if (stt->liobn == liobn) {
-			unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
-			struct page *page;
-			u64 *tbl;
-			long ret = kvmppc_ioba_validate(stt, ioba, 1);
+	stt = kvmppc_find_tce_table(vcpu->kvm, liobn);
+	if (!stt)
+		return H_TOO_HARD;
 
-			if (ret)
-				return ret;
+	ret = kvmppc_ioba_validate(stt, ioba, 1);
+	if (ret)
+		return ret;
 
-			page = stt->pages[idx / TCES_PER_PAGE];
-			tbl = (u64 *)page_address(page);
+	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
+	page = stt->pages[idx / TCES_PER_PAGE];
+	tbl = (u64 *)page_address(page);
 
-			vcpu->arch.gpr[4] = tbl[idx % TCES_PER_PAGE];
-			return H_SUCCESS;
-		}
-	}
+	vcpu->arch.gpr[4] = tbl[idx % TCES_PER_PAGE];
 
-	/* Didn't find the liobn, punt it to userspace */
-	return H_TOO_HARD;
+	return H_SUCCESS;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);
-- 
2.0.0
