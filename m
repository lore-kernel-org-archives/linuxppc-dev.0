Return-Path: <paulus@ozlabs.org>
Date: Tue, 13 Dec 2011 09:28:55 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH v3 05/14] KVM: PPC: Add an interface for pinning guest pages
 in Book3s HV guests
Message-ID: <20111212222855.GF18868@bloggs.ozlabs.ibm.com>
References: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds two new functions, kvmppc_pin_guest_page() and
kvmppc_unpin_guest_page(), and uses them to pin the guest pages where
the guest has registered areas of memory for the hypervisor to update,
(i.e. the per-cpu virtual processor areas, SLB shadow buffers and
dispatch trace logs) and then unpin them when they are no longer
required.

Although it is not strictly necessary to pin the pages at this point,
since all guest pages are already pinned, later commits in this series
will mean that guest pages aren't all pinned.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h |    3 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c   |   38 ++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c          |   67 ++++++++++++++++++---------------
 3 files changed, 78 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index e8c78ac..a2a89c6 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -140,6 +140,9 @@ extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
 extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
 extern int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu);
 extern pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+extern void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long addr,
+			unsigned long *nb_ret);
+extern void kvmppc_unpin_guest_page(struct kvm *kvm, void *addr);
 
 extern void kvmppc_entry_trampoline(void);
 extern void kvmppc_hv_entry_trampoline(void);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index e4c6069..dcd39dc 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -184,6 +184,44 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	return -ENOENT;
 }
 
+void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long gpa,
+			    unsigned long *nb_ret)
+{
+	struct kvm_memory_slot *memslot;
+	unsigned long gfn = gpa >> PAGE_SHIFT;
+	struct page *page;
+	unsigned long offset;
+	unsigned long pfn, pa;
+	unsigned long *physp;
+
+	memslot = gfn_to_memslot(kvm, gfn);
+	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
+		return NULL;
+	physp = kvm->arch.slot_phys[memslot->id];
+	if (!physp)
+		return NULL;
+	physp += (gfn - memslot->base_gfn) >>
+		(kvm->arch.ram_porder - PAGE_SHIFT);
+	pa = *physp;
+	if (!pa)
+		return NULL;
+	pfn = pa >> PAGE_SHIFT;
+	page = pfn_to_page(pfn);
+	get_page(page);
+	offset = gpa & (kvm->arch.ram_psize - 1);
+	if (nb_ret)
+		*nb_ret = kvm->arch.ram_psize - offset;
+	return page_address(page) + offset;
+}
+
+void kvmppc_unpin_guest_page(struct kvm *kvm, void *va)
+{
+	struct page *page = virt_to_page(va);
+
+	page = compound_head(page);
+	put_page(page);
+}
+
 void kvmppc_mmu_book3s_hv_init(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_mmu *mmu = &vcpu->arch.mmu;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 86d3e4b..bd82789 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -139,12 +139,10 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 				       unsigned long vcpuid, unsigned long vpa)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long gfn, pg_index, ra, len;
-	unsigned long pg_offset;
+	unsigned long len, nb;
 	void *va;
 	struct kvm_vcpu *tvcpu;
-	struct kvm_memory_slot *memslot;
-	unsigned long *physp;
+	int err = H_PARAMETER;
 
 	tvcpu = kvmppc_find_vcpu(kvm, vcpuid);
 	if (!tvcpu)
