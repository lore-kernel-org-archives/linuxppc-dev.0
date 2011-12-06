Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 Dec 2011 17:10:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 10/13] KVM: PPC: Implement MMIO emulation support for Book3S
 HV guests
Message-ID: <20111206061056.GN12389@drongo>
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

This provides the low-level support for MMIO emulation in Book3S HV
guests.  When the guest tries to map a page which is not covered by
any memslot, that page is taken to be an MMIO emulation page.  Instead
of inserting a valid HPTE, we insert an HPTE that has the valid bit
clear but another hypervisor software-use bit set, which we call
HPTE_V_ABSENT, to indicate that this is an absent page.  An
absent page is treated much like a valid page as far as guest hcalls
(H_ENTER, H_REMOVE, H_READ etc.) are concerned, except of course that
an absent HPTE doesn't need to be invalidated with tlbie since it
was never valid as far as the hardware is concerned.

When the guest accesses a page for which there is an absent HPTE, it
will take a hypervisor data storage interrupt (HDSI) since we now set
the VPM1 bit in the LPCR.  Our HDSI handler for HPTE-not-present faults
looks up the hash table and if it finds an absent HPTE mapping the
requested virtual address, will switch to kernel mode and handle the
fault in kvmppc_book3s_hv_page_fault(), which at present just calls
kvmppc_hv_emulate_mmio() to set up the MMIO emulation.

This is based on an earlier patch by Benjamin Herrenschmidt, but since
heavily reworked.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h    |    5 +
 arch/powerpc/include/asm/kvm_book3s_64.h |   26 +++
 arch/powerpc/include/asm/kvm_host.h      |    5 +
 arch/powerpc/include/asm/mmu-hash64.h    |    2 +-
 arch/powerpc/include/asm/ppc-opcode.h    |    4 +-
 arch/powerpc/include/asm/reg.h           |    1 +
 arch/powerpc/kernel/asm-offsets.c        |    1 +
 arch/powerpc/kernel/exceptions-64s.S     |    8 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  228 +++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv.c             |   21 ++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  262 ++++++++++++++++++++++++++----
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  127 ++++++++++++---
 12 files changed, 607 insertions(+), 83 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 5e7e04b..5ac53f9 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -121,6 +121,11 @@ extern void kvmppc_mmu_book3s_hv_init(struct kvm_vcpu *vcpu);
 extern int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte);
 extern int kvmppc_mmu_map_segment(struct kvm_vcpu *vcpu, ulong eaddr);
 extern void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu);
+extern int kvmppc_book3s_hv_page_fault(struct kvm_run *run,
+			struct kvm_vcpu *vcpu, unsigned long addr,
+			unsigned long status);
+extern long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr,
+			unsigned long slb_v, unsigned long valid);
 
 extern void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte);
 extern struct hpte_cache *kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu);
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 90e6658..9a59b6d 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -37,12 +37,15 @@ static inline struct kvmppc_book3s_shadow_vcpu *to_svcpu(struct kvm_vcpu *vcpu)
 #define HPT_HASH_MASK	(HPT_NPTEG - 1)
 #endif
 
+#define VRMA_VSID	0x1ffffffUL	/* 1TB VSID reserved for VRMA */
+
 /*
  * We use a lock bit in HPTE dword 0 to synchronize updates and
  * accesses to each HPTE, and another bit to indicate non-present
  * HPTEs.
  */
 #define HPTE_V_HVLOCK	0x40UL
+#define HPTE_V_ABSENT	0x20UL
 
 static inline long try_lock_hpte(unsigned long *hpte, unsigned long bits)
 {
@@ -138,6 +141,29 @@ static inline unsigned long hpte_cache_bits(unsigned long pte_val)
 #endif
 }
 
