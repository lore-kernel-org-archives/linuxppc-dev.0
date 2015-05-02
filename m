Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A72861A0D1C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 21:15:24 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Sat, 2 May 2015 21:15:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D54563578048
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 21:15:19 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t42BFAMg37093396
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 2 May 2015 21:15:19 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t42BELol022238
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 2 May 2015 21:14:21 +1000
Message-ID: <5544B179.1050901@linux.vnet.ibm.com>
Date: Sat, 02 May 2015 16:44:01 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Add poweroff (EPOW, DPO) events support
 for PowerNV platform
References: <1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com>
In-Reply-To: <1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="------------040008030303060900050405"
Cc: stewart@linux.vnet.ibm.com, joel@jms.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040008030303060900050405
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/30/2015 11:37 AM, Vipin K Parashar wrote:
> diff --git a/arch/powerpc/platforms/powernv/opal-poweroff-events.c b/arch/powerpc/platforms/powernv/opal-poweroff-events.c
> new file mode 100644
> index 0000000..9b169e2
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-poweroff-events.c
> @@ -0,0 +1,358 @@
> +/*
> + * PowerNV poweroff events support
> + *
> + * Copyright 2015 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#define pr_fmt(fmt)	"POWEROFF_EVENT: "    fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <linux/timer.h>
> +#include <linux/reboot.h>
> +#include <asm/opal.h>
> +#include <asm/machdep.h>
> +
> +/* System EPOW status */
> +u32 epow_status[OPAL_MAX_EPOW_CLASSES];
> +int num_epow_classes;

static

> +
> +/* EPOW event timer and corresponding locks */
> +static struct timer_list epow_timer;
> +static DEFINE_SPINLOCK(epow_timer_spinlock);
> +
> +/* EPOW, DPO event status values */
> +#define	DPO_DETECTED	1
> +#define	EPOW_DETECTED	1
> +
> +/* EPOW events supported */
> +#define EPOW_POWER_UPS          0
> +#define EPOW_POWER_UPS_LOW      1
> +#define EPOW_TEMP_HIGH_AMB      2
> +#define EPOW_TEMP_CRIT_AMB      3
> +#define EPOW_TEMP_HIGH_INT      4
> +#define EPOW_TEMP_CRIT_INT      5
> +#define MAX_EPOW_EVENTS		6
> +
> +/* EPOW events description */
> +static const char * const epow_events_map[] = {
> +	[EPOW_POWER_UPS]	= "UPS",
> +	[EPOW_POWER_UPS_LOW]	= "UPS-low",
> +	[EPOW_TEMP_HIGH_AMB]	= "high-ambient-temp",
> +	[EPOW_TEMP_CRIT_AMB]	= "crit-ambient-temp",
> +	[EPOW_TEMP_HIGH_INT]	= "high-internal-temp",
> +	[EPOW_TEMP_CRIT_INT]	= "crit-internal-temp",
> +};
> +
> +/* EPOW events timeout values */
> +static int epow_timeout[MAX_EPOW_EVENTS];
> +
> +/*
> + * TODO: Export various event timeout values via device tree.
> + *  Zero timeout value for any event suggests that it needs
> + *  immediate shutdown.
> + */
> +#define TIMEOUT_EPOW_POWER_UPS		450
> +#define TIMEOUT_EPOW_TEMP_HIGH_AMB	450
> +
> +/*
> + * Get various EPOW event timeouts.
> + * TODO: For now hardcoding timeout values but they need to be
> + * obtained via firmware device-tree.
> + */
> +void get_epow_timeouts(void)

static ?

> +{
> +	epow_timeout[EPOW_POWER_UPS] = TIMEOUT_EPOW_POWER_UPS;
> +	epow_timeout[EPOW_TEMP_HIGH_AMB] = TIMEOUT_EPOW_TEMP_HIGH_AMB;

What about the timeout values for other cases ? don't see assigned
anywhere but used in the process_epow() function..

> +}
> +
> +/* EPOW poweroff function. */
> +static void epow_poweroff(unsigned long event)
> +{
> +	pr_info("Powering off system due to %s EPOW event\n",
> +				epow_events_map[event]);
> +	orderly_poweroff(true);
> +}
> +
> +/* Start EPOW poweroff timer */
> +static void start_epow_timer(unsigned long event, int32_t timeout)

