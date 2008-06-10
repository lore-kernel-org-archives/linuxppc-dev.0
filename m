Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id AEDEADDF18
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 00:39:46 +1000 (EST)
Message-Id: <20080610142947.843882957@arndb.de>
References: <20080610142702.354823071@arndb.de>
Date: Tue, 10 Jun 2008 16:27:04 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [PATCH 2/5] powerpc: remove hdpu drivers
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The CONFIG_HDPU option is gone with the removal of arch/ppc,
so the drivers have become dead code that can be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/Makefile                 |    1 -
 drivers/misc/hdpuftrs/Makefile        |    1 -
 drivers/misc/hdpuftrs/hdpu_cpustate.c |  249 ---------------------------------
 drivers/misc/hdpuftrs/hdpu_nexus.c    |  150 --------------------
 4 files changed, 0 insertions(+), 401 deletions(-)
 delete mode 100644 drivers/misc/hdpuftrs/Makefile
 delete mode 100644 drivers/misc/hdpuftrs/hdpu_cpustate.c
 delete mode 100644 drivers/misc/hdpuftrs/hdpu_nexus.c

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 1952875..93ae3b3 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -4,7 +4,6 @@
 obj- := misc.o	# Dummy rule to force built-in.o to be made
 
 obj-$(CONFIG_IBM_ASM)		+= ibmasm/
-obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
 obj-$(CONFIG_MSI_LAPTOP)     += msi-laptop.o
 obj-$(CONFIG_ACER_WMI)     += acer-wmi.o
 obj-$(CONFIG_ASUS_LAPTOP)	+= asus-laptop.o
