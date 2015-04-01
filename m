Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B34DB1A0B0D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 17:07:12 +1100 (AEDT)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc/powernv: Add opal-prd channel
Message-Id: <1427868428.289931.158677373296.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 01 Apr 2015 14:07:08 +0800
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This change adds a char device to access the "PRD" (processor runtime
diagnostics) channel to OPAL firmware.

Includes contributions from Vaidyanathan Srinivasan, Neelesh Gupta &
Vishal Kulkarni.

Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/include/asm/opal-api.h            |   40 +
 arch/powerpc/include/asm/opal.h                |    1 
 arch/powerpc/include/uapi/asm/opal-prd.h       |   57 ++
 arch/powerpc/platforms/powernv/Makefile        |    2 
 arch/powerpc/platforms/powernv/opal-prd.c      |  440 +++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 6 files changed, 539 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0321a90..b787b95 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -153,7 +153,8 @@
 #define OPAL_FLASH_READ				110
 #define OPAL_FLASH_WRITE			111
 #define OPAL_FLASH_ERASE			112
-#define OPAL_LAST				112
+#define OPAL_PRD_MSG				113
+#define OPAL_LAST				113
 
 /* Device tree flags */
 
@@ -352,6 +353,7 @@ enum opal_msg_type {
 	OPAL_MSG_SHUTDOWN,		/* params[0] = 1 reboot, 0 shutdown */
 	OPAL_MSG_HMI_EVT,
 	OPAL_MSG_DPO,
+	OPAL_MSG_PRD,
 	OPAL_MSG_TYPE_MAX,
 };
 
@@ -674,6 +676,42 @@ typedef struct oppanel_line {
 	__be64 line_len;
 } oppanel_line_t;
 
+enum opal_prd_msg_type {
+	OPAL_PRD_MSG_TYPE_INIT = 0,	/* HBRT --> OPAL */
+	OPAL_PRD_MSG_TYPE_FINI,		/* HBRT --> OPAL */
+	OPAL_PRD_MSG_TYPE_ATTN,		/* HBRT <-- OPAL */
+	OPAL_PRD_MSG_TYPE_ATTN_ACK,	/* HBRT --> OPAL */
+	OPAL_PRD_MSG_TYPE_OCC_ERROR,	/* HBRT <-- OPAL */
+	OPAL_PRD_MSG_TYPE_OCC_RESET,	/* HBRT <-- OPAL */
+};
+
+struct opal_prd_msg {
+	uint8_t		type;
+	uint8_t		pad[3];
+	__be32		token;
+	union {
+		struct {
+			__be64	version;
+			__be64	ipoll;
+		} init;
+		struct {
+			__be64	proc;
+			__be64	ipoll_status;
+			__be64	ipoll_mask;
+		} attn;
+		struct {
+			__be64	proc;
+			__be64	ipoll_ack;
+		} attn_ack;
+		struct {
+			__be64	chip;
+		} occ_error;
+		struct {
+			__be64	chip;
+		} occ_reset;
+	};
+};
+
 /*
  * SG entries
  *
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 7c6d7ea..4375cb4 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -193,6 +193,7 @@ int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
 		uint64_t *msg_len);
 int64_t opal_i2c_request(uint64_t async_token, uint32_t bus_id,
 			 struct opal_i2c_request *oreq);
+int64_t opal_prd_msg(struct opal_prd_msg *msg);
 
 int64_t opal_flash_read(uint64_t id, uint64_t offset, uint64_t buf,
 		uint64_t size, uint64_t token);
diff --git a/arch/powerpc/include/uapi/asm/opal-prd.h b/arch/powerpc/include/uapi/asm/opal-prd.h
new file mode 100644
index 0000000..938af8e
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/opal-prd.h
@@ -0,0 +1,57 @@
+/*
+ * OPAL Runtime Diagnostics interface driver
+ * Supported on POWERNV platform
+ *
+ * (C) Copyright IBM 2015
+ *
+ * Author: Vaidyanathan Srinivasan <svaidy at linux.vnet.ibm.com>
+ * Author: Jeremy Kerr <jk@ozlabs.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _UAPI_ASM_POWERPC_OPAL_PRD_H_
+#define _UAPI_ASM_POWERPC_OPAL_PRD_H_
+
+#include <linux/types.h>
+
+#define OPAL_PRD_VERSION		1
+#define OPAL_PRD_RANGE_NAME_LEN		32
+#define OPAL_PRD_MAX_RANGES		8
+
+#define OPAL_PRD_GET_INFO		_IOR('o', 0x01, struct opal_prd_info)
+#define OPAL_PRD_SCOM_READ		_IOR('o', 0x10, struct opal_prd_scom)
+#define OPAL_PRD_SCOM_WRITE		_IOW('o', 0x11, struct opal_prd_scom)
+
+#ifndef __ASSEMBLY__
+
+struct opal_prd_range {
+	char		name[OPAL_PRD_RANGE_NAME_LEN];
+	__u64		physaddr;
+	__u64		size;
+};
+
+struct opal_prd_info {
+	__u64			version;
+	__u64			code_size;
+	struct opal_prd_range	ranges[OPAL_PRD_MAX_RANGES];
+
+};
+
+struct opal_prd_scom {
+	__u64	chip;
+	__u64	addr;
+	__u64	data;
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _UAPI_ASM_POWERPC_OPAL_PRD_H */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 6f3c5d3..ba07631 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,7 +1,7 @@
 obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
