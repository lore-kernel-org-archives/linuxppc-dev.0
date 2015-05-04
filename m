Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B6211A0E47
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 19:00:30 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EFE35140295
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:29 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 4 May 2015 19:00:28 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 669322CE804E
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:25 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4490HDX10617022
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 19:00:25 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t448xqI7023662
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 18:59:52 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] cpufreq: powernv: Register for OCC related
 opal_message notification
Date: Mon,  4 May 2015 14:24:09 +0530
Message-Id: <1430729652-14813-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: preeti@linux.vnet.ibm.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OCC is an On-Chip-Controller which takes care of power and thermal
safety of the chip. During runtime due to power failure or
overtemperature the OCC may throttle the frequencies of the CPUs to
remain within the power budget.

We want the cpufreq driver to be aware of such situations to be able
to report the reason to the user. We register to opal_message_notifier
to receive OCC messages from opal.

powernv_cpufreq_throttle_check() reports any frequency throttling and
this patch will report the reason or event that caused throttling. We
can be throttled if OCC is reset or OCC limits Pmax due to power or
thermal reasons. We are also notified of unthrottling after an OCC
reset or if OCC restores Pmax on the chip.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from v2:
- Patch split in to multiple patches.
- This patch contains only the opal_message notification handler

Changes from v1:
- Add macros to define OCC_RESET, OCC_LOAD and OCC_THROTTLE
- Define a structure to store chip id, chip mask which has bits set
  for cpus present in the chip, throttled state and a work_struct.
- Modify powernv_cpufreq_throttle_check() to be called via smp_call()
- On Pmax throttling/unthrottling update 'chip.throttled' and not the
  global 'throttled' as Pmax capping is local to the chip.
- Remove the condition which checks if local pstate is less than Pmin
  while checking for Psafe frequency. When OCC becomes active after
  reset we update 'thottled' to false and when the cpufreq governor
  initiates a pstate change, the local pstate will be in Psafe and we
  will be reporting a false positive when we are not throttled.
- Schedule a kworker on receiving throttling/unthrottling OCC message
  for that chip and schedule on all chips after receiving active.
- After an OCC reset all the cpus will be in Psafe frequency. So call
  target() and restore the frequency to policy->cur after OCC_ACTIVE
  and Pmax unthrottling
- Taken care of Viresh and Preeti's comments.

 drivers/cpufreq/powernv-cpufreq.c | 75 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index d0c18c9..9268424 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -33,15 +33,19 @@
 #include <asm/firmware.h>
 #include <asm/reg.h>
 #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
+#include <asm/opal.h>
 
 #define POWERNV_MAX_PSTATES	256
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
 #define PMSR_MAX(x)		((x >> 32) & 0xFF)
 #define PMSR_LP(x)		((x >> 48) & 0xFF)
+#define OCC_RESET		0
+#define OCC_LOAD		1
+#define OCC_THROTTLE		2
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
-static bool rebooting, throttled;
+static bool rebooting, throttled, occ_reset;
 
 static struct chip {
 	unsigned int id;
@@ -414,6 +418,74 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 	.notifier_call = powernv_cpufreq_reboot_notifier,
 };
 
+static char throttle_reason[][30] = {
+					"No throttling",
+					"Power Cap",
+					"Processor Over Temperature",
+					"Power Supply Failure",
+					"Over Current",
+					"OCC Reset"
+				     };
+
+static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
+				   unsigned long msg_type, void *msg)
+{
+	struct opal_msg *occ_msg = msg;
+	uint64_t token;
+	uint64_t chip_id, reason;
+
+	if (msg_type != OPAL_MSG_OCC)
+		return 0;
+
+	token = be64_to_cpu(occ_msg->params[0]);
+
+	switch (token) {
+	case OCC_RESET:
+		occ_reset = true;
+		/*
+		 * powernv_cpufreq_throttle_check() is called in
+		 * target() callback which can detect the throttle state
+		 * for governors like ondemand.
+		 * But static governors will not call target() often thus
+		 * report throttling here.
+		 */
+		if (!throttled) {
+			throttled = true;
+			pr_crit("CPU Frequency is throttled\n");
+		}
+		pr_info("OCC: Reset\n");
+		break;
+	case OCC_LOAD:
+		pr_info("OCC: Loaded\n");
+		break;
+	case OCC_THROTTLE:
+		chip_id = be64_to_cpu(occ_msg->params[1]);
+		reason = be64_to_cpu(occ_msg->params[2]);
+
+		if (occ_reset) {
+			occ_reset = false;
+			throttled = false;
+			pr_info("OCC: Active\n");
+			return 0;
+		}
+
+		if (reason && reason <= 5)
+			pr_info("OCC: Chip %u Pmax reduced due to %s\n",
+				(unsigned int)chip_id,
+				throttle_reason[reason]);
+		else if (!reason)
+			pr_info("OCC: Chip %u %s\n", (unsigned int)chip_id,
+				throttle_reason[reason]);
+	}
+	return 0;
+}
+
+static struct notifier_block powernv_cpufreq_opal_nb = {
+	.notifier_call	= powernv_cpufreq_occ_msg,
+	.next		= NULL,
+	.priority	= 0,
+};
+
 static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
 	struct powernv_smp_call_data freq_data;
@@ -481,6 +553,7 @@ static int __init powernv_cpufreq_init(void)
 		return rc;
 
 	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
+	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
 	return cpufreq_register_driver(&powernv_cpufreq_driver);
 }
 module_init(powernv_cpufreq_init);
-- 
1.9.3
