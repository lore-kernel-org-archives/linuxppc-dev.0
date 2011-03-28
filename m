Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.183])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95BDAB6FA6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 07:00:26 +1100 (EST)
Date: Mon, 28 Mar 2011 15:00:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [PATCH v2 4/4] KVM: PPC: e500: SPE switch between guest and host
Message-ID: <20110328200008.GC25685@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110328195923.GA25659@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: yu liu <yu.liu@freescale.com>

This patch provide a lazy way to do SPE switch.
The SPE save/restore will be done only if it's needed.

Linux already switches SPEFSCR on context switch (non-lazily), so the
only remaining bit is to save it between qemu and the guest.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: added kvm-ppc (sorry for the resend)

 arch/powerpc/include/asm/kvm_host.h |    6 +++
 arch/powerpc/kernel/asm-offsets.c   |    6 +++
 arch/powerpc/kvm/booke.c            |   15 +++++++-
 arch/powerpc/kvm/booke_interrupts.S |   62 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/e500.c             |   45 ++++++++++++++++++++++++-
 5 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index c376f6b..171cd85 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -195,6 +195,12 @@ struct kvm_vcpu_arch {
 	u64 fpr[32];
 	u64 fpscr;
 
+#ifdef CONFIG_SPE
+	ulong evr[32];
+	ulong spefscr;
+	ulong host_spefscr;
+	u64 acc;
+#endif
 #ifdef CONFIG_ALTIVEC
 	vector128 vr[32];
 	vector128 vscr;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 75b72c7..554f4d6 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -497,6 +497,12 @@ int main(void)
 	DEFINE(TLBCAM_MAS3, offsetof(struct tlbcam, MAS3));
 	DEFINE(TLBCAM_MAS7, offsetof(struct tlbcam, MAS7));
 #endif
+#ifdef CONFIG_SPE
+	DEFINE(VCPU_EVR, offsetof(struct kvm_vcpu, arch.evr[0]));
+	DEFINE(VCPU_ACC, offsetof(struct kvm_vcpu, arch.acc));
+	DEFINE(VCPU_SPEFSCR, offsetof(struct kvm_vcpu, arch.spefscr));
+	DEFINE(VCPU_HOST_SPEFSCR, offsetof(struct kvm_vcpu, arch.host_spefscr));
+#endif /* CONFIG_SPE */
 
 #ifdef CONFIG_KVM_EXIT_TIMING
 	DEFINE(VCPU_TIMING_EXIT_TBU, offsetof(struct kvm_vcpu,
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ef76acb..4e9c1a9 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -13,6 +13,7 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  *
  * Copyright IBM Corp. 2007
+ * Copyright (C) 2010 Freescale Semiconductor, Inc.
  *
  * Authors: Hollis Blanchard <hollisb@us.ibm.com>
  *          Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
@@ -344,10 +345,19 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 
-	case BOOKE_INTERRUPT_SPE_UNAVAIL:
-		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_UNAVAIL);
+#ifdef CONFIG_SPE
+	case BOOKE_INTERRUPT_SPE_UNAVAIL: {
+		extern void kvmppc_vcpu_spe_load(struct kvm_vcpu *vcpu);
+
+		/* reload the SPE env if guest first use SPE since last save */
+		if (kvmppc_msr_block_has(vcpu, MSR_SPE))
+			kvmppc_vcpu_spe_load(vcpu);
+
+		if (!(vcpu->arch.shared->msr & MSR_SPE))
+			kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_UNAVAIL);
 		r = RESUME_GUEST;
 		break;
+	}
 
 	case BOOKE_INTERRUPT_SPE_FP_DATA:
 		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_DATA);
@@ -358,6 +368,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_ROUND);
 		r = RESUME_GUEST;
 		break;