-obj-y			+= opal-msglog.o opal-hmi.o opal-power.o
+obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-prd.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
new file mode 100644
index 0000000..26e58e7
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -0,0 +1,440 @@
+/*
+ * OPAL Runtime Diagnostics interface driver
+ * Supported on POWERNV platform
+ *
+ * (C) Copyright IBM 2015
+ *
+ * Author: Vishal Kulkarni <kvishal at in.ibm.com>
+ * Author: Vaidyanathan Srinivasan <svaidy at linux.vnet.ibm.com>
+ * Author: Jeremy kerr <jk@ozlabs.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) "opal-prd: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/of.h>
+#include <linux/poll.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <asm/opal-prd.h>
+#include <asm/opal.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+static struct opal_prd_range ranges[OPAL_PRD_MAX_RANGES];
+
+struct opal_prd_msg_queue_item {
+	struct opal_prd_msg	msg;
+	struct list_head	list;
+};
+
+static LIST_HEAD(opal_prd_msg_queue);
+static DEFINE_SPINLOCK(opal_prd_msg_queue_lock);
+static DECLARE_WAIT_QUEUE_HEAD(opal_prd_msg_wait);
+static atomic_t usage;
+
+static struct opal_prd_range *find_range_by_addr(uint64_t addr)
+{
+	struct opal_prd_range *range;
+	unsigned int i;
+
+	for (i = 0; i < OPAL_PRD_MAX_RANGES; i++) {
+		range = &ranges[i];
+		if (addr >= range->physaddr &&
+				addr < range->physaddr + range->size)
+			return range;
+	}
+
+	return NULL;
+}
+
+static int opal_prd_open(struct inode *inode, struct file *file)
+{
+	if (atomic_xchg(&usage, 1) == 1)
+		return -EBUSY;
+
+	return 0;
+}
+
+/*
+ * opal_prd_mmap - maps the hbrt binary into userspace
+ * @file: file structure for the device
+ * @vma: VMA to map the registers into
+ */
+
+static int opal_prd_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct opal_prd_range *range;
+	size_t addr, size;
+	int rc;
+
+	pr_debug("opal_prd_mmap(0x%016lx, 0x%016lx, 0x%lx, 0x%lx)\n",
+			vma->vm_start, vma->vm_end, vma->vm_pgoff,
+			vma->vm_flags);
+
+	addr = vma->vm_pgoff << PAGE_SHIFT;
+	size = vma->vm_end - vma->vm_start;
+
+	/* ensure we're mapping within one of the allowable ranges */
+	range = find_range_by_addr(addr);
+	if (!range)
+		return -EINVAL;
+
+	if (addr + size > range->physaddr + range->size)
+		return -EINVAL;
+
+	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
+						 size, vma->vm_page_prot)
+				| _PAGE_SPECIAL;
+
+	rc = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff, size,
+			vma->vm_page_prot);
+
+	return rc;
+}
+
+static bool opal_msg_queue_empty(void)
+{
+	unsigned long flags;
+	bool ret;
+
+	spin_lock_irqsave(&opal_prd_msg_queue_lock, flags);
+	ret = list_empty(&opal_prd_msg_queue);
+	spin_unlock_irqrestore(&opal_prd_msg_queue_lock, flags);
+
+	return ret;
+}
+
+static unsigned int opal_prd_poll(struct file *file,
+		struct poll_table_struct *wait)
+{
+	poll_wait(file, &opal_prd_msg_wait, wait);
+
+	if (!opal_msg_queue_empty())
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static ssize_t opal_prd_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct opal_prd_msg_queue_item *item;
+	unsigned long flags;
+	ssize_t size;
+	int rc;
+
+	size = sizeof(item->msg);
+
+	if (count < size)
+		return -EINVAL;
+
+	if (*ppos)
+		return -ESPIPE;
+
+	item = NULL;
+
+	for (;;) {
+
+		spin_lock_irqsave(&opal_prd_msg_queue_lock, flags);
+		if (!list_empty(&opal_prd_msg_queue)) {
+			item = list_first_entry(&opal_prd_msg_queue,
+					struct opal_prd_msg_queue_item, list);
+			list_del(&item->list);
+		}
+		spin_unlock_irqrestore(&opal_prd_msg_queue_lock, flags);
+
+		if (item)
+			break;
+
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		rc = wait_event_interruptible(opal_prd_msg_wait,
+				!opal_msg_queue_empty());
+		if (rc)
+			return -EINTR;
+	}
+
+	rc = copy_to_user(buf, &item->msg, size);
+	if (rc) {
+		/* eep! re-queue at the head of the list */
+		spin_lock_irqsave(&opal_prd_msg_queue_lock, flags);
+		list_add(&item->list, &opal_prd_msg_queue);
+		spin_unlock_irqrestore(&opal_prd_msg_queue_lock, flags);
+		return -EFAULT;
+	}
+
+	kfree(item);
+
+	return size;
+}
+
+static ssize_t opal_prd_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct opal_prd_msg msg;
+	ssize_t size;
+	int rc;
+
+	size = sizeof(msg);
+
+	if (count < size)
+		return -EINVAL;
+
+	rc = copy_from_user(&msg, buf, sizeof(msg));
+	if (rc)
+		return -EFAULT;
+
+	rc = opal_prd_msg(&msg);
+	if (rc) {
+		pr_warn("write: opal_prd_msg returned %d\n", rc);
+		return -EIO;
+	}
+
+	return size;
+}
+
+static int opal_prd_release(struct inode *inode, struct file *file)
+{
+	struct opal_prd_msg msg;
+
+	msg.type = OPAL_PRD_MSG_TYPE_FINI;
+	msg.token = 0;
+
+	opal_prd_msg(&msg);
+	atomic_xchg(&usage, 0);
+
+	return 0;
+}
+
+
+static long opal_prd_ioctl(struct file *file, unsigned int cmd,
+		unsigned long param)
+{
+	struct opal_prd_info info;
+	struct opal_prd_scom scom;
+	int rc = 0;
+
+	switch(cmd) {
+	case OPAL_PRD_GET_INFO:
+		info.version = OPAL_PRD_VERSION;
+		memcpy(&info.ranges, ranges, sizeof(info.ranges));
+		rc = copy_to_user((void __user *)param, &info, sizeof(info));
+		if (rc)
+			return -EFAULT;
+		break;
+
+	case OPAL_PRD_SCOM_READ:
+		rc = copy_from_user(&scom, (void __user *)param, sizeof(scom));
+		if (rc)
+			return -EFAULT;
+
+		rc = opal_xscom_read(scom.chip, scom.addr,
+				(__be64 *)&scom.data);
+		scom.data = be64_to_cpu(scom.data);
+		pr_debug("ioctl SCOM_READ: chip %llx addr %016llx "
+				"data %016llx rc %d\n",
+				scom.chip, scom.addr, scom.data, rc);
+		if (rc)
+			return -EIO;
+
+		rc = copy_to_user((void __user *)param, &scom, sizeof(scom));
+		if (rc)
+			return -EFAULT;
+		break;
+
+	case OPAL_PRD_SCOM_WRITE:
+		rc = copy_from_user(&scom, (void __user *)param, sizeof(scom));
+		if (rc)
+			return -EFAULT;
+
+		rc = opal_xscom_write(scom.chip, scom.addr, scom.data);
+		pr_debug("ioctl SCOM_WRITE: chip %llx addr %016llx "
+				"data %016llx rc %d\n",
+				scom.chip, scom.addr, scom.data, rc);
+		if (rc)
+			return -EIO;
+
+		break;
+
+	default:
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+struct file_operations opal_prd_fops = {
+	.open		= opal_prd_open,
+	.mmap		= opal_prd_mmap,
+	.poll		= opal_prd_poll,
+	.read		= opal_prd_read,
+	.write		= opal_prd_write,
+	.unlocked_ioctl	= opal_prd_ioctl,
+	.release	= opal_prd_release,
+	.owner		= THIS_MODULE,
+};
+
+static struct miscdevice opal_prd_dev = {
+        .minor		= MISC_DYNAMIC_MINOR,
+        .name		= "opal-prd",
+        .fops		= &opal_prd_fops,
+};
+
+/* opal interface */
+static int opal_prd_msg_notifier(struct notifier_block *nb,
+		unsigned long msg_type, void *_msg)
+{
+	struct opal_prd_msg_queue_item *item;
+	struct opal_msg *msg = _msg;
+	unsigned long flags;
+
+	if (msg_type != OPAL_MSG_PRD)
+		return 0;
+
+	item = kzalloc(sizeof(*item), GFP_ATOMIC);
+	if (!item)
+		return -ENOMEM;
+
+	memcpy(&item->msg, msg->params, sizeof(item->msg));
+
+	spin_lock_irqsave(&opal_prd_msg_queue_lock, flags);
+	list_add_tail(&item->list, &opal_prd_msg_queue);
+	spin_unlock_irqrestore(&opal_prd_msg_queue_lock, flags);
+
+	wake_up_interruptible(&opal_prd_msg_wait);
+
+	return 0;
+}
+
+static struct notifier_block opal_prd_event_nb = {
+	.notifier_call	= opal_prd_msg_notifier,
+	.next		= NULL,
+	.priority	= 0,
+};
+
+static bool is_prd_range(const char *name)
+{
+	if (!name)
+		return false;
+
+	/* skip the ibm,firmware-* properties, they're from skiboot */
+	if (!strncmp(name, "ibm,firmware-", strlen("ibm,firmware-")))
+		return false;
+
+	return true;
+}
+
+/**
+ * Find the HBRT code region in reserved-ranges and set code_region_physaddr
+ * and code_region_size accordingly.
+ */
+static int parse_regions(void)
+{
+	const __be32 *ranges_prop;
+	int i, n, rc, nr_ranges;
+	struct device_node *np;
+	const char *name;
+
+	np = of_find_node_by_path("/");
+	if (!np)
+		return -ENODEV;
+
+	nr_ranges = of_property_count_strings(np, "reserved-names");
+	ranges_prop = of_get_property(np, "reserved-ranges", NULL);
+	if (!ranges_prop) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	for (i = 0, n = 0; i < nr_ranges; i++) {
+		uint64_t addr, size;
+
+		rc = of_property_read_string_index(np, "reserved-names", i,
+				&name);
+		if (rc)
+			continue;
+
+		if (strlen(name) >= OPAL_PRD_RANGE_NAME_LEN)
+			continue;
+
+		if (!is_prd_range(name))
+			continue;
+
+		addr = of_read_number(ranges_prop + (i * 4) + 0, 2);
+		size = PAGE_ALIGN(of_read_number(ranges_prop + (i * 4) + 2, 2));
+
+		if (addr & (PAGE_SIZE - 1)) {
+			pr_warn("skipping range %s: not page-aligned\n",
+					name);
+			continue;
+		}
+
+		if (n == OPAL_PRD_MAX_RANGES) {
+			pr_warn("Too many PRD ranges! Skipping %s\n", name);
+		} else {
+			strncpy(ranges[n].name, name,
+					OPAL_PRD_RANGE_NAME_LEN - 1);
+			ranges[n].physaddr = addr;
+			ranges[n].size = size;
+			n++;
+		}
+	}
+
+	of_node_put(np);
+
+	return 0;
+}
+
+static int __init opal_prd_init(void)
+{
+	int rc;
+
+	/* parse the code region information from the device tree */
+	rc = parse_regions();
+	if (rc) {
+		pr_err("Couldn't parse region information from DT\n");
+		return rc;
+	}
+
+	rc = opal_message_notifier_register(OPAL_MSG_PRD, &opal_prd_event_nb);
+	if (rc) {
+		pr_err("Couldn't register event notifier\n");
+		return rc;
+	}
+
+	rc = misc_register(&opal_prd_dev);
+	if (rc) {
+		pr_err("failed to register miscdev\n");
+		return rc;
+	}
+
+	return 0;
+}
+
+static void __exit opal_prd_exit(void)
+{
+	misc_deregister(&opal_prd_dev);
+	opal_message_notifier_unregister(OPAL_MSG_PRD, &opal_prd_event_nb);
+}
+
+module_init(opal_prd_init);
+module_exit(opal_prd_exit);
+
+MODULE_DESCRIPTION("PowerNV OPAL runtime diagnostic driver");
+MODULE_LICENSE("GPL");
+
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 4e74037..5e0e732 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -295,3 +295,4 @@ OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
 OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
 OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
 OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
+OPAL_CALL(opal_prd_msg,				OPAL_PRD_MSG);
