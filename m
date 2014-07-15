Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9F461A01FE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:24 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:24 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0D9692BB0058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:21 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9P40861014036
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:04 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PKou025608
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:20 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 5/7] KVM: PPC: Move reusable bits of H_PUT_TCE handler to
 helpers
Date: Tue, 15 Jul 2014 19:25:09 +1000
Message-Id: <1405416311-12429-6-git-send-email-aik@ozlabs.ru>
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

Upcoming multi-tce support (H_PUT_TCE_INDIRECT/H_STUFF_TCE hypercalls)
will validate TCE (not to have unexpected bits) and IO address (to be within
the DMA window boundaries).

This introduces helpers to validate TCE and IO address.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_ppc.h  |   4 ++
 arch/powerpc/kvm/book3s_64_vio_hv.c | 117 ++++++++++++++++++++++++++++++++----
 2 files changed, 109 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 9c89cdd..26e6e1a 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -127,6 +127,10 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce *args);
+extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
+		unsigned long ioba, unsigned long npages);
+extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
+		unsigned long tce);
 extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			     unsigned long ioba, unsigned long tce);
 extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 2624a01..ab3f50f 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -36,9 +36,102 @@
 #include <asm/kvm_host.h>
 #include <asm/udbg.h>
 #include <asm/iommu.h>
+#include <asm/tce.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
+/*
+ * Validates IO address.
+ *
+ * WARNING: This will be called in real-mode on HV KVM and virtual
+ *          mode on PR KVM
+ */
+long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
+		unsigned long ioba, unsigned long npages)
+{
+	unsigned long mask = (1 << IOMMU_PAGE_SHIFT_4K) - 1;
+	unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
+	unsigned long size = stt->window_size >> IOMMU_PAGE_SHIFT_4K;
+
+	if ((ioba & mask) || (size + npages <= idx))
+		return H_PARAMETER;
+
+	return H_SUCCESS;
+}
+EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
+
+/*
+ * Validates TCE address.
+ * At the moment flags and page mask are validated.
+ * As the host kernel does not access those addresses (just puts them
+ * to the table and user space is supposed to process them), we can skip
+ * checking other things (such as TCE is a guest RAM address or the page
+ * was actually allocated).
+ *
+ * WARNING: This will be called in real-mode on HV KVM and virtual
+ *          mode on PR KVM
+ */
+long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned long tce)
+{
+	unsigned long mask = ((1 << IOMMU_PAGE_SHIFT_4K) - 1) &
+			~(TCE_PCI_WRITE | TCE_PCI_READ);
+
+	if (tce & mask)
+		return H_PARAMETER;
+
+	return H_SUCCESS;
+}
+EXPORT_SYMBOL_GPL(kvmppc_tce_validate);
+
+/* Note on the use of page_address() in real mode,
+ *
+ * It is safe to use page_address() in real mode on ppc64 because
+ * page_address() is always defined as lowmem_page_address()
+ * which returns __va(PFN_PHYS(page_to_pfn(page))) which is arithmetial
+ * operation and does not access page struct.
+ *
+ * Theoretically page_address() could be defined different
+ * but either WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL
+ * should be enabled.
+ * WANT_PAGE_VIRTUAL is never enabled on ppc32/ppc64,
+ * HASHED_PAGE_VIRTUAL could be enabled for ppc32 only and only
+ * if CONFIG_HIGHMEM is defined. As CONFIG_SPARSEMEM_VMEMMAP
+ * is not expected to be enabled on ppc32, page_address()
+ * is safe for ppc32 as well.
+ *
+ * WARNING: This will be called in real-mode on HV KVM and virtual
+ *          mode on PR KVM
+ */
+static u64 *kvmppc_page_address(struct page *page)
+{
+#if defined(HASHED_PAGE_VIRTUAL) || defined(WANT_PAGE_VIRTUAL)
+#error TODO: fix to avoid page_address() here
+#endif
+	return (u64 *) page_address(page);
+}
+
+/*
+ * Handles TCE requests for emulated devices.
+ * Puts guest TCE values to the table and expects user space to convert them.
+ * Called in both real and virtual modes.
+ * Cannot fail so kvmppc_tce_validate must be called before it.
+ *
+ * WARNING: This will be called in real-mode on HV KVM and virtual
+ *          mode on PR KVM
+ */
+void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
+		unsigned long idx, unsigned long tce)
+{
+	struct page *page;
+	u64 *tbl;
+
+	page = stt->pages[idx / TCES_PER_PAGE];
+	tbl = kvmppc_page_address(page);
+
+	tbl[idx % TCES_PER_PAGE] = tce;
+}
+EXPORT_SYMBOL_GPL(kvmppc_tce_put);
+
 /* WARNING: This will be called in real-mode on HV KVM and virtual
  *          mode on PR KVM
  */
@@ -54,20 +147,19 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
 		if (stt->liobn == liobn) {
 			unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
-			struct page *page;
-			u64 *tbl;
-
 			/* udbg_printf("H_PUT_TCE: liobn 0x%lx => stt=%p  window_size=0x%x\n", */
 			/* 	    liobn, stt, stt->window_size); */
-			if (ioba >= stt->window_size)
-				return H_PARAMETER;
+			long ret = kvmppc_ioba_validate(stt, ioba, 1);
 
-			page = stt->pages[idx / TCES_PER_PAGE];
-			tbl = (u64 *)page_address(page);
+			if (ret)
+				return ret;
+
+			ret = kvmppc_tce_validate(stt, tce);
+			if (ret)
+				return ret;
+
+			kvmppc_tce_put(stt, idx, tce);
 
-			/* FIXME: Need to validate the TCE itself */
-			/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
-			tbl[idx % TCES_PER_PAGE] = tce;
 			return H_SUCCESS;
 		}
 	}
@@ -88,9 +180,10 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
 			struct page *page;
 			u64 *tbl;
+			long ret = kvmppc_ioba_validate(stt, ioba, 1);
 
-			if (ioba >= stt->window_size)
-				return H_PARAMETER;
+			if (ret)
+				return ret;
 
 			page = stt->pages[idx / TCES_PER_PAGE];
 			tbl = (u64 *)page_address(page);
-- 
2.0.0
