Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F6AA1A0E20
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 21:45:29 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 21:45:29 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 025AC2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 21:45:26 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5BBi21K61079558
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 21:44:10 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5BBhb8W010699
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 21:43:38 +1000
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, joel@jms.id.au, stewart@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: [RESEND PATCH v8] powerpc/powernv: Add poweroff (EPOW,
 DPO) events support for PowerNV platform
Date: Thu, 11 Jun 2015 17:13:13 +0530
Message-Id: <1434022993-20028-2-git-send-email-vipin@linux.vnet.ibm.com>
In-Reply-To: <1434022993-20028-1-git-send-email-vipin@linux.vnet.ibm.com>
References: <1434022993-20028-1-git-send-email-vipin@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for OPAL EPOW (Early Power Off Warning) and
DPO (Delayed Power Off) events for the PowerNV platform. These events
are generated on FSP (Flexible Service Processor) based systems. EPOW
events are generated due to various critical system conditions that
require system shutdown. A few examples of these conditions are high
ambient temperature or system running on UPS power with low UPS battery.
DPO event is generated in response to admin initiated system shutdown
request. Upon receipt of EPOW and DPO events the host kernel invokes
orderly_poweroff() for performing graceful system shutdown.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            |  40 +++++++
 arch/powerpc/include/asm/opal.h                |   3 +-
 arch/powerpc/platforms/powernv/opal-power.c    | 147 ++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 4 files changed, 173 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0321a90..f460435 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -730,6 +730,46 @@ struct opal_i2c_request {
 	__be64 buffer_ra;		/* Buffer real address */
 };
 
+/*
+ * EPOW status sharing (OPAL and the host)
+ *
+ * The host will pass on OPAL, a buffer of length OPAL_SYSEPOW_MAX
+ * with individual elements being 16 bits wide to fetch the system
+ * wide EPOW status. Each element in the buffer will contain the
+ * EPOW status in it's bit representation for a particular EPOW sub
+ * class as defiend here. So multiple detailed EPOW status bits
+ * specific for any sub class can be represented in a single buffer
+ * element as it's bit representation.
+ */
+
+/* System EPOW type */
+enum OpalSysEpow {
+	OPAL_SYSEPOW_POWER	= 0,	/* Power EPOW */
+	OPAL_SYSEPOW_TEMP	= 1,	/* Temperature EPOW */
+	OPAL_SYSEPOW_COOLING	= 2,	/* Cooling EPOW */
+	OPAL_SYSEPOW_MAX	= 3,	/* Max EPOW categories */
+};
+
+/* Power EPOW */
+enum OpalSysPower {
+	OPAL_SYSPOWER_UPS	= 0x0001, /* System on UPS power */
+	OPAL_SYSPOWER_CHNG	= 0x0002, /* System power config change */
+	OPAL_SYSPOWER_FAIL	= 0x0004, /* System impending power failure */
+	OPAL_SYSPOWER_INCL	= 0x0008, /* System incomplete power */
+};
+
+/* Temperature EPOW */
+enum OpalSysTemp {
+	OPAL_SYSTEMP_AMB	= 0x0001, /* System over ambient temperature */
+	OPAL_SYSTEMP_INT	= 0x0002, /* System over internal temperature */
+	OPAL_SYSTEMP_HMD	= 0x0004, /* System over ambient humidity */
+};
+
+/* Cooling EPOW */
+enum OpalSysCooling {
+	OPAL_SYSCOOL_INSF	= 0x0001, /* System insufficient cooling */
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 042af1a..8b174f3 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -141,7 +141,8 @@ int64_t opal_pci_fence_phb(uint64_t phb_id);
 int64_t opal_pci_reinit(uint64_t phb_id, uint64_t reinit_scope, uint64_t data);
 int64_t opal_pci_mask_pe_error(uint64_t phb_id, uint16_t pe_number, uint8_t error_type, uint8_t mask_action);
 int64_t opal_set_slot_led_status(uint64_t phb_id, uint64_t slot_id, uint8_t led_type, uint8_t led_action);
-int64_t opal_get_epow_status(__be64 *status);
+int64_t opal_get_epow_status(__be16 *epow_status, __be16 *num_epow_classes);
+int64_t opal_get_dpo_status(__be64 *dpo_timeout);
 int64_t opal_set_system_attention_led(uint8_t led_action);
 int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
 			    __be16 *pci_error_type, __be16 *severity);
diff --git a/arch/powerpc/platforms/powernv/opal-power.c b/arch/powerpc/platforms/powernv/opal-power.c
index ac46c2c..58dc330 100644
--- a/arch/powerpc/platforms/powernv/opal-power.c
+++ b/arch/powerpc/platforms/powernv/opal-power.c
@@ -9,9 +9,12 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#define pr_fmt(fmt)	"opal-power: "	fmt
+
 #include <linux/kernel.h>
 #include <linux/reboot.h>
 #include <linux/notifier.h>
+#include <linux/of.h>
 
 #include <asm/opal.h>
 #include <asm/machdep.h>
@@ -19,30 +22,116 @@
 #define SOFT_OFF 0x00
 #define SOFT_REBOOT 0x01
 
