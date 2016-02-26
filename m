Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 373061A0B74
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:41:20 +1100 (AEDT)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 828AF140317
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:41:19 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:41:17 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 25FBE3E40030
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:00 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIf0ak38731866
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:00 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIexUN016918
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:40:59 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 02/14] KVM: PPC: Book3S HV: Convert kvmppc_read_intr to a C
 function
Date: Fri, 26 Feb 2016 12:40:20 -0600
Message-Id: <1456512032-31286-3-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modify kvmppc_read_intr to make it a C function.

This also adds in the optimization of clearing saved_xirr in the case
where we completely handle and EOI an IPI.  Without this, the next
device interrupt will require two trips through the host interrupt
handling code.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_builtin.c    |  84 +++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 184 +++++++++++++++++---------------
 2 files changed, 179 insertions(+), 89 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 5f0380d..5db386a 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -25,6 +25,7 @@
 #include <asm/xics.h>
 #include <asm/dbell.h>
 #include <asm/cputhreads.h>
+#include <asm/io.h>
 
 #define KVM_CMA_CHUNK_ORDER	18
 
@@ -286,3 +287,86 @@ void kvmhv_commence_exit(int trap)
 
 struct kvmppc_host_rm_ops *kvmppc_host_rm_ops_hv;
 EXPORT_SYMBOL_GPL(kvmppc_host_rm_ops_hv);
+
+/*
+ * Determine what sort of external interrupt is pending (if any).
+ * Returns:
+ *	0 if no interrupt is pending
+ *	1 if an interrupt is pending that needs to be handled by the host
+ *	-1 if there was a guest wakeup IPI (which has now been cleared)
+ */
+
+long kvmppc_read_intr(struct kvm_vcpu *vcpu, int path)
+{
+	unsigned long xics_phys;
+	u32 h_xirr;
+	__be32 xirr;
+	u32 xisr;
+	u8 host_ipi;
+
+	/* see if a host IPI is pending */
+	host_ipi = local_paca->kvm_hstate.host_ipi;
+	if (host_ipi)
+		return 1;
+
+	/* Now read the interrupt from the ICP */
+	xics_phys = local_paca->kvm_hstate.xics_phys;
+	if (unlikely(!xics_phys))
+		return 1;
+
+	/*
+	 * Save XIRR for later. Since we get control in reverse endian
+	 * on LE systems, save it byte reversed and fetch it back in
+	 * host endian. Note that xirr is the value read from the
+	 * XIRR register, while h_xirr is the host endian version.
+	 */
+	xirr = _lwzcix(xics_phys + XICS_XIRR);
+	h_xirr = be32_to_cpu(xirr);
+	local_paca->kvm_hstate.saved_xirr = h_xirr;
+	xisr = h_xirr & 0xffffff;
+	/*
+	 * Ensure that the store/load complete to guarantee all side
+	 * effects of loading from XIRR has completed
+	 */
+	smp_mb();
+
+	/* if nothing pending in the ICP */
+	if (!xisr)
+		return 0;
+
+	/* We found something in the ICP...
+	 *
+	 * If it is an IPI, clear the MFRR and EOI it.
+	 */
+	if (xisr == XICS_IPI) {
+		_stbcix(xics_phys + XICS_MFRR, 0xff);
+		_stwcix(xics_phys + XICS_XIRR, xirr);
+		/*
+		 * Need to ensure side effects of above stores
+		 * complete before proceeding.
+		 */
+		smp_mb();
+
+		/*
+		 * We need to re-check host IPI now in case it got set in the
+		 * meantime. If it's clear, we bounce the interrupt to the
+		 * guest
+		 */
+		host_ipi = local_paca->kvm_hstate.host_ipi;
+		if (unlikely(host_ipi != 0)) {
+			/* We raced with the host,
+			 * we need to resend that IPI, bummer
+			 */
+			_stbcix(xics_phys + XICS_MFRR, IPI_PRIORITY);
+			/* Let side effects complete */
+			smp_mb();
+			return 1;
+		}
+
+		/* OK, it's an IPI for us */
+		local_paca->kvm_hstate.saved_xirr = 0;
+		return -1;
+	}
+
+	return 1;
+}
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index ed16182..29e6a8a 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -220,6 +220,13 @@ kvmppc_primary_no_guest:
 	li	r3, 0		/* Don't wake on privileged (OS) doorbell */
 	b	kvm_do_nap
 
+/*
+ * kvm_novcpu_wakeup
+ *	Entered from kvm_start_guest if kvm_hstate.napping is set
+ *	to NAPPING_NOVCPU
+ *		r2 = kernel TOC
+ *		r13 = paca
+ */
 kvm_novcpu_wakeup:
 	ld	r1, HSTATE_HOST_R1(r13)
 	ld	r5, HSTATE_KVM_VCORE(r13)
@@ -227,8 +234,18 @@ kvm_novcpu_wakeup:
 	stb	r0, HSTATE_NAPPING(r13)
 
 	/* check the wake reason */
+	ld	r3, HSTATE_KVM_VCPU(r13)
 	bl	kvmppc_check_wake_reason
 
