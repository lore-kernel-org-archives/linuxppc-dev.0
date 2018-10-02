Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1D8C004D2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:23:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B12B2064E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ot12XmhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B12B2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PdbF1hR9zF39y
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:23:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ot12XmhP";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSQ1JxrzF36K
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:32:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ot12XmhP"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSN4TgNz9sjB; Tue,  2 Oct 2018 21:32:04 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSN13bjz9sjD;
 Tue,  2 Oct 2018 21:32:04 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479924; bh=pXh22rNV2G1cs9MLmyBB/Q/ZTF34MNTYdqvG1i5RJ+A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ot12XmhPo2+GqySB7uNR1TU1EWOtvYRSTprOTgVhA0e5t7zPChbILvXNGskKELS8o
 4TfDzRw1ZSKlDSuuilO+60lX2hZTPOLEkrlkSfRGRJgFPWKZ7dA2a9aYl4y2r5cSUB
 898ksABPq+IVpXkNXg1GpEg/067b0LVyJmWamyPd4R+sA+kTMO8GpSIU/hfMSOU0dO
 2b9oq94nt0GAZxMDyvji1kTmaBszQ6vpp0U6vPEpeKPWJ+uVV0hLRbviZiqET1cloW
 M2YxwyUYadIqREomZTphmglDs7+6wIP/coDVS+QSHdZ9X06DWiAr/mKeVYXAMyhvtD
 H8xadfsuJNj4g==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 18/33] KVM: PPC: Book3S HV: Nested guest entry via hypercall
Date: Tue,  2 Oct 2018 21:31:17 +1000
Message-Id: <1538479892-14835-19-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds a new hypercall, H_ENTER_NESTED, which is used by a nested
hypervisor to enter one of its nested guests.  The hypercall supplies
register values in two structs.  Those values are copied by the level 0
(L0) hypervisor (the one which is running in hypervisor mode) into the
vcpu struct of the L1 guest, and then the guest is run until an
interrupt or error occurs which needs to be reported to L1 via the
hypercall return value.

Currently this assumes that the L0 and L1 hypervisors are the same
endianness, and the structs passed as arguments are in native
endianness.  If they are of different endianness, the version number
check will fail and the hcall will be rejected.

Nested hypervisors do not support indep_threads_mode=N, so this adds
code to print a warning message if the administrator has set
indep_threads_mode=N, and treat it as Y.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/hvcall.h       |  36 +++++
 arch/powerpc/include/asm/kvm_book3s.h   |   7 +
 arch/powerpc/include/asm/kvm_host.h     |   5 +
 arch/powerpc/kernel/asm-offsets.c       |   1 +
 arch/powerpc/kvm/book3s_hv.c            | 214 ++++++++++++++++++++++++-----
 arch/powerpc/kvm/book3s_hv_nested.c     | 230 ++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   8 ++
 7 files changed, 471 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index c95c651..45e8789 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -466,6 +466,42 @@ struct h_cpu_char_result {
 	u64 behaviour;
 };
 
+/* Register state for entering a nested guest with H_ENTER_NESTED */
+struct hv_guest_state {
+	u64 version;		/* version of this structure layout */
+	u32 lpid;
+	u32 vcpu_token;
+	/* These registers are hypervisor privileged (at least for writing) */
+	u64 lpcr;
+	u64 pcr;
+	u64 amor;
+	u64 dpdes;
+	u64 hfscr;
+	s64 tb_offset;
+	u64 dawr0;
+	u64 dawrx0;
+	u64 ciabr;
+	u64 hdec_expiry;
+	u64 purr;
+	u64 spurr;
+	u64 ic;
+	u64 vtb;
+	u64 hdar;
+	u64 hdsisr;
+	u64 heir;
+	u64 asdr;
+	/* These are OS privileged but need to be set late in guest entry */
+	u64 srr0;
+	u64 srr1;
+	u64 sprg[4];
+	u64 pidr;
+	u64 cfar;
+	u64 ppr;
+};
+
+/* Latest version of hv_guest_state structure */
+#define HV_GUEST_STATE_VERSION	1
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_HVCALL_H */
diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 43f212e..093fd70 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -280,6 +280,13 @@ void kvmhv_vm_nested_init(struct kvm *kvm);
 long kvmhv_set_partition_table(struct kvm_vcpu *vcpu);
 void kvmhv_set_ptbl_entry(unsigned int lpid, u64 dw0, u64 dw1);
 void kvmhv_release_all_nested(struct kvm *kvm);
