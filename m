Return-Path: <domen@coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id 28EB067BBE
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2005 08:57:16 +1000 (EST)
Message-Id: <20050630220349.966609000@>
Date: Fri, 01 Jul 2005 00:03:50 +0200
From: domen@coderock.org
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, domen@coderock.org,
	Christophe Lucas <clucas@rotomalug.org>
Subject: [patch 1/1] Audit return code : drivers/macintosh/apm_emu.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christophe Lucas <clucas@rotomalug.org>


Audit return codes (and handle failure correctly) for misc_register.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>


---
 apm_emu.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

Index: quilt/drivers/macintosh/apm_emu.c
===================================================================
--- quilt.orig/drivers/macintosh/apm_emu.c
+++ quilt/drivers/macintosh/apm_emu.c
@@ -515,19 +515,24 @@ static struct miscdevice apm_device = {
 
 static int __init apm_emu_init(void)
 {
+	int ret;
 	struct proc_dir_entry *apm_proc;
 
 	if (sys_ctrler != SYS_CTRLER_PMU) {
 		printk(KERN_INFO "apm_emu: Requires a machine with a PMU.\n");
 		return -ENODEV;
 	}
-		
+
+	ret = misc_register(&apm_device);
+	if (ret) {
+		printk(KERN_WARNING "apm_emu: Unable to register misc device.\n");
+		return ret;
+	}
+
 	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_emu_get_info);
 	if (apm_proc)
 		apm_proc->owner = THIS_MODULE;
 
-	misc_register(&apm_device);
-
 	pmu_register_sleep_notifier(&apm_sleep_notifier);
 
 	printk(KERN_INFO "apm_emu: APM Emulation %s initialized.\n", driver_version);

--
