Return-Path: <paulus@ozlabs.org>
Date: Thu, 15 Dec 2011 23:02:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 3/5] KVM: PPC: Book3S HV: Use the hardware referenced bit for
 kvm_age_hva
Message-ID: <20111215120247.GD20629@bloggs.ozlabs.ibm.com>
References: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This uses the host view of the hardware R (referenced) bit to speed
up kvm_age_hva() and kvm_test_age_hva().  Instead of removing all
the relevant HPTEs in kvm_age_hva(), we now just reset their R bits
if set.  Also, kvm_test_age_hva() now scans the relevant HPTEs to
see if any of them have R set.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h |    2 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c   |   81 ++++++++++++++++++++++++++++-----
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   |   19 ++++++++
 3 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index ea9539c..6ececb4 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -149,6 +149,8 @@ extern void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
 			unsigned long *rmap, long pte_index, int realmode);
 extern void kvmppc_invalidate_hpte(struct kvm *kvm, unsigned long *hptep,
 			unsigned long pte_index);
+void kvmppc_clear_ref_hpte(struct kvm *kvm, unsigned long *hptep,
+			unsigned long pte_index);
 extern void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long addr,
 			unsigned long *nb_ret);
 extern void kvmppc_unpin_guest_page(struct kvm *kvm, void *addr);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index aa51dde..926e2b9 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -772,16 +772,50 @@ int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
 static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			 unsigned long gfn)
 {
-	if (!kvm->arch.using_mmu_notifiers)
-		return 0;
-	if (!(*rmapp & KVMPPC_RMAP_REFERENCED))
-		return 0;
-	kvm_unmap_rmapp(kvm, rmapp, gfn);
-	while (test_and_set_bit_lock(KVMPPC_RMAP_LOCK_BIT, rmapp))
-		cpu_relax();
-	*rmapp &= ~KVMPPC_RMAP_REFERENCED;
-	__clear_bit_unlock(KVMPPC_RMAP_LOCK_BIT, rmapp);
-	return 1;
+	struct revmap_entry *rev = kvm->arch.revmap;
+	unsigned long head, i, j;
+	unsigned long *hptep;
+	int ret = 0;
+
+ retry:
+	lock_rmap(rmapp);
+	if (*rmapp & KVMPPC_RMAP_REFERENCED) {
+		*rmapp &= ~KVMPPC_RMAP_REFERENCED;
+		ret = 1;
+	}
+	if (!(*rmapp & KVMPPC_RMAP_PRESENT)) {
+		unlock_rmap(rmapp);
+		return ret;
+	}
+
+	i = head = *rmapp & KVMPPC_RMAP_INDEX;
+	do {
+		hptep = (unsigned long *) (kvm->arch.hpt_virt + (i << 4));
+		j = rev[i].forw;
+
+		/* If this HPTE isn't referenced, ignore it */
+		if (!(hptep[1] & HPTE_R_R))
+			continue;
+
+		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
+			/* unlock rmap before spinning on the HPTE lock */
+			unlock_rmap(rmapp);
+			while (hptep[0] & HPTE_V_HVLOCK)
+				cpu_relax();
+			goto retry;
+		}
+
+		/* Now check and modify the HPTE */
+		if ((hptep[0] & HPTE_V_VALID) && (hptep[1] & HPTE_R_R)) {
+			kvmppc_clear_ref_hpte(kvm, hptep, i);
+			rev[i].guest_rpte |= HPTE_R_R;
+			ret = 1;
+		}
+		hptep[0] &= ~HPTE_V_HVLOCK;
+	} while ((i = j) != head);
+
+	unlock_rmap(rmapp);
+	return ret;
 }
 
 int kvm_age_hva(struct kvm *kvm, unsigned long hva)
@@ -794,7 +828,32 @@ int kvm_age_hva(struct kvm *kvm, unsigned long hva)
 static int kvm_test_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			      unsigned long gfn)
 {
-	return !!(*rmapp & KVMPPC_RMAP_REFERENCED);
+	struct revmap_entry *rev = kvm->arch.revmap;
+	unsigned long head, i, j;
+	unsigned long *hp;
+	int ret = 1;
+
+	if (*rmapp & KVMPPC_RMAP_REFERENCED)
+		return 1;
+
+	lock_rmap(rmapp);
+	if (*rmapp & KVMPPC_RMAP_REFERENCED)
+		goto out;
+
+	if (*rmapp & KVMPPC_RMAP_PRESENT) {
+		i = head = *rmapp & KVMPPC_RMAP_INDEX;
+		do {
+			hp = (unsigned long *)(kvm->arch.hpt_virt + (i << 4));
+			j = rev[i].forw;
+			if (hp[1] & HPTE_R_R)
+				goto out;
+		} while ((i = j) != head);
+	}
+	ret = 0;
+
+ out:
+	unlock_rmap(rmapp);
+	return ret;
 }
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index bcf6f92..76864a8 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -641,6 +641,25 @@ void kvmppc_invalidate_hpte(struct kvm *kvm, unsigned long *hptep,
 }
 EXPORT_SYMBOL_GPL(kvmppc_invalidate_hpte);
 
+void kvmppc_clear_ref_hpte(struct kvm *kvm, unsigned long *hptep,
+			   unsigned long pte_index)
+{
+	unsigned long rb;
+	unsigned char rbyte;
+
+	rb = compute_tlbie_rb(hptep[0], hptep[1], pte_index);
+	rbyte = (hptep[1] & ~HPTE_R_R) >> 8;
+	/* modify only the second-last byte, which contains the ref bit */
+	*((char *)hptep + 14) = rbyte;
+	while (!try_lock_tlbie(&kvm->arch.tlbie_lock))
+		cpu_relax();
+	asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
+		     : : "r" (rb), "r" (kvm->arch.lpid));
+	asm volatile("ptesync" : : : "memory");
+	kvm->arch.tlbie_lock = 0;
+}
+EXPORT_SYMBOL_GPL(kvmppc_clear_ref_hpte);
+
 static int slb_base_page_shift[4] = {
 	24,	/* 16M */
 	16,	/* 64k */
-- 
1.7.7.3
