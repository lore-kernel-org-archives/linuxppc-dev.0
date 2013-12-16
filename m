Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E09AA2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 23:31:05 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Mon, 16 Dec 2013 18:01:02 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7858F1258056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 18:02:12 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBGCUorb23920676
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 18:00:51 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBGCUr00000816
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 18:00:53 +0530
Received: from [9.79.192.241] ([9.79.192.241])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 rBGCUqkH000794
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 18:00:53 +0530
Message-ID: <52AEF27F.3070202@linux.vnet.ibm.com>
Date: Mon, 16 Dec 2013 18:00:55 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/powernv: Framework to log critical errors on
 powernv.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch provides error logging interfaces to report critical
powernv error to FSP.
All the required information to dump the error is collected
at POWERNV level through error log interfaces
and then pushed on to FSP.

This also supports synchronous error logging in cases of
PANIC, by passing OPAL_ERROR_PANIC as severity in
elog_create() call.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                |  125 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-elog.c     |   60 +++++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 3 files changed, 185 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 0f01308..1c5440a 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -168,6 +168,7 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_GET_MSG				85
 #define OPAL_CHECK_ASYNC_COMPLETION		86
 #define OPAL_SYNC_HOST_REBOOT			87
+#define OPAL_ELOG_SEND				88
 
 #ifndef __ASSEMBLY__
 
@@ -260,6 +261,122 @@ enum OpalMessageType {
 	OPAL_MSG_TYPE_MAX,
 };
 
