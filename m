Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE5CC1A01F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 14:48:44 +1100 (AEDT)
Date: Wed, 3 Dec 2014 14:48:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: powernv: Return to cpu offline loop when finished
 in KVM guest
Message-ID: <20141203034840.GA612@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a secondary hardware thread has finished running a KVM guest, we
currently put that thread into nap mode using a nap instruction in
the KVM code.  This changes the code so that instead of doing a nap
instruction directly, we instead cause the call to power7_nap() that
put the thread into nap mode to return.  The reason for doing this is
to avoid having the KVM code having to know what low-power mode to
put the thread into.

In the case of a secondary thread used to run a KVM guest, the thread
will be offline from the point of view of the host kernel, and the
relevant power7_nap() call is the one in pnv_smp_cpu_disable().
In this case we don't want to clear pending IPIs in the offline loop
in that function, since that might cause us to miss the wakeup for
the next time the thread needs to run a guest.  To tell whether or
not to clear the interrupt, we use the SRR1 value returned from
power7_nap(), and check if it indicates an external interrupt.  We
arrange that the return from power7_nap() when we have finished running
a guest returns 0, so pending interrupts don't get flushed in that
case.

Note that it is important a secondary thread that has finished
executing in the guest, or that didn't have a guest to run, should
not return to power7_nap's caller while the kvm_hstate.hwthread_req
flag in the PACA is non-zero, because the return from power7_nap
will reenable the MMU, and the MMU might still be in guest context.
In this situation we spin at low priority in real mode waiting for
hwthread_req to become zero.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
I think this would be best going through the powerpc tree.  Alex,
if you can give me an acked-by for this that would be appreciated.

 arch/powerpc/include/asm/processor.h    |  2 +-
 arch/powerpc/kernel/exceptions-64s.S    |  2 ++
 arch/powerpc/kernel/idle_power7.S       | 12 ++++++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 54 ++++++++++++++++++++++-----------
 arch/powerpc/platforms/powernv/smp.c    | 23 +++++++++++---
 5 files changed, 68 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index dda7ac4..29c3798 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -451,7 +451,7 @@ extern unsigned long cpuidle_disable;
 enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
-extern void power7_nap(int check_irq);
+extern unsigned long power7_nap(int check_irq);
 extern void power7_sleep(void);
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a1d45c1..7f29c5f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -131,6 +131,8 @@ BEGIN_FTR_SECTION
 1:
 #endif
 
+	/* Return SRR1 from power7_nap() */
+	mfspr	r3,SPRN_SRR1
 	beq	cr1,2f
 	b	power7_wakeup_noloss
 2:	b	power7_wakeup_loss
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index c0754bb..18c0687 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -212,6 +212,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	mtspr	SPRN_SRR0,r5
 	rfid
 
+/*
+ * R3 here contains the value that will be returned to the caller
+ * of power7_nap.
+ */
 _GLOBAL(power7_wakeup_loss)
 	ld	r1,PACAR1(r13)
 BEGIN_FTR_SECTION
@@ -219,15 +223,19 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	REST_NVGPRS(r1)
 	REST_GPR(2, r1)
-	ld	r3,_CCR(r1)
+	ld	r6,_CCR(r1)
 	ld	r4,_MSR(r1)
 	ld	r5,_NIP(r1)
 	addi	r1,r1,INT_FRAME_SIZE
-	mtcr	r3
+	mtcr	r6
 	mtspr	SPRN_SRR1,r4
 	mtspr	SPRN_SRR0,r5
 	rfid
 
+/*
+ * R3 here contains the value that will be returned to the caller
+ * of power7_nap.
+ */
 _GLOBAL(power7_wakeup_noloss)
 	lbz	r0,PACA_NAPSTATELOST(r13)
 	cmpwi	r0,0
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index edb2ccd..65c105b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -201,8 +201,6 @@ kvmppc_primary_no_guest:
 	bge	kvm_novcpu_exit	/* another thread already exiting */
 	li	r3, NAPPING_NOVCPU
 	stb	r3, HSTATE_NAPPING(r13)
-	li	r3, 1
-	stb	r3, HSTATE_HWTHREAD_REQ(r13)
 
 	b	kvm_do_nap
 
@@ -293,6 +291,8 @@ kvm_start_guest:
 	/* if we have no vcpu to run, go back to sleep */
 	beq	kvm_no_guest
 
+kvm_secondary_got_guest:
+
 	/* Set HSTATE_DSCR(r13) to something sensible */
 	ld	r6, PACA_DSCR(r13)
 	std	r6, HSTATE_DSCR(r13)
