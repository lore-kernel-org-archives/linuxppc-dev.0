Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3497E2C0309
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 19:20:20 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
Date: Fri, 28 Jun 2013 12:20:03 +0300
Message-ID: <1372411203-14795-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1372411203-14795-1-git-send-email-mihai.caraman@freescale.com>
References: <1372411203-14795-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

lwepx faults needs to be handled by KVM and this implies additional code
in DO_KVM macro to identify the source of the exception originated from
host context. This requires to check the Exception Syndrome Register
(ESR[EPID]) and External PID Load Context Register (EPLC[EGS]) for DTB_MISS,
DSI and LRAT exceptions which is too intrusive for the host.

Get rid of lwepx and acquire last instuction in kvmppc_handle_exit() by
searching for the physical address and kmap it. This fixes an infinite loop
caused by lwepx's data TLB miss handled in the host and the TODO for TLB
eviction and execute-but-not-read entries.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
Resend this pacth for Alex G. he was unsubscribed from kvm-ppc mailist
for a while.

 arch/powerpc/include/asm/mmu-book3e.h |    6 ++-
 arch/powerpc/kvm/booke.c              |    6 +++
 arch/powerpc/kvm/booke.h              |    2 +
 arch/powerpc/kvm/bookehv_interrupts.S |   32 ++-------------
 arch/powerpc/kvm/e500.c               |    4 ++
 arch/powerpc/kvm/e500mc.c             |   69 +++++++++++++++++++++++++++++++++
 6 files changed, 91 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 99d43e0..32e470e 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -40,7 +40,10 @@
 
 /* MAS registers bit definitions */
 
-#define MAS0_TLBSEL(x)		(((x) << 28) & 0x30000000)
+#define MAS0_TLBSEL_MASK	0x30000000
+#define MAS0_TLBSEL_SHIFT	28
+#define MAS0_TLBSEL(x)		(((x) << MAS0_TLBSEL_SHIFT) & MAS0_TLBSEL_MASK)
+#define MAS0_GET_TLBSEL(mas0)	(((mas0) & MAS0_TLBSEL_MASK) >> MAS0_TLBSEL_SHIFT)
 #define MAS0_ESEL_MASK		0x0FFF0000
 #define MAS0_ESEL_SHIFT		16
 #define MAS0_ESEL(x)		(((x) << MAS0_ESEL_SHIFT) & MAS0_ESEL_MASK)
@@ -58,6 +61,7 @@
 #define MAS1_TSIZE_MASK		0x00000f80
 #define MAS1_TSIZE_SHIFT	7
 #define MAS1_TSIZE(x)		(((x) << MAS1_TSIZE_SHIFT) & MAS1_TSIZE_MASK)
+#define MAS1_GET_TSIZE(mas1)	(((mas1) & MAS1_TSIZE_MASK) >> MAS1_TSIZE_SHIFT)
 
 #define MAS2_EPN		(~0xFFFUL)
 #define MAS2_X0			0x00000040
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 1020119..6764a8e 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -836,6 +836,12 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	/* update before a new last_exit_type is rewritten */
 	kvmppc_update_timing_stats(vcpu);
 
+	/*
+	 * The exception type can change at this point, such as if the TLB entry
+	 * for the emulated instruction has been evicted.
+	 */
+	kvmppc_prepare_for_emulation(vcpu, &exit_nr);
+
 	/* restart interrupts if they were meant for the host */
 	kvmppc_restart_interrupt(vcpu, exit_nr);
 
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index 5fd1ba6..a0d0fea 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -90,6 +90,8 @@ void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu);
 void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void kvmppc_booke_vcpu_put(struct kvm_vcpu *vcpu);
 
