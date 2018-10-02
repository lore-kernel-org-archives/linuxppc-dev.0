Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40658C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:30:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B408C2064E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="bwR7YIRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B408C2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Pdl95hB4zDqws
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:29:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="bwR7YIRT";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSS4YB2zF35t
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:32:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="bwR7YIRT"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSR74BTz9sjB; Tue,  2 Oct 2018 21:32:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSR48DRz9sj0;
 Tue,  2 Oct 2018 21:32:07 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479927; bh=7xDyFLU+Vx1MM+08Lk93g+2vwJtItmtecR3HNZQ1Epk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bwR7YIRTwtwvl73Q1BEOZRkwTWioXneCD+tefbZK3pmbOM74L0k5qUNERglsj+2yR
 ZM7+ovmP3c48v4NQw4jDBNmkLkR2yzqRMRq4NNCJcVUb76Lmh5rNPNDHFIAe8vFNRI
 TPtFveflDneOdLwnAvDH3EQWYPvKuvm8Lp233AVbllKHzVfZeZrKMxFkYlAUbGT5Gw
 0oy8oOpNIekpYXnhOGTMlDoVleFzkAAYUooLQH4pCc+n2EmLzRTbYmoCQiNvqk6J2L
 Zwvv1H6lvS7OhDqYq4X01SCEC6lNQEoBvFnnqMsacecp3y0nLk/7mpsG4VwQ3ZDNEh
 NsE6gVZma4g5A==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 21/33] KVM: PPC: Book3S HV: Framework to handle HV
 Emulation Assist Interrupt
Date: Tue,  2 Oct 2018 21:31:20 +1000
Message-Id: <1538479892-14835-22-git-send-email-paulus@ozlabs.org>
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

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

A HEAI (hypervisor emulation assistance interrupt) occurs when a
hypervisor resource or instruction is used in a privileged but
non-hypervisor state and the LPCR_EVIRT bit is set in LPCR.  When
this occurs bit 45 is set in HSRR1.  Detect the occurrence of this,
and if userspace has enabled the nested virtualization capability
on the VM, then call the code to handle it accordingly.

With LPCR[EVIRT] set, we also get HEAI (without bit 45 set) for
mfspr or mtspr to unimplemented SPR numbers.  For these accesses,
we emulate the EVIRT=0 behaviour, which is to make the access
a no-op for privileged software unless it is accessing SPR 0,
4, 5 or 6.  Problem-state accesses and accesses to SPR 0, 4, 5
or 6 generate an illegal-instruction type program interrupt.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s.h |  2 +
 arch/powerpc/include/asm/reg.h        |  1 +
 arch/powerpc/kvm/book3s_hv.c          | 87 ++++++++++++++++++++++-------------
 arch/powerpc/kvm/book3s_hv_nested.c   | 55 ++++++++++++++++++++++
 4 files changed, 113 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 093fd70..0a97446 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -287,6 +287,8 @@ void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr);
 void kvmhv_restore_hv_return_state(struct kvm_vcpu *vcpu,
 				   struct hv_guest_state *hr);
 long int kvmhv_nested_page_fault(struct kvm_vcpu *vcpu);
+int kvmhv_emulate_priv(struct kvm_run *run, struct kvm_vcpu *vcpu,
+			unsigned int instr);
 
 void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 6fda746..9c42abf 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -456,6 +456,7 @@
 #define   LPCR_HVICE		ASM_CONST(0x0000000000000002)      /* P9: HV interrupt enable */
 #define   LPCR_HDICE		ASM_CONST(0x0000000000000001)      /* Hyp Decr enable (HV,PR,EE) */
 #define   LPCR_UPRT		ASM_CONST(0x0000000000400000)      /* Use Process Table (ISA 3) */
+#define   LPCR_EVIRT		ASM_CONST(0x0000000000200000)      /* Enhanced Virtualisation */
 #define   LPCR_HR		ASM_CONST(0x0000000000100000)
 #ifndef SPRN_LPID
 #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 134d7c7..b975683 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1027,30 +1027,6 @@ static int kvmppc_hcall_impl_hv(unsigned long cmd)
 	return kvmppc_hcall_impl_hv_realmode(cmd);
 }
 
-static int kvmppc_emulate_debug_inst(struct kvm_run *run,
-					struct kvm_vcpu *vcpu)
-{
-	u32 last_inst;
-
-	if (kvmppc_get_last_inst(vcpu, INST_GENERIC, &last_inst) !=
-					EMULATE_DONE) {
-		/*
-		 * Fetch failed, so return to guest and
-		 * try executing it again.
-		 */
-		return RESUME_GUEST;
-	}
-
-	if (last_inst == KVMPPC_INST_SW_BREAKPOINT) {
-		run->exit_reason = KVM_EXIT_DEBUG;
-		run->debug.arch.address = kvmppc_get_pc(vcpu);
-		return RESUME_HOST;
-	} else {
-		kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
-		return RESUME_GUEST;
-	}
-}
-
 static void do_nothing(void *x)
 {
 }
@@ -1144,6 +1120,23 @@ static int kvmppc_emulate_doorbell_instr(struct kvm_vcpu *vcpu)
 	return RESUME_GUEST;
 }
 
