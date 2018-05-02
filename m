Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 40bPr40YXZzF2RF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 14:07:31 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel 1/2] KVM: PPC: Use correct page shift in H_STUFF_TCE
Date: Wed,  2 May 2018 14:07:22 +1000
Message-Id: <20180502040723.20545-2-aik@ozlabs.ru>
In-Reply-To: <20180502040723.20545-1-aik@ozlabs.ru>
References: <20180502040723.20545-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The other TCE handlers use page shift from the guest visible TCE table
(described by kvmppc_spapr_tce_iommu_table) so let's make H_STUFF_TCE
handlers do the same thing.

This should cause no behavioral change now but soon we will allow
the iommu_table::it_page_shift being different from from the emulated
table page size so this will play a role.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c    | 2 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 4dffa61..041e54d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -615,7 +615,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 		return H_PARAMETER;
 
 	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
-		unsigned long entry = ioba >> stit->tbl->it_page_shift;
+		unsigned long entry = ioba >> stt->page_shift;
 
 		for (i = 0; i < npages; ++i) {
 			ret = kvmppc_tce_iommu_unmap(vcpu->kvm,
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 6651f73..e220fab 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -526,7 +526,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 		return H_PARAMETER;
 
 	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
-		unsigned long entry = ioba >> stit->tbl->it_page_shift;
+		unsigned long entry = ioba >> stt->page_shift;
 
 		for (i = 0; i < npages; ++i) {
 			ret = kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
-- 
2.11.0