@@ -157,51 +155,41 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 	if (flags < 4) {
 		if (vpa & 0x7f)
 			return H_PARAMETER;
+		if (flags >= 2 && !tvcpu->arch.vpa)
+			return H_RESOURCE;
 		/* registering new area; convert logical addr to real */
-		gfn = vpa >> PAGE_SHIFT;
-		memslot = gfn_to_memslot(kvm, gfn);
-		if (!memslot || !(memslot->flags & KVM_MEMSLOT_INVALID))
-			return H_PARAMETER;
-		physp = kvm->arch.slot_phys[memslot->id];
-		if (!physp)
-			return H_PARAMETER;
-		pg_index = (gfn - memslot->base_gfn) >>
-			(kvm->arch.ram_porder - PAGE_SHIFT);
-		pg_offset = vpa & (kvm->arch.ram_psize - 1);
-		ra = physp[pg_index];
-		if (!ra)
+		va = kvmppc_pin_guest_page(kvm, vpa, &nb);
+		if (va == NULL)
 			return H_PARAMETER;
-		ra = (ra & PAGE_MASK) | pg_offset;
-		va = __va(ra);
 		if (flags <= 1)
 			len = *(unsigned short *)(va + 4);
 		else
 			len = *(unsigned int *)(va + 4);
-		if (pg_offset + len > kvm->arch.ram_psize)
-			return H_PARAMETER;
+		if (len > nb)
+			goto out_unpin;
 		switch (flags) {
 		case 1:		/* register VPA */
 			if (len < 640)
-				return H_PARAMETER;
+				goto out_unpin;
+			if (tvcpu->arch.vpa)
+				kvmppc_unpin_guest_page(kvm, vcpu->arch.vpa);
 			tvcpu->arch.vpa = va;
 			init_vpa(vcpu, va);
 			break;
 		case 2:		/* register DTL */
 			if (len < 48)
-				return H_PARAMETER;
-			if (!tvcpu->arch.vpa)
-				return H_RESOURCE;
+				goto out_unpin;
 			len -= len % 48;
+			if (tvcpu->arch.dtl)
+				kvmppc_unpin_guest_page(kvm, vcpu->arch.dtl);
 			tvcpu->arch.dtl = va;
 			tvcpu->arch.dtl_end = va + len;
 			break;
 		case 3:		/* register SLB shadow buffer */
-			if (len < 8)
-				return H_PARAMETER;
-			if (!tvcpu->arch.vpa)
-				return H_RESOURCE;
-			tvcpu->arch.slb_shadow = va;
-			len = (len - 16) / 16;
+			if (len < 16)
+				goto out_unpin;
+			if (tvcpu->arch.slb_shadow)
+				kvmppc_unpin_guest_page(kvm, vcpu->arch.slb_shadow);
 			tvcpu->arch.slb_shadow = va;
 			break;
 		}
@@ -210,17 +198,30 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 		case 5:		/* unregister VPA */
 			if (tvcpu->arch.slb_shadow || tvcpu->arch.dtl)
 				return H_RESOURCE;
+			if (!tvcpu->arch.vpa)
+				break;
+			kvmppc_unpin_guest_page(kvm, tvcpu->arch.vpa);
 			tvcpu->arch.vpa = NULL;
 			break;
 		case 6:		/* unregister DTL */
+			if (!tvcpu->arch.dtl)
+				break;
+			kvmppc_unpin_guest_page(kvm, tvcpu->arch.dtl);
 			tvcpu->arch.dtl = NULL;
 			break;
 		case 7:		/* unregister SLB shadow buffer */
+			if (!tvcpu->arch.slb_shadow)
+				break;
+			kvmppc_unpin_guest_page(kvm, tvcpu->arch.slb_shadow);
 			tvcpu->arch.slb_shadow = NULL;
 			break;
 		}
 	}
 	return H_SUCCESS;
+
+ out_unpin:
+	kvmppc_unpin_guest_page(kvm, va);
+	return err;
 }
 
 int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
@@ -503,6 +504,12 @@ out:
 
 void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 {
+	if (vcpu->arch.dtl)
+		kvmppc_unpin_guest_page(vcpu->kvm, vcpu->arch.dtl);
+	if (vcpu->arch.slb_shadow)
+		kvmppc_unpin_guest_page(vcpu->kvm, vcpu->arch.slb_shadow);
+	if (vcpu->arch.vpa)
+		kvmppc_unpin_guest_page(vcpu->kvm, vcpu->arch.vpa);
 	kvm_vcpu_uninit(vcpu);
 	kfree(vcpu);
 }
-- 
1.7.7.3