@@ -318,27 +318,46 @@ kvm_start_guest:
 	stwcx.	r3, 0, r4
 	bne	51b
 
+/*
+ * At this point we have finished executing in the guest.
+ * We need to wait for hwthread_req to become zero, since
+ * we may not turn on the MMU while hwthread_req is non-zero.
+ * While waiting we also need to check if we get given a vcpu to run.
+ */
 kvm_no_guest:
-	li	r0, KVM_HWTHREAD_IN_NAP
+	lbz	r3, HSTATE_HWTHREAD_REQ(r13)
+	cmpwi	r3, 0
+	bne	53f
+	HMT_MEDIUM
+	li	r0, KVM_HWTHREAD_IN_KERNEL
 	stb	r0, HSTATE_HWTHREAD_STATE(r13)
-kvm_do_nap:
-	/* Clear the runlatch bit before napping */
-	mfspr	r2, SPRN_CTRLF
-	clrrdi	r2, r2, 1
-	mtspr	SPRN_CTRLT, r2
-
+	/* need to recheck hwthread_req after a barrier, to avoid race */
+	sync
+	lbz	r3, HSTATE_HWTHREAD_REQ(r13)
+	cmpwi	r3, 0
+	bne	54f
+/*
+ * We jump to power7_wakeup_loss, which will return to the caller
+ * of power7_nap in the powernv cpu offline loop.  The value we
+ * put in r3 becomes the return value for power7_nap.
+ */
 	li	r3, LPCR_PECE0
 	mfspr	r4, SPRN_LPCR
 	rlwimi	r4, r3, 0, LPCR_PECE0 | LPCR_PECE1
 	mtspr	SPRN_LPCR, r4
-	isync
-	std	r0, HSTATE_SCRATCH0(r13)
-	ptesync
-	ld	r0, HSTATE_SCRATCH0(r13)
-1:	cmpd	r0, r0
-	bne	1b
-	nap
-	b	.
+	li	r3, 0
+	b	power7_wakeup_loss
+
+53:	HMT_LOW
+	ld	r4, HSTATE_KVM_VCPU(r13)
+	cmpdi	r4, 0
+	beq	kvm_no_guest
+	HMT_MEDIUM
+	b	kvm_secondary_got_guest
+
+54:	li	r0, KVM_HWTHREAD_IN_KVM
+	stb	r0, HSTATE_HWTHREAD_STATE(r13)
+	b	kvm_no_guest
 
 /******************************************************************************
  *                                                                            *
@@ -2172,6 +2191,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_206)
 	 * occurs, with PECE1, PECE0 and PECEDP set in LPCR. Also clear the
 	 * runlatch bit before napping.
 	 */
+kvm_do_nap:
 	mfspr	r2, SPRN_CTRLF
 	clrrdi	r2, r2, 1
 	mtspr	SPRN_CTRLT, r2
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 4753958..b716f66 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -149,6 +149,7 @@ static int pnv_smp_cpu_disable(void)
 static void pnv_smp_cpu_kill_self(void)
 {
 	unsigned int cpu;
+	unsigned long srr1;
 
 	/* Standard hot unplug procedure */
 	local_irq_disable();
@@ -165,13 +166,25 @@ static void pnv_smp_cpu_kill_self(void)
 	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
 	while (!generic_check_cpu_restart(cpu)) {
 		ppc64_runlatch_off();
-		power7_nap(1);
+		srr1 = power7_nap(1);
 		ppc64_runlatch_on();
 
-		/* Clear the IPI that woke us up */
-		icp_native_flush_interrupt();
-		local_paca->irq_happened &= PACA_IRQ_HARD_DIS;
-		mb();
+		/*
+		 * If the SRR1 value indicates that we woke up due to
+		 * an external interrupt, then clear the interrupt.
+		 * We clear the interrupt before checking for the
+		 * reason, so as to avoid a race where we wake up for
+		 * some other reason, find nothing and clear the interrupt
+		 * just as some other cpu is sending us an interrupt.
+		 * If we returned from power7_nap as a result of
+		 * having finished executing in a KVM guest, then srr1
+		 * contains 0.
+		 */
+		if ((srr1 & SRR1_WAKEMASK) == SRR1_WAKEEE) {
+			icp_native_flush_interrupt();
+			local_paca->irq_happened &= PACA_IRQ_HARD_DIS;
+			smp_mb();
+		}
 
 		if (cpu_core_split_required())
 			continue;
-- 
2.1.3
