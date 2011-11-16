Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 09:52:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 01/11] KVM: PPC: Add memory-mapping support for PCI
 passthrough and emulation
Message-ID: <20111116225209.GB26985@bloggs.ozlabs.ibm.com>
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

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This adds support for adding PCI device I/O regions to the guest memory
map, and for trapping guest accesses to emulated MMIO regions and
delivering them to qemu for MMIO emulation.  To trap guest accesses to
emulated MMIO regions, we reserve key 31 for the hypervisor's use and
set the VPM1 bit in LPCR, which sends all page faults to the host.
Any page fault that is not a key fault gets reflected immediately to the
guest.  We set HPTEs for emulated MMIO regions to have key = 31, and
don't allow the guest to create HPTEs with key = 31.  Any page fault
that is a key fault with key = 31 is then a candidate for MMIO
emulation and thus gets sent up to qemu.  We also load the instruction
that caused the fault for use later when qemu has done the emulation.

[paulus@samba.org: Cleaned up, moved kvmppc_book3s_hv_emulate_mmio()
 to book3s_64_mmu_hv.c]

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h    |    1 +
 arch/powerpc/include/asm/kvm_book3s_64.h |   24 +++
 arch/powerpc/include/asm/kvm_host.h      |    2 +
 arch/powerpc/include/asm/kvm_ppc.h       |    1 +
 arch/powerpc/include/asm/reg.h           |    4 +
 arch/powerpc/kernel/exceptions-64s.S     |    8 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  301 +++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv.c             |   91 +++++++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  153 ++++++++++++----
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  131 ++++++++++++-
 arch/powerpc/kvm/book3s_pr.c             |    1 +
 arch/powerpc/kvm/booke.c                 |    1 +
 arch/powerpc/kvm/powerpc.c               |    2 +-
 include/linux/kvm.h                      |    3 +
 14 files changed, 656 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index deb8a4e..bd8345f 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -121,6 +121,7 @@ extern void kvmppc_mmu_book3s_hv_init(struct kvm_vcpu *vcpu);
 extern int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte);
 extern int kvmppc_mmu_map_segment(struct kvm_vcpu *vcpu, ulong eaddr);
 extern void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu);
+extern int kvmppc_book3s_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu);
 
 extern void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte);
 extern struct hpte_cache *kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu);
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index d0ac94f..53692c2 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -62,4 +62,28 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 	return rb;
 }
 
+/*
+ * We use a lock bit in HPTE dword 0 to synchronize updates and
+ * accesses to each HPTE.
+ */
+#define HPTE_V_HVLOCK	0x40UL
+
+static inline long try_lock_hpte(unsigned long *hpte, unsigned long bits)
+{
+	unsigned long tmp, old;
+
+	asm volatile("	ldarx	%0,0,%2\n"
+		     "	and.	%1,%0,%3\n"
+		     "	bne	2f\n"
+		     "	ori	%0,%0,%4\n"
+		     "  stdcx.	%0,0,%2\n"
+		     "	beq+	2f\n"
+		     "	li	%1,%3\n"
+		     "2:	isync"
+		     : "=&r" (tmp), "=&r" (old)
+		     : "r" (hpte), "r" (bits), "i" (HPTE_V_HVLOCK)
+		     : "cc", "memory");
+	return old == 0;
+}
+
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index bf8af5d..f142a2d 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -186,6 +186,8 @@ struct kvm_arch {
 	struct list_head spapr_tce_tables;
 	unsigned short last_vcpu[NR_CPUS];
 	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
+	unsigned long io_slot_pfn[KVM_MEMORY_SLOTS +
+				  KVM_PRIVATE_MEM_SLOTS];
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
 };
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index a284f20..8c372b9 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -132,6 +132,7 @@ extern void kvm_release_rma(struct kvmppc_rma_info *ri);
 extern int kvmppc_core_init_vm(struct kvm *kvm);
 extern void kvmppc_core_destroy_vm(struct kvm *kvm);
 extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
+				struct kvm_memory_slot *memslot,
 				struct kvm_userspace_memory_region *mem);
 extern void kvmppc_core_commit_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem);
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 559da19..ff3d627 100644
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
@@ -493,6 +494,9 @@
 #define SPRN_SPRG7	0x117	/* Special Purpose Register General 7 */
 #define SPRN_SRR0	0x01A	/* Save/Restore Register 0 */
 #define SPRN_SRR1	0x01B	/* Save/Restore Register 1 */
