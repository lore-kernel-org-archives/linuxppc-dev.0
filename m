Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPvgj3PmxzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 02:55:13 +1000 (AEST)
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58GsWEe020942
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 12:55:11 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9mfdjx4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 12:55:10 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:55:05 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v6 05/11] powerpc/powernv: Make pnv_powersave_common more
 generic
Date: Wed,  8 Jun 2016 11:54:25 -0500
In-Reply-To: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <1465404871-5406-6-git-send-email-shreyas@linux.vnet.ibm.com>
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
from pnv_enter_arch207_idle_mode and make it more generic by passing the rfid
address as a function parameter.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 - No changes since v4

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
2.1.4
