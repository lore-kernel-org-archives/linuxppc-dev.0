Return-Path: <waite@skycomputers.com>
Received: from sky.skycomputers.com (sky.skycomputers.com [198.4.246.2])
	by ozlabs.org (Postfix) with ESMTP id EA0DC67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 02:35:42 +1100 (EST)
From: Brian Waite <waite@skycomputers.com>
To: linuxppc-embedded@ozlabs.org, "Mark A. Greer" <mgreer@mvista.com>
Date: Thu, 17 Mar 2005 09:53:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200503170953.08829.waite@skycomputers.com>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ppc32:1/2 add support for Sky Computers HDPU Compute blade
	enhanced features
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add support for Sky Computers HDPU Compute blade enhanced features

Signed-off-by: Brian Waite <waite@skycomputers.com>

The Sky Computers HDPU compute blade is an embedded compute platform for the 
Sky Computers SMARTpac 600/1200 series. The blade consists of 
ppc7445/ppc7447A UP or SMP, Marvell Discovery II,  100 BaseT ethernet, a 
single 
PCI/PCI-X slot, and a PCI-X on-board Infiniband device.

This patch contains drivers for enhanced features of the HDPU compute blade. 
Namely, 2 drivers for registers used by the Health monitoring co-processor. 
The cpustate
register is a write only register used to convey critical states to the health 
monitor and the 
nexus registers provides a read-only interface from the health monitoring 
system to provide 
location based information. 

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/arch/ppc/Kconfig 
linux-2.5-hdpu/arch/ppc/Kconfig
--- linux-2.5/arch/ppc/Kconfig	2005-03-16 14:52:37 -05:00
+++ linux-2.5-hdpu/arch/ppc/Kconfig	2005-03-16 14:01:21 -05:00
@@ -543,6 +543,12 @@
 	help
 	  Select HDPU if configuring a Sky Computers Compute Blade.
 
