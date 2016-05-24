Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDbWX3D6CzDqNg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 23:15:52 +1000 (AEST)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 24 May 2016 07:15:49 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v4 06/10] powerpc/powernv: abstraction for saving SPRs before
 entering deep idle states
Date: Tue, 24 May 2016 18:45:10 +0530
Message-Id: <1464095714-48772-7-git-send-email-shreyas@linux.vnet.ibm.com>
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

Create a function for saving SPRs before entering deep idle states.
This function can be reused for POWER9 deep idle states.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 - No changes in v4

Changes in v3:
=============
 - Newly added in v3

 arch/powerpc/kernel/idle_power_common.S | 54 +++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
index a8397e3..2f909a1 100644
--- a/arch/powerpc/kernel/idle_power_common.S
+++ b/arch/powerpc/kernel/idle_power_common.S
@@ -53,6 +53,36 @@
 	.text
 
 /*
+ * Used by threads before entering deep idle states. Saves SPRs
+ * in interrupt stack frame
+ */
+save_sprs_to_stack:
+	/*
+	 * Note all register i.e per-core, per-subcore or per-thread is saved
+	 * here since any thread in the core might wake up first
+	 */
+	mfspr	r3,SPRN_SDR1
+	std	r3,_SDR1(r1)
+	mfspr	r3,SPRN_RPR
+	std	r3,_RPR(r1)
+	mfspr	r3,SPRN_SPURR
+	std	r3,_SPURR(r1)
+	mfspr	r3,SPRN_PURR
+	std	r3,_PURR(r1)
+	mfspr	r3,SPRN_TSCR
+	std	r3,_TSCR(r1)
+	mfspr	r3,SPRN_DSCR
+	std	r3,_DSCR(r1)
+	mfspr	r3,SPRN_AMOR
+	std	r3,_AMOR(r1)
+	mfspr	r3,SPRN_WORT
+	std	r3,_WORT(r1)
+	mfspr	r3,SPRN_WORC
+	std	r3,_WORC(r1)
+
+	blr
+
+/*
  * Used by threads when the lock bit of core_idle_state is set.
  * Threads will spin in HMT_LOW until the lock bit is cleared.
  * r14 - pointer to core_idle_state
@@ -209,28 +239,8 @@ fastsleep_workaround_at_entry:
 	b	common_enter
 
 enter_winkle:
-	/*
-	 * Note all register i.e per-core, per-subcore or per-thread is saved
-	 * here since any thread in the core might wake up first
-	 */
-	mfspr	r3,SPRN_SDR1
-	std	r3,_SDR1(r1)
-	mfspr	r3,SPRN_RPR
-	std	r3,_RPR(r1)
-	mfspr	r3,SPRN_SPURR
-	std	r3,_SPURR(r1)
-	mfspr	r3,SPRN_PURR
-	std	r3,_PURR(r1)
-	mfspr	r3,SPRN_TSCR
-	std	r3,_TSCR(r1)
-	mfspr	r3,SPRN_DSCR
-	std	r3,_DSCR(r1)
-	mfspr	r3,SPRN_AMOR
-	std	r3,_AMOR(r1)
-	mfspr	r3,SPRN_WORT
-	std	r3,_WORT(r1)
-	mfspr	r3,SPRN_WORC
-	std	r3,_WORC(r1)
+	bl	save_sprs_to_stack
+
 	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
 
 _GLOBAL(power7_idle)
-- 
2.4.11