'event' is of type 'int' which you are passing..

> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&epow_timer_spinlock, flags);
> +	/* Check for already running epow poweroff timer */
> +	if (timer_pending(&epow_timer)) {
> +		/* Timer for same event */
> +		if (epow_timer.data == event) {
> +			spin_unlock_irqrestore(&epow_timer_spinlock, flags);
> +			return;
> +		}
> +
> +		/* Timer with early poweroff timeout */
> +		if (epow_timer.expires < (jiffies + timeout * HZ)) {

Should it also return for the equal condition ?

if (epow_timer.expires <= (jiffies + timeout * HZ))

> +			event = epow_timer.data;
> +			spin_unlock_irqrestore(&epow_timer_spinlock, flags);
> +			pr_info("Poweroff already scheduled for %s EPOW event "
> +					"with earlier timeout.\n",
> +					epow_events_map[event]);
> +			return;
> +		}
> +	}
> +
> +	/* Start a new timer/modify existing timer with new timeout value */
> +	epow_timer.data = event;
> +	mod_timer(&epow_timer, jiffies + timeout  * HZ);
> +	spin_unlock_irqrestore(&epow_timer_spinlock, flags);
> +	pr_info("Scheduled system poweroff due to %s EPOW event "
> +			"after %d seconds\n", epow_events_map[event], timeout);
> +}
> +
> +/* Stop poweroff timer */
> +static void stop_epow_timer(void)
> +{
> +	int rc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&epow_timer_spinlock, flags);
> +	rc = del_timer(&epow_timer);
> +	spin_unlock_irqrestore(&epow_timer_spinlock, flags);
> +
> +	if (rc)
> +		pr_info("Poweroff timer deactivated\n");
> +}
> +
> +/* Get DPO status */
> +static int get_dpo_status(int32_t *dpo_timeout)
> +{
> +	int rc;
> +	__be32 opal_dpo_timeout;
> +
> +	rc = opal_get_dpo_status(&opal_dpo_timeout);
> +	if (rc == OPAL_WRONG_STATE) {
> +		*dpo_timeout = 0;
> +		return 0;
> +	}
> +
> +	*dpo_timeout = be32_to_cpu(opal_dpo_timeout);
> +	return DPO_DETECTED;
> +}
> +
> +/* Process DPO event */
> +void process_dpo(void)

static function ?

