Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A05C91A2D87
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:53:48 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Fri, 10 Apr 2015 16:53:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 665C83578047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:53:44 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A6raBp52887560
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:53:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A6rAJG028627
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:53:11 +1000
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/powernv: Add udev notification and poweroff event
 attributes
Date: Fri, 10 Apr 2015 12:22:13 +0530
Message-Id: <1428648733-23826-3-git-send-email-vipin@linux.vnet.ibm.com>
In-Reply-To: <1428648733-23826-1-git-send-email-vipin@linux.vnet.ibm.com>
References: <1428648733-23826-1-git-send-email-vipin@linux.vnet.ibm.com>
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds udev notification and poweroff event attributes for
EPOW, DPO poweroff events. OPAL Poweroff events driver exposes these
poweroff event attributes as attribute files for platform device
opal-poweroff-events. Upon receiving OPAL notifications for EPOW, DPO
events, driver sends uevents to notify udev and sets event attributes
accordingly.

Below attribute files are created for platform device opal-poweroff-events:

admin_shutdown - Poweroff needed due to admin requested shutdown
	Values as below:
	No
	Yes

power_supply - Poweroff needed due to UPS/internal battery
	Values as below:
	Normal
	UPS
	UPS-low

thermal - Poweroff needed due to abnormal ambient or internal temp
	Values as below:
	Normal
	High-ambient-temp
	Critical-ambient-temp
	High-internal-temp
	Critical-internal-temp

timeout - Time allowed for poweroff

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
---
 .../platforms/powernv/opal-poweroff-events.c       | 239 ++++++++++++++++++---
 1 file changed, 212 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-poweroff-events.c b/arch/powerpc/platforms/powernv/opal-poweroff-events.c
index f1669e0..757ed83 100644
--- a/arch/powerpc/platforms/powernv/opal-poweroff-events.c
+++ b/arch/powerpc/platforms/powernv/opal-poweroff-events.c
@@ -21,14 +21,132 @@
 
 #include "opal-poweroff-events.h"
 
-/* Poweroff timers */
+/* Kobject pointer for poweroff events platform device */
+static struct kobject *poweroff_dev_kobj;
+
+/* Poweroff event timer */
 static struct timer_list poweroff_timer;
-static DEFINE_SPINLOCK(poweroff_timer_spinlock);
 
 /* Converts OPAL event type into it's description. */
 static const char *poweroff_events_map[POWEROFF_EVENTS]
 			= {"EPOW", "DPO"};
 