+config HDPU_FEATURES
+	depends HDPU
+	tristate "HDPU-Features"
+	help
+	  Select to enable HDPU enhanced features.
+
 config EV64260
 	bool "Marvell-EV64260BP"
 	help
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/include/linux/hdpu_features.h 
linux-2.5-hdpu/include/linux/hdpu_features.h
--- linux-2.5/include/linux/hdpu_features.h	1969-12-31 19:00:00 -05:00
+++ linux-2.5-hdpu/include/linux/hdpu_features.h	2005-03-16 14:03:18 -05:00
@@ -0,0 +1,26 @@
+#include <linux/spinlock.h>
+
+struct cpustate_t {
+	spinlock_t lock;
+	int excl;
+        int open_count;
+	unsigned char cached_val;
+	int inited;
+	unsigned long *set_addr;
+	unsigned long *clr_addr;
+}; 
+
+
+#define HDPU_CPUSTATE_NAME "hdpu cpustate"
+#define HDPU_NEXUS_NAME "hdpu nexus"
+
+#define CPUSTATE_KERNEL_MAJOR  0x10
+
+#define CPUSTATE_KERNEL_INIT_DRV   0 /* CPU State Driver Initialized */
+#define CPUSTATE_KERNEL_INIT_PCI   1 /* 64360 PCI Busses Init */
+#define CPUSTATE_KERNEL_INIT_REG   2 /* 64360 Bridge Init */
+#define CPUSTATE_KERNEL_CPU1_KICK  3 /* Boot cpu 1 */
+#define CPUSTATE_KERNEL_CPU1_OK    4  /* Cpu 1 has checked in */
+#define CPUSTATE_KERNEL_OK         5 /* Terminal state */
+#define CPUSTATE_KERNEL_RESET   14 /* Board reset via SW*/
+#define CPUSTATE_KERNEL_HALT   15 /* Board halted via SW*/
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/arch/ppc/platforms/hdpu.c 
linux-2.5-hdpu/arch/ppc/platforms/hdpu.c
--- linux-2.5/arch/ppc/platforms/hdpu.c	1969-12-31 19:00:00 -05:00
+++ linux-2.5-hdpu/arch/ppc/platforms/hdpu.c	2005-03-16 14:03:18 -05:00
36a37
> #include <linux/hdpu_features.h>
57a59
> static void hdpu_cpustate_set(unsigned char new_state);
252a255,256
> 	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_INIT_PCI);
> 
260a265
> 	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_INIT_REG);
330a336,344
> #if defined(CONFIG_HDPU_FEATURES)
> static void __init hdpu_fixup_cpustate_pdata(struct platform_device *pd)
> {
> 	struct platform_device *pds[1];
> 	pds[0] = pd;
> 	mv64x60_pd_fixup(&bh, pds, 1);
> }
> #endif
> 
342a357,360
> #if defined(CONFIG_HDPU_FEATURES)
> 		{
> 		HDPU_CPUSTATE_NAME ".0", hdpu_fixup_cpustate_pdata},
> #endif
405a424
> 	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_OK);
443a463,464
> 	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_RESET);
> 
487a509,510
> 	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_HALT);
> 
755a779,780
> 	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_CPU1_KICK);
> 
819a845,847
> 		hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR |
> 				  CPUSTATE_KERNEL_CPU1_OK);
> 
933a962,968
> static void hdpu_cpustate_set(unsigned char new_state)
> {
> 	unsigned int state = (new_state << 21);
> 	mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, (0xff << 21));
> 	mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, state);
> }
> 
973a1009,1051
> #ifdef CONFIG_HDPU_FEATURES
> 
> static struct resource hdpu_cpustate_resources[] = {
> 	[0] = {
> 	       .name = "addr base",
> 	       .start = MV64x60_GPP_VALUE_SET,
> 	       .end = MV64x60_GPP_VALUE_CLR + 1,
> 	       .flags = IORESOURCE_MEM,
> 	       },
> };
> 
> static struct resource hdpu_nexus_resources[] = {
> 	[0] = {
> 	       .name = "nexus register",
> 	       .start = HDPU_NEXUS_ID_BASE,
> 	       .end = HDPU_NEXUS_ID_BASE + HDPU_NEXUS_ID_SIZE,
> 	       .flags = IORESOURCE_MEM,
> 	       },
> };
> 
> static struct platform_device hdpu_cpustate_device = {
> 	.name = HDPU_CPUSTATE_NAME,
> 	.id = 0,
> 	.num_resources = ARRAY_SIZE(hdpu_cpustate_resources),
> 	.resource = hdpu_cpustate_resources,
> };
> 
> static struct platform_device hdpu_nexus_device = {
> 	.name = HDPU_NEXUS_NAME,
> 	.id = 0,
> 	.num_resources = ARRAY_SIZE(hdpu_nexus_resources),
> 	.resource = hdpu_nexus_resources,
> };
> 
> static int __init hdpu_add_pds(void)
> {
> 	platform_device_register(&hdpu_cpustate_device);
> 	platform_device_register(&hdpu_nexus_device);
> 	return 0;
> }
> 
> arch_initcall(hdpu_add_pds);
> #endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/drivers/misc/Makefile 
linux-2.5-hdpu/drivers/misc/Makefile
--- linux-2.5/drivers/misc/Makefile	2005-03-16 14:15:39 -05:00
+++ linux-2.5-hdpu/drivers/misc/Makefile	2005-03-16 14:02:09 -05:00
@@ -4,3 +4,4 @@
 obj- := misc.o	# Dummy rule to force built-in.o to be made
 
 obj-$(CONFIG_IBM_ASM)	+= ibmasm/
+obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/drivers/misc/hdpuftrs/Makefile 
linux-2.5-hdpu/drivers/misc/hdpuftrs/Makefile
--- linux-2.5/drivers/misc/hdpuftrs/Makefile	1969-12-31 19:00:00 -05:00
+++ linux-2.5-hdpu/drivers/misc/hdpuftrs/Makefile	2005-03-16 14:02:09 -05:00
@@ -0,0 +1 @@
+obj-$(CONFIG_HDPU_FEATURES) := hdpu_cpustate.o hdpu_nexus.o
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/drivers/misc/hdpuftrs/hdpu_cpustate.c 
linux-2.5-hdpu/drivers/misc/hdpuftrs/hdpu_cpustate.c
--- linux-2.5/drivers/misc/hdpuftrs/hdpu_cpustate.c	1969-12-31 19:00:00 -05:00
+++ linux-2.5-hdpu/drivers/misc/hdpuftrs/hdpu_cpustate.c	2005-03-16 14:02:09 
-05:00
@@ -0,0 +1,234 @@
+/*
+ *	Sky CPU State Driver
+ *
+ *	Copyright (C) 2002 Brian Waite 
+ *
+ *	This driver allows use of the CPU state bits
+ *	It exports the /dev/sky_cpustate and also
+ *	/proc/sky_cpustate pseudo-file for status information.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/miscdevice.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include <linux/device.h>
+#include <asm/uaccess.h>
+#include <linux/hdpu_features.h>
+
+#define SKY_CPUSTATE_VERSION		"1.1"
+
+static int hdpu_cpustate_probe(struct device *ddev);
+static int hdpu_cpustate_remove(struct device *ddev);
+
+struct cpustate_t cpustate;
+
+static int cpustate_get_ref(int excl)
+{
+
+	int retval = -EBUSY;
+
+	spin_lock(&cpustate.lock);
+
+	if (cpustate.excl)
+		goto out_busy;
+
+	if (excl) {
+		if (cpustate.open_count)
+			goto out_busy;
+		cpustate.excl = 1;
+	}
+
+	cpustate.open_count++;
+	retval = 0;
+
+      out_busy:
+	spin_unlock(&cpustate.lock);
+	return retval;
+}
+
+static int cpustate_free_ref(void)
+{
+
+	spin_lock(&cpustate.lock);
+
+	cpustate.excl = 0;
+	cpustate.open_count--;
+
+	spin_unlock(&cpustate.lock);
+	return 0;
+}
+
+unsigned char cpustate_get_state(void)
+{
+
+	return cpustate.cached_val;
+}
+
+void cpustate_set_state(unsigned char new_state)
+{
+	unsigned int state = (new_state << 21);
+
+#ifdef DEBUG_CPUSTATE
+	printk("CPUSTATE -> 0x%x\n", new_state);
+#endif
+	spin_lock(&cpustate.lock);
+	cpustate.cached_val = new_state;
+	writel((0xff << 21), cpustate.clr_addr);
+	writel(state, cpustate.set_addr);
+	spin_unlock(&cpustate.lock);
+}
+
+/*
+ *	Now all the various file operations that we export.
+ */
+
+static ssize_t cpustate_read(struct file *file, char *buf,
+			     size_t count, loff_t * ppos)
+{
+	unsigned char data;
+
+	if (count < 0)
+		return -EFAULT;
+	if (count == 0)
+		return 0;
+
+	data = cpustate_get_state();
+	if (copy_to_user(buf, &data, sizeof(unsigned char)))
+		return -EFAULT;
+	return sizeof(unsigned char);
+}
+
+static ssize_t cpustate_write(struct file *file, const char *buf,
+			      size_t count, loff_t * ppos)
+{
+	unsigned char data;
+
+	if (count < 0)
+		return -EFAULT;
+
+	if (count == 0)
+		return 0;
+
+	if (copy_from_user((unsigned char *)&data, buf, sizeof(unsigned char)))
+		return -EFAULT;
+
+	cpustate_set_state(data);
+	return sizeof(unsigned char);
+}
+
+static int cpustate_open(struct inode *inode, struct file *file)
+{
+	return cpustate_get_ref((file->f_flags & O_EXCL));
+}
+
+static int cpustate_release(struct inode *inode, struct file *file)
+{
+	return cpustate_free_ref();
+}
+
+/*
+ *	Info exported via "/proc/sky_cpustate".
+ */
+static int cpustate_read_proc(char *page, char **start, off_t off,
+			      int count, int *eof, void *data)
+{
+	char *p = page;
+	int len = 0;
+
+	p += sprintf(p, "CPU State: %04x\n", cpustate_get_state());
+	len = p - page;
+
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+	return len;
+}
+
+static struct device_driver hdpu_cpustate_driver = {
+	.name = HDPU_CPUSTATE_NAME,
+	.bus = &platform_bus_type,
+	.probe = hdpu_cpustate_probe,
+	.remove = hdpu_cpustate_remove,
+};
+
+/*
+ *	The various file operations we support.
+ */
+static struct file_operations cpustate_fops = {
+      owner:THIS_MODULE,
+      open:cpustate_open,
+      release:cpustate_release,
+      read:cpustate_read,
+      write:cpustate_write,
+      fasync:NULL,
+      poll:NULL,
+      ioctl:NULL,
+      llseek:no_llseek,
+
+};
+
+static struct miscdevice cpustate_dev = {
+	MISC_DYNAMIC_MINOR,
+	"sky_cpustate",
+	&cpustate_fops
+};
+
+static int hdpu_cpustate_probe(struct device *ddev)
+{
+	struct platform_device *pdev = to_platform_device(ddev);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cpustate.set_addr = (unsigned long *)res->start;
+	cpustate.clr_addr = (unsigned long *)res->end - 1;
+
+	misc_register(&cpustate_dev);
+	create_proc_read_entry("sky_cpustate", 0, 0, cpustate_read_proc, NULL);
+
+	printk(KERN_INFO "Sky CPU State Driver v" SKY_CPUSTATE_VERSION "\n");
+	return 0;
+}
+static int hdpu_cpustate_remove(struct device *ddev)
+{
+
+	cpustate.set_addr = 0;
+	cpustate.clr_addr = 0;
+
+	remove_proc_entry("sky_cpustate", NULL);
+	misc_deregister(&cpustate_dev);
+	return 0;
+
+}
+
+static int __init cpustate_init(void)
+{
+	int rc;
+	rc = driver_register(&hdpu_cpustate_driver);
+	return rc;
+}
+
+static void __exit cpustate_exit(void)
+{
+	driver_unregister(&hdpu_cpustate_driver);
+}
+
+module_init(cpustate_init);
+module_exit(cpustate_exit);
+
+MODULE_AUTHOR("Brian Waite");
+MODULE_LICENSE("GPL");
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper 
--exclude=ChangeSet linux-2.5/drivers/misc/hdpuftrs/hdpu_nexus.c 
linux-2.5-hdpu/drivers/misc/hdpuftrs/hdpu_nexus.c
--- linux-2.5/drivers/misc/hdpuftrs/hdpu_nexus.c	1969-12-31 19:00:00 -05:00
+++ linux-2.5-hdpu/drivers/misc/hdpuftrs/hdpu_nexus.c	2005-03-16 14:02:09 
-05:00
@@ -0,0 +1,111 @@
+/*
+ *	Sky Nexus Register Driver
+ *
+ *	Copyright (C) 2002 Brian Waite 
+ *
+ *	This driver allows reading the Nexus register
+ *	It exports the /proc/sky_chassis_id and also
+ *	/proc/sky_slot_id pseudo-file for status information.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/hdpu_features.h>
+#include <linux/pci.h>
+
+#include <linux/device.h>
+
+static int hdpu_nexus_probe(struct device *ddev);
+static int hdpu_nexus_remove(struct device *ddev);
+
+static struct proc_dir_entry *hdpu_slot_id;
+static struct proc_dir_entry *hdpu_chassis_id;
+static int slot_id = -1;
+static int chassis_id = -1;
+
+static struct device_driver hdpu_nexus_driver = {
+	.name = HDPU_NEXUS_NAME,
+	.bus = &platform_bus_type,
+	.probe = hdpu_nexus_probe,
+	.remove = hdpu_nexus_remove,
+};
+
+int hdpu_slot_id_read(char *buffer, char **buffer_location, off_t offset,
+		      int buffer_length, int *zero, void *ptr)
+{
+
+	if (offset > 0)
+		return 0;
+	return sprintf(buffer, "%d\n", slot_id);
+}
+
+int hdpu_chassis_id_read(char *buffer, char **buffer_location, off_t offset,
+			 int buffer_length, int *zero, void *ptr)
+{
+
+	if (offset > 0)
+		return 0;
+	return sprintf(buffer, "%d\n", chassis_id);
+}
+
+static int hdpu_nexus_probe(struct device *ddev)
+{
+	struct platform_device *pdev = to_platform_device(ddev);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int *nexus_id_addr;
+	nexus_id_addr =
+	    ioremap(res->start, (unsigned long)(res->end - res->start));
+	if (nexus_id_addr) {
+		slot_id = (*nexus_id_addr >> 8) & 0x1f;
+		chassis_id = *nexus_id_addr & 0xff;
+		iounmap(nexus_id_addr);
+	} else
+		printk("Could not map slot id\n");
+	hdpu_slot_id = create_proc_entry("sky_slot_id", 0666, &proc_root);
+	hdpu_slot_id->read_proc = hdpu_slot_id_read;
+	hdpu_slot_id->nlink = 1;
+
+	hdpu_chassis_id = create_proc_entry("sky_chassis_id", 0666, &proc_root);
+	hdpu_chassis_id->read_proc = hdpu_chassis_id_read;
+	hdpu_chassis_id->nlink = 1;
+	return 0;
+}
+
+static int hdpu_nexus_remove(struct device *ddev)
+{
+	slot_id = -1;
+	chassis_id = -1;
+	remove_proc_entry("sky_slot_id", &proc_root);
+	remove_proc_entry("sky_chassis_id", &proc_root);
+	hdpu_slot_id = 0;
+	hdpu_chassis_id = 0;
+	return 0;
+}
+
+static int __init nexus_init(void)
+{
+	int rc;
+	rc = driver_register(&hdpu_nexus_driver);
+	return rc;
+}
+
+static void __exit nexus_exit(void)
+{
+	driver_unregister(&hdpu_nexus_driver);
+}
+
+module_init(nexus_init);
+module_exit(nexus_exit);
+
+MODULE_AUTHOR("Brian Waite");
+MODULE_LICENSE("GPL");
