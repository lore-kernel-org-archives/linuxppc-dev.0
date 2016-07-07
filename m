Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlqSk0rKYzDr5F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 06:47:49 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u67KjGBJ047973
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:47:48 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xmtwjw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 16:47:48 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 14:47:47 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v7 06/11] powerpc/powernv: abstraction for saving SPRs before
 entering deep idle states
Date: Fri,  8 Jul 2016 02:17:07 +0530
In-Reply-To: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <1467924432-29003-7-git-send-email-shreyas@linux.vnet.ibm.com>
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
 - No changes since v3

Changes in v3:
=============
 - Newly added in v3

 arch/powerpc/kernel/idle_book3s.S | 54 +++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index a8397e3..2f909a1 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
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
