Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yBhdf4TyRzDr6D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 16:01:10 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Paul Mackerras <paulus@samba.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: [PATCH kernel] KVM: PPC: Protect kvmppc_gpa_to_ua() with srcu
Date: Wed, 11 Oct 2017 16:00:34 +1100
Message-Id: <20171011050034.37872-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kvmppc_gpa_to_ua() accesses KVM memory slot array via
srcu_dereference_check() and this produces warnings from RCU like below.

This extends the existing srcu_read_lock/unlock to cover that
kvmppc_gpa_to_ua() as well.

We did not hit this before as this lock is not needed for the realmode
handlers and hash guests would use the realmode path all the time;
however the radix guests are always redirected to the virtual mode
handlers and hence the warning.

[   68.253798] ./include/linux/kvm_host.h:575 suspicious rcu_dereference_check() usage!
[   68.253799]
               other info that might help us debug this:

[   68.253802]
               rcu_scheduler_active = 2, debug_locks = 1
[   68.253804] 1 lock held by qemu-system-ppc/6413:
[   68.253806]  #0:  (&vcpu->mutex){+.+.}, at: [<c00800000e3c22f4>] vcpu_load+0x3c/0xc0 [kvm]
[   68.253826]
               stack backtrace:
[   68.253830] CPU: 92 PID: 6413 Comm: qemu-system-ppc Tainted: G        W       4.14.0-rc3-00553-g432dcba58e9c-dirty #72
[   68.253833] Call Trace:
[   68.253839] [c000000fd3d9f790] [c000000000b7fcc8] dump_stack+0xe8/0x160 (unreliable)
[   68.253845] [c000000fd3d9f7d0] [c0000000001924c0] lockdep_rcu_suspicious+0x110/0x180
[   68.253851] [c000000fd3d9f850] [c0000000000e825c] kvmppc_gpa_to_ua+0x26c/0x2b0
[   68.253858] [c000000fd3d9f8b0] [c00800000e3e1984] kvmppc_h_put_tce+0x12c/0x2a0 [kvm]

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 8f2da8bba737..4dffa611376d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -478,28 +478,30 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		return ret;
 
 	dir = iommu_tce_direction(tce);
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
 	if ((dir != DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
-			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL))
-		return H_PARAMETER;
+			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL)) {
+		ret = H_PARAMETER;
+		goto unlock_exit;
+	}
 
 	entry = ioba >> stt->page_shift;
 
 	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
-		if (dir == DMA_NONE) {
+		if (dir == DMA_NONE)
 			ret = kvmppc_tce_iommu_unmap(vcpu->kvm,
 					stit->tbl, entry);
-		} else {
-			idx = srcu_read_lock(&vcpu->kvm->srcu);
+		else
 			ret = kvmppc_tce_iommu_map(vcpu->kvm, stit->tbl,
 					entry, ua, dir);
-			srcu_read_unlock(&vcpu->kvm->srcu, idx);
-		}
 
 		if (ret == H_SUCCESS)
 			continue;
 
 		if (ret == H_TOO_HARD)
-			return ret;
+			goto unlock_exit;
 
 		WARN_ON_ONCE(1);
 		kvmppc_clear_tce(stit->tbl, entry);
@@ -507,7 +509,10 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 	kvmppc_tce_put(stt, entry, tce);
 
-	return H_SUCCESS;
+unlock_exit:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
 
-- 
2.11.0