+#define   SRR1_ISI_NOPT		0x40000000 /* ISI: Not found in hash */
+#define   SRR1_ISI_N_OR_G	0x10000000 /* ISI: Access is no-exec or G */
+#define   SRR1_ISI_PROT		0x08000000 /* ISI: Other protection fault */
 #define   SRR1_WAKEMASK		0x00380000 /* reason for wakeup */
 #define   SRR1_WAKESYSERR	0x00300000 /* System error */
 #define   SRR1_WAKEEE		0x00200000 /* External interrupt */
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
index bc3a2ea..da8c2f4 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -158,10 +158,307 @@ static void kvmppc_mmu_book3s_64_hv_reset_msr(struct kvm_vcpu *vcpu)
 	kvmppc_set_msr(vcpu, MSR_SF | MSR_ME);
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
+static unsigned int kvmppc_mmu_book3s_hv_slb_pshift(struct kvmppc_slb *slbe)
+{
+	if (!(slbe->origv & SLB_VSID_L))
+		return 12;	/*  4K */
+	switch ((slbe->origv >> 4) & 0x3) {
+	case 0: return 24;	/* 16M */
+	case 1: return 16;	/* 64K */
+	case 2: return 34;	/* 16G */
+	case 3: return 20;	/* 1M !!! but we don't support it */
+	}
+	return 12;     	/* Unsupported */
+}
+
+static unsigned long back_translate(struct kvm *kvm, unsigned long ra)
+{
+	unsigned long offset, rpn, i;
+
+	/* XXX handle MMIO  */
+	offset = ra & (kvm->arch.ram_psize - 1);
+	rpn = (ra - offset) >> PAGE_SHIFT;
+	for (i = 0; i < kvm->arch.ram_npages; ++i)
+		if (rpn == kvm->arch.ram_pginfo[i].pfn)
+			return (i << kvm->arch.ram_porder) + offset;
+
+	/* Error value */
+	return -1ull;
+}
+
+
+static char pp_read_perm[16] = {
+	/* key = 0 */	1, 1, 1, 1, 0, 0, 1, 0,
+	/* key = 1 */	0, 1, 1, 1, 0, 0, 0, 0
+};
+
+static char pp_write_perm[16] = {
+	/* key = 0 */	1, 1, 1, 0, 0, 0, 0, 0,
+	/* key = 1 */	0, 0, 1, 0, 0, 0, 0, 0
+};
+
+static int kvmppc_hv_find_hpte(struct kvm *kvm, gva_t eaddr,
+			struct kvmppc_slb *slbe, unsigned long *ret)
+{
+	unsigned int i;
+	unsigned int pshift;
+	unsigned long somask;
+	unsigned long vsid, hash;
+	unsigned long avpn;
+	unsigned long *hpte;
+
+	/* Get page shift, work out hash and AVPN etc. */
+	pshift = kvmppc_mmu_book3s_hv_slb_pshift(slbe);
+	if (slbe->origv & SLB_VSID_B_1T) {
+		somask = (1UL << 40) - 1;
+		vsid = (slbe->origv & ~SLB_VSID_B) >> SLB_VSID_SHIFT_1T;
+		vsid ^= vsid << 25;
+	} else {
+		somask = (1UL << 28) - 1;
+		vsid = (slbe->origv & ~SLB_VSID_B) >> SLB_VSID_SHIFT;
+	}
+	hash = (vsid ^ ((eaddr & somask) >> pshift)) & HPT_HASH_MASK;
+	avpn = slbe->origv & ~(somask >> 16);	/* also includes B */
+	avpn |= (eaddr & somask) >> 16;
+
+	if (pshift >= 24)
+		avpn &= ~((1UL << (pshift - 16)) - 1);
+	else
+		avpn &= ~0x7fUL;
+	avpn |= HPTE_V_VALID;
+
+	for (;;) {
+		hpte = (unsigned long *)(kvm->arch.hpt_virt + (hash << 7));	
+
+		for (i = 0; i < 16; i += 2) {
+			unsigned long oldv, v, r;
+
+			/* Read the PTE racily */
+			oldv = hpte[i] & ~HPTE_V_HVLOCK;
+
+			/* Check valid, hash, segment size and AVPN */
+			if (avpn != (oldv & (SLB_VSID_B | HPTE_V_AVPN |
+					     HPTE_V_SECONDARY | HPTE_V_VALID)))
+				continue;
+
+			/* Lock the PTE and read it under the lock */
+			while (!try_lock_hpte(&hpte[i], HPTE_V_HVLOCK))
+				cpu_relax();
+			v = hpte[i];
+			r = hpte[i+1];
+
+			/* Unlock the HPTE */
+			asm volatile("lwsync" : : : "memory");
+			v &= ~HPTE_V_HVLOCK;
+			hpte[i] = v;
+
+			/* Still OK? */
+			if (v != oldv) {
+				i -= 2;
+				continue;
+			}
+			ret[0] = v;
+			ret[1] = r;
+			return 1;
+		}
+
+		if (avpn & HPTE_V_SECONDARY)
+			break;
+		avpn |= HPTE_V_SECONDARY;
+		hash = hash ^ HPT_HASH_MASK;
+	}
+	return 0;
+}
+
+static unsigned long kvmppc_mmu_get_real_addr(unsigned long hpte[2],
+			unsigned long ea)
+{
+	unsigned int hpshift;
+	unsigned long r = hpte[1];
+	unsigned long ra_mask;
+
+	/* Get page size */
+	hpshift = 12;
+	if (hpte[0] & HPTE_V_LARGE) {
+		if ((r & 0xf000) == 0x1000)
+			hpshift = 16;
+		else if ((r & 0xff000) == 0)
+			hpshift = 24;
+		/* XXX TODO: Add 16G */
+	}
+	ra_mask = (1 << hpshift) - 1;
+
+	return (r & HPTE_R_RPN & ~ra_mask) | (ea & ra_mask);
+}
+
+static unsigned int kvmppc_mmu_get_pp_value(struct kvm_vcpu *vcpu,
+			struct kvmppc_slb *slbe, unsigned long hpte[2])
+{
+	unsigned int key, pp;
+
+	if (vcpu->arch.shared->msr & MSR_PR)
+		key = slbe->origv & SLB_VSID_KP;
+	else 
+		key = slbe->origv & SLB_VSID_KS;
+
+	pp = hpte[0] & HPTE_R_PP;
+	if (pp & HPTE_R_PP0)
+		pp |= 4;
+	if (key)
+		pp |= 8;
+	return pp;
+}
+
+/*
+ * XXX TODO: Handle key values from guest (add them to kvmppc_pte),
+ * for now we don't care tho as Linux guest doesn't use
+ * them. We also force key 31 for any MMIO emulation mapping
+ */
 static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
