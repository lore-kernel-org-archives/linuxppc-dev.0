Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E247AB7B7D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 15:29:20 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n8P5TEWm014670
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 00:29:15 -0500
Subject: powerpc: Move /proc/ppc64 to /proc/powerpc and add symlink
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 15:29:13 +1000
Message-Id: <1253856553.7103.513.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the stuff in /proc/ppc64 such as the RTAS bits are actually
useful to some 32-bit platforms. Rename the file, and create a
symlink on 64-bit for backward compatibility

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index b23664a..3faa391 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
 obj-$(CONFIG_PPC_OF)		+= of_device.o of_platform.o prom_parse.o
 obj-$(CONFIG_PPC_CLOCK)		+= clock.o
-procfs-$(CONFIG_PPC64)		:= proc_ppc64.o
+procfs-y			:= proc_powerpc.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
 rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)	:= rtas_pci.o
 obj-$(CONFIG_PPC_RTAS)		+= rtas.o rtas-rtc.o $(rtaspci-y-y)
diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index ed0ac4e..79a00bb 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -781,9 +781,9 @@ static int __init lparcfg_init(void)
 			!firmware_has_feature(FW_FEATURE_ISERIES))
 		mode |= S_IWUSR;
 
-	ent = proc_create("ppc64/lparcfg", mode, NULL, &lparcfg_fops);
+	ent = proc_create("powerpc/lparcfg", mode, NULL, &lparcfg_fops);
 	if (!ent) {
-		printk(KERN_ERR "Failed to create ppc64/lparcfg\n");
+		printk(KERN_ERR "Failed to create powerpc/lparcfg\n");
 		return -EIO;
 	}
 