+static inline bool hpte_read_permission(unsigned long pp, unsigned long key)
+{
+	if (key)
+		return PP_RWRX <= pp && pp <= PP_RXRX;
+	return 1;
+}
+
+static inline bool hpte_write_permission(unsigned long pp, unsigned long key)
+{
+	if (key)
+		return pp == PP_RWRW;
+	return pp <= PP_RWRW;
+}
+
+static inline int hpte_get_skey_perm(unsigned long hpte_r, unsigned long amr)
+{
+	unsigned long skey;
+
+	skey = ((hpte_r & HPTE_R_KEY_HI) >> 57) |
+		((hpte_r & HPTE_R_KEY_LO) >> 9);
+	return (amr >> (62 - 2 * skey)) & 3;
+}
+
 static inline void lock_rmap(unsigned long *rmap)
 {
 	do {
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e369d49..c9c92f0 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -209,6 +209,7 @@ struct kvm_arch {
 	unsigned long lpcr;
 	unsigned long rmor;
 	struct kvmppc_rma_info *rma;
+	unsigned long vrma_slb_v;
 	int rma_setup_done;
 	struct list_head spapr_tce_tables;
 	spinlock_t slot_phys_lock;
@@ -451,6 +452,10 @@ struct kvm_vcpu_arch {
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	struct kvm_vcpu_arch_shared shregs;
 
+	unsigned long pgfault_addr;
+	long pgfault_index;
+	unsigned long pgfault_hpte[2];
+
 	struct list_head run_list;
 	struct task_struct *run_task;
 	struct kvm_run *kvm_run;
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index b445e0a..033173e 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -108,11 +108,11 @@ extern char initial_stab[];
 #define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff000000)
 
 /* Values for PP (assumes Ks=0, Kp=1) */
-/* pp0 will always be 0 for linux     */
 #define PP_RWXX	0	/* Supervisor read/write, User none */
 #define PP_RWRX 1	/* Supervisor read/write, User read */
 #define PP_RWRW 2	/* Supervisor read/write, User read/write */
 #define PP_RXRX 3	/* Supervisor read,       User read */
+#define PP_RXXX	(HPTE_R_PP0 | 2)	/* Supervisor read, user none */
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index e980faa..d81f994 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -45,6 +45,7 @@
 #define PPC_INST_MFSPR_DSCR_MASK	0xfc1fffff
 #define PPC_INST_MTSPR_DSCR		0x7c1103a6
 #define PPC_INST_MTSPR_DSCR_MASK	0xfc1fffff
+#define PPC_INST_SLBFEE			0x7c0007a7
 
 #define PPC_INST_STRING			0x7c00042a
 #define PPC_INST_STRING_MASK		0xfc0007fe
@@ -183,7 +184,8 @@
 					__PPC_RS(t) | __PPC_RA(a) | __PPC_RB(b))
 #define PPC_ERATSX_DOT(t, a, w)	stringify_in_c(.long PPC_INST_ERATSX_DOT | \
 					__PPC_RS(t) | __PPC_RA(a) | __PPC_RB(b))
-
+#define PPC_SLBFEE_DOT(t, b)	stringify_in_c(.long PPC_INST_SLBFEE | \
+					__PPC_RT(t) | __PPC_RB(b))
 
 /*
  * Define what the VSX XX1 form instructions will look like, then add
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 4599d12..c74379a 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -216,6 +216,7 @@
 #define   DSISR_ISSTORE		0x02000000	/* access was a store */
 #define   DSISR_DABRMATCH	0x00400000	/* hit data breakpoint */
 #define   DSISR_NOSEGMENT	0x00200000	/* STAB/SLB miss */
+#define   DSISR_KEYFAULT	0x00200000	/* Key fault */
 #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
 #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
 #define SPRN_TBWL	0x11C	/* Time Base Lower Register (super, R/W) */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index fcda95c..84aac68 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -451,6 +451,7 @@ int main(void)
 	DEFINE(KVM_LAST_VCPU, offsetof(struct kvm, arch.last_vcpu));
 	DEFINE(KVM_LPCR, offsetof(struct kvm, arch.lpcr));
 	DEFINE(KVM_RMOR, offsetof(struct kvm, arch.rmor));
+	DEFINE(KVM_VRMA_SLB_V, offsetof(struct kvm, arch.vrma_slb_v));
 	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
 	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
 #endif
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 396d080..9c2f0e2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -100,14 +100,14 @@ data_access_not_stab:
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 #endif
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common, EXC_STD,
-				 KVMTEST_PR, 0x300)
+				 KVMTEST, 0x300)
 
 	. = 0x380
 	.globl data_access_slb_pSeries
 data_access_slb_pSeries:
 	HMT_MEDIUM
 	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x380)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
 #ifdef __DISABLED__
@@ -329,8 +329,8 @@ do_stab_bolted_pSeries:
 	EXCEPTION_PROLOG_PSERIES_1(.do_stab_bolted, EXC_STD)
 #endif /* CONFIG_POWER4_ONLY */
 
-	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_STD, 0x300)
-	KVM_HANDLER_PR_SKIP(PACA_EXSLB, EXC_STD, 0x380)
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x300)
+	KVM_HANDLER_SKIP(PACA_EXSLB, EXC_STD, 0x380)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x400)
 	KVM_HANDLER_PR(PACA_EXSLB, EXC_STD, 0x480)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x900)
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index b904c40..2d31519 100644
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
@@ -298,16 +296,18 @@ long kvmppc_virtmode_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	if (!psize)
 		return H_PARAMETER;
 
+	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
+
 	/* Find the memslot (if any) for this address */
 	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
 	gfn = gpa >> PAGE_SHIFT;
 	memslot = gfn_to_memslot(kvm, gfn);
-	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
-		return H_PARAMETER;
-	if (!slot_is_aligned(memslot, psize))
-		return H_PARAMETER;
-	if (kvmppc_get_guest_page(kvm, gfn, memslot, psize) < 0)
-		return H_PARAMETER;
+	if (memslot && !(memslot->flags & KVM_MEMSLOT_INVALID)) {
+		if (!slot_is_aligned(memslot, psize))
+			return H_PARAMETER;
+		if (kvmppc_get_guest_page(kvm, gfn, memslot, psize) < 0)
+			return H_PARAMETER;
+	}
 
 	preempt_disable();
 	ret = kvmppc_h_enter(vcpu, flags, pte_index, pteh, ptel);
