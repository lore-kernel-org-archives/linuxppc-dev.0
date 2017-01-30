Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlnJ2BChzDqDC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:12 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 18/20] KVM: PPC: Book3S HV: Allow guest exit path to have
 MMU on
Date: Mon, 30 Jan 2017 21:21:51 +1100
Message-Id: <1485771713-24801-19-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we allow LPCR[AIL] to be set for radix guests, then interrupts from
the guest to the host can be delivered by the hardware with relocation
on, and thus the code path starting at kvmppc_interrupt_hv can be
executed in virtual mode (MMU on) for radix guests (previously it was
only ever executed in real mode).

Most of the code is indifferent to whether the MMU is on or off, but
the calls to OPAL that use the real-mode OPAL entry code need to
be switched to use the virtual-mode code instead.  The affected
calls are the calls to the OPAL XICS emulation functions in
kvmppc_read_one_intr() and related functions.  We test the MSR[IR]
bit to detect whether we are in real or virtual mode, and call the
opal_rm_* or opal_* function as appropriate.

The other place that depends on the MMU being off is the optimization
where the guest exit code jumps to the external interrupt vector or
hypervisor doorbell interrupt vector, or returns to its caller (which
is __kvmppc_vcore_entry).  If the MMU is on and we are returning to
the caller, then we don't need to use an rfid instruction since the
MMU is already on; a simple blr suffices.  If there is an external
or hypervisor doorbell interrupt to handle, we branch to the
relocation-on version of the interrupt vector.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_builtin.c    | 38 ++++++++++++++++++++++-----------
 arch/powerpc/kvm/book3s_hv_rm_xics.c    |  8 +++----
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 29 +++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 5bb24be..fe08fea 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -29,6 +29,11 @@
 #include <asm/opal.h>
 #include <asm/smp.h>
 
+static bool in_realmode(void)
+{
+	return !(mfmsr() & MSR_IR);
+}
+
 #define KVM_CMA_CHUNK_ORDER	18
 
 /*
@@ -200,7 +205,6 @@ static inline void rm_writeb(unsigned long paddr, u8 val)
 
 /*
  * Send an interrupt or message to another CPU.
- * This can only be called in real mode.
  * The caller needs to include any barrier needed to order writes
  * to memory vs. the IPI/message.
  */
@@ -226,7 +230,9 @@ void kvmhv_rm_send_ipi(int cpu)
 
 	/* Else poke the target with an IPI */
 	xics_phys = paca[cpu].kvm_hstate.xics_phys;
