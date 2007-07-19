Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 657E0DDFAC
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 07:51:03 +1000 (EST)
Date: Thu, 19 Jul 2007 23:50:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: mgreer@mvista.com
Subject: [PATCH] mv64x60 use mutex instead of semaphore
Message-ID: <20070719215049.GA4896@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/ppc/syslib/mv64x60.c
===================================================================
--- linux-2.6.orig/arch/ppc/syslib/mv64x60.c	2007-07-19 22:47:07.000000000 +0200
+++ linux-2.6/arch/ppc/syslib/mv64x60.c	2007-07-19 22:48:29.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/mv643xx.h>
@@ -2359,7 +2360,7 @@ mv64460_chip_specific_init(struct mv64x6
 /* Export the hotswap register via sysfs for enum event monitoring */
 #define	VAL_LEN_MAX	11 /* 32-bit hex or dec stringified number + '\n' */
 
-DECLARE_MUTEX(mv64xxx_hs_lock);
+static DEFINE_MUTEX(mv64xxx_hs_lock);
 
 static ssize_t
 mv64xxx_hs_reg_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
@@ -2372,14 +2373,14 @@ mv64xxx_hs_reg_read(struct kobject *kobj
 	if (count < VAL_LEN_MAX)
 		return -EINVAL;
 
-	if (down_interruptible(&mv64xxx_hs_lock))
+	if (mutex_lock_interruptible(&mv64xxx_hs_lock))
 		return -ERESTARTSYS;
 	save_exclude = mv64x60_pci_exclude_bridge;
 	mv64x60_pci_exclude_bridge = 0;
 	early_read_config_dword(&sysfs_hose_a, 0, PCI_DEVFN(0, 0),
 			MV64360_PCICFG_CPCI_HOTSWAP, &v);
 	mv64x60_pci_exclude_bridge = save_exclude;
-	up(&mv64xxx_hs_lock);
+	mutex_unlock(&mv64xxx_hs_lock);
 
 	return sprintf(buf, "0x%08x\n", v);
 }
@@ -2396,14 +2397,14 @@ mv64xxx_hs_reg_write(struct kobject *kob
 		return -EINVAL;
 
 	if (sscanf(buf, "%i", &v) == 1) {
-		if (down_interruptible(&mv64xxx_hs_lock))
+		if (mutex_lock_interruptible(&mv64xxx_hs_lock))
 			return -ERESTARTSYS;
 		save_exclude = mv64x60_pci_exclude_bridge;
 		mv64x60_pci_exclude_bridge = 0;
 		early_write_config_dword(&sysfs_hose_a, 0, PCI_DEVFN(0, 0),
 				MV64360_PCICFG_CPCI_HOTSWAP, v);
 		mv64x60_pci_exclude_bridge = save_exclude;
-		up(&mv64xxx_hs_lock);
+		mutex_unlock(&mv64xxx_hs_lock);
 	}
 	else
 		count = -EINVAL;
@@ -2433,10 +2434,10 @@ mv64xxx_hs_reg_valid_show(struct device 
 	pdev = container_of(dev, struct platform_device, dev);
 	pdp = (struct mv64xxx_pdata *)pdev->dev.platform_data;
 
-	if (down_interruptible(&mv64xxx_hs_lock))
+	if (mutex_lock_interruptible(&mv64xxx_hs_lock))
 		return -ERESTARTSYS;
 	v = pdp->hs_reg_valid;
-	up(&mv64xxx_hs_lock);
+	mutex_unlock(&mv64xxx_hs_lock);
 
 	return sprintf(buf, "%i\n", v);
 }
