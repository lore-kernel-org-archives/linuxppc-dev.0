Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyR4c4PclzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 20:07:44 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0A944jL124759
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 04:07:43 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27vv7ah4gr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 04:07:42 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 10 Jan 2017 02:07:40 -0700
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
Subject: [PATCH v5 4/5] powernv: Pass PSSCR value and mask to power9_idle_stop
Date: Tue, 10 Jan 2017 14:37:03 +0530
In-Reply-To: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1484039224-5630-5-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

The arch300_idle_stop method currently takes only the requested stop
level as a parameter and picks up the rest of the PSSCR bits from a
hand-coded macro. This is not a very flexible design, especially when
the firmware has the capability to communicate the psscr value and the
mask associated with a particular stop state via device tree.

This patch modifies the power9_idle_stop API to take as parameters the
PSSCR value and the PSSCR mask corresponding to the stop state that
needs to be set. These PSSCR value and mask are respectively obtained
by parsing the "ibm,cpu-idle-state-psscr" and
"ibm,cpu-idle-state-psscr-mask" fields from the device tree.

In addition to this, the patch adds support for handling stop states
for which ESL and EC bits in the PSSCR are zero. As per the
architecture, a wakeup from these stop states resumes execution from
the subsequent instruction as opposed to waking up at the System
Vector.

The older firmware sets only the Requested Level (RL) field in the
psscr and psscr-mask exposed in the device tree. For older firmware
where psscr-mask=0xf, this patch will set the default sane values that
the set for for remaining PSSCR fields (i.e PSLL, MTL, ESL, EC, and
TR). For the new firmware, the patch will validate that the invariants
required by the ISA for the psscr values are maintained by the
firmware.

This skiboot patch that exports fully populated PSSCR values and the
mask for all the stop states can be found here:
https://lists.ozlabs.org/pipermail/skiboot/2016-September/004869.html

[Optimize the number of instructions before entering STOP with
ESL=EC=0, validate the PSSCR values provided by the firimware
maintains the invariants required as per the ISA suggested by Balbir
Singh]

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
[v4] -> [v5]: a) Validate the psscr values provided by firmware.
              b) Optimize the number of instructions before entering
	         stop with ESL=EC=0.

arch/powerpc/include/asm/cpuidle.h       |  44 ++++++++++
 arch/powerpc/include/asm/processor.h     |   3 +-
 arch/powerpc/kernel/idle_book3s.S        |  30 ++++---
 arch/powerpc/platforms/powernv/idle.c    | 138 ++++++++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/powernv.h |   3 +-
 arch/powerpc/platforms/powernv/smp.c     |  14 ++--
 drivers/cpuidle/cpuidle-powernv.c        |  52 +++++++++---
 7 files changed, 241 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 0a3255b..ced47ee 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -10,11 +10,55 @@
 #define PNV_CORE_IDLE_LOCK_BIT          0x100
 #define PNV_CORE_IDLE_THREAD_BITS       0x0FF
 
+/*
+ * ============================ NOTE =================================
+ * The older firmware populates only the RL field in the psscr_val and
+ * sets the psscr_mask to 0xf. On such a firmware, the kernel sets the
+ * remaining PSSCR fields to default values as follows:
+ *
+ * - ESL and EC bits are to 1. So wakeup from any stop state will be
+ *   at vector 0x100.
+ *
+ * - MTL and PSLL are set to the maximum allowed value as per the ISA,
+ *    i.e. 15.
+ *
+ * - The Transition Rate, TR is set to the Maximum value 3.
+ */
+#define PSSCR_HV_DEFAULT_VAL    (PSSCR_ESL | PSSCR_EC |		    \
+				PSSCR_PSLL_MASK | PSSCR_TR_MASK |   \
+				PSSCR_MTL_MASK)
+
+#define PSSCR_HV_DEFAULT_MASK   (PSSCR_ESL | PSSCR_EC |		    \
+				PSSCR_PSLL_MASK | PSSCR_TR_MASK |   \
+				PSSCR_MTL_MASK | PSSCR_RL_MASK)
+#define PSSCR_EC_SHIFT    20
+#define PSSCR_ESL_SHIFT   21
+#define GET_PSSCR_EC(x)   (((x) & PSSCR_EC) >> PSSCR_EC_SHIFT)
+#define GET_PSSCR_ESL(x)  (((x) & PSSCR_ESL) >> PSSCR_ESL_SHIFT)
+#define GET_PSSCR_RL(x)   ((x) & PSSCR_RL_MASK)
+
+#define ERR_EC_ESL_MISMATCH		-1
+#define ERR_DEEP_STATE_ESL_MISMATCH	-2
+
 #ifndef __ASSEMBLY__
 extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
 
 extern u64 pnv_first_deep_stop_state;
