Return-Path: <srs0=ev05=7k=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRqn05D2tzDqrC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:07:48 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xRqn03bM6z8vqD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:07:48 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xRqmz0ds9z9sNd
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2017 09:07:46 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v78N62pj067687
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2017 19:07:45 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c7jrecaps-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Aug 2017 19:07:45 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 19:07:44 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 16/17] powerpc/vas: Implement a simple FTW driver
Date: Tue,  8 Aug 2017 16:07:01 -0700
In-Reply-To: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1502233622-9330-17-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Fast Thread Wake-up (FTW) driver provides user space applications an
interface to the Core-to-Core functionality in POWER9. The driver provides
the device node/ioctl API to applications and uses the external interfaces
to the VAS driver to interact with the VAS hardware.

A follow-on patch provides detailed description of the API for the driver.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 MAINTAINERS                             |   1 +
 arch/powerpc/platforms/powernv/Kconfig  |  16 ++
 arch/powerpc/platforms/powernv/Makefile |   1 +
 arch/powerpc/platforms/powernv/nx-ftw.c | 486 ++++++++++++++++++++++++++++++++
 4 files changed, 504 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/nx-ftw.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c3f156c..a45c0c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6431,6 +6431,7 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	arch/powerpc/platforms/powernv/vas*
 F:	arch/powerpc/platforms/powernv/copy-paste.h
+F:	arch/powerpc/platforms/powernv/nx-ftw*
 F:	arch/powerpc/include/asm/vas.h
 F:	arch/powerpc/include/uapi/asm/vas.h
 
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index f565454..67ea0ff 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -44,3 +44,19 @@ config PPC_VAS
 	  VAS adapters are found in POWER9 based systems.
 
 	  If unsure, say N.
+
+config PPC_FTW
+	bool "IBM Fast Thread-Wakeup (FTW)"
+	depends on PPC_VAS
+	default n
+	help
+	  This enables support for IBM Fast Thread-Wakeup driver.
+
+	  The FTW driver allows applications to utilize a low overhead
+	  core-to-core wake up mechansim in the IBM Virtual Accelerator
+	  Switchboard (VAS) to improve performance.
+
+	  VAS adapters are found in POWER9 based systems and are required
+	  for the FTW driver to be operational.
+
+	  If unsure, say N.
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index e4db292..dc60046 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
 obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
 obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
 obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o