+#endif
 
 	case BOOKE_INTERRUPT_DATA_STORAGE:
 		kvmppc_core_queue_data_storage(vcpu, vcpu->arch.fault_dear,
diff --git a/arch/powerpc/kvm/booke_interrupts.S b/arch/powerpc/kvm/booke_interrupts.S
index 92193c7..910ec66 100644
--- a/arch/powerpc/kvm/booke_interrupts.S
+++ b/arch/powerpc/kvm/booke_interrupts.S
@@ -241,6 +241,14 @@ _GLOBAL(kvmppc_resume_host)
 heavyweight_exit:
 	/* Not returning to guest. */
 
+#ifdef CONFIG_SPE
+	/* save guest SPEFSCR and load host SPEFSCR */
+	mfspr	r9, SPRN_SPEFSCR
+	stw	r9, VCPU_SPEFSCR(r4)
+	lwz	r9, VCPU_HOST_SPEFSCR(r4)
+	mtspr	SPRN_SPEFSCR, r9
+#endif
+
 	/* We already saved guest volatile register state; now save the
 	 * non-volatiles. */
 	stw	r15, VCPU_GPR(r15)(r4)
@@ -342,6 +350,14 @@ _GLOBAL(__kvmppc_vcpu_entry)
 	lwz	r30, VCPU_GPR(r30)(r4)
 	lwz	r31, VCPU_GPR(r31)(r4)
 
+#ifdef CONFIG_SPE
+	/* save host SPEFSCR and load guest SPEFSCR */
+	mfspr	r3, SPRN_SPEFSCR
+	stw	r3, VCPU_HOST_SPEFSCR(r4)
+	lwz	r3, VCPU_SPEFSCR(r4)
+	mtspr	SPRN_SPEFSCR, r3
+#endif
+
 lightweight_exit:
 	stw	r2, HOST_R2(r1)
 
@@ -435,3 +451,49 @@ lightweight_exit:
 	lwz	r3, VCPU_GPR(r3)(r4)
 	lwz	r4, VCPU_GPR(r4)(r4)
 	rfi
+
+#ifdef CONFIG_SPE
+#define KVMPPC_SAVE_EVR(n,s,base)	evmergehi s,s,n; stw s,(4*(n))(base)
+#define KVMPPC_SAVE_2EVR(n,s,base)	KVMPPC_SAVE_EVR(n,s,base); \
+					   KVMPPC_SAVE_EVR(n+1,s,base)
+#define KVMPPC_SAVE_4EVR(n,s,base)	KVMPPC_SAVE_2EVR(n,s,base); \
+					   KVMPPC_SAVE_2EVR(n+2,s,base)
+#define KVMPPC_SAVE_8EVR(n,s,base)	KVMPPC_SAVE_4EVR(n,s,base); \
+					   KVMPPC_SAVE_4EVR(n+4,s,base)
+#define KVMPPC_SAVE_16EVR(n,s,base)	KVMPPC_SAVE_8EVR(n,s,base); \
+					   KVMPPC_SAVE_8EVR(n+8,s,base)
+#define KVMPPC_SAVE_32EVR(n,s,base)	KVMPPC_SAVE_16EVR(n,s,base); \
+					   KVMPPC_SAVE_16EVR(n+16,s,base)
+#define KVMPPC_LOAD_EVR(n,s,base)	lwz s,(4*(n))(base); evmergelo n,s,n
+#define KVMPPC_LOAD_2EVR(n,s,base)	KVMPPC_LOAD_EVR(n,s,base); \
+					   KVMPPC_LOAD_EVR(n+1,s,base)
+#define KVMPPC_LOAD_4EVR(n,s,base)	KVMPPC_LOAD_2EVR(n,s,base); \
+					   KVMPPC_LOAD_2EVR(n+2,s,base)
+#define KVMPPC_LOAD_8EVR(n,s,base)	KVMPPC_LOAD_4EVR(n,s,base); \
+					   KVMPPC_LOAD_4EVR(n+4,s,base)
+#define KVMPPC_LOAD_16EVR(n,s,base)	KVMPPC_LOAD_8EVR(n,s,base); \
+					   KVMPPC_LOAD_8EVR(n+8,s,base)
+#define KVMPPC_LOAD_32EVR(n,s,base)	KVMPPC_LOAD_16EVR(n,s,base); \
+					   KVMPPC_LOAD_16EVR(n+16,s,base)
+
+_GLOBAL(kvmppc_save_guest_spe)
+	cmpi	0,r3,0
+	beqlr-
+	addi	r5,r3,VCPU_EVR
+	KVMPPC_SAVE_32EVR(0,r4,r5)	/* save evr[32] */
+	evxor   evr6, evr6, evr6
+	evmwumiaa evr6, evr6, evr6
+	li	r4,VCPU_ACC
+	evstddx evr6, r4, r3		/* save acc */
+	blr
+
+_GLOBAL(kvmppc_load_guest_spe)
+	cmpi	0,r3,0
+	beqlr-
+	li      r4,VCPU_ACC
+	evlddx  evr6,r4,r3
+	evmra   evr6,evr6		/* load acc */
+	addi	r5,r3,VCPU_EVR
+	KVMPPC_LOAD_32EVR(0,r4,r5)	/* load evr[32] */
+	blr
+#endif
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index acfe052..038bc37 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2008-2011 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author: Yu Liu, <yu.liu@freescale.com>
  *
@@ -25,6 +25,25 @@
 #include "booke.h"
 #include "e500_tlb.h"
 
+#ifdef CONFIG_SPE
+extern void kvmppc_load_guest_spe(struct kvm_vcpu *vcpu);
+extern void kvmppc_save_guest_spe(struct kvm_vcpu *vcpu);
+
+void kvmppc_vcpu_spe_put(struct kvm_vcpu *vcpu)
+{
+	enable_kernel_spe();
+	kvmppc_save_guest_spe(vcpu);
+	kvmppc_set_msr_block(vcpu, MSR_SPE);
+}
+
+void kvmppc_vcpu_spe_load(struct kvm_vcpu *vcpu)
+{
+	enable_kernel_spe();
+	kvmppc_load_guest_spe(vcpu);
+	kvmppc_clr_msr_block(vcpu, MSR_SPE);
+}
+#endif
+
 void kvmppc_core_load_host_debugstate(struct kvm_vcpu *vcpu)
 {
 }
@@ -41,6 +60,11 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	kvmppc_e500_tlb_put(vcpu);
+#ifdef CONFIG_SPE
+	/* save SPE env if guest has used SPE since last save */
+	if (!kvmppc_msr_block_has(vcpu, MSR_SPE))
+		kvmppc_vcpu_spe_put(vcpu);
+#endif
 }
 
 int kvmppc_core_check_processor_compat(void)
@@ -75,7 +99,24 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
 
 int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
-	return __kvmppc_vcpu_entry(kvm_run, vcpu);
+	int ret;
+
+#ifdef CONFIG_SPE
+	/*
+	 * if guest is using SPE, we reload the env.
+	 * otherwise we do it when needed.
+	 */
+	if (vcpu->arch.shared->msr & MSR_SPE)
+		kvmppc_vcpu_spe_load(vcpu);
+#endif
+	ret = __kvmppc_vcpu_entry(kvm_run, vcpu);
+#ifdef CONFIG_SPE
+	/* save SPE env if guest has used SPE since last save */
+	if (!kvmppc_msr_block_has(vcpu, MSR_SPE))
+		kvmppc_vcpu_spe_put(vcpu);
+#endif
+
+	return ret;
 }
 
 /* 'linear_address' is actually an encoding of AS|PID|EADDR . */
-- 
1.7.1
