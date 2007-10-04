Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18180.25146.321019.568200@cargo.ozlabs.ibm.com>
Date: Thu, 4 Oct 2007 13:47:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Remove unused old code from powermac setup code
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since bootdevice never gets initialized, it's always NULL, and hence a
whole pile of code in arch/powerpc/platforms/setup.c never gets used.
(This was the code that originally was there so that the automatic
root partition selection mechanism would prefer a rootish-looking
partition on the device that OF loaded the kernel from over a similar
partition on other devices.)

This removes the unused code.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 7ccb923..c59a508 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -387,69 +387,13 @@ static void __init pmac_setup_arch(void)
 #endif /* CONFIG_ADB */
 }
 
-char *bootpath;
-char *bootdevice;
-void *boot_host;
-int boot_target;
-int boot_part;
-static dev_t boot_dev;
-
 #ifdef CONFIG_SCSI
 void note_scsi_host(struct device_node *node, void *host)
 {
-	int l;
-	char *p;
-
-	l = strlen(node->full_name);
-	if (bootpath != NULL && bootdevice != NULL
-	    && strncmp(node->full_name, bootdevice, l) == 0
-	    && (bootdevice[l] == '/' || bootdevice[l] == 0)) {
-		boot_host = host;
-		/*
-		 * There's a bug in OF 1.0.5.  (Why am I not surprised.)
-		 * If you pass a path like scsi/sd@1:0 to canon, it returns
-		 * something like /bandit@F2000000/gc@10/53c94@10000/sd@0,0
-		 * That is, the scsi target number doesn't get preserved.
-		 * So we pick the target number out of bootpath and use that.
-		 */
-		p = strstr(bootpath, "/sd@");
-		if (p != NULL) {
-			p += 4;
-			boot_target = simple_strtoul(p, NULL, 10);
-			p = strchr(p, ':');
-			if (p != NULL)
-				boot_part = simple_strtoul(p + 1, NULL, 10);
-		}
-	}
 }
 EXPORT_SYMBOL(note_scsi_host);
 #endif
 
-#if defined(CONFIG_BLK_DEV_IDE) && defined(CONFIG_BLK_DEV_IDE_PMAC)
-static dev_t __init find_ide_boot(void)
-{
-	char *p;
-	int n;
-	dev_t __init pmac_find_ide_boot(char *bootdevice, int n);
-
-	if (bootdevice == NULL)
-		return 0;
-	p = strrchr(bootdevice, '/');
-	if (p == NULL)
-		return 0;
-	n = p - bootdevice;
-
-	return pmac_find_ide_boot(bootdevice, n);
-}
-#endif /* CONFIG_BLK_DEV_IDE && CONFIG_BLK_DEV_IDE_PMAC */
-
-static void __init find_boot_device(void)
-{
-#if defined(CONFIG_BLK_DEV_IDE) && defined(CONFIG_BLK_DEV_IDE_PMAC)
-	boot_dev = find_ide_boot();
-#endif
-}
-
 static int initializing = 1;
 
 static int pmac_late_init(void)
@@ -469,7 +413,6 @@ late_initcall(pmac_late_init);
 /* can't be __init - can be called whenever a disk is first accessed */
 void note_bootable_part(dev_t dev, int part, int goodness)
 {
-	static int found_boot = 0;
 	char *p;
 
 	if (!initializing)
@@ -481,15 +424,8 @@ void note_bootable_part(dev_t dev, int part, int goodness)
 	if (p != NULL && (p == boot_command_line || p[-1] == ' '))
 		return;
 
-	if (!found_boot) {
-		find_boot_device();
-		found_boot = 1;
-	}
-	if (!boot_dev || dev == boot_dev) {
-		ROOT_DEV = dev + part;
-		boot_dev = 0;
-		current_root_goodness = goodness;
-	}
+	ROOT_DEV = dev + part;
+	current_root_goodness = goodness;
 }
 
 #ifdef CONFIG_ADB_CUDA
