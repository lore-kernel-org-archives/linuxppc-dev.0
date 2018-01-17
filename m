Return-Path: <srs0=4i2n=em=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLs6B5Vw8zF0W9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 13:50:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zLs6B1zMdz8x9W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 13:50:58 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zLs692pMkz9s82
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 13:50:57 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0H2oPgp070706
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 21:50:55 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fhtpn6pyw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 21:50:55 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 16 Jan 2018 21:50:54 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] powerpc/ftw: Implement a simple FTW driver
Date: Tue, 16 Jan 2018 18:50:41 -0800
In-Reply-To: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1516157443-17716-4-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Fast Thread Wake-up (FTW) driver provides user space applications an
interface to the low latency Core-to-Core wakeup functionality in POWER9.

This mechanism allows a thread on one core to efficiently send a message
to a "waiting thread" on another core on the same chip, using the Virtual
Accelrator Switchboard (VAS) subsystem.

This initial FTW driver implements the ioctl and mmap operations on an
FTW device node. Using these operations, a pair of application threads
can establish a "communication channel" and use the COPY, PASTE and WAIT
instructions to wait/wake up.

PATCH 5/5 documents the API and includes an example of the usage.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v2]
	- [Michael Neuling] Rename from drop "nx" from name "nx-ftw".
	- [Michael Neuling] Use a single VAS_FTW_SETUP ioctl to simplify
	  interface.
	- [Michael Ellerman] To work with paste emulation patch, mark
	  PTE dirty in ->mmap() to ensure there is no fault on paste
	  (the emulation patch must disable pagefaults when updating
	  thread reconfig registers).
	- Check return value from set_thread_tidr().
	- Move driver drivers/misc/ftw.

---
 drivers/misc/Kconfig      |   1 +
 drivers/misc/Makefile     |   1 +
 drivers/misc/ftw/Kconfig  |  16 +++
 drivers/misc/ftw/Makefile |   4 +
 drivers/misc/ftw/ftw.c    | 346 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 368 insertions(+)
 create mode 100644 drivers/misc/ftw/Kconfig
 create mode 100644 drivers/misc/ftw/Makefile
 create mode 100644 drivers/misc/ftw/ftw.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f1a5c23..a9b161f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -508,4 +508,5 @@ source "drivers/misc/mic/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
+source "drivers/misc/ftw/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 5ca5f64..338668c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_PPC_FTW)		+= ftw/
 obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