+	/*
+	 * Restore volatile registers since we could have called
+	 * a C routine in kvmppc_check_wake_reason.
+	 * Wake reason (trap) is returned through r31
+	 *	r5 = VCORE
+	 */
+	ld	r5, HSTATE_KVM_VCORE(r13)
+	mr	r12, r31
+
 	/* see if any other thread is already exiting */
 	lwz	r0, VCORE_ENTRY_EXIT(r5)
 	cmpwi	r0, 0x100
@@ -320,7 +337,15 @@ kvm_start_guest:
 	 */
 
 	/* Check the wake reason in SRR1 to see why we got here */
+	ld	r3, HSTATE_KVM_VCPU(r13)
 	bl	kvmppc_check_wake_reason
+	/*
+	 * kvmppc_check_wake_reason could invoke a C routine, but we
+	 * have no volatile registers to restore when we return.
+	 * Wake reason (trap) is returned through r31.
+	 */
+	mr	r12, r31
+
 	cmpdi	r3, 0
 	bge	kvm_no_guest
 
@@ -1230,16 +1255,56 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	/* External interrupt, first check for host_ipi. If this is
 	 * set, we know the host wants us out so let's do it now
 	 */
+	mr	r3, r9
 	bl	kvmppc_read_intr
+
+	/*
+	 * Restore the active volatile registers after returning from
+	 * a C function.
+	 */
+	ld	r9, HSTATE_KVM_VCPU(r13)
+	ld	r10, VCPU_PC(r9)
+	ld	r11, VCPU_MSR(r9)
+	li	r12, BOOK3S_INTERRUPT_EXTERNAL
+
+	/*
+	 * kvmppc_read_intr return codes:
+	 *
+	 * Exit to host (r3 > 0)
+	 *   1 An interrupt is pending that needs to be handled by the host
+	 *     Exit guest and return to host by branching to guest_exit_cont
+	 *
+	 * Before returning to guest, we check if any CPU is heading out
+	 * to the host and if so, we head out also. If no CPUs are heading
+	 * check return values <= 0.
+	 *
+	 * If returning to the guest, we need to restore CTR and XER
+	 * since these are volatile registers, and deliver_guest_interrupt
+	 * does not restore them.
+	 *
+	 * Return to guest (r3 <= 0)
+	 *  0 No external interrupt is pending
+	 * -1 A guest wakeup IPI (which has now been cleared)
+	 *    In either case, we return to guest to deliver any pending
+	 *    guest interrupts.
+	 */
+
 	cmpdi	r3, 0
 	bgt	guest_exit_cont
 
-	/* Check if any CPU is heading out to the host, if so head out too */
+	/* Return code <= 0 */
 4:	ld	r5, HSTATE_KVM_VCORE(r13)
 	lwz	r0, VCORE_ENTRY_EXIT(r5)
 	cmpwi	r0, 0x100
 	mr	r4, r9
-	blt	deliver_guest_interrupt
+	bge	guest_exit_cont
+
+	/* Return code <= 0, return to guest */
+	ld	r6, VCPU_CTR(r4)
+	ld	r7, VCPU_XER(r4)
+	mtctr	r6
+	mtxer	r7
+	b	deliver_guest_interrupt
 
 guest_exit_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
 	/* Save more register state  */
@@ -2319,6 +2384,22 @@ kvm_end_cede:
 	subf	r3, r7, r3
 	mtspr	SPRN_DEC, r3
 
+	/* Check the wake reason in SRR1 to see why we got here */
+	mr	r3, r4
+	bl	kvmppc_check_wake_reason
+
+	/*
+	 * Restore volatile registers since we could have called a
+	 * C routine in kvmppc_check_wake_reason
+	 *	r4 = VCPU
+	 * Wake reason (trap) is returned through r31
+	 * r3 tells us whether we need to return to host or not
+	 * WARNING: it gets checked much further down a second time:
+	 * should not modify r3 until this check is done.
+	 */
+	ld	r4, HSTATE_KVM_VCPU(r13)
+	mr	r12, r31
+
 	/* Load NV GPRS */
 	ld	r14, VCPU_GPR(R14)(r4)
 	ld	r15, VCPU_GPR(R15)(r4)
@@ -2338,9 +2419,6 @@ kvm_end_cede:
 	ld	r29, VCPU_GPR(R29)(r4)
 	ld	r30, VCPU_GPR(R30)(r4)
 	ld	r31, VCPU_GPR(R31)(r4)
- 
-	/* Check the wake reason in SRR1 to see why we got here */
-	bl	kvmppc_check_wake_reason
 
 	/* clear our bit in vcore->napping_threads */
 34:	ld	r5,HSTATE_KVM_VCORE(r13)
@@ -2355,7 +2433,7 @@ kvm_end_cede:
 	li	r0,0
 	stb	r0,HSTATE_NAPPING(r13)
 
-	/* See if the wake reason means we need to exit */
+	/* See if the wake reason saved in r3 means we need to exit */
 	stw	r12, VCPU_TRAP(r4)
 	mr	r9, r4
 	cmpdi	r3, 0
