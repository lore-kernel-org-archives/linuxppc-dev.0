Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTW2K03XYzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:40:09 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id p13so3886116pfd.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 09:40:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 14/14] powerpc/64s: idle ESL=0 stop can avoid MSR and
 save/restore overhead
Date: Sat, 12 Aug 2017 02:39:12 +1000
Message-Id: <20170811163912.28783-15-npiggin@gmail.com>
In-Reply-To: <20170811163912.28783-1-npiggin@gmail.com>
References: <20170811163912.28783-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When stop is executed with EC=ESL=0, it appears to execute like a
normal instruction (resuming from NIP when woken by interrupt).
So all the save/restore handling can be avoided completely. In
particular NV GPRs do not have to be saved, and MSR does not have
to be switched back to kernel MSR.

So move the test for "lite" sleep states out to power9_idle_stop.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 40 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index fc5145339277..0d8dd9823bd3 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -264,31 +264,8 @@ enter_winkle:
 /*
  * r3 - PSSCR value corresponding to the requested stop state.
  */
-power_enter_stop:
-/*
- * Check if we are executing the lite variant with ESL=EC=0
- */
-	andis.   r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
+power_enter_stop_esl:
 	clrldi   r3,r3,60 /* r3 = Bits[60:63] = Requested Level (RL) */
-	bne	 .Lhandle_esl_ec_set
-	PPC_STOP
-	li	r3,0  /* Since we didn't lose state, return 0 */
-
-	/*
-	 * pnv_wakeup_noloss() expects r12 to contain the SRR1 value so
-	 * it can determine if the wakeup reason is an HMI in
-	 * CHECK_HMI_INTERRUPT.
-	 *
-	 * However, when we wakeup with ESL=0, SRR1 will not contain the wakeup
-	 * reason, so there is no point setting r12 to SRR1.
-	 *
-	 * Further, we clear r12 here, so that we don't accidentally enter the
-	 * HMI in pnv_wakeup_noloss() if the value of r12[42:45] == WAKE_HMI.
-	 */
-	li	r12, 0
-	b 	pnv_wakeup_noloss
-
-.Lhandle_esl_ec_set:
 	/*
 	 * POWER9 DD2 can incorrectly set PMAO when waking up after a
 	 * state-loss idle. Saving and restoring MMCR0 over idle is a
@@ -361,9 +338,20 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
  * r3 contains desired PSSCR register value.
  */
 _GLOBAL(power9_idle_stop)
-	std	r3, PACA_REQ_PSSCR(r13)
+	/*
+	 * Check if we are executing the lite variant with ESL=EC=0
+	 * This case resumes execution after the stop instruction without
+	 * losing any state, so nothing has to be saved.
+	 */
 	mtspr 	SPRN_PSSCR,r3
-	LOAD_REG_ADDR(r4,power_enter_stop)
+	andis.	r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
+	bne	1f
+	PPC_STOP
+	li	r3,0  /* Since we didn't lose state, return 0 */
+	blr
+1:	/* state-loss idle */
+	std	r3, PACA_REQ_PSSCR(r13)
+	LOAD_REG_ADDR(r4,power_enter_stop_esl)
 	b	pnv_powersave_common
 	/* No return */
 
-- 
2.13.3
