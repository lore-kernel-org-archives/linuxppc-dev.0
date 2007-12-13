Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18272.47893.897716.632556@cargo.ozlabs.ibm.com>
Date: Thu, 13 Dec 2007 15:54:45 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Convert therm_pm72.c to use the kthread API
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This converts the therm_pm72.c driver to use the kthread API.  I
thought about making it use kthread_stop() instead of the `state'
variable and the `ctrl_complete' completion, but that isn't simple and
will require changing the way that `state' is used.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index e43554e..6fadc9a 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -121,6 +121,7 @@
 #include <linux/reboot.h>
 #include <linux/kmod.h>
 #include <linux/i2c.h>
+#include <linux/kthread.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -161,7 +162,7 @@ static struct slots_pid_state		slots_state;
 static int				state;
 static int				cpu_count;
 static int				cpu_pid_type;
-static pid_t				ctrl_task;
+static struct task_struct		*ctrl_task;
 static struct completion		ctrl_complete;
 static int				critical_state;
 static int				rackmac;
@@ -1779,8 +1780,6 @@ static int call_critical_overtemp(void)
  */
 static int main_control_loop(void *x)
 {
-	daemonize("kfand");
-
 	DBG("main_control_loop started\n");
 
 	down(&driver_lock);
@@ -1956,7 +1955,7 @@ static void start_control_loops(void)
 {
 	init_completion(&ctrl_complete);
 
-	ctrl_task = kernel_thread(main_control_loop, NULL, SIGCHLD | CLONE_KERNEL);
+	ctrl_task = kthread_run(main_control_loop, NULL, "kfand");
 }
 
 /*
@@ -1964,7 +1963,7 @@ static void start_control_loops(void)
  */
 static void stop_control_loops(void)
 {
-	if (ctrl_task != 0)
+	if (ctrl_task)
 		wait_for_completion(&ctrl_complete);
 }
 
