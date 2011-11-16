Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 10:50:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [RFC PATCH 08/11] KVM: PPC: Add a page fault handler function
Message-ID: <20111116235054.GI26985@bloggs.ozlabs.ibm.com>
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

This adds a kvmppc_book3s_hv_page_fault function that is capable of
handling the fault we get if the guest tries to access a non-present
page (one that we have marked with storage key 31 and no-execute),
and either doing MMIO emulation, or making the page resident and
rewriting the guest HPTE to point to it, if it is RAM.

We now call this for hypervisor instruction storage interrupts, and
for hypervisor data storage interrupts instead of the emulate-MMIO
function.  It can now be called for real-mode accesses through the
VRMA as well as virtual-mode accesses.

In order to identify non-present HPTEs, we use a second software-use
bit in the first dword of the HPTE, called HPTE_V_ABSENT.  We can't
just look for storage key 31 because non-present HPTEs for the VRMA
have to be actually invalid, as the storage key mechanism doesn't
operate in real mode.  Using this bit also means that we don't have
to restrict the guest from using key 31 any more.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h    |    6 +-
 arch/powerpc/include/asm/kvm_book3s_64.h |   11 ++-
 arch/powerpc/include/asm/kvm_host.h      |   30 ++--
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  259 +++++++++++++++++++++++-------
 arch/powerpc/kvm/book3s_hv.c             |   54 ++++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  121 ++++++++------
 6 files changed, 340 insertions(+), 141 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index b5ee1ce..ac48438 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -121,7 +121,9 @@ extern void kvmppc_mmu_book3s_hv_init(struct kvm_vcpu *vcpu);
 extern int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte);
 extern int kvmppc_mmu_map_segment(struct kvm_vcpu *vcpu, ulong eaddr);
 extern void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu);
-extern int kvmppc_book3s_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu);
+extern int kvmppc_book3s_hv_page_fault(struct kvm_run *run,
+			struct kvm_vcpu *vcpu, unsigned long addr,
+			unsigned long status);
 
 extern void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte);
 extern struct hpte_cache *kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu);
@@ -141,6 +143,8 @@ extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
 extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
 extern int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu);
 extern pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+extern void kvmppc_modify_hpte(struct kvm *kvm, unsigned long *hptep,
+			unsigned long new_hpte[2], unsigned long pte_index);
 extern void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long addr,
 			unsigned long *nb_ret);
 extern void kvmppc_unpin_guest_page(struct kvm *kvm, void *addr);
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 307e649..3745337 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -37,6 +37,8 @@ static inline struct kvmppc_book3s_shadow_vcpu *to_svcpu(struct kvm_vcpu *vcpu)
 #define HPT_HASH_MASK	(HPT_NPTEG - 1)
 #endif
 