+
+int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags);
+static inline void report_invalid_psscr_val(u64 psscr_val, int err)
+{
+	switch (err) {
+	case ERR_EC_ESL_MISMATCH:
+		pr_warn("Invalid psscr %llx : ESL,EC bits unequal",
+			psscr_val);
+		break;
+	case ERR_DEEP_STATE_ESL_MISMATCH:
+		pr_warn("Invalid psscr %llx : ESL cleared for deep stop-state",
+			psscr_val);
+	}
+}
 #endif
 
 #endif
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 4b47308..da68890 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -458,7 +458,8 @@ static inline unsigned long get_clean_sp(unsigned long sp, int is_32)
 extern unsigned long power7_nap(int check_irq);
 extern unsigned long power7_sleep(void);
 extern unsigned long power7_winkle(void);
-extern unsigned long arch300_idle_stop(unsigned long stop_level);
+extern unsigned long arch300_idle_stop(unsigned long stop_psscr_val,
+				      unsigned long stop_psscr_mask);
 
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 7f6657f..61965ab 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -40,9 +40,7 @@
 #define _WORC	GPR11
 #define _PTCR	GPR12
 
-#define PSSCR_HV_TEMPLATE	PSSCR_ESL | PSSCR_EC | \
-				PSSCR_PSLL_MASK | PSSCR_TR_MASK | \
-				PSSCR_MTL_MASK
+#define PSSCR_EC_ESL_MASK_SHIFTED          (PSSCR_EC | PSSCR_ESL) >> 16
 
 	.text
 
@@ -265,7 +263,7 @@ enter_winkle:
 	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
 
 /*
- * r3 - requested stop state
+ * r3 - PSSCR value corresponding to the requested stop state.
  */
 power_enter_stop:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -275,9 +273,18 @@ power_enter_stop:
 	stb	r4,HSTATE_HWTHREAD_STATE(r13)
 #endif
 /*
+ * Check if we are executing the lite variant with ESL=EC=0
+ */
+	andis.   r4, r3, PSSCR_EC_ESL_MASK_SHIFTED
+	clrldi   r3, r3, 60 /* r3 = Bits 60:63 = Requested Level (RL) */
+	bne	 1f
+	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+	li	r3,0  /* Since we didn't lose state, return 0 */
+	b 	pnv_wakeup_noloss
+/*
  * Check if the requested state is a deep idle state.
  */
-	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
+1:	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 	cmpd	r3,r4
 	bge	2f
@@ -354,16 +361,17 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
 20:	nop;
 
-
 /*
- * r3 - requested stop state
+ * r3 - The PSSCR value corresponding to the stop state.
+ * r4 - The PSSCR mask corrresonding to the stop state.
  */
 _GLOBAL(arch300_idle_stop)
-	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE)
-	or	r4,r4,r3
-	mtspr	SPRN_PSSCR, r4
-	li	r4, 1
+	mfspr   r5, SPRN_PSSCR
+	andc    r5, r5, r4
+	or      r3, r3, r5
+	mtspr 	SPRN_PSSCR, r3
 	LOAD_REG_ADDR(r5,power_enter_stop)
+	li	r4, 1
 	b	pnv_powersave_common
 	/* No return */
 /*
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index c3a2fac..7a6ff4a 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -237,15 +237,21 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
 			show_fastsleep_workaround_applyonce,
 			store_fastsleep_workaround_applyonce);
 
+/*
+ * The default stop state that will be used by ppc_md.power_save
+ * function on platforms that support stop instruction.
+ */
+u64 pnv_default_stop_val;
+u64 pnv_default_stop_mask;
 
 /*
  * Used for ppc_md.power_save which needs a function with no parameters
  */
 static void arch300_idle(void)
 {
-	/* Requesting stop state 0 */
-	arch300_idle_stop(0);
+	arch300_idle_stop(pnv_default_stop_val, pnv_default_stop_mask);
 }