-				struct kvmppc_pte *gpte, bool data)
+			struct kvmppc_pte *gpte, bool data)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvmppc_slb *slbe;
+	unsigned int pp, skey;
+	unsigned long hpte[2];
+	unsigned long ra;
+
+	/* Get SLB entry */
+	slbe = kvmppc_mmu_book3s_hv_find_slbe(vcpu, eaddr);
+	if (!slbe)
+		return -EINVAL;
+
+	/* Find the HPTE in the hash table */
+	if (!kvmppc_hv_find_hpte(kvm, eaddr, slbe, hpte))
+		return -ENOENT;
+
+	gpte->eaddr = eaddr;
+	gpte->vpage = ((hpte[0] & HPTE_V_AVPN) << 4) | ((eaddr >> 12) & 0xfff);
+
+	/* Get the real address from the HPTE */
+	ra = kvmppc_mmu_get_real_addr(hpte, eaddr);
+
+	/* Get PP bits and key for permission check */
+	pp = kvmppc_mmu_get_pp_value(vcpu, slbe, hpte);
+
+	/* Calculate permissions */
+	gpte->may_execute = !(hpte[1] & (HPTE_R_N | HPTE_R_G));
+	gpte->may_read = pp_read_perm[pp];
+	gpte->may_write = pp_write_perm[pp];
+
+	/*
+	 * Get the storage key value.  31 means a special no-access
+	 * HPTE that we have inserted, with the guest physical address
+	 * in the RPN field.  Other keys mean that the the RPN field
+	 * contains the real address.
+	 */
+	skey = ((hpte[1] & HPTE_R_KEY_HI) >> 57) |
+		((hpte[1] & HPTE_R_KEY_LO) >> 9);
+	if (skey == 31) {
+		gpte->raddr = ra;
+		return 0;
+	}
+
+	gpte->raddr = back_translate(kvm, ra);
+	return 0;
+}
+
+int kvmppc_book3s_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	return -ENOENT;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvmppc_slb *slbe;
+	unsigned long hpte[2];
+	unsigned long srr0 = kvmppc_get_pc(vcpu);
+	unsigned long ea = vcpu->arch.fault_dar;	
+	unsigned long gpa;
+	unsigned int pp, ok;
+	u32 last_inst, dsisr = vcpu->arch.fault_dsisr;
+	int ret = 0;
+
+	/*
+	 * Translate the access address.
+	 * If we can't find the HPTE, just return and re-execute the
+	 * instruction.f
+ 	 */
+	slbe = kvmppc_mmu_book3s_hv_find_slbe(vcpu, ea);
+	if (!slbe)
+		return RESUME_GUEST;
+	if (!kvmppc_hv_find_hpte(kvm, ea, slbe, hpte))
+		return RESUME_GUEST;
+
+	/*
+	 * Check if this is a special HPTE (storage key = 31); if not then
+	 * this is just a key fault in the guest.
+	 */
+	if ((hpte[1] & (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) !=
+	    (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) {
+		vcpu->arch.shregs.dsisr = dsisr;
+		vcpu->arch.shregs.dar = ea;
+		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_DATA_STORAGE, 0);
+		return RESUME_GUEST;
+	}
+
+	/* Check whether the attempted access was permitted */
+	pp = kvmppc_mmu_get_pp_value(vcpu, slbe, hpte);
+	ok = (dsisr & DSISR_ISSTORE) ? pp_write_perm[pp] : pp_read_perm[pp];
+	if (!ok) {
+		vcpu->arch.shregs.dar = ea;
+		vcpu->arch.shregs.dsisr = (dsisr & DSISR_ISSTORE) |
+			DSISR_PROTFAULT;
+		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_DATA_STORAGE, 0);
+		return RESUME_GUEST;
+	}
+
+	/* Translate the logical address */
+	gpa = kvmppc_mmu_get_real_addr(hpte, ea);
+
+	/*
+	 * We try to load the last instruction.  We don't let
+	 * emulate_instruction do it as its failure mode is pretty bogus.
+	 * If we fail, we just return to the guest and try executing it again.
+	 */
+	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED) {
+		ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
+		if (ret != EMULATE_DONE)
+			return RESUME_GUEST;
+		vcpu->arch.last_inst = last_inst;
+	}
+
+	/*
+	 * XXX WARNING: We do not know for sure whether the instruction we just
+	 * read from memory is the same that caused the fault in the first
+	 * place. We don't have a problem with the guest shooting itself in
+	 * the foot that way, however we must be careful that we enforce
+	 * the write permission based on the instruction we are actually
+	 * emulating, not based on dsisr. Unfortunately, the KVM code for
+	 * instruction emulation isn't smart enough for that to work
+	 * so right now we just do it badly and racily, but that will need
+	 * fixing
+	 */
+
+	vcpu->arch.paddr_accessed = gpa;
+	return kvmppc_emulate_mmio(run, vcpu);
 }
 
 void kvmppc_mmu_book3s_hv_init(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index b8ad233..d1f0774 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -320,8 +320,15 @@ static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 * We get these next two if the guest does a bad real-mode access,
 	 * as we have enabled VRMA (virtualized real mode area) mode in the
 	 * LPCR.  We just generate an appropriate DSI/ISI to the guest.
+	 *
+	 * We also get them for MMIO emulation via key faults
 	 */
 	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
+		/* We attempt MMIO emulation for key faults */
+		if (vcpu->arch.fault_dsisr & DSISR_KEYFAULT) {
+			r = kvmppc_book3s_hv_emulate_mmio(run, vcpu);
+			break;
+		}
 		vcpu->arch.shregs.dsisr = vcpu->arch.fault_dsisr;
 		vcpu->arch.shregs.dar = vcpu->arch.fault_dar;
 		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_DATA_STORAGE, 0);
