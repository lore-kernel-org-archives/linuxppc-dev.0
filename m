Return-Path: <paulus@ozlabs.org>
Date: Thu, 15 Dec 2011 23:03:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 4/5] KVM: PPC: Book3s HV: Implement get_dirty_log using
 hardware changed bit
Message-ID: <20111215120322.GE20629@bloggs.ozlabs.ibm.com>
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

This changes the implementation of kvm_vm_ioctl_get_dirty_log() for
Book3s HV guests to use the hardware C (changed) bits in the guest
hashed page table.  Since this makes the implementation quite different
from the Book3s PR case, this moves the existing implementation from
book3s.c to book3s_pr.c and creates a new implementation in book3s_hv.c.
That implementation calls kvmppc_hv_get_dirty_log() to do the actual
work by calling kvm_test_clear_dirty on each page.  It iterates over
the HPTEs, clearing the C bit if set, and returns 1 if any C bit was
set (including the saved C bit in the rmap entry).

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h |    2 +
 arch/powerpc/kvm/book3s.c             |   39 ------------------
 arch/powerpc/kvm/book3s_64_mmu_hv.c   |   69 +++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c          |   37 +++++++++++++++++
 arch/powerpc/kvm/book3s_pr.c          |   39 ++++++++++++++++++
 5 files changed, 147 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 6ececb4..aa795cc 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -158,6 +158,8 @@ extern long kvmppc_virtmode_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			long pte_index, unsigned long pteh, unsigned long ptel);
 extern long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			long pte_index, unsigned long pteh, unsigned long ptel);
+extern long kvmppc_hv_get_dirty_log(struct kvm *kvm,
+			struct kvm_memory_slot *memslot);
 
 extern void kvmppc_entry_trampoline(void);
 extern void kvmppc_hv_entry_trampoline(void);
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 6bf7e05..7d54f4e 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -477,45 +477,6 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-/*
- * Get (and clear) the dirty memory log for a memory slot.
- */
-int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
-				      struct kvm_dirty_log *log)
-{
-	struct kvm_memory_slot *memslot;
-	struct kvm_vcpu *vcpu;
-	ulong ga, ga_end;
-	int is_dirty = 0;
-	int r;
-	unsigned long n;
-
-	mutex_lock(&kvm->slots_lock);
-
-	r = kvm_get_dirty_log(kvm, log, &is_dirty);
-	if (r)
-		goto out;
-
-	/* If nothing is dirty, don't bother messing with page tables. */
-	if (is_dirty) {
-		memslot = id_to_memslot(kvm->memslots, log->slot);
-
-		ga = memslot->base_gfn << PAGE_SHIFT;
-		ga_end = ga + (memslot->npages << PAGE_SHIFT);
-
-		kvm_for_each_vcpu(n, vcpu, kvm)
-			kvmppc_mmu_pte_pflush(vcpu, ga, ga_end);
-
-		n = kvm_dirty_bitmap_bytes(memslot);
-		memset(memslot->dirty_bitmap, 0, n);
-	}
-
-	r = 0;
-out:
-	mutex_unlock(&kvm->slots_lock);
-	return r;
-}
-
 void kvmppc_decrementer_func(unsigned long data)
 {
 	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)data;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 926e2b9..783cd35 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -870,6 +870,75 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 	kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
 }
 
+static int kvm_test_clear_dirty(struct kvm *kvm, unsigned long *rmapp)
+{
+	struct revmap_entry *rev = kvm->arch.revmap;
+	unsigned long head, i, j;
+	unsigned long *hptep;
+	int ret = 0;
+
+ retry:
+	lock_rmap(rmapp);
+	if (*rmapp & KVMPPC_RMAP_CHANGED) {
+		*rmapp &= ~KVMPPC_RMAP_CHANGED;
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
+		if (!(hptep[1] & HPTE_R_C))
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
+		if ((hptep[0] & HPTE_V_VALID) && (hptep[1] & HPTE_R_C)) {
+			/* need to make it temporarily absent to clear C */
+			hptep[0] |= HPTE_V_ABSENT;
+			kvmppc_invalidate_hpte(kvm, hptep, i);
+			hptep[1] &= ~HPTE_R_C;
+			eieio();
+			hptep[0] = (hptep[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
+			rev[i].guest_rpte |= HPTE_R_C;
+			ret = 1;
+		}
+		hptep[0] &= ~HPTE_V_HVLOCK;
+	} while ((i = j) != head);
+
+	unlock_rmap(rmapp);
+	return ret;
+}
+
+long kvmppc_hv_get_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
+{
+	unsigned long i;
+	unsigned long *rmapp, *map;
+
+	preempt_disable();
+	rmapp = memslot->rmap;
+	map = memslot->dirty_bitmap;
+	for (i = 0; i < memslot->npages; ++i) {
+		if (kvm_test_clear_dirty(kvm, rmapp))
+			__set_bit_le(i, map);
+		++rmapp;
+	}
+	preempt_enable();
+	return 0;
+}
+
 void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long gpa,
 			    unsigned long *nb_ret)
 {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index cb8e15f..c11d960 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1105,6 +1105,43 @@ long kvm_vm_ioctl_allocate_rma(struct kvm *kvm, struct kvm_allocate_rma *ret)
 	return fd;
 }
 
+/*
+ * Get (and clear) the dirty memory log for a memory slot.
+ */
+int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
+{
+	struct kvm_memory_slot *memslot;
+	int r;
+	unsigned long n;
+
+	mutex_lock(&kvm->slots_lock);
+
+	r = -EINVAL;
+	if (log->slot >= KVM_MEMORY_SLOTS)
+		goto out;
+
+	memslot = id_to_memslot(kvm->memslots, log->slot);
+	r = -ENOENT;
+	if (!memslot->dirty_bitmap)
+		goto out;
+
+	n = kvm_dirty_bitmap_bytes(memslot);
+	memset(memslot->dirty_bitmap, 0, n);
+
+	r = kvmppc_hv_get_dirty_log(kvm, memslot);
+	if (r)
+		goto out;
+
+	r = -EFAULT;
+	if (copy_to_user(log->dirty_bitmap, memslot->dirty_bitmap, n))
+		goto out;
+
+	r = 0;
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+}
+
 static unsigned long slb_pgsize_encoding(unsigned long psize)
 {
 	unsigned long senc = 0;
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index ddd92a5..dfb52dc 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1069,6 +1069,45 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+/*
+ * Get (and clear) the dirty memory log for a memory slot.
+ */
+int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
+				      struct kvm_dirty_log *log)
+{
+	struct kvm_memory_slot *memslot;
+	struct kvm_vcpu *vcpu;
+	ulong ga, ga_end;
+	int is_dirty = 0;
+	int r;
+	unsigned long n;
+
+	mutex_lock(&kvm->slots_lock);
+
+	r = kvm_get_dirty_log(kvm, log, &is_dirty);
+	if (r)
+		goto out;
+
+	/* If nothing is dirty, don't bother messing with page tables. */
+	if (is_dirty) {
+		memslot = id_to_memslot(kvm->memslots, log->slot);
+
+		ga = memslot->base_gfn << PAGE_SHIFT;
+		ga_end = ga + (memslot->npages << PAGE_SHIFT);
+
+		kvm_for_each_vcpu(n, vcpu, kvm)
+			kvmppc_mmu_pte_pflush(vcpu, ga, ga_end);
+
+		n = kvm_dirty_bitmap_bytes(memslot);
+		memset(memslot->dirty_bitmap, 0, n);
+	}
+
+	r = 0;
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+}
+
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				      struct kvm_userspace_memory_region *mem)
 {
-- 
1.7.7.3