> +{
> +	pr_info("Powering off system due to poweroff request.\n");
> +	orderly_poweroff(true);
> +}
> +
> +/* Get EPOW status */
> +static int get_epow_status(void)
> +{
> +	int i;
> +	bool epow_detected = false;
> +
> +	__be32 opal_epow_status[OPAL_MAX_EPOW_CLASSES];
> +	__be32 opal_epow_classes;
> +
> +	opal_epow_classes = cpu_to_be32(OPAL_MAX_EPOW_CLASSES);
> +	for (i = 0; i < OPAL_MAX_EPOW_CLASSES; i++)
> +		opal_epow_status[i] = cpu_to_be32(0);
> +
> +	/* Get EPOW events information from OPAL */
> +	opal_get_epow_status(opal_epow_status, &opal_epow_classes);
> +
> +	/* Copy EPOW status */
> +	memset(epow_status, 0, sizeof(epow_status[0] * OPAL_MAX_EPOW_CLASSES));
> +	num_epow_classes = be32_to_cpu(opal_epow_classes);
> +	for (i = 0; i < num_epow_classes; i++) {
> +		epow_status[i] = be32_to_cpu(opal_epow_status[i]);
> +		if (epow_status[i])
> +			epow_detected = true;
> +	}
> +
> +	pr_info("EPOW classes supported OPAL = %d, Host = %d "
> +			"EPOW Status = 0x%x, 0x%x, 0x%x\n",
> +			num_epow_classes, OPAL_MAX_EPOW_CLASSES,
> +			epow_status[0], epow_status[1], epow_status[2]);
> +
> +	if (epow_detected)
> +		return EPOW_DETECTED;
> +
> +	return 0;
> +}
> +
> +/* Process EPOW information */
> +void process_epow(void)
> +{
> +	int i, timeout = 0, event = -1;
> +	bool epow_normal = false;
> +
> +	/* Check for EPOW return to normal state */
> +	for (i = 0; i < OPAL_MAX_EPOW_CLASSES; i++) {

s/OPAL_MAX_EPOW_CLASSES/num_epow_classes

> +		if (epow_status[i])
> +			break;
> +	}
> +
> +	if (i == OPAL_MAX_EPOW_CLASSES)
> +		epow_normal = true;
> +
> +	/* Cancel any pending shutdown timer due to EPOW normal state.*/
> +	if (epow_normal) {
> +		stop_epow_timer();
> +		return;
> +	}
> +
> +	/* Determine EPOW events and poweroff timeouts */
> +	if (epow_status[OPAL_EPOW_POWER] & OPAL_EPOW_POWER_UPS) {
> +		pr_info("EPOW due to system running on UPS power\n");
> +		event = EPOW_POWER_UPS;
> +		timeout = epow_timeout[EPOW_POWER_UPS];
> +	}
> +
> +	if (epow_status[OPAL_EPOW_POWER] & OPAL_EPOW_POWER_UPS_LOW) {
> +		pr_info("EPOW due to system running on UPS power "
> +				"with low battery\n");
> +		event = EPOW_POWER_UPS_LOW;
> +		timeout = epow_timeout[EPOW_POWER_UPS_LOW];
> +	}
> +
> +	if (epow_status[OPAL_EPOW_TEMP] & OPAL_EPOW_TEMP_HIGH_AMB) {
> +		pr_info("EPOW due to high ambient temperature\n");
> +		event = EPOW_TEMP_HIGH_AMB;
> +		timeout = epow_timeout[EPOW_TEMP_HIGH_AMB];
> +	}
> +
> +	if (epow_status[OPAL_EPOW_TEMP] & OPAL_EPOW_TEMP_CRIT_AMB) {
> +		pr_info("EPOW due to critical ambient temperature\n");
> +		event = EPOW_TEMP_CRIT_AMB;
> +		timeout = epow_timeout[EPOW_TEMP_CRIT_AMB];
> +	}
> +
> +	if (epow_status[OPAL_EPOW_TEMP] & OPAL_EPOW_TEMP_HIGH_INT) {
> +		pr_info("EPOW due to high internal temperature\n");
> +		event = EPOW_TEMP_HIGH_INT;
> +		timeout = epow_timeout[EPOW_TEMP_HIGH_INT];
> +	}
> +
> +	if (epow_status[OPAL_EPOW_TEMP] & OPAL_EPOW_TEMP_CRIT_INT) {
> +		pr_info("EPOW due to critical internal temperature\n");
> +		event = EPOW_TEMP_CRIT_INT;
> +		timeout = epow_timeout[EPOW_TEMP_CRIT_INT];
> +	}

'event' & 'timeout' values are getting updated after each check, I guess
for multiple types of epow cases.. Can it be changed to if-elseif-if 
construct..
and check based on the criticality ...?

> +
> +	if (event == -1) {
> +		pr_err("Unknown EPOW event\n");
> +		return;
> +	}
> +
> +	/* Start EPOW poweroff timer */
> +	start_epow_timer(event, timeout);
> +}
> +
> +/* Check for any existing EPOW, DPO events and process them, if existing */
> +static void process_existing_poweroff_events(void)
> +{
> +	int rc;
> +	int32_t dpo_timeout;
> +
> +	/* Check for any existing DPO event */
> +	rc = get_dpo_status(&dpo_timeout);
> +	if (rc == DPO_DETECTED) {
> +		pr_info("Existing DPO event detected\n");
> +		process_dpo();
> +		return;
> +	 } else
> +		pr_info("No existing DPO event detected\n");
> +
> +	/* Check for any existing EPOW event */
> +	rc = get_epow_status();
> +	if (rc == EPOW_DETECTED) {
> +		pr_info("Existing EPOW event detected.\n");
> +		process_epow();
> +	} else
> +		pr_info("No existing EPOW event detected\n");
> +
> +}
> +
> +/* Platform EPOW message received */
> +static int opal_epow_event(struct notifier_block *nb,
> +			unsigned long msg_type, void *msg)
> +{
> +	pr_info("EPOW event received\n");
> +
> +	/* Get EPOW event details */
> +	get_epow_status();
> +
> +	/* Process EPOW event information */
> +	process_epow();
> +
> +	return 0;
> +}
> +
> +
> +/* Platform DPO message received */
> +static int opal_dpo_event(struct notifier_block *nb,
> +				unsigned long msg_type, void *msg)
> +{
> +	pr_info("DPO event received.\n");
> +	process_dpo();
> +
> +	return 0;
> +}
> +
> +
> +/* OPAL EPOW event notifier block */
> +static struct notifier_block opal_epow_nb = {
> +	.notifier_call  = opal_epow_event,
> +	.next           = NULL,
> +	.priority       = 0,
> +};
> +
> +/* OPAL DPO event notifier block */
> +static struct notifier_block opal_dpo_nb = {
> +	.notifier_call  = opal_dpo_event,
> +	.next           = NULL,
> +	.priority       = 0,
> +};
> +
> +/* Poweroff events init */
> +static int opal_poweroff_events_init(void)

