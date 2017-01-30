Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlnF1T92zDqFC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:09 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 12/20] KVM: PPC: Book3S HV: Modify guest entry/exit paths
 to handle radix guests
Date: Mon, 30 Jan 2017 21:21:45 +1100
Message-Id: <1485771713-24801-13-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds code to  branch around the parts that radix guests don't
need - clearing and loading the SLB with the guest SLB contents,
saving the guest SLB contents on exit, and restoring the host SLB
contents.

Since the host is now using radix, we need to save and restore the
host value for the PID register.

On hypervisor data/instruction storage interrupts, we don't do the
guest HPT lookup on radix, but just save the guest physical address
for the fault (from the ASDR register) in the vcpu struct.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_host.h     |  1 +
 arch/powerpc/kernel/asm-offsets.c       |  2 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 57 ++++++++++++++++++++++++++-------
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index fb73518..da1421a 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -606,6 +606,7 @@ struct kvm_vcpu_arch {
 	ulong fault_dar;
 	u32 fault_dsisr;
 	unsigned long intr_msr;
+	ulong fault_gpa;	/* guest real address of page fault (POWER9) */
 #endif
 
 #ifdef CONFIG_BOOKE
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 0601e6a..3afa0ad 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -498,6 +498,7 @@ int main(void)
 	DEFINE(KVM_NEED_FLUSH, offsetof(struct kvm, arch.need_tlb_flush.bits));
 	DEFINE(KVM_ENABLED_HCALLS, offsetof(struct kvm, arch.enabled_hcalls));
 	DEFINE(KVM_VRMA_SLB_V, offsetof(struct kvm, arch.vrma_slb_v));
+	DEFINE(KVM_RADIX, offsetof(struct kvm, arch.radix));
 	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
 	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
 	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
@@ -537,6 +538,7 @@ int main(void)
 	DEFINE(VCPU_SLB_NR, offsetof(struct kvm_vcpu, arch.slb_nr));
 	DEFINE(VCPU_FAULT_DSISR, offsetof(struct kvm_vcpu, arch.fault_dsisr));
 	DEFINE(VCPU_FAULT_DAR, offsetof(struct kvm_vcpu, arch.fault_dar));
+	DEFINE(VCPU_FAULT_GPA, offsetof(struct kvm_vcpu, arch.fault_gpa));
 	DEFINE(VCPU_INTR_MSR, offsetof(struct kvm_vcpu, arch.intr_msr));
 	DEFINE(VCPU_LAST_INST, offsetof(struct kvm_vcpu, arch.last_inst));
 	DEFINE(VCPU_TRAP, offsetof(struct kvm_vcpu, arch.trap));
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 75d4eb3..5a0749b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -518,6 +518,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 /* Stack frame offsets */
 #define STACK_SLOT_TID		(112-16)
 #define STACK_SLOT_PSSCR	(112-24)
+#define STACK_SLOT_PID		(112-32)
 
 .global kvmppc_hv_entry
 kvmppc_hv_entry:
@@ -530,6 +531,7 @@ kvmppc_hv_entry:
 	 * R1 = host R1
 	 * R2 = TOC
 	 * all other volatile GPRS = free
+	 * Does not preserve non-volatile GPRs or CR fields
 	 */
 	mflr	r0
 	std	r0, PPC_LR_STKOFF(r1)
@@ -549,32 +551,38 @@ kvmppc_hv_entry:
 	bl	kvmhv_start_timing
 1:
 #endif
-	/* Clear out SLB */
+
+	/* Use cr7 as an indication of radix mode */
+	ld	r5, HSTATE_KVM_VCORE(r13)
+	ld	r9, VCORE_KVM(r5)	/* pointer to struct kvm */
+	lbz	r0, KVM_RADIX(r9)
+	cmpwi	cr7, r0, 0
+
+	/* Clear out SLB if hash */
+	bne	cr7, 2f
 	li	r6,0
 	slbmte	r6,r6
 	slbia
 	ptesync
-
+2:
 	/*
 	 * POWER7/POWER8 host -> guest partition switch code.
 	 * We don't have to lock against concurrent tlbies,
 	 * but we do have to coordinate across hardware threads.
 	 */
 	/* Set bit in entry map iff exit map is zero. */
-	ld	r5, HSTATE_KVM_VCORE(r13)
 	li	r7, 1
 	lbz	r6, HSTATE_PTID(r13)
 	sld	r7, r7, r6
-	addi	r9, r5, VCORE_ENTRY_EXIT
-21:	lwarx	r3, 0, r9
+	addi	r8, r5, VCORE_ENTRY_EXIT
+21:	lwarx	r3, 0, r8
 	cmpwi	r3, 0x100		/* any threads starting to exit? */
 	bge	secondary_too_late	/* if so we're too late to the party */
 	or	r3, r3, r7
-	stwcx.	r3, 0, r9
+	stwcx.	r3, 0, r8
 	bne	21b
 
 	/* Primary thread switches to guest partition. */
-	ld	r9,VCORE_KVM(r5)	/* pointer to struct kvm */
 	cmpwi	r6,0
 	bne	10f
 	lwz	r7,KVM_LPID(r9)
@@ -658,7 +666,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	beq	kvmppc_primary_no_guest
 kvmppc_got_guest:
 
-	/* Load up guest SLB entries */
+	/* Load up guest SLB entries (N.B. slb_max will be 0 for radix) */
 	lwz	r5,VCPU_SLB_MAX(r4)
 	cmpwi	r5,0
 	beq	9f
@@ -696,8 +704,10 @@ kvmppc_got_guest:
 BEGIN_FTR_SECTION
 	mfspr	r5, SPRN_TIDR
 	mfspr	r6, SPRN_PSSCR
+	mfspr	r7, SPRN_PID
 	std	r5, STACK_SLOT_TID(r1)
 	std	r6, STACK_SLOT_PSSCR(r1)
+	std	r7, STACK_SLOT_PID(r1)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
 BEGIN_FTR_SECTION
@@ -1285,11 +1295,15 @@ mc_cont:
 	mtspr	SPRN_CTRLT,r6
 4:
 	/* Read the guest SLB and save it away */
+	ld	r5, VCPU_KVM(r9)
+	lbz	r0, KVM_RADIX(r5)
+	cmpwi	r0, 0
+	li	r5, 0
+	bne	3f			/* for radix, save 0 entries */
 	lwz	r0,VCPU_SLB_NR(r9)	/* number of entries in SLB */
 	mtctr	r0
 	li	r6,0
 	addi	r7,r9,VCPU_SLB
-	li	r5,0
 1:	slbmfee	r8,r6
 	andis.	r0,r8,SLB_ESID_V@h
 	beq	2f
@@ -1301,7 +1315,7 @@ mc_cont:
 	addi	r5,r5,1
 2:	addi	r6,r6,1
 	bdnz	1b
-	stw	r5,VCPU_SLB_MAX(r9)
+3:	stw	r5,VCPU_SLB_MAX(r9)
 
 	/*
 	 * Save the guest PURR/SPURR
@@ -1550,8 +1564,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 BEGIN_FTR_SECTION
 	ld	r5, STACK_SLOT_TID(r1)
 	ld	r6, STACK_SLOT_PSSCR(r1)
+	ld	r7, STACK_SLOT_PID(r1)
 	mtspr	SPRN_TIDR, r5
 	mtspr	SPRN_PSSCR, r6
+	mtspr	SPRN_PID, r7
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
 	/*
@@ -1663,6 +1679,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	isync
 
 	/* load host SLB entries */
+BEGIN_MMU_FTR_SECTION
+	b	0f
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 	ld	r8,PACA_SLBSHADOWPTR(r13)
 
 	.rept	SLB_NUM_BOLTED
@@ -1675,7 +1694,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	slbmte	r6,r5
 1:	addi	r8,r8,16
 	.endr
-
+0:
 #ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
 	/* Finish timing, if we have a vcpu */
 	ld	r4, HSTATE_KVM_VCPU(r13)
@@ -1702,8 +1721,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
  * reflect the HDSI to the guest as a DSI.
  */
 kvmppc_hdsi:
+	ld	r3, VCPU_KVM(r9)
+	lbz	r0, KVM_RADIX(r3)
+	cmpwi	r0, 0
 	mfspr	r4, SPRN_HDAR
 	mfspr	r6, SPRN_HDSISR
+	bne	.Lradix_hdsi		/* on radix, just save DAR/DSISR/ASDR */
 	/* HPTE not found fault or protection fault? */
 	andis.	r0, r6, (DSISR_NOHPTE | DSISR_PROTFAULT)@h
 	beq	1f			/* if not, send it to the guest */
@@ -1780,11 +1803,23 @@ fast_interrupt_c_return:
 	stb	r0, HSTATE_IN_GUEST(r13)
 	b	guest_exit_cont
 
+.Lradix_hdsi:
+	std	r4, VCPU_FAULT_DAR(r9)
+	stw	r6, VCPU_FAULT_DSISR(r9)
+.Lradix_hisi:
+	mfspr	r5, SPRN_ASDR
+	std	r5, VCPU_FAULT_GPA(r9)
+	b	guest_exit_cont
+
 /*
  * Similarly for an HISI, reflect it to the guest as an ISI unless
  * it is an HPTE not found fault for a page that we have paged out.
  */
 kvmppc_hisi:
+	ld	r3, VCPU_KVM(r9)
+	lbz	r0, KVM_RADIX(r3)
+	cmpwi	r0, 0
+	bne	.Lradix_hisi		/* for radix, just save ASDR */
 	andis.	r0, r11, SRR1_ISI_NOPT@h
 	beq	1f
 BEGIN_FTR_SECTION
-- 
2.7.4
