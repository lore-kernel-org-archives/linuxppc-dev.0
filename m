Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPvgY2FY0zDqGR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 02:55:05 +1000 (AEST)
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58GsX1r041407
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 12:55:02 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9mfwdj7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 12:55:02 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:55:00 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v6 02/11] powerpc/kvm: make hypervisor state restore a function
Date: Wed,  8 Jun 2016 11:54:22 -0500
In-Reply-To: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <1465404871-5406-3-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the current code, when the thread wakes up in reset vector, some
of the state restore code and check for whether a thread needs to
branch to kvm is duplicated. Reorder the code such that this
duplication is avoided.

At a higher level this is what the change looks like-

Before this patch -
power7_wakeup_tb_loss:
	restore hypervisor state
	if (thread needed by kvm)
		goto kvm_start_guest
	restore nvgprs, cr, pc
	rfid to process context

power7_wakeup_loss:
	restore nvgprs, cr, pc
	rfid to process context

reset vector:
	if (waking from deep idle states)
		goto power7_wakeup_tb_loss
	else
		if (thread needed by kvm)
			goto kvm_start_guest
		goto power7_wakeup_loss

After this patch -
power7_wakeup_tb_loss:
	restore hypervisor state
	return

power7_restore_hyp_resource():
	if (waking from deep idle states)
		goto power7_wakeup_tb_loss
	return

power7_wakeup_loss:
	restore nvgprs, cr, pc
	rfid to process context

reset vector:
	power7_restore_hyp_resource()
	if (thread needed by kvm)
                goto kvm_start_guest
	goto power7_wakeup_loss

Reviewed-by: Paul Mackerras <paulus@samba.org>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
- No changes since v3

Changes in v3:
=============
- Retaining GET_PACA(r13) in System Reset vector instead of moving it
  to power7_restore_hyp_resource
- Added comments indicating entry conditions for power7_restore_hyp_resource
- Improved comments around return statements

 arch/powerpc/kernel/exceptions-64s.S | 28 ++------------
 arch/powerpc/kernel/idle_power7.S    | 72 +++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4c94406..4a74d6a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -107,25 +107,9 @@ BEGIN_FTR_SECTION
 	beq	9f
 
 	cmpwi	cr3,r13,2
-
-	/*
-	 * Check if last bit of HSPGR0 is set. This indicates whether we are
-	 * waking up from winkle.
-	 */
 	GET_PACA(r13)
-	clrldi	r5,r13,63
-	clrrdi	r13,r13,1
-	cmpwi	cr4,r5,1
-	mtspr	SPRN_HSPRG0,r13
+	bl	power7_restore_hyp_resource
 
-	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
-	cmpwi   cr2,r0,PNV_THREAD_NAP
-	bgt     cr2,8f				/* Either sleep or Winkle */
-
-	/* Waking up from nap should not cause hypervisor state loss */
-	bgt	cr3,.
-
-	/* Waking up from nap */
 	li	r0,PNV_THREAD_RUNNING
 	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
 
@@ -143,13 +127,9 @@ BEGIN_FTR_SECTION
 
 	/* Return SRR1 from power7_nap() */
 	mfspr	r3,SPRN_SRR1
-	beq	cr3,2f
-	b	power7_wakeup_noloss
-2:	b	power7_wakeup_loss
-
-	/* Fast Sleep wakeup on PowerNV */
-8:	GET_PACA(r13)
-	b 	power7_wakeup_tb_loss
+	blt	cr3,2f
+	b	power7_wakeup_loss
+2:	b	power7_wakeup_noloss
 
 9:
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 705c867..d5def06 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -276,6 +276,39 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 20:	nop;
 
 
+/*
+ * Called from reset vector. Check whether we have woken up with
+ * hypervisor state loss. If yes, restore hypervisor state and return
+ * back to reset vector.
+ *
+ * r13 - Contents of HSPRG0
+ * cr3 - set to gt if waking up with partial/complete hypervisor state loss
+ */
+_GLOBAL(power7_restore_hyp_resource)
+	/*
+	 * Check if last bit of HSPGR0 is set. This indicates whether we are
+	 * waking up from winkle.
+	 */
+	clrldi	r5,r13,63
+	clrrdi	r13,r13,1
+	cmpwi	cr4,r5,1
+	mtspr	SPRN_HSPRG0,r13
+
+	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
+	cmpwi   cr2,r0,PNV_THREAD_NAP
+	bgt     cr2,power7_wakeup_tb_loss	/* Either sleep or Winkle */
+
+	/*
+	 * We fall through here if PACA_THREAD_IDLE_STATE shows we are waking
+	 * up from nap. At this stage CR3 shouldn't contains 'gt' since that
+	 * indicates we are waking with hypervisor state loss from nap.
+	 */
+	bgt	cr3,.
+
+	blr	/* Return back to System Reset vector from where
+		   power7_restore_hyp_resource was invoked */
+
+
 _GLOBAL(power7_wakeup_tb_loss)
 	ld	r2,PACATOC(r13);
 	ld	r1,PACAR1(r13)
@@ -284,11 +317,13 @@ _GLOBAL(power7_wakeup_tb_loss)
 	 * and they are restored before switching to the process context. Hence
 	 * until they are restored, they are free to be used.
 	 *
-	 * Save SRR1 in a NVGPR as it might be clobbered in opal_call_realmode
-	 * (called in CHECK_HMI_INTERRUPT). SRR1 is required to determine the
-	 * wakeup reason if we branch to kvm_start_guest.
+	 * Save SRR1 and LR in NVGPRs as they might be clobbered in
+	 * opal_call_realmode (called in CHECK_HMI_INTERRUPT). SRR1 is required
+	 * to determine the wakeup reason if we branch to kvm_start_guest. LR
+	 * is required to return back to reset vector after hypervisor state
+	 * restore is complete.
 	 */
-
+	mflr	r17
 	mfspr	r16,SPRN_SRR1
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
@@ -438,33 +473,10 @@ common_exit:
 
 hypervisor_state_restored:
 
-	li	r5,PNV_THREAD_RUNNING
-	stb     r5,PACA_THREAD_IDLE_STATE(r13)
-
 	mtspr	SPRN_SRR1,r16
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	li      r0,KVM_HWTHREAD_IN_KERNEL
-	stb     r0,HSTATE_HWTHREAD_STATE(r13)
-	/* Order setting hwthread_state vs. testing hwthread_req */
-	sync
-	lbz     r0,HSTATE_HWTHREAD_REQ(r13)
-	cmpwi   r0,0
-	beq     6f
-	b       kvm_start_guest
-6:
-#endif
-
-	REST_NVGPRS(r1)
-	REST_GPR(2, r1)
-	ld	r3,_CCR(r1)
-	ld	r4,_MSR(r1)
-	ld	r5,_NIP(r1)
-	addi	r1,r1,INT_FRAME_SIZE
-	mtcr	r3
-	mfspr	r3,SPRN_SRR1		/* Return SRR1 */
-	mtspr	SPRN_SRR1,r4
-	mtspr	SPRN_SRR0,r5
-	rfid
+	mtlr	r17
+	blr	/* Return back to System Reset vector from where
+		   power7_restore_hyp_resource was invoked */
 
 fastsleep_workaround_at_exit:
 	li	r3,1
-- 
2.1.4