+long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu);
+int kvmhv_run_single_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu,
+			  u64 time_limit, unsigned long lpcr);
+void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr);
+void kvmhv_restore_hv_return_state(struct kvm_vcpu *vcpu,
+				   struct hv_guest_state *hr);
+long int kvmhv_nested_page_fault(struct kvm_vcpu *vcpu);
 
 void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index c35d4f2..ceb9f20 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -95,6 +95,7 @@ struct dtl_entry;
 
 struct kvmppc_vcpu_book3s;
 struct kvmppc_book3s_shadow_vcpu;
+struct kvm_nested_guest;
 
 struct kvm_vm_stat {
 	ulong remote_tlb_flush;
@@ -786,6 +787,10 @@ struct kvm_vcpu_arch {
 	u32 emul_inst;
 
 	u32 online;
+
+	/* For support of nested guests */
+	struct kvm_nested_guest *nested;
+	u32 nested_vcpu_id;
 #endif
 
 #ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 7c3738d..d0abcbb 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -503,6 +503,7 @@ int main(void)
 	OFFSET(VCPU_VPA, kvm_vcpu, arch.vpa.pinned_addr);
 	OFFSET(VCPU_VPA_DIRTY, kvm_vcpu, arch.vpa.dirty);
 	OFFSET(VCPU_HEIR, kvm_vcpu, arch.emul_inst);
+	OFFSET(VCPU_NESTED, kvm_vcpu, arch.nested);
 	OFFSET(VCPU_CPU, kvm_vcpu, cpu);
 	OFFSET(VCPU_THREAD_CPU, kvm_vcpu, arch.thread_cpu);
 #endif
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ca2529e..9900fd8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -942,6 +942,13 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		break;
 	case H_ENTER_NESTED:
 		ret = H_FUNCTION;
+		if (!vcpu->kvm->arch.nested_enable)
+			break;
+		ret = kvmhv_enter_nested_guest(vcpu);
+		if (ret == H_INTERRUPT) {
+			kvmppc_set_gpr(vcpu, 3, 0);
+			return -EINTR;
+		}
 		break;
 	case H_TLB_INVALIDATE:
 		ret = H_FUNCTION;
@@ -1272,6 +1279,104 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return r;
 }
 
+static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
+{
+	int r;
+	int srcu_idx;
+
+	vcpu->stat.sum_exits++;
+
+	/*
+	 * This can happen if an interrupt occurs in the last stages
+	 * of guest entry or the first stages of guest exit (i.e. after
+	 * setting paca->kvm_hstate.in_guest to KVM_GUEST_MODE_GUEST_HV
+	 * and before setting it to KVM_GUEST_MODE_HOST_HV).
+	 * That can happen due to a bug, or due to a machine check
+	 * occurring at just the wrong time.
+	 */
+	if (vcpu->arch.shregs.msr & MSR_HV) {
+		pr_emerg("KVM trap in HV mode while nested!\n");
+		pr_emerg("trap=0x%x | pc=0x%lx | msr=0x%llx\n",
+			 vcpu->arch.trap, kvmppc_get_pc(vcpu),
+			 vcpu->arch.shregs.msr);
+		kvmppc_dump_regs(vcpu);
+		return RESUME_HOST;
+	}
+	switch (vcpu->arch.trap) {
+	/* We're good on these - the host merely wanted to get our attention */
+	case BOOK3S_INTERRUPT_HV_DECREMENTER:
+		vcpu->stat.dec_exits++;
+		r = RESUME_GUEST;
+		break;
+	case BOOK3S_INTERRUPT_EXTERNAL:
+		vcpu->stat.ext_intr_exits++;
+		r = RESUME_HOST;
+		break;
+	case BOOK3S_INTERRUPT_H_DOORBELL:
+	case BOOK3S_INTERRUPT_H_VIRT:
+		vcpu->stat.ext_intr_exits++;
+		r = RESUME_GUEST;
+		break;
+	/* SR/HMI/PMI are HV interrupts that host has handled. Resume guest.*/
+	case BOOK3S_INTERRUPT_HMI:
+	case BOOK3S_INTERRUPT_PERFMON:
+	case BOOK3S_INTERRUPT_SYSTEM_RESET:
+		r = RESUME_GUEST;
+		break;
+	case BOOK3S_INTERRUPT_MACHINE_CHECK:
+		/* Pass the machine check to the L1 guest */
+		r = RESUME_HOST;
+		/* Print the MCE event to host console. */
+		machine_check_print_event_info(&vcpu->arch.mce_evt, false);
+		break;
+	/*
+	 * We get these next two if the guest accesses a page which it thinks
+	 * it has mapped but which is not actually present, either because
+	 * it is for an emulated I/O device or because the corresonding
+	 * host page has been paged out.
+	 */
+	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
+		srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+		r = kvmhv_nested_page_fault(vcpu);
+		srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
+		break;
+	case BOOK3S_INTERRUPT_H_INST_STORAGE:
+		vcpu->arch.fault_dar = kvmppc_get_pc(vcpu);
+		vcpu->arch.fault_dsisr = kvmppc_get_msr(vcpu) &
+					 DSISR_SRR1_MATCH_64S;
+		if (vcpu->arch.shregs.msr & HSRR1_HISI_WRITE)
+			vcpu->arch.fault_dsisr |= DSISR_ISSTORE;
+		srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+		r = kvmhv_nested_page_fault(vcpu);
+		srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
+		break;
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	case BOOK3S_INTERRUPT_HV_SOFTPATCH:
+		/*
+		 * This occurs for various TM-related instructions that
+		 * we need to emulate on POWER9 DD2.2.  We have already
+		 * handled the cases where the guest was in real-suspend
+		 * mode and was transitioning to transactional state.
+		 */
+		r = kvmhv_p9_tm_emulation(vcpu);
+		break;
+#endif
+
+	case BOOK3S_INTERRUPT_HV_RM_HARD:
+		vcpu->arch.trap = 0;
+		r = RESUME_GUEST;
+		if (!xive_enabled())
+			kvmppc_xics_rm_complete(vcpu, 0);
+		break;
+	default:
+		r = RESUME_HOST;
+		break;
+	}
+
+	return r;
+}
+
 static int kvm_arch_vcpu_ioctl_get_sregs_hv(struct kvm_vcpu *vcpu,
 					    struct kvm_sregs *sregs)
 {
@@ -3098,7 +3203,8 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 /*
  * Load up hypervisor-mode registers on P9.
  */
-static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit)
+static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
+				     unsigned long lpcr)
 {
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 	s64 hdec;
@@ -3155,7 +3261,7 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit)
 
 	mtspr(SPRN_AMOR, ~0UL);
 
