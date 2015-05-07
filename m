Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C59681A1196
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 19:32:29 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Thu, 7 May 2015 19:32:27 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 433F22CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 19:32:26 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t479WIGk17039570
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 19:32:26 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t479Vrdh019423
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 19:31:54 +1000
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] powerpc/powernv: Extract EPOW events timeout values
 from OPAL device tree
Date: Thu,  7 May 2015 15:00:20 +0530
Message-Id: <1430991020-7556-3-git-send-email-vipin@linux.vnet.ibm.com>
In-Reply-To: <1430991020-7556-1-git-send-email-vipin@linux.vnet.ibm.com>
References: <1430991020-7556-1-git-send-email-vipin@linux.vnet.ibm.com>
Cc: stewart@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>,
 joel@jms.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL exports plaform timeout values for various EPOW events under
EPOW device tree node. EPOW node contains sub nodes for each EPOW
class. Under each class platform timeout property files are located
for EPOW events under that class. Each file contains platform timeout
value for corresponding EPOW event in seconds.
	Support for extracting EPOW event timeout values from OPAL
device tree is added by this patch. Below property files are parsed
to extract EPOW event timeout values.

 Power EPOW
 ===========
 ups-timeout
 ups-low-timeout

 Temp EPOW
 ==========
 high-ambient-temp-timeout
 crit-ambient-temp-timeout
 high-internal-temp-timeout
 crit-internal-temp-timeout

Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-power.c | 79 +++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-power.c b/arch/powerpc/platforms/powernv/opal-power.c
index 7c1b2f8..5b015f3 100644
--- a/arch/powerpc/platforms/powernv/opal-power.c
+++ b/arch/powerpc/platforms/powernv/opal-power.c
@@ -60,15 +60,7 @@ static const char * const epow_events_map[] = {
 };
 
 /* Poweroff EPOW events timeout values in seconds */
-static const int epow_timeout[] = {
-	[EPOW_POWER_UPS]	= 900,
-	[EPOW_POWER_UPS_LOW]	= 20,
-	[EPOW_TEMP_HIGH_AMB]	= 900,
-	[EPOW_TEMP_CRIT_AMB]	= 20,
-	[EPOW_TEMP_HIGH_INT]	= 900,
-	[EPOW_TEMP_CRIT_INT]	= 20,
-	[EPOW_UNKNOWN]		= 0,
-};
+static int epow_timeout[MAX_EPOW_EVENTS];
 
 /* System poweroff function. */
 static void epow_poweroff(unsigned long event)
@@ -125,6 +117,72 @@ static void stop_epow_timer(void)
 		pr_info("Poweroff timer deactivated\n");
 }
 
+/* Extract timeout value from device tree property */
+static int get_timeout_value(struct device_node *node, const char *prop)
+{
+	const __be32 *pval;
+	int timeout = 0;
+
+	pval = of_get_property(node, prop, NULL);
+	if (pval)
+		timeout = be32_to_cpup(pval);
+	else
+		pr_err("Didn't find %s dt property\n", prop);
+
+	return timeout;
+}
+
+/* Get EPOW events timeout values from OPAL device tree */
+static void get_epow_timeouts(void)
+{
+	struct device_node *epow_power, *epow_temp;
+
+	/* EPOW power class event timeouts */
+	epow_power = of_find_node_by_path("/ibm,opal/epow/power");
+	if (epow_power) {
+		epow_timeout[EPOW_POWER_UPS] =
+			get_timeout_value(epow_power, "ups-timeout");
+		pr_info("Power EPOW ups-timeout = %d seconds\n",
+				epow_timeout[EPOW_POWER_UPS]);
+
+		epow_timeout[EPOW_POWER_UPS_LOW] =
+			get_timeout_value(epow_power, "ups-low-timeout");
+		pr_info("Power EPOW ups-low-timeout = %d seconds\n",
+				epow_timeout[EPOW_POWER_UPS_LOW]);
+
+		of_node_put(epow_power);
+	} else
+		pr_info("Power EPOW class not supported in OPAL\n");
+
+	/* EPOW temp class event timeouts */
+	epow_temp = of_find_node_by_path("/ibm,opal/epow/temp");
+	if (epow_temp) {
+		epow_timeout[EPOW_TEMP_HIGH_AMB] =
+		get_timeout_value(epow_temp, "high-ambient-temp-timeout");
+		pr_info("Temp EPOW high-ambient-temp-timeout = %d seconds\n",
+				epow_timeout[EPOW_TEMP_HIGH_AMB]);
+
+		epow_timeout[EPOW_TEMP_CRIT_AMB] =
+		get_timeout_value(epow_temp, "crit-ambient-temp-timeout");
+		pr_info("Temp EPOW crit-ambient-temp-timeout = %d seconds\n",
+				epow_timeout[EPOW_TEMP_CRIT_AMB]);
+
+		epow_timeout[EPOW_TEMP_HIGH_INT] =
+		get_timeout_value(epow_temp, "high-internal-temp-timeout");
+		pr_info("Temp EPOW high-inernal-temp-timeout = %d seconds\n",
+				epow_timeout[EPOW_TEMP_HIGH_INT]);
+
+		epow_timeout[EPOW_TEMP_CRIT_INT] =
+		get_timeout_value(epow_temp, "crit-internal-temp-timeout");
+		pr_info("Temp EPOW crit-inernal-temp-timeout = %d seconds\n",
+				epow_timeout[EPOW_TEMP_CRIT_INT]);
+
+		of_node_put(epow_temp);
+	} else
+		pr_info("Temp EPOW class not supported in OPAL\n");
+
+}
+
 /* Get DPO status */
 static bool get_dpo_status(int32_t *dpo_timeout)
 {
@@ -366,6 +424,9 @@ static int __init opal_poweroff_events_init(void)
 		init_timer(&epow_timer);
 		epow_timer.function = epow_poweroff;
 
+		/* Get EPOW events timeout value */
+		get_epow_timeouts();
+
 		/* Register EPOW event notifier */
 		ret = opal_message_notifier_register(OPAL_MSG_EPOW,
 				&opal_epow_nb);
-- 
1.9.3
