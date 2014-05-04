Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B836D1401B4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 03:26:15 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 5 May 2014 03:26:15 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6975A2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 03:26:13 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s44H4wom1442232
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 03:04:58 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s44HQCi6007915
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 03:26:13 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] KVM: PPC: BOOK3S: PR: Fix WARN_ON with debug options on
Date: Sun,  4 May 2014 22:56:08 +0530
Message-Id: <1399224368-22122-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With debug option "sleep inside atomic section checking" enabled we get
the below WARN_ON during a PR KVM boot. This is because upstream now
have PREEMPT_COUNT enabled even if we have preempt disabled. Fix the
warning by adding preempt_disable/enable around floating point and altivec
enable.

WARNING: at arch/powerpc/kernel/process.c:156
Modules linked in: kvm_pr kvm
CPU: 1 PID: 3990 Comm: qemu-system-ppc Tainted: G        W     3.15.0-rc1+ #4
task: c0000000eb85b3a0 ti: c0000000ec59c000 task.ti: c0000000ec59c000
NIP: c000000000015c84 LR: d000000003334644 CTR: c000000000015c00
REGS: c0000000ec59f140 TRAP: 0700   Tainted: G        W      (3.15.0-rc1+)
MSR: 8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 42000024  XER: 20000000
CFAR: c000000000015c24 SOFTE: 1
GPR00: d000000003334644 c0000000ec59f3c0 c000000000e2fa40 c0000000e2f80000
GPR04: 0000000000000800 0000000000002000 0000000000000001 8000000000000000
GPR08: 0000000000000001 0000000000000001 0000000000002000 c000000000015c00
GPR12: d00000000333da18 c00000000fb80900 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 00003fffce4e0fa1
GPR20: 0000000000000010 0000000000000001 0000000000000002 00000000100b9a38
GPR24: 0000000000000002 0000000000000000 0000000000000000 0000000000000013
GPR28: 0000000000000000 c0000000eb85b3a0 0000000000002000 c0000000e2f80000
NIP [c000000000015c84] .enable_kernel_fp+0x84/0x90
LR [d000000003334644] .kvmppc_handle_ext+0x134/0x190 [kvm_pr]
Call Trace:
[c0000000ec59f3c0] [0000000000000010] 0x10 (unreliable)
[c0000000ec59f430] [d000000003334644] .kvmppc_handle_ext+0x134/0x190 [kvm_pr]
[c0000000ec59f4c0] [d00000000324b380] .kvmppc_set_msr+0x30/0x50 [kvm]
[c0000000ec59f530] [d000000003337cac] .kvmppc_core_emulate_op_pr+0x16c/0x5e0 [kvm_pr]
[c0000000ec59f5f0] [d00000000324a944] .kvmppc_emulate_instruction+0x284/0xa80 [kvm]
[c0000000ec59f6c0] [d000000003336888] .kvmppc_handle_exit_pr+0x488/0xb70 [kvm_pr]
[c0000000ec59f790] [d000000003338d34] kvm_start_lightweight+0xcc/0xdc [kvm_pr]
[c0000000ec59f960] [d000000003336288] .kvmppc_vcpu_run_pr+0xc8/0x190 [kvm_pr]
[c0000000ec59f9f0] [d00000000324c880] .kvmppc_vcpu_run+0x30/0x50 [kvm]
[c0000000ec59fa60] [d000000003249e74] .kvm_arch_vcpu_ioctl_run+0x54/0x1b0 [kvm]
[c0000000ec59faf0] [d000000003244948] .kvm_vcpu_ioctl+0x478/0x760 [kvm]
[c0000000ec59fcb0] [c000000000224e34] .do_vfs_ioctl+0x4d4/0x790
[c0000000ec59fd90] [c000000000225148] .SyS_ioctl+0x58/0xb0
[c0000000ec59fe30] [c00000000000a1e4] syscall_exit+0x0/0x98

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_pr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index c5c052a9729c..f30cdfee800d 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -683,16 +683,20 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 #endif
 
 	if (msr & MSR_FP) {
+		preempt_disable();
 		enable_kernel_fp();
 		load_fp_state(&vcpu->arch.fp);
 		t->fp_save_area = &vcpu->arch.fp;
+		preempt_enable();
 	}
 
 	if (msr & MSR_VEC) {
 #ifdef CONFIG_ALTIVEC
+		preempt_disable();
 		enable_kernel_altivec();
 		load_vr_state(&vcpu->arch.vr);
 		t->vr_save_area = &vcpu->arch.vr;
+		preempt_enable();
 #endif
 	}
 
@@ -716,13 +720,17 @@ static void kvmppc_handle_lost_ext(struct kvm_vcpu *vcpu)
 		return;
 
 	if (lost_ext & MSR_FP) {
+		preempt_disable();
 		enable_kernel_fp();
 		load_fp_state(&vcpu->arch.fp);
+		preempt_enable();
 	}
 #ifdef CONFIG_ALTIVEC
 	if (lost_ext & MSR_VEC) {
+		preempt_disable();
 		enable_kernel_altivec();
 		load_vr_state(&vcpu->arch.vr);
+		preempt_enable();
 	}
 #endif
 	current->thread.regs->msr |= lost_ext;
-- 
1.9.1
