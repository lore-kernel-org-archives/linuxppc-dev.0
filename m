Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C60F91A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:45 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:45 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4822F3578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:42 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9PQ4D1048848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:26 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PfnV026106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:41 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 09/13] KVM: PPC: Add page_shift support for in-kernel
 H_PUT_TCE/etc handlers
Date: Tue, 15 Jul 2014 19:25:29 +1000
Message-Id: <1405416333-12477-10-git-send-email-aik@ozlabs.ru>
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

Recently introduced KVM_CREATE_SPAPR_TCE_64 added page_shift. This makes
use of it in kvmppc_tce_put().

This changes kvmppc_tce_put() to take an TCE index rather than IO address.

This does not change the existing behaviour and will be utilized later
by Dynamic DMA windows which support 64K and 16MB page sizes.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c    |  8 ++++----
 arch/powerpc/kvm/book3s_64_vio_hv.c | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 2648d88..8250521 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -371,7 +371,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu,
 	if (ret)
 		return ret;
 
-	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
+	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
 
 	return H_SUCCESS;
 }
@@ -436,7 +436,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	}
 
 	for (i = 0; i < npages; ++i)
-		kvmppc_tce_put(stt, (ioba >> IOMMU_PAGE_SHIFT_4K) + i,
+		kvmppc_tce_put(stt, (ioba >> stt->page_shift) + i,
 				vcpu->arch.tce_tmp_hpas[i]);
 
 unlock_exit:
@@ -465,8 +465,8 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (ret || (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ)))
 		return H_PARAMETER;
 
-	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE_4K)
-		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
+	for (i = 0; i < npages; ++i, ioba += (1 << stt->page_shift))
+		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
 	return H_SUCCESS;
 }
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 6c0b95d..99bac58 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -71,8 +71,8 @@ EXPORT_SYMBOL_GPL(kvmppc_find_tce_table);
 long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 		unsigned long ioba, unsigned long npages)
 {
-	unsigned long mask = (1 << IOMMU_PAGE_SHIFT_4K) - 1;
-	unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
+	unsigned long mask = (1 << stt->page_shift) - 1;
+	unsigned long idx = ioba >> stt->page_shift;
 
 	if ((ioba & mask) || (idx < stt->offset) ||
 			(stt->offset + stt->size + npages <= idx))
@@ -95,7 +95,7 @@ EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
  */
 long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned long tce)
 {
-	unsigned long mask = ((1 << IOMMU_PAGE_SHIFT_4K) - 1) &
+	unsigned long mask = ((1 << stt->page_shift) - 1) &
 			~(TCE_PCI_WRITE | TCE_PCI_READ);
 
 	if (tce & mask)
@@ -271,7 +271,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret)
 		return ret;
 
-	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
+	idx = ioba >> stt->page_shift;
 	kvmppc_tce_put(stt, idx, tce);
 
 	return H_SUCCESS;
@@ -323,7 +323,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	}
 
 	for (i = 0; i < npages; ++i)
-		kvmppc_tce_put(stt, (ioba >> IOMMU_PAGE_SHIFT_4K) + i,
+		kvmppc_tce_put(stt, (ioba >> stt->page_shift) + i,
 				vcpu->arch.tce_tmp_hpas[i]);
 
 put_page_exit:
@@ -354,8 +354,8 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (ret || (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ)))
 		return H_PARAMETER;
 
-	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE_4K)
-		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
+	for (i = 0; i < npages; ++i, ioba += (1 << stt->page_shift))
+		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
 	return H_SUCCESS;
 }
@@ -377,7 +377,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret)
 		return ret;
 
-	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
+	idx = ioba >> stt->page_shift;
 	idx -= stt->offset;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = (u64 *)page_address(page);
-- 
2.0.0
