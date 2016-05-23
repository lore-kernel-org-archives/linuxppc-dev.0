Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rD2JK6GT2zDqNy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 01:19:13 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 23 May 2016 09:19:10 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v3 3/9] powerpc/powernv: Rename reusable idle functions to
 hardware agnostic names
Date: Mon, 23 May 2016 20:48:36 +0530
Message-Id: <1464016722-7488-4-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1464016722-7488-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1464016722-7488-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Functions like power7_wakeup_loss, power7_wakeup_noloss,
power7_wakeup_tb_loss are used by POWER7 and POWER8 hardware. They can
also be used by POWER9. Hence rename these functions hardware agnostic
names.

Suggested-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
New in v3

 arch/powerpc/kernel/exceptions-64s.S    |  6 +++---
 arch/powerpc/kernel/idle_power_common.S | 16 ++++++++--------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4a74d6a..a0da627 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -108,7 +108,7 @@ BEGIN_FTR_SECTION
 
 	cmpwi	cr3,r13,2
 	GET_PACA(r13)
-	bl	power7_restore_hyp_resource
+	bl	pnv_restore_hyp_resource
 
 	li	r0,PNV_THREAD_RUNNING
 	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
@@ -128,8 +128,8 @@ BEGIN_FTR_SECTION
 	/* Return SRR1 from power7_nap() */
 	mfspr	r3,SPRN_SRR1
 	blt	cr3,2f
-	b	power7_wakeup_loss
-2:	b	power7_wakeup_noloss
+	b	pnv_wakeup_loss
+2:	b	pnv_wakeup_noloss
 
 9:
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
index db59613..973c9a1 100644
--- a/arch/powerpc/kernel/idle_power_common.S
+++ b/arch/powerpc/kernel/idle_power_common.S
@@ -284,7 +284,7 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
  * r13 - Contents of HSPRG0
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
-_GLOBAL(power7_restore_hyp_resource)
+_GLOBAL(pnv_restore_hyp_resource)
 	/*
 	 * Check if last bit of HSPGR0 is set. This indicates whether we are
 	 * waking up from winkle.
@@ -296,7 +296,7 @@ _GLOBAL(power7_restore_hyp_resource)
 
 	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi   cr2,r0,PNV_THREAD_NAP
-	bgt     cr2,power7_wakeup_tb_loss	/* Either sleep or Winkle */
+	bgt     cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
 
 	/*
 	 * We fall through here if PACA_THREAD_IDLE_STATE shows we are waking
@@ -306,10 +306,10 @@ _GLOBAL(power7_restore_hyp_resource)
 	bgt	cr3,.
 
 	blr	/* Return back to System Reset vector from where
-		   power7_restore_hyp_resource was invoked */
+		   pnv_restore_hyp_resource was invoked */
 
 
-_GLOBAL(power7_wakeup_tb_loss)
+_GLOBAL(pnv_wakeup_tb_loss)
 	ld	r2,PACATOC(r13);
 	ld	r1,PACAR1(r13)
 	/*
@@ -476,7 +476,7 @@ hypervisor_state_restored:
 	mtspr	SPRN_SRR1,r16
 	mtlr	r17
 	blr	/* Return back to System Reset vector from where
-		   power7_restore_hyp_resource was invoked */
+		   pnv_restore_hyp_resource was invoked */
 
 fastsleep_workaround_at_exit:
 	li	r3,1
@@ -489,7 +489,7 @@ fastsleep_workaround_at_exit:
  * R3 here contains the value that will be returned to the caller
  * of power7_nap.
  */
-_GLOBAL(power7_wakeup_loss)
+_GLOBAL(pnv_wakeup_loss)
 	ld	r1,PACAR1(r13)
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
@@ -509,10 +509,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
  * R3 here contains the value that will be returned to the caller
  * of power7_nap.
  */
-_GLOBAL(power7_wakeup_noloss)
+_GLOBAL(pnv_wakeup_noloss)
 	lbz	r0,PACA_NAPSTATELOST(r13)
 	cmpwi	r0,0
-	bne	power7_wakeup_loss
+	bne	pnv_wakeup_loss
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index e571ad2..86f0cae 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -392,7 +392,7 @@ kvm_no_guest:
 	cmpwi	r3, 0
 	bne	54f
 /*
- * We jump to power7_wakeup_loss, which will return to the caller
+ * We jump to pnv_wakeup_loss, which will return to the caller
  * of power7_nap in the powernv cpu offline loop.  The value we
  * put in r3 becomes the return value for power7_nap.
  */
@@ -401,7 +401,7 @@ kvm_no_guest:
 	rlwimi	r4, r3, 0, LPCR_PECE0 | LPCR_PECE1
 	mtspr	SPRN_LPCR, r4
 	li	r3, 0
-	b	power7_wakeup_loss
+	b	pnv_wakeup_loss
 
 53:	HMT_LOW
 	ld	r5, HSTATE_KVM_VCORE(r13)
-- 
2.4.11
