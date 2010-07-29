Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 83DFEB710B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 22:48:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 13/27] KVM: PPC: Magic Page Book3s support
Date: Thu, 29 Jul 2010 14:47:54 +0200
Message-Id: <1280407688-9815-14-git-send-email-agraf@suse.de>
In-Reply-To: <1280407688-9815-1-git-send-email-agraf@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to override EA as well as PA lookups for the magic page. When the guest
tells us to project it, the magic page overrides any guest mappings.

In order to reflect that, we need to hook into all the MMU layers of KVM to
force map the magic page if necessary.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v2 -> v3:

  - RMO -> PAM
  - combine 32 and 64 real page magic override
  - remove leftover goto point
  - align hypercalls to in/out of ePAPR
---
 arch/powerpc/include/asm/kvm_book3s.h |    1 +
 arch/powerpc/kvm/book3s.c             |   35 ++++++++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_32_mmu.c      |   16 +++++++++++++++
 arch/powerpc/kvm/book3s_32_mmu_host.c |    2 +-
 arch/powerpc/kvm/book3s_64_mmu.c      |   30 +++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_mmu_host.c |    9 +------
 6 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index b5b1961..00cf8b0 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -130,6 +130,7 @@ extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
 			   bool upper, u32 val);
 extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
 extern int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu);
+extern pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 
 extern u32 kvmppc_trampoline_lowmem;
 extern u32 kvmppc_trampoline_enter;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 0ed5376..eee97b5 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -419,6 +419,25 @@ void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr)
 	}
 }
 
+pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	ulong mp_pa = vcpu->arch.magic_page_pa;
+
+	/* Magic page override */
+	if (unlikely(mp_pa) &&
+	    unlikely(((gfn << PAGE_SHIFT) & KVM_PAM) ==
+		     ((mp_pa & PAGE_MASK) & KVM_PAM))) {
+		ulong shared_page = ((ulong)vcpu->arch.shared) & PAGE_MASK;
+		pfn_t pfn;
+
+		pfn = (pfn_t)virt_to_phys((void*)shared_page) >> PAGE_SHIFT;
+		get_page(pfn_to_page(pfn));
+		return pfn;
+	}
+
+	return gfn_to_pfn(vcpu->kvm, gfn);
+}
+
 /* Book3s_32 CPUs always have 32 bytes cache line size, which Linux assumes. To
  * make Book3s_32 Linux work on Book3s_64, we have to make sure we trap dcbz to
  * emulate 32 bytes dcbz length.
@@ -554,6 +573,13 @@ mmio:
 
 static int kvmppc_visible_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
+	ulong mp_pa = vcpu->arch.magic_page_pa;
+
+	if (unlikely(mp_pa) &&
+	    unlikely((mp_pa & KVM_PAM) >> PAGE_SHIFT == gfn)) {
+		return 1;
+	}
+
 	return kvm_is_visible_gfn(vcpu->kvm, gfn);
 }
 
@@ -1257,6 +1283,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	struct kvmppc_vcpu_book3s *vcpu_book3s;
 	struct kvm_vcpu *vcpu;
 	int err = -ENOMEM;
+	unsigned long p;
 
 	vcpu_book3s = vmalloc(sizeof(struct kvmppc_vcpu_book3s));
 	if (!vcpu_book3s)
@@ -1274,8 +1301,10 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	if (err)
 		goto free_shadow_vcpu;
 
-	vcpu->arch.shared = (void*)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	if (!vcpu->arch.shared)
+	p = __get_free_page(GFP_KERNEL|__GFP_ZERO);
+	/* the real shared page fills the last 4k of our page */
+	vcpu->arch.shared = (void*)(p + PAGE_SIZE - 4096);
+	if (!p)
 		goto uninit_vcpu;
 
 	vcpu->arch.host_retip = kvm_return_point;
@@ -1322,7 +1351,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
 
-	free_page((unsigned long)vcpu->arch.shared);
+	free_page((unsigned long)vcpu->arch.shared & PAGE_MASK);
 	kvm_vcpu_uninit(vcpu);
 	kfree(vcpu_book3s->shadow_vcpu);
 	vfree(vcpu_book3s);
diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index 449bce5..a7d121a 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -281,8 +281,24 @@ static int kvmppc_mmu_book3s_32_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 				      struct kvmppc_pte *pte, bool data)
 {
 	int r;
+	ulong mp_ea = vcpu->arch.magic_page_ea;
 
 	pte->eaddr = eaddr;
+
+	/* Magic page override */
+	if (unlikely(mp_ea) &&
+	    unlikely((eaddr & ~0xfffULL) == (mp_ea & ~0xfffULL)) &&
+	    !(vcpu->arch.shared->msr & MSR_PR)) {
+		pte->vpage = kvmppc_mmu_book3s_32_ea_to_vp(vcpu, eaddr, data);
+		pte->raddr = vcpu->arch.magic_page_pa | (pte->raddr & 0xfff);
+		pte->raddr &= KVM_PAM;
+		pte->may_execute = true;
+		pte->may_read = true;
+		pte->may_write = true;
+
+		return 0;
+	}
+
 	r = kvmppc_mmu_book3s_32_xlate_bat(vcpu, eaddr, pte, data);
 	if (r < 0)
 	       r = kvmppc_mmu_book3s_32_xlate_pte(vcpu, eaddr, pte, data, true);
diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 67b8c38..05e8c9e 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -147,7 +147,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 	struct hpte_cache *pte;
 
 	/* Get host physical address for gpa */
-	hpaddr = gfn_to_pfn(vcpu->kvm, orig_pte->raddr >> PAGE_SHIFT);
+	hpaddr = kvmppc_gfn_to_pfn(vcpu, orig_pte->raddr >> PAGE_SHIFT);
 	if (kvm_is_error_hva(hpaddr)) {
 		printk(KERN_INFO "Couldn't get guest page for gfn %lx!\n",
 				 orig_pte->eaddr);
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 58aa840..d7889ef 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -163,6 +163,22 @@ static int kvmppc_mmu_book3s_64_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	bool found = false;
 	bool perm_err = false;
 	int second = 0;
+	ulong mp_ea = vcpu->arch.magic_page_ea;
+
+	/* Magic page override */
+	if (unlikely(mp_ea) &&
+	    unlikely((eaddr & ~0xfffULL) == (mp_ea & ~0xfffULL)) &&
+	    !(vcpu->arch.shared->msr & MSR_PR)) {
+		gpte->eaddr = eaddr;
+		gpte->vpage = kvmppc_mmu_book3s_64_ea_to_vp(vcpu, eaddr, data);
+		gpte->raddr = vcpu->arch.magic_page_pa | (gpte->raddr & 0xfff);
+		gpte->raddr &= KVM_PAM;
+		gpte->may_execute = true;
+		gpte->may_read = true;
+		gpte->may_write = true;
+
+		return 0;
+	}
 
 	slbe = kvmppc_mmu_book3s_64_find_slbe(vcpu_book3s, eaddr);
 	if (!slbe)
@@ -445,6 +461,7 @@ static int kvmppc_mmu_book3s_64_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 	ulong ea = esid << SID_SHIFT;
 	struct kvmppc_slb *slb;
 	u64 gvsid = esid;
+	ulong mp_ea = vcpu->arch.magic_page_ea;
 
 	if (vcpu->arch.shared->msr & (MSR_DR|MSR_IR)) {
 		slb = kvmppc_mmu_book3s_64_find_slbe(to_book3s(vcpu), ea);
@@ -464,7 +481,7 @@ static int kvmppc_mmu_book3s_64_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 		break;
 	case MSR_DR|MSR_IR:
 		if (!slb)
-			return -ENOENT;
+			goto no_slb;
 
 		*vsid = gvsid;
 		break;
@@ -477,6 +494,17 @@ static int kvmppc_mmu_book3s_64_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 		*vsid |= VSID_PR;
 
 	return 0;
+
+no_slb:
+	/* Catch magic page case */
+	if (unlikely(mp_ea) &&
+	    unlikely(esid == (mp_ea >> SID_SHIFT)) &&
+	    !(vcpu->arch.shared->msr & MSR_PR)) {
+		*vsid = VSID_REAL | esid;
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static bool kvmppc_mmu_book3s_64_is_dcbz32(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 71c1f90..6cdd19a 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -101,18 +101,13 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 	struct kvmppc_sid_map *map;
 
 	/* Get host physical address for gpa */
-	hpaddr = gfn_to_pfn(vcpu->kvm, orig_pte->raddr >> PAGE_SHIFT);
+	hpaddr = kvmppc_gfn_to_pfn(vcpu, orig_pte->raddr >> PAGE_SHIFT);
 	if (kvm_is_error_hva(hpaddr)) {
 		printk(KERN_INFO "Couldn't get guest page for gfn %lx!\n", orig_pte->eaddr);
 		return -EINVAL;
 	}
 	hpaddr <<= PAGE_SHIFT;
-#if PAGE_SHIFT == 12
-#elif PAGE_SHIFT == 16
-	hpaddr |= orig_pte->raddr & 0xf000;
-#else
-#error Unknown page size
-#endif
+	hpaddr |= orig_pte->raddr & (~0xfffULL & ~PAGE_MASK);
 
 	/* and write the mapping ea -> hpa into the pt */
 	vcpu->arch.mmu.esid_to_vsid(vcpu, orig_pte->eaddr >> SID_SHIFT, &vsid);
-- 
1.6.0.2
