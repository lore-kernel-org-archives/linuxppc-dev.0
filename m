Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D302140111
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2014 10:46:05 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v2 4/4] KVM: PPC: Bookehv: Get vcpu's last instruction for
 emulation
Date: Thu, 1 May 2014 03:45:52 +0300
Message-ID: <1398905152-18091-5-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1398905152-18091-1-git-send-email-mihai.caraman@freescale.com>
References: <1398905152-18091-1-git-send-email-mihai.caraman@freescale.com>
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

On bookehv vcpu's last instruction is read using load external pid
(lwepx) instruction. lwepx exceptions (DTLB_MISS, DSI and LRAT) need
to be handled by KVM. These exceptions originate from host state
(MSR[GS] = 0) which implies additional checks in DO_KVM macro (beside
the current MSR[GS] = 1) by looking at the Exception Syndrome Register
(ESR[EPID]) and the External PID Load Context Register (EPLC[EGS]).
Doing this on each Data TLB miss exception is obvious too intrusive
for the host.

Get rid of lwepx and acquire last instuction in kvmppc_get_last_inst()
by searching for the physical address and kmap it. This fixes an
infinite loop caused by lwepx's data TLB miss handled in the host
and the TODO for TLB eviction and execute-but-not-read entries.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v2:
 - reworked patch description
 - used pr_* functions
 - addressed cosmetic feedback

 arch/powerpc/kvm/bookehv_interrupts.S | 37 ++++----------
 arch/powerpc/kvm/e500_mmu_host.c      | 93 ++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 925da71..65eff4c 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -122,38 +122,14 @@
 1:
 
 	.if	\flags & NEED_EMU
-	/*
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
-	 */
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
@@ -163,10 +139,15 @@
 	PPC_STL	r29, VCPU_GPR(R29)(r4)
 	PPC_STL	r30, VCPU_GPR(R30)(r4)
 	PPC_STL	r31, VCPU_GPR(R31)(r4)
-	mtspr	SPRN_EPLC, r8
-	isync
-	lwepx   r9, 0, r5
-	mtspr	SPRN_EPLC, r3
+
+	/*
+	 * We don't use external PID support. lwepx faults would need to be
+	 * handled by KVM and this implies aditional code in DO_KVM (for
+	 * DTB_MISS, DSI and LRAT) to check ESR[EPID] and EPLC[EGS] which
+	 * is too intrusive for the host. Get last instuction in
+	 * kvmppc_get_last_inst().
+	 */
+	li	r9, KVM_INST_FETCH_FAILED
 	stw	r9, VCPU_LAST_INST(r4)
 	.endif
 
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index fcccbb3..94b8be0 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -607,11 +607,102 @@ void kvmppc_mmu_map(struct kvm_vcpu *vcpu, u64 eaddr, gpa_t gpaddr,
 	}
 }
 
+#ifdef CONFIG_KVM_BOOKE_HV
+int kvmppc_ld_inst(struct kvm_vcpu *vcpu, u32 *instr)
+{
+	gva_t geaddr;
+	hpa_t addr;
+	hfn_t pfn;
+	hva_t eaddr;
+	u32 mas0, mas1, mas2, mas3;
+	u64 mas7_mas3;
+	struct page *page;
+	unsigned int addr_space, psize_shift;
+	bool pr;
+	unsigned long flags;
+
+	/* Search TLB for guest pc to get the real address */
+	geaddr = kvmppc_get_pc(vcpu);
+	addr_space = (vcpu->arch.shared->msr & MSR_IS) >> MSR_IR_LG;
+
+	local_irq_save(flags);
+	mtspr(SPRN_MAS6, (vcpu->arch.pid << MAS6_SPID_SHIFT) | addr_space);
+	mtspr(SPRN_MAS5, MAS5_SGS | vcpu->kvm->arch.lpid);
+	asm volatile("tlbsx 0, %[geaddr]\n" : :
+		     [geaddr] "r" (geaddr));
+	mtspr(SPRN_MAS5, 0);
+	mtspr(SPRN_MAS8, 0);
+	mas0 = mfspr(SPRN_MAS0);
+	mas1 = mfspr(SPRN_MAS1);
+	mas2 = mfspr(SPRN_MAS2);
+	mas3 = mfspr(SPRN_MAS3);
+	mas7_mas3 = (((u64) mfspr(SPRN_MAS7)) << 32) | mas3;
+	local_irq_restore(flags);
+
+	/*
+	 * If the TLB entry for guest pc was evicted, return to the guest.
+	 * There are high chances to find a valid TLB entry next time.
+	 */
+	if (!(mas1 & MAS1_VALID))
+		return EMULATE_AGAIN;
 
+	/*
+	 * Another thread may rewrite the TLB entry in parallel, don't
+	 * execute from the address if the execute permission is not set
+	 */
+	pr = vcpu->arch.shared->msr & MSR_PR;
+	if ((pr && !(mas3 & MAS3_UX)) || (!pr && !(mas3 & MAS3_SX))) {
+		pr_debug("Instuction emulation from a guest page\n"
+				"withot execute permission\n");
+		kvmppc_core_queue_program(vcpu, 0);
+		return EMULATE_AGAIN;
+	}
+
+	/*
+	 * We will map the real address through a cacheable page, so we will
+	 * not support cache-inhibited guest pages. Fortunately emulated
+	 * instructions should not live there.
+	 */
+	if (mas2 & MAS2_I) {
+		pr_debug("Instuction emulation from cache-inhibited\n"
+				"guest pages is not supported\n");
+		return EMULATE_FAIL;
+	}
+
+	/* Get page size */
+	psize_shift = MAS1_GET_TSIZE(mas1) + 10;
+
+	/* Map a page and get guest's instruction */
+	addr = (mas7_mas3 & (~0ULL << psize_shift)) |
+	       (geaddr & ((1ULL << psize_shift) - 1ULL));
+	pfn = addr >> PAGE_SHIFT;
+
+	/* Guard us against emulation from devices area */
+	if (unlikely(!page_is_ram(pfn))) {
+		pr_debug("Instruction emulation from non-RAM host\n"
+				"pages is not supported\n");
+		return EMULATE_FAIL;
+	}
+
+	if (unlikely(!pfn_valid(pfn))) {
+		pr_debug("Invalid frame number\n");
+		return EMULATE_FAIL;
+	}
+
+	page = pfn_to_page(pfn);
+	eaddr = (unsigned long)kmap_atomic(page);
+	eaddr |= addr & ~PAGE_MASK;
+	*instr = *(u32 *)eaddr;
+	kunmap_atomic((u32 *)eaddr);
+
+	return EMULATE_DONE;
+}
+#else
 int kvmppc_ld_inst(struct kvm_vcpu *vcpu, u32 *instr)
 {
 	return EMULATE_FAIL;
-}
+};
+#endif
 
 /************* MMU Notifiers *************/
 
-- 
1.7.11.7
