Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681CEC32788
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 13:29:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87EC20658
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 13:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87EC20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WBdw697jzF3JF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 00:29:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=akshay.adiga@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WBVc2H4TzF3J6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 00:23:20 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9BDFSO3055545
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 09:23:17 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n26hwakwk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 09:23:17 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 11 Oct 2018 14:23:14 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 11 Oct 2018 14:23:11 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9BDNApB54853788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Oct 2018 13:23:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08BAC11C05C;
 Thu, 11 Oct 2018 16:22:43 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8245811C050;
 Thu, 11 Oct 2018 16:22:41 +0100 (BST)
Received: from aks.in.ibm.com (unknown [9.124.35.29])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 11 Oct 2018 16:22:41 +0100 (BST)
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 2/3] powernv/cpuidle: Pass pointers instead of values
 to stop loop
Date: Thu, 11 Oct 2018 18:52:36 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011132237.14604-1-akshay.adiga@linux.vnet.ibm.com>
References: <20181011132237.14604-1-akshay.adiga@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18101113-0012-0000-0000-000002B5B505
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101113-0013-0000-0000-000020EA1365
Message-Id: <20181011132237.14604-3-akshay.adiga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-11_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110130
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, npiggin@gmail.com, huntbag@linux.vnet.ibm.com,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Passing pointer to the pnv_idle_state instead of psscr value and mask.
This helps us to pass more information to the stop loop. This will help to
figure out the method to enter/exit idle state.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

---
Changes from v1 :
 - Code is rebased on Nick Piggin's v4 patch "powerpc/64s: reimplement book3s
   idle code in C"

 arch/powerpc/include/asm/processor.h  |  5 ++-
 arch/powerpc/platforms/powernv/idle.c | 47 ++++++++++-----------------
 drivers/cpuidle/cpuidle-powernv.c     | 15 +++------
 3 files changed, 24 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 936795acba48..822d3236ad7f 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -43,6 +43,7 @@
 #include <asm/thread_info.h>
 #include <asm/ptrace.h>
 #include <asm/hw_breakpoint.h>
+#include <asm/cpuidle.h>
 
 /* We do _not_ want to define new machine types at all, those must die
  * in favor of using the device-tree
@@ -518,9 +519,7 @@ enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 
 extern void power7_idle_type(unsigned long type);
-extern void power9_idle_type(unsigned long stop_psscr_val,
-			      unsigned long stop_psscr_mask);
-
+extern void power9_idle_type(struct pnv_idle_states_t *state);
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
 extern void poweroff_now(void);
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 755918402591..681a23a066bb 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -44,8 +44,7 @@ int nr_pnv_idle_states;
  * The default stop state that will be used by ppc_md.power_save
  * function on platforms that support stop instruction.
  */
-static u64 pnv_default_stop_val;
-static u64 pnv_default_stop_mask;
+struct pnv_idle_states_t *pnv_default_state;
 static bool default_stop_found;
 
 /*
@@ -72,9 +71,7 @@ const int nr_known_versions = 1;
  * psscr value and mask of the deepest stop idle state.
  * Used when a cpu is offlined.
  */
-static u64 pnv_deepest_stop_psscr_val;
-static u64 pnv_deepest_stop_psscr_mask;
-static u64 pnv_deepest_stop_flag;
+static struct pnv_idle_states_t *pnv_deepest_state;
 static bool deepest_stop_found;
 
 static unsigned long power7_offline_type;
@@ -96,7 +93,7 @@ static int pnv_save_sprs_for_deep_states(void)
 	uint64_t hid5_val	= mfspr(SPRN_HID5);
 	uint64_t hmeer_val	= mfspr(SPRN_HMEER);
 	uint64_t msr_val = MSR_IDLE;
-	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
+	uint64_t psscr_val = pnv_deepest_state->psscr_val;
 
 	for_each_present_cpu(cpu) {
 		uint64_t pir = get_hard_smp_processor_id(cpu);
@@ -820,17 +817,15 @@ static unsigned long power9_offline_stop(unsigned long psscr)
 	return srr1;
 }
 
-static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
-				      unsigned long stop_psscr_mask)
+static unsigned long __power9_idle_type(struct pnv_idle_states_t *state)
 {
 	unsigned long psscr;
 	unsigned long srr1;
 
 	if (!prep_irq_for_idle_irqsoff())
 		return 0;
-
 	psscr = mfspr(SPRN_PSSCR);
-	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
+	psscr = (psscr & ~state->psscr_mask) | state->psscr_val;
 
 	__ppc64_runlatch_off();
 	srr1 = power9_idle_stop(psscr, true);
@@ -841,12 +836,10 @@ static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
 	return srr1;
 }
 
-void power9_idle_type(unsigned long stop_psscr_val,
-				      unsigned long stop_psscr_mask)
+void power9_idle_type(struct pnv_idle_states_t *state)
 {
 	unsigned long srr1;
-
-	srr1 = __power9_idle_type(stop_psscr_val, stop_psscr_mask);
+	srr1 = __power9_idle_type(state);
 	irq_set_pending_from_srr1(srr1);
 }
 
