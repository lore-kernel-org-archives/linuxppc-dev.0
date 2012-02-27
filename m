Return-Path: <r63875@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBF85B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 22:06:18 +1100 (EST)
From: Olivia Yin <hong-hua.yin@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] KVM: booke: Improve SPE switch
Date: Mon, 27 Feb 2012 19:00:01 +0800
Message-ID: <1330340401-30328-1-git-send-email-hong-hua.yin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liu Yu <yu.liu@freescale.com>, Olivia Yin <hong-hua.yin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Like book3s did for fp switch,
instead of switch SPE between host and guest,
the patch switch SPE state between qemu and guest.
In this way, we can simulate a host loadup SPE when load guest SPE state,
and let host to decide when to giveup SPE state.
Therefor it cooperates better with host SPE usage,
and so that has some performance benifit in UP host(lazy SPE).

Moreover, since the patch save guest SPE state into linux thread field,
it creates the condition to emulate guest SPE instructions in host,
so that we can avoid injecting SPE exception to guest.

The patch also turns all asm code into C code,
and add SPE stat counts.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
 arch/powerpc/include/asm/kvm_host.h |   11 +++++-
 arch/powerpc/kernel/asm-offsets.c   |    7 ----
 arch/powerpc/kvm/booke.c            |   63 +++++++++++++++++++++++++++++++----
 arch/powerpc/kvm/booke.h            |    8 +----
 arch/powerpc/kvm/booke_interrupts.S |   37 --------------------
 arch/powerpc/kvm/e500.c             |    5 ---
 arch/powerpc/kvm/timing.c           |    5 +++
 arch/powerpc/kvm/timing.h           |   11 ++++++
 8 files changed, 83 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 1843d5d..6186d08 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -117,6 +117,11 @@ struct kvm_vcpu_stat {
 	u32 st;
 	u32 st_slow;
 #endif
+#ifdef CONFIG_SPE
+	u32 spe_unavail;
+	u32 spe_fp_data;
+	u32 spe_fp_round;
+#endif
 };
 
 enum kvm_exit_types {
@@ -147,6 +152,11 @@ enum kvm_exit_types {
 	FP_UNAVAIL,
 	DEBUG_EXITS,
 	TIMEINGUEST,
+#ifdef CONFIG_SPE
+	SPE_UNAVAIL,
+	SPE_FP_DATA,
+	SPE_FP_ROUND,
+#endif
 	__NUMBER_OF_KVM_EXIT_TYPES
 };
 
@@ -330,7 +340,6 @@ struct kvm_vcpu_arch {
 #ifdef CONFIG_SPE
 	ulong evr[32];
 	ulong spefscr;
-	ulong host_spefscr;
 	u64 acc;
 #endif
 #ifdef CONFIG_ALTIVEC
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 8e0db0b..ff68f71 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -604,13 +604,6 @@ int main(void)
 	DEFINE(TLBCAM_MAS7, offsetof(struct tlbcam, MAS7));
 #endif
 
-#if defined(CONFIG_KVM) && defined(CONFIG_SPE)
-	DEFINE(VCPU_EVR, offsetof(struct kvm_vcpu, arch.evr[0]));
-	DEFINE(VCPU_ACC, offsetof(struct kvm_vcpu, arch.acc));
-	DEFINE(VCPU_SPEFSCR, offsetof(struct kvm_vcpu, arch.spefscr));
-	DEFINE(VCPU_HOST_SPEFSCR, offsetof(struct kvm_vcpu, arch.host_spefscr));
-#endif
-
 #ifdef CONFIG_KVM_EXIT_TIMING
 	DEFINE(VCPU_TIMING_EXIT_TBU, offsetof(struct kvm_vcpu,
 						arch.timing_exit.tv32.tbu));
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ee9e1ee..f20010b 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -55,6 +55,11 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "dec",        VCPU_STAT(dec_exits) },
 	{ "ext_intr",   VCPU_STAT(ext_intr_exits) },
 	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
+#ifdef CONFIG_SPE
+	{ "spe_unavail", VCPU_STAT(spe_unavail) },
+	{ "spe_fp_data", VCPU_STAT(spe_fp_data) },
+	{ "spe_fp_round", VCPU_STAT(spe_fp_round) },
+#endif
 	{ NULL }
 };
 
@@ -80,11 +85,11 @@ void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)
 }
 
 #ifdef CONFIG_SPE
-void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
+static void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
-	enable_kernel_spe();
-	kvmppc_save_guest_spe(vcpu);
+	if (current->thread.regs->msr & MSR_SPE)
+		giveup_spe(current);
 	vcpu->arch.shadow_msr &= ~MSR_SPE;
 	preempt_enable();
 }
