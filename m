Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 Dec 2011 17:13:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 11/13] KVM: Add barriers to allow mmu_notifier_retry to be
 used locklessly
Message-ID: <20111206061313.GO12389@drongo>
References: <20111206060156.GD12389@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111206060156.GD12389@drongo>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds an smp_wmb in kvm_mmu_notifier_invalidate_range_end() and an
smp_rmb in mmu_notifier_retry() so that mmu_notifier_retry() will give
the correct answer when called without kvm->mmu_lock being held.
PowerPC Book3S HV KVM wants to use a bitlock per guest page rather than
a single global spinlock in order to improve the scalability of updates
to the guest MMU hashed page table, and so needs this.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 include/linux/kvm_host.h |   14 +++++++++-----
 virt/kvm/kvm_main.c      |    6 +++---
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c6a2ec9..17319ad 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -672,12 +672,16 @@ static inline int mmu_notifier_retry(struct kvm_vcpu *vcpu, unsigned long mmu_se
 	if (unlikely(vcpu->kvm->mmu_notifier_count))
 		return 1;
 	/*
-	 * Both reads happen under the mmu_lock and both values are
-	 * modified under mmu_lock, so there's no need of smb_rmb()
-	 * here in between, otherwise mmu_notifier_count should be
-	 * read before mmu_notifier_seq, see
-	 * mmu_notifier_invalidate_range_end write side.
+	 * Ensure the read of mmu_notifier_count happens before the read
+	 * of mmu_notifier_seq.  This interacts with the smp_wmb() in
+	 * mmu_notifier_invalidate_range_end to make sure that the caller
+	 * either sees the old (non-zero) value of mmu_notifier_count or
+	 * the new (incremented) value of mmu_notifier_seq.
+	 * PowerPC Book3s HV KVM calls this under a per-page lock
+	 * rather than under kvm->mmu_lock, for scalability, so
+	 * can't rely on kvm->mmu_lock to keep things ordered.
 	 */
+	smp_rmb();
 	if (vcpu->kvm->mmu_notifier_seq != mmu_seq)
 		return 1;
 	return 0;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d9cfb78..ad2a912 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -357,11 +357,11 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 	 * been freed.
 	 */
 	kvm->mmu_notifier_seq++;
+	smp_wmb();
 	/*
 	 * The above sequence increase must be visible before the
-	 * below count decrease but both values are read by the kvm
-	 * page fault under mmu_lock spinlock so we don't need to add
-	 * a smb_wmb() here in between the two.
+	 * below count decrease, which is ensured by the smp_wmb above
+	 * in conjunction with the smp_rmb in mmu_notifier_retry().
 	 */
 	kvm->mmu_notifier_count--;
 	spin_unlock(&kvm->mmu_lock);
-- 
1.7.5.4
