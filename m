Return-Path: <sonny@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26AF3DDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 17:15:28 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5I7FOOi001947
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 03:15:24 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5I7FOcV124050
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 01:15:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5I7FOBd003189
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 01:15:24 -0600
Received: from us.ibm.com (zoidberg.austin.ibm.com [9.41.41.81])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5I7FNPh003176
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 01:15:23 -0600
Resent-Message-ID: <20080618071523.GD29409@localhost.localdomain>
Date: Wed, 18 Jun 2008 01:51:23 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] Power5,Power6 BSR driver
Message-ID: <20080618065123.GB13318@localhost.localdomain>
References: <20080616185344.GB16192@gamma> <20080617223952.GA9594@localdomain>
	<20080617224443.GD7552@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080617224443.GD7552@localhost.localdomain>
Cc: sonnyrao@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2008 at 05:44:43PM -0500, Sonny Rao wrote:
> On Tue, Jun 17, 2008 at 05:39:52PM -0500, Nathan Lynch wrote:
> > Hi, mainly a couple of coding style things, but one minor bug (I
> > think).
<snip>
> 
> Ok Will fix and send out again

From: Sonny Rao <sonnyrao@us.ibm.com>

Adds a character driver for BSR support on IBM POWER systems including 
Power5 and Power6.  The BSR is an optional processor facility not currently 
implemented by any other processors.  It's primary purpose is large SMP 
synchronization.  More details on the BSR are in comments to the code which 
follows.

After addressing any issues from the community I'm hoping this can be queued
for 2.6.27.

Signed-off-by: Sonny Rao <sonnyrao@us.ibm.com>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

