Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A98F1A0213
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 23:10:13 +1000 (EST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 383471400B5
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2014 23:10:12 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 18:40:09 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CC24AE005C
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2014 18:41:53 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6TDC5T965798146
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2014 18:42:05 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6TDA7AM001706
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2014 18:40:08 +0530
Subject: [PATCH 2/3] powerpc/powernv: Invoke opal call to handle hmi.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 29 Jul 2014 18:40:07 +0530
Message-ID: <20140729131006.13492.8779.stgit@mars>
In-Reply-To: <20140729130900.13492.85976.stgit@mars>
References: <20140729130900.13492.85976.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

When we hit the HMI in Linux, invoke opal call to handle/recover from HMI
errors in real mode and then in virtual mode during check_irq_replay()
invoke opal_poll_events()/opal_do_notifier() to retrieve HMI event from
OPAL and act accordingly.

Now that we are ready to handle HMI interrupt directly in linux, remove
the HMI interrupt registration with firmware.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                |   47 ++++++
 arch/powerpc/include/asm/paca.h                |    1 
 arch/powerpc/platforms/powernv/Makefile        |    2 
 arch/powerpc/platforms/powernv/opal-hmi.c      |  188 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 arch/powerpc/platforms/powernv/opal.c          |   35 ++++
 6 files changed, 267 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-hmi.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index dd1cf8d..b81b99e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -147,6 +147,7 @@ struct opal_sg_list {
 #define OPAL_SET_PARAM				90
 #define OPAL_DUMP_RESEND			91
 #define OPAL_DUMP_INFO2				94
+#define OPAL_HANDLE_HMI				98
 
 #ifndef __ASSEMBLY__
 
@@ -240,6 +241,7 @@ enum OpalMessageType {
 	OPAL_MSG_MEM_ERR,
 	OPAL_MSG_EPOW,
 	OPAL_MSG_SHUTDOWN,
+	OPAL_MSG_HMI_EVT,
 	OPAL_MSG_TYPE_MAX,
 };
 
@@ -502,6 +504,50 @@ struct OpalMemoryErrorData {
 	} u;
 };
 
+/* HMI interrupt event */
+enum OpalHMI_Version {
+	OpalHMIEvt_V1 = 1,
+};
+
+enum OpalHMI_Severity {
+	OpalHMI_SEV_NO_ERROR = 0,
+	OpalHMI_SEV_WARNING = 1,
+	OpalHMI_SEV_ERROR_SYNC = 2,
+	OpalHMI_SEV_FATAL = 3,
+};
+
+enum OpalHMI_Disposition {
+	OpalHMI_DISPOSITION_RECOVERED = 0,
+	OpalHMI_DISPOSITION_NOT_RECOVERED = 1,
+};
+
+enum OpalHMI_ErrType {
+	OpalHMI_ERROR_MALFUNC_ALERT	= 0,
+	OpalHMI_ERROR_PROC_RECOV_DONE,
+	OpalHMI_ERROR_PROC_RECOV_DONE_AGAIN,
+	OpalHMI_ERROR_PROC_RECOV_MASKED,
+	OpalHMI_ERROR_TFAC,
+	OpalHMI_ERROR_TFMR_PARITY,
+	OpalHMI_ERROR_HA_OVERFLOW_WARN,
+	OpalHMI_ERROR_XSCOM_FAIL,
+	OpalHMI_ERROR_XSCOM_DONE,
+	OpalHMI_ERROR_SCOM_FIR,
+	OpalHMI_ERROR_DEBUG_TRIG_FIR,
+	OpalHMI_ERROR_HYP_RESOURCE,
+};
+
+struct OpalHMIEvent {
+	uint8_t		version;	/* 0x00 */
+	uint8_t		severity;	/* 0x01 */
+	uint8_t		type;		/* 0x02 */
+	uint8_t		disposition;	/* 0x03 */
+	uint8_t		reserved_1[4];	/* 0x04 */
+
+	__be64		hmer;
+	/* TFMR register. Valid only for TFAC and TFMR_PARITY error type. */
+	__be64		tfmr;
+};
+
 enum {
 	OPAL_P7IOC_DIAG_TYPE_NONE	= 0,
 	OPAL_P7IOC_DIAG_TYPE_RGC	= 1,
@@ -860,6 +906,7 @@ int64_t opal_get_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 		uint64_t length);
 int64_t opal_sensor_read(uint32_t sensor_hndl, int token, __be32 *sensor_data);
+int64_t opal_handle_hmi(void);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index bb0bd25..dd799a3 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -171,6 +171,7 @@ struct paca_struct {
 	 * and already using emergency stack.
 	 */
 	u16 in_mce;
+	u8 hmi_event_available;		 /* HMI event is available */
 #endif
 
 	/* Stuff for accurate time accounting */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 4ad227d..495fed0 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,7 +1,7 @@
 obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
-obj-y			+= opal-msglog.o
+obj-y			+= opal-msglog.o opal-hmi.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
new file mode 100644
index 0000000..97ac8dc
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -0,0 +1,188 @@
+/*
+ * OPAL hypervisor Maintenance interrupt handling support in PowreNV.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright 2014 IBM Corporation
+ * Author: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include <asm/opal.h>
+#include <asm/cputable.h>
+
+static int opal_hmi_handler_nb_init;
+struct OpalHmiEvtNode {
+	struct list_head list;
+	struct OpalHMIEvent hmi_evt;
+};
+static LIST_HEAD(opal_hmi_evt_list);
+static DEFINE_SPINLOCK(opal_hmi_evt_lock);
+
+static void print_hmi_event_info(struct OpalHMIEvent *hmi_evt)
+{
+	const char *level, *sevstr, *error_info;
+	static const char *hmi_error_types[] = {
+		"Malfunction Alert",
+		"Processor Recovery done",
+		"Processor recovery occurred again",
+		"Processor recovery occurred for masked error",
+		"Timer facility experienced an error",
+		"TFMR SPR is corrupted",
+		"UPS (Uniterrupted Power System) Overflow indication",
+		"An XSCOM operation failure",
+		"An XSCOM operation completed",
+		"SCOM has set a reserved FIR bit to cause recovery",
+		"Debug trigger has set a reserved FIR bit to cause recovery",
+		"A hypervisor resource error occurred"
+	};
+
+	/* Print things out */
+	if (hmi_evt->version != OpalHMIEvt_V1) {
+		pr_err("HMI Interrupt, Unknown event version %d !\n",
+			hmi_evt->version);
+		return;
+	}
+	switch (hmi_evt->severity) {
+	case OpalHMI_SEV_NO_ERROR:
+		level = KERN_INFO;
+		sevstr = "Harmless";
+		break;
+	case OpalHMI_SEV_WARNING:
+		level = KERN_WARNING;
+		sevstr = "";
+		break;
+	case OpalHMI_SEV_ERROR_SYNC:
+		level = KERN_ERR;
+		sevstr = "Severe";
+		break;
+	case OpalHMI_SEV_FATAL:
+	default:
+		level = KERN_ERR;
+		sevstr = "Fatal";
+		break;
+	}
+
+	printk("%s%s Hypervisor Maintenance interrupt [%s]\n",
+		level, sevstr,
+		hmi_evt->disposition == OpalHMI_DISPOSITION_RECOVERED ?
+		"Recovered" : "Not recovered");
+	error_info = hmi_evt->type < ARRAY_SIZE(hmi_error_types) ?
+			hmi_error_types[hmi_evt->type]
+			: "Unknown";
+	printk("%s Error detail: %s\n", level, error_info);
+	printk("%s	HMER: %016llx\n", level, be64_to_cpu(hmi_evt->hmer));
+	if ((hmi_evt->type == OpalHMI_ERROR_TFAC) ||
+		(hmi_evt->type == OpalHMI_ERROR_TFMR_PARITY))
+		printk("%s	TFMR: %016llx\n", level,
+						be64_to_cpu(hmi_evt->tfmr));
+}
+
+static void hmi_event_handler(struct work_struct *work)
+{
+	unsigned long flags;
+	struct OpalHMIEvent *hmi_evt;
+	struct OpalHmiEvtNode *msg_node;
+	uint8_t disposition;
+
+	spin_lock_irqsave(&opal_hmi_evt_lock, flags);
+	while (!list_empty(&opal_hmi_evt_list)) {
+		msg_node = list_entry(opal_hmi_evt_list.next,
+					   struct OpalHmiEvtNode, list);
+		list_del(&msg_node->list);
+		spin_unlock_irqrestore(&opal_hmi_evt_lock, flags);
+
+		hmi_evt = (struct OpalHMIEvent *) &msg_node->hmi_evt;
+		print_hmi_event_info(hmi_evt);
+		disposition = hmi_evt->disposition;
+		kfree(msg_node);
+
+		/*
+		 * Check if HMI event has been recovered or not. If not
+		 * then we can't continue, invoke panic.
+		 */
+		if (disposition != OpalHMI_DISPOSITION_RECOVERED)
+			panic("Unrecoverable HMI exception");
+
+		spin_lock_irqsave(&opal_hmi_evt_lock, flags);
+	}
+	spin_unlock_irqrestore(&opal_hmi_evt_lock, flags);
+}
+
+static DECLARE_WORK(hmi_event_work, hmi_event_handler);
+/*
+ * opal_handle_hmi_event - notifier handler that queues up HMI events
+ * to be preocessed later.
+ */
+static int opal_handle_hmi_event(struct notifier_block *nb,
+			  unsigned long msg_type, void *msg)
+{
+	unsigned long flags;
+	struct OpalHMIEvent *hmi_evt;
+	struct opal_msg *hmi_msg = msg;
+	struct OpalHmiEvtNode *msg_node;
+
+	/* Sanity Checks */
+	if (msg_type != OPAL_MSG_HMI_EVT)
+		return 0;
+
+	/* HMI event info starts from param[0] */
+	hmi_evt = (struct OpalHMIEvent *)&hmi_msg->params[0];
+
+	/* Delay the logging of HMI events to workqueue. */
+	msg_node = kzalloc(sizeof(*msg_node), GFP_ATOMIC);
+	if (!msg_node) {
+		pr_err("HMI: out of memory, Opal message event not handled\n");
+		return -ENOMEM;
+	}
+	memcpy(&msg_node->hmi_evt, hmi_evt, sizeof(struct OpalHMIEvent));
+
+	spin_lock_irqsave(&opal_hmi_evt_lock, flags);
+	list_add(&msg_node->list, &opal_hmi_evt_list);
+	spin_unlock_irqrestore(&opal_hmi_evt_lock, flags);
+
+	schedule_work(&hmi_event_work);
+	return 0;
+}
+
+static struct notifier_block opal_hmi_handler_nb = {
+	.notifier_call	= opal_handle_hmi_event,
+	.next		= NULL,
+	.priority	= 0,
+};
+
+static int __init opal_hmi_handler_init(void)
+{
+	int ret;
+
+	if (!opal_hmi_handler_nb_init) {
+		ret = opal_message_notifier_register(
+				OPAL_MSG_HMI_EVT, &opal_hmi_handler_nb);
+		if (ret) {
+			pr_err("%s: Can't register OPAL event notifier (%d)\n",
+			       __func__, ret);
+			return ret;
+		}
+		opal_hmi_handler_nb_init = 1;
+	}
+	return 0;
+}
+subsys_initcall(opal_hmi_handler_init);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 4abbff2..8d98745 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -146,3 +146,4 @@ OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
 OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
 OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
 OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
+OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index af4c5ac..05b24dc 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -192,9 +192,6 @@ static int __init opal_register_exception_handlers(void)
 	 * fwnmi area at 0x7000 to provide the glue space to OPAL
 	 */
 	glue = 0x7000;
-	opal_register_exception_handler(OPAL_HYPERVISOR_MAINTENANCE_HANDLER,
-					0, glue);
-	glue += 128;
 	opal_register_exception_handler(OPAL_SOFTPATCH_HANDLER, 0, glue);
 #endif
 
@@ -516,15 +513,41 @@ int opal_machine_check(struct pt_regs *regs)
 /* Early hmi handler called in real mode. */
 int opal_hmi_exception_early(struct pt_regs *regs)
 {
-	/* TODO: Call opal hmi handler. */
+	s64 rc;
+
+	/*
+	 * call opal hmi handler. Pass paca address as token.
+	 * The return value OPAL_SUCCESS is an indication that there is
+	 * an HMI event generated waiting to pull by Linux.
+	 */
+	rc = opal_handle_hmi();
+	if (rc == OPAL_SUCCESS) {
+		local_paca->hmi_event_available = 1;
+		return 1;
+	}
 	return 0;
 }
 
 /* HMI exception handler called in virtual mode during check_irq_replay. */
 int opal_handle_hmi_exception(struct pt_regs *regs)
 {
-	/* TODO: Retrive and print HMI event from OPAL. */
-	return 0;
+	s64 rc;
+	__be64 evt = 0;
+
+	/*
+	 * Check if HMI event is available.
+	 * if Yes, then call opal_poll_events to pull opal messages and
+	 * process them.
+	 */
+	if (!local_paca->hmi_event_available)
+		return 0;
+
+	local_paca->hmi_event_available = 0;
+	rc = opal_poll_events(&evt);
+	if (rc == OPAL_SUCCESS && evt)
+		opal_do_notifier(be64_to_cpu(evt));
+
+	return 1;
 }
 
 static uint64_t find_recovery_address(uint64_t nip)