+#define VRMA_VSID	0x1ffffffUL	/* 1TB VSID reserved for VRMA */
+
 static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 					     unsigned long pte_index)
 {
@@ -72,9 +74,11 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 
 /*
  * We use a lock bit in HPTE dword 0 to synchronize updates and
- * accesses to each HPTE.
+ * accesses to each HPTE, and another bit to indicate non-present
+ * HPTEs.
  */
 #define HPTE_V_HVLOCK	0x40UL
+#define HPTE_V_ABSENT	0x20UL
 
 static inline long try_lock_hpte(unsigned long *hpte, unsigned long bits)
 {
@@ -106,6 +110,11 @@ static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
 	return 0;				/* error */
 }
 
+static inline unsigned long hpte_rpn(unsigned long ptel, unsigned long psize)
+{
+	return ((ptel & HPTE_R_RPN) & ~(psize - 1)) >> PAGE_SHIFT;
+}
+
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 static inline unsigned long *kvmppc_pfn_entry(struct kvm *kvm,
 			struct kvm_memory_slot *memslot, unsigned long gfn)
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index f211643..ababf17 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -162,6 +162,20 @@ struct kvmppc_rma_info {
 	atomic_t 	 use_count;
 };
 
+struct kvmppc_slb {
+	u64 esid;
+	u64 vsid;
+	u64 orige;
+	u64 origv;
+	bool valid	: 1;
+	bool Ks		: 1;
+	bool Kp		: 1;
+	bool nx		: 1;
+	bool large	: 1;	/* PTEs are 16MB */
+	bool tb		: 1;	/* 1TB segment */
+	bool class	: 1;
+};
+
 /*
  * The reverse mapping array has one entry for each HPTE,
  * which stores the guest's view of the second word of the HPTE
@@ -184,6 +198,8 @@ struct kvm_arch {
 	unsigned long lpcr;
 	unsigned long rmor;
 	struct kvmppc_rma_info *rma;
+	struct kvmppc_slb vrma_slb;
+	unsigned long vrma_pgorder;
 	struct list_head spapr_tce_tables;
 	unsigned long *slot_pfns[KVM_MEMORY_SLOTS + KVM_PRIVATE_MEM_SLOTS];
 	int slot_page_order[KVM_MEMORY_SLOTS + KVM_PRIVATE_MEM_SLOTS];
@@ -251,20 +267,6 @@ struct kvmppc_mmu {
 	bool (*is_dcbz32)(struct kvm_vcpu *vcpu);
 };
 
-struct kvmppc_slb {
-	u64 esid;
-	u64 vsid;
-	u64 orige;
-	u64 origv;
-	bool valid	: 1;
-	bool Ks		: 1;
-	bool Kp		: 1;
-	bool nx		: 1;
-	bool large	: 1;	/* PTEs are 16MB */
-	bool tb		: 1;	/* 1TB segment */
-	bool class	: 1;
-};
-
 struct kvm_vcpu_arch {
 	ulong host_stack;
 	u32 host_pid;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 9c7e825..32c7d8c 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -34,8 +34,6 @@
 #include <asm/ppc-opcode.h>
 #include <asm/cputable.h>
 
-#define VRMA_VSID	0x1ffffffUL	/* 1TB VSID reserved for VRMA */
-
 /* POWER7 has 10-bit LPIDs, PPC970 has 6-bit LPIDs */
 #define MAX_LPID_970	63
 #define NR_LPIDS	(LPID_RSVD + 1)
@@ -125,6 +123,7 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 	pfns = kvm->arch.slot_pfns[mem->slot];
 	porder = kvm->arch.slot_page_order[mem->slot];
 	psize = 1ul << porder;
+	kvm->arch.vrma_pgorder = porder;
 	npages = memslot->npages >> (porder - PAGE_SHIFT);
 
 	/* VRMA can't be > 1TB */
@@ -135,7 +134,7 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 		npages = HPT_NPTEG;
 
 	hp0 = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
-		HPTE_V_BOLTED | hpte0_pgsize_encoding(psize) | HPTE_V_VALID;
+		HPTE_V_BOLTED | hpte0_pgsize_encoding(psize);
 	hp1 = hpte1_pgsize_encoding(psize) |
 		HPTE_R_R | HPTE_R_C | HPTE_R_M | PP_RWXX;
 
@@ -154,7 +153,7 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 			local_irq_enable();
 		}
 