Index: linux-2.6.24/drivers/char/bsr.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.24/drivers/char/bsr.c	2008-06-18 01:45:49.000000000 -0500
@@ -0,0 +1,309 @@
+/* IBM POWER Barrier Synchronization Register Driver
+ *
+ * Copyright IBM Corporation 2008
+ *
+ * Author: Sonny Rao <sonnyrao@us.ibm.com>
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
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/module.h>
+#include <linux/cdev.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <asm/io.h>
+
+/*
+ This driver exposes a special register which can be used for fast
+ synchronization across a large SMP machine.  The hardware is exposed
+ as an array of bytes where each process will write to one of the bytes to
+ indicate it has finished the current stage and this update is broadcast to
+ all processors without having to bounce a cacheline between them. In
+ POWER5 and POWER6 there is one of these registers per SMP,  but it is
+ presented in two forms; first, it is given as a whole and then as a number
+ of smaller registers which alias to parts of the single whole register.
+ This can potentially allow multiple groups of processes to each have their
+ own private synchronization device.
+
+ Note that this hardware *must* be written to using *only* single byte writes.
+ It may be read using 1, 2, 4, or 8 byte loads which must be aligned since
+ this region is treated as cache-inhibited  processes should also use a
+ full sync before and after writing to the BSR to ensure all stores and
+ the BSR update have made it to all chips in the system
+*/
+
+/* This is arbitrary number, up to Power6 it's been 17 or fewer  */
+#define BSR_MAX_DEVS (32)
+
+struct bsr_dev {
+	u64      bsr_addr;     /* Real address */
+	u64      bsr_len;      /* length of mem region we can map */
+	unsigned bsr_bytes;    /* size of the BSR reg itself */
+	unsigned bsr_stride;   /* interval at which BSR repeats in the page */
+	unsigned bsr_type;     /* maps to enum below */
+	unsigned bsr_num;      /* bsr id number for its type */
+	int      bsr_minor;
+
+	dev_t    bsr_dev;
+	struct cdev bsr_cdev;
+	struct device *bsr_device;
+	char     bsr_name[32];
+
+};
+
+static unsigned num_bsr_devs;
+static struct bsr_dev *bsr_devs;
+static struct class *bsr_class;
+static int bsr_major;
+
+enum {
+	BSR_8   = 0,
+	BSR_16  = 1,
+	BSR_64  = 2,
+	BSR_128 = 3,
+	BSR_UNKNOWN = 4,
+	BSR_MAX = 5,
+};
+
+static unsigned bsr_types[BSR_MAX];
+
+static ssize_t
+bsr_size_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct bsr_dev *bsr_dev = dev_get_drvdata(dev);
+	return sprintf(buf, "%u\n", bsr_dev->bsr_bytes);
+}
+
+static ssize_t
+bsr_stride_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct bsr_dev *bsr_dev = dev_get_drvdata(dev);
+	return sprintf(buf, "%u\n", bsr_dev->bsr_stride);
+}
+
+static ssize_t
+bsr_len_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct bsr_dev *bsr_dev = dev_get_drvdata(dev);
+	return sprintf(buf, "%lu\n", bsr_dev->bsr_len);
+}
+
+static struct device_attribute bsr_dev_attrs[] = {
+	__ATTR(bsr_size, S_IRUGO, bsr_size_show, NULL),
+	__ATTR(bsr_stride, S_IRUGO, bsr_stride_show, NULL),
+	__ATTR(bsr_length, S_IRUGO, bsr_len_show, NULL),
+	__ATTR_NULL
+};
+
+static int bsr_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	unsigned long size   = vma->vm_end - vma->vm_start;
+	struct bsr_dev *dev = filp->private_data;
+
+	if (size > dev->bsr_len || (size & (PAGE_SIZE-1)))
+		return -EINVAL;
+
+	vma->vm_flags |= (VM_IO | VM_DONTEXPAND);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	if (io_remap_pfn_range(vma, vma->vm_start, dev->bsr_addr >> PAGE_SHIFT,
+			       size, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static int bsr_open(struct inode * inode, struct file * filp)
+{
+	struct cdev *cdev = inode->i_cdev;
+	struct bsr_dev *dev = container_of(cdev, struct bsr_dev, bsr_cdev);
+
+	filp->private_data = dev;
+	return 0;
+}
+
+const static struct file_operations bsr_fops = {
+	.owner = THIS_MODULE,
+	.mmap  = bsr_mmap,
+	.open  = bsr_open,
+};
+
+static void bsr_cleanup_devs(void)
+{
+	int i;
+	for (i=0 ; i < num_bsr_devs; i++) {
+		struct bsr_dev *cur = bsr_devs + i;
+		if (cur->bsr_device) {
+			cdev_del(&cur->bsr_cdev);
+			device_del(cur->bsr_device);
+		}
+	}
+
+	kfree(bsr_devs);
+}
+
+static int bsr_create_devs(struct device_node *bn)
+{
+	int reg_len, bsr_stride_len, bsr_bytes_len;
+	const u64 *reg;
+	const u32 *bsr_stride;
+	const u32 *bsr_bytes;
+	unsigned i;
+
+	reg        = of_get_property(bn, "reg", &reg_len);
+	bsr_stride = of_get_property(bn, "ibm,lock-stride", &bsr_stride_len);
+	bsr_bytes  = of_get_property(bn, "ibm,#lock-bytes", &bsr_bytes_len);
+
+	if (!reg || !bsr_stride || !bsr_bytes ||
+	    (bsr_stride_len != bsr_bytes_len) ||
+	    (bsr_stride_len / 4 != reg_len / 16)) {
+		printk(KERN_ERR "bsr of-node has missing/incorrect property\n");
+		return -ENODEV;
+	}
+
+	num_bsr_devs = reg_len / 16;
+
+	/* only a warning, its informational since we'll fail and exit */
+	WARN_ON(num_bsr_devs > BSR_MAX_DEVS);
+
+	bsr_devs = kzalloc(sizeof(struct bsr_dev) * num_bsr_devs, GFP_KERNEL);
+	if (!bsr_devs)
+		return -ENOMEM;
+
+	for (i = 0 ; i < num_bsr_devs; i++) {
+		struct bsr_dev *cur = bsr_devs + i;
+		int result;
+
+		cur->bsr_minor  = i;
+		cur->bsr_addr   = reg[i * 2];
+		cur->bsr_len    = reg[i * 2 + 1];
+		cur->bsr_bytes  = bsr_bytes[i];
+		cur->bsr_stride = bsr_stride[i];
+		cur->bsr_dev    = MKDEV(bsr_major, i);
+
+		switch(cur->bsr_bytes) {
+		case 8:
+			cur->bsr_type = BSR_8;
+			break;
+		case 16:
+			cur->bsr_type = BSR_16;
+			break;
+		case 64:
+			cur->bsr_type = BSR_64;
+			break;
+		case 128:
+			cur->bsr_type = BSR_128;
+			break;
+		default:
+			cur->bsr_type = BSR_UNKNOWN;
+			printk(KERN_INFO "unknown BSR size %d\n",cur->bsr_bytes);
+		}
+
+		cur->bsr_num = bsr_types[cur->bsr_type];
+		bsr_types[cur->bsr_type] = cur->bsr_num + 1;
+		snprintf(cur->bsr_name, 32, "bsr%d_%d",
+			 cur->bsr_bytes, cur->bsr_num);
+
+		cdev_init(&cur->bsr_cdev, &bsr_fops);
+		result = cdev_add(&cur->bsr_cdev, cur->bsr_dev, 1);
+		if (result)
+			goto out_err;
+
+		cur->bsr_device = device_create(bsr_class, NULL,
+						cur->bsr_dev,
+						cur->bsr_name);
+		if (!cur->bsr_device) {
+			printk(KERN_ERR "device_create failed for %s\n",
+			       cur->bsr_name);
+			cdev_del(&cur->bsr_cdev);
+			goto out_err;
+		}
+		dev_set_drvdata(cur->bsr_device, cur);
+	}
+
+	return 0;
+
+ out_err:
+
+	bsr_cleanup_devs();
+	return -ENODEV;
+}
+
+static int __init bsr_init(void)
+{
+	struct device_node *np;
+	dev_t bsr_dev = MKDEV(bsr_major, 0);
+	int ret = -ENODEV;
+	int result;
+
+	np = of_find_compatible_node(NULL, "ibm,bsr", "ibm,bsr");
+	if (!np)
+		goto out_err;
+
+	bsr_class = class_create(THIS_MODULE, "bsr");
+	if (IS_ERR(bsr_class)) {
+		printk(KERN_ERR "class_create() failed for bsr_class\n");
+		goto out_err_1;
+	}
+	bsr_class->dev_attrs = bsr_dev_attrs;
+
+	result = alloc_chrdev_region(&bsr_dev, 0, BSR_MAX_DEVS, "bsr");
+	bsr_major = MAJOR(bsr_dev);
+	if (result < 0) {
+		printk(KERN_ERR "alloc_chrdev_region() failed for bsr\n");
+		goto out_err_2;
+	}
+
+	if ((ret = bsr_create_devs(np)) < 0)
+		goto out_err_3;
+
+	of_node_put(np);
+
+	return 0;
+
+ out_err_3:
+	unregister_chrdev_region(bsr_dev, BSR_MAX_DEVS);
+
+ out_err_2:
+	class_destroy(bsr_class);
+
+ out_err_1:
+	of_node_put(np);
+
+ out_err:
+
+	return ret;
+}
+
+static void __exit  bsr_exit(void)
+{
+
+	bsr_cleanup_devs();
+
+	if (bsr_class)
+		class_destroy(bsr_class);
+
+	if (bsr_major)
+		unregister_chrdev_region(MKDEV(bsr_major, 0), BSR_MAX_DEVS);
+}
+
+module_init(bsr_init);
+module_exit(bsr_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sonny Rao <sonnyrao@us.ibm.com>");
Index: linux-2.6.24/drivers/char/Makefile
===================================================================
--- linux-2.6.24.orig/drivers/char/Makefile	2008-06-18 01:24:04.000000000 -0500
+++ linux-2.6.24/drivers/char/Makefile	2008-06-18 01:38:30.000000000 -0500
@@ -57,6 +57,7 @@
 obj-$(CONFIG_VIOCONS)		+= viocons.o
 obj-$(CONFIG_VIOTAPE)		+= viotape.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
+obj-$(CONFIG_IBM_BSR)		+= bsr.o
 obj-$(CONFIG_SGI_MBCS)		+= mbcs.o
 obj-$(CONFIG_BRIQ_PANEL)	+= briq_panel.o
 obj-$(CONFIG_BFIN_OTP)		+= bfin-otp.o
Index: linux-2.6.24/drivers/char/Kconfig
===================================================================
--- linux-2.6.24.orig/drivers/char/Kconfig	2008-06-18 01:24:04.000000000 -0500
+++ linux-2.6.24/drivers/char/Kconfig	2008-06-18 01:38:30.000000000 -0500
@@ -649,6 +649,14 @@
 	  which will also be compiled when this driver is built as a
 	  module.

+config IBM_BSR
+	tristate "IBM POWER Barrier Synchronization Register support"
+	depends on PPC_PSERIES
+	help
+	  This devices exposes a hardware mechanism for fast synchronization
+	  of threads across a large system which avoids bouncing a cacheline
+	  between several cores on a system
+
 source "drivers/char/ipmi/Kconfig"

 config DS1620
