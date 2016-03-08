Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CFCC1A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:14 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 22/25] powerpc/kvm: Exclude HPT resizes when collecting the
 dirty log
Date: Tue,  8 Mar 2016 14:08:59 +1100
Message-Id: <1457406542-6210-23-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
References: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While there is an active HPT resize in progress, working out which guest
pages are dirty is rather more complicated, because depending on exactly
the phase of the resize the information could be in either the current,
tentative or previous HPT or reverse map of the guest.

To avoid this problem, for now we just exclude collecting the dirty map
while a resize is in progress, blocking the dirty map operation until the
resize is complete.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 5b84347..c4c1814 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1128,6 +1128,7 @@ long kvmppc_hv_get_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	unsigned long *rmapp;
 	struct kvm_vcpu *vcpu;
 
+	mutex_lock(&kvm->arch.resize_hpt_mutex); /* exclude a concurrent HPT resize */
 	preempt_disable();
 	rmapp = memslot->arch.rmap;
 	for (i = 0; i < memslot->npages; ++i) {
@@ -1152,6 +1153,7 @@ long kvmppc_hv_get_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		spin_unlock(&vcpu->arch.vpa_update_lock);
 	}
 	preempt_enable();
+	mutex_unlock(&kvm->arch.resize_hpt_mutex);
 	return 0;
 }
 
-- 
2.5.0