@@ -92,8 +97,10 @@ void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
 static void kvmppc_vcpu_enable_spe(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
-	enable_kernel_spe();
-	kvmppc_load_guest_spe(vcpu);
+	if (!(current->thread.regs->msr & MSR_SPE)) {
+		load_up_spe(NULL);
+		current->thread.regs->msr |= MSR_SPE;
+	}
 	vcpu->arch.shadow_msr |= MSR_SPE;
 	preempt_enable();
 }
@@ -104,7 +111,7 @@ static void kvmppc_vcpu_sync_spe(struct kvm_vcpu *vcpu)
 		if (!(vcpu->arch.shadow_msr & MSR_SPE))
 			kvmppc_vcpu_enable_spe(vcpu);
 	} else if (vcpu->arch.shadow_msr & MSR_SPE) {
-		kvmppc_vcpu_disable_spe(vcpu);
+		vcpu->arch.shadow_msr &= ~MSR_SPE;
 	}
 }
 #else
@@ -124,7 +131,8 @@ void kvmppc_set_msr(struct kvm_vcpu *vcpu, u32 new_msr)
 	vcpu->arch.shared->msr = new_msr;
 
 	kvmppc_mmu_msr_notify(vcpu, old_msr);
-	kvmppc_vcpu_sync_spe(vcpu);
+ 	if ((old_msr ^ new_msr) & MSR_SPE)
+		kvmppc_vcpu_sync_spe(vcpu);
 }
 
 static void kvmppc_booke_queue_irqprio(struct kvm_vcpu *vcpu,
@@ -338,6 +346,11 @@ void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
 	int ret;
+#ifdef CONFIG_SPE
+	ulong evr[32];
+	ulong spefscr;
+	u64 acc;
+#endif
 
 	if (!vcpu->arch.sane) {
 		kvm_run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
@@ -355,7 +368,40 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	}
 
 	kvm_guest_enter();
+#ifdef CONFIG_SPE
+	/* Save userspace SPE state in stack */
+	enable_kernel_spe();
+	memcpy(evr, current->thread.evr, sizeof(current->thread.evr));
+	acc = current->thread.acc;
+
+	/* Restore guest SPE state to thread */
+	memcpy(current->thread.evr, vcpu->arch.evr, sizeof(vcpu->arch.evr));
+	current->thread.acc = vcpu->arch.acc;
+
+	/* Switch SPEFSCR and load guest SPE state if needed */
+	spefscr = mfspr(SPRN_SPEFSCR);
+	kvmppc_vcpu_sync_spe(vcpu);
+	mtspr(SPRN_SPEFSCR, vcpu->arch.spefscr);
+#endif
+
 	ret = __kvmppc_vcpu_run(kvm_run, vcpu);
+
+#ifdef CONFIG_SPE
+	/* Switch SPEFSCR and save guest SPE state if needed */
+	vcpu->arch.spefscr = mfspr(SPRN_SPEFSCR);
+	kvmppc_vcpu_disable_spe(vcpu);
+	mtspr(SPRN_SPEFSCR, spefscr);
+
+	/* Save guest SPE state from thread */
+	memcpy(vcpu->arch.evr, current->thread.evr, sizeof(vcpu->arch.evr));
+	vcpu->arch.acc = current->thread.acc;
+
+	/* Restore userspace SPE state from stack */
+	memcpy(current->thread.evr, evr, sizeof(current->thread.evr));
+	current->thread.spefscr = spefscr;
+	current->thread.acc = acc;
+#endif
+
 	kvm_guest_exit();
 
 out:
@@ -457,17 +503,20 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		else
 			kvmppc_booke_queue_irqprio(vcpu,
 						   BOOKE_IRQPRIO_SPE_UNAVAIL);
+		kvmppc_account_exit(vcpu, SPE_UNAVAIL);
 		r = RESUME_GUEST;
 		break;
 	}
 
 	case BOOKE_INTERRUPT_SPE_FP_DATA:
 		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_DATA);
+		kvmppc_account_exit(vcpu, SPE_FP_DATA);
 		r = RESUME_GUEST;
 		break;
 
 	case BOOKE_INTERRUPT_SPE_FP_ROUND:
 		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_ROUND);
+		kvmppc_account_exit(vcpu, SPE_FP_ROUND);
 		r = RESUME_GUEST;
 		break;
 #else
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index 2fe2027..c02b8f9 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -22,6 +22,7 @@
 
 #include <linux/types.h>
 #include <linux/kvm_host.h>
+#include <asm/system.h>
 #include <asm/kvm_ppc.h>
 #include "timing.h"
 
@@ -64,11 +65,4 @@ int kvmppc_booke_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 int kvmppc_booke_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt);
 int kvmppc_booke_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs);
 
-/* low-level asm code to transfer guest state */
-void kvmppc_load_guest_spe(struct kvm_vcpu *vcpu);
-void kvmppc_save_guest_spe(struct kvm_vcpu *vcpu);
-
-/* high-level function, manages flags, host state */
-void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu);
-
 #endif /* __KVM_BOOKE_H__ */
