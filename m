Return-Path: <joel@jms.id.au>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3876A1A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 13:15:48 +1100 (AEDT)
Received: by pacgg7 with SMTP id gg7so23362927pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2015 19:15:44 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] kernel/reboot.c: Add orderly_reboot for graceful reboot
Date: Mon, 30 Mar 2015 12:45:32 +1030
Message-Id: <1427681733-25488-1-git-send-email-joel@jms.id.au>
Cc: rusty@rustcorp.com.au, fabf@skynet.be, jk@ozlabs.org,
 akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel has orderly_poweroff which allows the kernel to initiate a
graceful shutdown of userspace, by running /sbin/poweroff. This adds
orderly_reboot that will cause userspace to shut itself down by calling
/sbin/reboot.

This will be used for shutdown initiated by a system controller on
platforms that do not use ACPI.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/linux/reboot.h |  1 +
 kernel/reboot.c        | 51 +++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 48bf152..a4ffcd9 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -68,6 +68,7 @@ void ctrl_alt_del(void);
 extern char poweroff_cmd[POWEROFF_CMD_PATH_LEN];
 
 extern int orderly_poweroff(bool force);
+extern int orderly_reboot(void);
 
 /*
  * Emergency restart, callable from an interrupt handler.
diff --git a/kernel/reboot.c b/kernel/reboot.c
index a3a9e24..d0aa1ec 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -306,8 +306,9 @@ void ctrl_alt_del(void)
 }
 
 char poweroff_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/poweroff";
+char reboot_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/reboot";
 
-static int __orderly_poweroff(bool force)
+static int run_cmd(const char *cmd)
 {
 	char **argv;
 	static char *envp[] = {
@@ -316,8 +317,7 @@ static int __orderly_poweroff(bool force)
 		NULL
 	};
 	int ret;
-
-	argv = argv_split(GFP_KERNEL, poweroff_cmd, NULL);
+	argv = argv_split(GFP_KERNEL, cmd, NULL);
 	if (argv) {
 		ret = call_usermodehelper(argv[0], argv, envp, UMH_WAIT_EXEC);
 		argv_free(argv);
@@ -325,8 +325,33 @@ static int __orderly_poweroff(bool force)
 		ret = -ENOMEM;
 	}
 
+	return ret;
+}
+
+static int __orderly_reboot(void)
+{
+	int ret;
+
+	ret = run_cmd(reboot_cmd);
+
+	if (ret) {
+		pr_warn("Failed to start orderly reboot: forcing the issue\n");
+		emergency_sync();
+		kernel_restart(NULL);
+	}
+
+	return ret;
+}
+
+static int __orderly_poweroff(bool force)
+{
+	int ret;
+
+	ret = run_cmd(reboot_cmd);
+
 	if (ret && force) {
 		pr_warn("Failed to start orderly shutdown: forcing the issue\n");
+
 		/*
 		 * I guess this should try to kick off some daemon to sync and
 		 * poweroff asap.  Or not even bother syncing if we're doing an
@@ -364,6 +389,26 @@ int orderly_poweroff(bool force)
 }
 EXPORT_SYMBOL_GPL(orderly_poweroff);
 
+static void reboot_work_func(struct work_struct *work)
+{
+	__orderly_reboot();
+}
+
+static DECLARE_WORK(reboot_work, reboot_work_func);
+
+/**
+ * orderly_reboot - Trigger an orderly system reboot
+ *
+ * This may be called from any context to trigger a system reboot.
+ * If the orderly reboot fails, it will force an immediate reboot.
+ */
+int orderly_reboot(void)
+{
+	schedule_work(&reboot_work);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(orderly_reboot);
+
 static int __init reboot_setup(char *str)
 {
 	for (;;) {
-- 
2.1.4
