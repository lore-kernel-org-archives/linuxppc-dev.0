Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FB9D1A01FE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:23 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:23 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D3B8C3578055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:20 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F98YNA63635536
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:08:34 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PJXu005877
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:19 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 4/7] KVM: PPC: Replace SPAPR_TCE_SHIFT with
 IOMMU_PAGE_SHIFT_4K
Date: Tue, 15 Jul 2014 19:25:08 +1000
Message-Id: <1405416311-12429-5-git-send-email-aik@ozlabs.ru>
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

SPAPR_TCE_SHIFT is used in few places only and since IOMMU_PAGE_SHIFT_4K
can bre easily used instead, remove SPAPR_TCE_SHIFT.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 2 --
 arch/powerpc/kvm/book3s_64_vio.c         | 3 ++-
 arch/powerpc/kvm/book3s_64_vio_hv.c      | 5 +++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index fddb72b..4f7dcf6 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -33,8 +33,6 @@ static inline void svcpu_put(struct kvmppc_book3s_shadow_vcpu *svcpu)
 }
 #endif
 
-#define SPAPR_TCE_SHIFT		12
-
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 #define KVM_DEFAULT_HPT_ORDER	24	/* 16MB HPT by default */
 extern unsigned long kvm_rma_pages;
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 516f2ee..e9bcb13 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -36,12 +36,13 @@
 #include <asm/ppc-opcode.h>
 #include <asm/kvm_host.h>
 #include <asm/udbg.h>
+#include <asm/iommu.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
 static long kvmppc_stt_npages(unsigned long window_size)
 {
-	return ALIGN((window_size >> SPAPR_TCE_SHIFT)
+	return ALIGN((window_size >> IOMMU_PAGE_SHIFT_4K)
 		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
 }
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 89e96b3..2624a01 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -35,6 +35,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/kvm_host.h>
 #include <asm/udbg.h>
+#include <asm/iommu.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
@@ -52,7 +53,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
 		if (stt->liobn == liobn) {
-			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
+			unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
 			struct page *page;
 			u64 *tbl;
 
@@ -84,7 +85,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
 		if (stt->liobn == liobn) {
-			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
+			unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
 			struct page *page;
 			u64 *tbl;
 
-- 
2.0.0