@@ -329,7 +336,7 @@ static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 	case BOOK3S_INTERRUPT_H_INST_STORAGE:
 		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_INST_STORAGE,
-					0x08000000);
+					vcpu->arch.shregs.msr & 0x78000000);
 		r = RESUME_GUEST;
 		break;
 	/*
@@ -1068,17 +1075,67 @@ static struct page *hva_to_page(unsigned long addr)
 }
 
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
-				struct kvm_userspace_memory_region *mem)
+				      struct kvm_memory_slot *memslot,
+				      struct kvm_userspace_memory_region *mem)
 {
 	unsigned long psize, porder;
 	unsigned long i, npages, totalpages;
 	unsigned long pg_ix;
 	struct kvmppc_pginfo *pginfo;
-	unsigned long hva;
 	struct kvmppc_rma_info *ri = NULL;
+	struct vm_area_struct *vma;
 	struct page *page;
+	unsigned long hva;
+
+	/*
+	 * This could be an attempt at adding memory or it could be MMIO
+	 * pass-through. We need to treat them differently but the only
+	 * way for us to know what it is is to look at the VMA and play
+	 * guess work so let's just do that
+	 */
+	down_read(&current->mm->mmap_sem);
+	vma = find_vma(current->mm, mem->userspace_addr);
+	if (!vma || vma->vm_start > mem->userspace_addr)
+		goto err_unlock;
+
+	/* Anything with VM_IO will be handled as MMIO pass-through */
+	if (vma->vm_flags & VM_IO) {
+		unsigned long offset = mem->userspace_addr - vma->vm_start;
+
+		/* We require VM_PFNMAP for now */
+		if (!(vma->vm_flags & VM_PFNMAP))
+			goto err_unlock;
+
+		/*
+		 * We require read & write permission as we cannot yet
+		 * enforce guest read-only protection or no access.
+		 */
+		if ((vma->vm_flags & (VM_READ | VM_WRITE)) !=
+		    (VM_READ | VM_WRITE))
+			goto err_unlock;
+
+		/*
+		 * Tag the memslot with a private flag and store the pfn
+		 * in a separate array for use by H_ENTER
+		 */
+		memslot->flags |= KVM_MEMSLOT_IO;
+		kvm->arch.io_slot_pfn[memslot->id] =
+			vma->vm_pgoff + (offset >> PAGE_SHIFT);
+		up_read(&current->mm->mmap_sem);
+		return 0;
+	}
+
+	/* Is this one of our preallocated RMAs? */
+	if (mem->guest_phys_addr == 0) {
+		if (vma && vma->vm_file &&
+		    vma->vm_file->f_op == &kvm_rma_fops &&
+		    mem->userspace_addr == vma->vm_start)
+			ri = vma->vm_file->private_data;
+	}
+
+	up_read(&current->mm->mmap_sem);
 