-		if (!pfn) {
+		if (!pfn && !cpu_has_feature(CPU_FTR_ARCH_206)) {
 			pr_err("KVM: Couldn't find page for VRMA at %lx\n",
 			       addr);
 			break;
@@ -174,7 +173,8 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 		hpte[1] = hp1 | (pfn << PAGE_SHIFT);
 		smp_wmb();
 		/* HPTE high word - virtual address, bolted, valid, large */
-		hpte[0] = hp0 | ((addr >> 16) & ~0x7fUL);
+		hpte[0] = hp0 | ((addr >> 16) & ~0x7fUL) |
+			(pfn ? HPTE_V_VALID : HPTE_V_ABSENT);
 
 		/* Reverse map info */
 		rev = &kvm->arch.revmap[hash];
@@ -216,10 +216,16 @@ static void kvmppc_mmu_book3s_64_hv_reset_msr(struct kvm_vcpu *vcpu)
 }
 
 static struct kvmppc_slb *kvmppc_mmu_book3s_hv_find_slbe(struct kvm_vcpu *vcpu,
-							 gva_t eaddr)
+							 gva_t eaddr, bool data)
 {
 	u64 mask;
 	int i;
+	unsigned long xr;
+
+	xr = data ? MSR_DR : MSR_IR;
+	if (!(vcpu->arch.shregs.msr & xr))
+		/* real mode access, assume VRMA */
+		return &vcpu->kvm->arch.vrma_slb;
 
 	for (i = 0; i < vcpu->arch.slb_nr; i++) {
 		if (!(vcpu->arch.slb[i].orige & SLB_ESID_V))
@@ -377,7 +383,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	int index;
 
 	/* Get SLB entry */
-	slbe = kvmppc_mmu_book3s_hv_find_slbe(vcpu, eaddr);
+	slbe = kvmppc_mmu_book3s_hv_find_slbe(vcpu, eaddr, data);
 	if (!slbe)
 		return -EINVAL;
 
@@ -402,58 +408,14 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	return 0;
 }
 
-int kvmppc_book3s_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
+static int kvmppc_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				  unsigned long gpa)
 {
-	struct kvm *kvm = vcpu->kvm;
-	struct kvmppc_slb *slbe;
-	unsigned long hpte[3];
+	int ret;
+	u32 last_inst;
 	unsigned long srr0 = kvmppc_get_pc(vcpu);
-	unsigned long ea = vcpu->arch.fault_dar;	
-	unsigned long gpa;
-	unsigned int pp, ok;
-	u32 last_inst, dsisr = vcpu->arch.fault_dsisr;
-	int index, ret = 0;
-
-	/*
-	 * Translate the access address.
-	 * If we can't find the HPTE, just return and re-execute the
-	 * instruction.
- 	 */
-	slbe = kvmppc_mmu_book3s_hv_find_slbe(vcpu, ea);
-	if (!slbe)
-		return RESUME_GUEST;
-	index = kvmppc_hv_find_hpte(kvm, ea, slbe, hpte);
-	if (index < 0)
-		return RESUME_GUEST;
-
-	/*
-	 * Check if this is a special HPTE (storage key = 31); if not then
-	 * this is just a key fault in the guest.
-	 */
-	if ((hpte[1] & (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) !=
-	    (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) {
-		vcpu->arch.shregs.dsisr = dsisr;
-		vcpu->arch.shregs.dar = ea;
-		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_DATA_STORAGE, 0);
-		return RESUME_GUEST;
-	}
-
-	/* Check whether the attempted access was permitted */
-	pp = kvmppc_mmu_get_pp_value(vcpu, slbe, hpte[1]);
-	ok = (dsisr & DSISR_ISSTORE) ? pp_write_perm[pp] : pp_read_perm[pp];
-	if (!ok) {
-		vcpu->arch.shregs.dar = ea;
-		vcpu->arch.shregs.dsisr = (dsisr & DSISR_ISSTORE) |
-			DSISR_PROTFAULT;
-		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_DATA_STORAGE, 0);
-		return RESUME_GUEST;
-	}
 
-	/* Translate the logical address */
-	gpa = kvmppc_mmu_get_real_addr(hpte[0], hpte[2], ea);
-
-	/*
-	 * We try to load the last instruction.  We don't let
+	/* We try to load the last instruction.  We don't let
 	 * emulate_instruction do it as its failure mode is pretty bogus.
 	 * If we fail, we just return to the guest and try executing it again.
 	 */
@@ -475,11 +437,196 @@ int kvmppc_book3s_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	 * so right now we just do it badly and racily, but that will need
 	 * fixing
 	 */
+	/*
+	 * Emulated accesses are emulated by looking at the hash for
+	 * translation once, then performing the access later. The
+	 * translation could be invalidated in the meantime in which
+	 * point performing the subsequent memory access on the old
+	 * physical address is a violation of the architecture and
+	 * a security hole.
+	 *
+	 * This is less of an issue for MMIO stores since they aren't
+	 * globally visible. It could be an issue for MMIO loads to
+	 * a certain extent but we'll ignore it for now
+	 */
 
 	vcpu->arch.paddr_accessed = gpa;
 	return kvmppc_emulate_mmio(run, vcpu);
 }
 
