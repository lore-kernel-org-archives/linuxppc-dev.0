Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 10:02:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [RFC PATCH 07/11] KVM: PPC: Convert do_h_register_vpa to use Linux
 page tables
Message-ID: <20111116230206.GH26985@bloggs.ozlabs.ibm.com>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes do_h_register_vpa use a new helper function,
kvmppc_pin_guest_page, to pin the page containing the virtual
processor area that the guest wants to register.  The logic of
whether to use the userspace Linux page tables or the slot_pfns
array is thus hidden in kvmppc_pin_guest_page.  There is also a
new kvmppc_unpin_guest_page to release a previously-pinned page,
which we call at VPA unregistration time, or when a new VPA is
registered, or when the vcpu is destroyed.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h |    3 ++
 arch/powerpc/kvm/book3s_64_mmu_hv.c   |   44 +++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c          |   52 ++++++++++++++++++++++----------
 3 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index bd8345f..b5ee1ce 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -141,6 +141,9 @@ extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
 extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
 extern int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu);
 extern pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+extern void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long addr,
+			unsigned long *nb_ret);
+extern void kvmppc_unpin_guest_page(struct kvm *kvm, void *addr);
 
 extern void kvmppc_entry_trampoline(void);
 extern void kvmppc_hv_entry_trampoline(void);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 99187db..9c7e825 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -480,6 +480,50 @@ int kvmppc_book3s_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	return kvmppc_emulate_mmio(run, vcpu);
 }
 
+void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long gpa,
+			    unsigned long *nb_ret)
+{
+	struct kvm_memory_slot *memslot;
+	unsigned long gfn = gpa >> PAGE_SHIFT;
+	struct page *pages[1];
+	int npages;
+	unsigned long hva, psize, offset;
+	unsigned long pfn;
+	unsigned long *pfnp;
+
+	memslot = gfn_to_memslot(kvm, gfn);
+	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID) ||
+	    (memslot->flags & KVM_MEMSLOT_IO))
+		return NULL;
+	pfnp = kvmppc_pfn_entry(kvm, memslot, gfn);
+	if (pfnp) {
+		pfn = *pfnp;
+		if (!pfn)
+			return NULL;
+		psize = 1ul << kvm->arch.slot_page_order[memslot->id];
+		pages[0] = pfn_to_page(pfn);
+		get_page(pages[0]);
+	} else {
+		hva = gfn_to_hva_memslot(memslot, gfn);
+		npages = get_user_pages_fast(hva, 1, 1, pages);
+		if (npages < 1)
+			return NULL;
+		psize = PAGE_SIZE;
+	}
+	offset = gpa & (psize - 1);
+	if (nb_ret)
+		*nb_ret = psize - offset;
+	return page_address(pages[0]) + offset;
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
index cb21845..ceb49d2 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -163,10 +163,10 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 				       unsigned long vcpuid, unsigned long vpa)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long ra, len;
-	unsigned long nb;
+	unsigned long len, nb;
 	void *va;
 	struct kvm_vcpu *tvcpu;
+	int err = H_PARAMETER;
 
 	tvcpu = kvmppc_find_vcpu(kvm, vcpuid);
 	if (!tvcpu)
@@ -179,40 +179,41 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 	if (flags < 4) {
 		if (vpa & 0x7f)
 			return H_PARAMETER;
+		if (flags >= 2 && !tvcpu->arch.vpa)
+			return H_RESOURCE;
 		/* registering new area; convert logical addr to real */
-		ra = kvmppc_logical_to_real(kvm, vpa, &nb);
-		if (!ra)
+		va = kvmppc_pin_guest_page(kvm, vpa, &nb);
+		if (va == NULL)
 			return H_PARAMETER;
-		va = __va(ra);
 		if (flags <= 1)
 			len = *(unsigned short *)(va + 4);
 		else
 			len = *(unsigned int *)(va + 4);
 		if (len > nb)
-			return H_PARAMETER;
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
@@ -221,17 +222,30 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
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
@@ -488,6 +502,12 @@ out:
 
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
1.7.7.2