+/* Spinlock for poweroff events */
+unsigned long flags;
+static DEFINE_SPINLOCK(poweroff_event_spinlock);
+
+/* Poweroff event properties */
+enum props_power_supply {
+	POWER_SUPPLY_NORMAL,
+	POWER_SUPPLY_UPS,
+	POWER_SUPPLY_UPS_LOW,
+};
+
+enum props_thermal {
+	THERMAL_NORMAL,
+	THERMAL_HIGH_AMB_TEMP,
+	THERMAL_CRIT_AMB_TEMP,
+	THERMAL_HIGH_INT_TEMP,
+	THERMAL_CRIT_INT_TEMP,
+};
+
+/* Poweroff event property strings */
+static const char *poweroff_power_supply[] = {
+	[POWER_SUPPLY_NORMAL] = "Normal",
+	[POWER_SUPPLY_UPS] = "UPS",
+	[POWER_SUPPLY_UPS_LOW] = "UPS-battery-low",
+};
+static const char *poweroff_thermal[] = {
+	[THERMAL_NORMAL] = "Normal",
+	[THERMAL_HIGH_AMB_TEMP] = "High-ambient-temp",
+	[THERMAL_CRIT_AMB_TEMP] = "Critical-ambient-temp",
+	[THERMAL_HIGH_INT_TEMP] = "High-internal-temp",
+	[THERMAL_CRIT_INT_TEMP] = "Critical-internal-temp",
+};
+
+/* Global variable for poweroff event properties */
+static struct {
+	bool admin_shutdown;
+	enum props_power_supply power_supply;
+	enum props_thermal thermal;
+} poweroff_property = {
+	.admin_shutdown = false,
+	.power_supply = POWER_SUPPLY_NORMAL,
+	.thermal = THERMAL_NORMAL,
+};
+
+/* Poweroff events device attribute functions */
+static ssize_t thermal_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int index;
+
+	spin_lock_irqsave(&poweroff_event_spinlock, flags);
+	index = poweroff_property.thermal;
+	spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
+
+	return sprintf(buf, "%s\n", poweroff_thermal[index]);
+}
+
+static ssize_t power_supply_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int index;
+
+	spin_lock_irqsave(&poweroff_event_spinlock, flags);
+	index = poweroff_property.power_supply;
+	spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
+
+	return sprintf(buf, "%s\n", poweroff_power_supply[index]);
+}
+
+static ssize_t admin_shutdown_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int admin_shutdown;
+
+	spin_lock_irqsave(&poweroff_event_spinlock, flags);
+	admin_shutdown = poweroff_property.admin_shutdown;
+	spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
+
+	return sprintf(buf, "%s\n", admin_shutdown ? "Yes" : "No");
+}
+
+static ssize_t timeout_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	unsigned long timeout;
+
+	spin_lock_irqsave(&poweroff_event_spinlock, flags);
+	if (time_after(poweroff_timer.expires, jiffies))
+		timeout = (poweroff_timer.expires - jiffies) / HZ;
+	else
+		timeout = 0;
+	spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
+
+	return sprintf(buf, "%lu\n", timeout);
+}
+
+/* Poweroff events device attributes */
+static struct device_attribute poweroff_attrs[] = {
+	__ATTR_RO(thermal),		/* Thermal state of the machine */
+	__ATTR_RO(power_supply),	/* Power supply state of the machine */
+	__ATTR_RO(admin_shutdown),	/* Admin initated power off event */
+	__ATTR_RO(timeout),		/* Timeout for system shutdown */
+};
+
+/* Workitem and callback function to notify udev */
+static void notify_udev(struct work_struct *work)
+{
+	int ret;
+
+	/* Trigger uevent to notify udev */
+	ret = kobject_uevent(poweroff_dev_kobj, KOBJ_CHANGE);
+	if (ret)
+		pr_info("Unable to publish uevent. Error = %d\n", ret);
+}
+static DECLARE_WORK(work_notify_udev, notify_udev);
+
 /* Host poweroff function. */
 static void poweroff_host(unsigned long event)
 {
@@ -39,13 +157,11 @@ static void poweroff_host(unsigned long event)
 /* Start poweroff timer */
 static void start_poweroff_timer(unsigned long event, int32_t timeout)
 {
-	unsigned long flags;
-
 	/* Check if any poweroff timer is already active with lower timeout */
-	spin_lock_irqsave(&poweroff_timer_spinlock, flags);
+	spin_lock_irqsave(&poweroff_event_spinlock, flags);
 	if (timer_pending(&poweroff_timer) &&
 			(poweroff_timer.expires < (jiffies + timeout * HZ))) {
-		spin_unlock_irqrestore(&poweroff_timer_spinlock, flags);
+		spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
 		pr_info("An earlier poweroff already scheduled due to %s "
 			"event\n", poweroff_events_map[poweroff_timer.data]);
 		return;
@@ -54,7 +170,7 @@ static void start_poweroff_timer(unsigned long event, int32_t timeout)
 	/* Start a new timer/modify existing timer with new timeout value */
 	poweroff_timer.data = event;
 	mod_timer(&poweroff_timer, jiffies + timeout  * HZ);
-	spin_unlock_irqrestore(&poweroff_timer_spinlock, flags);
+	spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
 	pr_info("Scheduled poweroff due to %s event after %d seconds\n",
 			poweroff_events_map[event], timeout);
 }
@@ -62,29 +178,26 @@ static void start_poweroff_timer(unsigned long event, int32_t timeout)
 /* Cancel poweroff timer for EPOW event */
 static void cancel_epow_poweroff_timer(void)
 {
-	unsigned long flags;
-
 	/* Check if poweroff time for epow event is running */
-	spin_lock_irqsave(&poweroff_timer_spinlock, flags);
+	spin_lock_irqsave(&poweroff_event_spinlock, flags);
 	if (timer_pending(&poweroff_timer) &&
 		poweroff_timer.data ==  POWEROFF_EVENT_EPOW) {
 		del_timer_sync(&poweroff_timer);
-		spin_unlock_irqrestore(&poweroff_timer_spinlock, flags);
+		spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
 		pr_info("Poweroff timer for EPOW event deactivated\n");
 		return;
 	}
-	spin_unlock_irqrestore(&poweroff_timer_spinlock, flags);
+	spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
 }
 
 /* Stop poweroff timer */
 static void stop_poweroff_timer(void)
 {
 	int rc;
-	unsigned long flags;
 
-	spin_lock_irqsave(&poweroff_timer_spinlock, flags);
+	spin_lock_irqsave(&poweroff_event_spinlock, flags);
 	rc = del_timer_sync(&poweroff_timer);
-	spin_unlock_irqrestore(&poweroff_timer_spinlock, flags);
+	spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
 
 	if (rc)
 		pr_info("Poweroff timer deactivated\n");
@@ -155,14 +268,51 @@ void process_epow_event(struct epow_event *p_epow)
 	int guest_shutdown = 0;
 	int epow_delay = 0;
 
-	/*
-	* OPAL_EPOW_NONE shows that EPOW condition has returned
-	* to normal and thus we need to cancel any EPOW poweroff
-	* timer running.
-	*/
-	if (p_epow->type == OPAL_EPOW_NONE) {
+	/* Check EPOW event type and process accordingly */
+	switch (p_epow->type) {
+	case OPAL_EPOW_NONE:
+		spin_lock_irqsave(&poweroff_event_spinlock, flags);
+		poweroff_property.power_supply = POWER_SUPPLY_NORMAL;
+		poweroff_property.thermal = THERMAL_NORMAL;
+		spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
+
+		/* Schedule async work to notify udev */
+		schedule_work(&work_notify_udev);
+
+		/* Cancel any running EPOW event poweroff timer */
 		cancel_epow_poweroff_timer();
 		return;
+	case OPAL_EPOW_EVENT_TYPE3:
+		spin_lock_irqsave(&poweroff_event_spinlock, flags);
+		switch (p_epow->reason_code) {
+		case OPAL_EPOW_UPS:
+			poweroff_property.power_supply = POWER_SUPPLY_UPS;
+			break;
+		case OPAL_EPOW_AMB_TEMP:
+			poweroff_property.thermal = THERMAL_HIGH_AMB_TEMP;
+			break;
+		case OPAL_EPOW_INT_TEMP:
+			poweroff_property.power_supply = THERMAL_HIGH_INT_TEMP;
+		}
+		spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
+		break;
+	case OPAL_EPOW_EVENT_TYPE4:
+		spin_lock_irqsave(&poweroff_event_spinlock, flags);
+		switch (p_epow->reason_code) {
+		case OPAL_EPOW_UPS:
+			poweroff_property.power_supply = POWER_SUPPLY_UPS_LOW;
+			break;
+		case OPAL_EPOW_AMB_TEMP:
+			poweroff_property.thermal = THERMAL_CRIT_AMB_TEMP;
+			break;
+		case OPAL_EPOW_INT_TEMP:
+			poweroff_property.power_supply = THERMAL_CRIT_INT_TEMP;
+		}
+		spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
+		break;
+	default:
+		pr_err("Unknown EPOW event\n");
+		return;
 	}
 
 	/*
@@ -191,6 +341,10 @@ void process_epow_event(struct epow_event *p_epow)
 	if (epow_delay)
 		timeout += POWEROFF_EPOW_DELAY;
 
+	/* Schedule async work to notify udev */
+	schedule_work(&work_notify_udev);
+
+	/* Start kernel poweroff timer */
 	start_poweroff_timer(POWEROFF_EVENT_EPOW, timeout);
 }
 
@@ -208,6 +362,14 @@ void process_dpo_event(int64_t dpo_timeout)
 	else
 		dpo_timeout = POWEROFF_HOST_TIME;
 
+	spin_lock_irqsave(&poweroff_event_spinlock, flags);
+	poweroff_property.admin_shutdown = true;
+	spin_unlock_irqrestore(&poweroff_event_spinlock, flags);
+
+	/* Schedule async work to notify udev */
+	schedule_work(&work_notify_udev);
+
+	/* Start kernel poweroff timer */
 	start_poweroff_timer(POWEROFF_EVENT_DPO, dpo_timeout);
 }
 
@@ -227,7 +389,7 @@ static void process_existing_poweroff_events(void)
 
 	if (epow.type != OPAL_EPOW_NONE) {
 		pr_info("Existing EPOW%d event detected. "
-			"Timeout = %d seconds, Reason: %s\n",
+			"HW timeout = %d seconds, Reason: %s\n",
 			epow.type, epow.timeout,
 			get_epow_reason_string(epow.reason_code));
 		process_epow_event(&epow);
@@ -238,7 +400,7 @@ check_dpo:
 	/* Check for any existing DPO event */
 	get_dpo_timeout(&dpo_timeout);
 	if (dpo_timeout) {
-		pr_info("Existing DPO event detected. Timeout = %lld seconds\n",
+		pr_info("Existing DPO event detected. HW timeout = %lld seconds\n",
 				dpo_timeout);
 		process_dpo_event(dpo_timeout);
 	 } else
@@ -259,11 +421,11 @@ static int opal_epow_event_notifier(struct notifier_block *nb,
 		return 0;
 	}
 
-	pr_info("EPOW%d event received. Timeout = %d seconds, Reason: %s\n",
+	pr_info("EPOW%d event received. HW timeout = %d seconds, Reason: %s\n",
 		epow.type, epow.timeout,
 		get_epow_reason_string(epow.reason_code));
 
-	/* Processing EPOW event information */
+	/* Process EPOW event information */
 	process_epow_event(&epow);
 
 	return 0;
@@ -284,8 +446,9 @@ static int opal_dpo_event_notifier(struct notifier_block *nb,
 		return 0;
 	}
 
-	pr_info("DPO event received. Timeout = %lld seconds\n", dpo_timeout);
+	pr_info("DPO event received. HW timeout = %lld seconds\n", dpo_timeout);
 
+	/* Process DPO event */
 	process_dpo_event(dpo_timeout);
 
 	return 0;
@@ -309,12 +472,24 @@ static struct notifier_block opal_dpo_nb = {
 /* Platform driver probe */
 static int opal_poweroff_events_probe(struct platform_device *pdev)
 {
-	int ret;
+	int i, ret;
 
 	/* Initialize poweroff timer */
 	init_timer(&poweroff_timer);
 	poweroff_timer.function = poweroff_host;
 
+	/* Kobject pointer for poweroff events platform device */
+	poweroff_dev_kobj = &(pdev->dev.kobj);
+
+	/* Create sysfs attribute files for device */
+	for (i=0; i<ARRAY_SIZE(poweroff_attrs); i++) {
+		ret = device_create_file(&pdev->dev, &poweroff_attrs[i]);
+		if (ret)
+			pr_err("Failed to create sysfs attr file '%s'. "
+				"Error = %d\n", poweroff_attrs[i].attr.name,
+						ret);
+	}
+
 	/*
 	 * Check for any existing EPOW or DPO events. Host could have missed
 	 * their notifications while booting.
@@ -339,12 +514,15 @@ static int opal_poweroff_events_probe(struct platform_device *pdev)
 	pr_info("DPO event notifier registered\n");
 
 	pr_info("OPAL poweroff events driver initialized\n");
+
 	return 0;
 }
 
 /* Platform driver remove */
 static int opal_poweroff_events_remove(struct platform_device *pdev)
 {
+	int i;
+
 	/* Unregister OPAL message notifiers */
 	opal_notifier_unregister(&opal_dpo_nb);
 	opal_notifier_unregister(&opal_epow_nb);
@@ -352,6 +530,13 @@ static int opal_poweroff_events_remove(struct platform_device *pdev)
 	/* Stop poweroff timer */
 	stop_poweroff_timer();
 
+	/* Cancel any async work scheduled */
+	cancel_work_sync(&work_notify_udev);
+
+	/* Remove sysfs attribute files */
+	for (i=0; i<ARRAY_SIZE(poweroff_attrs); i++)
+		device_remove_file(&pdev->dev, &poweroff_attrs[i]);
+
 	pr_info("OPAL poweroff events driver exited\n");
 	return 0;
 }
-- 
1.9.3
