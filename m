Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F5961A04F5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jun 2014 07:08:30 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 15 Jun 2014 07:08:27 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3693E2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jun 2014 07:08:23 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5EKkHDW11075986
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jun 2014 06:46:18 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5EL8M4V009085
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jun 2014 07:08:22 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/kvm: support to handle sw breakpoint
Date: Sun, 15 Jun 2014 02:38:17 +0530
Message-Id: <1402780097-28827-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds kernel side support for software breakpoint.
Design is that, by using an illegal instruction, we trap to hypervisor
via Emulation Assistance interrupt, where we check for the illegal instruction
and accordingly we return to Host or Guest. Patch mandates use of "abs" instruction
(primary opcode 31 and extended opcode 360) as sw breakpoint instruction.
Based on PowerISA v2.01, ABS instruction has been dropped from the architecture
and treated an illegal instruction.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s.c    |  3 ++-
 arch/powerpc/kvm/book3s_hv.c | 23 +++++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index c254c27..b40fe5d 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -789,7 +789,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
-	return -EINVAL;
+	vcpu->guest_debug = dbg->control;
+	return 0;
 }
 
 void kvmppc_decrementer_func(unsigned long data)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7a12edb..688421d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -67,6 +67,14 @@
 /* Used as a "null" value for timebase values */
 #define TB_NIL	(~(u64)0)
 
+/*
+ * SW_BRK_DBG_INT is debug Instruction for supporting Software Breakpoint.
+ * Instruction mnemonic is ABS, primary opcode is 31 and extended opcode is 360.
+ * Based on PowerISA v2.01, ABS instruction has been dropped from the architecture
+ * and treated an illegal instruction.
+ */
+#define SW_BRK_DBG_INT 0x7c0002d0
+
 static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
 static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu);
 
@@ -721,12 +729,19 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 	/*
 	 * This occurs if the guest executes an illegal instruction.
-	 * We just generate a program interrupt to the guest, since
-	 * we don't emulate any guest instructions at this stage.
+	 * To support software breakpoint, we check for the sw breakpoint
+	 * instruction to return back to host, if not we just generate a
+	 * program interrupt to the guest.
 	 */
 	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
-		kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
-		r = RESUME_GUEST;
+		if (vcpu->arch.last_inst == SW_BRK_DBG_INT) {
+			run->exit_reason = KVM_EXIT_DEBUG;
+			run->debug.arch.address = vcpu->arch.pc;
+			r = RESUME_HOST;
+		} else {
+			kvmppc_core_queue_program(vcpu, 0x80000);
+			r = RESUME_GUEST;
+		}
 		break;
 	/*
 	 * This occurs if the guest (kernel or userspace), does something that
-- 
1.8.3.1