+/* Classification of Error/Events reporting type classification
+ * Platform Events/Errors: Report Machine Check Interrupt
+ * INPUT_OUTPUT: Report all I/O related events/errors
+ * RESOURCE_DEALLOC: Hotplug events and errors
+ * MISC: Miscellanous error
+ * Field: error_events_type
+ */
+enum error_events {
+	OPAL_PLATFORM,
+	OPAL_INPUT_OUTPUT,
+	OPAL_RESOURCE_DEALLOC,
+	OPAL_MISC,
+};
+
+/* OPAL Subsystem IDs listed for reporting events/errors
+ * Field: subsystem_id
+ */
+
+#define OPAL_PROCESSOR_SUBSYSTEM        0x10
+#define OPAL_MEMORY_SUBSYSTEM           0x20
+#define OPAL_IO_SUBSYSTEM               0x30
+#define OPAL_IO_DEVICES                 0x40
+#define OPAL_CEC_HARDWARE               0x50
+#define OPAL_POWER_COOLING              0x60
+#define OPAL_MISC_SUBSYSTEM             0x70
+#define OPAL_SURVEILLANCE_ERR           0x7A
+#define OPAL_PLATFORM_FIRMWARE          0x80
+#define OPAL_SOFTWARE                   0x90
+#define OPAL_EXTERNAL_ENV               0xA0
+
+/* During reporting an event/error the following represents
+ * how serious the logged event/error is. (Severity)
+ * Field: event_sev
+ */
+#define OPAL_INFO                                   0x00
+#define OPAL_RECOVERED_ERR_GENERAL                  0x10
+
+/* 0x2X series is to denote set of Predictive Error
+ * 0x20 Generic predictive error
+ * 0x21 Predictive error, degraded performance
+ * 0x22 Predictive error, fault may be corrected after reboot
+ * 0x23 Predictive error, fault may be corrected after reboot,
+ * degraded performance
+ * 0x24 Predictive error, loss of redundancy
+ */
+#define OPAL_PREDICTIVE_ERR_GENERAL                         0x20
+#define OPAL_PREDICTIVE_ERR_DEGRADED_PERF                   0x21
+#define OPAL_PREDICTIVE_ERR_FAULT_RECTIFY_REBOOT            0x22
+#define OPAL_PREDICTIVE_ERR_FAULT_RECTIFY_BOOT_DEGRADE_PERF 0x23
+#define OPAL_PREDICTIVE_ERR_LOSS_OF_REDUNDANCY              0x24
+
+/* 0x4X series for Unrecoverable Error
+ * 0x40 Generic Unrecoverable error
+ * 0x41 Unrecoverable error bypassed with degraded performance
+ * 0x44 Unrecoverable error bypassed with loss of redundancy
+ * 0x45 Unrecoverable error bypassed with loss of redundancy and performance
+ * 0x48 Unrecoverable error bypassed with loss of function
+ */
+#define OPAL_UNRECOVERABLE_ERR_GENERAL                      0x40
+#define OPAL_UNRECOVERABLE_ERR_DEGRADE_PERF                 0x41
+#define OPAL_UNRECOVERABLE_ERR_LOSS_REDUNDANCY              0x44
+#define OPAL_UNRECOVERABLE_ERR_LOSS_REDUNDANCY_PERF         0x45
+#define OPAL_UNRECOVERABLE_ERR_LOSS_OF_FUNCTION             0x48
+#define OPAL_ERROR_PANIC                                    0x50
+
+/* Event Sub-type
+ * This field provides additional information on the non-error
+ * event type
+ * Field: event_subtype
+ */
+#define OPAL_NA                                         0x00
+#define OPAL_MISCELLANEOUS_INFO_ONLY                    0x01
+#define OPAL_PREV_REPORTED_ERR_RECTIFIED                0x10
+#define OPAL_SYS_RESOURCES_DECONFIG_BY_USER             0x20
+#define OPAL_SYS_RESOURCE_DECONFIG_PRIOR_ERR            0x21
+#define OPAL_RESOURCE_DEALLOC_EVENT_NOTIFY              0x22
+#define OPAL_CONCURRENT_MAINTENANCE_EVENT               0x40
+#define OPAL_CAPACITY_UPGRADE_EVENT                     0x60
+#define OPAL_RESOURCE_SPARING_EVENT                     0x70
+#define OPAL_DYNAMIC_RECONFIG_EVENT                     0x80
+#define OPAL_NORMAL_SYS_PLATFORM_SHUTDOWN               0xD0
+#define OPAL_ABNORMAL_POWER_OFF                         0xE0
+
+/* Max user dump size is 14K    */
+#define OPAL_LOG_MAX_DUMP       14336
+
+/* Multiple user data sections */
+struct opal_usr_data_scn {
+	uint32_t tag;
+	uint16_t size;
+	uint16_t component_id;
+	char data_dump[4];
+};
+
+/* All the information regarding an error/event to be reported
+ * needs to populate this structure using pre-defined interfaces
+ * only
+ */
+struct opal_errorlog {
+
+	uint16_t component_id;
+	uint8_t error_events_type:3;
+	uint8_t subsystem_id;
+
+	uint8_t event_sev;
+	uint8_t event_subtype;
+	uint8_t usr_scn_count; /* User section count */
+	uint8_t elog_origin;
+
+	uint32_t usr_scn_size; /* User section size */
+	uint32_t reason_code;
+	uint32_t additional_info[4];
+
+	char usr_data_dump[OPAL_LOG_MAX_DUMP];
+};
+
 /* Machine check related definitions */
 enum OpalMCE_Version {
 	OpalMCE_V1 = 1,
@@ -853,6 +970,14 @@ int64_t opal_dump_ack(uint32_t dump_id);
 int64_t opal_get_msg(uint64_t buffer, size_t size);
 int64_t opal_check_completion(uint64_t buffer, size_t size, uint64_t token);
 int64_t opal_sync_host_reboot(void);
+struct opal_errorlog *elog_create(uint8_t err_evt_type, uint16_t component_id,
+		uint8_t subsystem_id, uint8_t event_sev, uint8_t  event_subtype,
+		uint32_t reason_code, uint32_t info0, uint32_t info1,
+		uint32_t info2, uint32_t info3);
+int update_user_dump(struct opal_errorlog *buf, unsigned char *data,
+					uint32_t tag, uint16_t size);
+void commit_errorlog_to_fsp(struct opal_errorlog *buf);
+int opal_commit_log_to_fsp(void *buf);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 58849d0..ade1e58 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -15,6 +15,7 @@
 #include <linux/sysfs.h>
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include <linux/fcntl.h>
 #include <asm/uaccess.h>
 #include <asm/opal.h>
@@ -22,7 +23,9 @@
 /* Maximum size of a single log on FSP is 16KB */
 #define OPAL_MAX_ERRLOG_SIZE	16384
 
-/* maximu number of records powernv can hold */
+#define USR_CHAR_ARRAY_FIXED_SIZE      4
+
+/* Maximum number of records powernv can hold */
 #define MAX_NUM_RECORD	128
 
 struct opal_err_log {
@@ -272,6 +275,61 @@ static int init_err_log_buffer(void)
 	return 0;
 }
 
+/* Interface to be used by POWERNV to push the logs to FSP via Sapphire */
+struct opal_errorlog *elog_create(uint8_t err_evt_type, uint16_t component_id,
+		uint8_t subsystem_id, uint8_t event_sev, uint8_t  event_subtype,
+		uint32_t reason_code, uint32_t info0, uint32_t info1,
+		uint32_t info2, uint32_t info3)
+{
+	struct opal_errorlog *buf;
+
+	buf = kzalloc(sizeof(struct opal_errorlog), GFP_KERNEL);
+	if (!buf) {
+		printk(KERN_ERR "ELOG: failed to allocate memory.\n");
+		return NULL;
+	}
+
+	buf->error_events_type = err_evt_type;
+	buf->component_id = component_id;
+	buf->subsystem_id = subsystem_id;
+	buf->event_sev = event_sev;
+	buf->event_subtype = event_subtype;
+	buf->reason_code = reason_code;
+	buf->additional_info[0] = info0;
+	buf->additional_info[1] = info1;
+	buf->additional_info[2] = info2;
+	buf->additional_info[3] = info3;
+	return buf;
+}
+
+int update_user_dump(struct opal_errorlog *buf, unsigned char *data,
+				uint32_t tag, uint16_t size)
+{
+	char *buffer = (char *)buf->usr_data_dump + buf->usr_scn_size;
+	struct opal_usr_data_scn *tmp;
+
+	if ((buf->usr_scn_size + size) > OPAL_LOG_MAX_DUMP) {
+		printk(KERN_ERR "ELOG: Size of dump data overruns buffer");
+		return -1;
+	}
+
+	tmp = (struct opal_usr_data_scn *)buffer;
+	tmp->tag = tag;
+	tmp->size = size + sizeof(struct opal_usr_data_scn)
+				- USR_CHAR_ARRAY_FIXED_SIZE;
+	memcpy(tmp->data_dump, data, size);
+
+	buf->usr_scn_size += tmp->size;
+	buf->usr_scn_count++;
+	return 0;
+}
+
+void commit_errorlog_to_fsp(struct opal_errorlog *buf)
+{
+	opal_commit_log_to_fsp((void *)(vmalloc_to_pfn(buf) << PAGE_SHIFT));
+	kfree(buf);
+}
+
 /* Initialize error logging */
 static int __init opal_elog_init(void)
 {
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index ad318d8..821d8a2 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -133,3 +133,4 @@ OPAL_CALL(opal_dump_ack,			OPAL_DUMP_ACK);
 OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
 OPAL_CALL(opal_check_completion,		OPAL_CHECK_ASYNC_COMPLETION);
 OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
+OPAL_CALL(opal_commit_log_to_fsp,		OPAL_ELOG_SEND);

Regards,
Deepthi
