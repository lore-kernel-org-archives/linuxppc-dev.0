Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C1DB02C00A2
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Dec 2013 16:17:30 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 16 Dec 2013 15:17:25 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D3E493578023
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Dec 2013 16:17:22 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBG5HALB10289500
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Dec 2013 16:17:10 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBG5HM9N000368
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Dec 2013 16:17:22 +1100
Subject: [PATCH] This patch adds support to read error logs from OPAL and
 export them
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 16 Dec 2013 10:47:20 +0530
Message-ID: <20131216051720.30807.40785.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

to userspace through sysfs interface /sys/firmware/opa/opal-elog.

This patch buffers 128 error log records until it is consumed by userspace
tool. This patch provides an sysfs interface '/sys/firmware/opa/opal-elog-ack'
to user to receive an acknowledgement of successful log consumption.

This is what user space tool would do:
- Read error log from /sys/firmware/opa/opal-elog.
- Save it to the disk.
- Send an acknowledgement on successful consumption by writing error log
  id to /sys/firmware/opa/opal-elog-ack.

Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                |   11 +
 arch/powerpc/platforms/powernv/Makefile        |    2 
 arch/powerpc/platforms/powernv/opal-elog.c     |  309 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    5 
 arch/powerpc/platforms/powernv/opal.c          |    2 
 5 files changed, 328 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-elog.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 5462fa7..723a7db 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -129,6 +129,11 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_LPC_READ				67
 #define OPAL_LPC_WRITE				68
 #define OPAL_RETURN_CPU				69
+#define OPAL_ELOG_READ				71
+#define OPAL_ELOG_WRITE				72
+#define OPAL_ELOG_ACK				73
+#define OPAL_ELOG_RESEND			74
+#define OPAL_ELOG_SIZE				75
 #define OPAL_FLASH_VALIDATE			76
 #define OPAL_FLASH_MANAGE			77
 #define OPAL_FLASH_UPDATE			78
@@ -727,6 +732,11 @@ int64_t opal_lpc_write(uint32_t chip_id, enum OpalLPCAddressType addr_type,
 		       uint32_t addr, uint32_t data, uint32_t sz);
 int64_t opal_lpc_read(uint32_t chip_id, enum OpalLPCAddressType addr_type,
 		      uint32_t addr, uint32_t *data, uint32_t sz);
+int64_t opal_read_elog(uint64_t buffer, size_t size, uint64_t log_id);
+int64_t opal_get_elog_size(uint64_t *log_id, size_t *size, uint64_t *elog_type);
+int64_t opal_write_elog(uint64_t buffer, uint64_t size, uint64_t offset);
+int64_t opal_send_ack_elog(uint64_t log_id);
+void opal_resend_pending_logs(void);
 int64_t opal_validate_flash(uint64_t buffer, uint32_t *size, uint32_t *result);
 int64_t opal_manage_flash(uint8_t op);
 int64_t opal_update_flash(uint64_t blk_list);
@@ -761,6 +771,7 @@ extern void opal_get_rtc_time(struct rtc_time *tm);
 extern unsigned long opal_get_boot_time(void);
 extern void opal_nvram_init(void);
 extern void opal_flash_init(void);
+extern int opal_elog_init(void);
 
 extern int opal_machine_check(struct pt_regs *regs);
 extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 873fa13..0f692eb 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,6 +1,6 @@
 obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
