Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3DA682C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 22:31:34 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 4 Feb 2014 17:01:33 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 81774394005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 17:01:29 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s14BVOkh42074298
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 17:01:24 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s14BVS4l021666
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 17:01:28 +0530
Received: from deepthi.in.ibm.com (deepthi.in.ibm.com [9.124.35.236] (may be
 forged))
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s14BVSN0021654
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 17:01:28 +0530
Subject: [PATCH V5 1/3] powernv: Push critical error logs to FSP
To: linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 04 Feb 2014 17:01:49 +0530
Message-ID: <20140204113140.19141.82426.stgit@deepthi.in.ibm.com>
In-Reply-To: <20140204113127.19141.21493.stgit@deepthi.in.ibm.com>
References: <20140204113127.19141.21493.stgit@deepthi.in.ibm.com>
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
 arch/powerpc/include/asm/opal.h                |   36 ++++++++++
 arch/powerpc/platforms/powernv/opal-elog.c     |   76 +++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 arch/powerpc/platforms/powernv/powernv.h       |   84 ++++++++++++++++++++++++
 4 files changed, 196 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 554a031..ede6a2d 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -174,6 +174,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_GET_PARAM				89
 #define OPAL_SET_PARAM				90
 #define OPAL_DUMP_RESEND			91
+#define OPAL_ELOG_SEND				92
 
 #ifndef __ASSEMBLY__
 
@@ -268,6 +269,40 @@ enum OpalMessageType {
 	OPAL_MSG_TYPE_MAX,
 };
 
+/* Max user dump size is 14K    */
+#define OPAL_LOG_MAX_DUMP       14336
+
+/* Multiple user data sections */
+struct __attribute__((__packed__)) opal_user_data_section {
+	uint32_t tag;
+	uint16_t size;
+	uint16_t component_id;
+	char data_dump[1];
+};
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
@@ -862,6 +897,7 @@ int64_t opal_get_elog_size(uint64_t *log_id, size_t *size, uint64_t *elog_type);
 int64_t opal_write_elog(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_send_ack_elog(uint64_t log_id);
 void opal_resend_pending_logs(void);
+int64_t opal_elog_send(void *buffer);
 int64_t opal_validate_flash(uint64_t buffer, uint32_t *size, uint32_t *result);
 int64_t opal_manage_flash(uint8_t op);
 int64_t opal_update_flash(uint64_t blk_list);
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index fc891ae..c9ce835 100644
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
@@ -16,8 +19,9 @@
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
 #include <linux/fcntl.h>
+#include <linux/mm.h>
 #include <asm/uaccess.h>
-#include <asm/opal.h>
+#include "powernv.h"
 
 /* Maximum size of a single log on FSP is 16KB */
 #define OPAL_MAX_ERRLOG_SIZE	16384
@@ -272,6 +276,76 @@ static int init_err_log_buffer(void)
 	return 0;
 }
 