@@ -321,10 +321,218 @@ long kvmppc_virtmode_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 
 }
 
+static struct kvmppc_slb *kvmppc_mmu_book3s_hv_find_slbe(struct kvm_vcpu *vcpu,
+							 gva_t eaddr)
+{
+	u64 mask;
+	int i;
+
+	for (i = 0; i < vcpu->arch.slb_nr; i++) {
+		if (!(vcpu->arch.slb[i].orige & SLB_ESID_V))
+			continue;
+
+		if (vcpu->arch.slb[i].origv & SLB_VSID_B_1T)
+			mask = ESID_MASK_1T;
+		else
+			mask = ESID_MASK;
+
+		if (((vcpu->arch.slb[i].orige ^ eaddr) & mask) == 0)
+			return &vcpu->arch.slb[i];
+	}
+	return NULL;
+}
+
+static unsigned long kvmppc_mmu_get_real_addr(unsigned long v, unsigned long r,
+			unsigned long ea)
+{
+	unsigned long ra_mask;
+
+	ra_mask = hpte_page_size(v, r) - 1;
+	return (r & HPTE_R_RPN & ~ra_mask) | (ea & ra_mask);
+}
+
 static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
-				struct kvmppc_pte *gpte, bool data)
+			struct kvmppc_pte *gpte, bool data)
 {
-	return -ENOENT;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvmppc_slb *slbe;
+	unsigned long slb_v;
+	unsigned long pp, key;
+	unsigned long v, gr;
+	unsigned long *hptep;
+	int index;
+	int virtmode = vcpu->arch.shregs.msr & (data ? MSR_DR : MSR_IR);
+
+	/* Get SLB entry */
+	if (virtmode) {
+		slbe = kvmppc_mmu_book3s_hv_find_slbe(vcpu, eaddr);
+		if (!slbe)
+			return -EINVAL;
+		slb_v = slbe->origv;
+	} else {
+		/* real mode access */
+		slb_v = vcpu->kvm->arch.vrma_slb_v;
+	}
+
+	/* Find the HPTE in the hash table */
+	index = kvmppc_hv_find_lock_hpte(kvm, eaddr, slb_v,
+					 HPTE_V_VALID | HPTE_V_ABSENT);
+	if (index < 0)
+		return -ENOENT;
+	hptep = (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
+	v = hptep[0] & ~HPTE_V_HVLOCK;
+	gr = kvm->arch.revmap[index].guest_rpte;
+
+	/* Unlock the HPTE */
+	asm volatile("lwsync" : : : "memory");
+	hptep[0] = v;
+
+	gpte->eaddr = eaddr;
+	gpte->vpage = ((v & HPTE_V_AVPN) << 4) | ((eaddr >> 12) & 0xfff);
+
+	/* Get PP bits and key for permission check */
+	pp = gr & (HPTE_R_PP0 | HPTE_R_PP);
+	key = (vcpu->arch.shregs.msr & MSR_PR) ? SLB_VSID_KP : SLB_VSID_KS;
+	key &= slb_v;
+
+	/* Calculate permissions */
+	gpte->may_read = hpte_read_permission(pp, key);
+	gpte->may_write = hpte_write_permission(pp, key);
+	gpte->may_execute = gpte->may_read && !(gr & (HPTE_R_N | HPTE_R_G));
+
+	/* Storage key permission check for POWER7 */
+	if (data && virtmode && cpu_has_feature(CPU_FTR_ARCH_206)) {
+		int amrfield = hpte_get_skey_perm(gr, vcpu->arch.amr);
+		if (amrfield & 1)
+			gpte->may_read = 0;
+		if (amrfield & 2)
+			gpte->may_write = 0;
+	}
+
+	/* Get the guest physical address */
+	gpte->raddr = kvmppc_mmu_get_real_addr(v, gr, eaddr);
+	return 0;
+}
+
+/*
+ * Quick test for whether an instruction is a load or a store.
+ * If the instruction is a load or a store, then this will indicate
+ * which it is, at least on server processors.  (Embedded processors
+ * have some external PID instructions that don't follow the rule
+ * embodied here.)  If the instruction isn't a load or store, then
+ * this doesn't return anything useful.
+ */
+static int instruction_is_store(unsigned int instr)
+{
+	unsigned int mask;
+
+	mask = 0x10000000;
+	if ((instr & 0xfc000000) == 0x7c000000)
+		mask = 0x100;		/* major opcode 31 */
+	return (instr & mask) != 0;
+}
+
+static int kvmppc_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				  unsigned long gpa, int is_store)
+{
+	int ret;
+	u32 last_inst;
+	unsigned long srr0 = kvmppc_get_pc(vcpu);
+
+	/* We try to load the last instruction.  We don't let
+	 * emulate_instruction do it as it doesn't check what
+	 * kvmppc_ld returns.
+	 * If we fail, we just return to the guest and try executing it again.
+	 */
+	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED) {
+		ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
+		if (ret != EMULATE_DONE || last_inst == KVM_INST_FETCH_FAILED)
+			return RESUME_GUEST;
+		vcpu->arch.last_inst = last_inst;
+	}
+
+	/*
+	 * WARNING: We do not know for sure whether the instruction we just
+	 * read from memory is the same that caused the fault in the first
+	 * place.  If the instruction we read is neither an load or a store,
+	 * then it can't access memory, so we don't need to worry about
+	 * enforcing access permissions.  So, assuming it is a load or
+	 * store, we just check that its direction (load or store) is
+	 * consistent with the original fault, since that's what we
+	 * checked the access permissions against.  If there is a mismatch
+	 * we just return and retry the instruction.
+	 */
+
+	if (instruction_is_store(vcpu->arch.last_inst) != !!is_store)
+		return RESUME_GUEST;
+
+	/*
+	 * Emulated accesses are emulated by looking at the hash for
+	 * translation once, then performing the access later. The
+	 * translation could be invalidated in the meantime in which
+	 * point performing the subsequent memory access on the old
+	 * physical address could possibly be a security hole for the
+	 * guest (but not the host).
+	 *
+	 * This is less of an issue for MMIO stores since they aren't
+	 * globally visible. It could be an issue for MMIO loads to
+	 * a certain extent but we'll ignore it for now.
+	 */
+
+	vcpu->arch.paddr_accessed = gpa;
+	return kvmppc_emulate_mmio(run, vcpu);
+}
+
+int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				unsigned long ea, unsigned long dsisr)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long *hptep, hpte[3];
+	unsigned long psize;
+	unsigned long gfn;
+	struct kvm_memory_slot *memslot;
+	struct revmap_entry *rev;
+	long index;
+
+	/*
+	 * Real-mode code has already searched the HPT and found the
+	 * entry we're interested in.  Lock the entry and check that
+	 * it hasn't changed.  If it has, just return and re-execute the
+	 * instruction.
+	 */
+	if (ea != vcpu->arch.pgfault_addr)
+		return RESUME_GUEST;
+	index = vcpu->arch.pgfault_index;
+	hptep = (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
+	rev = &kvm->arch.revmap[index];
+	preempt_disable();
+	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
+		cpu_relax();
+	hpte[0] = hptep[0] & ~HPTE_V_HVLOCK;
+	hpte[1] = hptep[1];
+	hpte[2] = rev->guest_rpte;
+	asm volatile("lwsync" : : : "memory");
+	hptep[0] = hpte[0];
+	preempt_enable();
+
+	if (hpte[0] != vcpu->arch.pgfault_hpte[0] ||
+	    hpte[1] != vcpu->arch.pgfault_hpte[1])
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
+		return kvmppc_hv_emulate_mmio(run, vcpu, gpa,
+					      dsisr & DSISR_ISSTORE);
+	}
+
+	/* should never get here otherwise */
+	return -EFAULT;
 }
 
 void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long gpa,
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 150f527..38f7d05 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -324,19 +324,18 @@ static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 	}
 	/*
-	 * We get these next two if the guest does a bad real-mode access,
-	 * as we have enabled VRMA (virtualized real mode area) mode in the
-	 * LPCR.  We just generate an appropriate DSI/ISI to the guest.
+	 * We get this if the guest accesses a page which it thinks
+	 * it has mapped but which is not actually present, because
+	 * it is for an emulated I/O device.
+	 * Any other HDSI interrupt has been handled already.
 	 */
 	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
