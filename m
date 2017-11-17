Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydg2f23gCzDrSH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Nov 2017 01:08:58 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id a84so2044344pfl.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 06:08:58 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 1/3] powerpc/64s/idle: POWER9 implement a separate idle stop
 function for hotplug
Date: Sat, 18 Nov 2017 00:08:05 +1000
Message-Id: <20171117140807.22105-2-npiggin@gmail.com>
In-Reply-To: <20171117140807.22105-1-npiggin@gmail.com>
References: <20171117140807.22105-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement a new function to invoke stop, power9_offline_stop, which is
like power9_idle_stop but used by the cpu hotplug code.

Move KVM secondary state manipulation code to the offline case.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/processor.h  |  1 +
 arch/powerpc/kernel/idle_book3s.S     | 24 ++++++++++++++++++------
 arch/powerpc/platforms/powernv/idle.c |  2 +-
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index bdab3b74eb98..0ebdb58460ce 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -500,6 +500,7 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern unsigned long power7_idle_insn(unsigned long type); /* PNV_THREAD_NAP/etc*/
 extern void power7_idle_type(unsigned long type);
 extern unsigned long power9_idle_stop(unsigned long psscr_val);
+extern unsigned long power9_offline_stop(unsigned long psscr_val);
 extern void power9_idle_type(unsigned long stop_psscr_val,
 			      unsigned long stop_psscr_mask);
 
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 01e1c1997893..2f8364e7b489 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -325,12 +325,6 @@ enter_winkle:
  * r3 - PSSCR value corresponding to the requested stop state.
  */
 power_enter_stop:
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	/* Tell KVM we're entering idle */
-	li	r4,KVM_HWTHREAD_IN_IDLE
-	/* DO THIS IN REAL MODE!  See comment above. */
-	stb	r4,HSTATE_HWTHREAD_STATE(r13)
-#endif
 /*
  * Check if we are executing the lite variant with ESL=EC=0
  */
@@ -435,6 +429,24 @@ _GLOBAL(power9_idle_stop)
 	b	pnv_powersave_common
 	/* No return */
 
+/*
+ * Entered with MSR[EE]=0 and no soft-masked interrupts pending.
+ * r3 contains desired PSSCR register value.
+ */
+_GLOBAL(power9_offline_stop)
+	std	r3, PACA_REQ_PSSCR(r13)
+	mtspr 	SPRN_PSSCR,r3
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	/* Tell KVM we're entering idle */
+	li	r4,KVM_HWTHREAD_IN_IDLE
+	/* DO THIS IN REAL MODE!  See comment above. */
+	stb	r4,HSTATE_HWTHREAD_STATE(r13)
+#endif
+	LOAD_REG_ADDR(r4,power_enter_stop)
+	b	pnv_powersave_common
+	/* No return */
+
+
 /*
  * On waking up from stop 0,1,2 with ESL=1 on POWER9 DD1,
  * HSPRG0 will be set to the HSPRG0 value of one of the
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 443d5ca71995..a921d5428d76 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -434,7 +434,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 		psscr = mfspr(SPRN_PSSCR);
 		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
 						pnv_deepest_stop_psscr_val;
-		srr1 = power9_idle_stop(psscr);
+		srr1 = power9_offline_stop(psscr);
 
 	} else if ((idle_states & OPAL_PM_WINKLE_ENABLED) &&
 		   (idle_states & OPAL_PM_LOSE_FULL_CONTEXT)) {
-- 
2.15.0
