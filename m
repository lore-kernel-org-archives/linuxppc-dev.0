Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1422D1A0349
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:57:12 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 15 Feb 2016 11:57:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C2AC03578057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:57:08 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1F1v0YA17694770
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:57:08 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1F1uaPS008263
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:36 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v3 6/7] KVM: PPC: Move reusable bits of H_PUT_TCE
 handler to helpers
Date: Mon, 15 Feb 2016 12:55:08 +1100
Message-Id: <1455501309-47200-7-git-send-email-aik@ozlabs.ru>
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

Upcoming multi-tce support (H_PUT_TCE_INDIRECT/H_STUFF_TCE hypercalls)
will validate TCE (not to have unexpected bits) and IO address
(to be within the DMA window boundaries).

This introduces helpers to validate TCE and IO address. The helpers are
exported as they compile into vmlinux (to work in realmode) and will be
used later by KVM kernel module in virtual mode.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* inverted @mask in kvmppc_tce_validate() to match the same variable in
kvmppc_ioba_validate()
* s/arithmetial/arithmetic/
* s/should be enabled/would have to be enabled/

v2:
* added note to the commit log about why new helpers are exported
* did not add a note that xxx_validate() validate TCEs for KVM (not for
host kernel DMA) as the helper names and file location tell what are
they for
---
 arch/powerpc/include/asm/kvm_ppc.h  |  4 ++
 arch/powerpc/kvm/book3s_64_vio_hv.c | 89 ++++++++++++++++++++++++++++++++-----
 2 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 2241d53..9513911 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -166,6 +166,10 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 
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
index 0ce4ffb..b608fdd 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -36,6 +36,7 @@
 #include <asm/kvm_host.h>
 #include <asm/udbg.h>
 #include <asm/iommu.h>
+#include <asm/tce.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
@@ -64,7 +65,7 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
  * WARNING: This will be called in real-mode on HV KVM and virtual
  *          mode on PR KVM
  */
-static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
+long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 		unsigned long ioba, unsigned long npages)
 {
 	unsigned long mask = (1ULL << IOMMU_PAGE_SHIFT_4K) - 1;
@@ -76,6 +77,79 @@ static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 
 	return H_SUCCESS;
 }
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
+	unsigned long mask =
+			~(IOMMU_PAGE_MASK_4K | TCE_PCI_WRITE | TCE_PCI_READ);
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
+ * which returns __va(PFN_PHYS(page_to_pfn(page))) which is arithmetic
+ * operation and does not access page struct.
+ *
+ * Theoretically page_address() could be defined different
+ * but either WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL
+ * would have to be enabled.
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
 
 /* WARNING: This will be called in real-mode on HV KVM and virtual
  *          mode on PR KVM
@@ -85,9 +159,6 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 {
 	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
 	long ret;
-	unsigned long idx;
-	struct page *page;
-	u64 *tbl;
 
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
@@ -99,13 +170,11 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
-	page = stt->pages[idx / TCES_PER_PAGE];
-	tbl = (u64 *)page_address(page);
+	ret = kvmppc_tce_validate(stt, tce);
+	if (ret != H_SUCCESS)
+		return ret;
 
-	/* FIXME: Need to validate the TCE itself */
-	/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
-	tbl[idx % TCES_PER_PAGE] = tce;
+	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
 
 	return H_SUCCESS;
 }
-- 
2.5.0.rc3