-		vcpu->arch.shregs.dsisr = vcpu->arch.fault_dsisr;
-		vcpu->arch.shregs.dar = vcpu->arch.fault_dar;
-		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_DATA_STORAGE, 0);
-		r = RESUME_GUEST;
+		r = kvmppc_book3s_hv_page_fault(run, vcpu,
+				vcpu->arch.fault_dar, vcpu->arch.fault_dsisr);
 		break;
 	case BOOK3S_INTERRUPT_H_INST_STORAGE:
 		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_INST_STORAGE,
-					0x08000000);
+					vcpu->arch.shregs.msr & 0x58000000);
 		r = RESUME_GUEST;
 		break;
 	/*
@@ -1226,6 +1225,8 @@ static int kvmppc_hv_setup_rma(struct kvm_vcpu *vcpu)
 
 		/* Update VRMASD field in the LPCR */
 		senc = slb_pgsize_encoding(psize);
+		kvm->arch.vrma_slb_v = senc | SLB_VSID_B_1T |
+			(VRMA_VSID << SLB_VSID_SHIFT_1T);
 		lpcr = kvm->arch.lpcr & ~LPCR_VRMASD;
 		lpcr |= senc << (LPCR_VRMASD_SH - 4);
 		kvm->arch.lpcr = lpcr;
@@ -1322,7 +1323,9 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 		kvm->arch.host_lpcr = lpcr = mfspr(SPRN_LPCR);
 		lpcr &= LPCR_PECE | LPCR_LPES;
 		lpcr |= (4UL << LPCR_DPFD_SH) | LPCR_HDICE |
