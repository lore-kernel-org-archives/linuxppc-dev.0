Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM2RK0QNKzF0RZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 20:51:25 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 1/6] KVM: PPC: Book3S HV: Make sure we don't re-enter guest
 without XIVE loaded
Date: Wed, 17 Jan 2018 20:51:10 +1100
Message-Id: <1516182675-25331-2-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1516182675-25331-1-git-send-email-paulus@ozlabs.org>
References: <1516182675-25331-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a bug where it is possible to enter a guest on a POWER9
system without having the XIVE (interrupt controller) context loaded.
This can happen because we unload the XIVE context from the CPU
before doing the real-mode handling for machine checks.  After the
real-mode handler runs, it is possible that we re-enter the guest
via a fast path which does not load the XIVE context.

To fix this, we move the unloading of the XIVE context to come after
the real-mode machine check handler is called.

Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
Cc: stable@vger.kernel.org # v4.11+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index c8ffd69..76332a3 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1423,6 +1423,26 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	blt	deliver_guest_interrupt
 
 guest_exit_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
+	/* Save more register state  */
+	mfdar	r6
+	mfdsisr	r7
+	std	r6, VCPU_DAR(r9)
+	stw	r7, VCPU_DSISR(r9)
+	/* don't overwrite fault_dar/fault_dsisr if HDSI */
+	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
+	beq	mc_cont
+	std	r6, VCPU_FAULT_DAR(r9)
+	stw	r7, VCPU_FAULT_DSISR(r9)
+
+	/* See if it is a machine check */
+	cmpwi	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
+	beq	machine_check_realmode
+mc_cont:
+#ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
+	addi	r3, r9, VCPU_TB_RMEXIT
+	mr	r4, r9
+	bl	kvmhv_accumulate_time
+#endif
 #ifdef CONFIG_KVM_XICS
 	/* We are exiting, pull the VP from the XIVE */
 	lwz	r0, VCPU_XIVE_PUSHED(r9)
@@ -1460,26 +1480,6 @@ guest_exit_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
 	eieio
 1:
 #endif /* CONFIG_KVM_XICS */
-	/* Save more register state  */
-	mfdar	r6
-	mfdsisr	r7
-	std	r6, VCPU_DAR(r9)
-	stw	r7, VCPU_DSISR(r9)
-	/* don't overwrite fault_dar/fault_dsisr if HDSI */
-	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
-	beq	mc_cont
-	std	r6, VCPU_FAULT_DAR(r9)
-	stw	r7, VCPU_FAULT_DSISR(r9)
-
-	/* See if it is a machine check */
-	cmpwi	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
-	beq	machine_check_realmode
-mc_cont:
-#ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
-	addi	r3, r9, VCPU_TB_RMEXIT
-	mr	r4, r9
-	bl	kvmhv_accumulate_time
-#endif
 
 	mr 	r3, r12
 	/* Increment exit count, poke other threads to exit */
-- 
2.7.4
