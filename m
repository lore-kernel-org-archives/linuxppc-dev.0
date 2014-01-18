Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 813BC2C0356
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 13:42:52 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Sat, 18 Jan 2014 08:12:47 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 005B1394003F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 08:12:44 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0I2gYlg21102740
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 08:12:34 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0I2ghpl026404
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 08:12:43 +0530
Subject: [PATCH V3 1/3] powernv: Push critical error logs to FSP
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Sat, 18 Jan 2014 08:13:03 +0530
Message-ID: <20140118024259.13537.13285.stgit@deepthi>
In-Reply-To: <20140118024150.13537.11381.stgit@deepthi>
References: <20140118024150.13537.11381.stgit@deepthi>
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

This patch provides error logging interfaces to report critical
powernv error logs to FSP.
All the required information to dump the error is collected
at POWERNV level through error log interfaces
and then pushed on to FSP.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                |  123 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-elog.c     |   76 +++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 3 files changed, 200 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 013a696..51b8eb6 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -173,6 +173,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_SENSOR_READ			88
 #define OPAL_GET_PARAM				89
 #define OPAL_SET_PARAM				90
+#define OPAL_ELOG_SEND				92
 
 #ifndef __ASSEMBLY__
 
@@ -267,6 +268,119 @@ enum OpalMessageType {
 	OPAL_MSG_TYPE_MAX,
 };
 