-	mtspr(SPRN_LPCR, vc->lpcr);
+	mtspr(SPRN_LPCR, lpcr);
 	isync();
 
 	kvmppc_xive_push_vcpu(vcpu);
@@ -3225,7 +3331,8 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit)
  * Virtual-mode guest entry for POWER9 and later when the host and
  * guest are both using the radix MMU.  The LPIDR has already been set.
  */
-int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit)
+int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
+			 unsigned long lpcr)
 {
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 	unsigned long host_dscr = mfspr(SPRN_DSCR);
@@ -3289,14 +3396,32 @@ int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit)
 
 	mtspr(SPRN_DEC, vcpu->arch.dec_expires - mftb());
 
-	if (vcpu->arch.doorbell_request) {
-		vc->dpdes = 1;
-		smp_wmb();
-		vcpu->arch.doorbell_request = 0;
+	if (kvmhv_on_pseries()) {
+		/* call our hypervisor to load up HV regs and go */
+		struct hv_guest_state hvregs;
+
+		kvmhv_save_hv_regs(vcpu, &hvregs);
+		hvregs.lpcr = lpcr;
+		vcpu->arch.regs.msr = vcpu->arch.shregs.msr;
+		hvregs.version = HV_GUEST_STATE_VERSION;
+		if (vcpu->arch.nested) {
+			hvregs.lpid = vcpu->arch.nested->shadow_lpid;
+			hvregs.vcpu_token = vcpu->arch.nested_vcpu_id;
+		} else {
+			hvregs.lpid = vcpu->kvm->arch.lpid;
+			hvregs.vcpu_token = vcpu->vcpu_id;
+		}
+		hvregs.hdec_expiry = time_limit;
+		trap = plpar_hcall_norets(H_ENTER_NESTED, __pa(&hvregs),
+					  __pa(&vcpu->arch.regs));
+		kvmhv_restore_hv_return_state(vcpu, &hvregs);
+		vcpu->arch.shregs.msr = vcpu->arch.regs.msr;
+		vcpu->arch.shregs.dar = mfspr(SPRN_DAR);
+		vcpu->arch.shregs.dsisr = mfspr(SPRN_DSISR);
+	} else {
+		trap = kvmhv_load_hv_regs_and_go(vcpu, time_limit, lpcr);
 	}
 
-	trap = kvmhv_load_hv_regs_and_go(vcpu, time_limit);
-
 	vcpu->arch.slb_max = 0;
 	dec = mfspr(SPRN_DEC);
 	tb = mftb();
@@ -3535,6 +3660,11 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	trace_kvmppc_vcore_wakeup(do_sleep, block_ns);
 }
 
