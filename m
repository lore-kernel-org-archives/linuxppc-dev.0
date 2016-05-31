Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJlDy2nYhzDqfM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 17:17:38 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id gp3so17151994pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 00:17:38 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH 2/2] KVM: PPC: hypervisor large decrementer support
Date: Tue, 31 May 2016 17:16:56 +1000
Message-Id: <1464679016-10347-2-git-send-email-oohall@gmail.com>
In-Reply-To: <1464679016-10347-1-git-send-email-oohall@gmail.com>
References: <1464675936.30958.22.camel@neuling.org>
 <1464679016-10347-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power ISAv3 extends the width of the decrementer register from 32 bits.
The enlarged register width is implementation dependent, but reads from
these registers are automatically sign extended to produce a 64 bit
output when operating in large mode. The HDEC always operates in large
mode while the DEC register can be operated in 32bit mode or large mode
depending on the setting of the LPCR.LD bit.

Currently the hypervisor assumes that reads from the DEC and HDEC
register produce a 32 bit result which it sign extends to 64 bits using
the extsw instruction. This behaviour can result in the guest DEC
register value being corrupted by the hypervisor when the guest is
operating in LD mode since the results of the extsw instruction only
depends on the value of bit 31 in the register to be sign extended.

This patch adds the GET_DEC() and GET_HDEC() assembly macros for reading
from the decrementer registers. These macros will return the current
decrementer value as a 64 bit quantity regardless of the Host CPU or
guest decrementer operating mode. Additionally this patch corrects
several uses of decrementer values that assume a 32 bit register width.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/exception-64s.h | 29 ++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_host.h      |  2 +-
 arch/powerpc/include/asm/kvm_ppc.h       |  2 +-
 arch/powerpc/include/uapi/asm/kvm.h      |  2 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S  |  3 +--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 38 ++++++++++++++++++--------------
 arch/powerpc/kvm/emulate.c               |  6 ++---
 7 files changed, 57 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 93ae809fe5ea..4fa303bf6d5b 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -545,4 +545,33 @@ END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 #define FINISH_NAP
 #endif
 
+/*
+ * On ISAv3 processors the DEC register can be extended from 32 bits to 64 by
+ * setting the LD flag the LPCR. The decrementer value is a signed quantity so
+ * sign exension is required when operating in 32 bit mode. The GET_DEC() and
+ * GET_HDEC() handle this sign extension and yield a 64 bit result independent
+ * of the LD mode.
+ *
+ * NB: It's possible run with LD mode disabled on ISAv3 so GET_DEC() does not
+ *     use a CPU_FEATURE section. A feature section is used for GET_HDEC because
+ *     it has no mode bit. It is always 64 bits for ISAv3 processors.
+ */
+
+#define IS_LD_ENABLED(reg)                 \
+	mfspr  reg,SPRN_LPCR;              \
+	andis. reg,reg,(LPCR_LD >> 16);
+
+#define GET_DEC(reg)                       \
+	IS_LD_ENABLED(reg);                \
+	mfspr reg, SPRN_DEC;               \
+	bne 99f;                           \
+	extsw reg, reg;                    \
+99:
+
+#define GET_HDEC(reg) \
+	mfspr reg, SPRN_HDEC;           \
+BEGIN_FTR_SECTION                       \
+	extsw reg, reg;                 \
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
+
 #endif	/* _ASM_POWERPC_EXCEPTION_H */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ec35af34a3fb..ddea233e2cce 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -520,7 +520,7 @@ struct kvm_vcpu_arch {
 	ulong mcsrr0;
 	ulong mcsrr1;
 	ulong mcsr;
-	u32 dec;
+	u64 dec;
 #ifdef CONFIG_BOOKE
 	u32 decar;
 #endif
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 2544edabe7f3..4de0102930e9 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -94,7 +94,7 @@ extern int kvmppc_emulate_instruction(struct kvm_run *run,
 extern int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu);
 extern int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu);
 extern void kvmppc_emulate_dec(struct kvm_vcpu *vcpu);