+
 /*
  * First deep stop state. Used to figure out when to save/restore
  * hypervisor context.
@@ -253,9 +259,11 @@ static void arch300_idle(void)
 u64 pnv_first_deep_stop_state = MAX_STOP_STATE;
 
 /*
- * Deepest stop idle state. Used when a cpu is offlined
+ * psscr value and mask of the deepest stop idle state.
+ * Used when a cpu is offlined.
  */
-u64 pnv_deepest_stop_state;
+u64 pnv_deepest_stop_psscr_val;
+u64 pnv_deepest_stop_psscr_mask;
 
 /*
  * Power ISA 3.0 idle initialization.
@@ -292,6 +300,44 @@ static void arch300_idle(void)
  *	Bits 60:63 - Requested Level
  *	Used to specify which power-saving level must be entered on executing
  *	stop instruction
+ */
+
+int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
+{
+	int err = 0;
+
+	/*
+	 * psscr_mask == 0xf indicates an older firmware.
+	 * Set remaining fields of psscr to the default values.
+	 * See NOTE above definition of PSSCR_HV_DEFAULT_VAL
+	 */
+	if (*psscr_mask == 0xf) {
+		*psscr_val = *psscr_val | PSSCR_HV_DEFAULT_VAL;
+		*psscr_mask = PSSCR_HV_DEFAULT_MASK;
+		return err;
+	}
+
+	/*
+	 * New firmware is expected to set the psscr_val bits correctly.
+	 * Validate that the following invariants are correctly maintained by
+	 * the new firmware.
+	 * - ESL bit value matches the EC bit value.
+	 * - ESL bit is set for all the deep stop states.
+	 */
+	if (GET_PSSCR_ESL(*psscr_val) != GET_PSSCR_EC(*psscr_val)) {
+		err = ERR_EC_ESL_MISMATCH;
+	} else if ((flags & OPAL_PM_LOSE_FULL_CONTEXT) &&
+		GET_PSSCR_ESL(*psscr_val) == 0) {
+		err = ERR_DEEP_STATE_ESL_MISMATCH;
+	}
+
+	return err;
+}
+
+/*
+ * pnv_arch300_idle_init: Initializes the default idle state, first
+ *                        deep idle state and deepest idle state on
+ *                        ISA 3.0 CPUs.
  *
  * @np: /ibm,opal/power-mgt device node
  * @flags: cpu-idle-state-flags array
@@ -302,43 +348,109 @@ static int __init pnv_arch300_idle_init(struct device_node *np, u32 *flags,
 					int dt_idle_states)
 {
 	u64 *psscr_val = NULL;
+	u64 *psscr_mask = NULL;
+	u32 *residency_ns = NULL;
+	u64 max_residency_ns = 0;
 	int rc = 0, i;
+	bool default_stop_found = false, deepest_stop_found = false;
 
-	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
-				GFP_KERNEL);
-	if (!psscr_val) {
+	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
+	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
+	residency_ns = kcalloc(dt_idle_states, sizeof(*residency_ns),
+			       GFP_KERNEL);
+
+	if (!psscr_val || !psscr_mask || !residency_ns) {
 		rc = -1;
 		goto out;
 	}
+
 	if (of_property_read_u64_array(np,
 		"ibm,cpu-idle-state-psscr",
 		psscr_val, dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
+		rc = -1;
+		goto out;
+	}
+
+	if (of_property_read_u64_array(np,
+				       "ibm,cpu-idle-state-psscr-mask",
+				       psscr_mask, dt_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr-mask in DT\n");
+		rc = -1;
+		goto out;
+	}
+
+	if (of_property_read_u32_array(np,
+				       "ibm,cpu-idle-state-residency-ns",
+					residency_ns, dt_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-residency-ns in DT\n");
 		rc = -1;
 		goto out;
 	}
 
 	/*
-	 * Set pnv_first_deep_stop_state and pnv_deepest_stop_state.
+	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
+	 * and the pnv_default_stop_{val,mask}.
+	 *
 	 * pnv_first_deep_stop_state should be set to the first stop
 	 * level to cause hypervisor state loss.
-	 * pnv_deepest_stop_state should be set to the deepest stop
-	 * stop state.
+	 *
+	 * pnv_deepest_stop_{val,mask} should be set to values corresponding to
+	 * the deepest stop state.
+	 *
+	 * pnv_default_stop_{val,mask} should be set to values corresponding to
+	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
 	 */
 	pnv_first_deep_stop_state = MAX_STOP_STATE;
 	for (i = 0; i < dt_idle_states; i++) {
+		int err;
 		u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
 
 		if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
 		     (pnv_first_deep_stop_state > psscr_rl))
 			pnv_first_deep_stop_state = psscr_rl;
 