+/*
+ * This never fails for a radix guest, as none of the operations it does
+ * for a radix guest can fail or have a way to report failure.
+ * kvmhv_run_single_vcpu() relies on this fact.
+ */
 static int kvmhv_setup_mmu(struct kvm_vcpu *vcpu)
 {
 	int r = 0;
@@ -3684,12 +3814,15 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	return vcpu->arch.ret;
 }
 
-static int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
-				 struct kvm_vcpu *vcpu, u64 time_limit)
+int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
+			  struct kvm_vcpu *vcpu, u64 time_limit,
+			  unsigned long lpcr)
 {
 	int trap, r, pcpu, pcpu0;
 	int srcu_idx;
 	struct kvmppc_vcore *vc;
+	struct kvm_nested_guest *nested = vcpu->arch.nested;
+	unsigned long lpid;
 
 	trace_kvmppc_run_vcpu_enter(vcpu);
 
@@ -3710,16 +3843,8 @@ static int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 	vc->runner = vcpu;
 
 	/* See if the MMU is ready to go */
-	if (!vcpu->kvm->arch.mmu_ready) {
-		r = kvmhv_setup_mmu(vcpu);
-		if (r) {
-			kvm_run->exit_reason = KVM_EXIT_FAIL_ENTRY;
-			kvm_run->fail_entry.
-				hardware_entry_failure_reason = 0;
-			vcpu->arch.ret = r;
-			goto out;
-		}
-	}
+	if (!vcpu->kvm->arch.mmu_ready)
+		kvmhv_setup_mmu(vcpu);
 
 	if (need_resched())
 		cond_resched();
@@ -3741,7 +3866,22 @@ static int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 	if (lazy_irq_pending() || need_resched() || !vcpu->kvm->arch.mmu_ready)
 		goto out;
 
-	kvmppc_core_prepare_to_enter(vcpu);
+	if (!nested) {
+		kvmppc_core_prepare_to_enter(vcpu);
+		if (vcpu->arch.doorbell_request) {
+			vc->dpdes = 1;
+			smp_wmb();
+			vcpu->arch.doorbell_request = 0;
+		}
+		if (test_bit(BOOK3S_IRQPRIO_EXTERNAL,
+			     &vcpu->arch.pending_exceptions))
+			lpcr |= LPCR_MER;
+	} else if (vcpu->arch.pending_exceptions ||
+		   vcpu->arch.doorbell_request ||
+		   xive_interrupt_pending(vcpu)) {
+		vcpu->arch.ret = RESUME_HOST;
+		goto out;
+	}
 
 	kvmppc_clear_host_core(pcpu);
 
@@ -3755,7 +3895,10 @@ static int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 	vc->vcore_state = VCORE_RUNNING;
 	trace_kvmppc_run_core(vc, 0);
 
-	mtspr(SPRN_LPID, vc->kvm->arch.lpid);
+	lpid = vc->kvm->arch.lpid;
+	if (nested)
+		lpid = nested->shadow_lpid;
+	mtspr(SPRN_LPID, lpid);
 	isync();
 
 	/* See comment above in kvmppc_run_core() about this */
@@ -3764,7 +3907,7 @@ static int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 		pcpu0 &= ~0x3UL;
 
 	if (cpumask_test_cpu(pcpu0, &vc->kvm->arch.need_tlb_flush)) {
-		radix__local_flush_tlb_lpid_guest(vc->kvm->arch.lpid);
+		radix__local_flush_tlb_lpid_guest(lpid);
 		/* Clear the bit after the TLB flush */
 		cpumask_clear_cpu(pcpu0, &vc->kvm->arch.need_tlb_flush);
 	}
@@ -3776,7 +3919,7 @@ static int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 
 	this_cpu_disable_ftrace();
 
-	trap = kvmhv_p9_guest_entry(vcpu, time_limit);
+	trap = kvmhv_p9_guest_entry(vcpu, time_limit, lpcr);
 	vcpu->arch.trap = trap;
 
 	this_cpu_enable_ftrace();
@@ -3801,8 +3944,12 @@ static int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 
 	trace_kvm_guest_exit(vcpu);
 	r = RESUME_GUEST;
-	if (trap)
-		r = kvmppc_handle_exit_hv(kvm_run, vcpu, current);
+	if (trap) {
+		if (!nested)
+			r = kvmppc_handle_exit_hv(kvm_run, vcpu, current);
+		else
+			r = kvmppc_handle_nested_exit(vcpu);
+	}
 	vcpu->arch.ret = r;
 
 	if (is_kvmppc_resume_guest(r) && vcpu->arch.ceded &&
@@ -3917,7 +4064,8 @@ static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
 
 	do {
 		if (kvm->arch.threads_indep && kvm_is_radix(kvm))
-			r = kvmhv_run_single_vcpu(run, vcpu, ~(u64)0);
+			r = kvmhv_run_single_vcpu(run, vcpu, ~(u64)0,
+						  vcpu->arch.vcore->lpcr);
 		else
 			r = kvmppc_run_vcpu(run, vcpu);
 
@@ -4467,8 +4615,14 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	 * On POWER9, we only need to do this if the "indep_threads_mode"
 	 * module parameter has been set to N.
 	 */
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		kvm->arch.threads_indep = indep_threads_mode;
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		if (!indep_threads_mode && !cpu_has_feature(CPU_FTR_HVMODE)) {
+			pr_warn("KVM: Ignoring indep_threads_mode=N in nested hypervisor\n");
+			kvm->arch.threads_indep = true;
+		} else {
+			kvm->arch.threads_indep = indep_threads_mode;
+		}
+	}
 	if (!kvm->arch.threads_indep)
 		kvm_hv_vm_activated();
 
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 3ae5c39..4a381b4 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -20,6 +20,231 @@ static struct patb_entry *pseries_partition_tb;
 
 static void kvmhv_update_ptbl_cache(struct kvm_nested_guest *gp);
 
+void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
+{
+	struct kvmppc_vcore *vc = vcpu->arch.vcore;
+
+	hr->pcr = vc->pcr;
+	hr->dpdes = vc->dpdes;
+	hr->hfscr = vcpu->arch.hfscr;
+	hr->tb_offset = vc->tb_offset;
+	hr->dawr0 = vcpu->arch.dawr;
+	hr->dawrx0 = vcpu->arch.dawrx;
+	hr->ciabr = vcpu->arch.ciabr;
+	hr->purr = vcpu->arch.purr;
+	hr->spurr = vcpu->arch.spurr;
+	hr->ic = vcpu->arch.ic;
+	hr->vtb = vc->vtb;
+	hr->srr0 = vcpu->arch.shregs.srr0;
+	hr->srr1 = vcpu->arch.shregs.srr1;
+	hr->sprg[0] = vcpu->arch.shregs.sprg0;
+	hr->sprg[1] = vcpu->arch.shregs.sprg1;
+	hr->sprg[2] = vcpu->arch.shregs.sprg2;
+	hr->sprg[3] = vcpu->arch.shregs.sprg3;
+	hr->pidr = vcpu->arch.pid;
+	hr->cfar = vcpu->arch.cfar;
+	hr->ppr = vcpu->arch.ppr;
+}
+
+static void save_hv_return_state(struct kvm_vcpu *vcpu, int trap,
+				 struct hv_guest_state *hr)
+{
+	struct kvmppc_vcore *vc = vcpu->arch.vcore;
+
+	hr->dpdes = vc->dpdes;
+	hr->hfscr = vcpu->arch.hfscr;
+	hr->purr = vcpu->arch.purr;
+	hr->spurr = vcpu->arch.spurr;
+	hr->ic = vcpu->arch.ic;
+	hr->vtb = vc->vtb;
+	hr->srr0 = vcpu->arch.shregs.srr0;
+	hr->srr1 = vcpu->arch.shregs.srr1;
+	hr->sprg[0] = vcpu->arch.shregs.sprg0;
+	hr->sprg[1] = vcpu->arch.shregs.sprg1;
+	hr->sprg[2] = vcpu->arch.shregs.sprg2;
+	hr->sprg[3] = vcpu->arch.shregs.sprg3;
+	hr->pidr = vcpu->arch.pid;
+	hr->cfar = vcpu->arch.cfar;
+	hr->ppr = vcpu->arch.ppr;
+	switch (trap) {
+	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
+		hr->hdar = vcpu->arch.fault_dar;
+		hr->hdsisr = vcpu->arch.fault_dsisr;
+		hr->asdr = vcpu->arch.fault_gpa;
+		break;
+	case BOOK3S_INTERRUPT_H_INST_STORAGE:
+		hr->asdr = vcpu->arch.fault_gpa;
+		break;
+	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
+		hr->heir = vcpu->arch.emul_inst;
+		break;
+	}
+}
+
+static void restore_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
+{
+	struct kvmppc_vcore *vc = vcpu->arch.vcore;
+
+	vc->pcr = hr->pcr;
+	vc->dpdes = hr->dpdes;
+	vcpu->arch.hfscr = hr->hfscr;
+	vcpu->arch.dawr = hr->dawr0;
+	vcpu->arch.dawrx = hr->dawrx0;
+	vcpu->arch.ciabr = hr->ciabr;
+	vcpu->arch.purr = hr->purr;
+	vcpu->arch.spurr = hr->spurr;
+	vcpu->arch.ic = hr->ic;
+	vc->vtb = hr->vtb;
+	vcpu->arch.shregs.srr0 = hr->srr0;
+	vcpu->arch.shregs.srr1 = hr->srr1;
+	vcpu->arch.shregs.sprg0 = hr->sprg[0];
+	vcpu->arch.shregs.sprg1 = hr->sprg[1];
+	vcpu->arch.shregs.sprg2 = hr->sprg[2];
+	vcpu->arch.shregs.sprg3 = hr->sprg[3];
+	vcpu->arch.pid = hr->pidr;
+	vcpu->arch.cfar = hr->cfar;
+	vcpu->arch.ppr = hr->ppr;
+}
+
+void kvmhv_restore_hv_return_state(struct kvm_vcpu *vcpu,
+				   struct hv_guest_state *hr)
+{
+	struct kvmppc_vcore *vc = vcpu->arch.vcore;
+
+	vc->dpdes = hr->dpdes;
+	vcpu->arch.hfscr = hr->hfscr;
+	vcpu->arch.purr = hr->purr;
+	vcpu->arch.spurr = hr->spurr;
+	vcpu->arch.ic = hr->ic;
+	vc->vtb = hr->vtb;
+	vcpu->arch.fault_dar = hr->hdar;
+	vcpu->arch.fault_dsisr = hr->hdsisr;
+	vcpu->arch.fault_gpa = hr->asdr;
+	vcpu->arch.emul_inst = hr->heir;
+	vcpu->arch.shregs.srr0 = hr->srr0;
+	vcpu->arch.shregs.srr1 = hr->srr1;
+	vcpu->arch.shregs.sprg0 = hr->sprg[0];
+	vcpu->arch.shregs.sprg1 = hr->sprg[1];
+	vcpu->arch.shregs.sprg2 = hr->sprg[2];
+	vcpu->arch.shregs.sprg3 = hr->sprg[3];
+	vcpu->arch.pid = hr->pidr;
+	vcpu->arch.cfar = hr->cfar;
+	vcpu->arch.ppr = hr->ppr;
+}
+
+long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
+{
+	long int err, r;
+	struct kvm_nested_guest *l2;
+	struct pt_regs l2_regs, saved_l1_regs;
+	struct hv_guest_state l2_hv, saved_l1_hv;
+	struct kvmppc_vcore *vc = vcpu->arch.vcore;
+	u64 hv_ptr, regs_ptr;
+	u64 hdec_exp;
+	s64 delta_purr, delta_spurr, delta_ic, delta_vtb;
+	u64 mask;
+	unsigned long lpcr;
+
+	if (vcpu->kvm->arch.l1_ptcr == 0)
+		return H_NOT_AVAILABLE;
+
+	/* copy parameters in */
+	hv_ptr = kvmppc_get_gpr(vcpu, 4);
+	err = kvm_vcpu_read_guest(vcpu, hv_ptr, &l2_hv,
+				  sizeof(struct hv_guest_state));
+	if (err)
+		return H_PARAMETER;
+	if (l2_hv.version != HV_GUEST_STATE_VERSION)
+		return H_P2;
+
+	regs_ptr = kvmppc_get_gpr(vcpu, 5);
+	err = kvm_vcpu_read_guest(vcpu, regs_ptr, &l2_regs,
+				  sizeof(struct pt_regs));
+	if (err)
+		return H_PARAMETER;
+
+	/* translate lpid */
+	l2 = kvmhv_get_nested(vcpu->kvm, l2_hv.lpid, true);
+	if (!l2)
+		return H_PARAMETER;
+	if (!l2->l1_gr_to_hr) {
+		mutex_lock(&l2->tlb_lock);
+		kvmhv_update_ptbl_cache(l2);
+		mutex_unlock(&l2->tlb_lock);
+	}
+
+	/* save l1 values of things */
+	vcpu->arch.regs.msr = vcpu->arch.shregs.msr;
+	saved_l1_regs = vcpu->arch.regs;
+	kvmhv_save_hv_regs(vcpu, &saved_l1_hv);
+
+	/* convert TB values/offsets to host (L0) values */
+	hdec_exp = l2_hv.hdec_expiry - vc->tb_offset;
+	vc->tb_offset += l2_hv.tb_offset;
+
+	/* set L1 state to L2 state */
+	vcpu->arch.nested = l2;
+	vcpu->arch.nested_vcpu_id = l2_hv.vcpu_token;
+	vcpu->arch.regs = l2_regs;
+	vcpu->arch.shregs.msr = vcpu->arch.regs.msr;
+	mask = LPCR_DPFD | LPCR_ILE | LPCR_TC | LPCR_AIL | LPCR_LD |
+		LPCR_LPES | LPCR_MER;
+	lpcr = (vc->lpcr & ~mask) | (l2_hv.lpcr & mask);
+	restore_hv_regs(vcpu, &l2_hv);
+
+	vcpu->arch.ret = RESUME_GUEST;
+	vcpu->arch.trap = 0;
+	do {
+		if (mftb() >= hdec_exp) {
+			vcpu->arch.trap = BOOK3S_INTERRUPT_HV_DECREMENTER;
+			r = RESUME_HOST;
+			break;
+		}
+		r = kvmhv_run_single_vcpu(vcpu->arch.kvm_run, vcpu, hdec_exp,
+					  lpcr);
+	} while (is_kvmppc_resume_guest(r));
+
+	/* save L2 state for return */
+	l2_regs = vcpu->arch.regs;
+	l2_regs.msr = vcpu->arch.shregs.msr;
+	delta_purr = vcpu->arch.purr - l2_hv.purr;
+	delta_spurr = vcpu->arch.spurr - l2_hv.spurr;
+	delta_ic = vcpu->arch.ic - l2_hv.ic;
+	delta_vtb = vc->vtb - l2_hv.vtb;
+	save_hv_return_state(vcpu, vcpu->arch.trap, &l2_hv);
+
+	/* restore L1 state */
+	vcpu->arch.nested = NULL;
+	vcpu->arch.regs = saved_l1_regs;
+	vcpu->arch.shregs.msr = saved_l1_regs.msr & ~MSR_TS_MASK;
+	/* set L1 MSR TS field according to L2 transaction state */
+	if (l2_regs.msr & MSR_TS_MASK)
+		vcpu->arch.shregs.msr |= MSR_TS_S;
+	vc->tb_offset = saved_l1_hv.tb_offset;
+	restore_hv_regs(vcpu, &saved_l1_hv);
+	vcpu->arch.purr += delta_purr;
+	vcpu->arch.spurr += delta_spurr;
+	vcpu->arch.ic += delta_ic;
+	vc->vtb += delta_vtb;
+
+	kvmhv_put_nested(l2);
+
+	/* copy l2_hv_state and regs back to guest */
+	err = kvm_vcpu_write_guest(vcpu, hv_ptr, &l2_hv,
+				   sizeof(struct hv_guest_state));
+	if (err)
+		return H_AUTHORITY;
+	err = kvm_vcpu_write_guest(vcpu, regs_ptr, &l2_regs,
+				   sizeof(struct pt_regs));
+	if (err)
+		return H_AUTHORITY;
+
+	if (r == -EINTR)
+		return H_INTERRUPT;
+
+	return vcpu->arch.trap;
+}
+
 long kvmhv_nested_init(void)
 {
 	long int ptb_order;
@@ -285,3 +510,8 @@ void kvmhv_put_nested(struct kvm_nested_guest *gp)
 	if (ref == 0)
 		kvmhv_release_nested(gp);
 }
+
+long kvmhv_nested_page_fault(struct kvm_vcpu *vcpu)
+{
+	return RESUME_HOST;
+}
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 83efc13..8da73ea 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1393,6 +1393,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 BEGIN_FTR_SECTION
 	PPC_MSGSYNC
 	lwsync
+	/* always exit if we're running a nested guest */
+	ld	r0, VCPU_NESTED(r9)
+	cmpdi	r0, 0
+	bne	guest_exit_cont
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	lbz	r0, HSTATE_HOST_IPI(r13)
 	cmpwi	r0, 0
@@ -2199,6 +2203,10 @@ hcall_try_real_mode:
 	andi.	r0,r11,MSR_PR
 	/* sc 1 from userspace - reflect to guest syscall */
 	bne	sc_1_fast_return
+	/* sc 1 from nested guest - give it to L1 to handle */
+	ld	r0, VCPU_NESTED(r9)
+	cmpdi	r0, 0
+	bne	guest_exit_cont
 	clrrdi	r3,r3,2
 	cmpldi	r3,hcall_real_table_end - hcall_real_table
 	bge	guest_exit_cont
-- 
2.7.4

