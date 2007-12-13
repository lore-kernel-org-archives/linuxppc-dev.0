Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18272.41786.242678.619178@cargo.ozlabs.ibm.com>
Date: Thu, 13 Dec 2007 14:12:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Convert media-bay.c to use the kthread API
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We aren't supposed to use kernel_thread directly in drivers any more,
and in fact using kthread_run is a bit simpler.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 48d647a..080844b 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -20,6 +20,7 @@
 #include <linux/stddef.h>
 #include <linux/init.h>
 #include <linux/ide.h>
+#include <linux/kthread.h>
 #include <asm/prom.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -35,7 +36,6 @@
 
 
 #define MB_DEBUG
-#define MB_IGNORE_SIGNALS
 
 #ifdef MB_DEBUG
 #define MBDBG(fmt, arg...)	printk(KERN_INFO fmt , ## arg)
@@ -622,12 +622,7 @@ static int media_bay_task(void *x)
 {
 	int	i;
 
-	strcpy(current->comm, "media-bay");
-#ifdef MB_IGNORE_SIGNALS
-	sigfillset(&current->blocked);
-#endif
-
-	for (;;) {
+	while (!kthread_should_stop()) {
 		for (i = 0; i < media_bay_count; ++i) {
 			down(&media_bays[i].lock);
 			if (!media_bays[i].sleeping)
@@ -636,8 +631,6 @@ static int media_bay_task(void *x)
 		}
 
 		msleep_interruptible(MB_POLL_DELAY);
-		if (signal_pending(current))
-			return 0;
 	}
 }
 
@@ -699,7 +692,7 @@ static int __devinit media_bay_attach(struct macio_dev *mdev, const struct of_de
 
 	/* Startup kernel thread */
 	if (i == 0)
-		kernel_thread(media_bay_task, NULL, CLONE_KERNEL);
+		kthread_run(media_bay_task, NULL, "media-bay");
 
 	return 0;
 