@@ -2423,9 +2501,15 @@ machine_check_realmode:
  *	1 if something happened that needs to be handled by the host
  *	-1 if there was a guest wakeup (IPI or msgsnd)
  *
- * Also sets r12 to the interrupt vector for any interrupt that needs
+ * Also sets r31 to the interrupt vector for any interrupt that needs
  * to be handled now by the host (0x500 for external interrupt), or zero.
- * Modifies r0, r6, r7, r8.
+ * Modifies all volatile registers (since it may call a C function).
+ * Since this routine modifies r31, it cannot be called by a C function.
+ * This routine branches to kvmppc_read_intr, a C function, if an external
+ * interrupt is pending. Thus, this routine can only be called through
+ * instructions like "bl" which set the link register.
+ *
+ * Entered with r3 = VCPU
  */
 kvmppc_check_wake_reason:
 	mfspr	r6, SPRN_SRR1
@@ -2435,10 +2519,10 @@ FTR_SECTION_ELSE
 	rlwinm	r6, r6, 45-31, 0xe	/* P7 wake reason field is 3 bits */
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_207S)
 	cmpwi	r6, 8			/* was it an external interrupt? */
-	li	r12, BOOK3S_INTERRUPT_EXTERNAL
+	li	r31, BOOK3S_INTERRUPT_EXTERNAL
 	beq	kvmppc_read_intr	/* if so, see what it was */
 	li	r3, 0
-	li	r12, 0
+	li	r31, 0
 	cmpwi	r6, 6			/* was it the decrementer? */
 	beq	0f
 BEGIN_FTR_SECTION
@@ -2451,7 +2535,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 0:	blr
 
 	/* hypervisor doorbell */
-3:	li	r12, BOOK3S_INTERRUPT_H_DOORBELL
+3:	li	r31, BOOK3S_INTERRUPT_H_DOORBELL
 
 	/*
 	 * Clear the doorbell as we will invoke the handler
@@ -2469,84 +2553,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	blr
 
 /*
- * Determine what sort of external interrupt is pending (if any).
- * Returns:
- *	0 if no interrupt is pending
- *	1 if an interrupt is pending that needs to be handled by the host
- *	-1 if there was a guest wakeup IPI (which has now been cleared)
- * Modifies r0, r6, r7, r8, returns value in r3.
- */
-kvmppc_read_intr:
-	/* see if a host IPI is pending */
-	li	r3, 1
-	lbz	r0, HSTATE_HOST_IPI(r13)
-	cmpwi	r0, 0
-	bne	1f
-
-	/* Now read the interrupt from the ICP */
-	ld	r6, HSTATE_XICS_PHYS(r13)
-	li	r7, XICS_XIRR
-	cmpdi	r6, 0
-	beq-	1f
-	lwzcix	r0, r6, r7
-	/*
-	 * Save XIRR for later. Since we get in in reverse endian on LE
-	 * systems, save it byte reversed and fetch it back in host endian.
-	 */
-	li	r3, HSTATE_SAVED_XIRR
-	STWX_BE	r0, r3, r13
-#ifdef __LITTLE_ENDIAN__
-	lwz	r3, HSTATE_SAVED_XIRR(r13)
-#else
-	mr	r3, r0
-#endif
-	rlwinm.	r3, r3, 0, 0xffffff
-	sync
-	beq	1f			/* if nothing pending in the ICP */
-
-	/* We found something in the ICP...
-	 *
-	 * If it's not an IPI, stash it in the PACA and return to
-	 * the host, we don't (yet) handle directing real external
-	 * interrupts directly to the guest
-	 */
-	cmpwi	r3, XICS_IPI		/* if there is, is it an IPI? */
-	bne	42f
-
-	/* It's an IPI, clear the MFRR and EOI it */
-	li	r3, 0xff
-	li	r8, XICS_MFRR
-	stbcix	r3, r6, r8		/* clear the IPI */
-	stwcix	r0, r6, r7		/* EOI it */
-	sync
-
-	/* We need to re-check host IPI now in case it got set in the
-	 * meantime. If it's clear, we bounce the interrupt to the
-	 * guest
-	 */
-	lbz	r0, HSTATE_HOST_IPI(r13)
-	cmpwi	r0, 0
-	bne-	43f
-
-	/* OK, it's an IPI for us */
-	li	r12, 0
-	li	r3, -1
-1:	blr
-
-42:	/* It's not an IPI and it's for the host. We saved a copy of XIRR in
-	 * the PACA earlier, it will be picked up by the host ICP driver
-	 */
-	li	r3, 1
-	b	1b
-
-43:	/* We raced with the host, we need to resend that IPI, bummer */
-	li	r0, IPI_PRIORITY
-	stbcix	r0, r6, r8		/* set the IPI */
-	sync
-	li	r3, 1
-	b	1b
-
-/*
  * Save away FP, VMX and VSX registers.
  * r3 = vcpu pointer
  * N.B. r30 and r31 are volatile across this function,
-- 
1.8.3.4
