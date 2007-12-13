Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18272.45290.230209.624296@cargo.ozlabs.ibm.com>
Date: Thu, 13 Dec 2007 15:11:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Convert adb.c to use kthread API and not spin on ADB requests
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This converts adb.c to use the kthread API.

It also changes adb_request so that if the ADBREQ_SYNC flag is
specified, we now sleep waiting for the request to finish using an
on-stack completion rather than spinning.  To implement this, we now
require that if the ADBREQ_SYNC flag is set, the `done' parameter must
be NULL.  All of the existing callers of adb_request that pass
ADBREQ_SYNC appear to be in process context and have done == NULL.
Doing this allows us to get rid of an awful hack in adb_request()
where we used to test whether the request was coming from the adb
probe task and use a completion if it was, and otherwise spin.

This also gets rid of a static request block that was used if the req
parameter to adb_request was NULL.  None of the callers do that any
more, so the static request block is no longer necessary.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 7b892f4..5ae28f0 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -35,6 +35,7 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/kthread.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -82,9 +83,7 @@ struct adb_driver *adb_controller;
 BLOCKING_NOTIFIER_HEAD(adb_client_list);
 static int adb_got_sleep;
 static int adb_inited;
-static pid_t adb_probe_task_pid;
 static DECLARE_MUTEX(adb_probe_mutex);
-static struct completion adb_probe_task_comp;
 static int sleepy_trackpad;
 static int autopoll_devs;
 int __adb_probe_sync;
@@ -126,16 +125,6 @@ static void printADBreply(struct adb_request *req)
 }
 #endif
 
-
-static __inline__ void adb_wait_ms(unsigned int ms)
-{
-	if (current->pid && adb_probe_task_pid &&
-	  adb_probe_task_pid == current->pid)
-		msleep(ms);
-	else
-		mdelay(ms);
-}
-
 static int adb_scan_bus(void)
 {
 	int i, highFree=0, noMovement;
@@ -240,13 +229,10 @@ static int adb_scan_bus(void)
 static int
 adb_probe_task(void *x)
 {
-	strcpy(current->comm, "kadbprobe");
-
 	printk(KERN_INFO "adb: starting probe task...\n");
 	do_adb_reset_bus();
 	printk(KERN_INFO "adb: finished probe task...\n");
 
-	adb_probe_task_pid = 0;
 	up(&adb_probe_mutex);
 
 	return 0;
@@ -255,7 +241,7 @@ adb_probe_task(void *x)
 static void
 __adb_probe_task(struct work_struct *bullshit)
 {
-	adb_probe_task_pid = kernel_thread(adb_probe_task, NULL, SIGCHLD | CLONE_KERNEL);
+	kthread_run(adb_probe_task, NULL, "kadbprobe");
 }
 
 static DECLARE_WORK(adb_reset_work, __adb_probe_task);
@@ -341,7 +327,6 @@ int __init adb_init(void)
 			sleepy_trackpad = 1;
 #endif /* CONFIG_PPC */
 
-		init_completion(&adb_probe_task_comp);
 		adbdev_init();
 		adb_reset_bus();
 	}
@@ -366,7 +351,7 @@ do_adb_reset_bus(void)
 
 	if (sleepy_trackpad) {
 		/* Let the trackpad settle down */
-		adb_wait_ms(500);
+		msleep(500);
 	}
 
 	down(&adb_handler_sem);
@@ -382,7 +367,7 @@ do_adb_reset_bus(void)
 
 	if (sleepy_trackpad) {
 		/* Let the trackpad settle down */
-		adb_wait_ms(1500);
+		msleep(1500);
 	}
 
 	if (!ret) {
@@ -406,41 +391,27 @@ adb_poll(void)
 	adb_controller->poll();
 }
 
-static void
-adb_probe_wakeup(struct adb_request *req)
+static void adb_sync_req_done(struct adb_request *req)
 {
-	complete(&adb_probe_task_comp);
-}
+	struct completion *comp = req->arg;
 
-/* Static request used during probe */
-static struct adb_request adb_sreq;
-static unsigned long adb_sreq_lock; // Use semaphore ! */ 
+	complete(comp);
+}
 
 int
 adb_request(struct adb_request *req, void (*done)(struct adb_request *),
 	    int flags, int nbytes, ...)
 {
 	va_list list;
-	int i, use_sreq;
+	int i;
 	int rc;
+	struct completion comp;
 
 	if ((adb_controller == NULL) || (adb_controller->send_request == NULL))
 		return -ENXIO;
 	if (nbytes < 1)
 		return -EINVAL;
-	if (req == NULL && (flags & ADBREQ_NOSEND))
-		return -EINVAL;
-	
-	if (req == NULL) {
-		if (test_and_set_bit(0,&adb_sreq_lock)) {
-			printk("adb.c: Warning: contention on static request !\n");
-			return -EPERM;
-		}
-		req = &adb_sreq;
-		flags |= ADBREQ_SYNC;
-		use_sreq = 1;
-	} else
-		use_sreq = 0;
+
 	req->nbytes = nbytes+1;
 	req->done = done;
 	req->reply_expected = flags & ADBREQ_REPLY;
@@ -453,25 +424,18 @@ adb_request(struct adb_request *req, void (*done)(struct adb_request *),
 	if (flags & ADBREQ_NOSEND)
 		return 0;
 
-	/* Synchronous requests send from the probe thread cause it to
-	 * block. Beware that the "done" callback will be overriden !
-	 */
-	if ((flags & ADBREQ_SYNC) &&
-	    (current->pid && adb_probe_task_pid &&
-	    adb_probe_task_pid == current->pid)) {
-		req->done = adb_probe_wakeup;
-		rc = adb_controller->send_request(req, 0);
-		if (rc || req->complete)
-			goto bail;
-		wait_for_completion(&adb_probe_task_comp);
-		rc = 0;
-		goto bail;
+	/* Synchronous requests block using an on-stack completion */
+	if (flags & ADBREQ_SYNC) {
+		WARN_ON(done);
+		req->done = adb_sync_req_done;
+		req->arg = &comp;
+		init_completion(&comp);
 	}
 
-	rc = adb_controller->send_request(req, flags & ADBREQ_SYNC);
-bail:
-	if (use_sreq)
-		clear_bit(0, &adb_sreq_lock);
+	rc = adb_controller->send_request(req, 0);
+
+	if ((flags & ADBREQ_SYNC) && !rc && !req->complete)
+		wait_for_completion(&comp);
 
 	return rc;
 }