Use '__init' macro for the initialization function.

> +{
> +	int ret;
> +
> +	/* Initialize poweroff timer */
> +	init_timer(&epow_timer);
> +	epow_timer.function = epow_poweroff;
> +
> +	/* Get EPOW event timeout values */
> +	get_epow_timeouts();
> +
> +	/* Check for any existing EPOW or DPO events. */
> +	process_existing_poweroff_events();
> +
> +	/* Register EPOW event notifier */
> +	ret = opal_message_notifier_register(OPAL_MSG_EPOW, &opal_epow_nb);
> +	if (ret) {
> +		pr_err("EPOW event notifier registration failed\n");
> +		return ret;
> +	}
> +
> +	/* Register DPO event notifier */
> +	ret = opal_message_notifier_register(OPAL_MSG_DPO, &opal_dpo_nb);
> +	if (ret) {
> +		pr_err("DPO event notifier registration failed\n");
> +		opal_notifier_unregister(&opal_epow_nb);

opal_message_notifier_unregister() instead.
plus delete the timer too.

Regards,
Neelesh.

> +		return ret;
> +	}
> +
> +
> +	pr_info("OPAL poweroff events support initialized\n");
> +
> +	return 0;
> +}
> +
> +machine_subsys_initcall(powernv, opal_poweroff_events_init);
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index a7ade94..5d3c8e3 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -249,6 +249,7 @@ OPAL_CALL(opal_pci_reinit,			OPAL_PCI_REINIT);
>   OPAL_CALL(opal_pci_mask_pe_error,		OPAL_PCI_MASK_PE_ERROR);
>   OPAL_CALL(opal_set_slot_led_status,		OPAL_SET_SLOT_LED_STATUS);
>   OPAL_CALL(opal_get_epow_status,			OPAL_GET_EPOW_STATUS);
> +OPAL_CALL(opal_get_dpo_status,			OPAL_GET_DPO_STATUS);
>   OPAL_CALL(opal_set_system_attention_led,	OPAL_SET_SYSTEM_ATTENTION_LED);
>   OPAL_CALL(opal_pci_next_error,			OPAL_PCI_NEXT_ERROR);
>   OPAL_CALL(opal_pci_poll,			OPAL_PCI_POLL);


--------------040008030303060900050405
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <br>
    <div class="moz-cite-prefix">On 04/30/2015 11:37 AM, Vipin K
      Parashar wrote:<br>
    </div>
    <blockquote
      cite="mid:1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">
