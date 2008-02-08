Return-Path: <bzolnier@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id C692BDE674
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:31:26 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so3580760pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:31:26 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:45:37 +0100
Message-Id: <20080208004537.17746.56138.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 11/18] ide-generic: add ide_generic class and attribute for
	adding new interfaces
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Add ide_generic_sysfs_init() helper registering 'ide_generic' class
  (together with ide_generic_class_release() ->class_release method)
  and use it in ide_generic_init().

* Add "add" class attribute to 'ide_generic' class for adding new interfaces
  (it is intended to be a replacement for obsoleted "idex=base[,ctl[,irq]]"
  kernel parameters).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
+391 bytes (x86-32)

I also tried interface based on kernel parameters but it sucked
(more complex, bigger source code + resulting binary).

 drivers/ide/ide-generic.c |   78 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -1,17 +1,89 @@
 /*
  * generic/default IDE host driver
  *
- * Copyright (C) 2004 Bartlomiej Zolnierkiewicz
+ * Copyright (C) 2004, 2008 Bartlomiej Zolnierkiewicz
  * This code was split off from ide.c.  See it for original copyrights.
  *
  * May be copied or modified under the terms of the GNU General Public License.
  */
 
+/*
+ * For special cases new interfaces may be added using sysfs, i.e.
+ *
+ *	echo -n "0x168:0x36e:10" > /sys/class/ide_generic/add
+ *
+ * will add an interface using I/O ports 0x168-0x16f/0x36e and IRQ 10.
+ */
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/ide.h>
 
+#define DRV_NAME	"ide_generic"
+
+static ssize_t store_add(struct class *cls, const char *buf, size_t n)
+{
+	ide_hwif_t *hwif;
+	unsigned int base, ctl;
+	int irq;
+	hw_regs_t hw;
+	u8 idx[] = { 0xff, 0xff, 0xff, 0xff };
+
+	if (sscanf(buf, "%x:%x:%d", &base, &ctl, &irq) != 3)
+		return -EINVAL;
+
+	hwif = ide_find_port(base);
+	if (hwif == NULL)
+		return -ENOENT;
+
+	memset(&hw, 0, sizeof(hw));
+	ide_std_init_ports(&hw, base, ctl);
+	hw.irq = irq;
+	hw.chipset = ide_generic;
+
+	ide_init_port_hw(hwif, &hw);
+
+	idx[0] = hwif->index;
+
+	ide_device_add(idx, NULL);
+
+	return n;
+};
+
+static struct class_attribute ide_generic_class_attrs[] = {
+	__ATTR(add, S_IWUSR, NULL, store_add),
+	__ATTR_NULL
+};
+
+static void ide_generic_class_release(struct class *cls)
+{
+	kfree(cls);
+}
+
+static int __init ide_generic_sysfs_init(void)
+{
+	struct class *cls;
+	int rc;
+
+	cls = kzalloc(sizeof(*cls), GFP_KERNEL);
+	if (!cls)
+		return -ENOMEM;
+
+	cls->name = DRV_NAME;
+	cls->owner = THIS_MODULE;
+	cls->class_release = ide_generic_class_release;
+	cls->class_attrs = ide_generic_class_attrs;
+
+	rc = class_register(cls);
+	if (rc) {
+		kfree(cls);
+		return rc;
+	}
+
+	return 0;
+}
+
 static int __init ide_generic_init(void)
 {
 	u8 idx[MAX_HWIFS];
@@ -36,6 +108,10 @@ static int __init ide_generic_init(void)
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
 		ide_release_lock();	/* for atari only */
 
+	if (ide_generic_sysfs_init())
+		printk(KERN_ERR DRV_NAME ": failed to create ide_generic "
+					 "class\n");
+
 	return 0;
 }
 