-extern u32 kvmppc_get_dec(struct kvm_vcpu *vcpu, u64 tb);
+extern u64 kvmppc_get_dec(struct kvm_vcpu *vcpu, u64 tb);
 extern void kvmppc_decrementer_func(struct kvm_vcpu *vcpu);
 extern int kvmppc_sanity_check(struct kvm_vcpu *vcpu);
 extern int kvmppc_subarch_vcpu_init(struct kvm_vcpu *vcpu);
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index c93cf35ce379..2dd92e841127 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -215,7 +215,7 @@ struct kvm_sregs {
 			__u32 tsr;	/* KVM_SREGS_E_UPDATE_TSR */
 			__u32 tcr;
 			__u32 decar;
-			__u32 dec;	/* KVM_SREGS_E_UPDATE_DEC */
+			__u64 dec;	/* KVM_SREGS_E_UPDATE_DEC */
 
 			/*
 			 * Userspace can read TB directly, but the
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index 0fdc4a28970b..b408f72385e4 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -121,10 +121,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	 * Put whatever is in the decrementer into the
 	 * hypervisor decrementer.
 	 */
-	mfspr	r8,SPRN_DEC
+	GET_DEC(r8)
 	mftb	r7
 	mtspr	SPRN_HDEC,r8
-	extsw	r8,r8
 	add	r8,r8,r7
 	std	r8,HSTATE_DECEXP(r13)
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index e571ad277398..718e5581494e 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -183,6 +183,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 kvmppc_primary_no_guest:
 	/* We handle this much like a ceded vcpu */
 	/* put the HDEC into the DEC, since HDEC interrupts don't wake us */
+
+	/* XXX: ISA v3 only says the HDEC is at least as large as the DEC, but
+	 *      this code assumes we can fit HDEC in DEC. This is probably
+	 *      not an issue in practice, but... */
 	mfspr	r3, SPRN_HDEC
 	mtspr	SPRN_DEC, r3
 	/*
@@ -249,9 +253,9 @@ kvm_novcpu_wakeup:
 	bge	kvm_novcpu_exit
 
 	/* See if our timeslice has expired (HDEC is negative) */
-	mfspr	r0, SPRN_HDEC
+	GET_HDEC(r0);
 	li	r12, BOOK3S_INTERRUPT_HV_DECREMENTER
-	cmpwi	r0, 0
+	cmpdi	r0, 0
 	blt	kvm_novcpu_exit
 
 	/* Got an IPI but other vcpus aren't yet exiting, must be a latecomer */
@@ -340,8 +344,9 @@ kvm_secondary_got_guest:
 	lbz	r4, HSTATE_PTID(r13)
 	cmpwi	r4, 0
 	bne	63f
-	lis	r6, 0x7fff
-	ori	r6, r6, 0xffff
+
+	LOAD_REG_ADDR(r6, decrementer_max);
+	ld	r6,0(r6);
 	mtspr	SPRN_HDEC, r6
 	/* and set per-LPAR registers, if doing dynamic micro-threading */
 	ld	r6, HSTATE_SPLIT_MODE(r13)
@@ -897,7 +902,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	mftb	r7
 	subf	r3,r7,r8
 	mtspr	SPRN_DEC,r3
-	stw	r3,VCPU_DEC(r4)
+	std	r3,VCPU_DEC(r4)
 
 	ld	r5, VCPU_SPRG0(r4)
 	ld	r6, VCPU_SPRG1(r4)
@@ -953,8 +958,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	isync
 
 	/* Check if HDEC expires soon */
-	mfspr	r3, SPRN_HDEC
-	cmpwi	r3, 512		/* 1 microsecond */
+	GET_HDEC(r3)
+	cmpdi	r3, 512		/* 1 microsecond */
 	blt	hdec_soon
 
 	ld	r6, VCPU_CTR(r4)
@@ -990,8 +995,9 @@ deliver_guest_interrupt:
 	beq	5f
 	li	r0, BOOK3S_INTERRUPT_EXTERNAL
 	bne	cr1, 12f
-	mfspr	r0, SPRN_DEC
-	cmpwi	r0, 0
+
+	GET_DEC(r0)
+	cmpdi	r0, 0
 	li	r0, BOOK3S_INTERRUPT_DECREMENTER
 	bge	5f
 
@@ -1206,8 +1212,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	/* See if this is a leftover HDEC interrupt */
 	cmpwi	r12,BOOK3S_INTERRUPT_HV_DECREMENTER
 	bne	2f
-	mfspr	r3,SPRN_HDEC
-	cmpwi	r3,0
+	GET_HDEC(r3);
+	cmpdi	r3,0
 	mr	r4,r9
 	bge	fast_guest_return
 2:
@@ -1326,9 +1332,8 @@ mc_cont:
 	mtspr	SPRN_SPURR,r4
 
 	/* Save DEC */
-	mfspr	r5,SPRN_DEC
+	GET_DEC(r5);
 	mftb	r6
-	extsw	r5,r5
 	add	r5,r5,r6
 	/* r5 is a guest timebase value here, convert to host TB */
 	ld	r3,HSTATE_KVM_VCORE(r13)
@@ -2250,15 +2255,14 @@ _GLOBAL(kvmppc_h_cede)		/* r3 = vcpu pointer, r11 = msr, r13 = paca */
 	 * no later than the end of our timeslice (HDEC interrupts
 	 * don't wake us from nap).
 	 */
-	mfspr	r3, SPRN_DEC
-	mfspr	r4, SPRN_HDEC
+	GET_DEC(r3);
+	GET_HDEC(r4);
 	mftb	r5
-	cmpw	r3, r4
+	cmpd	r3, r4
 	ble	67f
 	mtspr	SPRN_DEC, r4
 67:
 	/* save expiry time of guest decrementer */
-	extsw	r3, r3
 	add	r3, r3, r5
 	ld	r4, HSTATE_KVM_VCPU(r13)
 	ld	r5, HSTATE_KVM_VCORE(r13)
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index 5cc2e7af3a7b..5d065c04f2d5 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -39,7 +39,7 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
 	unsigned long dec_nsec;
 	unsigned long long dec_time;
 
-	pr_debug("mtDEC: %x\n", vcpu->arch.dec);
+	pr_debug("mtDEC: %llx\n", vcpu->arch.dec);
 	hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
 
 #ifdef CONFIG_PPC_BOOK3S
@@ -47,7 +47,7 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
 	kvmppc_core_dequeue_dec(vcpu);
 
 	/* POWER4+ triggers a dec interrupt if the value is < 0 */
-	if (vcpu->arch.dec & 0x80000000) {
+	if ((s64) vcpu->arch.dec < 0) {
 		kvmppc_core_queue_dec(vcpu);
 		return;
 	}
@@ -78,7 +78,7 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
 	vcpu->arch.dec_jiffies = get_tb();
 }
 
-u32 kvmppc_get_dec(struct kvm_vcpu *vcpu, u64 tb)
+u64 kvmppc_get_dec(struct kvm_vcpu *vcpu, u64 tb)
 {
 	u64 jd = tb - vcpu->arch.dec_jiffies;
 
-- 
2.5.5