diff --git a/arch/powerpc/platforms/powernv/opal-poweroff-events.c b/arch/powerpc/platforms/powernv/opal-poweroff-events.c
new file mode 100644
index 0000000..9b169e2
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-poweroff-events.c
@@ -0,0 +1,358 @@
+/*
+ * PowerNV poweroff events support
+ *
+ * Copyright 2015 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt)	"POWEROFF_EVENT: "    fmt
+
+#include &lt;linux/kernel.h&gt;
+#include &lt;linux/spinlock.h&gt;
+#include &lt;linux/timer.h&gt;
+#include &lt;linux/reboot.h&gt;
+#include &lt;asm/opal.h&gt;
+#include &lt;asm/machdep.h&gt;
+
+/* System EPOW status */
+u32 epow_status[OPAL_MAX_EPOW_CLASSES];
+int num_epow_classes;</pre>
    </blockquote>
    <br>
    <small>static</small><br>
    <br>
    <blockquote
      cite="mid:1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">+
+/* EPOW event timer and corresponding locks */
+static struct timer_list epow_timer;
+static DEFINE_SPINLOCK(epow_timer_spinlock);
+
+/* EPOW, DPO event status values */
+#define	DPO_DETECTED	1
+#define	EPOW_DETECTED	1
+
+/* EPOW events supported */
+#define EPOW_POWER_UPS          0
+#define EPOW_POWER_UPS_LOW      1
+#define EPOW_TEMP_HIGH_AMB      2
+#define EPOW_TEMP_CRIT_AMB      3
+#define EPOW_TEMP_HIGH_INT      4
+#define EPOW_TEMP_CRIT_INT      5
+#define MAX_EPOW_EVENTS		6
+
+/* EPOW events description */
+static const char * const epow_events_map[] = {
+	[EPOW_POWER_UPS]	= "UPS",
+	[EPOW_POWER_UPS_LOW]	= "UPS-low",
+	[EPOW_TEMP_HIGH_AMB]	= "high-ambient-temp",
+	[EPOW_TEMP_CRIT_AMB]	= "crit-ambient-temp",
+	[EPOW_TEMP_HIGH_INT]	= "high-internal-temp",
+	[EPOW_TEMP_CRIT_INT]	= "crit-internal-temp",
+};
+
+/* EPOW events timeout values */
+static int epow_timeout[MAX_EPOW_EVENTS];
+
+/*
+ * TODO: Export various event timeout values via device tree.
+ *  Zero timeout value for any event suggests that it needs
+ *  immediate shutdown.
+ */
+#define TIMEOUT_EPOW_POWER_UPS		450
+#define TIMEOUT_EPOW_TEMP_HIGH_AMB	450
+
+/*
+ * Get various EPOW event timeouts.
+ * TODO: For now hardcoding timeout values but they need to be
+ * obtained via firmware device-tree.
+ */
+void get_epow_timeouts(void)</pre>
    </blockquote>
    <br>
    <small>static ?</small><br>
    <br>
    <blockquote
      cite="mid:1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">+{
+	epow_timeout[EPOW_POWER_UPS] = TIMEOUT_EPOW_POWER_UPS;
+	epow_timeout[EPOW_TEMP_HIGH_AMB] = TIMEOUT_EPOW_TEMP_HIGH_AMB;</pre>
    </blockquote>
    <br>
    <small>What about the timeout values for other cases ? don't see
      assigned<br>
      anywhere but used in the process_epow() function..</small><br>
    <br>
    <blockquote
      cite="mid:1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">
+}
+
+/* EPOW poweroff function. */
+static void epow_poweroff(unsigned long event)
+{
+	pr_info("Powering off system due to %s EPOW event\n",
+				epow_events_map[event]);
+	orderly_poweroff(true);
+}
+
+/* Start EPOW poweroff timer */
+static void start_epow_timer(unsigned long event, int32_t timeout)</pre>
    </blockquote>
    <br>
    <small>'event' is of type 'int' which you are passing..</small><br>
    <br>
    <blockquote
      cite="mid:1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&amp;epow_timer_spinlock, flags);
