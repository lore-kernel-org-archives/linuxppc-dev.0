Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C0712C0312
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 05:58:13 +1100 (EST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MY40053OC8BJKB0@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Sat, 21 Dec 2013 03:48:11 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: rjw@rjwysocki.net
Subject: [PATCH v2 4/9] ACPI / cpuidle: fix max idle state handling with
 hotplug CPU support
Date: Fri, 20 Dec 2013 19:47:26 +0100
Message-id: <1387565251-7051-5-git-send-email-b.zolnierkie@samsung.com>
In-reply-to: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 b.zolnierkie@samsung.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
 linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

acpi_processor_hotplug() calls acpi_processor_setup_cpuidle_cx()
without calling acpi_processor_setup_cpuidle_states() first so it
is possible that dev->state_count becomes different from
drv->state_count (in case of SMP system with unsupported C2/C3
states + enabled CPU hotplug and num_online_cpus() becoming > 1).

The driver code assumes that cpuidle core will handle such cases
but currently this is untrue (dev->state_count is used only for
handling cpuidle state sysfs entries and drv->state_count is used
for all other cases) and will not be fixed in the future as
dev->state_count is planned to be removed.

Fix the issue by checking for the max supported idle state in
C2/C3 state's ->enter handler (acpi_idle_enter_simple() for C2/C3
and acpi_idle_enter_bm() for C3 + bm_check flag set) and setting
the C1 state (instead of higher states) when needed.

Also remove no longer needed max idle state checks from
acpi_processor_setup_cpuidle_[states,cx]().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/processor_idle.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index a0cc5ef4f..c080c99 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -783,6 +783,13 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return -EINVAL;
 
+#ifdef CONFIG_HOTPLUG_CPU
+	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+	    !pr->flags.has_cst &&
+	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
+		return acpi_idle_enter_c1(dev, drv, CPUIDLE_DRIVER_STATE_START);
+#endif
+
 	if (cx->entry_method == ACPI_CSTATE_FFH) {
 		if (current_set_polling_and_test())
 			return -EINVAL;
@@ -829,6 +836,13 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return -EINVAL;
 
+#ifdef CONFIG_HOTPLUG_CPU
+	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+	    !pr->flags.has_cst &&
+	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
+		return acpi_idle_enter_c1(dev, drv, CPUIDLE_DRIVER_STATE_START);
+#endif
+
 	if (!cx->bm_sts_skip && acpi_idle_bm_check()) {
 		if (drv->safe_state_index >= 0) {
 			return drv->states[drv->safe_state_index].enter(dev,
@@ -930,12 +944,6 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 		if (!cx->valid)
 			continue;
 
-#ifdef CONFIG_HOTPLUG_CPU
-		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
-		    !pr->flags.has_cst &&
-		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
-			continue;
-#endif
 		per_cpu(acpi_cstate[count], dev->cpu) = cx;
 
 		count++;
@@ -985,13 +993,6 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 		if (!cx->valid)
 			continue;
 
-#ifdef CONFIG_HOTPLUG_CPU
-		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
-		    !pr->flags.has_cst &&
-		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
-			continue;
-#endif
-
 		state = &drv->states[count];
 		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d", i);
 		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
-- 
1.8.2.3
