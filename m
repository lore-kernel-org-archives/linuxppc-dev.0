Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMBD0vzLzF0Yp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:12:20 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id e3so1306371pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:12:20 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 08/26] KVM: PPC: Book3S PR: Sync TM bits to shadow msr for
 problem state guest
Date: Thu, 11 Jan 2018 18:11:21 +0800
Message-Id: <1515665499-31710-9-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

MSR TS bits can be modified with non-privileged instruction like
tbegin./tend.  That means guest can change MSR value "silently" without
notifying host.

It is necessary to sync the TM bits to host so that host can calculate
shadow msr correctly.

note privilege guest will always fail transactions so we only take
care of problem state guest.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_pr.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 4e9acdd..7ec866a 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -977,6 +977,9 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 {
 	int r = RESUME_HOST;
 	int s;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	ulong old_msr = kvmppc_get_msr(vcpu);
+#endif
 
 	vcpu->stat.sum_exits++;
 
@@ -988,6 +991,28 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	trace_kvm_exit(exit_nr, vcpu);
 	guest_exit();
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/*
+	 * Unlike other MSR bits, MSR[TS]bits can be changed at guest without
+	 * notifying host:
+	 *  modified by unprivileged instructions like "tbegin"/"tend"/
+	 * "tresume"/"tsuspend" in PR KVM guest.
+	 *
+	 * It is necessary to sync here to calculate a correct shadow_msr.
+	 *
+	 * privileged guest's tbegin will be failed at present. So we
+	 * only take care of problem state guest.
+	 */
+	if (unlikely((old_msr & MSR_PR) &&
+		(vcpu->arch.shadow_srr1 & (MSR_TS_MASK)) !=
+				(old_msr & (MSR_TS_MASK)))) {
+		old_msr &= ~(MSR_TS_MASK);
+		old_msr |= (vcpu->arch.shadow_srr1 & (MSR_TS_MASK));
+		kvmppc_set_msr_fast(vcpu, old_msr);
+		kvmppc_recalc_shadow_msr(vcpu);
+	}
+#endif
+
 	switch (exit_nr) {
 	case BOOK3S_INTERRUPT_INST_STORAGE:
 	{
-- 
1.8.3.1
