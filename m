Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDbWS2WNMzDqMq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 23:15:48 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 24 May 2016 09:15:46 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v4 05/10] powerpc/powernv: Make pnv_powersave_common more
 generic
Date: Tue, 24 May 2016 18:45:09 +0530
Message-Id: <1464095714-48772-6-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1464095714-48772-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1464095714-48772-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_powersave_common does common steps needed before entering idle
state and eventually changes MSR to MSR_IDLE and does rfid to
pnv_enter_arch207_idle_mode.

Move the updation of HSTATE_HWTHREAD_STATE to pnv_powersave_common
from pnv_enter_arch207_idle_mode and make it more generic by passing
the rfid address as a function parameter.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
Changes in v4:
==============
 - Moved renaming of power7_powersave_common to earlier patch

Changes in v3:
==============
 - Moved HSTATE_HWTHREAD_STATE updation to power_powersave_common

 arch/powerpc/kernel/idle_power_common.S | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
index 34dbfc9..a8397e3 100644
--- a/arch/powerpc/kernel/idle_power_common.S
+++ b/arch/powerpc/kernel/idle_power_common.S
@@ -75,6 +75,8 @@ core_idle_lock_held:
  * To check IRQ_HAPPENED in r4
  * 	0 - don't check
  * 	1 - check
+ *
+ * Address to 'rfid' to in r5
  */
 _GLOBAL(pnv_powersave_common)
 	/* Use r3 to pass state nap/sleep/winkle */
@@ -127,28 +129,28 @@ _GLOBAL(pnv_powersave_common)
 	std	r9,_MSR(r1)
 	std	r1,PACAR1(r13)
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	/* Tell KVM we're entering idle */
+	li	r4,KVM_HWTHREAD_IN_NAP
+	stb	r4,HSTATE_HWTHREAD_STATE(r13)
+#endif
+
 	/*
 	 * Go to real mode to do the nap, as required by the architecture.
 	 * Also, we need to be in real mode before setting hwthread_state,
 	 * because as soon as we do that, another thread can switch
 	 * the MMU context to the guest.
 	 */
-	LOAD_REG_IMMEDIATE(r5, MSR_IDLE)
+	LOAD_REG_IMMEDIATE(r7, MSR_IDLE)
 	li	r6, MSR_RI
 	andc	r6, r9, r6
-	LOAD_REG_ADDR(r7, pnv_enter_arch207_idle_mode)
 	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
-	mtspr	SPRN_SRR0, r7
-	mtspr	SPRN_SRR1, r5
+	mtspr	SPRN_SRR0, r5
+	mtspr	SPRN_SRR1, r7
 	rfid
 
 	.globl pnv_enter_arch207_idle_mode
 pnv_enter_arch207_idle_mode:
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	/* Tell KVM we're napping */
-	li	r4,KVM_HWTHREAD_IN_NAP
-	stb	r4,HSTATE_HWTHREAD_STATE(r13)
-#endif
 	stb	r3,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi	cr3,r3,PNV_THREAD_SLEEP
 	bge	cr3,2f
@@ -243,18 +245,21 @@ _GLOBAL(power7_idle)
 _GLOBAL(power7_nap)
 	mr	r4,r3
 	li	r3,PNV_THREAD_NAP
+	LOAD_REG_ADDR(r5, pnv_enter_arch207_idle_mode)
 	b	pnv_powersave_common
 	/* No return */
 
 _GLOBAL(power7_sleep)
 	li	r3,PNV_THREAD_SLEEP
 	li	r4,1
+	LOAD_REG_ADDR(r5, pnv_enter_arch207_idle_mode)
 	b	pnv_powersave_common
 	/* No return */
 
 _GLOBAL(power7_winkle)
 	li	r3,PNV_THREAD_WINKLE
 	li	r4,1
+	LOAD_REG_ADDR(r5, pnv_enter_arch207_idle_mode)
 	b	pnv_powersave_common
 	/* No return */
 
-- 
2.4.11