-	if (xics_phys)
+	if (!in_realmode())
+		opal_int_set_mfrr(get_hard_smp_processor_id(cpu), IPI_PRIORITY);
+	else if (xics_phys)
 		rm_writeb(xics_phys + XICS_MFRR, IPI_PRIORITY);
 	else
 		opal_rm_int_set_mfrr(get_hard_smp_processor_id(cpu),
@@ -412,14 +418,15 @@ static long kvmppc_read_one_intr(bool *again)
 
 	/* Now read the interrupt from the ICP */
 	xics_phys = local_paca->kvm_hstate.xics_phys;
-	if (!xics_phys) {
-		/* Use OPAL to read the XIRR */
+	rc = 0;
+	if (!in_realmode())
+		rc = opal_int_get_xirr(&xirr, false);
+	else if (!xics_phys)
 		rc = opal_rm_int_get_xirr(&xirr, false);
-		if (rc < 0)
-			return 1;
-	} else {
+	else
 		xirr = _lwzcix(xics_phys + XICS_XIRR);
-	}
+	if (rc < 0)
+		return 1;
 
 	/*
 	 * Save XIRR for later. Since we get control in reverse endian
@@ -445,15 +452,19 @@ static long kvmppc_read_one_intr(bool *again)
 	 * If it is an IPI, clear the MFRR and EOI it.
 	 */
 	if (xisr == XICS_IPI) {
-		if (xics_phys) {
+		rc = 0;
+		if (!in_realmode()) {
+			opal_int_set_mfrr(hard_smp_processor_id(), 0xff);
+			rc = opal_int_eoi(h_xirr);
+		} else if (xics_phys) {
 			_stbcix(xics_phys + XICS_MFRR, 0xff);
 			_stwcix(xics_phys + XICS_XIRR, xirr);
 		} else {
 			opal_rm_int_set_mfrr(hard_smp_processor_id(), 0xff);
 			rc = opal_rm_int_eoi(h_xirr);
-			/* If rc > 0, there is another interrupt pending */
-			*again = rc > 0;
 		}
+		/* If rc > 0, there is another interrupt pending */
+		*again = rc > 0;
 
 		/*
 		 * Need to ensure side effects of above stores
@@ -471,7 +482,10 @@ static long kvmppc_read_one_intr(bool *again)
 			/* We raced with the host,
 			 * we need to resend that IPI, bummer
 			 */
-			if (xics_phys)
+			if (!in_realmode())
+				opal_int_set_mfrr(hard_smp_processor_id(),
+						  IPI_PRIORITY);
+			else if (xics_phys)
 				_stbcix(xics_phys + XICS_MFRR, IPI_PRIORITY);
 			else
 				opal_rm_int_set_mfrr(hard_smp_processor_id(),
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 06edc43..7e2eb3e 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -70,11 +70,9 @@ static inline void icp_send_hcore_msg(int hcore, struct kvm_vcpu *vcpu)
 	hcpu = hcore << threads_shift;
 	kvmppc_host_rm_ops_hv->rm_core[hcore].rm_data = vcpu;
 	smp_muxed_ipi_set_message(hcpu, PPC_MSG_RM_HOST_ACTION);
-	if (paca[hcpu].kvm_hstate.xics_phys)
-		icp_native_cause_ipi_rm(hcpu);
-	else
-		opal_rm_int_set_mfrr(get_hard_smp_processor_id(hcpu),
-				     IPI_PRIORITY);
+	kvmppc_set_host_ipi(hcpu, 1);
+	smp_mb();
+	kvmhv_rm_send_ipi(hcpu);
 }
 #else
 static inline void icp_send_hcore_msg(int hcore, struct kvm_vcpu *vcpu) { }
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 2da08d7..ab390bc 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -148,6 +148,15 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	addi	r1, r1, 112
 	ld	r7, HSTATE_HOST_MSR(r13)
 
+	/*
+	 * If we came back from the guest via a relocation-on interrupt,
+	 * we will be in virtual mode at this point, which makes it a
+	 * little easier to get back to the caller.
+	 */
+	mfmsr	r0
+	andi.	r0, r0, MSR_IR		/* in real mode? */
+	bne	.Lvirt_return
+
 	cmpwi	cr1, r12, BOOK3S_INTERRUPT_MACHINE_CHECK
 	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
 	beq	11f
@@ -181,6 +190,26 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtspr SPRN_HSRR1, r7
 	ba    0xe80
 
+	/* Virtual-mode return - can't get here for HMI or machine check */
+.Lvirt_return:
+	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
+	beq	16f
+	cmpwi	r12, BOOK3S_INTERRUPT_H_DOORBELL
+	beq	17f
+	andi.	r0, r7, MSR_EE		/* were interrupts hard-enabled? */
+	beq	18f
+	mtmsrd	r7, 1			/* if so then re-enable them */
+18:	mtlr	r8
+	blr
+
+16:	mtspr	SPRN_HSRR0, r8		/* jump to reloc-on external vector */
+	mtspr	SPRN_HSRR1, r7
+	b	exc_virt_0x4500_hardware_interrupt
+
+17:	mtspr	SPRN_HSRR0, r8
+	mtspr	SPRN_HSRR1, r7
+	b	exc_virt_0x4e80_h_doorbell
+
 kvmppc_primary_no_guest:
 	/* We handle this much like a ceded vcpu */
 	/* put the HDEC into the DEC, since HDEC interrupts don't wake us */
-- 
2.7.4