+obj-$(CONFIG_PPC_FTW)	+= nx-ftw.o
diff --git a/arch/powerpc/platforms/powernv/nx-ftw.c b/arch/powerpc/platforms/powernv/nx-ftw.c
new file mode 100644
index 0000000..a0b6388
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/nx-ftw.c
@@ -0,0 +1,486 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <asm/cputable.h>
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/cdev.h>
+#include <linux/mutex.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include <linux/bootmem.h>
+#include <asm/opal-api.h>
+#include <asm/opal.h>
+#include <asm/page.h>
+#include <asm/vas.h>
+#include <asm/reg.h>
+
+/*
+ * NX-FTW is a device driver used to provide user space access to the
+ * Core-to-Core aka Fast Thread Wakeup (FTW) functionality provided by
+ * the Virtual Accelerator Subsystem (VAS) in POWER9 systems. See also
+ * arch/powerpc/platforms/powernv/vas*.
+ *
+ * The driver creates the device node /dev/crypto/nx-ftw that can be
+ * used as follows:
+ *
+ *	fd = open("/dev/crypto/nx-ftw", O_RDWR);
+ *	rc = ioctl(fd, VAS_RX_WIN_OPEN, &rxattr);
+ *	rc = ioctl(fd, VAS_TX_WIN_OPEN, &txattr);
+ *	paste_addr = mmap(NULL, PAGE_SIZE, prot, MAP_SHARED, fd, 0ULL).
+ *	vas_copy(&crb, 0, 1);
+ *	vas_paste(paste_addr, 0, 1);
+ *
+ * where "vas_copy" and "vas_paste" are defined in copy-paste.h.
+ */
+
+static char		*nxftw_dev_name = "nx-ftw";
+static atomic_t		nxftw_instid = ATOMIC_INIT(0);
+static dev_t		nxftw_devt;
+static struct dentry	*nxftw_debugfs;
+static struct class	*nxftw_dbgfs_class;
+
+/*
+ * Wrapper object for the nx-ftw device node - there is just one
+ * instance of this node for the whole system.
+ */
+struct nxftw_dev {
+	struct cdev cdev;
+	struct device *device;
+	char *name;
+	atomic_t refcount;
+} nxftw_device;
+
+/*
+ * One instance per open of a nx-ftw device. Each nxftw_instance is
+ * associated with a VAS window, after the caller issues VAS_RX_WIN_OPEN
+ * or VAS_TX_WIN_OPEN ioctl.
+ */
+struct nxftw_instance {
+	int instance;
+	bool tx_win;
+	struct vas_window *window;
+};
+
+#define VAS_DEFAULT_VAS_ID	0
+#define POWERNV_LPID		0	/* TODO: For VM/KVM guests? */
+
+static char *nxftw_devnode(struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "crypto/%s", dev_name(dev));
+}
+
+static int nxftw_open(struct inode *inode, struct file *fp)
+{
+	int minor;
+	struct nxftw_instance *nxti;
+
+	minor = MINOR(inode->i_rdev);
+
+	nxti = kzalloc(sizeof(*nxti), GFP_KERNEL);
+	if (!nxti)
+		return -ENOMEM;
+
+	nxti->instance = atomic_inc_return(&nxftw_instid);
+	nxti->window = NULL;
+
+	fp->private_data = nxti;
+	return 0;
+}
+
+static int validate_txwin_user_attr(struct vas_tx_win_open_attr *uattr)
+{
+	int i;
+
+	if (uattr->version != 1)
+		return -EINVAL;
+
+	if (uattr->flags & ~VAS_FLAGS_HIGH_PRI)
+		return -EINVAL;
+
+	if (uattr->reserved1 || uattr->reserved2)
+		return -EINVAL;
+
+	for (i = 0; i < sizeof(uattr->reserved3) / sizeof(uint64_t); i++) {
+		if (uattr->reserved3[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool validate_rxwin_user_attr(struct vas_rx_win_open_attr *uattr)
+{
+	int i;
+
+	if (uattr->version != 1)
+		return -EINVAL;
+
+	for (i = 0; i < sizeof(uattr->reserved) / sizeof(uint64_t); i++) {
+		if (uattr->reserved[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+#ifdef vas_debug
+static inline void dump_rx_win_attr(struct vas_rx_win_attr *attr)
+{
+	pr_err("NX-FTW: user %d, nx %d, fault %d, ntfy %d, intr %d early %d\n",
+			attr->user_win ? 1 : 0,
+			attr->nx_win ? 1 : 0,
+			attr->fault_win ? 1 : 0,
+			attr->notify_disable ? 1 : 0,
+			attr->intr_disable ? 1 : 0,
+			attr->notify_early ? 1 : 0);
+
+	pr_err("NX-FTW: rx_fifo %p, rx_fifo_size %d, max value 0x%x\n",
+			attr->rx_fifo, attr->rx_fifo_size,
+			VAS_RX_FIFO_SIZE_MAX);
+
+}
+#else
+static inline void dump_rx_win_attr(struct vas_rx_win_attr *attr)
+{
+}
+#endif
+
+static int nxftw_ioc_open_rx_window(struct file *fp, unsigned long arg)
+{
+	int rc;
+	struct vas_rx_win_open_attr uattr;
+	struct vas_rx_win_attr rxattr;
+	struct nxftw_instance *nxti = fp->private_data;
+	struct vas_window *win;
+
+	rc = copy_from_user(&uattr, (void *)arg, sizeof(uattr));
+	if (rc) {
+		pr_devel("%s(): copy_from_user() returns %d\n", __func__, rc);
+		return -EFAULT;
+	}
+
+	rc = validate_rxwin_user_attr(&uattr);
+	if (rc)
+		return rc;
+
+	memset(&rxattr, 0, sizeof(rxattr));
+
+	rxattr.lnotify_lpid = POWERNV_LPID;
+
+	/*
+	 * Only caller can own the window for now. Not sure if there is need
+	 * for process P1 to make P2 the owner of a window. If so, we need to
+	 * find P2, make sure we have permissions, get a reference etc.
+	 */
+	rxattr.lnotify_pid = mfspr(SPRN_PID);
+	rxattr.lnotify_tid = mfspr(SPRN_TIDR);
+	rxattr.rx_fifo = NULL;
+	rxattr.rx_fifo_size = 0;
+	rxattr.intr_disable = true;
+	rxattr.user_win = true;
+
+	dump_rx_win_attr(&rxattr);
+
+	/*
+	 * TODO: Rather than the default vas id, choose an instance of VAS
+	 *	 based on the chip the caller is running.
+	 */
+	win = vas_rx_win_open(VAS_DEFAULT_VAS_ID, VAS_COP_TYPE_FTW, &rxattr);
+	if (IS_ERR(win)) {
+		pr_devel("%s() vas_rx_win_open() failed, %ld\n", __func__,
+				PTR_ERR(win));
+		return PTR_ERR(win);
+	}
+
+	nxti->window = win;
+	uattr.rx_win_handle = vas_win_id(win);
+
+	rc = copy_to_user((void *)arg, &uattr, sizeof(uattr));
+	if (rc) {
+		pr_devel("%s(): copy_to_user() failed, %d\n", __func__, rc);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int nxftw_ioc_open_tx_window(struct file *fp, unsigned long arg)
+{
+	int rc;
+	enum vas_cop_type cop;
+	struct vas_window *win;
+	struct vas_tx_win_open_attr uattr;
+	struct vas_tx_win_attr txattr;
+	struct nxftw_instance *nxti = fp->private_data;
+
+	rc = copy_from_user(&uattr, (void *)arg, sizeof(uattr));
+	if (rc) {
+		pr_devel("%s(): copy_from_user() failed, %d\n", __func__, rc);
+		return -EFAULT;
+	}
+
+	cop = VAS_COP_TYPE_FTW;
+
+	rc = validate_txwin_user_attr(&uattr);
+	if (rc)
+		return rc;
+
+	pr_devel("Pid %d: Opening txwin, cop %d, PIDR %ld\n",
+				task_pid_nr(current), cop, mfspr(SPRN_PID));
+
+	vas_init_tx_win_attr(&txattr, cop);
+
+	txattr.lpid = POWERNV_LPID;
+	txattr.pidr = mfspr(SPRN_PID);
+	txattr.pid = task_pid_nr(current);
+	txattr.user_win = true;
+	txattr.pswid = uattr.rx_win_handle;
+
+	win = vas_tx_win_open(VAS_DEFAULT_VAS_ID, cop, &txattr);
+	if (IS_ERR(win)) {
+		pr_devel("%s() vas_tx_win_open() failed, %ld\n", __func__,
+					PTR_ERR(win));
+		return PTR_ERR(win);
+	}
+	nxti->window = win;
+	nxti->tx_win = true;
+
+	return 0;
+}
+
+static int nxftw_release(struct inode *inode, struct file *fp)
+{
+	struct nxftw_instance *nxti;
+
+	nxti = fp->private_data;
+
+	vas_win_close(nxti->window);
+	nxti->window = NULL;
+
+	kfree(nxti);
+	fp->private_data = NULL;
+	atomic_dec(&nxftw_instid);
+
+	return 0;
+}
+
+static ssize_t nxftw_write(struct file *fp, const char __user *buf,
+			size_t len, loff_t *offsetp)
+{
+	return -ENOTSUPP;
+}
+
+static ssize_t nxftw_read(struct file *fp, char __user *buf, size_t len,
+			loff_t *offsetp)
+{
+	return -ENOTSUPP;
+}
+
+static int nxftw_vma_fault(struct vm_fault *vmf)
+{
+	u64 offset;
+	unsigned long vaddr;
+	uint64_t pbaddr_start;
+	struct nxftw_instance *nxti;
+	struct vm_area_struct *vma = vmf->vma;
+
+	nxti = vma->vm_private_data;
+	offset = vmf->pgoff << PAGE_SHIFT;
+	vaddr = (unsigned long)vmf->address;
+
+	pbaddr_start = vas_win_paste_addr(nxti->window);
+
+	pr_devel("%s() instance %d, pbaddr 0x%llx, vaddr 0x%lx,"
+			"offset %llx, pgoff 0x%lx, vma-start 0x%zx,"
+			"size %zd\n", __func__, nxti->instance,
+			pbaddr_start, vaddr, offset, vmf->pgoff,
+			vma->vm_start, vma->vm_end-vma->vm_start);
+
+	vm_insert_pfn(vma, vaddr, (pbaddr_start + offset) >> PAGE_SHIFT);
+
+	return VM_FAULT_NOPAGE;
+}
+
+const struct vm_operations_struct nxftw_vm_ops = {
+	.fault = nxftw_vma_fault,
+};
+
+static int nxftw_mmap(struct file *fp, struct vm_area_struct *vma)
+{
+	struct nxftw_instance *nxti = fp->private_data;
+
+	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
+		pr_devel("%s(): size 0x%zx, PAGE_SIZE 0x%zx\n", __func__,
+				(vma->vm_end - vma->vm_start), PAGE_SIZE);
+		return -EINVAL;
+	}
+
+	/* Ensure instance has an open send window */
+	if (!nxti->window || !nxti->tx_win) {
+		pr_devel("%s(): No send window open?\n", __func__);
+		return -EINVAL;
+	}
+
+	/* flags, page_prot from cxl_mmap(), except we want cachable */
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
+	vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);
+
+	vma->vm_ops = &nxftw_vm_ops;
+	vma->vm_private_data = nxti;
+
+	return 0;
+}
+
+static long nxftw_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct nxftw_instance *nxti;
+
+	nxti = fp->private_data;
+
+	pr_devel("%s() cmd 0x%x, TX_WIN_OPEN 0x%lx\n", __func__, cmd,
+			VAS_TX_WIN_OPEN);
+	switch (cmd) {
+
+	case VAS_TX_WIN_OPEN:
+		return nxftw_ioc_open_tx_window(fp, arg);
+
+	case VAS_RX_WIN_OPEN:
+		return nxftw_ioc_open_rx_window(fp, arg);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+const struct file_operations nxftw_fops = {
+	.owner = THIS_MODULE,
+	.open = nxftw_open,
+	.release = nxftw_release,
+	.read = nxftw_read,
+	.write = nxftw_write,
+	.mmap = nxftw_mmap,
+	.unlocked_ioctl = nxftw_ioctl,
+};
+
+
+int nxftw_file_init(void)
+{
+	int rc;
+	dev_t devno;
+
+	rc = alloc_chrdev_region(&nxftw_devt, 1, 1, "nx-ftw");
+	if (rc) {
+		pr_err("Unable to allocate nxftw major number: %i\n", rc);
+		return rc;
+	}
+
+	pr_devel("NX-FTW device allocated, dev [%i,%i]\n", MAJOR(nxftw_devt),
+			MINOR(nxftw_devt));
+
+	nxftw_dbgfs_class = class_create(THIS_MODULE, "nxftw");
+	if (IS_ERR(nxftw_dbgfs_class)) {
+		pr_err("Unable to create NX-FTW class\n");
+		rc = PTR_ERR(nxftw_dbgfs_class);
+		goto err;
+	}
+	nxftw_dbgfs_class->devnode = nxftw_devnode;
+
+	cdev_init(&nxftw_device.cdev, &nxftw_fops);
+
+	devno = MKDEV(MAJOR(nxftw_devt), 0);
+	if (cdev_add(&nxftw_device.cdev, devno, 1)) {
+		pr_err("NX-FTW: cdev_add() failed\n");
+		goto err;
+	}
+
+	nxftw_device.device = device_create(nxftw_dbgfs_class, NULL,
+			devno, NULL, nxftw_dev_name, MINOR(devno));
+	if (IS_ERR(nxftw_device.device)) {
+		pr_err("Unable to create nxftw-%d\n", MINOR(devno));
+		goto err;
+	}
+
+	pr_devel("%s: Added dev [%d,%d]\n", __func__, MAJOR(devno),
+			MINOR(devno));
+	return 0;
+
+err:
+	unregister_chrdev_region(nxftw_devt, 1);
+	return rc;
+}
+
+void nxftw_file_exit(void)
+{
+	dev_t devno;
+
+	pr_devel("NX-FTW: %s entered\n", __func__);
+
+	cdev_del(&nxftw_device.cdev);
+	devno = MKDEV(MAJOR(nxftw_devt), MINOR(nxftw_devt));
+	device_destroy(nxftw_dbgfs_class, devno);
+
+	class_destroy(nxftw_dbgfs_class);
+	unregister_chrdev_region(nxftw_devt, 1);
+}
+
+
+/*
+ * Create a debugfs entry. Not sure what for yet, though
+ */
+int __init nxftw_debugfs_init(void)
+{
+	struct dentry *ent;
+
+	ent = debugfs_create_dir("nxftw", NULL);
+	if (IS_ERR(ent)) {
+		pr_devel("nxftw: %s(): error creating dbgfs dir\n", __func__);
+		return PTR_ERR(ent);
+	}
+	nxftw_debugfs = ent;
+
+	return 0;
+}
+
+void nxftw_debugfs_exit(void)
+{
+	debugfs_remove_recursive(nxftw_debugfs);
+}
+
+int __init nxftw_init(void)
+{
+	int rc;
+
+	rc = nxftw_file_init();
+	if (rc)
+		return rc;
+
+	rc = nxftw_debugfs_init();
+	if (rc)
+		goto free_file;
+
+	pr_err("NX-FTW Device initialized\n");
+
+	return 0;
+
+free_file:
+	nxftw_file_exit();
+	return rc;
+}
+
+void __init nxftw_exit(void)
+{
+	pr_devel("NX-FTW Device exiting\n");
+	nxftw_debugfs_exit();
+	nxftw_file_exit();
+}
+
+module_init(nxftw_init);
+module_exit(nxftw_exit);
+
+MODULE_DESCRIPTION("IBM NX Fast Thread Wakeup Device");
+MODULE_AUTHOR("Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>");
+MODULE_LICENSE("GPL");
-- 
2.7.4
