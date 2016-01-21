Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F27341A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:40:40 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 21 Jan 2016 17:40:38 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AEC7D2CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:40:35 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0L7e58B41222256
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:40:13 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0L7e3Q0025339
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:40:03 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v2 1/6] KVM: PPC: Rework H_PUT_TCE/H_GET_TCE handlers
Date: Thu, 21 Jan 2016 18:39:32 +1100
Message-Id: <1453361977-19589-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reworks the existing H_PUT_TCE/H_GET_TCE handlers to have following
patches applied nicer.

This moves the ioba boundaries check to a helper and adds a check for
least bits which have to be zeros.

The patch is pretty mechanical (only check for least ioba bits is added)
so no change in behaviour is expected.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changelog:
v2:
* compare @ret with H_SUCCESS instead of assuming H_SUCCESS is zero
* made error reporting cleaner
---
 arch/powerpc/kvm/book3s_64_vio_hv.c | 111 +++++++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 89e96b3..862f9a2 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -35,71 +35,104 @@
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
+	list_for_each_entry_lockless(stt, &kvm->arch.spapr_tce_tables, list)
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
+	if ((ioba & mask) || (idx + npages > size))
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
+	long ret;
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
+		return H_TOO_HARD;
 
-			/* udbg_printf("H_PUT_TCE: liobn 0x%lx => stt=%p  window_size=0x%x\n", */
-			/* 	    liobn, stt, stt->window_size); */
-			if (ioba >= stt->window_size)
-				return H_PARAMETER;
+	ret = kvmppc_ioba_validate(stt, ioba, 1);
+	if (ret != H_SUCCESS)
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
+	return H_SUCCESS;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
 
 long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
-		      unsigned long ioba)
+		unsigned long ioba)
 {
-	struct kvm *kvm = vcpu->kvm;
-	struct kvmppc_spapr_tce_table *stt;
+	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
+	long ret;
+	unsigned long idx;
+	struct page *page;
+	u64 *tbl;
 
-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
-		if (stt->liobn == liobn) {
-			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
-			struct page *page;
-			u64 *tbl;
+	if (!stt)
+		return H_TOO_HARD;
 
-			if (ioba >= stt->window_size)
-				return H_PARAMETER;
+	ret = kvmppc_ioba_validate(stt, ioba, 1);
+	if (ret != H_SUCCESS)
+		return ret;
 
-			page = stt->pages[idx / TCES_PER_PAGE];
-			tbl = (u64 *)page_address(page);
+	idx = ioba >> SPAPR_TCE_SHIFT;
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
2.5.0.rc3
