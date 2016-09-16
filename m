Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb9Sm6W0jzDsZc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 19:48:08 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8G9hetI076868
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 05:48:06 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25ftr8c9mk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 05:48:06 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 16 Sep 2016 03:48:05 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powernv:idle:Implement lite variant of power_enter_stop
Date: Fri, 16 Sep 2016 15:17:42 +0530
In-Reply-To: <cover.1474015799.git.ego@linux.vnet.ibm.com>
References: <cover.1474015799.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1474015799.git.ego@linux.vnet.ibm.com>
References: <cover.1474015799.git.ego@linux.vnet.ibm.com>
Message-Id: <86d28da16d5bf66f111cc93eea3f000e41faff57.1474015799.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

This patch adds a function named power_enter_stop_lite() that can
execute a stop instruction when ESL and EC bits are set to zero in the
PSSCR.  The function handles the wake-up from idle at the instruction
immediately after the stop instruction.

If the flag OPAL_PM_WAKEUP_AT_NEXT_INST[1] is set in the device tree
for a stop state, then use the lite variant for that particular stop
state.

[1] : The corresponding patch in skiboot that defines
      OPAL_PM_WAKEUP_AT_NEXT_INST and enables it in the device tree
      can be found here:
      https://lists.ozlabs.org/pipermail/skiboot/2016-September/004805.html

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h   |  1 +
 arch/powerpc/include/asm/processor.h  |  3 ++-
 arch/powerpc/kernel/idle_book3s.S     | 28 +++++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/idle.c | 17 ++++++++++++++---
 arch/powerpc/platforms/powernv/smp.c  |  2 +-
 drivers/cpuidle/cpuidle-powernv.c     | 24 ++++++++++++++++++++++--
 6 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0e2e57b..6e5741e 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -179,6 +179,7 @@
 #define OPAL_PM_TIMEBASE_STOP		0x00000002
 #define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000
 #define OPAL_PM_LOSE_FULL_CONTEXT	0x00004000
+#define OPAL_PM_WAKEUP_AT_NEXT_INST	0x00008000
 #define OPAL_PM_NAP_ENABLED		0x00010000
 #define OPAL_PM_SLEEP_ENABLED		0x00020000
 #define OPAL_PM_WINKLE_ENABLED		0x00040000
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 68e3bf5..e0549a0 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -460,7 +460,8 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern unsigned long power7_nap(int check_irq);
 extern unsigned long power7_sleep(void);
 extern unsigned long power7_winkle(void);
-extern unsigned long power9_idle_stop(unsigned long stop_level);
+extern unsigned long power9_idle_stop(unsigned long stop_level,
+				unsigned long exec_lite);
 
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 32d666b..47ee106 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -43,6 +43,8 @@
 #define PSSCR_HV_TEMPLATE	PSSCR_ESL | PSSCR_EC | \
 				PSSCR_PSLL_MASK | PSSCR_TR_MASK | \
 				PSSCR_MTL_MASK
+#define PSSCR_HV_TEMPLATE_LITE	PSSCR_PSLL_MASK | PSSCR_TR_MASK | \
+				 PSSCR_MTL_MASK
 
 	.text
 
@@ -246,6 +248,20 @@ enter_winkle:
 
 	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
 
+
+/*
+ * power_enter_stop_lite : This will resume the wake up from
+ * idle at the subsequent instruction.
+ *
+ * Caller should set ESL=EC=0 in PSSCR before calling
+ * this function.
+ *
+ */
+power_enter_stop_lite:
+	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+7:	li	r3,0  /* Since we didn't lose state, return 0 */
+	b 	pnv_wakeup_noloss
+
 /*
  * r3 - requested stop state
  */
@@ -333,13 +349,19 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 
 /*
  * r3 - requested stop state
+ * r4 - Indicates if the lite variant with ESL=EC=0 should be executed.
  */
 _GLOBAL(power9_idle_stop)
-	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE)
-	or	r4,r4,r3
+	cmpdi	r4, 1
+	bne	4f
+	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE_LITE)
+	LOAD_REG_ADDR(r5,power_enter_stop_lite)
+	b 	5f
+4:	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE)
+	LOAD_REG_ADDR(r5,power_enter_stop)
+5:	or	r4,r4,r3
 	mtspr	SPRN_PSSCR, r4
 	li	r4, 1
-	LOAD_REG_ADDR(r5,power_enter_stop)
 	b	pnv_powersave_common
 	/* No return */
 /*
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 479c256..c3d3fed 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -244,8 +244,15 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
 static void power9_idle(void)
 {
 	/* Requesting stop state 0 */
-	power9_idle_stop(0);
+	power9_idle_stop(0, 0);
 }
+
+static void power9_idle_lite(void)
+{
+	/* Requesting stop state 0 with ESL=EC=0 */
+	power9_idle_stop(0, 1);
+}
+
 /*
  * First deep stop state. Used to figure out when to save/restore
  * hypervisor context.
@@ -414,8 +421,12 @@ static int __init pnv_init_idle_states(void)
 
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
 		ppc_md.power_save = power7_idle;
-	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
-		ppc_md.power_save = power9_idle;
+	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST) {
+		if (supported_cpuidle_states & OPAL_PM_WAKEUP_AT_NEXT_INST)
+			ppc_md.power_save = power9_idle_lite;
+		else
+			ppc_md.power_save = power9_idle;
+	}
 
 out:
 	return 0;
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index c789258..6587b96 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -183,7 +183,7 @@ static void pnv_smp_cpu_kill_self(void)
 		ppc64_runlatch_off();
 
 		if (cpu_has_feature(CPU_FTR_ARCH_300))
-			srr1 = power9_idle_stop(pnv_deepest_stop_state);
+			srr1 = power9_idle_stop(pnv_deepest_stop_state, 0);
 		else if (idle_states & OPAL_PM_WINKLE_ENABLED)
 			srr1 = power7_winkle();
 		else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index f7ca891..7021ddf 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -102,7 +102,21 @@ static int stop_loop(struct cpuidle_device *dev,
 		     int index)
 {
 	ppc64_runlatch_off();
-	power9_idle_stop(stop_psscr_table[index]);
+	power9_idle_stop(stop_psscr_table[index], 0);
+	ppc64_runlatch_on();
+	return index;
+}
+
+/*
+ * This function calls stop instruction with
+ * ESL and EC bits set to 0.
+ */
+static int stop_lite_loop(struct cpuidle_device *dev,
+		     struct cpuidle_driver *drv,
+		     int index)
+{
+	ppc64_runlatch_off();
+	power9_idle_stop(stop_psscr_table[index], 1);
 	ppc64_runlatch_on();
 	return index;
 }
@@ -273,7 +287,13 @@ static int powernv_add_idle_states(void)
 				names[i], CPUIDLE_NAME_LEN);
 			powernv_states[nr_idle_states].flags = 0;
 
-			powernv_states[nr_idle_states].enter = stop_loop;
+			if (flags[i] & OPAL_PM_WAKEUP_AT_NEXT_INST) {
+				powernv_states[nr_idle_states].enter =
+					stop_lite_loop;
+			} else {
+				powernv_states[nr_idle_states].enter =
+					stop_loop;
+			}
 			stop_psscr_table[nr_idle_states] = psscr_val[i];
 		}
 
-- 
1.9.4