-			LPCR_VPM0 | LPCR_VRMA_L;
+			LPCR_VPM0 | LPCR_VPM1;
+		kvm->arch.vrma_slb_v = SLB_VSID_B_1T |
+			(VRMA_VSID << SLB_VSID_SHIFT_1T);
 	}
 	kvm->arch.lpcr = lpcr;
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index b600f8c..d58a885 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -139,13 +139,23 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	psize = hpte_page_size(pteh, ptel);
 	if (!psize)
 		return H_PARAMETER;
+	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
 
 	/* Find the memslot (if any) for this address */
 	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
 	gfn = gpa >> PAGE_SHIFT;
 	memslot = builtin_gfn_to_memslot(kvm, gfn);
-	if (!(memslot && !(memslot->flags & KVM_MEMSLOT_INVALID)))
-		return H_PARAMETER;
+	pa = 0;
+	rmap = NULL;
+	if (!(memslot && !(memslot->flags & KVM_MEMSLOT_INVALID))) {
+		/* PPC970 can't do emulated MMIO */
+		if (!cpu_has_feature(CPU_FTR_ARCH_206))
+			return H_PARAMETER;
+		/* Emulated MMIO - mark this with key=31 */
+		pteh |= HPTE_V_ABSENT;
+		ptel |= HPTE_R_KEY_HI | HPTE_R_KEY_LO;
+		goto do_insert;
+	}
 
 	/* Check if the requested page fits entirely in the memslot. */
 	if (!slot_is_aligned(memslot, psize))
@@ -173,13 +183,13 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 
 	ptel &= ~(HPTE_R_PP0 - psize);
 	ptel |= pa;
+	pteh |= HPTE_V_VALID;
 
 	/* Check WIMG */
 	if (!hpte_cache_flags_ok(ptel, is_io))
 		return H_PARAMETER;
-	pteh &= ~0x60UL;
-	pteh |= HPTE_V_VALID;
 
+ do_insert:
 	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	if (likely((flags & H_EXACT) == 0)) {
@@ -187,7 +197,8 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 		for (i = 0; i < 8; ++i) {
 			if ((*hpte & HPTE_V_VALID) == 0 &&
-			    try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
+			    try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID |
+					  HPTE_V_ABSENT))
 				break;
 			hpte += 2;
 		}
@@ -202,7 +213,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			for (i = 0; i < 8; ++i) {
 				while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 					cpu_relax();
-				if ((*hpte & HPTE_V_VALID) == 0)
+				if (!(*hpte & (HPTE_V_VALID | HPTE_V_ABSENT)))
 					break;
 				*hpte &= ~HPTE_V_HVLOCK;
 				hpte += 2;
@@ -213,11 +224,12 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		pte_index += i;
 	} else {
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-		if (!try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID)) {
+		if (!try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID |
+				   HPTE_V_ABSENT)) {
 			/* Lock the slot and check again */
 			while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 				cpu_relax();
-			if (*hpte & HPTE_V_VALID) {
+			if (*hpte & (HPTE_V_VALID | HPTE_V_ABSENT)) {
 				*hpte &= ~HPTE_V_HVLOCK;
 				return H_PTEG_FULL;
 			}
@@ -232,10 +244,12 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		rev->guest_rpte = g_ptel;
 
 	/* Link HPTE into reverse-map chain */
-	if (realmode)
-		rmap = real_vmalloc_addr(rmap);
-	lock_rmap(rmap);
-	kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index, realmode);
+	if (pteh & HPTE_V_VALID) {
+		if (realmode)
+			rmap = real_vmalloc_addr(rmap);
+		lock_rmap(rmap);
+		kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index, realmode);
+	}
 
 	hpte[1] = ptel;
 
