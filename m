Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyR4Z3W0WzDqKD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 20:07:42 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0A944hD055079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 04:07:40 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27vvbxrtam-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 04:07:40 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 10 Jan 2017 02:07:38 -0700
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v5 2/5] powernv:stop: Uniformly rename power9 to arch300
Date: Tue, 10 Jan 2017 14:37:01 +0530
In-Reply-To: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1484039224-5630-3-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Balbir pointed out that in idle_book3s.S and powernv/idle.c some
functions and variables had power9 in their names while some others
had arch300.

This patch uniformly renames all instances of "power9" in the
variables/function/comments occuring in these files to "arch300" in
order to make them consistent.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
New patch in v5

 arch/powerpc/include/asm/processor.h  |  2 +-
 arch/powerpc/kernel/idle_book3s.S     | 13 +++++++------
 arch/powerpc/platforms/powernv/idle.c |  6 +++---
 arch/powerpc/platforms/powernv/smp.c  |  2 +-
 drivers/cpuidle/cpuidle-powernv.c     |  2 +-
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index c07c31b..4b47308 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -458,7 +458,7 @@ static inline unsigned long get_clean_sp(unsigned long sp, int is_32)
 extern unsigned long power7_nap(int check_irq);
 extern unsigned long power7_sleep(void);
 extern unsigned long power7_winkle(void);
-extern unsigned long power9_idle_stop(unsigned long stop_level);
+extern unsigned long arch300_idle_stop(unsigned long stop_level);
 
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index be90e2f..7f6657f 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -106,8 +106,9 @@ core_idle_lock_held:
 
 /*
  * Pass requested state in r3:
- *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE in POWER8
- *	   - Requested STOP state in POWER9
+ *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE on ISA 2.07 or less
+	     (POWER7,POWER8)
+ *	   - Requested STOP state on ISA 3.0 CPUs
  *
  * To check IRQ_HAPPENED in r4
  * 	0 - don't check
@@ -357,7 +358,7 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 /*
  * r3 - requested stop state
  */
-_GLOBAL(power9_idle_stop)
+_GLOBAL(arch300_idle_stop)
 	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE)
 	or	r4,r4,r3
 	mtspr	SPRN_PSSCR, r4
@@ -377,7 +378,7 @@ _GLOBAL(pnv_restore_hyp_resource)
 BEGIN_FTR_SECTION
 	ld	r2,PACATOC(r13);
 	/*
-	 * POWER ISA 3. Use PSSCR to determine if we
+	 * POWER ISA 3.0. Use PSSCR to determine if we
 	 * are waking up from deep idle state
 	 */
 	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
@@ -429,8 +430,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 /*
  * Called if waking up from idle state which can cause either partial or
  * complete hyp state loss.
- * In POWER8, called if waking up from fastsleep or winkle
- * In POWER9, called if waking up from stop state >= pnv_first_deep_stop_state
+ * In ISA 2.07 (POWER8),called if waking up from fastsleep or winkle
+ * In ISA 3.0, called if waking up from stop state >= pnv_first_deep_stop_state
  *
  * r13 - PACA
  * cr3 - gt if waking up with partial/complete hypervisor state loss
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 479c256..c3a2fac 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -241,10 +241,10 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
 /*
  * Used for ppc_md.power_save which needs a function with no parameters
  */
-static void power9_idle(void)
+static void arch300_idle(void)
 {
 	/* Requesting stop state 0 */
-	power9_idle_stop(0);
+	arch300_idle_stop(0);
 }
 /*
  * First deep stop state. Used to figure out when to save/restore
@@ -415,7 +415,7 @@ static int __init pnv_init_idle_states(void)
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
 		ppc_md.power_save = power7_idle;
 	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
-		ppc_md.power_save = power9_idle;
+		ppc_md.power_save = arch300_idle;
 
 out:
 	return 0;
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index c789258..c931bb2 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -183,7 +183,7 @@ static void pnv_smp_cpu_kill_self(void)
 		ppc64_runlatch_off();
 
 		if (cpu_has_feature(CPU_FTR_ARCH_300))
-			srr1 = power9_idle_stop(pnv_deepest_stop_state);
+			srr1 = arch300_idle_stop(pnv_deepest_stop_state);
 		else if (idle_states & OPAL_PM_WINKLE_ENABLED)
 			srr1 = power7_winkle();
 		else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 7fe442c..a7f6528 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -102,7 +102,7 @@ static int stop_loop(struct cpuidle_device *dev,
 		     int index)
 {
 	ppc64_runlatch_off();
-	power9_idle_stop(stop_psscr_table[index]);
+	arch300_idle_stop(stop_psscr_table[index]);
 	ppc64_runlatch_on();
 	return index;
 }
-- 
1.9.4