-	/* For now, only allow 16MB pages */
+	/* For now, only allow 16MB pages for memory */
 	porder = LARGE_PAGE_ORDER;
 	psize = 1ul << porder;
 	if ((mem->memory_size & (psize - 1)) ||
@@ -1102,23 +1159,13 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	if (totalpages > kvm->arch.ram_npages)
 		kvm->arch.ram_npages = totalpages;
 
-	/* Is this one of our preallocated RMAs? */
-	if (mem->guest_phys_addr == 0) {
-		struct vm_area_struct *vma;
-
-		down_read(&current->mm->mmap_sem);
-		vma = find_vma(current->mm, mem->userspace_addr);
-		if (vma && vma->vm_file &&
-		    vma->vm_file->f_op == &kvm_rma_fops &&
-		    mem->userspace_addr == vma->vm_start)
-			ri = vma->vm_file->private_data;
-		up_read(&current->mm->mmap_sem);
-		if (!ri && cpu_has_feature(CPU_FTR_ARCH_201)) {
-			pr_err("CPU requires an RMO\n");
-			return -EINVAL;
-		}
+	if (!ri && mem->guest_phys_addr == 0 &&
+	    cpu_has_feature(CPU_FTR_ARCH_201)) {
+		pr_err("CPU requires an RMO\n");
+		return -EINVAL;
 	}
 
+	/* Handle pre-allocated RMAs */
 	if (ri) {
 		unsigned long rma_size;
 		unsigned long lpcr;
@@ -1184,6 +1231,8 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 
 	return 0;
 
+ err_unlock:
+	up_read(&current->mm->mmap_sem);
  err:
 	return -EINVAL;
 }
@@ -1241,6 +1290,10 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 		lpcr &= LPCR_PECE | LPCR_LPES;
 		lpcr |= (4UL << LPCR_DPFD_SH) | LPCR_HDICE |
 			LPCR_VPM0 | LPCR_VRMA_L;
+		/* XXX Enable MMIO emu, we should probably do that
+		 *     only upon instruction from qemu... 
+		 */
+		lpcr |= LPCR_VPM1;
 	}
 	kvm->arch.lpcr = lpcr;
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index bacb0cf..6cb2f23 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -25,24 +25,26 @@
 #define HPT_NPTEG	(1ul << (HPT_ORDER - 7))	/* 128B per pteg */
 #define HPT_HASH_MASK	(HPT_NPTEG - 1)
 
-#define HPTE_V_HVLOCK	0x40UL
-
-static inline long lock_hpte(unsigned long *hpte, unsigned long bits)
+/*
+ * Since this file is built in even if KVM is a module, we need
+ * a local copy of this function for the case where kvm_main.c is
+ * modular.
+ */
+static struct kvm_memory_slot *builtin_gfn_to_memslot(struct kvm *kvm,
+						      gfn_t gfn)
 {
-	unsigned long tmp, old;
+	int i;
+	struct kvm_memslots *slots;
 
-	asm volatile("	ldarx	%0,0,%2\n"
-		     "	and.	%1,%0,%3\n"
-		     "	bne	2f\n"
-		     "	ori	%0,%0,%4\n"
-		     "  stdcx.	%0,0,%2\n"
-		     "	beq+	2f\n"
-		     "	li	%1,%3\n"
-		     "2:	isync"
-		     : "=&r" (tmp), "=&r" (old)
-		     : "r" (hpte), "r" (bits), "i" (HPTE_V_HVLOCK)
-		     : "cc", "memory");
-	return old == 0;
+	slots = kvm_memslots(kvm);
+	for (i = 0; i < slots->nmemslots; ++i) {
+		struct kvm_memory_slot *memslot = &slots->memslots[i];
+
+		if (gfn >= memslot->base_gfn
+		    && gfn < memslot->base_gfn + memslot->npages)
+			return memslot;
+	}
+	return NULL;
 }
 
 long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
@@ -50,7 +52,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 {
 	unsigned long porder;
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long i, lpn, pa;
+	unsigned long i, lpn, pa, gpa, psize;
 	unsigned long *hpte;
 
 	/* only handle 4k, 64k and 16M pages for now */
@@ -69,19 +71,88 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		} else
 			return H_PARAMETER;
 	}