diff --git a/drivers/misc/hdpuftrs/Makefile b/drivers/misc/hdpuftrs/Makefile
deleted file mode 100644
index ac74ae6..0000000
--- a/drivers/misc/hdpuftrs/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_HDPU_FEATURES) := hdpu_cpustate.o hdpu_nexus.o
diff --git a/drivers/misc/hdpuftrs/hdpu_cpustate.c b/drivers/misc/hdpuftrs/hdpu_cpustate.c
deleted file mode 100644
index ff51ab6..0000000
--- a/drivers/misc/hdpuftrs/hdpu_cpustate.c
+++ /dev/null
@@ -1,249 +0,0 @@
-/*
- *	Sky CPU State Driver
- *
- *	Copyright (C) 2002 Brian Waite
- *
- *	This driver allows use of the CPU state bits
- *	It exports the /dev/sky_cpustate and also
- *	/proc/sky_cpustate pseudo-file for status information.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/spinlock.h>
-#include <linux/miscdevice.h>
-#include <linux/proc_fs.h>
-#include <linux/hdpu_features.h>
-#include <linux/platform_device.h>
-#include <asm/uaccess.h>
-#include <linux/seq_file.h>
-#include <asm/io.h>
-
-#define SKY_CPUSTATE_VERSION		"1.1"
-
-static int hdpu_cpustate_probe(struct platform_device *pdev);
-static int hdpu_cpustate_remove(struct platform_device *pdev);
-
-static unsigned char cpustate_get_state(void);
-static int cpustate_proc_open(struct inode *inode, struct file *file);
-static int cpustate_proc_read(struct seq_file *seq, void *offset);
-
-static struct cpustate_t cpustate;
-
-static const struct file_operations proc_cpustate = {
-	.open = cpustate_proc_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static int cpustate_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cpustate_proc_read, NULL);
-}
-
-static int cpustate_proc_read(struct seq_file *seq, void *offset)
-{
-	seq_printf(seq, "CPU State: %04x\n", cpustate_get_state());
-	return 0;
-}
-
-static int cpustate_get_ref(int excl)
-{
-
-	int retval = -EBUSY;
-
-	spin_lock(&cpustate.lock);
-
-	if (cpustate.excl)
-		goto out_busy;
-
-	if (excl) {
-		if (cpustate.open_count)
-			goto out_busy;
-		cpustate.excl = 1;
-	}
-
-	cpustate.open_count++;
-	retval = 0;
-
-      out_busy:
-	spin_unlock(&cpustate.lock);
-	return retval;
-}
-
-static int cpustate_free_ref(void)
-{
-
-	spin_lock(&cpustate.lock);
-
-	cpustate.excl = 0;
-	cpustate.open_count--;
-
-	spin_unlock(&cpustate.lock);
-	return 0;
-}
-
-static unsigned char cpustate_get_state(void)
-{
-
-	return cpustate.cached_val;
-}
-
-static void cpustate_set_state(unsigned char new_state)
-{
-	unsigned int state = (new_state << 21);
-
-#ifdef DEBUG_CPUSTATE
-	printk("CPUSTATE -> 0x%x\n", new_state);
-#endif
-	spin_lock(&cpustate.lock);
-	cpustate.cached_val = new_state;
-	writel((0xff << 21), cpustate.clr_addr);
-	writel(state, cpustate.set_addr);
-	spin_unlock(&cpustate.lock);
-}
-
-/*
- *	Now all the various file operations that we export.
- */
-
-static ssize_t cpustate_read(struct file *file, char *buf,
-			     size_t count, loff_t * ppos)
-{
-	unsigned char data;
-
-	if (count < 0)
-		return -EFAULT;
-	if (count == 0)
-		return 0;
-
-	data = cpustate_get_state();
-	if (copy_to_user(buf, &data, sizeof(unsigned char)))
-		return -EFAULT;
-	return sizeof(unsigned char);
-}
-
-static ssize_t cpustate_write(struct file *file, const char *buf,
-			      size_t count, loff_t * ppos)
-{
-	unsigned char data;
-
-	if (count < 0)
-		return -EFAULT;
-
-	if (count == 0)
-		return 0;
-
-	if (copy_from_user((unsigned char *)&data, buf, sizeof(unsigned char)))
-		return -EFAULT;
-
-	cpustate_set_state(data);
-	return sizeof(unsigned char);
-}
-
-static int cpustate_open(struct inode *inode, struct file *file)
-{
-	return cpustate_get_ref((file->f_flags & O_EXCL));
-}
-
-static int cpustate_release(struct inode *inode, struct file *file)
-{
-	return cpustate_free_ref();
-}
-
-static struct platform_driver hdpu_cpustate_driver = {
-	.probe = hdpu_cpustate_probe,
-	.remove = hdpu_cpustate_remove,
-	.driver = {
-		.name = HDPU_CPUSTATE_NAME,
-		.owner = THIS_MODULE,
-	},
-};
-
-/*
- *	The various file operations we support.
- */
-static const struct file_operations cpustate_fops = {
-      .owner	= THIS_MODULE,
-      .open	= cpustate_open,
-      .release	= cpustate_release,
-      .read	= cpustate_read,
-      .write	= cpustate_write,
-      .llseek	= no_llseek,
-};
-
-static struct miscdevice cpustate_dev = {
-	.minor	= MISC_DYNAMIC_MINOR,
-	.name	= "sky_cpustate",
-	.fops	= &cpustate_fops,
-};
-
-static int hdpu_cpustate_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-	struct proc_dir_entry *proc_de;
-	int ret;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		printk(KERN_ERR "sky_cpustate: "
-		       "Invalid memory resource.\n");
-		return -EINVAL;
-	}
-	cpustate.set_addr = (unsigned long *)res->start;
-	cpustate.clr_addr = (unsigned long *)res->end - 1;
-
-	ret = misc_register(&cpustate_dev);
-	if (ret) {
-		printk(KERN_WARNING "sky_cpustate: "
-		       "Unable to register misc device.\n");
-		cpustate.set_addr = NULL;
-		cpustate.clr_addr = NULL;
-		return ret;
-	}
-
-	proc_de = proc_create("sky_cpustate", 0666, NULL, &proc_cpustate);
-	if (!proc_de) {
-		printk(KERN_WARNING "sky_cpustate: "
-		       "Unable to create proc entry\n");
-	}
-
-	printk(KERN_INFO "Sky CPU State Driver v" SKY_CPUSTATE_VERSION "\n");
-	return 0;
-}
-
-static int hdpu_cpustate_remove(struct platform_device *pdev)
-{
-	cpustate.set_addr = NULL;
-	cpustate.clr_addr = NULL;
-
-	remove_proc_entry("sky_cpustate", NULL);
-	misc_deregister(&cpustate_dev);
-
-	return 0;
-}
-
-static int __init cpustate_init(void)
-{
-	return platform_driver_register(&hdpu_cpustate_driver);
-}
-
-static void __exit cpustate_exit(void)
-{
-	platform_driver_unregister(&hdpu_cpustate_driver);
-}
-
-module_init(cpustate_init);
-module_exit(cpustate_exit);
-
-MODULE_AUTHOR("Brian Waite");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" HDPU_CPUSTATE_NAME);
diff --git a/drivers/misc/hdpuftrs/hdpu_nexus.c b/drivers/misc/hdpuftrs/hdpu_nexus.c
deleted file mode 100644
index 08e26be..0000000
--- a/drivers/misc/hdpuftrs/hdpu_nexus.c
+++ /dev/null
@@ -1,150 +0,0 @@
-/*
- *	Sky Nexus Register Driver
- *
- *	Copyright (C) 2002 Brian Waite
- *
- *	This driver allows reading the Nexus register
- *	It exports the /proc/sky_chassis_id and also
- *	/proc/sky_slot_id pseudo-file for status information.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/proc_fs.h>
-#include <linux/hdpu_features.h>
-#include <linux/platform_device.h>
-#include <linux/seq_file.h>
-#include <asm/io.h>
-
-static int hdpu_nexus_probe(struct platform_device *pdev);
-static int hdpu_nexus_remove(struct platform_device *pdev);
-static int hdpu_slot_id_open(struct inode *inode, struct file *file);
-static int hdpu_slot_id_read(struct seq_file *seq, void *offset);
-static int hdpu_chassis_id_open(struct inode *inode, struct file *file);
-static int hdpu_chassis_id_read(struct seq_file *seq, void *offset);
-
-static struct proc_dir_entry *hdpu_slot_id;
-static struct proc_dir_entry *hdpu_chassis_id;
-static int slot_id = -1;
-static int chassis_id = -1;
-
-static const struct file_operations proc_slot_id = {
-	.open = hdpu_slot_id_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static const struct file_operations proc_chassis_id = {
-	.open = hdpu_chassis_id_open,
-	.read = seq_read,
-	.llseek	= seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
-static struct platform_driver hdpu_nexus_driver = {
-	.probe = hdpu_nexus_probe,
-	.remove = hdpu_nexus_remove,
-	.driver = {
-		.name = HDPU_NEXUS_NAME,
-		.owner = THIS_MODULE,
-	},
-};
-
-static int hdpu_slot_id_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hdpu_slot_id_read, NULL);
-}
-
-static int hdpu_slot_id_read(struct seq_file *seq, void *offset)
-{
-	seq_printf(seq, "%d\n", slot_id);
-	return 0;
-}
-
-static int hdpu_chassis_id_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hdpu_chassis_id_read, NULL);
-}
-
-static int hdpu_chassis_id_read(struct seq_file *seq, void *offset)
-{
-	seq_printf(seq, "%d\n", chassis_id);
-	return 0;
-}
-
-static int hdpu_nexus_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-	int *nexus_id_addr;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		printk(KERN_ERR "sky_nexus: "
-		       "Invalid memory resource.\n");
-		return -EINVAL;
-	}
-	nexus_id_addr = ioremap(res->start,
-				(unsigned long)(res->end - res->start));
-	if (nexus_id_addr) {
-		slot_id = (*nexus_id_addr >> 8) & 0x1f;
-		chassis_id = *nexus_id_addr & 0xff;
-		iounmap(nexus_id_addr);
-	} else {
-		printk(KERN_ERR "sky_nexus: Could not map slot id\n");
-	}
-
-	hdpu_slot_id = proc_create("sky_slot_id", 0666, NULL, &proc_slot_id);
-	if (!hdpu_slot_id) {
-		printk(KERN_WARNING "sky_nexus: "
-		       "Unable to create proc dir entry: sky_slot_id\n");
-	}
-
-	hdpu_chassis_id = proc_create("sky_chassis_id", 0666, NULL,
-				      &proc_chassis_id);
-	if (!hdpu_chassis_id)
-		printk(KERN_WARNING "sky_nexus: "
-		       "Unable to create proc dir entry: sky_chassis_id\n");
-	}
-
-	return 0;
-}
-
-static int hdpu_nexus_remove(struct platform_device *pdev)
-{
-	slot_id = -1;
-	chassis_id = -1;
-
-	remove_proc_entry("sky_slot_id", NULL);
-	remove_proc_entry("sky_chassis_id", NULL);
-
-	hdpu_slot_id = 0;
-	hdpu_chassis_id = 0;
-
-	return 0;
-}
-
-static int __init nexus_init(void)
-{
-	return platform_driver_register(&hdpu_nexus_driver);
-}
-
-static void __exit nexus_exit(void)
-{
-	platform_driver_unregister(&hdpu_nexus_driver);
-}
-
-module_init(nexus_init);
-module_exit(nexus_exit);
-
-MODULE_AUTHOR("Brian Waite");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" HDPU_NEXUS_NAME);
-- 
1.5.4.3

-- 
