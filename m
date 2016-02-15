Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F29AC1A004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:20 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 15 Feb 2016 11:56:19 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D26B52BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:15 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1F1u6nK7930364
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:15 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1F1tgJj013240
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:55:42 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v3 5/7] KVM: PPC: Replace SPAPR_TCE_SHIFT with
 IOMMU_PAGE_SHIFT_4K
Date: Mon, 15 Feb 2016 12:55:07 +1100
Message-Id: <1455501309-47200-6-git-send-email-aik@ozlabs.ru>
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

SPAPR_TCE_SHIFT is used in few places only and since IOMMU_PAGE_SHIFT_4K
can be easily used instead, remove SPAPR_TCE_SHIFT.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
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
index 1a1e14f..84993d1 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -36,12 +36,13 @@
 #include <asm/ppc-opcode.h>
 #include <asm/kvm_host.h>
 #include <asm/udbg.h>
+#include <asm/iommu.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
 static unsigned long kvmppc_tce_pages(unsigned long window_size)
 {
-	return ALIGN((window_size >> SPAPR_TCE_SHIFT)
+	return ALIGN((window_size >> IOMMU_PAGE_SHIFT_4K)
 		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
 }
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 124d692..0ce4ffb 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -99,7 +99,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	idx = ioba >> SPAPR_TCE_SHIFT;
+	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = (u64 *)page_address(page);
 
@@ -127,7 +127,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	idx = ioba >> SPAPR_TCE_SHIFT;
+	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = (u64 *)page_address(page);
 
-- 
2.5.0.rc3
