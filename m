Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id D764BB7C38
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:36 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 16/27] Add desktop PowerPC specific emulation
Date: Fri, 30 Oct 2009 16:47:16 +0100
Message-Id: <1256917647-6200-17-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Little opcodes behave differently on desktop and embedded PowerPC cores.
In order to reflect those differences, let's add some #ifdef code to emulate.c.

We could probably also handle them in the core specific emulation files, but I
would prefer to reuse as much code as possible.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v4 -> v5:

  - use get_tb instead of mftb
  - make ppc32 and ppc64 emulation share more code
---
 arch/powerpc/kvm/emulate.c |   49 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index 50d411d..1ec5e07 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -32,6 +32,7 @@
 #include "trace.h"
 
 #define OP_TRAP 3
+#define OP_TRAP_64 2
 
 #define OP_31_XOP_LWZX      23
 #define OP_31_XOP_LBZX      87
@@ -64,16 +65,36 @@
 #define OP_STH  44
 #define OP_STHU 45
 
+#ifdef CONFIG_PPC64
+static int kvmppc_dec_enabled(struct kvm_vcpu *vcpu)
+{
+	return 1;
+}
+#else
+static int kvmppc_dec_enabled(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.tcr & TCR_DIE;
+}
+#endif
+
 void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
 {
 	unsigned long nr_jiffies;
 
-	if (vcpu->arch.tcr & TCR_DIE) {
+#ifdef CONFIG_PPC64
+	/* POWER4+ triggers a dec interrupt if the value is < 0 */
+	if (vcpu->arch.dec & 0x80000000) {
+		del_timer(&vcpu->arch.dec_timer);
+		kvmppc_core_queue_dec(vcpu);
+		return;
+	}
+#endif
+	if (kvmppc_dec_enabled(vcpu)) {
 		/* The decrementer ticks at the same rate as the timebase, so
 		 * that's how we convert the guest DEC value to the number of
 		 * host ticks. */
 
-		vcpu->arch.dec_jiffies = mftb();
+		vcpu->arch.dec_jiffies = get_tb();
 		nr_jiffies = vcpu->arch.dec / tb_ticks_per_jiffy;
 		mod_timer(&vcpu->arch.dec_timer,
 		          get_jiffies_64() + nr_jiffies);
@@ -113,9 +134,15 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	/* this default type might be overwritten by subcategories */
 	kvmppc_set_exit_type(vcpu, EMULATED_INST_EXITS);
 
+	pr_debug(KERN_INFO "Emulating opcode %d / %d\n", get_op(inst), get_xop(inst));
+
 	switch (get_op(inst)) {
 	case OP_TRAP:
+#ifdef CONFIG_PPC64
+	case OP_TRAP_64:
+#else
 		vcpu->arch.esr |= ESR_PTR;
+#endif
 		kvmppc_core_queue_program(vcpu);
 		advance = 0;
 		break;
@@ -190,17 +217,19 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			case SPRN_SRR1:
 				vcpu->arch.gpr[rt] = vcpu->arch.srr1; break;
 			case SPRN_PVR:
-				vcpu->arch.gpr[rt] = mfspr(SPRN_PVR); break;
+				vcpu->arch.gpr[rt] = vcpu->arch.pvr; break;
 			case SPRN_PIR:
-				vcpu->arch.gpr[rt] = mfspr(SPRN_PIR); break;
+				vcpu->arch.gpr[rt] = vcpu->vcpu_id; break;
+			case SPRN_MSSSR0:
+				vcpu->arch.gpr[rt] = 0; break;
 
 			/* Note: mftb and TBRL/TBWL are user-accessible, so
 			 * the guest can always access the real TB anyways.
 			 * In fact, we probably will never see these traps. */
 			case SPRN_TBWL:
-				vcpu->arch.gpr[rt] = mftbl(); break;
+				vcpu->arch.gpr[rt] = get_tb() >> 32; break;
 			case SPRN_TBWU:
-				vcpu->arch.gpr[rt] = mftbu(); break;
+				vcpu->arch.gpr[rt] = get_tb(); break;
 
 			case SPRN_SPRG0:
 				vcpu->arch.gpr[rt] = vcpu->arch.sprg0; break;
@@ -215,11 +244,9 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 
 			case SPRN_DEC:
 			{
-				u64 jd = mftb() - vcpu->arch.dec_jiffies;
+				u64 jd = get_tb() - vcpu->arch.dec_jiffies;
 				vcpu->arch.gpr[rt] = vcpu->arch.dec - jd;
-#ifdef DEBUG_EMUL
-				printk(KERN_INFO "mfDEC: %x - %llx = %lx\n", vcpu->arch.dec, jd, vcpu->arch.gpr[rt]);
-#endif
+				pr_debug(KERN_INFO "mfDEC: %x - %llx = %lx\n", vcpu->arch.dec, jd, vcpu->arch.gpr[rt]);
 				break;
 			}
 			default:
@@ -271,6 +298,8 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			case SPRN_TBWL: break;
 			case SPRN_TBWU: break;
 
+			case SPRN_MSSSR0: break;
+
 			case SPRN_DEC:
 				vcpu->arch.dec = vcpu->arch.gpr[rs];
 				kvmppc_emulate_dec(vcpu);
-- 
1.6.0.2