+
+/* Classification of error/event type to be reported on OPAL */
+/* Platform Events/Errors: Report Machine Check Interrupt */
+#define OPAL_PLATFORM_ERR_EVT		0x01
+/* INPUT_OUTPUT: Report all I/O related events/errors */
+#define OPAL_INPUT_OUTPUT_ERR_EVT	0x02
+/* RESOURCE_DEALLOC: Hotplug events and errors */
+#define OPAL_RESOURCE_DEALLOC_ERR_EVT	0x03
+/* MISC: Miscellanous error */
+#define OPAL_MISC_ERR_EVT		0x04
+
+/* OPAL Subsystem IDs listed for reporting events/errors */
+#define OPAL_PROCESSOR_SUBSYSTEM	0x10
+#define OPAL_MEMORY_SUBSYSTEM		0x20
+#define OPAL_IO_SUBSYSTEM		0x30
+#define OPAL_IO_DEVICES			0x40
+#define OPAL_CEC_HARDWARE		0x50
+#define OPAL_POWER_COOLING		0x60
+#define OPAL_MISC_SUBSYSTEM		0x70
+#define OPAL_SURVEILLANCE_ERR		0x7A
+#define OPAL_PLATFORM_FIRMWARE		0x80
+#define OPAL_SOFTWARE			0x90
+#define OPAL_EXTERNAL_ENV		0xA0
+
+
+/*
+ * During reporting an event/error the following represents
+ * how serious the logged event/error is. (Severity)
+ */
+#define OPAL_INFO						0x00
+#define OPAL_RECOVERED_ERR_GENERAL				0x10
+
+/* 0x2X series is to denote set of Predictive Error */
+/* 0x20 Generic predictive error */
+#define OPAL_PREDICTIVE_ERR_GENERAL				0x20
+/* 0x21 Predictive error, degraded performance */
+#define OPAL_PREDICTIVE_ERR_DEGRADED_PERF			0x21
+/* 0x22 Predictive error, fault may be corrected after reboot */
+#define OPAL_PREDICTIVE_ERR_FAULT_RECTIFY_REBOOT		0x22
+/*
+ * 0x23 Predictive error, fault may be corrected after reboot,
+ * degraded performance
+ */
+#define OPAL_PREDICTIVE_ERR_FAULT_RECTIFY_BOOT_DEGRADE_PERF	0x23
+/* 0x24 Predictive error, loss of redundancy */
+#define OPAL_PREDICTIVE_ERR_LOSS_OF_REDUNDANCY			0x24
+
+/* 0x4X series for Unrecoverable Error */
+/* 0x40 Generic Unrecoverable error */
+#define OPAL_UNRECOVERABLE_ERR_GENERAL				0x40
+/* 0x41 Unrecoverable error bypassed with degraded performance */
+#define OPAL_UNRECOVERABLE_ERR_DEGRADE_PERF			0x41
+/* 0x44 Unrecoverable error bypassed with loss of redundancy */
+#define OPAL_UNRECOVERABLE_ERR_LOSS_REDUNDANCY			0x44
+/* 0x45 Unrecoverable error bypassed with loss of redundancy and performance */
+#define OPAL_UNRECOVERABLE_ERR_LOSS_REDUNDANCY_PERF		0x45
+/* 0x48 Unrecoverable error bypassed with loss of function */
+#define OPAL_UNRECOVERABLE_ERR_LOSS_OF_FUNCTION			0x48
+
+/*
+ * OPAL Event Sub-type
+ * This field provides additional information on the non-error
+ * event type
+ */
+#define OPAL_NA						0x00
+#define OPAL_MISCELLANEOUS_INFO_ONLY			0x01
+#define OPAL_PREV_REPORTED_ERR_RECTIFIED		0x10
+#define OPAL_SYS_RESOURCES_DECONFIG_BY_USER		0x20
+#define OPAL_SYS_RESOURCE_DECONFIG_PRIOR_ERR		0x21
+#define OPAL_RESOURCE_DEALLOC_EVENT_NOTIFY		0x22
+#define OPAL_CONCURRENT_MAINTENANCE_EVENT		0x40
+#define OPAL_CAPACITY_UPGRADE_EVENT			0x60
+#define OPAL_RESOURCE_SPARING_EVENT			0x70
+#define OPAL_DYNAMIC_RECONFIG_EVENT			0x80
+#define OPAL_NORMAL_SYS_PLATFORM_SHUTDOWN		0xD0
+#define OPAL_ABNORMAL_POWER_OFF				0xE0
+
+/* Max user dump size is 14K    */
+#define OPAL_LOG_MAX_DUMP       14336
+#define OPAL_USER_DATA_SZ	4
+
+/* Multiple user data sections */
+struct __attribute__((__packed__)) opal_user_data_section {
+	uint32_t tag;
+	uint16_t size;
+	uint16_t component_id;
+	char data_dump[OPAL_USER_DATA_SZ];
+};
+
+
+/*
+ * All the information regarding an error/event to be reported
+ * needs to populate this structure using pre-defined interfaces
+ * only
+ */
+struct __attribute__((__packed__)) opal_errorlog {
+
+	uint16_t component_id;
+	uint8_t error_event_type;
+	uint8_t subsystem_id;
+
+	uint8_t event_severity;
+	uint8_t event_subtype;
+	uint8_t user_section_count;
+	uint8_t elog_origin;
+
+	uint32_t user_section_size;
+	uint32_t reason_code;
+	uint32_t additional_info[4];
+
+	char user_data_dump[OPAL_LOG_MAX_DUMP];
+};
+
 /* Machine check related definitions */
 enum OpalMCE_Version {
 	OpalMCE_V1 = 1,
@@ -861,6 +975,15 @@ int64_t opal_get_elog_size(uint64_t *log_id, size_t *size, uint64_t *elog_type);
 int64_t opal_write_elog(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_send_ack_elog(uint64_t log_id);
 void opal_resend_pending_logs(void);
+struct opal_errorlog *opal_elog_create(uint8_t opal_error_event_type,
+			uint16_t opal_component_id, uint8_t opal_subsystem_id,
+			uint8_t opal_event_severity, uint8_t opal_event_subtype,
+			uint32_t reason_code, uint32_t info0, uint32_t info1,
+			uint32_t info2, uint32_t info3);
+int opal_elog_update_user_dump(struct opal_errorlog *buf, unsigned char *data,
+						uint32_t tag, uint16_t size);
+int opal_commit_errorlog_to_fsp(struct opal_errorlog *buf);
+int opal_commit_log_to_fsp(void *buf);
 int64_t opal_validate_flash(uint64_t buffer, uint32_t *size, uint32_t *result);
 int64_t opal_manage_flash(uint8_t op);
 int64_t opal_update_flash(uint64_t blk_list);
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index fc891ae..5aa2d86 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -8,6 +8,9 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+#undef DEBUG
+#define pr_fmt(fmt) "ELOG: " fmt
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
@@ -16,6 +19,7 @@
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
 #include <linux/fcntl.h>
+#include <linux/mm.h>
 #include <asm/uaccess.h>
 #include <asm/opal.h>
 
@@ -272,6 +276,78 @@ static int init_err_log_buffer(void)
 	return 0;
 }
 
+/* Interface to be used by POWERNV to push the logs to FSP via Sapphire */
+struct opal_errorlog *opal_elog_create(uint8_t opal_error_event_type,
+			uint16_t opal_component_id, uint8_t opal_subsystem_id,
+			uint8_t opal_event_severity, uint8_t opal_event_subtype,
+			uint32_t reason_code, uint32_t info0, uint32_t info1,
+			uint32_t info2, uint32_t info3)
+{
+	struct opal_errorlog *buf;
+
+	buf = kzalloc(sizeof(struct opal_errorlog), GFP_KERNEL);
+	if (!buf) {
+		pr_err("Failed to allocate buffer for generating error log\n");
+		return NULL;
+	}
+
+	buf->error_event_type = opal_error_event_type;
+	buf->component_id = opal_component_id;
+	buf->subsystem_id = opal_subsystem_id;
+	buf->event_severity = opal_event_severity;
+	buf->event_subtype = opal_event_subtype;
+	buf->reason_code = reason_code;
+	buf->additional_info[0] = info0;
+	buf->additional_info[1] = info1;
+	buf->additional_info[2] = info2;
+	buf->additional_info[3] = info3;
+	return buf;
+}
+
+int opal_elog_update_user_dump(struct opal_errorlog *buf, unsigned char *data,
+						uint32_t tag, uint16_t size)
+{
+	char *buffer;
+	struct opal_user_data_section *tmp;
+
+	if (!buf) {
+		pr_err("Cannot update user data. Error log buffer is invalid");
+		return -1;
+	}
+
+	buffer = (char *)buf->user_data_dump + buf->user_section_size;
+	if ((buf->user_section_size + size) > OPAL_LOG_MAX_DUMP) {
+		pr_err("Size of user data overruns the buffer");
+		return -1;
+	}
+
+	tmp = (struct opal_user_data_section *)buffer;
+	tmp->tag = tag;
+	tmp->size = size + sizeof(struct opal_user_data_section)
+						- OPAL_USER_DATA_SZ;
+	memcpy(tmp->data_dump, data, size);
+
+	buf->user_section_size += tmp->size;
+	buf->user_section_count++;
+	return 0;
+}
+
+int opal_commit_errorlog_to_fsp(struct opal_errorlog *buf)
+{
+	int rc;
+
+	rc = opal_commit_log_to_fsp((void *)
+			(vmalloc_to_pfn(buf) << PAGE_SHIFT));
+	if (rc == OPAL_SUCCESS) {
+		/* If the log has been committed, free the buffer */
+		kfree(buf);
+		buf = NULL;
+	} else
+		pr_err("Error log could not be committed to FSP");
+
+	return rc;
+}
+
 /* Initialize error logging */
 int __init opal_elog_init(void)
 {
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index c4907aa..65c25277 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -136,3 +136,4 @@ OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
 OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
 OPAL_CALL(opal_get_param,                       OPAL_GET_PARAM);
 OPAL_CALL(opal_set_param,                       OPAL_SET_PARAM);
+OPAL_CALL(opal_commit_log_to_fsp,		OPAL_ELOG_SEND);
