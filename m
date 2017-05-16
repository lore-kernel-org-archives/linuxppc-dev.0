Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRrkB4pT8zDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 18:50:10 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G8moue039546
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:50:01 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2afvpgm7qj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:50:01 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 16 May 2017 02:50:00 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 4/6] powernv:idle: Restore SPRs for deep idle states via stop
 API.
Date: Tue, 16 May 2017 14:19:46 +0530
In-Reply-To: <cover.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
Message-Id: <f17d276f44899f8d88023b3b8503f34dc57bf205.1494585671.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

Some of the SPR values (HID0, MSR, SPRG0) don't change during the run
time of a booted kernel, once they have been initialized.

The contents of these SPRs are lost when the CPUs enter deep stop
states. So instead saving and restoring SPRs from the kernel, use the
stop-api provided by the firmware by which the firmware can restore
the contents of these SPRs to their initialized values after wakeup
from a deep stop state.

Apart from these, program the PSSCR value to that of the deepest stop
state via the stop-api. This will be used to indicate to the
underlying firmware as to what stop state to put the threads that have
been woken up by a special-wakeup.

And while we are at programming SPRs via stop-api, ensure that HID1,
HID4 and HID5 registers which are only available on POWER8 are not
requested to be restored by the firware on POWER9.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 83 ++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 84eb9bc..4deac0d 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -30,8 +30,33 @@
 /* Power ISA 3.0 allows for stop states 0x0 - 0xF */
 #define MAX_STOP_STATE	0xF
 
+#define P9_STOP_SPR_MSR 2000
+#define P9_STOP_SPR_PSSCR      855
+
 static u32 supported_cpuidle_states;
 
+/*
+ * The default stop state that will be used by ppc_md.power_save
+ * function on platforms that support stop instruction.
+ */
+static u64 pnv_default_stop_val;
+static u64 pnv_default_stop_mask;
+static bool default_stop_found;
+
+/*
+ * First deep stop state. Used to figure out when to save/restore
+ * hypervisor context.
+ */
+u64 pnv_first_deep_stop_state = MAX_STOP_STATE;
+
+/*
+ * psscr value and mask of the deepest stop idle state.
+ * Used when a cpu is offlined.
+ */
+static u64 pnv_deepest_stop_psscr_val;
+static u64 pnv_deepest_stop_psscr_mask;
+static bool deepest_stop_found;
+
 static int pnv_save_sprs_for_deep_states(void)
 {
 	int cpu;
@@ -48,6 +73,8 @@ static int pnv_save_sprs_for_deep_states(void)
 	uint64_t hid4_val = mfspr(SPRN_HID4);
 	uint64_t hid5_val = mfspr(SPRN_HID5);
 	uint64_t hmeer_val = mfspr(SPRN_HMEER);
+	uint64_t msr_val = MSR_IDLE;
+	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
 
 	for_each_possible_cpu(cpu) {
 		uint64_t pir = get_hard_smp_processor_id(cpu);
@@ -61,6 +88,18 @@ static int pnv_save_sprs_for_deep_states(void)
 		if (rc != 0)
 			return rc;
 
+		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+			rc = opal_slw_set_reg(pir, P9_STOP_SPR_MSR, msr_val);
+			if (rc)
+				return rc;
+
+			rc = opal_slw_set_reg(pir,
+					      P9_STOP_SPR_PSSCR, psscr_val);
+
+			if (rc)
+				return rc;
+		}
+
 		/* HIDs are per core registers */
 		if (cpu_thread_in_core(cpu) == 0) {
 
@@ -72,17 +111,21 @@ static int pnv_save_sprs_for_deep_states(void)
 			if (rc != 0)
 				return rc;
 
-			rc = opal_slw_set_reg(pir, SPRN_HID1, hid1_val);
-			if (rc != 0)
-				return rc;
+			/* Only p8 needs to set extra HID regiters */
+			if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
 
-			rc = opal_slw_set_reg(pir, SPRN_HID4, hid4_val);
-			if (rc != 0)
-				return rc;
+				rc = opal_slw_set_reg(pir, SPRN_HID1, hid1_val);
+				if (rc != 0)
+					return rc;
 
-			rc = opal_slw_set_reg(pir, SPRN_HID5, hid5_val);
-			if (rc != 0)
-				return rc;
+				rc = opal_slw_set_reg(pir, SPRN_HID4, hid4_val);
+				if (rc != 0)
+					return rc;
+
+				rc = opal_slw_set_reg(pir, SPRN_HID5, hid5_val);
+				if (rc != 0)
+					return rc;
+			}
 		}
 	}
 
@@ -241,14 +284,6 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
 			store_fastsleep_workaround_applyonce);
 
 /*
- * The default stop state that will be used by ppc_md.power_save
- * function on platforms that support stop instruction.
- */
-static u64 pnv_default_stop_val;
-static u64 pnv_default_stop_mask;
-static bool default_stop_found;
-
-/*
  * Used for ppc_md.power_save which needs a function with no parameters
  */
 static void power9_idle(void)
@@ -257,20 +292,6 @@ static void power9_idle(void)
 }
 
 /*
- * First deep stop state. Used to figure out when to save/restore
- * hypervisor context.
- */
-u64 pnv_first_deep_stop_state = MAX_STOP_STATE;
-
-/*
- * psscr value and mask of the deepest stop idle state.
- * Used when a cpu is offlined.
- */
-static u64 pnv_deepest_stop_psscr_val;
-static u64 pnv_deepest_stop_psscr_mask;
-static bool deepest_stop_found;
-
-/*
  * pnv_cpu_offline: A function that puts the CPU into the deepest
  * available platform idle state on a CPU-Offline.
  */
-- 
1.8.3.1
