Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A61821A2C5D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:51:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Sep 2015 20:51:04 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AC41A2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:51:02 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8FAojKd48627742
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8FAoURI026750
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:30 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 6/9] KVM: PPC: Replace SPAPR_TCE_SHIFT with
 IOMMU_PAGE_SHIFT_4K
Date: Tue, 15 Sep 2015 20:49:36 +1000
Message-Id: <1442314179-9706-7-git-send-email-aik@ozlabs.ru>
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

SPAPR_TCE_SHIFT is used in few places only and since IOMMU_PAGE_SHIFT_4K
can be easily used instead, remove SPAPR_TCE_SHIFT.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 2 --
 arch/powerpc/kvm/book3s_64_vio.c         | 3 ++-
 arch/powerpc/kvm/book3s_64_vio_hv.c      | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 2aa79c8..7529aab 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -33,8 +33,6 @@ static inline void svcpu_put(struct kvmppc_book3s_shadow_vcpu *svcpu)
 }
 #endif
 
-#define SPAPR_TCE_SHIFT		12
-
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 #define KVM_DEFAULT_HPT_ORDER	24	/* 16MB HPT by default */
 #endif
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index b70787d..e347856 100644
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
index 8ae12ac..6cf1ab3 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -99,7 +99,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret)
 		return ret;
 
-	idx = ioba >> SPAPR_TCE_SHIFT;
+	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = (u64 *)page_address(page);
 
@@ -121,7 +121,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (stt) {
 		ret = kvmppc_ioba_validate(stt, ioba, 1);
 		if (!ret) {
-			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
+			unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
 			struct page *page = stt->pages[idx / TCES_PER_PAGE];
 			u64 *tbl = (u64 *)page_address(page);
 
-- 
2.4.0.rc3.8.gfb3e7d5