diff --git a/drivers/misc/ftw/Kconfig b/drivers/misc/ftw/Kconfig
new file mode 100644
index 0000000..5454d40
--- /dev/null
+++ b/drivers/misc/ftw/Kconfig
@@ -0,0 +1,16 @@
+
+config PPC_FTW
+	tristate "IBM Fast Thread-Wakeup (FTW)"
+	depends on PPC_VAS
+	default n
+	help
+          This enables support for IBM Fast Thread-Wakeup driver.
+
+          The FTW driver allows applications to utilize a low overhead
+          core-to-core wake up mechansim in the IBM Virtual Accelerator
+          Switchboard (VAS) to improve performance.
+
+          VAS adapters are found in POWER9 based systems and are required
+          for the FTW driver to be operational.
+
+          If unsure, say N.
diff --git a/drivers/misc/ftw/Makefile b/drivers/misc/ftw/Makefile
new file mode 100644
index 0000000..2cfe566
--- /dev/null
+++ b/drivers/misc/ftw/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+ccflags-y			:= $(call cc-disable-warning, unused-const-variable)
+ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
+obj-$(CONFIG_PPC_FTW)		+= ftw.o
diff --git a/drivers/misc/ftw/ftw.c b/drivers/misc/ftw/ftw.c
new file mode 100644
index 0000000..6fcb4e2
--- /dev/null
+++ b/drivers/misc/ftw/ftw.c
@@ -0,0 +1,346 @@
+/*
+ * Copyright 2018 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#define pr_fmt(fmt) "ftw: " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/pfn_t.h>
+#include <asm/switch_to.h>
+#include <asm/vas.h>
+#include <uapi/misc/ftw.h>
+
+/*
+ * FTW is a device driver used to provide user space access to the
+ * Core-to-Core aka Fast Thread Wakeup (FTW) functionality provided by
+ * the Virtual Accelerator Subsystem (VAS) in POWER9 systems. See also
+ * arch/powerpc/platforms/powernv/vas*.
+ *
+ * The driver creates the device /dev/ftw that can be used as follows:
+ *
+ *	fd = open("/dev/ftw", O_RDWR);
+ *	rc = ioctl(fd, FTW_SETUP, &attr);
+ *	paste_addr = mmap(NULL, PAGE_SIZE, prot, MAP_SHARED, fd, 0ULL).
+ *	vas_copy(&crb, 0, 1);
+ *	vas_paste(paste_addr, 0, 1);
+ *
+ * where "vas_copy" and "vas_paste" are defined in copy-paste.h.
+ */
+
+static char		*ftw_dev_name = "ftw";
+static atomic_t		ftw_instid = ATOMIC_INIT(0);
+
+/*
+ * Wrapper object for the ftw device - there is just one instance of
+ * this node in the system.
+ */
+struct ftw_dev {
+	struct cdev cdev;
+	struct device *device;
+	char *name;
+	dev_t devt;
+	struct class *class;
+} ftw_device;
+
+/*
+ * One instance per open of a ftw device. Each ftw_instance is
+ * associated with a VAS window after the caller issues FTW_SETUP
+ * ioctl.
+ */
+struct ftw_instance {
+	int id;
+	struct vas_window *rxwin;
+	struct vas_window *txwin;
+};
+
+static char *ftw_devnode(struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "%s", dev_name(dev));
+}
+
+static int ftw_open(struct inode *inode, struct file *fp)
+{
+	struct ftw_instance *instance;
+
+	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
+	if (!instance)
+		return -ENOMEM;
+
+	instance->id = atomic_inc_return(&ftw_instid);
+
+	fp->private_data = instance;
+
+	return 0;
+}
+
+static int validate_ftw_setup_attr(struct ftw_setup_attr *uattr)
+{
+	if (uattr->version != 1 || uattr->reserved || uattr->reserved1 ||
+				   uattr->reserved2)
+		return -EINVAL;
+
+	if (uattr->flags & ~FTW_FLAGS_PIN_WINDOW)
+		return -EINVAL;
+
+	if (uattr->flags & FTW_FLAGS_PIN_WINDOW && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return 0;
+}
+
+static int ftw_ioc_ftw_setup(struct file *fp, unsigned long arg)
+{
+	int rc, vasid, cop;
+	struct vas_rx_win_attr rxattr;
+	struct vas_tx_win_attr txattr;
+	struct ftw_setup_attr uattr;
+	void __user *uptr = (void *)arg;
+	struct vas_window *rxwin, *txwin;
+	struct ftw_instance *instance = fp->private_data;
+
+	rc = copy_from_user(&uattr, uptr, sizeof(uattr));
+	if (rc) {
+		pr_debug("copy_from_user() returns %d\n", rc);
+		return -EFAULT;
+	}
+
+	rc = validate_ftw_setup_attr(&uattr);
+	if (rc)
+		return rc;
+
+	cop = VAS_COP_TYPE_FTW;
+	rc = set_thread_tidr(current);
+	if (rc)
+		return rc;
+
+	vasid = uattr.vas_id;
+
+	vas_init_rx_win_attr(&rxattr, cop);
+	rxattr.lnotify_lpid = mfspr(SPRN_LPID);
+
+	/*
+	 * Only caller can own the window for now. Not sure if there is need
+	 * for process P1 to make P2 the owner of a window. If so, we need to
+	 * find P2, make sure we have permissions, get a reference etc.
+	 */
+	rxattr.lnotify_pid = mfspr(SPRN_PID);
+	rxattr.lnotify_tid = mfspr(SPRN_TIDR);
+
+	rxwin = vas_rx_win_open(vasid, cop, &rxattr);
+	if (IS_ERR(rxwin)) {
+		pr_debug("vas_rx_win_open() failed, %ld\n", PTR_ERR(rxwin));
+		return PTR_ERR(rxwin);
+	}
+
+	vas_init_tx_win_attr(&txattr, cop);
+
+	txattr.lpid = mfspr(SPRN_LPID);
+	txattr.pidr = mfspr(SPRN_PID);
+	txattr.pid = task_pid_nr(current);
+	txattr.pswid = vas_win_id(rxwin);
+
+	txwin = vas_tx_win_open(vasid, cop, &txattr);
+	if (IS_ERR(txwin)) {
+		pr_debug("vas_tx_win_open() failed, %ld\n", PTR_ERR(txwin));
+		rc = PTR_ERR(txwin);
+		goto close_rxwin;
+	}
+
+	instance->rxwin = rxwin;
+	instance->txwin = txwin;
+
+	return 0;
+
+close_rxwin:
+	vas_win_close(rxwin);
+	return rc;
+}
+
+static int ftw_release(struct inode *inode, struct file *fp)
+{
+	struct ftw_instance *instance;
+
+	instance = fp->private_data;
+
+	if (instance->txwin)
+		vas_win_close(instance->txwin);
+	if (instance->rxwin)
+		vas_win_close(instance->rxwin);
+	/*
+	 * TODO We don't know here if user has other receive windows
+	 *      open, and can't really call clear_thread_tidr(). So,
+	 *      once the process calls set_thread_tidr(), the TIDR value
+	 *      sticks around until process exits, potentially resulting
+	 *      in an unnecessary copy in restore_sprs() when even the
+	 *      process has closed its last window.
+	 */
+
+	instance->rxwin = instance->txwin = NULL;
+
+	kfree(instance);
+	fp->private_data = NULL;
+	atomic_dec(&ftw_instid);
+
+	return 0;
+}
+
+static int ftw_mmap(struct file *fp, struct vm_area_struct *vma)
+{
+	int rc;
+	pgprot_t prot;
+	u64 paste_addr;
+	unsigned long pfn;
+	struct ftw_instance *instance = fp->private_data;
+
+	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
+		pr_debug("size 0x%zx, PAGE_SIZE 0x%zx\n",
+				(vma->vm_end - vma->vm_start), PAGE_SIZE);
+		return -EINVAL;
+	}
+
+	/* Ensure instance has an open send window */
+	if (!instance->txwin) {
+		pr_debug("No send window open?\n");
+		return -EINVAL;
+	}
+
+	paste_addr = vas_win_paste_addr(instance->txwin);
+	pfn = paste_addr >> PAGE_SHIFT;
+
+	/* flags, page_prot from cxl_mmap(), except we want cachable */
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
+	vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);
+
+	/*
+	 * We must disable page faults when emulating the paste
+	 * instruction. To ensure that the page associated with
+	 * the paste address is in memory, mark it dirty.
+	 */
+	prot = __pgprot(pgprot_val(vma->vm_page_prot) | _PAGE_DIRTY);
+
+	rc = remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
+			vma->vm_end - vma->vm_start, prot);
+
+	pr_devel("paste addr %llx at %lx, rc %d\n", paste_addr, vma->vm_start,
+			rc);
+
+	set_thread_uses_vas();
+
+	return rc;
+}
+
+static long ftw_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+
+	case FTW_SETUP:
+		return ftw_ioc_ftw_setup(fp, arg);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+const struct file_operations ftw_fops = {
+	.owner = THIS_MODULE,
+	.open = ftw_open,
+	.release = ftw_release,
+	.mmap = ftw_mmap,
+	.unlocked_ioctl = ftw_ioctl,
+};
+
+
+int ftw_file_init(void)
+{
+	int rc;
+	dev_t devno;
+
+	rc = alloc_chrdev_region(&ftw_device.devt, 1, 1, "ftw");
+	if (rc) {
+		pr_debug("Unable to allocate ftw major number: %i\n", rc);
+		return rc;
+	}
+
+	pr_devel("device allocated, dev [%i,%i]\n",
+			MAJOR(ftw_device.devt), MINOR(ftw_device.devt));
+
+	ftw_device.class = class_create(THIS_MODULE, "ftw");
+	if (IS_ERR(ftw_device.class)) {
+		pr_debug("Unable to create FTW class\n");
+		rc = PTR_ERR(ftw_device.class);
+		goto err;
+	}
+	ftw_device.class->devnode = ftw_devnode;
+
+	cdev_init(&ftw_device.cdev, &ftw_fops);
+
+	devno = MKDEV(MAJOR(ftw_device.devt), 0);
+	if (cdev_add(&ftw_device.cdev, devno, 1)) {
+		pr_debug("cdev_add() failed\n");
+		goto err;
+	}
+
+	ftw_device.device = device_create(ftw_device.class, NULL,
+			devno, NULL, ftw_dev_name, MINOR(devno));
+	if (IS_ERR(ftw_device.device)) {
+		pr_debug("Unable to create ftw-%d\n", MINOR(devno));
+		goto err;
+	}
+
+	pr_devel("Added dev [%d,%d]\n", MAJOR(devno), MINOR(devno));
+
+	return 0;
+
+err:
+	unregister_chrdev_region(ftw_device.devt, 1);
+	return rc;
+}
+
+void ftw_file_exit(void)
+{
+	dev_t devno;
+
+	cdev_del(&ftw_device.cdev);
+	devno = MKDEV(MAJOR(ftw_device.devt), MINOR(ftw_device.devt));
+	device_destroy(ftw_device.class, devno);
+
+	class_destroy(ftw_device.class);
+	unregister_chrdev_region(ftw_device.devt, 1);
+}
+
+int __init ftw_init(void)
+{
+	int rc;
+
+	rc = ftw_file_init();
+	if (rc)
+		return rc;
+
+	pr_info("Device initialized\n");
+
+	return 0;
+}
+
+void __init ftw_exit(void)
+{
+	pr_devel("Device exiting\n");
+	ftw_file_exit();
+}
+
+module_init(ftw_init);
+module_exit(ftw_exit);
+
+MODULE_DESCRIPTION("IBM NX Fast Thread Wakeup Device");
+MODULE_AUTHOR("Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>");
+MODULE_LICENSE("GPL");
-- 
2.7.4