-	lpn = (ptel & HPTE_R_RPN) >> kvm->arch.ram_porder;
-	if (lpn >= kvm->arch.ram_npages || porder > kvm->arch.ram_porder)
-		return H_PARAMETER;
-	pa = kvm->arch.ram_pginfo[lpn].pfn << PAGE_SHIFT;
-	if (!pa)
-		return H_PARAMETER;
-	/* Check WIMG */
-	if ((ptel & HPTE_R_WIMG) != HPTE_R_M &&
-	    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
+	psize = (1ul << porder);
+
+	/* We do not allow the guest to set key 31 which is reserved
+	 * for MMIO emulation. We don't want to allow MMIO emulation
+	 * to be used to access RAM due to possible races between
+	 * emulation and TLB invalidations.
+	 *
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
+	if ((ptel & (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) ==
+	    (HPTE_R_KEY_HI | HPTE_R_KEY_LO))
 		return H_PARAMETER;
+
+	/* Figure out the type of page and handle accordingly,
+	 * first check for RAM pages
+	 */
+	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
+	if ((gpa >> kvm->arch.ram_porder) < kvm->arch.ram_npages) {
+		lpn = (ptel & HPTE_R_RPN) >> kvm->arch.ram_porder;
+		if (porder > kvm->arch.ram_porder)
+			return H_PARAMETER;
+		pa = kvm->arch.ram_pginfo[lpn].pfn << PAGE_SHIFT;
+		if (!pa)
+			return H_PARAMETER;
+		/* Check WIMG */
+		if ((ptel & HPTE_R_WIMG) != HPTE_R_M &&
+		    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
+			return H_PARAMETER;
+		ptel &= ~(HPTE_R_PP0 - kvm->arch.ram_psize);
+		ptel |= pa;
+	} else {
+		struct kvm_memory_slot *memslot;
+
+		/* Check WIMG */
+		if ((ptel & HPTE_R_WIMG) != (HPTE_R_I) &&
+		    (ptel & HPTE_R_WIMG) != (HPTE_R_I | HPTE_R_G))
+			return H_PARAMETER;		
+
+		/* Else check for MMIO pass-through */
+		memslot = builtin_gfn_to_memslot(kvm, gpa >> PAGE_SHIFT);
+		if (memslot && memslot->flags & KVM_MEMSLOT_IO) {
+			unsigned long egfn = (gpa + psize) >> PAGE_SHIFT;
+
+			/* Check if the requested page fits entirely in
+			 * the memslot and check if the start pfn fits
+			 * out page size alignment
+			 */
+			if ((egfn - memslot->base_gfn) > memslot->npages)
+				return H_PARAMETER;
+			pa = kvm->arch.io_slot_pfn[memslot->id] << PAGE_SHIFT;
+			pa += gpa - (memslot->base_gfn << PAGE_SHIFT);
+			if (pa & (psize - 1))
+				return H_PARAMETER;
+
+			/* Make up HPTE */
+			ptel &= ~(HPTE_R_PP0 - psize);
+			ptel |= pa;
+		}
+		/* Else check for MMIO emulation */
+		else if (cpu_has_feature(CPU_FTR_ARCH_206)) {
+			/* Leave RPN intact */
+
+			/* We force no-execute and set key to 1 to cause
+			 * faults on access.
+			 * XXX Should we instead just return H_PARAMETER if
+			 * N isn't already set ?
+			 */
+			ptel |= HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_R_N;
+		} else
+			return H_PARAMETER;
+	}
 	pteh &= ~0x60UL;
-	ptel &= ~(HPTE_R_PP0 - kvm->arch.ram_psize);
-	ptel |= pa;
+	
 	if (pte_index >= (HPT_NPTEG << 3))
 		return H_PARAMETER;
 	if (likely((flags & H_EXACT) == 0)) {
@@ -91,21 +162,21 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			if (i == 8)
 				return H_PTEG_FULL;
 			if ((*hpte & HPTE_V_VALID) == 0 &&
-			    lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
+			    try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
 				break;
 			hpte += 2;
 		}
 	} else {
 		i = 0;
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-		if (!lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
+		if (!try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
 			return H_PTEG_FULL;
 	}
 	hpte[1] = ptel;
 	eieio();
 	hpte[0] = pteh;
 	asm volatile("ptesync" : : : "memory");
-	atomic_inc(&kvm->arch.ram_pginfo[lpn].refcnt);
+	// XXX atomic_inc(&kvm->arch.ram_pginfo[lpn].refcnt);
 	vcpu->arch.gpr[4] = pte_index + i;
 	return H_SUCCESS;
 }
@@ -141,7 +212,7 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	if (pte_index >= (HPT_NPTEG << 3))
 		return H_PARAMETER;
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-	while (!lock_hpte(hpte, HPTE_V_HVLOCK))
+	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
 	if ((hpte[0] & HPTE_V_VALID) == 0 ||
 	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) != avpn) ||
@@ -200,7 +271,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 			break;
 		}
 		hp = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-		while (!lock_hpte(hp, HPTE_V_HVLOCK))
+		while (!try_lock_hpte(hp, HPTE_V_HVLOCK))
 			cpu_relax();
 		found = 0;
 		if (hp[0] & HPTE_V_VALID) {
@@ -260,14 +331,19 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 
 	if (pte_index >= (HPT_NPTEG << 3))
 		return H_PARAMETER;
+	/* Don't let it set a normal memory page to key 31 */
+	if (((flags >> 9) & 0x1f) == 0x1f)
+		return H_PARAMETER;
+
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-	while (!lock_hpte(hpte, HPTE_V_HVLOCK))
+	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
 	if ((hpte[0] & HPTE_V_VALID) == 0 ||
 	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) != avpn)) {
 		hpte[0] &= ~HPTE_V_HVLOCK;
 		return H_NOT_FOUND;
 	}
+
 	if (atomic_read(&kvm->online_vcpus) == 1)
 		flags |= H_LOCAL;
 	v = hpte[0];
@@ -276,6 +352,12 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	r |= (flags << 55) & HPTE_R_PP0;
 	r |= (flags << 48) & HPTE_R_KEY_HI;
 	r |= flags & (HPTE_R_PP | HPTE_R_N | HPTE_R_KEY_LO);