+static int kvmhv_emulate_unknown_spr(struct kvm_vcpu *vcpu, u32 instr)
+{
+	u32 spr = get_sprn(instr);
+
+	/*
+	 * In privileged state, access to unimplemented SPRs is a no-op
+	 * except for SPR 0, 4, 5 and 6.  All other accesses get turned
+	 * into illegal-instruction program interrupts.
+	 */
+	if ((vcpu->arch.shregs.msr & MSR_PR) ||
+	    spr == 0 || (4 <= spr && spr <= 6))
+		return EMULATE_FAIL;
+
+	kvmppc_set_pc(vcpu, kvmppc_get_pc(vcpu) + 4);
+	return RESUME_GUEST;
+}
+
 static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				 struct task_struct *tsk)
 {
@@ -1260,19 +1253,49 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 * to the guest. If guest debug is enabled, we need to check
 	 * whether the instruction is a software breakpoint instruction.
 	 * Accordingly return to Guest or Host.
+	 * With LPCR[EVIRT] set, we also get these for accesses to
+	 * unknown SPRs and for guests executing hypervisor privileged
+	 * instructions.
 	 */
 	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
-		if (vcpu->arch.emul_inst != KVM_INST_FETCH_FAILED)
-			vcpu->arch.last_inst = kvmppc_need_byteswap(vcpu) ?
-				swab32(vcpu->arch.emul_inst) :
-				vcpu->arch.emul_inst;
-		if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP) {
-			r = kvmppc_emulate_debug_inst(run, vcpu);
+	{
+		u32 instr = vcpu->arch.emul_inst;
+		unsigned long srr1_bit = SRR1_PROGILL;
+
+		vcpu->arch.last_inst = kvmppc_need_byteswap(vcpu) ?
+			swab32(instr) : instr;
+
+		r = EMULATE_FAIL;
+		if (vcpu->arch.shregs.msr & SRR1_PROGPRIV) {
+			/*
+			 * Tried to execute hypervisor privileged instruction
+			 * or mtspr/mfspr on a hypervisor privileged SPR while
+			 * MSR(HV | PR) == 0b00 -> Privileged but !HV state
+			 */
+			srr1_bit = SRR1_PROGPRIV;
+			if (vcpu->kvm->arch.nested_enable)
+				r = kvmhv_emulate_priv(run, vcpu, instr);
 		} else {
-			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
+			/* Illegal instruction or unknown SPR access */
+			if (instr == KVMPPC_INST_SW_BREAKPOINT &&
+			    (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP)) {
+				run->exit_reason = KVM_EXIT_DEBUG;
+				run->debug.arch.address = kvmppc_get_pc(vcpu);
+				r = RESUME_HOST;
+				break;
+			}
+			if ((instr & 0xfc0006fe) == PPC_INST_MFSPR)
+				/* mfspr or mtspr to unknown SPR, may be noop */
+				r = kvmhv_emulate_unknown_spr(vcpu, instr);
+		}
+		if (r == EMULATE_FAIL) {
+			pr_debug("KVM: Couldn't emulate instruction 0x%.8x\n",
+				 instr);
+			kvmppc_core_queue_program(vcpu, srr1_bit);
 			r = RESUME_GUEST;
 		}
 		break;
+	}
 	/*
 	 * This occurs if the guest (kernel or userspace), does something that
 	 * is prohibited by HFSCR.
@@ -4612,7 +4635,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	 */
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		lpcr &= ~LPCR_VPM0;
-		lpcr |= LPCR_HVICE | LPCR_HEIC;
+		lpcr |= LPCR_HVICE | LPCR_HEIC | LPCR_EVIRT;
 
 		/*
 		 * If xive is enabled, we route 0x500 interrupts directly
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 4a381b4..f8f9fab 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -15,6 +15,7 @@
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
+#include <asm/disassemble.h>
 
 static struct patb_entry *pseries_partition_tb;
 
@@ -515,3 +516,57 @@ long kvmhv_nested_page_fault(struct kvm_vcpu *vcpu)
 {
 	return RESUME_HOST;
 }
+
+static int kvmhv_emulate_priv_mtspr(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				    unsigned int instr)
+{
+	return EMULATE_FAIL;
+}
+
+static int kvmhv_emulate_priv_mfspr(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				    unsigned int instr)
+{
+	return EMULATE_FAIL;
+}
+
+static int kvmhv_emulate_priv_op_31(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				    unsigned int instr)
+{
+	return EMULATE_FAIL;
+}
+
+static int kvmhv_emulate_priv_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				  unsigned int instr)
+{
+	return EMULATE_FAIL;
+}
+
+int kvmhv_emulate_priv(struct kvm_run *run, struct kvm_vcpu *vcpu,
+			unsigned int instr)
+{
+	int rc = EMULATE_FAIL;
+
+	switch (get_op(instr)) {
+	case 31:
+		switch (get_xop(instr)) {
+		case OP_31_XOP_MTSPR:
+			rc = kvmhv_emulate_priv_mtspr(run, vcpu, instr);
+			break;
+		case OP_31_XOP_MFSPR:
+			rc = kvmhv_emulate_priv_mfspr(run, vcpu, instr);
+			break;
+		default:
+			rc = kvmhv_emulate_priv_op_31(run, vcpu, instr);
+			break;
+		}
+
+		if (rc == EMULATE_DONE)
+			kvmppc_set_pc(vcpu, kvmppc_get_pc(vcpu) + 4);
+		break;
+	default:
+		rc = kvmhv_emulate_priv_op(run, vcpu, instr);
+		break;
+	}
+
+	return rc;
+}
-- 
2.7.4

