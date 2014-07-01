Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 288A31A0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 18:41:15 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 1 Jul 2014 14:11:12 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 340B83940049
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 14:11:08 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s618fMfF57933924
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Jul 2014 14:11:23 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s618f5M5010410
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Jul 2014 14:11:05 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH v2] powerpc/kvm: support to handle sw breakpoint
Date: Tue,  1 Jul 2014 14:11:02 +0530
Message-Id: <1404204062-19635-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
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
and accordingly we return to Host or Guest. Patch also adds support for
software breakpoint in PR KVM.

Patch mandates use of "abs" instruction as sw breakpoint instruction
(primary opcode 31 and extended opcode 360). Based on PowerISA v2.01,
ABS instruction has been dropped from the architecture and treated an
illegal instruction.

Changes v1->v2:

 Moved the debug instruction #def to kvm_book3s.h. This way PR_KVM can also share it.
 Added code to use KVM get one reg infrastructure to get debug opcode.
 Updated emulate.c to include emulation of debug instruction incase of PR_KVM.
 Made changes to commit message.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |    8 ++++++++
 arch/powerpc/include/asm/ppc-opcode.h |    5 +++++
 arch/powerpc/kvm/book3s.c             |    3 ++-
 arch/powerpc/kvm/book3s_hv.c          |    9 +++++++++
 arch/powerpc/kvm/book3s_pr.c          |    3 +++
 arch/powerpc/kvm/emulate.c            |   10 ++++++++++
 6 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index f52f656..180d549 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -24,6 +24,14 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_book3s_asm.h>
 
+/*
+ * KVMPPC_INST_BOOK3S_DEBUG is debug Instruction for supporting Software Breakpoint.
+ * Instruction mnemonic is ABS, primary opcode is 31 and extended opcode is 360.
+ * Based on PowerISA v2.01, ABS instruction has been dropped from the architecture
+ * and treated an illegal instruction.
+ */
+#define KVMPPC_INST_BOOK3S_DEBUG	0x7c0002d0
+
 struct kvmppc_bat {
 	u64 raw;
 	u32 bepi;
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 3132bb9..3fbb4c1 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -111,6 +111,11 @@
 #define OP_31_XOP_LHBRX     790
 #define OP_31_XOP_STHBRX    918
 
+/* KVMPPC_INST_BOOK3S_DEBUG -- Software breakpoint Instruction
+ * Instruction mnemonic is ABS, primary opcode is 31 and extended opcode is 360.
+ */
+#define OP_31_XOP_ABS	    360
+
 #define OP_LWZ  32
 #define OP_LD   58
 #define OP_LWZU 33
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
index 7a12edb..402c1ec 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -725,8 +725,14 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 * we don't emulate any guest instructions at this stage.
 	 */
 	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
+	if (kvmppc_get_last_inst(vcpu) == KVMPPC_INST_BOOK3S_DEBUG ) {
+		run->exit_reason = KVM_EXIT_DEBUG;
+		run->debug.arch.address = kvmppc_get_pc(vcpu);
+		r = RESUME_HOST;
+	} else {
 		kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
 		r = RESUME_GUEST;
+	}
 		break;
 	/*
 	 * This occurs if the guest (kernel or userspace), does something that
@@ -831,6 +837,9 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	long int i;
 
 	switch (id) {
+	case KVM_REG_PPC_DEBUG_INST:
+		*val = get_reg_val(id, KVMPPC_INST_BOOK3S_DEBUG);
+		break;
 	case KVM_REG_PPC_HIOR:
 		*val = get_reg_val(id, 0);
 		break;
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 8eef1e5..27f5234 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1229,6 +1229,9 @@ static int kvmppc_get_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
 	int r = 0;
 
 	switch (id) {
+	case KVM_REG_PPC_DEBUG_INST:
+		*val = get_reg_val(id, KVMPPC_INST_BOOK3S_DEBUG);
+		break;
 	case KVM_REG_PPC_HIOR:
 		*val = get_reg_val(id, to_book3s(vcpu)->hior);
 		break;
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index da86d9b..13fba51 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -363,6 +363,16 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			                               2, 0);
 			break;
 
+		case OP_31_XOP_ABS:
+			/*
+			 * This is debug instruction. So we dont emulate instead,
+			 * We fill the pc and exit code and direct the return to host.
+			 */
+			run->exit_reason = KVM_EXIT_DEBUG;
+			run->debug.arch.address = kvmppc_get_pc(vcpu);
+			emulated = EMULATE_EXIT_USER;
+			break;
+
 		default:
 			/* Attempt core-specific emulation below. */
 			emulated = EMULATE_FAIL;
-- 
1.7.10.4