-		if (pnv_deepest_stop_state < psscr_rl)
-			pnv_deepest_stop_state = psscr_rl;
+		err = validate_psscr_val_mask(&psscr_val[i], &psscr_mask[i],
+					      flags[i]);
+		if (err) {
+			report_invalid_psscr_val(psscr_val[i], err);
+			continue;
+		}
+
+		if (max_residency_ns < residency_ns[i]) {
+			max_residency_ns = residency_ns[i];
+			pnv_deepest_stop_psscr_val = psscr_val[i];
+			pnv_deepest_stop_psscr_mask = psscr_mask[i];
+			deepest_stop_found = true;
+		}
+
+		if (!default_stop_found &&
+		    (flags[i] & OPAL_PM_STOP_INST_FAST)) {
+			pnv_default_stop_val = psscr_val[i];
+			pnv_default_stop_mask = psscr_mask[i];
+			default_stop_found = true;
+		}
+	}
+
+	if (!default_stop_found) {
+		pnv_default_stop_val = PSSCR_HV_DEFAULT_VAL;
+		pnv_default_stop_mask = PSSCR_HV_DEFAULT_MASK;
+		pr_warn("Setting default stop psscr val=%llx,mask=%llx\n",
+			pnv_default_stop_val, pnv_default_stop_mask);
+	}
+
+	if (!deepest_stop_found) {
+		pnv_deepest_stop_psscr_val = PSSCR_HV_DEFAULT_VAL;
+		pnv_deepest_stop_psscr_mask = PSSCR_HV_DEFAULT_MASK;
+		pr_warn("Setting default stop psscr val=%llx,mask=%llx\n",
+			pnv_deepest_stop_psscr_val,
+			pnv_deepest_stop_psscr_mask);
 	}
 
 out:
 	kfree(psscr_val);
+	kfree(psscr_mask);
+	kfree(residency_ns);
 	return rc;
 }
 
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index da7c843..6130522 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -18,7 +18,8 @@ static inline void pnv_pci_shutdown(void) { }
 #endif
 
 extern u32 pnv_get_supported_cpuidle_states(void);
-extern u64 pnv_deepest_stop_state;
+extern u64 pnv_deepest_stop_psscr_val;
+extern u64 pnv_deepest_stop_psscr_mask;
 
 extern void pnv_lpc_init(void);
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index c931bb2..408695f 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -182,15 +182,17 @@ static void pnv_smp_cpu_kill_self(void)
 
 		ppc64_runlatch_off();
 
-		if (cpu_has_feature(CPU_FTR_ARCH_300))
-			srr1 = arch300_idle_stop(pnv_deepest_stop_state);
-		else if (idle_states & OPAL_PM_WINKLE_ENABLED)
+		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+			srr1 = arch300_idle_stop(pnv_deepest_stop_psscr_val,
+						pnv_deepest_stop_psscr_mask);
+		} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
 			srr1 = power7_winkle();
-		else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
-				(idle_states & OPAL_PM_SLEEP_ENABLED_ER1))
+		} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
+			   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
 			srr1 = power7_sleep();
-		else
+		} else {
 			srr1 = power7_nap(1);
+		}
 
 		ppc64_runlatch_on();
 
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index a21f1f0..bbadd91 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -19,6 +19,7 @@
 #include <asm/firmware.h>
 #include <asm/opal.h>
 #include <asm/runlatch.h>