+	/* Check for already running epow poweroff timer */
+	if (timer_pending(&amp;epow_timer)) {
+		/* Timer for same event */
+		if (epow_timer.data == event) {
+			spin_unlock_irqrestore(&amp;epow_timer_spinlock, flags);
+			return;
+		}
+
+		/* Timer with early poweroff timeout */
+		if (epow_timer.expires &lt; (jiffies + timeout * HZ)) {</pre>
    </blockquote>
    <br>
    <small>Should it also return for the equal condition ?</small><br>
    <pre wrap="">if (epow_timer.expires &lt;= (jiffies + timeout * HZ))</pre>
    <blockquote
      cite="mid:1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">
+			event = epow_timer.data;
+			spin_unlock_irqrestore(&amp;epow_timer_spinlock, flags);
+			pr_info("Poweroff already scheduled for %s EPOW event "
+					"with earlier timeout.\n",
+					epow_events_map[event]);
+			return;
+		}
+	}
+
+	/* Start a new timer/modify existing timer with new timeout value */
+	epow_timer.data = event;
+	mod_timer(&amp;epow_timer, jiffies + timeout  * HZ);
+	spin_unlock_irqrestore(&amp;epow_timer_spinlock, flags);
+	pr_info("Scheduled system poweroff due to %s EPOW event "
+			"after %d seconds\n", epow_events_map[event], timeout);
+}
+
+/* Stop poweroff timer */
+static void stop_epow_timer(void)
+{
+	int rc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&amp;epow_timer_spinlock, flags);
+	rc = del_timer(&amp;epow_timer);
+	spin_unlock_irqrestore(&amp;epow_timer_spinlock, flags);
+
+	if (rc)
+		pr_info("Poweroff timer deactivated\n");
+}
+
+/* Get DPO status */
+static int get_dpo_status(int32_t *dpo_timeout)
+{
+	int rc;
+	__be32 opal_dpo_timeout;
+
+	rc = opal_get_dpo_status(&amp;opal_dpo_timeout);
+	if (rc == OPAL_WRONG_STATE) {
+		*dpo_timeout = 0;
+		return 0;
+	}
+
+	*dpo_timeout = be32_to_cpu(opal_dpo_timeout);
+	return DPO_DETECTED;
+}
+
+/* Process DPO event */
+void process_dpo(void)</pre>
    </blockquote>
    <br>
    <small>static</small> <small>function ?</small><br>
    <br>
    <blockquote
      cite="mid:1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">+{
+	pr_info("Powering off system due to poweroff request.\n");
+	orderly_poweroff(true);
+}
+
+/* Get EPOW status */
+static int get_epow_status(void)
+{
+	int i;
+	bool epow_detected = false;
+
+	__be32 opal_epow_status[OPAL_MAX_EPOW_CLASSES];
+	__be32 opal_epow_classes;
+
+	opal_epow_classes = cpu_to_be32(OPAL_MAX_EPOW_CLASSES);
+	for (i = 0; i &lt; OPAL_MAX_EPOW_CLASSES; i++)
+		opal_epow_status[i] = cpu_to_be32(0);
+
+	/* Get EPOW events information from OPAL */
+	opal_get_epow_status(opal_epow_status, &amp;opal_epow_classes);
+
+	/* Copy EPOW status */
+	memset(epow_status, 0, sizeof(epow_status[0] * OPAL_MAX_EPOW_CLASSES));
+	num_epow_classes = be32_to_cpu(opal_epow_classes);
+	for (i = 0; i &lt; num_epow_classes; i++) {
+		epow_status[i] = be32_to_cpu(opal_epow_status[i]);
+		if (epow_status[i])
+			epow_detected = true;
+	}
+
+	pr_info("EPOW classes supported OPAL = %d, Host = %d "
+			"EPOW Status = 0x%x, 0x%x, 0x%x\n",
+			num_epow_classes, OPAL_MAX_EPOW_CLASSES,
+			epow_status[0], epow_status[1], epow_status[2]);
+
+	if (epow_detected)
+		return EPOW_DETECTED;
+
+	return 0;
+}
+
+/* Process EPOW information */
+void process_epow(void)
+{
+	int i, timeout = 0, event = -1;
+	bool epow_normal = false;
+
+	/* Check for EPOW return to normal state */
+	for (i = 0; i &lt; OPAL_MAX_EPOW_CLASSES; i++) {</pre>
    </blockquote>
    <br>
    <small>s/OPAL_MAX_EPOW_CLASSES/num_epow_classes</small><br>
    <br>
    <blockquote
      cite="mid:1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">+		if (epow_status[i])
+			break;
+	}
+
+	if (i == OPAL_MAX_EPOW_CLASSES)
+		epow_normal = true;
+
+	/* Cancel any pending shutdown timer due to EPOW normal state.*/
+	if (epow_normal) {
+		stop_epow_timer();
+		return;
+	}
+
+	/* Determine EPOW events and poweroff timeouts */
+	if (epow_status[OPAL_EPOW_POWER] &amp; OPAL_EPOW_POWER_UPS) {
+		pr_info("EPOW due to system running on UPS power\n");
+		event = EPOW_POWER_UPS;
+		timeout = epow_timeout[EPOW_POWER_UPS];
+	}
+
+	if (epow_status[OPAL_EPOW_POWER] &amp; OPAL_EPOW_POWER_UPS_LOW) {
+		pr_info("EPOW due to system running on UPS power "
+				"with low battery\n");
+		event = EPOW_POWER_UPS_LOW;
+		timeout = epow_timeout[EPOW_POWER_UPS_LOW];
+	}
+
+	if (epow_status[OPAL_EPOW_TEMP] &amp; OPAL_EPOW_TEMP_HIGH_AMB) {
+		pr_info("EPOW due to high ambient temperature\n");
+		event = EPOW_TEMP_HIGH_AMB;
+		timeout = epow_timeout[EPOW_TEMP_HIGH_AMB];
+	}
+
+	if (epow_status[OPAL_EPOW_TEMP] &amp; OPAL_EPOW_TEMP_CRIT_AMB) {
+		pr_info("EPOW due to critical ambient temperature\n");
+		event = EPOW_TEMP_CRIT_AMB;
+		timeout = epow_timeout[EPOW_TEMP_CRIT_AMB];
+	}
+
+	if (epow_status[OPAL_EPOW_TEMP] &amp; OPAL_EPOW_TEMP_HIGH_INT) {
+		pr_info("EPOW due to high internal temperature\n");
+		event = EPOW_TEMP_HIGH_INT;
+		timeout = epow_timeout[EPOW_TEMP_HIGH_INT];
+	}
+
+	if (epow_status[OPAL_EPOW_TEMP] &amp; OPAL_EPOW_TEMP_CRIT_INT) {
+		pr_info("EPOW due to critical internal temperature\n");
+		event = EPOW_TEMP_CRIT_INT;
+		timeout = epow_timeout[EPOW_TEMP_CRIT_INT];
+	}</pre>
    </blockquote>
    <br>
    <small>'event' &amp; 'timeout' values are getting updated after each
      check, I guess<br>
      for multiple types of epow cases.. Can it be changed to
      if-elseif-if construct..<br>
      and check based on the criticality ...?<br>
    </small><br>
    <blockquote
      cite="mid:1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">
+
+	if (event == -1) {
+		pr_err("Unknown EPOW event\n");
+		return;
+	}
+
+	/* Start EPOW poweroff timer */
+	start_epow_timer(event, timeout);
+}
+
+/* Check for any existing EPOW, DPO events and process them, if existing */
+static void process_existing_poweroff_events(void)
+{
+	int rc;
+	int32_t dpo_timeout;
+
+	/* Check for any existing DPO event */
+	rc = get_dpo_status(&amp;dpo_timeout);
+	if (rc == DPO_DETECTED) {
+		pr_info("Existing DPO event detected\n");
+		process_dpo();
+		return;
+	 } else
+		pr_info("No existing DPO event detected\n");
+
+	/* Check for any existing EPOW event */
+	rc = get_epow_status();
+	if (rc == EPOW_DETECTED) {
+		pr_info("Existing EPOW event detected.\n");
+		process_epow();
+	} else
+		pr_info("No existing EPOW event detected\n");
+
+}
+
+/* Platform EPOW message received */
+static int opal_epow_event(struct notifier_block *nb,
+			unsigned long msg_type, void *msg)
+{
+	pr_info("EPOW event received\n");
+
+	/* Get EPOW event details */
+	get_epow_status();
+
+	/* Process EPOW event information */
+	process_epow();
+
+	return 0;
+}
+
+
+/* Platform DPO message received */
+static int opal_dpo_event(struct notifier_block *nb,
+				unsigned long msg_type, void *msg)
+{
+	pr_info("DPO event received.\n");
+	process_dpo();
+
+	return 0;
+}
+
+
+/* OPAL EPOW event notifier block */
+static struct notifier_block opal_epow_nb = {
+	.notifier_call  = opal_epow_event,
+	.next           = NULL,
+	.priority       = 0,
+};
+
+/* OPAL DPO event notifier block */
+static struct notifier_block opal_dpo_nb = {
+	.notifier_call  = opal_dpo_event,
+	.next           = NULL,
+	.priority       = 0,
+};
+
+/* Poweroff events init */
+static int opal_poweroff_events_init(void)</pre>
    </blockquote>
    <br>
    <small>Use '__init' macro for the initialization function.</small><br>
    <br>
    <blockquote
      cite="mid:1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">+{
+	int ret;
+
+	/* Initialize poweroff timer */
+	init_timer(&amp;epow_timer);
+	epow_timer.function = epow_poweroff;
+
+	/* Get EPOW event timeout values */
+	get_epow_timeouts();
+
+	/* Check for any existing EPOW or DPO events. */
+	process_existing_poweroff_events();
+
+	/* Register EPOW event notifier */
+	ret = opal_message_notifier_register(OPAL_MSG_EPOW, &amp;opal_epow_nb);
+	if (ret) {
+		pr_err("EPOW event notifier registration failed\n");
+		return ret;
+	}
+
+	/* Register DPO event notifier */
+	ret = opal_message_notifier_register(OPAL_MSG_DPO, &amp;opal_dpo_nb);
+	if (ret) {
+		pr_err("DPO event notifier registration failed\n");
+		opal_notifier_unregister(&amp;opal_epow_nb);</pre>
    </blockquote>
    <br>
    <small>opal_message_notifier_unregister() instead.</small><br>
    <small>plus delete the timer too.</small><br>
    <br>
    <small>Regards,<br>
      Neelesh.<br>
      <br>
    </small>
    <blockquote
      cite="mid:1430374028-32181-1-git-send-email-vipin@linux.vnet.ibm.com"
      type="cite">
      <pre wrap="">+		return ret;
+	}
+
+
+	pr_info("OPAL poweroff events support initialized\n");
+
+	return 0;
+}
+
+machine_subsys_initcall(powernv, opal_poweroff_events_init);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index a7ade94..5d3c8e3 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -249,6 +249,7 @@ OPAL_CALL(opal_pci_reinit,			OPAL_PCI_REINIT);
 OPAL_CALL(opal_pci_mask_pe_error,		OPAL_PCI_MASK_PE_ERROR);
 OPAL_CALL(opal_set_slot_led_status,		OPAL_SET_SLOT_LED_STATUS);
 OPAL_CALL(opal_get_epow_status,			OPAL_GET_EPOW_STATUS);
+OPAL_CALL(opal_get_dpo_status,			OPAL_GET_DPO_STATUS);
 OPAL_CALL(opal_set_system_attention_led,	OPAL_SET_SYSTEM_ATTENTION_LED);
 OPAL_CALL(opal_pci_next_error,			OPAL_PCI_NEXT_ERROR);
 OPAL_CALL(opal_pci_poll,			OPAL_PCI_POLL);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040008030303060900050405--
