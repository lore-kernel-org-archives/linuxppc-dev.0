Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B358DDF57
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 09:31:55 +1000 (EST)
Message-Id: <200806092326.m59NQ9rm014227@imap1.linux-foundation.org>
Subject: [patch 4/5] macintosh: media bay: semaphore to mutex
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Mon, 09 Jun 2008 16:26:09 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Daniel Walker <dwalker@mvista.com>

Signed-off-by: Daniel Walker <dwalker@mvista.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/macintosh/mediabay.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff -puN drivers/macintosh/mediabay.c~macintosh-media-bay-semaphore-to-mutex drivers/macintosh/mediabay.c
--- a/drivers/macintosh/mediabay.c~macintosh-media-bay-semaphore-to-mutex
+++ a/drivers/macintosh/mediabay.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/ide.h>
 #include <linux/kthread.h>
+#include <linux/mutex.h>
 #include <asm/prom.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -77,7 +78,7 @@ struct media_bay_info {
 	int				index;
 	int				cached_gpio;
 	int				sleeping;
-	struct semaphore		lock;
+	struct mutex			lock;
 #ifdef CONFIG_BLK_DEV_IDE_PMAC
 	ide_hwif_t			*cd_port;
 	void __iomem			*cd_base;
@@ -459,27 +460,27 @@ int media_bay_set_ide_infos(struct devic
 		if (bay->mdev && which_bay == bay->mdev->ofdev.node) {
 			int timeout = 5000, index = hwif->index;
 			
-			down(&bay->lock);
+			mutex_lock(&bay->lock);
 
 			bay->cd_port	= hwif;
  			bay->cd_base	= (void __iomem *) base;
 			bay->cd_irq	= irq;
 
 			if ((MB_CD != bay->content_id) || bay->state != mb_up) {
-				up(&bay->lock);
+				mutex_unlock(&bay->lock);
 				return 0;
 			}
 			printk(KERN_DEBUG "Registered ide%d for media bay %d\n", index, i);
 			do {
 				if (MB_IDE_READY(i)) {
 					bay->cd_index	= index;
-					up(&bay->lock);
+					mutex_unlock(&bay->lock);
 					return 0;
 				}
 				mdelay(1);
 			} while(--timeout);
 			printk(KERN_DEBUG "Timeount waiting IDE in bay %d\n", i);
-			up(&bay->lock);
+			mutex_unlock(&bay->lock);
 			return -ENODEV;
 		}
 	}
@@ -616,10 +617,10 @@ static int media_bay_task(void *x)
 
 	while (!kthread_should_stop()) {
 		for (i = 0; i < media_bay_count; ++i) {
-			down(&media_bays[i].lock);
+			mutex_lock(&media_bays[i].lock);
 			if (!media_bays[i].sleeping)
 				media_bay_step(i);
-			up(&media_bays[i].lock);
+			mutex_unlock(&media_bays[i].lock);
 		}
 
 		msleep_interruptible(MB_POLL_DELAY);
@@ -659,7 +660,7 @@ static int __devinit media_bay_attach(st
 	bay->index = i;
 	bay->ops = match->data;
 	bay->sleeping = 0;
-	init_MUTEX(&bay->lock);
+	mutex_init(&bay->lock);
 
 	/* Init HW probing */
 	if (bay->ops->init)
@@ -697,10 +698,10 @@ static int media_bay_suspend(struct maci
 
 	if (state.event != mdev->ofdev.dev.power.power_state.event
 	    && (state.event & PM_EVENT_SLEEP)) {
-		down(&bay->lock);
+		mutex_lock(&bay->lock);
 		bay->sleeping = 1;
 		set_mb_power(bay, 0);
-		up(&bay->lock);
+		mutex_unlock(&bay->lock);
 		msleep(MB_POLL_DELAY);
 		mdev->ofdev.dev.power.power_state = state;
 	}
@@ -719,12 +720,12 @@ static int media_bay_resume(struct macio
 	       	   they seem to help the 3400 get it right.
 	       	 */
 	       	/* Force MB power to 0 */
-		down(&bay->lock);
+		mutex_lock(&bay->lock);
 	       	set_mb_power(bay, 0);
 		msleep(MB_POWER_DELAY);
 	       	if (bay->ops->content(bay) != bay->content_id) {
 			printk("mediabay%d: content changed during sleep...\n", bay->index);
-			up(&bay->lock);
+			mutex_unlock(&bay->lock);
 	       		return 0;
 		}
 	       	set_mb_power(bay, 1);
@@ -740,7 +741,7 @@ static int media_bay_resume(struct macio
 	       	} while((bay->state != mb_empty) &&
 	       		(bay->state != mb_up));
 		bay->sleeping = 0;
-		up(&bay->lock);
+		mutex_unlock(&bay->lock);
 	}
 	return 0;
 }
_