+#include <asm/cpuidle.h>
 
 /*
  * Expose only those Hardware idle states via the cpuidle framework
@@ -34,7 +35,12 @@ struct cpuidle_driver powernv_idle_driver = {
 static int max_idle_state;
 static struct cpuidle_state *cpuidle_state_table;
 
-static u64 stop_psscr_table[CPUIDLE_STATE_MAX];
+struct stop_psscr_table {
+	u64 val;
+	u64 mask;
+};
+
+static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX];
 
 static u64 snooze_timeout;
 static bool snooze_timeout_en;
@@ -106,7 +112,8 @@ static int stop_loop(struct cpuidle_device *dev,
 		     int index)
 {
 	ppc64_runlatch_off();
-	arch300_idle_stop(stop_psscr_table[index]);
+	arch300_idle_stop(stop_psscr_table[index].val,
+			 stop_psscr_table[index].mask);
 	ppc64_runlatch_on();
 	return index;
 }
@@ -178,7 +185,7 @@ static inline void add_powernv_state(int index, const char *name,
 						    int),
 				     unsigned int target_residency,
 				     unsigned int exit_latency,
-				     u64 psscr_val)
+				     u64 psscr_val, u64 psscr_mask)
 {
 	strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
 	strlcpy(powernv_states[index].desc, name, CPUIDLE_NAME_LEN);
@@ -186,7 +193,8 @@ static inline void add_powernv_state(int index, const char *name,
 	powernv_states[index].target_residency = target_residency;
 	powernv_states[index].exit_latency = exit_latency;
 	powernv_states[index].enter = idle_fn;
-	stop_psscr_table[index] = psscr_val;
+	stop_psscr_table[index].val = psscr_val;
+	stop_psscr_table[index].mask = psscr_mask;
 }
 
 static int powernv_add_idle_states(void)
@@ -198,7 +206,9 @@ static int powernv_add_idle_states(void)
 	u32 residency_ns[CPUIDLE_STATE_MAX];
 	u32 flags[CPUIDLE_STATE_MAX];
 	u64 psscr_val[CPUIDLE_STATE_MAX];
+	u64 psscr_mask[CPUIDLE_STATE_MAX];
 	const char *names[CPUIDLE_STATE_MAX];
+	bool has_stop_states = false;
 	int i, rc;
 
 	/* Currently we have snooze statically defined */
@@ -245,15 +255,25 @@ static int powernv_add_idle_states(void)
 
 	/*
 	 * If the idle states use stop instruction, probe for psscr values
-	 * which are necessary to specify required stop level.
+	 * and psscr mask which are necessary to specify required stop level.
 	 */
-	if (flags[0] & (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP))
+	if (flags[0] & (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP)) {
 		if (of_property_read_u64_array(power_mgt,
 		    "ibm,cpu-idle-state-psscr", psscr_val, dt_idle_states)) {
-			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
+			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
+			goto out;
+		}
+
+		if (of_property_read_u64_array(power_mgt,
+					       "ibm,cpu-idle-state-psscr-mask",
+						psscr_mask, dt_idle_states)) {
+			pr_warn("cpuidle-powernv:Missing ibm,cpu-idle-state-psscr-mask in DT\n");
 			goto out;
 		}
 
+		has_stop_states = true;
+	}
+
 	rc = of_property_read_u32_array(power_mgt,
 		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
 
@@ -276,6 +296,16 @@ static int powernv_add_idle_states(void)
 		else
 			target_residency = 0;
 
+		if (has_stop_states) {
+			int err = validate_psscr_val_mask(&psscr_val[i],
+							  &psscr_mask[i],
+							  flags[i]);
+			if (err) {
+				report_invalid_psscr_val(psscr_val[i], err);
+				continue;
+			}
+		}
+
 		/*
 		 * For nap and fastsleep, use default target_residency
 		 * values if f/w does not expose it.
@@ -286,13 +316,13 @@ static int powernv_add_idle_states(void)
 			/* Add NAP state */
 			add_powernv_state(nr_idle_states, "Nap",
 					  CPUIDLE_FLAG_NONE, nap_loop,
-					  target_residency, exit_latency, 0);
+					  target_residency, exit_latency, 0, 0);
 		} else if ((flags[i] & OPAL_PM_STOP_INST_FAST) &&
 				!(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
 			add_powernv_state(nr_idle_states, names[i],
 					  CPUIDLE_FLAG_NONE, stop_loop,
 					  target_residency, exit_latency,
-					  psscr_val[i]);
+					  psscr_val[i], psscr_mask[i]);
 		}
 
 		/*
@@ -308,13 +338,13 @@ static int powernv_add_idle_states(void)
 			add_powernv_state(nr_idle_states, "FastSleep",
 					  CPUIDLE_FLAG_TIMER_STOP,
 					  fastsleep_loop,
-					  target_residency, exit_latency, 0);
+					  target_residency, exit_latency, 0, 0);
 		} else if ((flags[i] & OPAL_PM_STOP_INST_DEEP) &&
 				(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
 			add_powernv_state(nr_idle_states, names[i],
 					  CPUIDLE_FLAG_TIMER_STOP, stop_loop,
 					  target_residency, exit_latency,
-					  psscr_val[i]);
+					  psscr_val[i], psscr_mask[i]);
 		}
 #endif
 		nr_idle_states++;
-- 
1.9.4