+/*
+ * Look for a VRMA hash entry.  This only looks in the last slot of
+ * the primary PTEG, and accepts VRMA entries that are absent and invalid.
+ */
+static int kvmppc_hv_find_vrma(struct kvm *kvm, unsigned long addr,
+			       unsigned long hpte[3])
+{
+	unsigned long v, r, gr;
+	unsigned long i, hash;
+	unsigned long *hp;
+	unsigned long mask, val;
+	unsigned long porder, psize;
+
+	porder = kvm->arch.vrma_pgorder;
+	psize = 1ul << porder;
+	i = addr >> porder;
+	addr &= ~(psize - 1);
+	hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & HPT_HASH_MASK;
+	hash = (hash << 3) + 7;
+	hp = (unsigned long *) (kvm->arch.hpt_virt + (hash << 4));
+	mask = SLB_VSID_B | HPTE_V_AVPN | HPTE_V_SECONDARY | HPTE_V_LARGE;
+	val = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
+		((addr >> 16) & ~0x7fUL) | hpte0_pgsize_encoding(psize);
+	if ((hp[0] & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
+	    (hp[0] & mask) != val)
+		return -1;
+	while (!try_lock_hpte(hp, HPTE_V_HVLOCK))
+		cpu_relax();
+	v = hp[0] & ~HPTE_V_HVLOCK;
+	r = hp[1];
+	gr = kvm->arch.revmap[hash].guest_rpte;
+	smp_wmb();
+	hp[0] = v;	/* unlock */
+	if ((v & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 || (v & mask) != val)
+		return -1;
+	hpte[0] = v;
+	hpte[1] = r;
+	hpte[2] = gr;
+	return hash;
+}
+
+int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				unsigned long ea, unsigned long dsisr)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvmppc_slb *slbe;
+	unsigned long *hptep, hpte[3];
+	unsigned long psize, pte_size;
+	unsigned long gfn, hva, pfn, amr;
+	struct kvm_memory_slot *memslot;
+	struct revmap_entry *rev;
+	struct page *page, *pages[1];
+	unsigned int pp, ok;
+	int index, ret, skey, npages;
+	bool data = vcpu->arch.trap == BOOK3S_INTERRUPT_H_DATA_STORAGE;
+	bool realmode = !(vcpu->arch.shregs.msr & (data ? MSR_DR : MSR_IR));
+
+	/*
+	 * Translate the access address.
+	 * If we can't find the HPTE, just return and re-execute the
+	 * instruction.
+ 	 */
+	slbe = kvmppc_mmu_book3s_hv_find_slbe(vcpu, ea, data);
+	if (!slbe)
+		return RESUME_GUEST;
+	index = kvmppc_hv_find_hpte(kvm, ea, slbe, hpte);
+	/* if not found and real mode, look for an absent VRMA entry */
+	if (index < 0) {
+		if (!realmode)
+			return RESUME_GUEST;
+		index = kvmppc_hv_find_vrma(kvm, ea, hpte);
+		if (index < 0)
+			goto pass_to_guest;
+	}
+
+	/*
+	 * Check if this is a special HPTE (HPTE_V_ABSENT set); if not then
+	 * this is just a key fault or no-execute fault in the guest.
+	 * It could be that this was a special HPTE at the time of the
+	 * fault, but it has subsequently been turned into a normal HPTE
+	 * by another CPU, so check if the access should have been allowed.
+	 * If it should, just retry.
+	 */
+	if (!(hpte[0] & HPTE_V_ABSENT) && !realmode && data) {
+		skey = ((hpte[1] & HPTE_R_KEY_HI) >> 57) |
+			((hpte[1] & HPTE_R_KEY_LO) >> 9);
+		amr = vcpu->arch.amr << (2 * skey);
+		if (!(dsisr & DSISR_ISSTORE))
+			amr <<= 1;
+		if (amr & (1ul << 63))
+			goto pass_to_guest;
+	}
+
+	/* Check whether the attempted access was permitted */
+	pp = kvmppc_mmu_get_pp_value(vcpu, slbe, hpte[1]);
+	if (data) {
+		ok = (dsisr & DSISR_ISSTORE) ? pp_write_perm[pp] :
+			pp_read_perm[pp];
+		dsisr = (dsisr & DSISR_ISSTORE) | DSISR_PROTFAULT;
+	} else {
+		ok = pp_read_perm[pp] && (hpte[2] & (HPTE_R_N | HPTE_R_G)) == 0;
+	}
+	if (!ok)
+		goto pass_to_guest;
+	if (!(hpte[0] & HPTE_V_ABSENT))
+		return RESUME_GUEST;
+
+	/* Translate the logical address and get the page */
+	psize = hpte_page_size(hpte[0], hpte[1]);
+	gfn = hpte_rpn(hpte[2], psize);
+	memslot = gfn_to_memslot(kvm, gfn);
+
+	/* No memslot means it's an emulated MMIO region */
+	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID)) {
+		unsigned long gpa = (gfn << PAGE_SHIFT) | (ea & (psize - 1));
+		return kvmppc_hv_emulate_mmio(run, vcpu, gpa);
+	}
+
+	if (kvm->arch.slot_pfns[memslot->id])
+		return -EFAULT;		/* should never get here */
+	hva = gfn_to_hva_memslot(memslot, gfn);
+	npages = get_user_pages_fast(hva, 1, 1, pages);
+	if (npages < 1)
+		return -EFAULT;
+	page = pages[0];
+
+	pte_size = PAGE_SIZE;
+	if (PageHuge(page)) {
+		page = compound_head(page);
+		pte_size <<= compound_order(page);
+	}
+	ret = -EFAULT;
+	if (psize > pte_size)
+		goto out_put;
+	pfn = page_to_pfn(page);
+
+	/* Set the HPTE to point to pfn */
+	ret = RESUME_GUEST;
+	hptep = (unsigned long *)kvm->arch.hpt_virt + (index << 1);
+	rev = &kvm->arch.revmap[index];
+	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
+		cpu_relax();
+	if ((hptep[0] & ~HPTE_V_HVLOCK) != hpte[0] || hptep[1] != hpte[1] ||
+	    rev->guest_rpte != hpte[2]) {
+		/* HPTE has been changed under us; let the guest retry */
+		hptep[0] &= ~HPTE_V_HVLOCK;
+		goto out_put;
+	}
+	hpte[0] = (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
+	hpte[1] = (rev->guest_rpte & ~(HPTE_R_PP0 - pte_size)) |
+		(pfn << PAGE_SHIFT);
+	kvmppc_modify_hpte(kvm, hptep, hpte, index);
+	if (page)
+		SetPageDirty(page);
+
+ out_put:
+	if (page)
+		put_page(page);
+	return ret;
+
+ pass_to_guest:
+	/* Pass the interrupt along to the guest */
+	if (data) {
+		vcpu->arch.shregs.dsisr = dsisr;
+		vcpu->arch.shregs.dar = ea;
+		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_DATA_STORAGE, 0);
+	} else {
+		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_INST_STORAGE,
+					vcpu->arch.shregs.msr & 0x78000000);
+	}
+	return RESUME_GUEST;
+}
+
 void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long gpa,
 			    unsigned long *nb_ret)
 {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ceb49d2..47053e9 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -348,12 +348,16 @@ static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 * as we have enabled VRMA (virtualized real mode area) mode in the
 	 * LPCR.  We just generate an appropriate DSI/ISI to the guest.
 	 *
-	 * We also get them for MMIO emulation via key faults
+	 * We also get them if the guest accesses a page which it thinks
+	 * it has mapped but which is not actually present, either because
+	 * it is for an emulated I/O device or because the corresonding
+	 * host page has been paged out.
 	 */
 	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
-		/* We attempt MMIO emulation for key faults */
-		if (vcpu->arch.fault_dsisr & DSISR_KEYFAULT) {
-			r = kvmppc_book3s_hv_emulate_mmio(run, vcpu);
+		if ((vcpu->arch.fault_dsisr & DSISR_KEYFAULT) ||
+		    !(vcpu->arch.shregs.msr & MSR_DR)) {
+			r = kvmppc_book3s_hv_page_fault(run, vcpu,
+				vcpu->arch.fault_dar, vcpu->arch.fault_dsisr);
 			break;
 		}
 		vcpu->arch.shregs.dsisr = vcpu->arch.fault_dsisr;
@@ -362,6 +366,12 @@ static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 	case BOOK3S_INTERRUPT_H_INST_STORAGE:
+		if ((vcpu->arch.shregs.msr & SRR1_ISI_N_OR_G) ||
+		    !(vcpu->arch.shregs.msr & MSR_IR)) {
+			r = kvmppc_book3s_hv_page_fault(run, vcpu,
+				kvmppc_get_pc(vcpu), 0);
+			break;
+		}
 		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_INST_STORAGE,
 					vcpu->arch.shregs.msr & 0x78000000);
 		r = RESUME_GUEST;
@@ -1108,6 +1118,18 @@ static struct page *hva_to_page(unsigned long addr)
 	return page[0];
 }
 
