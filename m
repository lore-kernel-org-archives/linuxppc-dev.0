Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D809F67A63
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 12:42:24 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 12:42:07 +1100
Message-Id: <1106012528.4499.39.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] update aty128fb sleep/wakeup code for new powermac changes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch updates aty128fb power management code to the changes of the powermac
sleep mecanism. It makes the driver use the new hook for early wakeup, adds the
call to the arch code indicating wether it can wakeup the chip, etc... This patch
shouldn't break non-ppc, but this should be tested.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/aty128fb.c
===================================================================
--- linux-work.orig/drivers/video/aty/aty128fb.c	2005-01-17 13:24:18.000000000 +1100
+++ linux-work/drivers/video/aty/aty128fb.c	2005-01-17 13:49:25.921211544 +1100
@@ -67,6 +67,7 @@
 #include <asm/io.h>
 
 #ifdef CONFIG_PPC_PMAC
+#include <asm/pmac_feature.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include "../macmodes.h"
@@ -167,6 +168,7 @@
 static void aty128_remove(struct pci_dev *pdev);
 static int aty128_pci_suspend(struct pci_dev *pdev, u32 state);
 static int aty128_pci_resume(struct pci_dev *pdev);
+static int aty128_do_resume(struct pci_dev *pdev);
 
 /* supported Rage128 chipsets */
 static struct pci_device_id aty128_pci_tbl[] = {
@@ -1705,6 +1707,18 @@
  *  Initialisation
  */
 
+#ifdef CONFIG_PPC_PMAC
+static void aty128_early_resume(void *data)
+{
+        struct aty128fb_par *par = data;
+
+	if (try_acquire_console_sem())
+		return;
+	aty128_do_resume(par->pdev);
+	release_console_sem();
+}
+#endif /* CONFIG_PPC_PMAC */
+
 static int __init aty128_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
@@ -1749,6 +1763,13 @@
 	var = default_var;
 #ifdef CONFIG_PPC_PMAC
 	if (_machine == _MACH_Pmac) {
+		/* Indicate sleep capability */
+		if (par->chip_gen == rage_M3) {
+			pmac_call_feature(PMAC_FTR_DEVICE_CAN_WAKE, NULL, 0, 1);
+			pmac_set_early_video_resume(aty128_early_resume, par);
+		}
+
+		/* Find default mode */
 		if (mode_option) {
 			if (!mac_find_mode(&var, info, mode_option, 8))
 				var = default_var;
@@ -2365,7 +2386,7 @@
 	return 0;
 }
 
-static int aty128_pci_resume(struct pci_dev *pdev)
+static int aty128_do_resume(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
@@ -2373,8 +2394,6 @@
 	if (pdev->dev.power.power_state == 0)
 		return 0;
 
-	acquire_console_sem();
-
 	/* Wakeup chip */
 	if (pdev->dev.power.power_state == 2)
 		aty128_set_suspend(par, 0);
@@ -2394,8 +2413,6 @@
 	par->lock_blank = 0;
 	aty128fb_blank(0, info);
 
-	release_console_sem();
-
 	pdev->dev.power.power_state = 0;
 
 	printk(KERN_DEBUG "aty128fb: resumed !\n");
@@ -2403,6 +2420,18 @@
 	return 0;
 }
 
+static int aty128_pci_resume(struct pci_dev *pdev)
+{
+	int rc;
+
+	acquire_console_sem();
+	rc = aty128_do_resume(pdev);
+	release_console_sem();
+
+	return rc;
+}
+
+
 int __init aty128fb_init(void)
 {
 #ifndef MODULE