@@ -282,7 +296,7 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
-	if ((hpte[0] & HPTE_V_VALID) == 0 ||
+	if ((hpte[0] & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) != avpn) ||
 	    ((flags & H_ANDCOND) && (hpte[0] & avpn) != 0)) {
 		hpte[0] &= ~HPTE_V_HVLOCK;
@@ -293,11 +307,14 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	vcpu->arch.gpr[4] = v = hpte[0] & ~HPTE_V_HVLOCK;
 	vcpu->arch.gpr[5] = r = hpte[1];
 	rb = compute_tlbie_rb(v, r, pte_index);
-	remove_revmap_chain(kvm, pte_index, v);
+	if (v & HPTE_V_VALID)
+		remove_revmap_chain(kvm, pte_index, v);
 	smp_wmb();
 	hpte[0] = 0;
+	if (!(v & HPTE_V_VALID))
+		return H_SUCCESS;
 	if (!(flags & H_LOCAL)) {
-		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
+		while (!try_lock_tlbie(&kvm->arch.tlbie_lock))
 			cpu_relax();
 		asm volatile("ptesync" : : : "memory");
 		asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
@@ -344,7 +361,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 		while (!try_lock_hpte(hp, HPTE_V_HVLOCK))
 			cpu_relax();
 		found = 0;
-		if (hp[0] & HPTE_V_VALID) {
+		if (hp[0] & (HPTE_V_ABSENT | HPTE_V_VALID)) {
 			switch (flags & 3) {
 			case 0:		/* absolute */
 				found = 1;
@@ -367,8 +384,10 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 		/* insert R and C bits from PTE */
 		flags |= (hp[1] >> 5) & 0x0c;
 		args[i * 2] = ((0x80 | flags) << 56) + pte_index;
-		tlbrb[n_inval++] = compute_tlbie_rb(hp[0], hp[1], pte_index);
-		remove_revmap_chain(kvm, pte_index, hp[0]);
+		if (hp[0] & HPTE_V_VALID) {
+			tlbrb[n_inval++] = compute_tlbie_rb(hp[0], hp[1], pte_index);
+			remove_revmap_chain(kvm, pte_index, hp[0]);
+		}
 		smp_wmb();
 		hp[0] = 0;
 	}
@@ -404,14 +423,16 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 
 	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
+
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
-	if ((hpte[0] & HPTE_V_VALID) == 0 ||
+	if ((hpte[0] & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) != avpn)) {
 		hpte[0] &= ~HPTE_V_HVLOCK;
 		return H_NOT_FOUND;
 	}
+
 	if (atomic_read(&kvm->online_vcpus) == 1)
 		flags |= H_LOCAL;
 	v = hpte[0];
@@ -430,20 +451,22 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	r = (hpte[1] & ~mask) | bits;
 
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
@@ -456,7 +479,7 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 		   unsigned long pte_index)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long *hpte, r;
+	unsigned long *hpte, v, r;
 	int i, n = 1;
 	struct revmap_entry *rev = NULL;
 
@@ -470,15 +493,182 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
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
+static int slb_base_page_shift[4] = {
+	24,	/* 16M */
+	16,	/* 64k */
+	34,	/* 16G */
+	20,	/* 1M, unsupported */
+};
+
+long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
+			      unsigned long valid)
+{
+	unsigned int i;
+	unsigned int pshift;
+	unsigned long somask;
+	unsigned long vsid, hash;
+	unsigned long avpn;
+	unsigned long *hpte;
+	unsigned long mask, val;
+	unsigned long v, r;
+
+	/* Get page shift, work out hash and AVPN etc. */
+	mask = SLB_VSID_B | HPTE_V_AVPN | HPTE_V_SECONDARY;
+	val = 0;
+	pshift = 12;
+	if (slb_v & SLB_VSID_L) {
+		mask |= HPTE_V_LARGE;
+		val |= HPTE_V_LARGE;
+		pshift = slb_base_page_shift[(slb_v & SLB_VSID_LP) >> 4];
+	}
+	if (slb_v & SLB_VSID_B_1T) {
+		somask = (1UL << 40) - 1;
+		vsid = (slb_v & ~SLB_VSID_B) >> SLB_VSID_SHIFT_1T;
+		vsid ^= vsid << 25;
+	} else {
+		somask = (1UL << 28) - 1;
+		vsid = (slb_v & ~SLB_VSID_B) >> SLB_VSID_SHIFT;
+	}
+	hash = (vsid ^ ((eaddr & somask) >> pshift)) & HPT_HASH_MASK;
+	avpn = slb_v & ~(somask >> 16);	/* also includes B */
+	avpn |= (eaddr & somask) >> 16;
+
+	if (pshift >= 24)
+		avpn &= ~((1UL << (pshift - 16)) - 1);
+	else
+		avpn &= ~0x7fUL;
+	val |= avpn;
+
+	for (;;) {
+		hpte = (unsigned long *)(kvm->arch.hpt_virt + (hash << 7));	
+
+		for (i = 0; i < 16; i += 2) {
+			/* Read the PTE racily */
+			v = hpte[i] & ~HPTE_V_HVLOCK;
+
+			/* Check valid/absent, hash, segment size and AVPN */
+			if (!(v & valid) || (v & mask) != val)
+				continue;
+
+			/* Lock the PTE and read it under the lock */
+			while (!try_lock_hpte(&hpte[i], HPTE_V_HVLOCK))
+				cpu_relax();
+			v = hpte[i] & ~HPTE_V_HVLOCK;
+			r = hpte[i+1];
+
+			/*
+			 * Check the HPTE again, including large page size
+			 * Since we don't currently allow any MPSS (mixed
+			 * page-size segment) page sizes, it is sufficient
+			 * to check against the actual page size.
+			 */
+			if ((v & valid) && (v & mask) == val &&
+			    hpte_page_size(v, r) == (1ul << pshift))
+				/* Return with the HPTE still locked */
+				return (hash << 3) + (i >> 1);
+
+			/* Unlock and move on */
+			hpte[i] = v;
+		}
+
+		if (val & HPTE_V_SECONDARY)
+			break;
+		val |= HPTE_V_SECONDARY;
+		hash = hash ^ HPT_HASH_MASK;
+	}
+	return -1;
+}
+EXPORT_SYMBOL(kvmppc_hv_find_lock_hpte);
+
+/*
+ * Called in real mode to check whether an HPTE not found fault
+ * is due to accessing an emulated MMIO page.
+ * Returns a possibly modified status (DSISR) value if not
+ * (i.e. pass the interrupt to the guest),
+ * -1 to pass the fault up to host kernel mode code, -2 to do that
+ * and also load the instruction word,
+ * or 0 if we should make the guest retry the access.
+ */
+long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
+			  unsigned long slb_v, unsigned int status)
+{
+	struct kvm *kvm = vcpu->kvm;
+	long int index;
+	unsigned long v, r, gr;
+	unsigned long *hpte;
+	unsigned long valid;
+	struct revmap_entry *rev;
+	unsigned long pp, key;
+
+	valid = HPTE_V_VALID | HPTE_V_ABSENT;
+	index = kvmppc_hv_find_lock_hpte(kvm, addr, slb_v, valid);
+	if (index < 0)
+		return status;		/* there really was no HPTE */
+
+	hpte = (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
+	v = hpte[0] & ~HPTE_V_HVLOCK;
+	r = hpte[1];
+	rev = real_vmalloc_addr(&kvm->arch.revmap[index]);
+	gr = rev->guest_rpte;
+
+	/* Unlock the HPTE */
+	asm volatile("lwsync" : : : "memory");
+	hpte[0] = v;
+
+	/* If the HPTE is valid by now, retry the instruction */
+	if (v & HPTE_V_VALID)
+		return 0;
+
+	/* Check access permissions to the page */
+	pp = gr & (HPTE_R_PP0 | HPTE_R_PP);
+	key = (vcpu->arch.shregs.msr & MSR_PR) ? SLB_VSID_KP : SLB_VSID_KS;
+	if (status & DSISR_ISSTORE) {
+		/* check write permission */
+		if (!hpte_write_permission(pp, slb_v & key))
+			goto protfault;
+	} else {
+		if (!hpte_read_permission(pp, slb_v & key))
+			goto protfault;
+	}
+
+	/* Check storage key, if applicable */
+	if (vcpu->arch.shregs.msr & MSR_DR) {
+		unsigned int perm = hpte_get_skey_perm(gr, vcpu->arch.amr);
+		if (status & DSISR_ISSTORE)
+			perm >>= 1;
+		if (perm & 1)
+			return (status & ~DSISR_NOHPTE) | DSISR_KEYFAULT;
+	}
+
+	/* Save HPTE info for virtual-mode handler */
+	vcpu->arch.pgfault_addr = addr;
+	vcpu->arch.pgfault_index = index;
+	vcpu->arch.pgfault_hpte[0] = v;
+	vcpu->arch.pgfault_hpte[1] = r;
+
+	if (vcpu->arch.shregs.msr & MSR_IR)
+		return -2;	/* MMIO emulation - load instr word */
+
+	return -1;		/* send fault up to host kernel mode */
+
+ protfault:
+	return (status & ~DSISR_NOHPTE) | DSISR_PROTFAULT;
+}
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 44d8829..3a04550 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -598,6 +598,28 @@ kvmppc_interrupt:
 
 	stw	r12,VCPU_TRAP(r9)
 
+	/* Save HEIR (HV emulation assist reg) in last_inst
+	   if this is an HEI (HV emulation interrupt, e40) */
+	li	r3,KVM_INST_FETCH_FAILED
+BEGIN_FTR_SECTION
+	cmpwi	r12,BOOK3S_INTERRUPT_H_EMUL_ASSIST
+	bne	11f
+	mfspr	r3,SPRN_HEIR
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
+11:	stw	r3,VCPU_LAST_INST(r9)
+
+	/* these are volatile across C function calls */
+	mfctr	r3
+	mfxer	r4
+	std	r3, VCPU_CTR(r9)
+	stw	r4, VCPU_XER(r9)
+
+BEGIN_FTR_SECTION
+	/* If this is a page table miss then see if it's theirs or ours */
+	cmpwi	r12, BOOK3S_INTERRUPT_H_DATA_STORAGE
+	beq	kvmppc_hdsi
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
+
 	/* See if this is a leftover HDEC interrupt */
 	cmpwi	r12,BOOK3S_INTERRUPT_HV_DECREMENTER
 	bne	2f
@@ -605,7 +627,7 @@ kvmppc_interrupt:
 	cmpwi	r3,0
 	bge	ignore_hdec
 2:
-	/* See if this is something we can handle in real mode */
+	/* See if this is an hcall we can handle in real mode */
 	cmpwi	r12,BOOK3S_INTERRUPT_SYSCALL
 	beq	hcall_try_real_mode
 
@@ -621,6 +643,7 @@ BEGIN_FTR_SECTION
 1:
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
+nohpte_cont:
 hcall_real_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
 	/* Save DEC */
 	mfspr	r5,SPRN_DEC
@@ -629,36 +652,21 @@ hcall_real_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
 	add	r5,r5,r6
 	std	r5,VCPU_DEC_EXPIRES(r9)
 
-	/* Save HEIR (HV emulation assist reg) in last_inst
-	   if this is an HEI (HV emulation interrupt, e40) */
-	li	r3,-1
-BEGIN_FTR_SECTION
-	cmpwi	r12,BOOK3S_INTERRUPT_H_EMUL_ASSIST
-	bne	11f
-	mfspr	r3,SPRN_HEIR
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
-11:	stw	r3,VCPU_LAST_INST(r9)
-
 	/* Save more register state  */
-	mfxer	r5
 	mfdar	r6
 	mfdsisr	r7
-	mfctr	r8
-
-	stw	r5, VCPU_XER(r9)
 	std	r6, VCPU_DAR(r9)
 	stw	r7, VCPU_DSISR(r9)
-	std	r8, VCPU_CTR(r9)
-	/* grab HDAR & HDSISR if HV data storage interrupt (HDSI) */
 BEGIN_FTR_SECTION
+	/* don't overwrite fault_dar/fault_dsisr if HDSI */
 	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
 	beq	6f
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
-7:	std	r6, VCPU_FAULT_DAR(r9)
+	std	r6, VCPU_FAULT_DAR(r9)
 	stw	r7, VCPU_FAULT_DSISR(r9)
 
 	/* Save guest CTRL register, set runlatch to 1 */
-	mfspr	r6,SPRN_CTRLF
+6:	mfspr	r6,SPRN_CTRLF
 	stw	r6,VCPU_CTRL(r9)
 	andi.	r0,r6,1
 	bne	4f
@@ -1091,9 +1099,84 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	mtspr	SPRN_HSRR1, r7
 	ba	0x500
 
-6:	mfspr	r6,SPRN_HDAR
-	mfspr	r7,SPRN_HDSISR
-	b	7b
+/*
+ * Check whether an HDSI is an HPTE not found fault or something else.
+ * If it is an HPTE not found fault that is due to the guest accessing
+ * a page that they have mapped but which we have paged out, then
+ * we continue on with the guest exit path.  In all other cases,
+ * reflect the HDSI to the guest as a DSI.
+ */
+kvmppc_hdsi:
+	mfspr	r4, SPRN_HDAR
+	mfspr	r6, SPRN_HDSISR
+	/* HPTE not found fault? */
+	andis.	r0, r6, DSISR_NOHPTE@h
+	beq	1f			/* if not, send it to the guest */
+	andi.	r0, r11, MSR_DR		/* data relocation enabled? */
+	beq	3f
+	clrrdi	r0, r4, 28
+	PPC_SLBFEE_DOT(r5, r0)		/* if so, look up SLB */
+	bne	1f			/* if no SLB entry found */
+4:	std	r4, VCPU_FAULT_DAR(r9)
+	stw	r6, VCPU_FAULT_DSISR(r9)
+
+	/* Search the hash table. */
+	mr	r3, r9			/* vcpu pointer */
+	bl	.kvmppc_hpte_hv_fault
+	ld	r9, HSTATE_KVM_VCPU(r13)
+	ld	r10, VCPU_PC(r9)
+	ld	r11, VCPU_MSR(r9)
+	li	r12, BOOK3S_INTERRUPT_H_DATA_STORAGE
+	cmpdi	r3, 0			/* retry the instruction */
+	beq	6f
+	cmpdi	r3, -1			/* handle in kernel mode */
+	beq	nohpte_cont
+	cmpdi	r3, -2			/* MMIO emulation; need instr word */
+	beq	2f
+
+	/* Synthesize a DSI for the guest */
+	ld	r4, VCPU_FAULT_DAR(r9)
+	mr	r6, r3
+1:	mtspr	SPRN_DAR, r4
+	mtspr	SPRN_DSISR, r6
+	mtspr	SPRN_SRR0, r10
+	mtspr	SPRN_SRR1, r11
+	li	r10, BOOK3S_INTERRUPT_DATA_STORAGE
+	li	r11, (MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
+	rotldi	r11, r11, 63
+6:	ld	r7, VCPU_CTR(r9)
+	lwz	r8, VCPU_XER(r9)
+	mtctr	r7
+	mtxer	r8
+	mr	r4, r9
+	b	fast_guest_return
+
+3:	ld	r5, VCPU_KVM(r9)	/* not relocated, use VRMA */
+	ld	r5, KVM_VRMA_SLB_V(r5)
+	b	4b
+
+	/* If this is for emulated MMIO, load the instruction word */
+2:	li	r8, KVM_INST_FETCH_FAILED	/* In case lwz faults */
+
+	/* Set guest mode to 'jump over instruction' so if lwz faults
+	 * we'll just continue at the next IP. */
+	li	r0, KVM_GUEST_MODE_SKIP
+	stb	r0, HSTATE_IN_GUEST(r13)
+
+	/* Do the access with MSR:DR enabled */
+	mfmsr	r3
+	ori	r4, r3, MSR_DR		/* Enable paging for data */
+	mtmsrd	r4
+	lwz	r8, 0(r10)
+	mtmsrd	r3
+
+	/* Store the result */
+	stw	r8, VCPU_LAST_INST(r9)
+
+	/* Unset guest mode. */
+	li	r0, KVM_GUEST_MODE_NONE
+	stb	r0, HSTATE_IN_GUEST(r13)
+	b	nohpte_cont
 
 /*
  * Try to handle an hcall in real mode.
-- 
1.7.5.4