+static unsigned long slb_pgsize_encoding(unsigned long psize)
+{
+	unsigned long senc = 0;
+
+	if (psize > 0x1000) {
+		senc = SLB_VSID_L;
+		if (psize == 0x10000)
+			senc |= SLB_VSID_LP_01;
+	}
+	return senc;
+}
+
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				      struct kvm_memory_slot *memslot,
 				      struct kvm_userspace_memory_region *mem)
@@ -1117,7 +1139,7 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	struct kvmppc_rma_info *ri = NULL;
 	struct vm_area_struct *vma;
 	unsigned long pfn;
-	unsigned long lpcr;
+	unsigned long lpcr, senc;
 	unsigned long *pfns = NULL;
 
 	npages = mem->memory_size >> PAGE_SHIFT;
@@ -1207,18 +1229,12 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		if (!(psize == 0x1000 || psize == 0x1000000 ||
 		      (psize == 0x10000 && cpu_has_feature(CPU_FTR_ARCH_206))))
 			goto err;
-		lpcr = kvm->arch.lpcr;
-		switch (porder) {
-		case 12:
-			lpcr &= ~(LPCR_VRMA_L);
-			break;
-		case 16:
-			lpcr |= (LPCR_VRMA_L | LPCR_VRMA_LP1);
-			break;
-		case 24:
-			lpcr |= LPCR_VRMA_L;
-			break;
-		}
+
+		senc = slb_pgsize_encoding(psize);
+		kvm->arch.vrma_slb.origv = senc | SLB_VSID_B_1T |
+			(VRMA_VSID << SLB_VSID_SHIFT_1T);
+		lpcr = kvm->arch.lpcr & ~(0x1fUL << LPCR_VRMASD_SH);
+		lpcr |= senc << (LPCR_VRMASD_SH - 4);
 		kvm->arch.lpcr = lpcr;
 	}
 
