Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA2691A1634
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 20:23:37 +1000 (EST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 669B714009C
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2014 20:23:37 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 29 Sep 2014 20:23:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 928322BB0051
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2014 20:23:33 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8TAPLfr34275536
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2014 20:25:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8TANWZD029729
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2014 20:23:32 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc, powernv: Add OPAL platform event driver
Date: Mon, 29 Sep 2014 15:53:29 +0530
Message-Id: <1411986209-16800-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch creates a new OPAL platform event character driver
which will give userspace clients the access to these events
and process them effectively. Following platforms events are
currently supported with this platform driver.

	(1) Environmental and Power Warning (EPOW)
	(2) Delayed Power Off (DPO)

The user interface for this driver is /dev/opal_event character
device file where the user space clients can poll and read for
new opal platform events. The expected sequence of events driven
from user space should be like the following.

	(1) Open the character device file
	(2) Poll on the file for POLLIN event
	(3) When unblocked, must attempt to read PLAT_EVENT_MAX_SIZE size
	(4) Kernel driver will pass at most one opal_plat_event structure
	(5) Poll again for more new events

The driver registers for OPAL messages notifications corresponding to
individual OPAL events. When any of those event messages arrive in the
kernel, the callbacks are called to process them which in turn unblocks
the polling thread on the character device file. The driver also registers
a timer function which will be called after a threshold amount of time to
shutdown the system. The user space client receives the timeout value for
all individual OPAL platform events and hence must prepare the system and
eventually shutdown. In case the user client does not shutdown the system,
the timer function will be called after the threshold and shutdown the
system explicitly.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                    |  45 +-
 .../include/uapi/asm/opal_platform_events.h        |  90 +++
 arch/powerpc/platforms/powernv/Makefile            |   2 +-
 .../platforms/powernv/opal-platform-events.c       | 737 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
 arch/powerpc/platforms/powernv/opal.c              |   8 +-
 6 files changed, 880 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/opal_platform_events.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-platform-events.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 86055e5..c134137 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -151,6 +151,7 @@ struct opal_sg_list {
 #define OPAL_HANDLE_HMI				98
 #define OPAL_REGISTER_DUMP_REGION		101
 #define OPAL_UNREGISTER_DUMP_REGION		102
+#define OPAL_GET_DPO_STATUS			105
 
 #ifndef __ASSEMBLY__
 
@@ -249,6 +250,7 @@ enum OpalMessageType {
 	OPAL_MSG_EPOW,
 	OPAL_MSG_SHUTDOWN,
 	OPAL_MSG_HMI_EVT,
+	OPAL_MSG_DPO,
 	OPAL_MSG_TYPE_MAX,
 };
 
@@ -417,6 +419,46 @@ struct opal_msg {
 	__be64 params[8];
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
 struct opal_machine_check_event {
 	enum OpalMCE_Version	version:8;	/* 0x00 */
 	uint8_t			in_use;		/* 0x01 */
@@ -881,7 +923,7 @@ int64_t opal_pci_fence_phb(uint64_t phb_id);
 int64_t opal_pci_reinit(uint64_t phb_id, uint64_t reinit_scope, uint64_t data);
 int64_t opal_pci_mask_pe_error(uint64_t phb_id, uint16_t pe_number, uint8_t error_type, uint8_t mask_action);
 int64_t opal_set_slot_led_status(uint64_t phb_id, uint64_t slot_id, uint8_t led_type, uint8_t led_action);
-int64_t opal_get_epow_status(__be64 *status);
+int64_t opal_get_epow_status(uint16_t *status, uint16_t *length);
 int64_t opal_set_system_attention_led(uint8_t led_action);
 int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
 			    __be16 *pci_error_type, __be16 *severity);
@@ -924,6 +966,7 @@ int64_t opal_sensor_read(uint32_t sensor_hndl, int token, __be32 *sensor_data);
 int64_t opal_handle_hmi(void);
 int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
 int64_t opal_unregister_dump_region(uint32_t id);
+int64_t opal_get_dpo_status(int64_t *dpo_timeout);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/uapi/asm/opal_platform_events.h b/arch/powerpc/include/uapi/asm/opal_platform_events.h
new file mode 100644
index 0000000..6d2e13e
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/opal_platform_events.h
@@ -0,0 +1,90 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright IBM Corp. 2014
+ *
+ * Author: Anshuman Khandual <khandual@linux.vnet.ibm.com>
+ */
+#ifndef __LINUX_OPAL_PLATFORM_EVENTS_H
+#define __LINUX_OPAL_PLATFORM_EVENTS_H
+
+#include <linux/types.h>
+
+/* EPOW classification */
+enum epow_condition {
+	EPOW_SYSPOWER_CHNG	= 0,	/* Power */
+	EPOW_SYSPOWER_FAIL	= 1,
+	EPOW_SYSPOWER_INCL	= 2,
+	EPOW_SYSPOWER_UPS	= 3,
+	EPOW_SYSTEMP_AMB	= 4,	/* Temperature */
+	EPOW_SYSTEMP_INT	= 5,
+	EPOW_SYSTEMP_HMD	= 6,
+	EPOW_SYSCOOL_INSF	= 7,	/* Cooling */
+	EPOW_MAX = 8,
+};
+
+/* OPAL EPOW event */
+struct epow_event {
+	__u64	epow[EPOW_MAX];		/* Detailed system EPOW status */
+	__u64	timeout;		/* Timeout to shutdown in secs */
+};
+
+/* OPAL DPO event */
+struct dpo_event {
+	__u64	orig_timeout;		/* Platform provided timeout in secs */
+	__u64	remain_timeout;		/* Timeout to shutdown in secs */
+};
+
+/* OPAL event */
+struct opal_plat_event {
+	__u32	type;			/* Type of OPAL platform event */
+#define OPAL_PLAT_EVENT_TYPE_EPOW	0
+#define OPAL_PLAT_EVENT_TYPE_DPO	1
+#define OPAL_PLAT_EVENT_TYPE_MAX	2
+	__u32	size;			/* Size of OPAL platform event */
+	union {
+		struct epow_event epow;	/* EPOW platform event */
+		struct dpo_event  dpo;	/* DPO platform event */
+	};
+};
+
+/*
+ * Suggested read size
+ *
+ * The user space client should attempt to read OPAL_PLAT_EVENT_READ_SIZE
+ * amount of data from the character device file '/dev/opal_event' at any
+ * point of time. The kernel driver will pass an entire opal_plat_event
+ * structure in every read. This ensures that minium data the user space
+ * client gets from the kernel is one opal_plat_event structure.
+ */
+#define	PLAT_EVENT_MAX_SIZE	4096
+
+/*
+ * Suggested user operation
+ *
+ * The user space client must follow these steps in order to be able to
+ * exploit the features exported through the OPAL platform event driver.
+ *
+ *	(1) Open the character device file
+ *	(2) Poll on the file for POLLIN
+ *	(3) When unblocked, must attempt to read PLAT_EVENT_MAX_SIZE size
+ *	(4) Kernel driver will pass one opal_plat_event structure
+ *	(5) Poll again for more new events
+ *
+ * The character device file (/dev/opal_event) must be opened and operated by
+ * only one user space client at any point of time. Other attempts to open the
+ * file will be returned by the driver as EBUSY.
+ */
+
+#endif /* __LINUX_OPAL_PLATFORM_EVENTS_H */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index f241acc..c4b3b9b 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,7 +1,7 @@
 obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
-obj-y			+= opal-msglog.o opal-hmi.o
+obj-y			+= opal-msglog.o opal-hmi.o opal-platform-events.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
diff --git a/arch/powerpc/platforms/powernv/opal-platform-events.c b/arch/powerpc/platforms/powernv/opal-platform-events.c
new file mode 100644
index 0000000..5e87d2b
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-platform-events.c
@@ -0,0 +1,737 @@
+/*
+ * IBM PowerNV OPAL platform events driver
+ *
+ * Copyright IBM Corporation 2014
+ *
+ * Author: Anshuman Khandual <khandual@linux.vnet.ibm.com>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#define PREFIX		"OPAL_EVENT"
+#define pr_fmt(fmt)	PREFIX ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/cdev.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/timer.h>
+#include <linux/reboot.h>
+#include <asm/uaccess.h>
+#include <asm/opal.h>
+#include <asm/opal_platform_events.h>
+
+/* Platform events driver */
+static dev_t opal_event_dev;
+static struct cdev opal_event_cdev;
+static struct class *opal_event_class;
+static bool opal_event_open_flag;
+
+#define OPAL_EVENT_MAX_DEVS	1
+
+/* Platform events timers */
+static struct timer_list opal_event_timer;
+
+static DECLARE_WAIT_QUEUE_HEAD(opal_plat_evt_wait);
+static DECLARE_WAIT_QUEUE_HEAD(opal_plat_open_wait);
+static DEFINE_SPINLOCK(opal_plat_evt_spinlock);
+static DEFINE_SPINLOCK(opal_plat_timer_spinlock);
+static DEFINE_MUTEX(opal_plat_evt_mutex);
+
+/*
+ * Platform timeout values
+ *
+ * XXX: The default timeout value is 5 minutes. In future this
+ * should be communicated from the platform firmware through
+ * device tree attributes.
+ */
+#define OPAL_EPOW_TIMEOUT	300
+
+struct opal_platform_evt {
+	struct opal_plat_event opal_event;
+	struct list_head link;
+};
+static LIST_HEAD(opal_event_queue);
+static unsigned long opal_dpo_target;
+static bool opal_event_probe_finished;
+
+/*
+ * OPAL event map
+ *
+ * Converts OPAL event type into it's description.
+ */
+static const char *opal_event_map[OPAL_PLAT_EVENT_TYPE_MAX] = {
+	"OPAL_PLAT_EVENT_TYPE_EPOW", "OPAL_PLAT_EVENT_TYPE_DPO"
+};
+
+/*
+ * opal_event_timeout
+ *
+ * This is the actual timer handler. If the any of the timers
+ * expire, this function will be called to shutdown the system
+ * gracefully.
+ */
+static void opal_event_timeout(unsigned long data)
+{
+	orderly_poweroff(1);
+}
+
+/*
+ * opal_event_start_timer
+ *
+ * This will start opal event timer with given timeout value as the expiry
+ * if either the timer is not active or the expiry value of the already
+ * activated timer is at a later point of time in the future compared to the
+ * timeout value for this given new event. The function mod_timer takes care
+ * all the cases whether the opal event timer is already active or not.
+ */
+static void opal_event_start_timer(unsigned long event, u64 timeout)
+{
+	unsigned long flags;
+
+	/* Timer active with earlier timeout */
+	spin_lock_irqsave(&opal_plat_timer_spinlock, flags);
+	if (timer_pending(&opal_event_timer) &&
+			(opal_event_timer.expires < (jiffies + timeout * HZ))) {
+		spin_unlock_irqrestore(&opal_plat_timer_spinlock, flags);
+		pr_info("Timer for %s event active with an earlier timeout\n",
+					opal_event_map[opal_event_timer.data]);
+		return;
+	}
+	opal_event_timer.data = event;
+	mod_timer(&opal_event_timer, jiffies + timeout * HZ);
+	spin_unlock_irqrestore(&opal_plat_timer_spinlock, flags);
+	pr_info("Timer activated for %s event\n", opal_event_map[event]);
+}
+
+/*
+ * opal_event_stop_timer
+ *
+ * This will attempt to stop opal_event_timer if it is already enabled.
+ */
+static void opal_event_stop_timer(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&opal_plat_timer_spinlock, flags);
+	del_timer_sync(&opal_event_timer);
+	spin_unlock_irqrestore(&opal_plat_timer_spinlock, flags);
+	pr_info("Timer deactivated\n");
+}
+
+/*
+ * opal_event_read
+ *
+ * User client needs to attempt to read PLAT_EVENT_MAX_SIZE amount of data
+ * from the file descriptor at a time. The driver will pass a single node
+ * from the list if available at a time and then delete the node from the list.
+ */
+static ssize_t opal_event_read(struct file *filep,
+			char __user *buf, size_t len, loff_t *off)
+{
+	struct opal_platform_evt *evt;
+	unsigned long flags;
+
+	if (len < sizeof(struct opal_plat_event))
+		return -EINVAL;
+
+	/* Fetch the first node on the list */
+	spin_lock_irqsave(&opal_plat_evt_spinlock, flags);
+	if (list_empty(&opal_event_queue)) {
+		spin_unlock_irqrestore(&opal_plat_evt_spinlock, flags);
+		return 0;
+	}
+
+	/* Fetch and delete from the list */
+	evt = list_first_entry(&opal_event_queue,
+					struct opal_platform_evt, link);
+	list_del(&evt->link);
+
+	/*
+	 * Update the remaining timeout for DPO event.
+	 * This can only be updated during the read time.
+	 */
+	if (evt->opal_event.type == OPAL_PLAT_EVENT_TYPE_DPO) {
+		unsigned long timeout;
+
+		if (opal_dpo_target &&
+				evt->opal_event.dpo.orig_timeout) {
+			timeout = (opal_dpo_target - jiffies) / HZ;
+			evt->opal_event.dpo.remain_timeout = timeout;
+		}
+	}
+	spin_unlock_irqrestore(&opal_plat_evt_spinlock, flags);
+
+	if (copy_to_user(buf, &evt->opal_event,
+		sizeof(struct opal_plat_event))) {
+
+		/*
+		 * Copy to user has failed. The event node had
+		 * been deleted from the list. Lets add it back
+		 * there.
+		 */
+		spin_lock_irqsave(&opal_plat_evt_spinlock, flags);
+		list_add_tail(&evt->link, &opal_event_queue);
+		spin_unlock_irqrestore(&opal_plat_evt_spinlock, flags);
+		return -EFAULT;
+	}
+
+	kfree(evt);
+	return sizeof(struct opal_plat_event);
+}
+
+/*
+ * opal_event_poll
+ *
+ * Poll is unblocked right away with POLLIN when data is available.
+ * When data is not available, the process will have to block till
+ * it gets waked up and data is available to read.
+ */
+static unsigned int opal_event_poll(struct file *file, poll_table *wait)
+{
+	poll_wait(file, &opal_plat_evt_wait, wait);
+	if (!list_empty(&opal_event_queue))
+		return POLLIN;
+	return 0;
+}
+
+/*
+ * opal_event_open
+ *
+ * This makes sure that only one process can open the
+ * character device file at any point of time. Others
+ * attempting to open the file descriptor will either
+ * get EBUSY (with O_NONBLOCK flag) or wait for the
+ * other process to close the file descriptor.
+ */
+static int opal_event_open(struct inode *inode, struct file *file)
+{
+	int err;
+
+	mutex_lock(&opal_plat_evt_mutex);
+	while (opal_event_open_flag) {
+		mutex_unlock(&opal_plat_evt_mutex);
+		if (file->f_flags & O_NONBLOCK)
+			return -EBUSY;
+		err = wait_event_interruptible(opal_plat_open_wait,
+							!opal_event_open_flag);
+		if (err)
+			return -ERESTARTSYS;
+		mutex_lock(&opal_plat_evt_mutex);
+	}
+	opal_event_open_flag = true;
+	mutex_unlock(&opal_plat_evt_mutex);
+	return 0;
+}
+
+/*
+ * opal_event_release
+ *
+ * Releases the file descriptor for the device file.
+ */
+static int opal_event_release(struct inode *inode, struct file *file)
+{
+	mutex_lock(&opal_plat_evt_mutex);
+	if (opal_event_open_flag) {
+		opal_event_open_flag = false;
+		wake_up_interruptible(&opal_plat_open_wait);
+	}
+	mutex_unlock(&opal_plat_evt_mutex);
+	return 0;
+}
+
+/* Defined file operation */
+static const struct file_operations fops = {
+	.owner	= THIS_MODULE,
+	.open		= opal_event_open,
+	.release	= opal_event_release,
+	.read		= opal_event_read,
+	.poll		= opal_event_poll,
+};
+
+/* Process the received EPOW information */
+void process_epow(__u64 *epow, int16_t *epow_status, int max_epow_class)
+{
+	/*
+	 * Platform might have returned less number of EPOW
+	 * subclass status than asked for. This situation
+	 * happens when the platform firmware is older compared
+	 * to the kernel.
+	 */
+
+	if (!max_epow_class) {
+		pr_warn("EPOW: OPAL_SYSEPOW_POWER subclass not present\n");
+		return;
+	}
+
+	/* Power */
+	max_epow_class--;
+	if (epow_status[OPAL_SYSEPOW_POWER] & OPAL_SYSPOWER_CHNG) {
+		pr_info("EPOW: Power configuration changed\n");
+		epow[EPOW_SYSPOWER_CHNG] = 1;
+	}
+
+	if (epow_status[OPAL_SYSEPOW_POWER] & OPAL_SYSPOWER_FAIL) {
+		pr_info("EPOW: Impending system power failure\n");
+		epow[EPOW_SYSPOWER_FAIL] = 1;
+	}
+
+	if (epow_status[OPAL_SYSEPOW_POWER] & OPAL_SYSPOWER_INCL) {
+		pr_info("EPOW: Incomplete system power\n");
+		epow[EPOW_SYSPOWER_INCL] = 1;
+	}
+
+	if (epow_status[OPAL_SYSEPOW_POWER] & OPAL_SYSPOWER_UPS) {
+		pr_info("EPOW: System on UPS power\n");
+		epow[EPOW_SYSPOWER_UPS] = 1;
+	}
+
+	if (!max_epow_class) {
+		pr_warn("EPOW: OPAL_SYSEPOW_TEMP subclass not present\n");
+		return;
+	}
+
+	/* Temperature */
+	max_epow_class--;
+	if (epow_status[OPAL_SYSEPOW_TEMP] & OPAL_SYSTEMP_AMB) {
+		pr_info("EPOW: Over ambient temperature\n");
+		epow[EPOW_SYSTEMP_AMB] = 1;
+	}
+
+	if (epow_status[OPAL_SYSEPOW_TEMP] & OPAL_SYSTEMP_INT) {
+		pr_info("EPOW: Over internal temperature\n");
+		epow[EPOW_SYSTEMP_INT] = 1;
+	}
+
+	if (epow_status[OPAL_SYSEPOW_TEMP] & OPAL_SYSTEMP_HMD) {
+		pr_info("EPOW: Over internal humidity\n");
+		epow[EPOW_SYSTEMP_HMD] = 1;
+	}
+
+	if (!max_epow_class) {
+		pr_warn("EPOW: OPAL_SYSEPOW_COOLING subclass not present\n");
+		return;
+	}
+
+	/* Cooling */
+	max_epow_class--;
+	if (epow_status[OPAL_SYSEPOW_COOLING] & OPAL_SYSCOOL_INSF) {
+		pr_info("EPOW: Insufficient cooling\n");
+		epow[EPOW_SYSCOOL_INSF] = 1;
+	}
+}
+
+/*
+ * fetch_epow_status
+ *
+ * Fetch the system EPOW status through an OPAL call and
+ * validate the number of EPOW sub class status received.
+ */
+static void fetch_epow_status(int16_t *epow_status, int16_t *n_epow)
+{
+	int rc;
+
+	memset(epow_status, 0, sizeof(int16_t) * OPAL_SYSEPOW_MAX);
+	*n_epow = OPAL_SYSEPOW_MAX;
+	rc = opal_get_epow_status(epow_status, n_epow);
+	if (rc != OPAL_SUCCESS) {
+		pr_err("EPOW: OPAL call failed\n");
+		memset(epow_status, 0, sizeof(int16_t) * OPAL_SYSEPOW_MAX);
+		*n_epow = 0;
+		return;
+	}
+	if (!(*n_epow))
+		pr_err("EPOW: No subclass status received\n");
+}
+
+/*
+ * fetch_dpo_timeout
+ *
+ * Fetch the system DPO timeout status through an OPAL call.
+ */
+static void fetch_dpo_timeout(int64_t *dpo_timeout)
+{
+	int rc;
+
+	rc = opal_get_dpo_status(dpo_timeout);
+	if (rc != OPAL_SUCCESS) {
+		pr_err("DPO: OPAL call failed\n");
+		*dpo_timeout = 0;
+		return;
+	}
+}
+
+/*
+ * valid_epow
+ *
+ * Validate the received EPOW event status. This ensures
+ * that there are valid status for various EPOW sub classes
+ * and their individual events.
+ */
+static bool valid_epow(int16_t *epow_status, int16_t n_epow)
+{
+	int i;
+
+	/* EPOW sub classes present */
+	if (!n_epow)
+		return false;
+
+	/* EPOW events present */
+	for (i = 0; i < n_epow; i++) {
+		if (epow_status[i])
+			return true;
+	}
+	return false;
+}
+
+/*
+ * epow_exclude
+ *
+ * XXX: EPOW events on the action exclude list. System shutdown
+ * would not be scheduled for all these platform events. In future
+ * this should be communicated from the platform firmware through
+ * device tree attributes.
+ */
+static bool epow_exclude(int epow_event)
+{
+	switch (epow_event) {
+	case EPOW_SYSPOWER_CHNG:
+		return true;
+	case EPOW_SYSPOWER_INCL:
+		return true;
+	case EPOW_SYSPOWER_UPS:
+		return true;
+	case EPOW_SYSTEMP_HMD:
+		return true;
+	case EPOW_SYSCOOL_INSF:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * actionable_epow
+ *
+ * There are some EPOW events for which the user client must receive
+ * their status but the driver would not schedule a timer for that
+ * event as the platform would not force shutdown the system because
+ * of this event. This filters only the actionable EPOW events for
+ * which shutdown timer need to be scheduled.
+ */
+static bool actionable_epow(__u64 *epow)
+{
+	int i;
+
+	for (i = 0; i < EPOW_MAX; i++) {
+		if (!epow_exclude(i) && epow[i])
+			return true;
+	}
+	return false;
+}
+
+/*
+ * opal_event_handle_basic
+ *
+ * Sets up the basic information for an opal platform event,
+ * activates the timer, adds to the list and wakes up waiting
+ * threads on the character device.
+ */
+static void opal_event_handle_basic(struct opal_platform_evt *evt,
+				unsigned long type, unsigned long timeout)
+{
+	unsigned long flags;
+
+	evt->opal_event.type = type;
+	switch (type) {
+	case OPAL_PLAT_EVENT_TYPE_EPOW:
+		evt->opal_event.size = sizeof(struct epow_event);
+		evt->opal_event.epow.timeout = timeout;
+		if (actionable_epow(evt->opal_event.epow.epow))
+			opal_event_start_timer(OPAL_PLAT_EVENT_TYPE_EPOW,
+							OPAL_EPOW_TIMEOUT);
+		break;
+	case  OPAL_PLAT_EVENT_TYPE_DPO:
+		evt->opal_event.size = sizeof(struct dpo_event);
+		evt->opal_event.dpo.orig_timeout = timeout;
+		opal_event_start_timer(OPAL_PLAT_EVENT_TYPE_DPO, timeout);
+		break;
+	default:
+		pr_err("Unknown event type\n");
+		break;
+	}
+	spin_lock_irqsave(&opal_plat_evt_spinlock, flags);
+	list_add_tail(&evt->link, &opal_event_queue);
+	spin_unlock_irqrestore(&opal_plat_evt_spinlock, flags);
+	wake_up_interruptible(&opal_plat_evt_wait);
+}
+
+/*
+ * opal_event_existing_status
+ *
+ * Fetch and process existing opal platform event conditions
+ * present on the system. If events detected, add them to the
+ * list which can be consumed by the user space right away.
+ */
+static void opal_event_existing_status(void)
+{
+	struct opal_platform_evt *evt;
+	int64_t dpo_timeout;
+	int16_t	epow_status[OPAL_SYSEPOW_MAX], n_epow;
+
+	fetch_epow_status(epow_status, &n_epow);
+	if (valid_epow(epow_status, n_epow)) {
+		evt = kzalloc(sizeof(struct opal_platform_evt), GFP_KERNEL);
+		if (!evt) {
+			pr_err("EPOW: Memory allocation for event failed\n");
+			return;
+		}
+		process_epow(evt->opal_event.epow.epow, epow_status, n_epow);
+		opal_event_handle_basic(evt, OPAL_PLAT_EVENT_TYPE_EPOW,
+							OPAL_EPOW_TIMEOUT);
+	}
+
+	fetch_dpo_timeout(&dpo_timeout);
+	if (dpo_timeout) {
+		evt = kzalloc(sizeof(struct opal_platform_evt), GFP_KERNEL);
+		if (!evt) {
+			pr_err("DPO: Memory allocation for event failed\n");
+			return;
+		}
+		opal_dpo_target = jiffies + dpo_timeout * HZ;
+		opal_event_handle_basic(evt, OPAL_PLAT_EVENT_TYPE_DPO,
+								dpo_timeout);
+	}
+}
+
+/* Platform EPOW message received */
+static int opal_epow_event(struct notifier_block *nb,
+				unsigned long msg_type, void *msg)
+{
+	struct opal_platform_evt *evt;
+	int16_t	epow_status[OPAL_SYSEPOW_MAX], n_epow;
+
+	if (msg_type != OPAL_MSG_EPOW)
+		return 0;
+
+	fetch_epow_status(epow_status, &n_epow);
+	if (!valid_epow(epow_status, n_epow))
+		return -EINVAL;
+
+	pr_debug("EPOW event: Power(%x) Thermal(%x) Cooling(%x)\n",
+			epow_status[0], epow_status[1], epow_status[2]);
+	evt = kzalloc(sizeof(struct opal_platform_evt), GFP_KERNEL);
+	if (!evt) {
+		pr_err("EPOW: Memory allocation for event failed\n");
+		return -ENOMEM;
+	}
+	process_epow(evt->opal_event.epow.epow, epow_status, n_epow);
+	opal_event_handle_basic(evt,
+				OPAL_PLAT_EVENT_TYPE_EPOW, OPAL_EPOW_TIMEOUT);
+	return 0;
+}
+
+/* Platform DPO message received */
+static int opal_dpo_event(struct notifier_block *nb,
+				unsigned long msg_type, void *msg)
+{
+	struct opal_platform_evt *evt;
+	int64_t dpo_timeout;
+
+	if (msg_type != OPAL_MSG_DPO)
+		return 0;
+
+	fetch_dpo_timeout(&dpo_timeout);
+	if (!dpo_timeout)
+		return -EINVAL;
+
+	pr_debug("DPO event: Timeout:%llu\n", dpo_timeout);
+	evt = kzalloc(sizeof(struct opal_platform_evt), GFP_KERNEL);
+	if (!evt) {
+		pr_err("DPO: Memory allocation for event failed\n");
+		return -ENOMEM;
+	}
+	opal_dpo_target = jiffies + dpo_timeout * HZ;
+	opal_event_handle_basic(evt, OPAL_PLAT_EVENT_TYPE_DPO, dpo_timeout);
+	return 0;
+}
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
+/* Platform driver probe */
+static int opal_event_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+	int ret;
+
+	if (opal_event_probe_finished) {
+		pr_err("%s getting called once again\n", __func__);
+		return 0;
+	}
+	opal_event_probe_finished = true;
+
+	init_timer(&opal_event_timer);
+	opal_event_timer.function = opal_event_timeout;
+	opal_event_open_flag = false;
+	opal_dpo_target = 0;
+
+	ret = alloc_chrdev_region(&opal_event_dev, 0,
+					OPAL_EVENT_MAX_DEVS, "opal_event");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "aloc_chrdev_region failed\n");
+		return ret;
+	}
+
+	opal_event_class = class_create(THIS_MODULE, "opal_event");
+	if (IS_ERR(opal_event_class)) {
+		ret = PTR_ERR(opal_event_class);
+		dev_err(&pdev->dev, "class_create failed with %d\n", ret);
+		goto fail_chrdev;
+	}
+
+	dev = device_create(opal_event_class, &pdev->dev,
+					opal_event_dev, NULL, "opal_event");
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		dev_err(&pdev->dev, "device_create failed with %d\n", ret);
+		goto fail_class;
+	}
+
+	cdev_init(&opal_event_cdev, &fops);
+	ret = cdev_add(&opal_event_cdev, opal_event_dev, OPAL_EVENT_MAX_DEVS);
+	if (ret < 0) {
+		dev_err(dev, "cdev_add failed\n");
+		ret = -EINVAL;
+		goto fail_device;
+	}
+
+	ret = opal_message_notifier_register(OPAL_MSG_EPOW, &opal_epow_nb);
+	if (ret) {
+		pr_err("EPOW: Platform event message notifier failed\n");
+		goto fail_cdev;
+	}
+
+	ret = opal_message_notifier_register(OPAL_MSG_DPO, &opal_dpo_nb);
+	if (ret) {
+		pr_err("DPO: Platform event message notifier failed\n");
+		opal_notifier_unregister(&opal_epow_nb);
+		goto fail_cdev;
+	}
+
+	/*
+	 * During the system boot, reboot and kexecs, the host can miss
+	 * some of the EPOW or DPO messages sent from OPAL. This ensures
+	 * that the current status of EPOW or DPO if any, is fetched and
+	 * then updated correctly. The user space needs to first read the
+	 * existing system status before entering into the poll/read loop.
+	 *
+	 */
+	opal_event_existing_status();
+	pr_info("OPAL platform event driver initialized\n");
+	return 0;
+fail_cdev:
+	cdev_del(&opal_event_cdev);
+fail_device:
+	device_destroy(opal_event_class, opal_event_dev);
+fail_class:
+	class_destroy(opal_event_class);
+fail_chrdev:
+	unregister_chrdev_region(opal_event_dev, OPAL_EVENT_MAX_DEVS);
+	return ret;
+}
+
+/* Platform driver remove */
+static int opal_event_remove(struct platform_device *pdev)
+{
+	struct opal_platform_evt *evt;
+
+	/* OPAL notifiers */
+	opal_notifier_unregister(&opal_dpo_nb);
+	opal_notifier_unregister(&opal_epow_nb);
+
+	/* Devices */
+	cdev_del(&opal_event_cdev);
+	device_destroy(opal_event_class, opal_event_dev);
+	class_destroy(opal_event_class);
+	unregister_chrdev_region(opal_event_dev, OPAL_EVENT_MAX_DEVS);
+
+	/* Timers */
+	opal_event_stop_timer();
+
+	/* Flush the list */
+	while (!list_empty(&opal_event_queue)) {
+		evt = list_first_entry(&opal_event_queue,
+					struct opal_platform_evt, link);
+		list_del(&evt->link);
+		kfree(evt);
+	}
+
+	pr_info("OPAL platform event driver exited\n");
+	return 0;
+}
+
+/* Platform driver property match */
+static struct of_device_id opal_event_match[] = {
+	{
+		.compatible	= "ibm,opal-v3-epow",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, opal_event_match);
+
+static struct platform_driver opal_event_driver = {
+	.probe	= opal_event_probe,
+	.remove = opal_event_remove,
+	.driver = {
+		.name = "opal-platform-event-driver",
+		.owner = THIS_MODULE,
+		.of_match_table = opal_event_match,
+	},
+};
+
+static int __init opal_platform_event_init(void)
+{
+	opal_event_probe_finished = false;
+	return platform_driver_register(&opal_event_driver);
+}
+
+static void __exit opal_platform_event_exit(void)
+{
+	platform_driver_unregister(&opal_event_driver);
+}
+module_init(opal_platform_event_init);
+module_exit(opal_platform_event_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Anshuman Khandual <khandual@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("PowerNV OPAL platform events driver");
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 2e6ce1b..2d1dc99 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -247,3 +247,4 @@ OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
 OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
+OPAL_CALL(opal_get_dpo_status,			OPAL_GET_DPO_STATUS);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index b44eec3..869dd45 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -625,7 +625,7 @@ static void __init opal_dump_region_init(void)
 }
 static int __init opal_init(void)
 {
-	struct device_node *np, *consoles;
+	struct device_node *np, *consoles, *epow;
 	const __be32 *irqs;
 	int rc, i, irqlen;
 
@@ -649,6 +649,12 @@ static int __init opal_init(void)
 		of_node_put(consoles);
 	}
 
+	epow = of_find_node_by_path("/ibm,opal/epow");
+	if (epow) {
+		of_platform_device_create(epow, "opal_event", NULL);
+		of_node_put(epow);
+	}
+
 	/* Find all OPAL interrupts and request them */
 	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
 	pr_debug("opal: Found %d interrupts reserved for OPAL\n",
-- 
1.9.3
