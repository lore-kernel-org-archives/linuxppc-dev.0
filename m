Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB97C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 05:54:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC2F2087D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 05:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="H64xrfxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC2F2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T8hM3R5jzDqf8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 16:54:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="H64xrfxD";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T89f0bXPzF37R
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:31:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="H64xrfxD"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T89d61FVzB2xn; Mon,  8 Oct 2018 16:31:33 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T89d3jc4zB2xk;
 Mon,  8 Oct 2018 16:31:33 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976693; bh=rhwZmTbPSGXuqzu5MmIcPN2GrDUqIBi5Ktej1eXaNjA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H64xrfxDFUsV3Q15mdeuKqXzHKcxnYXyDv+W+slKjCaEfNCeFf7aQKrRXQijCJQrQ
 Ni4dk+ySQYu/DHxXNvkkyhMiYwSc29WjQM1/D0V/J1DIPGxyl1JB8sT+47PobNRqfL
 bpeuHKcXn3/LCkA4DJ2IPITYDIjTQbTx5W5yRlDg7GoNmU2XGEw4LMXxHEg3I9gGvw
 9QC61k+wHc9qnJXJJNWCVK9eIg0bPNdvv/UQNd0l9p8IB/sBcVNe6l8JTxn3FidkN/
 zR5AFt/K27FXm5nn3uvo3yYWoThdG83xgGGqFP1H640JrCacbMTRaegZtlUhs8W2RG
 qzkTYq1yS144Q==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 08/33] KVM: PPC: Book3S HV: Call kvmppc_handle_exit_hv()
 with vcore unlocked
Date: Mon,  8 Oct 2018 16:30:54 +1100
Message-Id: <1538976679-1363-9-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
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

Currently kvmppc_handle_exit_hv() is called with the vcore lock held
because it is called within a for_each_runnable_thread loop.
However, we already unlock the vcore within kvmppc_handle_exit_hv()
under certain circumstances, and this is safe because (a) any vcpus
that become runnable and are added to the runnable set by
kvmppc_run_vcpu() have their vcpu->arch.trap == 0 and can't actually
run in the guest (because the vcore state is VCORE_EXITING), and
(b) for_each_runnable_thread is safe against addition or removal
of vcpus from the runnable set.

Therefore, in order to simplify things for following patches, let's
drop the vcore lock in the for_each_runnable_thread loop, so
kvmppc_handle_exit_hv() gets called without the vcore lock held.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 49a686c..0e17593 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1084,7 +1084,6 @@ static int kvmppc_emulate_doorbell_instr(struct kvm_vcpu *vcpu)
 	return RESUME_GUEST;
 }
 
-/* Called with vcpu->arch.vcore->lock held */
 static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				 struct task_struct *tsk)
 {
@@ -1205,10 +1204,7 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				swab32(vcpu->arch.emul_inst) :
 				vcpu->arch.emul_inst;
 		if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP) {
-			/* Need vcore unlocked to call kvmppc_get_last_inst */
-			spin_unlock(&vcpu->arch.vcore->lock);
 			r = kvmppc_emulate_debug_inst(run, vcpu);
-			spin_lock(&vcpu->arch.vcore->lock);
 		} else {
 			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
 			r = RESUME_GUEST;
@@ -1224,12 +1220,8 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	case BOOK3S_INTERRUPT_H_FAC_UNAVAIL:
 		r = EMULATE_FAIL;
 		if (((vcpu->arch.hfscr >> 56) == FSCR_MSGP_LG) &&
-		    cpu_has_feature(CPU_FTR_ARCH_300)) {
-			/* Need vcore unlocked to call kvmppc_get_last_inst */
-			spin_unlock(&vcpu->arch.vcore->lock);
+		    cpu_has_feature(CPU_FTR_ARCH_300))
 			r = kvmppc_emulate_doorbell_instr(vcpu);
-			spin_lock(&vcpu->arch.vcore->lock);
-		}
 		if (r == EMULATE_FAIL) {
 			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
 			r = RESUME_GUEST;
@@ -2599,6 +2591,14 @@ static void post_guest_process(struct kvmppc_vcore *vc, bool is_master)
 	spin_lock(&vc->lock);
 	now = get_tb();
 	for_each_runnable_thread(i, vcpu, vc) {
+		/*
+		 * It's safe to unlock the vcore in the loop here, because
+		 * for_each_runnable_thread() is safe against removal of
+		 * the vcpu, and the vcore state is VCORE_EXITING here,
+		 * so any vcpus becoming runnable will have their arch.trap
+		 * set to zero and can't actually run in the guest.
+		 */
+		spin_unlock(&vc->lock);
 		/* cancel pending dec exception if dec is positive */
 		if (now < vcpu->arch.dec_expires &&
 		    kvmppc_core_pending_dec(vcpu))
@@ -2614,6 +2614,7 @@ static void post_guest_process(struct kvmppc_vcore *vc, bool is_master)
 		vcpu->arch.ret = ret;
 		vcpu->arch.trap = 0;
 
+		spin_lock(&vc->lock);
 		if (is_kvmppc_resume_guest(vcpu->arch.ret)) {
 			if (vcpu->arch.pending_exceptions)
 				kvmppc_core_prepare_to_enter(vcpu);
-- 
2.7.4

