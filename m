Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKs46pCLzDrFq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:50:48 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 07:50:46 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 011161FF0050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:50:29 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3LDohd539256144
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 06:50:43 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3LDohmj003598
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:50:43 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 4/9] powerpc/powernv: Make power7_powersave_common more generic
Date: Thu, 21 Apr 2016 19:19:54 +0530
Message-Id: <1461246599-6098-5-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1461246599-6098-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1461246599-6098-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

power7_powersave_common does common steps needed before entering idle
state and eventually changes MSR to MSR_IDLE and does rfid to
power7_enter_nap_mode.

Make it more generic by passing the rfid address as a function parameter.
Also make function name more generic.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle_power7.S       | 11 +++++++----
 arch/powerpc/kernel/idle_power_common.S | 11 ++++++-----
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 594e1c5..1ea71d4 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -169,19 +169,22 @@ _GLOBAL(power7_idle)
 _GLOBAL(power7_nap)
 	mr	r4,r3
 	li	r3,PNV_THREAD_NAP
-	b	power7_powersave_common
+	LOAD_REG_ADDR(r5, power7_enter_nap_mode)
+	b	power_powersave_common
 	/* No return */
 
 _GLOBAL(power7_sleep)
 	li	r3,PNV_THREAD_SLEEP
 	li	r4,1
-	b	power7_powersave_common
+	LOAD_REG_ADDR(r5, power7_enter_nap_mode)
+	b	power_powersave_common
 	/* No return */
 
 _GLOBAL(power7_winkle)
-	li	r3,3
+	li	r3,PNV_THREAD_WINKLE
 	li	r4,1
-	b	power7_powersave_common
+	LOAD_REG_ADDR(r5, power7_enter_nap_mode)
+	b	power_powersave_common
 	/* No return */
 
 _GLOBAL(power7_wakeup_tb_loss)
diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
index 05954ae..ff7a541 100644
--- a/arch/powerpc/kernel/idle_power_common.S
+++ b/arch/powerpc/kernel/idle_power_common.S
@@ -21,8 +21,10 @@
  * To check IRQ_HAPPENED in r4
  * 	0 - don't check
  * 	1 - check
+ *
+ * Address to 'rfid' to in r5
  */
-_GLOBAL(power7_powersave_common)
+_GLOBAL(power_powersave_common)
 	/* Use r3 to pass state nap/sleep/winkle */
 	/* NAP is a state loss, we create a regs frame on the
 	 * stack, fill it up with the state we care about and
@@ -79,13 +81,12 @@ _GLOBAL(power7_powersave_common)
 	 * because as soon as we do that, another thread can switch
 	 * the MMU context to the guest.
 	 */
-	LOAD_REG_IMMEDIATE(r5, MSR_IDLE)
+	LOAD_REG_IMMEDIATE(r7, MSR_IDLE)
 	li	r6, MSR_RI
 	andc	r6, r9, r6
-	LOAD_REG_ADDR(r7, power7_enter_nap_mode)
 	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
-	mtspr	SPRN_SRR0, r7
-	mtspr	SPRN_SRR1, r5
+	mtspr	SPRN_SRR0, r5
+	mtspr	SPRN_SRR1, r7
 	rfid
 	/* No return */
 
-- 
2.1.4
