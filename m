Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC66D1A0ED2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Feb 2015 18:09:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Fri, 6 Feb 2015 17:09:50 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 781762BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Feb 2015 18:09:48 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1679eLC43581530
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Feb 2015 18:09:48 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1679EHl021338
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Feb 2015 18:09:14 +1100
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V4] powerpc, powernv: Add OPAL platform event driver
Date: Fri,  6 Feb 2015 12:38:42 +0530
Message-Id: <1423206522-18084-1-git-send-email-vipin@linux.vnet.ibm.com>
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
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
	(3) When unblocked, must attempt to read OPAL_PLAT_EVENT_MAX_SIZE size
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

Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V4:
- Used miscdev in place of chardev
- Used module_platform_driver macro for registering platform driver
- Added endianness conversions before and after making OPAL calls
- Changed events data structure in opal_platform_events.h to use bitmask
  for various events in each event class
- Added some info prints
- Added code changes to return remaining time for DPO event for user space query
- Made O_NONBLOCK unsupported for file open call
- Changed actionable_epow function to exclude events and purged epow_exclude function

Changes in V3:
- Rebased the patch against the mainline

Changes in V2:
- Changed the function fetch_dpo_timeout
- Export opal_platform_events.h for user space consumption
- Posted here https://patchwork.ozlabs.org/patch/396725/

Original V1:
- Original patch
- Posted here http://patchwork.ozlabs.org/patch/394340/

 arch/powerpc/include/asm/opal.h                    |  45 +-
 arch/powerpc/include/uapi/asm/Kbuild               |   1 +
 .../include/uapi/asm/opal_platform_events.h        |  90 +++
 arch/powerpc/platforms/powernv/Makefile            |   2 +-
 .../platforms/powernv/opal-platform-events.c       | 663 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
 arch/powerpc/platforms/powernv/opal.c              |   8 +-
 7 files changed, 807 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/opal_platform_events.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-platform-events.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index eb95b67..950839c 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -166,6 +166,7 @@ struct opal_sg_list {
 #define OPAL_UNREGISTER_DUMP_REGION		102
 #define OPAL_WRITE_TPO				103
 #define OPAL_READ_TPO				104
+#define OPAL_GET_DPO_STATUS			105
 #define OPAL_IPMI_SEND				107
 #define OPAL_IPMI_RECV				108
 #define OPAL_I2C_REQUEST			109
@@ -306,6 +307,7 @@ enum OpalMessageType {
 	OPAL_MSG_EPOW,
 	OPAL_MSG_SHUTDOWN,
 	OPAL_MSG_HMI_EVT,
+	OPAL_MSG_DPO,
 	OPAL_MSG_TYPE_MAX,
 };
 
@@ -421,6 +423,46 @@ struct opal_msg {
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
 enum {
 	OPAL_IPMI_MSG_FORMAT_VERSION_1 = 1,
 };
@@ -871,7 +913,7 @@ int64_t opal_pci_fence_phb(uint64_t phb_id);
 int64_t opal_pci_reinit(uint64_t phb_id, uint64_t reinit_scope, uint64_t data);
 int64_t opal_pci_mask_pe_error(uint64_t phb_id, uint16_t pe_number, uint8_t error_type, uint8_t mask_action);
 int64_t opal_set_slot_led_status(uint64_t phb_id, uint64_t slot_id, uint8_t led_type, uint8_t led_action);
-int64_t opal_get_epow_status(__be64 *status);
+int64_t opal_get_epow_status(__be16 *status, __be16 *length);
 int64_t opal_set_system_attention_led(uint8_t led_action);
 int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
 			    __be16 *pci_error_type, __be16 *severity);
@@ -923,6 +965,7 @@ int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
 		uint64_t *msg_len);
 int64_t opal_i2c_request(uint64_t async_token, uint32_t bus_id,
 			 struct opal_i2c_request *oreq);
+int64_t opal_get_dpo_status(__be64 *dpo_timeout);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 7a3f795..d20970b 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -44,3 +44,4 @@ header-y += tm.h
 header-y += types.h
 header-y += ucontext.h
 header-y += unistd.h