diff --git a/arch/powerpc/kernel/proc_powerpc.c b/arch/powerpc/kernel/proc_powerpc.c
new file mode 100644
index 0000000..1ed3b8d
--- /dev/null
+++ b/arch/powerpc/kernel/proc_powerpc.c
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 2001 Mike Corrigan & Dave Engebretsen IBM Corporation
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
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/proc_fs.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+
+#include <asm/machdep.h>
+#include <asm/vdso_datapage.h>
+#include <asm/rtas.h>
+#include <asm/uaccess.h>
+#include <asm/prom.h>
+
+#ifdef CONFIG_PPC64
+
+static loff_t page_map_seek( struct file *file, loff_t off, int whence)
+{
+	loff_t new;
+	struct proc_dir_entry *dp = PDE(file->f_path.dentry->d_inode);
+
+	switch(whence) {
+	case 0:
+		new = off;
+		break;
+	case 1:
+		new = file->f_pos + off;
+		break;
+	case 2:
+		new = dp->size + off;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if ( new < 0 || new > dp->size )
+		return -EINVAL;
+	return (file->f_pos = new);
+}
+
+static ssize_t page_map_read( struct file *file, char __user *buf, size_t nbytes,
+			      loff_t *ppos)
+{
+	struct proc_dir_entry *dp = PDE(file->f_path.dentry->d_inode);
+	return simple_read_from_buffer(buf, nbytes, ppos, dp->data, dp->size);
+}
+
+static int page_map_mmap( struct file *file, struct vm_area_struct *vma )
+{
+	struct proc_dir_entry *dp = PDE(file->f_path.dentry->d_inode);
+
+	if ((vma->vm_end - vma->vm_start) > dp->size)
+		return -EINVAL;
+
+	remap_pfn_range(vma, vma->vm_start, __pa(dp->data) >> PAGE_SHIFT,
+						dp->size, vma->vm_page_prot);
+	return 0;
+}
+
+static const struct file_operations page_map_fops = {
+	.llseek	= page_map_seek,
+	.read	= page_map_read,
+	.mmap	= page_map_mmap
+};
+
+
+static int __init proc_ppc64_init(void)
+{
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_data("powerpc/systemcfg", S_IFREG|S_IRUGO, NULL,
+			       &page_map_fops, vdso_data);
+	if (!pde)
+		return 1;
+	pde->size = PAGE_SIZE;
+
+	return 0;
+}
+__initcall(proc_ppc64_init);
+
+#endif /* CONFIG_PPC64 */
+
+/*
+ * Create the ppc64 and ppc64/rtas directories early. This allows us to
+ * assume that they have been previously created in drivers.
+ */
+static int __init proc_ppc64_create(void)
+{
+	struct proc_dir_entry *root;
+
+	root = proc_mkdir("powerpc", NULL);
+	if (!root)
+		return 1;
+
+#ifdef CONFIG_PPC64
+	if (!proc_symlink("ppc64", NULL, "powerpc"))
+		pr_err("Failed to create link /proc/ppc64 -> /proc/powerpc\n");
+#endif
+
+	if (!of_find_node_by_path("/rtas"))
+		return 0;
+
+	if (!proc_mkdir("rtas", root))
+		return 1;
+
+	if (!proc_symlink("rtas", NULL, "powerpc/rtas"))
+		return 1;
+
+	return 0;
+}
+core_initcall(proc_ppc64_create);
diff --git a/arch/powerpc/kernel/proc_ppc64.c b/arch/powerpc/kernel/proc_ppc64.c
deleted file mode 100644
index c647dde..0000000
--- a/arch/powerpc/kernel/proc_ppc64.c
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- * Copyright (C) 2001 Mike Corrigan & Dave Engebretsen IBM Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/proc_fs.h>
-#include <linux/slab.h>
-#include <linux/kernel.h>
-
-#include <asm/machdep.h>
-#include <asm/vdso_datapage.h>
-#include <asm/rtas.h>
-#include <asm/uaccess.h>
-#include <asm/prom.h>
-
-static loff_t  page_map_seek( struct file *file, loff_t off, int whence);
-static ssize_t page_map_read( struct file *file, char __user *buf, size_t nbytes,
-			      loff_t *ppos);
-static int     page_map_mmap( struct file *file, struct vm_area_struct *vma );
-
-static const struct file_operations page_map_fops = {
-	.llseek	= page_map_seek,
-	.read	= page_map_read,
-	.mmap	= page_map_mmap
-};
-
-/*
- * Create the ppc64 and ppc64/rtas directories early. This allows us to
- * assume that they have been previously created in drivers.
- */
-static int __init proc_ppc64_create(void)
-{
-	struct proc_dir_entry *root;
-
-	root = proc_mkdir("ppc64", NULL);
-	if (!root)
-		return 1;
-
-	if (!of_find_node_by_path("/rtas"))
-		return 0;
-
-	if (!proc_mkdir("rtas", root))
-		return 1;
-
-	if (!proc_symlink("rtas", NULL, "ppc64/rtas"))
-		return 1;
-
-	return 0;
-}
-core_initcall(proc_ppc64_create);
-
-static int __init proc_ppc64_init(void)
-{
-	struct proc_dir_entry *pde;
-
-	pde = proc_create_data("ppc64/systemcfg", S_IFREG|S_IRUGO, NULL,
-			       &page_map_fops, vdso_data);
-	if (!pde)
-		return 1;
-	pde->size = PAGE_SIZE;
-
-	return 0;
-}
-__initcall(proc_ppc64_init);
-
-static loff_t page_map_seek( struct file *file, loff_t off, int whence)
-{
-	loff_t new;
-	struct proc_dir_entry *dp = PDE(file->f_path.dentry->d_inode);
-
-	switch(whence) {
-	case 0:
-		new = off;
-		break;
-	case 1:
-		new = file->f_pos + off;
-		break;
-	case 2:
-		new = dp->size + off;
-		break;
-	default:
-		return -EINVAL;
-	}
-	if ( new < 0 || new > dp->size )
-		return -EINVAL;
-	return (file->f_pos = new);
-}
-
-static ssize_t page_map_read( struct file *file, char __user *buf, size_t nbytes,
-			      loff_t *ppos)
-{
-	struct proc_dir_entry *dp = PDE(file->f_path.dentry->d_inode);
-	return simple_read_from_buffer(buf, nbytes, ppos, dp->data, dp->size);
-}
-
-static int page_map_mmap( struct file *file, struct vm_area_struct *vma )
-{
-	struct proc_dir_entry *dp = PDE(file->f_path.dentry->d_inode);
-
-	if ((vma->vm_end - vma->vm_start) > dp->size)
-		return -EINVAL;
-
-	remap_pfn_range(vma, vma->vm_start, __pa(dp->data) >> PAGE_SHIFT,
-						dp->size, vma->vm_page_prot);
-	return 0;
-}
-
diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 13011a9..a85117d 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -6,7 +6,7 @@
  *      as published by the Free Software Foundation; either version
  *      2 of the License, or (at your option) any later version.
  *
- * /proc/ppc64/rtas/firmware_flash interface
+ * /proc/powerpc/rtas/firmware_flash interface
  *
  * This file implements a firmware_flash interface to pump a firmware
  * image into the kernel.  At reboot time rtas_restart() will see the
@@ -740,7 +740,7 @@ static int __init rtas_flash_init(void)
 		return 1;
 	}
 
