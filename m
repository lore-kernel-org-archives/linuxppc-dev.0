Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWVX2474TzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 15:24:49 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y5so11352691pff.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 20:24:49 -0800 (PST)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>, Alexander Graf <agraf@suse.de>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH] KVM: PPC: Book3S PR: close a race window when SVCPU pointer
 is hold before kvmppc_copy_from_svcpu()
Date: Wed, 31 Jan 2018 12:23:24 +0800
Message-Id: <1517372604-21405-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

commit 40fdd8c88c4a ("KVM: PPC: Book3S: PR: Make svcpu -> vcpu store
preempt savvy") and commit 3d3319b45eea ("KVM: PPC: Book3S: PR: Enable
interrupts earlier") is trying to turns on preemption early when
return into highmem guest exit handler.

However there is a race window in following example at
arch/powerpc/kvm/book3s_interrupts.S:

highmem guest exit handler:
...
195         GET_SHADOW_VCPU(r4)
196         bl      FUNC(kvmppc_copy_from_svcpu)
...
239         bl      FUNC(kvmppc_handle_exit_pr)

If there comes a preemption between line 195 and 196, line 196
may hold an invalid SVCPU reference with following sequence:
1) Qemu task T1 runs at GET_SHADOW_VCPU(r4) at line 195, on CPU A.
2) T1 is preempted and switch out CPU A. As a result, it checks
CPU A's svcpu->in_use (=1 at present) and flush cpu A's svcpu to
T1's vcpu.
3) Another task T2 switches into CPU A and it may update CPU A's
svcpu->in_use into 1.
4) T1 is scheduled into CPU B. But it still holds CPU A's svcpu
reference as R4. Then it executes kvmppc_copy_from_svcpu() with
R4 and it will corrupt T1's VCPU with T2's content. T2's VCPU
will also be impacted.

This patch moves the svcpu->in_use into VCPU so that the vcpus
sharing the same svcpu can work properly and fix the above case.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s_asm.h |  1 -
 arch/powerpc/include/asm/kvm_host.h       |  4 ++++
 arch/powerpc/kvm/book3s_pr.c              | 12 ++++++------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index ab386af..9a8ef23 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -142,7 +142,6 @@ struct kvmppc_host_state {
 };
 
 struct kvmppc_book3s_shadow_vcpu {
-	bool in_use;
 	ulong gpr[14];
 	u32 cr;
 	ulong xer;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 3aa5b57..4f54daf 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -781,6 +781,10 @@ struct kvm_vcpu_arch {
 	struct dentry *debugfs_dir;
 	struct dentry *debugfs_timings;
 #endif /* CONFIG_KVM_BOOK3S_HV_EXIT_TIMING */
+	bool svcpu_in_use; /* indicates whether current vcpu need copy svcpu
+			    * content to local.
+			    * false: no need to copy; true: need copy;
+			    */
 };
 
 #define VCPU_FPR(vcpu, i)	(vcpu)->arch.fp.fpr[i][TS_FPROFFSET]
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 7deaeeb..d791142 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -98,7 +98,7 @@ static void kvmppc_core_vcpu_load_pr(struct kvm_vcpu *vcpu, int cpu)
 	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
 	memcpy(svcpu->slb, to_book3s(vcpu)->slb_shadow, sizeof(svcpu->slb));
 	svcpu->slb_max = to_book3s(vcpu)->slb_shadow_max;
-	svcpu->in_use = 0;
+	vcpu->arch.svcpu_in_use = 0;
 	svcpu_put(svcpu);
 #endif
 
@@ -120,9 +120,9 @@ static void kvmppc_core_vcpu_put_pr(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
 	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
-	if (svcpu->in_use) {
+	if (vcpu->arch.svcpu_in_use)
 		kvmppc_copy_from_svcpu(vcpu, svcpu);
-	}
+
 	memcpy(to_book3s(vcpu)->slb_shadow, svcpu->slb, sizeof(svcpu->slb));
 	to_book3s(vcpu)->slb_shadow_max = svcpu->slb_max;
 	svcpu_put(svcpu);
@@ -176,7 +176,7 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 	vcpu->arch.entry_vtb = get_vtb();
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		vcpu->arch.entry_ic = mfspr(SPRN_IC);
-	svcpu->in_use = true;
+	vcpu->arch.svcpu_in_use = true;
 }
 
 /* Copy data touched by real-mode code from shadow vcpu back to vcpu */
@@ -193,7 +193,7 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 	 * Maybe we were already preempted and synced the svcpu from
 	 * our preempt notifiers. Don't bother touching this svcpu then.
 	 */
-	if (!svcpu->in_use)
+	if (!vcpu->arch.svcpu_in_use)
 		goto out;
 
 	vcpu->arch.gpr[0] = svcpu->gpr[0];
@@ -230,7 +230,7 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 	to_book3s(vcpu)->vtb += get_vtb() - vcpu->arch.entry_vtb;
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		vcpu->arch.ic += mfspr(SPRN_IC) - vcpu->arch.entry_ic;
-	svcpu->in_use = false;
+	vcpu->arch.svcpu_in_use = false;
 
 out:
 	preempt_enable();
-- 
1.8.3.1