@@ -855,7 +848,7 @@ void power9_idle_type(unsigned long stop_psscr_val,
  */
 void power9_idle(void)
 {
-	power9_idle_type(pnv_default_stop_val, pnv_default_stop_mask);
+	power9_idle_type(pnv_default_state);
 }
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -974,8 +967,8 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 		unsigned long psscr;
 
 		psscr = mfspr(SPRN_PSSCR);
-		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
-						pnv_deepest_stop_psscr_val;
+		psscr = (psscr & ~pnv_deepest_state->psscr_mask) |
+						pnv_deepest_state->psscr_val;
 		srr1 = power9_offline_stop(psscr);
 	} else if (cpu_has_feature(CPU_FTR_ARCH_206) && power7_offline_type) {
 		srr1 = power7_offline();
@@ -1123,16 +1116,13 @@ static void __init pnv_power9_idle_init(void)
 
 		if (max_residency_ns < state->residency_ns) {
 			max_residency_ns = state->residency_ns;
-			pnv_deepest_stop_psscr_val = state->psscr_val;
-			pnv_deepest_stop_psscr_mask = state->psscr_mask;
-			pnv_deepest_stop_flag = state->flags;
+			pnv_deepest_state = state;
 			deepest_stop_found = true;
 		}
 
 		if (!default_stop_found &&
 		    (state->flags & OPAL_PM_STOP_INST_FAST)) {
-			pnv_default_stop_val = state->psscr_val;
-			pnv_default_stop_mask = state->psscr_mask;
+			pnv_default_state = state;
 			default_stop_found = true;
 			WARN_ON(state->flags & OPAL_PM_LOSE_FULL_CONTEXT);
 		}
@@ -1143,15 +1133,15 @@ static void __init pnv_power9_idle_init(void)
 	} else {
 		ppc_md.power_save = power9_idle;
 		pr_info("cpuidle-powernv: Default stop: psscr = 0x%016llx,mask=0x%016llx\n",
-			pnv_default_stop_val, pnv_default_stop_mask);
+			pnv_default_state->psscr_val, pnv_default_state->psscr_mask);
 	}
 
 	if (unlikely(!deepest_stop_found)) {
 		pr_warn("cpuidle-powernv: No suitable stop state for CPU-Hotplug. Offlined CPUs will busy wait");
 	} else {
 		pr_info("cpuidle-powernv: Deepest stop: psscr = 0x%016llx,mask=0x%016llx\n",
-			pnv_deepest_stop_psscr_val,
-			pnv_deepest_stop_psscr_mask);
+			pnv_deepest_state->psscr_val,
+			pnv_deepest_state->psscr_mask);
 	}
 
 	pr_info("cpuidle-powernv: First stop level that may lose SPRs = 0x%lld\n",
@@ -1173,16 +1163,15 @@ static void __init pnv_disable_deep_states(void)
 	pr_warn("cpuidle-powernv: Idle power-savings, CPU-Hotplug affected\n");
 
 	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
-	    (pnv_deepest_stop_flag & OPAL_PM_LOSE_FULL_CONTEXT)) {
+	    (pnv_deepest_state->flags & OPAL_PM_LOSE_FULL_CONTEXT)) {
 		/*
 		 * Use the default stop state for CPU-Hotplug
 		 * if available.
 		 */
 		if (default_stop_found) {
-			pnv_deepest_stop_psscr_val = pnv_default_stop_val;
-			pnv_deepest_stop_psscr_mask = pnv_default_stop_mask;
+			pnv_deepest_state = pnv_default_state;
 			pr_warn("cpuidle-powernv: Offlined CPUs will stop with psscr = 0x%016llx\n",
-				pnv_deepest_stop_psscr_val);
+				pnv_deepest_state->psscr_val);
 		} else { /* Fallback to snooze loop for CPU-Hotplug */
 			deepest_stop_found = false;
 			pr_warn("cpuidle-powernv: Offlined CPUs will busy wait\n");
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index a15514ebd1c3..5116d5991d30 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -35,13 +35,7 @@ static struct cpuidle_driver powernv_idle_driver = {
 static int max_idle_state __read_mostly;
 static struct cpuidle_state *cpuidle_state_table __read_mostly;
 
-struct stop_psscr_table {
-	u64 val;
-	u64 mask;
-};
-
-static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
-
+struct pnv_idle_states_t idx_to_state_ptr[CPUIDLE_STATE_MAX] __read_mostly;
 static u64 default_snooze_timeout __read_mostly;
 static bool snooze_timeout_en __read_mostly;
 
@@ -143,8 +137,9 @@ static int stop_loop(struct cpuidle_device *dev,
 		     struct cpuidle_driver *drv,
 		     int index)
 {
-	power9_idle_type(stop_psscr_table[index].val,
-			 stop_psscr_table[index].mask);
+	struct pnv_idle_states_t *state;
+	state = &pnv_idle_states[index];
+	power9_idle_type(state);
 	return index;
 }
 
@@ -242,8 +237,6 @@ static inline void add_powernv_state(int index, const char *name,
 	powernv_states[index].exit_latency = exit_latency;
 	powernv_states[index].enter = idle_fn;
 	/* For power8 and below psscr_* will be 0 */
-	stop_psscr_table[index].val = psscr_val;
-	stop_psscr_table[index].mask = psscr_mask;
 }
 
 /*
-- 
2.17.1

