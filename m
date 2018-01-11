Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMCH1krCzF0RN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:13:15 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id d23so1312402pfe.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:13:15 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 23/26] KVM: PPC: Book3S PR: add emulation for tabort. for
 privilege guest
Date: Thu, 11 Jan 2018 18:11:36 +0800
Message-Id: <1515665499-31710-24-git-send-email-wei.guo.simon@gmail.com>
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

Currently privilege guest will be run with TM disabled.

Although the privilege guest cannot initiate a new transaction,
it can use tabort to terminate its problem state's transaction.
So it is still necessary to emulate tabort. for privilege guest.

This patch adds emulation for tabort. of privilege guest.

Tested with:
https://github.com/justdoitqd/publicFiles/blob/master/test_tabort.c

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  1 +
 arch/powerpc/kvm/book3s_emulate.c     | 31 +++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_pr.c          |  2 +-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 524cd82..8bd454c 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -258,6 +258,7 @@ extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu);
 void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu);
 void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu);
+void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu);
 #endif
 
 extern int kvm_irq_bypass;
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 52a2e46..65eb236 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -50,6 +50,7 @@
 #define OP_31_XOP_SLBMFEE	915
 
 #define OP_31_XOP_TBEGIN	654
+#define OP_31_XOP_TABORT	910
 
 #define OP_31_XOP_TRECLAIM	942
 #define OP_31_XOP_TRCHKPT	1006
@@ -193,6 +194,19 @@ static void kvmppc_emulate_trchkpt(struct kvm_vcpu *vcpu)
 	guest_msr |= MSR_TS_S;
 	kvmppc_set_msr(vcpu, guest_msr);
 }
+
+/* emulate tabort. at guest privilege state */
+static void kvmppc_emulate_tabort(struct kvm_vcpu *vcpu, int ra_val)
+{
+	/* currently we only emulate tabort. but no emulation of other
+	 * tabort variants since there is no kernel usage of them at
+	 * present.
+	 */
+	tm_enable();
+	tm_abort(ra_val);
+	tm_disable();
+}
+
 #endif
 
 int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
@@ -459,6 +473,23 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				emulated = EMULATE_FAIL;
 			break;
 		}
+		case OP_31_XOP_TABORT:
+		{
+			ulong guest_msr = kvmppc_get_msr(vcpu);
+			unsigned long ra_val = 0;
+
+			/* only emulate for privilege guest, since problem state
+			 * guest can run with TM enabled and we don't expect to
+			 * trap at here for that case.
+			 */
+			WARN_ON(guest_msr & MSR_PR);
+
+			if (ra)
+				ra_val = kvmppc_get_gpr(vcpu, ra);
+
+			kvmppc_emulate_tabort(vcpu, ra_val);
+			break;
+		}
 		case OP_31_XOP_TRECLAIM:
 		{
 			ulong guest_msr = kvmppc_get_msr(vcpu);
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 1d105fa..f65415b 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -246,7 +246,7 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 }
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-static inline void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu)
+inline void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu)
 {
 	tm_enable();
 	vcpu->arch.tfhar = mfspr(SPRN_TFHAR);
-- 
1.8.3.1