+/* Interface to be used by POWERNV to push the logs to FSP via Sapphire */
+struct opal_errorlog *pnv_elog_create(uint8_t pnv_error_event_type,
+			uint16_t pnv_component_id, uint8_t pnv_subsystem_id,
+			uint8_t pnv_event_severity, uint8_t pnv_event_subtype,
+			uint32_t reason_code, uint32_t info0, uint32_t info1,
+			uint32_t info2, uint32_t info3)
+{
+	struct opal_errorlog *buf;
+
+	buf = kzalloc(sizeof(struct opal_errorlog), GFP_ATOMIC);
+	if (!buf) {
+		pr_err("Failed to allocate buffer for generating error log\n");
+		return NULL;
+	}
+
+	buf->error_event_type = pnv_error_event_type;
+	buf->component_id = pnv_component_id;
+	buf->subsystem_id = pnv_subsystem_id;
+	buf->event_severity = pnv_event_severity;
+	buf->event_subtype = pnv_event_subtype;
+	buf->reason_code = reason_code;
+	buf->additional_info[0] = info0;
+	buf->additional_info[1] = info1;
+	buf->additional_info[2] = info2;
+	buf->additional_info[3] = info3;
+	return buf;
+}
+
+int pnv_elog_update_user_dump(struct opal_errorlog *buf, unsigned char *data,
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
+	tmp->size = size + sizeof(struct opal_user_data_section) - 1;
+	memcpy(tmp->data_dump, data, size);
+
+	buf->user_section_size += tmp->size;
+	buf->user_section_count++;
+	return 0;
+}
+
+int pnv_commit_errorlog(struct opal_errorlog *buf)
+{
+	int rc;
+
+	rc = opal_elog_send((void *)(__pa(buf)));
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
index 81e445f..250f7db 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -137,3 +137,4 @@ OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
 OPAL_CALL(opal_get_param,                       OPAL_GET_PARAM);
 OPAL_CALL(opal_set_param,                       OPAL_SET_PARAM);
 OPAL_CALL(opal_dump_resend_notification,	OPAL_DUMP_RESEND);
+OPAL_CALL(opal_elog_send,			OPAL_ELOG_SEND);
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index c9cfb0b..42a8b8c 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -1,6 +1,8 @@
 #ifndef _POWERNV_H
 #define _POWERNV_H
 
+#include <asm/opal.h>
+
 #ifdef CONFIG_SMP
 extern void pnv_smp_init(void);
 #else
@@ -23,4 +25,86 @@ bool cpu_core_split_required(void);
 
 extern void pnv_lpc_init(void);
 
+/* Classification of error/event type to be reported on POWERNV */
+/* Platform Events/Errors: Report Machine Check Interrupt */
+#define PNV_PLATFORM_ERR_EVT		0x01
+/* INPUT_OUTPUT: Report all I/O related events/errors */
+#define PNV_INPUT_OUTPUT_ERR_EVT	0x02
+/* RESOURCE_DEALLOC: Hotplug events and errors */
+#define PNV_RESOURCE_DEALLOC_ERR_EVT	0x03
+/* MISC: Miscellanous error */
+#define PNV_MISC_ERR_EVT		0x04
+
+/* POWERNV Subsystem IDs listed for reporting events/errors */
+#define PNV_PROCESSOR_SUBSYSTEM		0x10
+#define PNV_MEMORY_SUBSYSTEM		0x20
+#define PNV_IO_SUBSYSTEM		0x30
+#define PNV_IO_DEVICES			0x40
+#define PNV_CEC_HARDWARE		0x50
+#define PNV_POWER_COOLING		0x60
+#define PNV_MISC_SUBSYSTEM		0x70
+#define PNV_SURVEILLANCE_ERR		0x7A
+#define PNV_PLATFORM_FIRMWARE		0x80
+#define PNV_SOFTWARE			0x90
+#define PNV_EXTERNAL_ENV		0xA0
+/*
+ * During reporting an event/error the following represents
+ * how serious the logged event/error is. (Severity)
+ */
+#define PNV_INFO						0x00
+#define PNV_RECOVERED_ERR_GENERAL				0x10
+
+/* 0x2X series is to denote set of Predictive Error */
+/* 0x20 Generic predictive error */
+#define PNV_PREDICTIVE_ERR_GENERAL				0x20
+/* 0x21 Predictive error, degraded performance */
+#define PNV_PREDICTIVE_ERR_DEGRADED_PERF			0x21
+/* 0x22 Predictive error, fault may be corrected after reboot */
+#define PNV_PREDICTIVE_ERR_FAULT_RECTIFY_REBOOT			0x22
+/*
+ * 0x23 Predictive error, fault may be corrected after reboot,
+ * degraded performance
+ */
+#define PNV_PREDICTIVE_ERR_FAULT_RECTIFY_BOOT_DEGRADE_PERF	0x23
+/* 0x24 Predictive error, loss of redundancy */
+#define PNV_PREDICTIVE_ERR_LOSS_OF_REDUNDANCY			0x24
+
+/* 0x4X series for Unrecoverable Error */
+/* 0x40 Generic Unrecoverable error */
+#define PNV_UNRECOVERABLE_ERR_GENERAL				0x40
+/* 0x41 Unrecoverable error bypassed with degraded performance */
+#define PNV_UNRECOVERABLE_ERR_DEGRADE_PERF			0x41
+/* 0x44 Unrecoverable error bypassed with loss of redundancy */
+#define PNV_UNRECOVERABLE_ERR_LOSS_REDUNDANCY			0x44
+/* 0x45 Unrecoverable error bypassed with loss of redundancy and performance */
+#define PNV_UNRECOVERABLE_ERR_LOSS_REDUNDANCY_PERF		0x45
+/* 0x48 Unrecoverable error bypassed with loss of function */
+#define PNV_UNRECOVERABLE_ERR_LOSS_OF_FUNCTION			0x48
+/*
+ * POWERNV Event Sub-type
+ * This field provides additional information on the non-error
+ * event type
+ */
+#define PNV_NA						0x00
+#define PNV_MISCELLANEOUS_INFO_ONLY			0x01
+#define PNV_PREV_REPORTED_ERR_RECTIFIED			0x10
+#define PNV_SYS_RESOURCES_DECONFIG_BY_USER		0x20
+#define PNV_SYS_RESOURCE_DECONFIG_PRIOR_ERR		0x21
+#define PNV_RESOURCE_DEALLOC_EVENT_NOTIFY		0x22
+#define PNV_CONCURRENT_MAINTENANCE_EVENT		0x40
+#define PNV_CAPACITY_UPGRADE_EVENT			0x60
+#define PNV_RESOURCE_SPARING_EVENT			0x70
+#define PNV_DYNAMIC_RECONFIG_EVENT			0x80
+#define PNV_NORMAL_SYS_PLATFORM_SHUTDOWN		0xD0
+#define PNV_ABNORMAL_POWER_OFF				0xE0
+
+struct opal_errorlog *pnv_elog_create(uint8_t pnv_error_event_type,
+			uint16_t pnv_component_id, uint8_t pnv_subsystem_id,
+			uint8_t pnv_event_severity, uint8_t pnv_event_subtype,
+			uint32_t reason_code, uint32_t info0, uint32_t info1,
+			uint32_t info2, uint32_t info3);
+int pnv_elog_update_user_dump(struct opal_errorlog *buf, unsigned char *data,
+						uint32_t tag, uint16_t size);
+int pnv_commit_errorlog(struct opal_errorlog *buf);
+
 #endif /* _POWERNV_H */
