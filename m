Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q5nZ5GpQzF0dS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:45:54 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id a20-v6so6469874pfo.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 21:45:54 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v3 11/29] KVM: PPC: Book3S PR: implement RFID TM behavior to
 suppress change from S0 to N0
Date: Mon, 21 May 2018 12:09:28 +0800
Message-Id: <1526875786-10372-12-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
References: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Accordingly to ISA specification for RFID, in MSR TM disabled and TS
suspended state(S0), if the target MSR is TM disabled and TS state is
inactive(N0), rfid should suppress this update.

This patch make RFID emulation of PR KVM to be consistent with this.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_emulate.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 68d6898..2eb457b 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -117,11 +117,28 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	case 19:
 		switch (get_xop(inst)) {
 		case OP_19_XOP_RFID:
-		case OP_19_XOP_RFI:
+		case OP_19_XOP_RFI: {
+			unsigned long srr1 = kvmppc_get_srr1(vcpu);
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+			unsigned long cur_msr = kvmppc_get_msr(vcpu);
+
+			/*
+			 * add rules to fit in ISA specification regarding TM
+			 * state transistion in TM disable/Suspended state,
+			 * and target TM state is TM inactive(00) state. (the
+			 * change should be suppressed).
+			 */
+			if (((cur_msr & MSR_TM) == 0) &&
+				((srr1 & MSR_TM) == 0) &&
+				MSR_TM_SUSPENDED(cur_msr) &&
+				!MSR_TM_ACTIVE(srr1))
+				srr1 |= MSR_TS_S;
+#endif
 			kvmppc_set_pc(vcpu, kvmppc_get_srr0(vcpu));
-			kvmppc_set_msr(vcpu, kvmppc_get_srr1(vcpu));
+			kvmppc_set_msr(vcpu, srr1);
 			*advance = 0;
 			break;
+		}
 
 		default:
 			emulated = EMULATE_FAIL;
-- 
1.8.3.1