-	firmware_flash_pde = create_flash_pde("ppc64/rtas/"
+	firmware_flash_pde = create_flash_pde("powerpc/rtas/"
 					      FIRMWARE_FLASH_NAME,
 					      &rtas_flash_operations);
 	if (firmware_flash_pde == NULL) {
@@ -754,7 +754,7 @@ static int __init rtas_flash_init(void)
 	if (rc != 0)
 		goto cleanup;
 
-	firmware_update_pde = create_flash_pde("ppc64/rtas/"
+	firmware_update_pde = create_flash_pde("powerpc/rtas/"
 					       FIRMWARE_UPDATE_NAME,
 					       &rtas_flash_operations);
 	if (firmware_update_pde == NULL) {
@@ -768,7 +768,7 @@ static int __init rtas_flash_init(void)
 	if (rc != 0)
 		goto cleanup;
 
-	validate_pde = create_flash_pde("ppc64/rtas/" VALIDATE_FLASH_NAME,
+	validate_pde = create_flash_pde("powerpc/rtas/" VALIDATE_FLASH_NAME,
 			      		&validate_flash_operations);
 	if (validate_pde == NULL) {
 		rc = -ENOMEM;
@@ -781,7 +781,7 @@ static int __init rtas_flash_init(void)
 	if (rc != 0)
 		goto cleanup;
 
-	manage_pde = create_flash_pde("ppc64/rtas/" MANAGE_FLASH_NAME,
+	manage_pde = create_flash_pde("powerpc/rtas/" MANAGE_FLASH_NAME,
 				      &manage_flash_operations);
 	if (manage_pde == NULL) {
 		rc = -ENOMEM;
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 2e2bbe1..5182d2b 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -184,7 +184,7 @@ static int pSeries_reconfig_remove_node(struct device_node *np)
 }
 
 /*
- * /proc/ppc64/ofdt - yucky binary interface for adding and removing
+ * /proc/powerpc/ofdt - yucky binary interface for adding and removing
  * OF device nodes.  Should be deprecated as soon as we get an
  * in-kernel wrapper for the RTAS ibm,configure-connector call.
  */
@@ -543,7 +543,7 @@ static const struct file_operations ofdt_fops = {
 	.write = ofdt_write
 };
 
-/* create /proc/ppc64/ofdt write-only by root */
+/* create /proc/powerpc/ofdt write-only by root */
 static int proc_ppc64_create_ofdt(void)
 {
 	struct proc_dir_entry *ent;
@@ -551,7 +551,7 @@ static int proc_ppc64_create_ofdt(void)
 	if (!machine_is(pseries))
 		return 0;
 
-	ent = proc_create("ppc64/ofdt", S_IWUSR, NULL, &ofdt_fops);
+	ent = proc_create("powerpc/ofdt", S_IWUSR, NULL, &ofdt_fops);
 	if (ent)
 		ent->size = 0;
 
diff --git a/arch/powerpc/platforms/pseries/scanlog.c b/arch/powerpc/platforms/pseries/scanlog.c
index 417eca7..1b45c45 100644
--- a/arch/powerpc/platforms/pseries/scanlog.c
+++ b/arch/powerpc/platforms/pseries/scanlog.c
@@ -13,7 +13,7 @@
  * of this data using this driver.  A dump exists if the device-tree
  * /chosen/ibm,scan-log-data property exists.
  *
- * This driver exports /proc/ppc64/scan-log-dump which can be read.
+ * This driver exports /proc/powerpc/scan-log-dump which can be read.
  * The driver supports only sequential reads.
  *
  * The driver looks at a write to the driver for the single word "reset".
@@ -186,7 +186,7 @@ static int __init scanlog_init(void)
 	if (!data)
 		goto err;
 
-	ent = proc_create_data("ppc64/rtas/scan-log-dump", S_IRUSR, NULL,
+	ent = proc_create_data("powerpc/rtas/scan-log-dump", S_IRUSR, NULL,
 			       &scanlog_fops, data);
 	if (!ent)
 		goto err;