+/* Detect EPOW event */
+static bool detect_epow(void)
+{
+	u16 epow;
+	int i, rc;
+	__be16 epow_classes;
+	__be16 opal_epow_status[OPAL_SYSEPOW_MAX] = {0};
+
+	/*
+	* Check for EPOW event. Kernel sends supported EPOW classes info
+	* to OPAL. OPAL returns EPOW info along with classes present.
+	*/
+	epow_classes = cpu_to_be16(OPAL_SYSEPOW_MAX);
+	rc = opal_get_epow_status(opal_epow_status, &epow_classes);
+	if (rc != OPAL_SUCCESS) {
+		pr_err("Failed to get EPOW event information\n");
+		return false;
+	}
+
+	/* Look for EPOW events present */
+	for (i = 0; i < be16_to_cpu(epow_classes); i++) {
+		epow = be16_to_cpu(opal_epow_status[i]);
+
+		/* Filter events which do not need shutdown. */
+		if (i == OPAL_SYSEPOW_POWER)
+			epow &= ~(OPAL_SYSPOWER_CHNG | OPAL_SYSPOWER_FAIL |
+					OPAL_SYSPOWER_INCL);
+		if (epow)
+			return true;
+	}
+
+	return false;
+}
+
+/* Check for existing EPOW, DPO events */
+static bool poweroff_pending(void)
+{
+	int rc;
+	__be64 opal_dpo_timeout;
+
+	/* Check for DPO event */
+	rc = opal_get_dpo_status(&opal_dpo_timeout);
+	if (rc == OPAL_SUCCESS) {
+		pr_info("Existing DPO event detected.\n");
+		return true;
+	}
+
+	/* Check for EPOW event */
+	if (detect_epow()) {
+		pr_info("Existing EPOW event detected.\n");
+		return true;
+	}
+
+	return false;
+}
+
+/* OPAL power-control events notifier */
 static int opal_power_control_event(struct notifier_block *nb,
-				    unsigned long msg_type, void *msg)
+					unsigned long msg_type, void *msg)
 {
-	struct opal_msg *power_msg = msg;
 	uint64_t type;
 
-	type = be64_to_cpu(power_msg->params[0]);
-
-	switch (type) {
-	case SOFT_REBOOT:
-		pr_info("OPAL: reboot requested\n");
-		orderly_reboot();
+	switch (msg_type) {
+	case OPAL_MSG_EPOW:
+		if (detect_epow()) {
+			pr_info("EPOW msg received. Powering off system\n");
+			orderly_poweroff(true);
+		}
 		break;
-	case SOFT_OFF:
-		pr_info("OPAL: poweroff requested\n");
+	case OPAL_MSG_DPO:
+		pr_info("DPO msg received. Powering off system\n");
 		orderly_poweroff(true);
 		break;
+	case OPAL_MSG_SHUTDOWN:
+		type = be64_to_cpu(((struct opal_msg *)msg)->params[0]);
+		switch (type) {
+		case SOFT_REBOOT:
+			pr_info("Reboot requested\n");
+			orderly_reboot();
+			break;
+		case SOFT_OFF:
+			pr_info("Poweroff requested\n");
+			orderly_poweroff(true);
+			break;
+		default:
+			pr_err("Unknown power-control type %llu\n", type);
+		}
+		break;
 	default:
-		pr_err("OPAL: power control type unexpected %016llx\n", type);
+		pr_err("Unknown OPAL message type %lu\n", msg_type);
 	}
 
 	return 0;
 }
 
+/* OPAL EPOW event notifier block */
+static struct notifier_block opal_epow_nb = {
+	.notifier_call	= opal_power_control_event,
+	.next		= NULL,
+	.priority	= 0,
+};
+
+/* OPAL DPO event notifier block */
+static struct notifier_block opal_dpo_nb = {
+	.notifier_call	= opal_power_control_event,
+	.next		= NULL,
+	.priority	= 0,
+};
+
+/* OPAL power-control event notifier block */
 static struct notifier_block opal_power_control_nb = {
 	.notifier_call	= opal_power_control_event,
 	.next		= NULL,
@@ -51,16 +140,40 @@ static struct notifier_block opal_power_control_nb = {
 
 static int __init opal_power_control_init(void)
 {
-	int ret;
+	int ret, supported = 0;
+	struct device_node *np;
 
+	/* Register OPAL power-control events notifier */
 	ret = opal_message_notifier_register(OPAL_MSG_SHUTDOWN,
-					     &opal_power_control_nb);
-	if (ret) {
-		pr_err("%s: Can't register OPAL event notifier (%d)\n",
-				__func__, ret);
-		return ret;
+						&opal_power_control_nb);
+	if (ret)
+		pr_err("Failed to register SHUTDOWN notifier, ret = %d\n", ret);
+
+	/* Determine OPAL EPOW, DPO support */
+	np = of_find_node_by_path("/ibm,opal/epow");
+	if (np) {
+		supported = of_device_is_compatible(np, "ibm,opal-v3-epow");
+		of_node_put(np);
 	}
 
+	if (!supported)
+		return 0;
+	pr_info("OPAL EPOW, DPO support detected.\n");
+
+	/* Register EPOW event notifier */
+	ret = opal_message_notifier_register(OPAL_MSG_EPOW, &opal_epow_nb);
+	if (ret)
+		pr_err("Failed to register EPOW notifier, ret = %d\n", ret);
+
+	/* Register DPO event notifier */
+	ret = opal_message_notifier_register(OPAL_MSG_DPO, &opal_dpo_nb);
+	if (ret)
+		pr_err("Failed to register DPO notifier, ret = %d\n", ret);
+
+	/* Check for any pending EPOW or DPO events. */
+	if (poweroff_pending())
+		orderly_poweroff(true);
+
 	return 0;
 }
 machine_subsys_initcall(powernv, opal_power_control_init);
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
-- 
1.9.3