@@ -1262,7 +1278,6 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
 	}
 
-
 	pfns = vzalloc(npages * sizeof(unsigned long));
 	if (!pfns)
 		return -ENOMEM;
@@ -1337,6 +1352,9 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 		 *     only upon instruction from qemu... 
 		 */
 		lpcr |= LPCR_VPM1;
+		kvm->arch.vrma_slb.orige = SLB_ESID_V;
+		kvm->arch.vrma_slb.origv = SLB_VSID_B_1T | SLB_VSID_L |
+			(VRMA_VSID << SLB_VSID_SHIFT_1T);
 	}
 	kvm->arch.lpcr = lpcr;
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 1778091..b477e68 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -11,6 +11,7 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/hugetlb.h>
+#include <linux/module.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -75,27 +76,6 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	if (!psize)
 		return H_PARAMETER;
 
-	/*
-	 * We do not allow the guest to set key 31 which is reserved
-	 * for MMIO emulation and non-present RAM pages.  We don't want
-	 * to allow MMIO emulation to be used to access RAM due to possible
-	 * races between emulation and TLB invalidations.
-	 *
-	 * Emulated accesses are emulated by looking at the hash for
-	 * translation once, then performing the access later. The
-	 * translation could be invalidated in the meantime in which
-	 * point performing the subsequent memory access on the old
-	 * physical address is a violation of the architecture and
-	 * a security hole.
-	 *
-	 * This is less of an issue for MMIO stores since they aren't
-	 * globally visible. It could be an issue for MMIO loads to
-	 * a certain extent but we'll ignore it for now
-	 */
-	if ((ptel & (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) ==
-	    (HPTE_R_KEY_HI | HPTE_R_KEY_LO))
-		return H_PARAMETER;
-
 	/* Find the memslot (if any) for this address */
 	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
 	gfn = gpa >> PAGE_SHIFT;
@@ -162,11 +142,19 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		/*
 		 * If this is a non-present page for any reason
 		 * and this is a POWER7, set the key to 31 and set N.
+		 * If this is a page which could be accessed in real mode
+		 * using VRMA (which ignores page class keys) we have
+		 * to make it invalid instead.
 		 * On 970 we have to have all pages present.
 		 */
 		if (!cpu_has_feature(CPU_FTR_ARCH_206))
 			return H_PARAMETER;
-		ptel |= HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_R_N;
+		pteh |= HPTE_V_ABSENT;
+		if ((pteh & 0xffffffffff000000ul) ==
+		    (HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16))))
+			pteh &= ~HPTE_V_VALID;
+		else
+			ptel |= HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_R_N;
 	}
 
 	if (pte_index >= HPT_NPTE)
