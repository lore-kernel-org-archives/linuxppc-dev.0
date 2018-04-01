Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DPYq2yDqzF21H
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 15:49:19 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id j3so7295315pgf.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 22:49:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v3 3/3] powerpc/64s/idle: POWER9 ESL=0 stop avoid save/restore
 overhead
Date: Sun,  1 Apr 2018 15:48:55 +1000
Message-Id: <20180401054855.17864-4-npiggin@gmail.com>
In-Reply-To: <20180401054855.17864-1-npiggin@gmail.com>
References: <20180401054855.17864-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When stop is executed with EC=ESL=0, it appears to execute like a
normal instruction (resuming from NIP when woken by interrupt). So all
the save/restore handling can be avoided completely. In particular NV
GPRs do not have to be saved, and MSR does not have to be switched
back to kernel MSR.

So move the test for EC=ESL=0 sleep states out to power9_idle_stop,
and return directly to the caller after stop in that case.

This improves performance for ping-pong benchmark with the stop0_lite
idle state by 2.54% for 2 threads in the same core, and 2.57% for
different cores. Performance increase with HV_POSSIBLE defined will be
improved further by avoiding the hwsync.

Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 45 ++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 68fa97885fc0..dedcd78a204a 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -324,32 +324,8 @@ enter_winkle:
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
-	std	r3, PACA_REQ_PSSCR(r13)
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
 BEGIN_FTR_SECTION
 	/*
 	 * POWER9 DD2.0 or earlier can incorrectly set PMAO when waking up after
@@ -439,21 +415,32 @@ _GLOBAL(power9_offline_stop)
 	stb	r4,HSTATE_HWTHREAD_STATE(r13)
 #endif
 _GLOBAL(power9_idle_stop)
+	mtspr 	SPRN_PSSCR,r3
+	/*
+	 * The ESL=EC=0 case does not wake up at 0x100, and it does not
+	 * allow SMT mode switching, so it does not require PSSCR to be
+	 * saved.
+	 */
+	andis.	r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
+	bne	1f
+	PPC_STOP
+	li	r3,0  /* Since we didn't lose state, return 0 */
+	blr
+1:
 	std	r3, PACA_REQ_PSSCR(r13)
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 BEGIN_FTR_SECTION
 	sync
 	lwz	r5, PACA_DONT_STOP(r13)
 	cmpwi	r5, 0
-	bne	1f
+	bne	2f
 END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_XER_SO_BUG)
 #endif
-	mtspr 	SPRN_PSSCR,r3
-	LOAD_REG_ADDR(r4,power_enter_stop)
+	LOAD_REG_ADDR(r4,power_enter_stop_esl)
 	b	pnv_powersave_common
 	/* No return */
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-1:
+2:
 	/*
 	 * We get here when TM / thread reconfiguration bug workaround
 	 * code wants to get the CPU into SMT4 mode, and therefore
-- 
2.16.3
