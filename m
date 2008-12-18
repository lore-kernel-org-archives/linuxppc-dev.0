Return-Path: <brking@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D4D7DDF26
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 08:14:55 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBILE3Cf012456
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 16:14:03 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBILEqG0167006
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 16:14:52 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBIMF2Ob032534
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 17:15:02 -0500
Message-Id: <200812182215.mBIMF1Kp032428@d01av04.pok.ibm.com>
Subject: [PATCH 2/2] powerpc: Add reboot notifier to Collaborative Memory
	Manager
To: paulus@samba.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 18 Dec 2008 15:13:49 -0600
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When running Active Memory Sharing, pages can get marked as
"loaned" with the hypervisor by the CMM driver. This state gets
cleared by the system firmware when rebooting the partition.
When using kexec to boot a new kernel, this state never gets
cleared and the hypervisor and CMM driver can get out of sync
with respect to the number of pages currently marked "loaned".
Fix this by adding a reboot notifier to the CMM driver to deflate
the balloon and mark all pages as active.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/cmm.c |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff -puN arch/powerpc/platforms/pseries/cmm.c~powerpc_cmm_reboot_notifier arch/powerpc/platforms/pseries/cmm.c
--- linux-2.6/arch/powerpc/platforms/pseries/cmm.c~powerpc_cmm_reboot_notifier	2008-12-17 09:59:00.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/cmm.c	2008-12-17 09:59:00.000000000 -0600
@@ -28,6 +28,7 @@
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/oom.h>
+#include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/stringify.h>
 #include <linux/swap.h>
@@ -384,6 +385,26 @@ static void cmm_unregister_sysfs(struct 
 }
 
 /**
+ * cmm_reboot_notifier - Make sure pages are not still marked as "loaned"
+ *
+ **/
+static int cmm_reboot_notifier(struct notifier_block *nb,
+			       unsigned long action, void *unused)
+{
+	if (action == SYS_RESTART) {
+		if (cmm_thread_ptr)
+			kthread_stop(cmm_thread_ptr);
+		cmm_thread_ptr = NULL;
+		cmm_free_pages(loaned_pages);
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block cmm_reboot_nb = {
+	.notifier_call = cmm_reboot_notifier,
+};
+
+/**
  * cmm_init - Module initialization
  *
  * Return value:
@@ -399,9 +420,12 @@ static int cmm_init(void)
 	if ((rc = register_oom_notifier(&cmm_oom_nb)) < 0)
 		return rc;
 
-	if ((rc = cmm_sysfs_register(&cmm_sysdev)))
+	if ((rc = register_reboot_notifier(&cmm_reboot_nb)))
 		goto out_oom_notifier;
 
+	if ((rc = cmm_sysfs_register(&cmm_sysdev)))
+		goto out_reboot_notifier;
+
 	if (cmm_disabled)
 		return rc;
 
@@ -415,6 +439,8 @@ static int cmm_init(void)
 
 out_unregister_sysfs:
 	cmm_unregister_sysfs(&cmm_sysdev);
+out_reboot_notifier:
+	unregister_reboot_notifier(&cmm_reboot_nb);
 out_oom_notifier:
 	unregister_oom_notifier(&cmm_oom_nb);
 	return rc;
@@ -431,6 +457,7 @@ static void cmm_exit(void)
 	if (cmm_thread_ptr)
 		kthread_stop(cmm_thread_ptr);
 	unregister_oom_notifier(&cmm_oom_nb);
+	unregister_reboot_notifier(&cmm_reboot_nb);
 	cmm_free_pages(loaned_pages);
 	cmm_unregister_sysfs(&cmm_sysdev);
 }
_
