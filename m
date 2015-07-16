Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C16401A0727
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 18:04:54 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2349E140285
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 18:04:53 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 13:34:51 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DE4531258056
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:37:41 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6G84har22675704
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:45 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6G84f8o030640
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:43 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: joel@jms.id.au, viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 3/6] cpufreq: powernv: Register for OCC related
 opal_message notification
Date: Thu, 16 Jul 2015 13:34:20 +0530
Message-Id: <1437033863-15864-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changes from v4:
- Replace memcpy() with be64_to_cpu() to copy the msg->params[]

Changes from v3:
- Move the macro definitions of OCC_RESET, OCC_LOAD, OCC_THROTTLE to
  arch/powerpc/include/asm/opal-api.h
- Use 'struct opal_occ_msg' to copy the 'opal_msg->params[]' and refer
  the members of this structure in the code; Replace 'chip_id',
  'token' and 'reason' with omsg.chip, omsg.type, omsg.throttle_status
- Use OCC_MAX_THROTTLE_STATUS instead of the magic number.
- Add opal_message_notifier_unregister()

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
 drivers/cpufreq/powernv-cpufreq.c | 74 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index d0c18c9..a634199 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -33,6 +33,7 @@
 #include <asm/firmware.h>
 #include <asm/reg.h>
 #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
+#include <asm/opal.h>
 
 #define POWERNV_MAX_PSTATES	256
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
@@ -41,7 +42,7 @@
 #define PMSR_LP(x)		((x >> 48) & 0xFF)
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
-static bool rebooting, throttled;
+static bool rebooting, throttled, occ_reset;
 
 static struct chip {
 	unsigned int id;
@@ -414,6 +415,74 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
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
+				   unsigned long msg_type, void *_msg)
+{
+	struct opal_msg *msg = _msg;
+	struct opal_occ_msg omsg;
+
+	if (msg_type != OPAL_MSG_OCC)
+		return 0;
+
+	omsg.type = be64_to_cpu(msg->params[0]);
+
+	switch (omsg.type) {
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
+		omsg.chip = be64_to_cpu(msg->params[1]);
+		omsg.throttle_status = be64_to_cpu(msg->params[2]);
+
+		if (occ_reset) {
+			occ_reset = false;
+			throttled = false;
+			pr_info("OCC: Active\n");
+			return 0;
+		}
+
+		if (omsg.throttle_status &&
+		    omsg.throttle_status <= OCC_MAX_THROTTLE_STATUS)
+			pr_info("OCC: Chip %u Pmax reduced due to %s\n",
+				(unsigned int)omsg.chip,
+				throttle_reason[omsg.throttle_status]);
+		else if (!omsg.throttle_status)
+			pr_info("OCC: Chip %u %s\n", (unsigned int)omsg.chip,
+				throttle_reason[omsg.throttle_status]);
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
@@ -481,6 +550,7 @@ static int __init powernv_cpufreq_init(void)
 		return rc;
 
 	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
+	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
 	return cpufreq_register_driver(&powernv_cpufreq_driver);
 }
 module_init(powernv_cpufreq_init);
@@ -488,6 +558,8 @@ module_init(powernv_cpufreq_init);
 static void __exit powernv_cpufreq_exit(void)
 {
 	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
+	opal_message_notifier_unregister(OPAL_MSG_OCC,
+					 &powernv_cpufreq_opal_nb);
 	cpufreq_unregister_driver(&powernv_cpufreq_driver);
 }
 module_exit(powernv_cpufreq_exit);
-- 
1.9.3
