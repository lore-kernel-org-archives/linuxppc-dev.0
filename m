Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DPYh4SzgzF20x
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 15:49:12 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id a15so7291159pgn.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 22:49:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v3 1/3] powerpc/64s/idle: POWER9 implement a separate idle
 stop function for hotplug
Date: Sun,  1 Apr 2018 15:48:53 +1000
Message-Id: <20180401054855.17864-2-npiggin@gmail.com>
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

Implement a new function to invoke stop, power9_offline_stop, which is
like power9_idle_stop but used by the cpu hotplug code.

Move KVM secondary state manipulation code to the offline case.

Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/processor.h  |  1 +
 arch/powerpc/kernel/idle_book3s.S     | 21 +++++++++++++++------
 arch/powerpc/platforms/powernv/idle.c |  2 +-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index bb9cb25ffb20..c4b36a494a63 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -518,6 +518,7 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern unsigned long power7_idle_insn(unsigned long type); /* PNV_THREAD_NAP/etc*/
 extern void power7_idle_type(unsigned long type);
 extern unsigned long power9_idle_stop(unsigned long psscr_val);
+extern unsigned long power9_offline_stop(unsigned long psscr_val);
 extern void power9_idle_type(unsigned long stop_psscr_val,
 			      unsigned long stop_psscr_mask);
 
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index d503203842b0..fc2e5cf2c74c 100644
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
@@ -428,7 +422,22 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 /*
  * Entered with MSR[EE]=0 and no soft-masked interrupts pending.
  * r3 contains desired PSSCR register value.
+ *
+ * Offline (CPU unplug) case also must notify KVM that the CPU is
+ * idle.
  */
+_GLOBAL(power9_offline_stop)
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	/*
+	 * Tell KVM we're entering idle.
+	 * This does not have to be done in real mode because the P9 MMU
+	 * is independent per-thread. Some steppings share radix/hash mode
+	 * between threads, but in that case KVM has a barrier sync in real
+	 * mode before and after switching between radix and hash.
+	 */
+	li	r4,KVM_HWTHREAD_IN_IDLE
+	stb	r4,HSTATE_HWTHREAD_STATE(r13)
+#endif
 _GLOBAL(power9_idle_stop)
 	std	r3, PACA_REQ_PSSCR(r13)
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index d9e366bb23da..378fde1f85a8 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -511,7 +511,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 		psscr = mfspr(SPRN_PSSCR);
 		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
 						pnv_deepest_stop_psscr_val;
-		srr1 = power9_idle_stop(psscr);
+		srr1 = power9_offline_stop(psscr);
 
 	} else if ((idle_states & OPAL_PM_WINKLE_ENABLED) &&
 		   (idle_states & OPAL_PM_LOSE_FULL_CONTEXT)) {
-- 
2.16.3
