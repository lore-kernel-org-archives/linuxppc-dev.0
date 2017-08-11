Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTW241tbBzDr2m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:39:56 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id c65so3908876pfl.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 09:39:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v2 10/14] KVM: PPC: Book3S HV: POWER9 does not require
 secondary thread management
Date: Sat, 12 Aug 2017 02:39:08 +1000
Message-Id: <20170811163912.28783-11-npiggin@gmail.com>
In-Reply-To: <20170811163912.28783-1-npiggin@gmail.com>
References: <20170811163912.28783-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 CPUs have independent MMU contexts per thread, so KVM does not
need to quiesce secondary threads, so the hwthread_req/hwthread_state
protocol does not have to be used. So patch it away on POWER9, and patch
away the branch from the Linux idle wakeup to kvm_start_guest that is
never used.

Add a warning and error out of kvmppc_grab_hwthread in case it is ever
called on POWER9.

This avoids a hwsync in the idle wakeup path on POWER9.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s_asm.h |  4 ++++
 arch/powerpc/kernel/idle_book3s.S         | 30 +++++++++++++++---------------
 arch/powerpc/kvm/book3s_hv.c              | 14 +++++++++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  8 ++++++++
 4 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index 7cea76f11c26..83596f32f50b 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -104,6 +104,10 @@ struct kvmppc_host_state {
 	u8 napping;
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	/*
+	 * hwthread_req/hwthread_state pair is used to pull sibling threads
+	 * out of guest on pre-ISAv3.0B CPUs where threads share MMU.
+	 */
 	u8 hwthread_req;
 	u8 hwthread_state;
 	u8 host_ipi;
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index e6252c5a57a4..9a9a28f0758d 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -243,12 +243,6 @@ enter_winkle:
  * r3 - PSSCR value corresponding to the requested stop state.
  */
 power_enter_stop:
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	/* Tell KVM we're entering idle */
-	li	r4,KVM_HWTHREAD_IN_IDLE
-	/* DO THIS IN REAL MODE!  See comment above. */
-	stb	r4,HSTATE_HWTHREAD_STATE(r13)
-#endif
 /*
  * Check if we are executing the lite variant with ESL=EC=0
  */
@@ -411,6 +405,18 @@ pnv_powersave_wakeup_mce:
 
 	b	pnv_powersave_wakeup
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+kvm_start_guest_check:
+	li	r0,KVM_HWTHREAD_IN_KERNEL
+	stb	r0,HSTATE_HWTHREAD_STATE(r13)
+	/* Order setting hwthread_state vs. testing hwthread_req */
+	sync
+	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
+	cmpwi	r0,0
+	beqlr
+	b	kvm_start_guest
+#endif
+
 /*
  * Called from reset vector for powersave wakeups.
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
@@ -435,15 +441,9 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	mr	r3,r12
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	li	r0,KVM_HWTHREAD_IN_KERNEL
-	stb	r0,HSTATE_HWTHREAD_STATE(r13)
-	/* Order setting hwthread_state vs. testing hwthread_req */
-	sync
-	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
-	cmpwi	r0,0
-	beq	1f
-	b	kvm_start_guest
-1:
+BEGIN_FTR_SECTION
+	bl	kvm_start_guest_check
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 #endif
 
 	/* Return SRR1 from power7_nap() */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 359c79cdf0cc..e34cd6fb947b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2111,6 +2111,16 @@ static int kvmppc_grab_hwthread(int cpu)
 	struct paca_struct *tpaca;
 	long timeout = 10000;
 
+	/*
+	 * ISA v3.0 idle routines do not set hwthread_state or test
+	 * hwthread_req, so they can not grab idle threads.
+	 */
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		WARN_ON(1);
+		pr_err("KVM: can not control sibling threads\n");
+		return -EBUSY;
+	}
+
 	tpaca = &paca[cpu];
 
 	/* Ensure the thread won't go into the kernel if it wakes */
@@ -2145,10 +2155,12 @@ static void kvmppc_release_hwthread(int cpu)
 	struct paca_struct *tpaca;
 
 	tpaca = &paca[cpu];
-	tpaca->kvm_hstate.hwthread_req = 0;
 	tpaca->kvm_hstate.kvm_vcpu = NULL;
 	tpaca->kvm_hstate.kvm_vcore = NULL;
 	tpaca->kvm_hstate.kvm_split_mode = NULL;
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		tpaca->kvm_hstate.hwthread_req = 0;
+
 }
 
 static void radix_flush_cpu(struct kvm *kvm, int cpu, struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index c52184a8efdf..3e024fd71fe8 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -149,9 +149,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	subf	r4, r4, r3
 	mtspr	SPRN_DEC, r4
 
+BEGIN_FTR_SECTION
 	/* hwthread_req may have got set by cede or no vcpu, so clear it */
 	li	r0, 0
 	stb	r0, HSTATE_HWTHREAD_REQ(r13)
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 
 	/*
 	 * For external interrupts we need to call the Linux
@@ -314,6 +316,7 @@ kvm_novcpu_exit:
  * Relocation is off and most register values are lost.
  * r13 points to the PACA.
  * r3 contains the SRR1 wakeup value, SRR1 is trashed.
+ * This is not used by ISAv3.0B processors.
  */
 	.globl	kvm_start_guest
 kvm_start_guest:
@@ -432,6 +435,9 @@ kvm_secondary_got_guest:
  * While waiting we also need to check if we get given a vcpu to run.
  */
 kvm_no_guest:
+BEGIN_FTR_SECTION
+	twi	31,0,0
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	lbz	r3, HSTATE_HWTHREAD_REQ(r13)
 	cmpwi	r3, 0
 	bne	53f
@@ -2509,8 +2515,10 @@ kvm_do_nap:
 	clrrdi	r0, r0, 1
 	mtspr	SPRN_CTRLT, r0
 
+BEGIN_FTR_SECTION
 	li	r0,1
 	stb	r0,HSTATE_HWTHREAD_REQ(r13)
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	mfspr	r5,SPRN_LPCR
 	ori	r5,r5,LPCR_PECE0 | LPCR_PECE1
 BEGIN_FTR_SECTION
-- 
2.13.3
