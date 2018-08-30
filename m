Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42172s4y1fzF36t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 13:17:25 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel 2/4] KVM: PPC: Inform the userspace about TCE update
 failures
Date: Thu, 30 Aug 2018 13:16:45 +1000
Message-Id: <20180830031647.34134-3-aik@ozlabs.ru>
In-Reply-To: <20180830031647.34134-1-aik@ozlabs.ru>
References: <20180830031647.34134-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We return H_TOO_HARD from TCE update handlers when we think that
the next handler (realmode -> virtual mode -> user mode) has a chance to
handle the request; H_HARDWARE/H_CLOSED otherwise.

This changes the handlers to return H_TOO_HARD on every error giving
the userspace an opportunity to handle any request or at least log
them all.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c    | 8 ++++----
 arch/powerpc/kvm/book3s_64_vio_hv.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 0fef22b..3e8ac98 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -401,7 +401,7 @@ static long kvmppc_tce_iommu_do_unmap(struct kvm *kvm,
 	long ret;
 
 	if (WARN_ON_ONCE(iommu_tce_xchg(tbl, entry, &hpa, &dir)))
-		return H_HARDWARE;
+		return H_TOO_HARD;
 
 	if (dir == DMA_NONE)
 		return H_SUCCESS;
@@ -449,15 +449,15 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 		return H_TOO_HARD;
 
 	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, tbl->it_page_shift, &hpa)))
-		return H_HARDWARE;
+		return H_TOO_HARD;
 
 	if (mm_iommu_mapped_inc(mem))
-		return H_CLOSED;
+		return H_TOO_HARD;
 
 	ret = iommu_tce_xchg(tbl, entry, &hpa, &dir);
 	if (WARN_ON_ONCE(ret)) {
 		mm_iommu_mapped_dec(mem);
-		return H_HARDWARE;
+		return H_TOO_HARD;
 	}
 
 	if (dir != DMA_NONE)
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 7ab6f3f..9584d9b 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -277,10 +277,10 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 
 	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, tbl->it_page_shift,
 			&hpa)))
-		return H_HARDWARE;
+		return H_TOO_HARD;
 
 	if (WARN_ON_ONCE_RM(mm_iommu_mapped_inc(mem)))
-		return H_CLOSED;
+		return H_TOO_HARD;
 
 	ret = iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
 	if (ret) {
@@ -478,7 +478,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 
 		rmap = (void *) vmalloc_to_phys(rmap);
 		if (WARN_ON_ONCE_RM(!rmap))
-			return H_HARDWARE;
+			return H_TOO_HARD;
 
 		/*
 		 * Synchronize with the MMU notifier callbacks in
-- 
2.11.0