diff --git a/arch/powerpc/kvm/booke_interrupts.S b/arch/powerpc/kvm/booke_interrupts.S
index 10d8ef6..c44367d 100644
--- a/arch/powerpc/kvm/booke_interrupts.S
+++ b/arch/powerpc/kvm/booke_interrupts.S
@@ -245,15 +245,6 @@ _GLOBAL(kvmppc_resume_host)
 
 heavyweight_exit:
 	/* Not returning to guest. */
-
-#ifdef CONFIG_SPE
-	/* save guest SPEFSCR and load host SPEFSCR */
-	mfspr	r9, SPRN_SPEFSCR
-	stw	r9, VCPU_SPEFSCR(r4)
-	lwz	r9, VCPU_HOST_SPEFSCR(r4)
-	mtspr	SPRN_SPEFSCR, r9
-#endif
-
 	/* We already saved guest volatile register state; now save the
 	 * non-volatiles. */
 	stw	r15, VCPU_GPR(r15)(r4)
@@ -355,14 +346,6 @@ _GLOBAL(__kvmppc_vcpu_run)
 	lwz	r30, VCPU_GPR(r30)(r4)
 	lwz	r31, VCPU_GPR(r31)(r4)
 
-#ifdef CONFIG_SPE
-	/* save host SPEFSCR and load guest SPEFSCR */
-	mfspr	r3, SPRN_SPEFSCR
-	stw	r3, VCPU_HOST_SPEFSCR(r4)
-	lwz	r3, VCPU_SPEFSCR(r4)
-	mtspr	SPRN_SPEFSCR, r3
-#endif
-
 lightweight_exit:
 	stw	r2, HOST_R2(r1)
 
@@ -460,23 +443,3 @@ lightweight_exit:
 	lwz	r4, VCPU_GPR(r4)(r4)
 	rfi
 
-#ifdef CONFIG_SPE
-_GLOBAL(kvmppc_save_guest_spe)
-	cmpi	0,r3,0
-	beqlr-
-	SAVE_32EVRS(0, r4, r3, VCPU_EVR)
-	evxor   evr6, evr6, evr6
-	evmwumiaa evr6, evr6, evr6
-	li	r4,VCPU_ACC
-	evstddx evr6, r4, r3		/* save acc */
-	blr
-
-_GLOBAL(kvmppc_load_guest_spe)
-	cmpi	0,r3,0
-	beqlr-
-	li      r4,VCPU_ACC
-	evlddx  evr6,r4,r3
-	evmra   evr6,evr6		/* load acc */
-	REST_32EVRS(0, r4, r3, VCPU_EVR)
-	blr
-#endif
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index ddcd896..74da9c8 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -42,11 +42,6 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	kvmppc_e500_tlb_put(vcpu);
-
-#ifdef CONFIG_SPE
-	if (vcpu->arch.shadow_msr & MSR_SPE)
-		kvmppc_vcpu_disable_spe(vcpu);
-#endif
 }
 
 int kvmppc_core_check_processor_compat(void)
diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
index 07b6110..c9ce332 100644
--- a/arch/powerpc/kvm/timing.c
+++ b/arch/powerpc/kvm/timing.c
@@ -135,6 +135,11 @@ static const char *kvm_exit_names[__NUMBER_OF_KVM_EXIT_TYPES] = {
 	[USR_PR_INST] =             "USR_PR_INST",
 	[FP_UNAVAIL] =              "FP_UNAVAIL",
 	[DEBUG_EXITS] =             "DEBUG",
+#ifdef CONFIG_SPE
+	[SPE_UNAVAIL] =              "SPE_UNAVAIL",
+	[SPE_FP_DATA] =              "SPE_FP_DATA",
+	[SPE_FP_ROUND] =             "SPE_FP_ROUND",
+#endif
 	[TIMEINGUEST] =             "TIMEINGUEST"
 };
 
diff --git a/arch/powerpc/kvm/timing.h b/arch/powerpc/kvm/timing.h
index 8167d42..712ab3a 100644
--- a/arch/powerpc/kvm/timing.h
+++ b/arch/powerpc/kvm/timing.h
@@ -93,6 +93,17 @@ static inline void kvmppc_account_exit_stat(struct kvm_vcpu *vcpu, int type)
 	case SIGNAL_EXITS:
 		vcpu->stat.signal_exits++;
 		break;
+#ifdef CONFIG_SPE
+	case SPE_UNAVAIL:
+		vcpu->stat.spe_unavail++;
+		break;
+	case SPE_FP_DATA:
+		vcpu->stat.spe_fp_data++;
+		break;
+	case SPE_FP_ROUND:
+		vcpu->stat.spe_fp_round++;
+		break;
+#endif
 	}
 }
 
-- 
1.6.4