+void kvmppc_prepare_for_emulation(struct kvm_vcpu *vcpu, unsigned int *exit_nr);
+
 enum int_class {
 	INT_CLASS_NONCRIT,
 	INT_CLASS_CRIT,
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 20c7a54..0538ab9 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -120,37 +120,20 @@
 
 	.if	\flags & NEED_EMU
 	/*
-	 * This assumes you have external PID support.
-	 * To support a bookehv CPU without external PID, you'll
-	 * need to look up the TLB entry and create a temporary mapping.
-	 *
-	 * FIXME: we don't currently handle if the lwepx faults.  PR-mode
-	 * booke doesn't handle it either.  Since Linux doesn't use
-	 * broadcast tlbivax anymore, the only way this should happen is
-	 * if the guest maps its memory execute-but-not-read, or if we
-	 * somehow take a TLB miss in the middle of this entry code and
-	 * evict the relevant entry.  On e500mc, all kernel lowmem is
-	 * bolted into TLB1 large page mappings, and we don't use
-	 * broadcast invalidates, so we should not take a TLB miss here.
-	 *
-	 * Later we'll need to deal with faults here.  Disallowing guest
-	 * mappings that are execute-but-not-read could be an option on
-	 * e500mc, but not on chips with an LRAT if it is used.
+	 * We don't use external PID support. lwepx faults would need to be
+	 * handled by KVM and this implies aditional code in DO_KVM (for
+	 * DTB_MISS, DSI and LRAT) to check ESR[EPID] and EPLC[EGS] which
+	 * is too intrusive for the host. Get last instuction in
+	 * kvmppc_handle_exit().
 	 */
-
-	mfspr	r3, SPRN_EPLC	/* will already have correct ELPID and EGS */
 	PPC_STL	r15, VCPU_GPR(R15)(r4)
 	PPC_STL	r16, VCPU_GPR(R16)(r4)
 	PPC_STL	r17, VCPU_GPR(R17)(r4)
 	PPC_STL	r18, VCPU_GPR(R18)(r4)
 	PPC_STL	r19, VCPU_GPR(R19)(r4)
-	mr	r8, r3
 	PPC_STL	r20, VCPU_GPR(R20)(r4)
-	rlwimi	r8, r6, EPC_EAS_SHIFT - MSR_IR_LG, EPC_EAS
 	PPC_STL	r21, VCPU_GPR(R21)(r4)
-	rlwimi	r8, r6, EPC_EPR_SHIFT - MSR_PR_LG, EPC_EPR
 	PPC_STL	r22, VCPU_GPR(R22)(r4)
-	rlwimi	r8, r10, EPC_EPID_SHIFT, EPC_EPID
 	PPC_STL	r23, VCPU_GPR(R23)(r4)
 	PPC_STL	r24, VCPU_GPR(R24)(r4)
 	PPC_STL	r25, VCPU_GPR(R25)(r4)
@@ -160,11 +143,6 @@
 	PPC_STL	r29, VCPU_GPR(R29)(r4)
 	PPC_STL	r30, VCPU_GPR(R30)(r4)
 	PPC_STL	r31, VCPU_GPR(R31)(r4)
-	mtspr	SPRN_EPLC, r8
-	isync
-	lwepx   r9, 0, r5
-	mtspr	SPRN_EPLC, r3
-	stw	r9, VCPU_LAST_INST(r4)
 	.endif
 
 	.if	\flags & NEED_ESR
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index ce6b73c..c82a89f 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -439,6 +439,10 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
 	return r;
 }
 
+void kvmppc_prepare_for_emulation(struct kvm_vcpu *vcpu, unsigned int *exit_nr)
+{
+}
+
 struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500;
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index c3bdc0a..3641df7 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -271,6 +271,75 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
 	return r;
 }
 
+void kvmppc_prepare_for_emulation(struct kvm_vcpu *vcpu, unsigned int *exit_nr)
+{
+	gva_t geaddr;
+	hpa_t addr;
+	u64 mas7_mas3;
+	hva_t eaddr;
+	u32 mas1, mas3;
+	struct page *page;
+	unsigned int addr_space, psize_shift;
+	bool pr;
+
+	if ((*exit_nr != BOOKE_INTERRUPT_DATA_STORAGE) &&
+	    (*exit_nr != BOOKE_INTERRUPT_DTLB_MISS) &&
+	    (*exit_nr != BOOKE_INTERRUPT_HV_PRIV))
+		return;
+
+	/* Search guest translation to find the real addressss */
+	geaddr = vcpu->arch.pc;
+	addr_space = (vcpu->arch.shared->msr & MSR_IS) >> MSR_IR_LG;
+	mtspr(SPRN_MAS6, (vcpu->arch.pid << MAS6_SPID_SHIFT) | addr_space);
+	mtspr(SPRN_MAS5, MAS5_SGS | vcpu->kvm->arch.lpid);
+	isync();
+	asm volatile("tlbsx 0, %[geaddr]\n" : : [geaddr] "r" (geaddr));
+	mtspr(SPRN_MAS5, 0);
+	mtspr(SPRN_MAS8, 0);	
+
+	mas1 = mfspr(SPRN_MAS1);
+	if (!(mas1 & MAS1_VALID)) {
+		/*
+	 	 * There is no translation for the emulated instruction.
+		 * Simulate an instruction TLB miss. This should force the host
+		 * or ultimately the guest to add the translation and then
+		 * reexecute the instruction.
+		 */
+		*exit_nr = BOOKE_INTERRUPT_ITLB_MISS;
+		return;
+	}
+
+	mas3 = mfspr(SPRN_MAS3);
+	pr = vcpu->arch.shared->msr & MSR_PR;
+	if ((pr && (!(mas3 & MAS3_UX))) || ((!pr) && (!(mas3 & MAS3_SX)))) {
+	 	/*
+		 * Another thread may rewrite the TLB entry in parallel, don't
+		 * execute from the address if the execute permission is not set
+		 */
+		vcpu->arch.fault_esr = 0;
+		*exit_nr = BOOKE_INTERRUPT_INST_STORAGE;
+		return;
+	}
+
+	/* Get page size */
+	if (MAS0_GET_TLBSEL(mfspr(SPRN_MAS0)) == 0)
+		psize_shift = PAGE_SHIFT;
+	else
+		psize_shift = MAS1_GET_TSIZE(mas1) + 10;
+
+	mas7_mas3 = (((u64) mfspr(SPRN_MAS7)) << 32) |
+		    mfspr(SPRN_MAS3);
+	addr = (mas7_mas3 & (~0ULL << psize_shift)) |
+	       (geaddr & ((1ULL << psize_shift) - 1ULL));
+
+	/* Map a page and get guest's instruction */
+	page = pfn_to_page(addr >> PAGE_SHIFT);
+	eaddr = (unsigned long)kmap_atomic(page);
+	eaddr |= addr & ~PAGE_MASK;
+	vcpu->arch.last_inst = *(u32 *)eaddr;
+	kunmap_atomic((u32 *)eaddr);
+}
+
 struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500;
-- 
1.7.4.1