+header-y += opal_platform_events.h
diff --git a/arch/powerpc/include/uapi/asm/opal_platform_events.h b/arch/powerpc/include/uapi/asm/opal_platform_events.h
new file mode 100644
index 0000000..ab1e9bf
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
+ * Copyright IBM Corp. 2014
+ *
+ * Author: Anshuman Khandual <khandual@linux.vnet.ibm.com>
+ */
+#ifndef __LINUX_OPAL_PLATFORM_EVENTS_H
+#define __LINUX_OPAL_PLATFORM_EVENTS_H
+
+#include <linux/types.h>
+
+/* OPAL platform event types */
+#define OPAL_PLAT_EVENT_TYPE_EPOW	0	/* EPOW event */
+#define OPAL_PLAT_EVENT_TYPE_DPO	1	/* DPO event */
+#define OPAL_PLAT_EVENT_TYPE_MAX	2	/* Max events supported */
+
+/* System EPOW type */
+enum opal_epow {
+	OPAL_EPOW_POWER		= 0, /* Power EPOW */
+	OPAL_EPOW_TEMP		= 1, /* Temperature EPOW */
+	OPAL_EPOW_COOL		= 2, /* Cooling EPOW */
+	OPAL_EPOW_MAX		= 3, /* Max EPOW categories */
+};
+
+/* Power EPOW */
+enum epow_power {
+	EPOW_POWER_UPS		= 0x0001, /* System on UPS power */
+	EPOW_POWER_CHNG		= 0x0002, /* System power config change */
+	EPOW_POWER_FAIL		= 0x0004, /* System impending power failure */
+	EPOW_POWER_INCL		= 0x0008, /* System incomplete power */
+};
+
+/* Temperature EPOW */
+enum epow_temp {
+	EPOW_TEMP_AMB		= 0x0001, /* System over ambient temperature */
+	EPOW_TEMP_INT		= 0x0002, /* System over internal temperature */
+	EPOW_TEMP_HMD		= 0x0004, /* System over ambient humidity */
+};
+
+/* Cooling EPOW */
+enum epow_cooling {
+	EPOW_COOL_INSF		= 0x0001, /* System insufficient cooling */
+};
+
+
+/* OPAL event */
+struct opal_plat_event {
+	__u32	type;			/* Type of OPAL platform event */
+	__u32	size;			/* Size of OPAL platform event */
+	__u64	timeout;		/* Timeout to shutdown in secs */
+	__u16	epow[OPAL_EPOW_MAX];	/* Detailed system EPOW status */
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
+#define	OPAL_PLAT_EVENT_MAX_SIZE	4096
+
+/*
+ * Suggested user operation
+ *
+ * The user space client must follow these steps in order to be able to
+ * exploit the features exported through the OPAL platform event driver.
+ *
+ *	(1) Open the character device file
+ *	(2) Poll on the file for POLLIN
+ *	(3) When unblocked, must attempt to read OPAL_PLAT_EVENT_MAX_SIZE size
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
index 0000000..023ae3a
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-platform-events.c
@@ -0,0 +1,663 @@
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
+#include <linux/miscdevice.h>
+#include <asm/uaccess.h>
+#include <asm/opal.h>
+#include <asm/opal_platform_events.h>
+
+#define OPAL_EVENT_MAX_DEVS	1
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
+/* Platform events driver */
+static bool opal_event_open_flag;
+
+/* Platform events timers */
+static struct timer_list opal_event_timer;
+
+static DECLARE_WAIT_QUEUE_HEAD(opal_plat_evt_wait);
+static DECLARE_WAIT_QUEUE_HEAD(opal_plat_open_wait);
+static DEFINE_SPINLOCK(opal_dpo_target_spinlock);
+static DEFINE_SPINLOCK(opal_plat_evt_spinlock);
+static DEFINE_SPINLOCK(opal_plat_timer_spinlock);
+static DEFINE_MUTEX(opal_plat_evt_mutex);
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
+	pr_info("Timer activated for %s event with timeout = %llu seconds\n",
+					opal_event_map[event], timeout);
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
+ * User client needs to attempt to read OPAL_PLAT_EVENT_MAX_SIZE amount of data
+ * from the file descriptor at a time. The driver will pass a single node
+ * from the list if available at a time and then delete the node from the list.
+ */
+static ssize_t opal_event_read(struct file *filep,
+			char __user *buf, size_t len, loff_t *off)
+{
+	struct opal_platform_evt *evt;
+	unsigned long flags;
+
+	if (len != OPAL_PLAT_EVENT_MAX_SIZE)
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
+	spin_unlock_irqrestore(&opal_plat_evt_spinlock, flags);
+
+	/*
+	 * Update the remaining timeout for DPO event.
+	 * This can only be updated during the read time.
+	 */
+	if (evt->opal_event.type == OPAL_PLAT_EVENT_TYPE_DPO) {
+		unsigned long timeout = 0, dpo_target;
+
+		spin_lock_irqsave(&opal_dpo_target_spinlock, flags);
+		dpo_target = opal_dpo_target;
+		spin_unlock_irqrestore(&opal_dpo_target_spinlock, flags);
+
+		if (time_after(dpo_target, jiffies))
+			timeout = (dpo_target - jiffies) / HZ;
+		evt->opal_event.timeout = timeout;
+	}
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
+ * attempting to open the file descriptor will wait for
+ * the other process to close the file descriptor.
+ * O_NONBLOCK mode isn't supported.
+ */
+static int opal_event_open(struct inode *inode, struct file *file)
+{
+	int err;
+
+	if (file->f_flags & O_NONBLOCK)
+		return -ENOTSUPP;
+
+	mutex_lock(&opal_plat_evt_mutex);
+	while (opal_event_open_flag) {
+		mutex_unlock(&opal_plat_evt_mutex);
+		err = wait_event_interruptible(opal_plat_open_wait,
+						!opal_event_open_flag);
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
+static const struct file_operations opal_event_fops = {
+	.owner		= THIS_MODULE,
+	.open		= opal_event_open,
+	.release	= opal_event_release,
+	.read		= opal_event_read,
+	.poll		= opal_event_poll,
+};
+
+/* Process the received EPOW information */
+void process_epow(__u16 *epow, int16_t *epow_status, int max_epow_class)
+{
+	int i;
+
+	/* Copy received EPOW information from OPAL */
+	for (i = 0; i < OPAL_EPOW_MAX; i++) {
+		epow[i] = 0;
+		if (epow_status[i])
+			epow[i] = epow_status[i];
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
+	int i, rc;
+	__be16 epow[OPAL_SYSEPOW_MAX], num_epow;
+
+	memset(epow_status, 0, sizeof(int16_t) * OPAL_SYSEPOW_MAX);
+	memset(epow, 0, sizeof(__be16) * OPAL_SYSEPOW_MAX);
+	num_epow = OPAL_SYSEPOW_MAX;
+
+	rc = opal_get_epow_status(epow, &num_epow);
+
+	if (rc != OPAL_SUCCESS) {
+		pr_err("EPOW: OPAL call failed\n");
+		memset(epow_status, 0, sizeof(int16_t) * OPAL_SYSEPOW_MAX);
+		*n_epow = 0;
+		return;
+	}
+
+	*n_epow = be16_to_cpu(num_epow);
+	for (i = 0; i < *n_epow; i++)
+		*(epow_status+i) = be16_to_cpup(epow+i);
+
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
+	__be64 timeout;
+
+	rc = opal_get_dpo_status(&timeout);
+
+	*dpo_timeout = be64_to_cpu(timeout);
+
+	if (rc == OPAL_WRONG_STATE) {
+		pr_info("DPO: Not initiated by OPAL\n");
+		*dpo_timeout = 0;
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
+ * actionable_epow
+ *
+ * There are some EPOW events for which the user client must receive
+ * their status but the driver would not schedule a timer for that
+ * event as the platform would not force shutdown the system because
+ * of this event. This filters only the actionable EPOW events for
+ * which shutdown timer need to be scheduled.
+ */
+static bool actionable_epow(__u16 *epow)
+{
+
+	if (epow[OPAL_EPOW_POWER] == EPOW_POWER_UPS)
+		return false;
+
+	if (epow[OPAL_EPOW_POWER] == EPOW_POWER_CHNG)
+		return false;
+
+	if (epow[OPAL_EPOW_POWER] == EPOW_POWER_INCL)
+		return false;
+
+	if (epow[OPAL_EPOW_TEMP] == EPOW_TEMP_HMD)
+		return false;
+
+	if (epow[OPAL_EPOW_COOL] == EPOW_COOL_INSF)
+		return false;
+
+	return true;
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
+		evt->opal_event.timeout = timeout;
+		if (actionable_epow(evt->opal_event.epow))
+			opal_event_start_timer(OPAL_PLAT_EVENT_TYPE_EPOW,
+							OPAL_EPOW_TIMEOUT);
+		break;
+	case  OPAL_PLAT_EVENT_TYPE_DPO:
+		evt->opal_event.timeout = timeout;
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
+	unsigned long flags;
+	int16_t	epow_status[OPAL_SYSEPOW_MAX], n_epow;
+
+	fetch_epow_status(epow_status, &n_epow);
+	if (valid_epow(epow_status, n_epow)) {
+		pr_info("Detected pending EPOW event: "
+			"Power(0x%x) Thermal(0x%x) Cooling(0x%x)\n",
+			epow_status[0], epow_status[1], epow_status[2]);
+
+		evt = kzalloc(sizeof(struct opal_platform_evt), GFP_KERNEL);
+		if (!evt) {
+			pr_err("EPOW: Memory allocation for event failed\n");
+			return;
+		}
+		process_epow(evt->opal_event.epow, epow_status, n_epow);
+		opal_event_handle_basic(evt, OPAL_PLAT_EVENT_TYPE_EPOW,
+							OPAL_EPOW_TIMEOUT);
+	}
+
+	fetch_dpo_timeout(&dpo_timeout);
+	if (dpo_timeout) {
+		pr_info("Detected pending DPO event with timeout = %llu seconds\n",
+					dpo_timeout);
+
+		evt = kzalloc(sizeof(struct opal_platform_evt), GFP_KERNEL);
+		if (!evt) {
+			pr_err("DPO: Memory allocation for event failed\n");
+			return;
+		}
+		spin_lock_irqsave(&opal_dpo_target_spinlock, flags);
+		opal_dpo_target = jiffies + dpo_timeout * HZ;
+		spin_unlock_irqrestore(&opal_dpo_target_spinlock, flags);
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
+	pr_info("EPOW event detected\n");
+
+	fetch_epow_status(epow_status, &n_epow);
+	if (!valid_epow(epow_status, n_epow))
+		return -EINVAL;
+
+	pr_info("EPOW event: Power(0x%x) Thermal(0x%x) Cooling(0x%x)\n",
+			epow_status[0], epow_status[1], epow_status[2]);
+
+	evt = kzalloc(sizeof(struct opal_platform_evt), GFP_ATOMIC);
+	if (!evt) {
+		pr_err("EPOW: Memory allocation for event failed\n");
+		return -ENOMEM;
+	}
+	process_epow(evt->opal_event.epow, epow_status, n_epow);
+	opal_event_handle_basic(evt,
+				OPAL_PLAT_EVENT_TYPE_EPOW, OPAL_EPOW_TIMEOUT);
+	return 0;
+}
+
+/* Platform DPO message received */
+static int opal_dpo_event(struct notifier_block *nb,
+				unsigned long msg_type, void *msg)
+{
+	unsigned long flags;
+	struct opal_platform_evt *evt;
+	int64_t dpo_timeout;
+
+	if (msg_type != OPAL_MSG_DPO)
+		return 0;
+
+	pr_info("DPO event detected\n");
+
+	fetch_dpo_timeout(&dpo_timeout);
+	if (!dpo_timeout)
+		return -EINVAL;
+
+	pr_info("DPO event timeout = %llu seconds\n", dpo_timeout);
+	evt = kzalloc(sizeof(struct opal_platform_evt), GFP_ATOMIC);
+	if (!evt) {
+		pr_err("DPO: Memory allocation for event failed\n");
+		return -ENOMEM;
+	}
+	spin_lock_irqsave(&opal_dpo_target_spinlock, flags);
+	opal_dpo_target = jiffies + dpo_timeout * HZ;
+	spin_unlock_irqrestore(&opal_dpo_target_spinlock, flags);
+
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
+static struct miscdevice opal_event_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "opal_event",
+	.fops = &opal_event_fops,
+};
+
+/* Platform driver probe */
+static int opal_event_probe(struct platform_device *pdev)
+{
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
+	/* Register opal_event device. */
+	ret = misc_register(&opal_event_dev);
+	if (ret < 0) {
+		pr_err("opal_event device registration failed.\n");
+		return 0;
+	}
+
+	ret = opal_message_notifier_register(OPAL_MSG_EPOW, &opal_epow_nb);
+	if (ret) {
+		pr_err("EPOW: Platform event message notifier failed\n");
+		goto unregister_dev;
+	}
+	pr_info("EPOW: Platform event message notifier registered\n");
+
+	ret = opal_message_notifier_register(OPAL_MSG_DPO, &opal_dpo_nb);
+	if (ret) {
+		pr_err("DPO: Platform event message notifier failed\n");
+		opal_notifier_unregister(&opal_epow_nb);
+		goto unregister_dev;
+	}
+	pr_info("DPO: Platform event message notifier registered\n");
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
+
+	return 0;
+
+unregister_dev:
+	ret = misc_deregister(&opal_event_dev);
+	if (ret < 0) {
+		pr_err("opal_event device de-registration failed.\n");
+		return 0;
+	}
+
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
+	/* Deregister opal_event device */
+	misc_deregister(&opal_event_dev);
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
+module_platform_driver(opal_event_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Anshuman Khandual <khandual@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("PowerNV OPAL platform events driver");
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 0509bca..f4ac7c1c 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -292,3 +292,4 @@ OPAL_CALL(opal_tpo_read,			OPAL_READ_TPO);
 OPAL_CALL(opal_ipmi_send,			OPAL_IPMI_SEND);
 OPAL_CALL(opal_ipmi_recv,			OPAL_IPMI_RECV);
 OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
+OPAL_CALL(opal_get_dpo_status,			OPAL_GET_DPO_STATUS);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f10b9ec..ce05279 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -697,7 +697,7 @@ static void opal_i2c_create_devs(void)
 
 static int __init opal_init(void)
 {
-	struct device_node *np, *consoles;
+	struct device_node *np, *consoles, *epow;
 	const __be32 *irqs;
 	int rc, i, irqlen;
 
@@ -724,6 +724,12 @@ static int __init opal_init(void)
 	/* Create i2c platform devices */
 	opal_i2c_create_devs();
 
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