-obj-y			+= rng.o
+obj-y			+= rng.o opal-elog.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
new file mode 100644
index 0000000..fc891ae
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -0,0 +1,309 @@
+/*
+ * Error log support on PowerNV.
+ *
+ * Copyright 2013 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/fs.h>
+#include <linux/vmalloc.h>
+#include <linux/fcntl.h>
+#include <asm/uaccess.h>
+#include <asm/opal.h>
+
+/* Maximum size of a single log on FSP is 16KB */
+#define OPAL_MAX_ERRLOG_SIZE	16384
+
+/* maximu number of records powernv can hold */
+#define MAX_NUM_RECORD	128
+
+struct opal_err_log {
+	struct list_head link;
+	uint64_t opal_log_id;
+	size_t opal_log_size;
+	uint8_t data[OPAL_MAX_ERRLOG_SIZE];
+};
+
+/* Pre-allocated temp buffer to pull error log from opal. */
+static uint8_t err_log_data[OPAL_MAX_ERRLOG_SIZE];
+/* Protect err_log_data buf */
+static DEFINE_MUTEX(err_log_data_mutex);
+
+static uint64_t total_log_size;
+static bool opal_log_available;
+static LIST_HEAD(elog_list);
+static LIST_HEAD(elog_ack_list);
+
+/* lock to protect elog_list and elog-ack_list. */
+static DEFINE_SPINLOCK(opal_elog_lock);
+
+static DECLARE_WAIT_QUEUE_HEAD(opal_log_wait);
+
+/*
+ * Interface for user to acknowledge the error log.
+ *
+ * Once user acknowledge the log, we delete that record entry from the
+ * list and move it ack list.
+ */
+void opal_elog_ack(uint64_t ack_id)
+{
+	unsigned long flags;
+	struct opal_err_log *record, *next;
+	bool found = false;
+
+	printk(KERN_INFO "OPAL Log ACK=%llx", ack_id);
+
+	/* once user acknowledge a log delete record from list */
+	spin_lock_irqsave(&opal_elog_lock, flags);
+	list_for_each_entry_safe(record, next, &elog_list, link) {
+		if (ack_id == record->opal_log_id) {
+			list_del(&record->link);
+			list_add(&record->link, &elog_ack_list);
+			total_log_size -= OPAL_MAX_ERRLOG_SIZE;
+			found = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&opal_elog_lock, flags);
+
+	/* Send acknowledgement to FSP */
+	if (found)
+		opal_send_ack_elog(ack_id);
+	return;
+}
+
+
+static ssize_t elog_ack_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	uint32_t log_ack_id;
+	log_ack_id = *(uint32_t *) buf;
+
+	/* send acknowledgment to FSP */
+	opal_elog_ack(log_ack_id);
+	return 0;
+}
+
+/*
+ * Show error log records to user.
+ */
+static ssize_t opal_elog_show(struct file *filp, struct kobject *kobj,
+				struct bin_attribute *bin_attr, char *buf,
+				loff_t pos, size_t count)
+{
+	unsigned long flags;
+	struct opal_err_log *record, *next;
+	size_t size = 0;
+	size_t data_to_copy = 0;
+	int error = 0;
+
+	/* Display one log at a time. */
+	if (count > OPAL_MAX_ERRLOG_SIZE)
+		count = OPAL_MAX_ERRLOG_SIZE;
+
+	spin_lock_irqsave(&opal_elog_lock, flags);
+	/* Align the pos to point within total errlog size. */
+	if (total_log_size && pos > total_log_size)
+		pos = pos % total_log_size;
+
+	/*
+	 * if pos goes beyond total_log_size then we know we don't have any
+	 * new record to show.
+	 */
+	if (total_log_size == 0 || pos >= total_log_size) {
+		opal_log_available = 0;
+		if (filp->f_flags & O_NONBLOCK) {
+			spin_unlock_irqrestore(&opal_elog_lock, flags);
+			error = -EAGAIN;
+			goto out;
+		}
+		spin_unlock_irqrestore(&opal_elog_lock, flags);
+		pos = 0;
+
+		/* Wait until we get log from sapphire */
+		error = wait_event_interruptible(opal_log_wait,
+						 opal_log_available);
+		if (error)
+			goto out;
+		spin_lock_irqsave(&opal_elog_lock, flags);
+	}
+
+	/*
+	 * Show log record one by one through /sys/firmware/opal/opal_elog
+	 */
+	list_for_each_entry_safe(record, next, &elog_list, link) {
+		if ((pos >= size) && (pos < (size + OPAL_MAX_ERRLOG_SIZE))) {
+			data_to_copy = OPAL_MAX_ERRLOG_SIZE - (pos - size);
+			if (count > data_to_copy)
+				count = data_to_copy;
+			memcpy(buf, record->data + (pos - size), count);
+			error = count;
+			break;
+		}
+		size += OPAL_MAX_ERRLOG_SIZE;
+	}
+	spin_unlock_irqrestore(&opal_elog_lock, flags);
+out:
+	return error;
+}
+
+/* Interface to read log from OPAL */
+static void opal_elog_read(void)
+{
+	struct opal_err_log *record;
+	size_t elog_size;
+	uint64_t log_id;
+	uint64_t elog_type;
+
+	unsigned long flags;
+	int rc = 0;
+
+	spin_lock_irqsave(&opal_elog_lock, flags);
+	if (list_empty(&elog_ack_list)) {
+		/*
+		 * We have no more room to read logs. Ignore it for now,
+		 * will read it later when we have enough space.
+		 */
+		spin_unlock_irqrestore(&opal_elog_lock, flags);
+		return;
+	}
+
+	/* Pull out the free node. */
+	record = list_entry(elog_ack_list.next, struct opal_err_log, link);
+	list_del(&record->link);
+	spin_unlock_irqrestore(&opal_elog_lock, flags);
+
+	/* read log size and log ID from OPAL */
+	rc = opal_get_elog_size(&log_id, &elog_size, &elog_type);
+	if (rc != OPAL_SUCCESS) {
+		pr_err("ELOG: Opal log read failed\n");
+		return;
+	}
+	if (elog_size >= OPAL_MAX_ERRLOG_SIZE)
+		elog_size  =  OPAL_MAX_ERRLOG_SIZE;
+
+	record->opal_log_id = log_id;
+	record->opal_log_size = elog_size;
+	memset(record->data, 0, sizeof(record->data));
+
+	mutex_lock(&err_log_data_mutex);
+	rc = opal_read_elog(__pa(err_log_data), elog_size, log_id);
+	if (rc != OPAL_SUCCESS) {
+		mutex_unlock(&err_log_data_mutex);
+		pr_err("ELOG: log read failed for log-id=%llx\n", log_id);
+		/* put back the free node. */
+		spin_lock_irqsave(&opal_elog_lock, flags);
+		list_add(&record->link, &elog_ack_list);
+		spin_unlock_irqrestore(&opal_elog_lock, flags);
+		return;
+	}
+	memcpy(record->data, err_log_data, elog_size);
+	mutex_unlock(&err_log_data_mutex);
+
+	spin_lock_irqsave(&opal_elog_lock, flags);
+	list_add_tail(&record->link, &elog_list);
+	total_log_size += OPAL_MAX_ERRLOG_SIZE;
+	spin_unlock_irqrestore(&opal_elog_lock, flags);
+
+	opal_log_available = 1;
+	wake_up_interruptible(&opal_log_wait);
+	return;
+}
+
+static void elog_work_fn(struct work_struct *work)
+{
+	opal_elog_read();
+}
+
+static DECLARE_WORK(elog_work, elog_work_fn);
+
+static int elog_event(struct notifier_block *nb,
+				unsigned long events, void *change)
+{
+	/* check for error log event */
+	if (events & OPAL_EVENT_ERROR_LOG_AVAIL)
+		schedule_work(&elog_work);
+	return 0;
+}
+
+/* Initialize sysfs file */
+static struct kobj_attribute opal_elog_ack_attr = __ATTR(opal_elog_ack,
+						0200, NULL, elog_ack_store);
+
+static struct notifier_block elog_nb = {
+	.notifier_call  = elog_event,
+	.next           = NULL,
+	.priority       = 0
+};
+
+static struct bin_attribute opal_elog_attr = {
+	.attr = {.name = "opal_elog", .mode = 0400},
+	.read = opal_elog_show,
+};
+
+/*
+ * Pre-allocate a buffer to hold handful of error logs until user space
+ * consumes it.
+ */
+static int init_err_log_buffer(void)
+{
+	int i = 0;
+	struct opal_err_log *buf_ptr;
+
+	buf_ptr = vmalloc(sizeof(struct opal_err_log) * MAX_NUM_RECORD);
+	if (!buf_ptr) {
+		printk(KERN_ERR "ELOG: failed to allocate memory.\n");
+		return -ENOMEM;
+	}
+	memset(buf_ptr, 0, sizeof(struct opal_err_log) * MAX_NUM_RECORD);
+
+	/* Initialize ack list will all free nodes. */
+	for (i = 0; i < MAX_NUM_RECORD; i++, buf_ptr++)
+		list_add(&buf_ptr->link, &elog_ack_list);
+	return 0;
+}
+
+/* Initialize error logging */
+int __init opal_elog_init(void)
+{
+	int rc = 0;
+
+	rc = init_err_log_buffer();
+	if (rc)
+		return rc;
+
+	rc = sysfs_create_bin_file(opal_kobj, &opal_elog_attr);
+	if (rc) {
+		printk(KERN_ERR "ELOG: unable to create sysfs file"
+					"opal_elog (%d)\n", rc);
+		return rc;
+	}
+
+	rc = sysfs_create_file(opal_kobj, &opal_elog_ack_attr.attr);
+	if (rc) {
+		printk(KERN_ERR "ELOG: unable to create sysfs file"
+			" opal_elog_ack (%d)\n", rc);
+		return rc;
+	}
+
+	rc = opal_notifier_register(&elog_nb);
+	if (rc) {
+		pr_err("%s: Can't register OPAL event notifier (%d)\n",
+		__func__, rc);
+		return rc;
+	}
+
+	/* We are now ready to pull error logs from opal. */
+	opal_resend_pending_logs();
+
+	return 0;
+}
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index e780650..a040b02 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -123,6 +123,11 @@ OPAL_CALL(opal_xscom_write,			OPAL_XSCOM_WRITE);
 OPAL_CALL(opal_lpc_read,			OPAL_LPC_READ);
 OPAL_CALL(opal_lpc_write,			OPAL_LPC_WRITE);
 OPAL_CALL(opal_return_cpu,			OPAL_RETURN_CPU);
+OPAL_CALL(opal_read_elog,			OPAL_ELOG_READ);
+OPAL_CALL(opal_send_ack_elog,			OPAL_ELOG_ACK);
+OPAL_CALL(opal_get_elog_size,			OPAL_ELOG_SIZE);
+OPAL_CALL(opal_resend_pending_logs,		OPAL_ELOG_RESEND);
+OPAL_CALL(opal_write_elog,			OPAL_ELOG_WRITE);
 OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
 OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
 OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 31053be..20e1834 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -475,6 +475,8 @@ static int __init opal_init(void)
 	/* Create "opal" kobject under /sys/firmware */
 	rc = opal_sysfs_init();
 	if (rc == 0) {
+		/* Setup error log interface */
+		rc = opal_elog_init();
 		/* Setup code update interface */
 		opal_flash_init();
 	}