+
+ 	/* Don't let guest remove N or key from emulated MMIO pages */
+	if ((hpte[1] & (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) == 
+	    (HPTE_R_KEY_HI | HPTE_R_KEY_LO))
+		r |= HPTE_R_N | HPTE_R_KEY_HI | HPTE_R_KEY_LO;
+		
 	rb = compute_tlbie_rb(v, r, pte_index);
 	hpte[0] = v & ~HPTE_V_VALID;
 	if (!(flags & H_LOCAL)) {
@@ -303,11 +385,12 @@ static unsigned long reverse_xlate(struct kvm *kvm, unsigned long realaddr)
 	long int i;
 	unsigned long offset, rpn;
 
+	/* XXX handle MMIO and EMU */
 	offset = realaddr & (kvm->arch.ram_psize - 1);
 	rpn = (realaddr - offset) >> PAGE_SHIFT;
 	for (i = 0; i < kvm->arch.ram_npages; ++i)
 		if (rpn == kvm->arch.ram_pginfo[i].pfn)
-			return (i << PAGE_SHIFT) + offset;
+			return (i << kvm->arch.ram_porder) + offset;
 	return HPTE_R_RPN;	/* all 1s in the RPN field */
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 44d8829..7916e1d 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -230,10 +230,19 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 	mtspr	SPRN_DABR,r6
 
 BEGIN_FTR_SECTION
-	/* Restore AMR and UAMOR, set AMOR to all 1s */
+	/* Restore AMR and UAMOR and set AMOR such that
+	 *
+	 *   - AMOR allow change to all keys except 31
+	 *   - AMR disables access for key 31
+	 *   - Other AMR and UAMOR bits are under guest control
+	 *
+	 * Key 31 is thus protected for use by MMIO emulation
+	 */
 	ld	r5,VCPU_AMR(r4)
 	ld	r6,VCPU_UAMOR(r4)
-	li	r7,-1
+	li	r7,-4 /* Disable access to key 31 */
+	ori	r5,r5,3
+	and	r6,r6,r7
 	mtspr	SPRN_AMR,r5
 	mtspr	SPRN_UAMOR,r6
 	mtspr	SPRN_AMOR,r7
@@ -544,13 +553,24 @@ kvmppc_interrupt:
 	 * Register contents:
 	 * R12		= interrupt vector
 	 * R13		= PACA
-	 * guest CR, R12 saved in shadow VCPU SCRATCH1/0
+	 * guest CR, R12 saved in PACA HSTATE_SCRATCH1/0
 	 * guest R13 saved in SPRN_SCRATCH0
 	 */
 	/* abuse host_r2 as third scratch area; we get r2 from PACATOC(r13) */
 	std	r9, HSTATE_HOST_R2(r13)
-	ld	r9, HSTATE_KVM_VCPU(r13)
 
+BEGIN_FTR_SECTION
+	/* check for HDSI/HISI for fast reflection to guest when
+	 * VPM is enabled
+	 */
+	cmpwi	r12, BOOK3S_INTERRUPT_H_DATA_STORAGE + 2
+	beq	kvmppc_hdsi
+	cmpwi	r12, BOOK3S_INTERRUPT_H_INST_STORAGE + 2
+	beq	kvmppc_hisi
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
+
+.Lhxsi_cont:
+	ld	r9, HSTATE_KVM_VCPU(r13)
 	/* Save registers */
 
 	std	r0, VCPU_GPR(r0)(r9)
@@ -631,7 +651,7 @@ hcall_real_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
 
 	/* Save HEIR (HV emulation assist reg) in last_inst
 	   if this is an HEI (HV emulation interrupt, e40) */
-	li	r3,-1
+	li	r3,KVM_INST_FETCH_FAILED
 BEGIN_FTR_SECTION
 	cmpwi	r12,BOOK3S_INTERRUPT_H_EMUL_ASSIST
 	bne	11f
@@ -649,7 +669,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 	std	r6, VCPU_DAR(r9)
 	stw	r7, VCPU_DSISR(r9)
 	std	r8, VCPU_CTR(r9)
-	/* grab HDAR & HDSISR if HV data storage interrupt (HDSI) */
+	/* grab HDAR & HDSISR if HV data storage interrupt (HDSI)
+	 * also try to load the instruction
+	 */
 BEGIN_FTR_SECTION
 	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
 	beq	6f
@@ -1091,11 +1113,108 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	mtspr	SPRN_HSRR1, r7
 	ba	0x500
 
+	/* Out of line H_DATA_STORAGE exception, grab HDAR and HDSISR
+	 * and try to load the instruction from guest memory. Note that
+	 * VCPU_LAST_INST has already been set to -1 at this point.
+	 */
 6:	mfspr	r6,SPRN_HDAR
 	mfspr	r7,SPRN_HDSISR
+
+	/* Only fetch instruction if guest IR relocation is enabled */
+	andi.	r0,r11,MSR_IR
+	beq	7b
+	
+	/* In case lwz faults */
+	li	r8,KVM_INST_FETCH_FAILED
+
+	/* Set guest mode to 'jump over instruction' so if lwz faults
+	 * we'll just continue at the next IP. */
+	li	r0,KVM_GUEST_MODE_SKIP
+	stb	r0,HSTATE_IN_GUEST(r13)
+
+	/* Do the access with MSR:DR enabled */
+	mfmsr	r3
+	ori	r4,r3,MSR_DR		/* Enable paging for data */
+	mtmsrd	r4
+	sync
+	lwz	r8,0(r10)
+	mtmsr	r3
+	sync
+
+	/* Store the result */
+	stw	r8,VCPU_LAST_INST(r9)
+
+	/* Unset guest mode. XXX This is a dup, maybe we could
+	 * move the original later in the code flow, just before
+	 * starting the MMU switch
+	 */
+	li	r0,KVM_GUEST_MODE_NONE
+	stb	r0,HSTATE_IN_GUEST(r13)
 	b	7b
 
 /*
+ * See if this H[DI]SI interrupt is one that can be bounced to the guest.
+ * It can be bounced immediately if it is not in real mode and is
+ * not a key fault (DSI) or not a non-exec fault (ISI).
+ *
+ * Here, r9, r12 and cr are saved in the PACA, r13 is saved in SPRN_SCRATCH0.
+ */
+kvmppc_hdsi:
+	std	r0, PACA_EXGEN(r13)
+	mfspr	r9, SPRN_HDSISR
+	mfspr	r12, SPRN_HSRR1
+	andis.	r0, r9, DSISR_KEYFAULT@h
+	bne	1f
+	andi.	r0, r12, MSR_DR
+	beq	1f
+	mfspr	r0, SPRN_HSRR0		/* turn it into a DSI for the guest */
+	mtspr	SPRN_DSISR, r9
+	mtspr	SPRN_SRR1, r12
+	mtspr	SPRN_SRR0, r0
+	mfspr	r9, SPRN_HDAR
+	li	r0, BOOK3S_INTERRUPT_DATA_STORAGE
+	li	r12, (MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
+	rotldi	r12, r12, 63
+	mtspr	SPRN_DAR, r9
+	mtspr	SPRN_HSRR0, r0
+	mtspr	SPRN_HSRR1, r12
+	lwz	r0, HSTATE_SCRATCH1(r13)
+	mtocrf	0x80, r0
+	ld	r9, HSTATE_HOST_R2(r13)
+	ld	r12, HSTATE_SCRATCH0(r13)
+	ld	r0, PACA_EXGEN(r13)
+	GET_SCRATCH0(r13)
+	hrfid
+	b	.
+1:	ld	r0, PACA_EXGEN(r13)
+	li	r12, BOOK3S_INTERRUPT_H_DATA_STORAGE + 2
+	b	.Lhxsi_cont
+
+kvmppc_hisi:
+	mfspr	r9, SPRN_HSRR1
+	andi.	r12, r9, MSR_IR
+	beq	1f
+	andis.	r12, r9, SRR1_ISI_N_OR_G@h
+	bne	1f
+	mfspr	r12, SPRN_HSRR0		/* turn it into a ISI for the guest */
+	mtspr	SPRN_SRR1, r9
+	mtspr	SPRN_SRR0, r12
+	li	r9, BOOK3S_INTERRUPT_INST_STORAGE
+	li	r12, (MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
+	rotldi	r12, r12, 63
+	mtspr	SPRN_HSRR0, r9
+	mtspr	SPRN_HSRR1, r12
+	lwz	r9, HSTATE_SCRATCH1(r13)
+	mtocrf	0x80, r9
+	ld	r9, HSTATE_HOST_R2(r13)
+	ld	r12, HSTATE_SCRATCH0(r13)
+	GET_SCRATCH0(r13)
+	hrfid
+	b	.
+1:	li	r12, BOOK3S_INTERRUPT_H_INST_STORAGE + 2
+	b	.Lhxsi_cont
+
+/*
  * Try to handle an hcall in real mode.
  * Returns to the guest if we handle it, or continues on up to
  * the kernel if we can't (i.e. if we don't have a handler for
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index f3a6414..30e7c2e 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1007,6 +1007,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 }
 
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
+				      struct kvm_memory_slot *memslot,
 				      struct kvm_userspace_memory_region *mem)
 {
 	return 0;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 9c78589..e9186e9 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -895,6 +895,7 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 }
 
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
+				      struct kvm_memory_slot *memslot,
 				      struct kvm_userspace_memory_region *mem)
 {
 	return 0;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index c33f6a7..084d1c5 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -265,7 +265,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
                                    struct kvm_userspace_memory_region *mem,
                                    int user_alloc)
 {
-	return kvmppc_core_prepare_memory_region(kvm, mem);
+	return kvmppc_core_prepare_memory_region(kvm, memslot, mem);
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index c107fae..774b04d 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -105,6 +105,9 @@ struct kvm_userspace_memory_region {
 #define KVM_MEM_LOG_DIRTY_PAGES  1UL
 #define KVM_MEMSLOT_INVALID      (1UL << 1)
 
+/* Kernel internal use */
+#define KVM_MEMSLOT_IO		 (1UL << 31)
+
 /* for KVM_IRQ_LINE */
 struct kvm_irq_level {
 	/*
-- 
1.7.7.2