@@ -178,14 +166,16 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			if (i == 8)
 				return H_PTEG_FULL;
 			if ((*hpte & HPTE_V_VALID) == 0 &&
-			    try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
+			    try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID |
+					  HPTE_V_ABSENT))
 				break;
 			hpte += 2;
 		}
 		pte_index += i;
 	} else {
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-		if (!try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
+		if (!try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID |
+				   HPTE_V_ABSENT))
 			return H_PTEG_FULL;
 	}
 
@@ -238,7 +228,7 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
-	if ((hpte[0] & HPTE_V_VALID) == 0 ||
+	if ((hpte[0] & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) != avpn) ||
 	    ((flags & H_ANDCOND) && (hpte[0] & avpn) != 0)) {
 		hpte[0] &= ~HPTE_V_HVLOCK;
@@ -250,6 +240,8 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	vcpu->arch.gpr[5] = r = hpte[1];
 	rb = compute_tlbie_rb(v, r, pte_index);
 	hpte[0] = 0;
+	if (!(v & HPTE_V_VALID))
+		return H_SUCCESS;
 	if (!(flags & H_LOCAL)) {
 		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
 			cpu_relax();
@@ -298,7 +290,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 		while (!try_lock_hpte(hp, HPTE_V_HVLOCK))
 			cpu_relax();
 		found = 0;
-		if (hp[0] & HPTE_V_VALID) {
+		if (hp[0] & (HPTE_V_ABSENT | HPTE_V_VALID)) {
 			switch (flags & 3) {
 			case 0:		/* absolute */
 				found = 1;
@@ -321,7 +313,8 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 		/* insert R and C bits from PTE */
 		flags |= (hp[1] >> 5) & 0x0c;
 		args[i * 2] = ((0x80 | flags) << 56) + pte_index;
-		tlbrb[n_inval++] = compute_tlbie_rb(hp[0], hp[1], pte_index);
+		if (hp[0] & HPTE_V_VALID)
+			tlbrb[n_inval++] = compute_tlbie_rb(hp[0], hp[1], pte_index);
 		hp[0] = 0;
 	}
 	if (n_inval == 0)
@@ -356,14 +349,11 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 
 	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
-	/* Don't let it set a normal memory page to key 31 */
-	if (((flags >> 9) & 0x1f) == 0x1f)
-		return H_PARAMETER;
 
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
-	if ((hpte[0] & HPTE_V_VALID) == 0 ||
+	if ((hpte[0] & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) != avpn)) {
 		hpte[0] &= ~HPTE_V_HVLOCK;
 		return H_NOT_FOUND;
@@ -386,9 +376,8 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 		rev->guest_rpte = r;
 	}
 
- 	/* Don't let guest remove N or key from emulated MMIO pages */
-	if ((hpte[1] & (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) == 
-	    (HPTE_R_KEY_HI | HPTE_R_KEY_LO))
+ 	/* Don't let guest remove N or key from non-present pages */
+	if (hpte[0] & HPTE_V_ABSENT)
 		mask = HPTE_R_PP0 | HPTE_R_PP;
 	else
 		mask = HPTE_R_PP0 | HPTE_R_PP | HPTE_R_N |
@@ -396,20 +385,22 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	r = (hpte[1] & ~mask) | (bits & mask);
 
 	/* Update HPTE */
-	rb = compute_tlbie_rb(v, r, pte_index);
-	hpte[0] = v & ~HPTE_V_VALID;
-	if (!(flags & H_LOCAL)) {
-		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
-			cpu_relax();
-		asm volatile("ptesync" : : : "memory");
-		asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
-			     : : "r" (rb), "r" (kvm->arch.lpid));
-		asm volatile("ptesync" : : : "memory");
-		kvm->arch.tlbie_lock = 0;
-	} else {
-		asm volatile("ptesync" : : : "memory");
-		asm volatile("tlbiel %0" : : "r" (rb));
-		asm volatile("ptesync" : : : "memory");
+	if (v & HPTE_V_VALID) {
+		rb = compute_tlbie_rb(v, r, pte_index);
+		hpte[0] = v & ~HPTE_V_VALID;
+		if (!(flags & H_LOCAL)) {
+			while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
+				cpu_relax();
+			asm volatile("ptesync" : : : "memory");
+			asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
+				     : : "r" (rb), "r" (kvm->arch.lpid));
+			asm volatile("ptesync" : : : "memory");
+			kvm->arch.tlbie_lock = 0;
+		} else {
+			asm volatile("ptesync" : : : "memory");
+			asm volatile("tlbiel %0" : : "r" (rb));
+			asm volatile("ptesync" : : : "memory");
+		}
 	}
 	hpte[1] = r;
 	eieio();
@@ -422,7 +413,7 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 		   unsigned long pte_index)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long *hpte, r;
+	unsigned long *hpte, v, r;
 	int i, n = 1;
 	struct revmap_entry *rev = NULL;
 
@@ -436,15 +427,43 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 		rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
 	for (i = 0; i < n; ++i, ++pte_index) {
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
+		v = hpte[0] & ~HPTE_V_HVLOCK;
 		r = hpte[1];
-		if (hpte[0] & HPTE_V_VALID) {
+		if (v & HPTE_V_ABSENT) {
+			v &= ~HPTE_V_ABSENT;
+			v |= HPTE_V_VALID;
+		}
+		if (v & HPTE_V_VALID) {
 			if (rev)
 				r = rev[i].guest_rpte;
 			else
 				r = hpte[1] | HPTE_R_RPN;
 		}
-		vcpu->arch.gpr[4 + i * 2] = hpte[0];
+		vcpu->arch.gpr[4 + i * 2] = v;
 		vcpu->arch.gpr[5 + i * 2] = r;
 	}
 	return H_SUCCESS;
 }
+
+void kvmppc_modify_hpte(struct kvm *kvm, unsigned long *hptep,
+			unsigned long new_hpte[2], unsigned long pte_index)
+{
+	unsigned long rb;
+
+	hptep[1] = new_hpte[1];
+	eieio();
+	if (hptep[0] & HPTE_V_VALID) {
+		/* previously valid, so need to tlbie */
+		rb = compute_tlbie_rb(hptep[0], hptep[1], pte_index);
+		while (!try_lock_tlbie(&kvm->arch.tlbie_lock))
+			cpu_relax();
+		asm volatile("ptesync" : : : "memory");
+		asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
+			     : : "r" (rb), "r" (kvm->arch.lpid));
+		asm volatile("ptesync" : : : "memory");
+		kvm->arch.tlbie_lock = 0;
+	}
+	hptep[0] = new_hpte[0] & ~HPTE_V_HVLOCK;	/* unlocks it */
+	asm volatile("ptesync" : : : "memory");
+}
+EXPORT_SYMBOL_GPL(kvmppc_modify_hpte);
-- 
1.7.7.2
