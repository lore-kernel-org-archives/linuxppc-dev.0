Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9FA642C037D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:34:46 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 04:34:44 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 15C526E8028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:38 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I8YBOw305238
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:12 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I8YBHQ004190
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:34:11 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/31] powerpc/eeh: Single kthread to handle events
Date: Tue, 18 Jun 2013 16:33:34 +0800
Message-Id: <1371544435-4943-11-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We possiblly have multiple kthreads running for multiple EEH errors
(events) and use one spinlock to make the process of handling those
EEH events serialized. That's unnecessary and the patch creates only
one kthread, which is started during EEH core initialization time in
eeh_init(). A new semaphore introduced to count the number of existing
EEH events in the queue and the kthread waiting on the semaphore.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh_event.h |    1 +
 arch/powerpc/kernel/eeh.c            |    5 ++
 arch/powerpc/kernel/eeh_event.c      |   96 +++++++++++++++++----------------
 3 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
index de67d83..de92c86 100644
--- a/arch/powerpc/include/asm/eeh_event.h
+++ b/arch/powerpc/include/asm/eeh_event.h
@@ -31,6 +31,7 @@ struct eeh_event {
 	struct eeh_pe		*pe;	/* EEH PE		*/
 };
 
+int eeh_event_init(void);
 int eeh_send_failure_event(struct eeh_pe *pe);
 void eeh_handle_event(struct eeh_pe *pe);
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 7d169d3..777ecc0 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -704,6 +704,11 @@ int __init eeh_init(void)
 
 	raw_spin_lock_init(&confirm_error_lock);
 
+	/* Initialize EEH event */
+	ret = eeh_event_init();
+	if (ret)
+		return ret;
+
 	/* Enable EEH for all adapters */
 	if (eeh_probe_mode_devtree()) {
 		list_for_each_entry_safe(hose, tmp,
diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index 185bedd..62e532d 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -18,11 +18,10 @@
 
 #include <linux/delay.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
 #include <linux/sched.h>
+#include <linux/semaphore.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
-#include <linux/workqueue.h>
 #include <linux/kthread.h>
 #include <asm/eeh_event.h>
 #include <asm/ppc-pci.h>
@@ -35,14 +34,9 @@
  *  work-queue, where a worker thread can drive recovery.
  */
 
-/* EEH event workqueue setup. */
 static DEFINE_SPINLOCK(eeh_eventlist_lock);
+static struct semaphore eeh_eventlist_sem;
 LIST_HEAD(eeh_eventlist);
-static void eeh_thread_launcher(struct work_struct *);
-DECLARE_WORK(eeh_event_wq, eeh_thread_launcher);
-
-/* Serialize reset sequences for a given pci device */
-DEFINE_MUTEX(eeh_event_mutex);
 
 /**
  * eeh_event_handler - Dispatch EEH events.
@@ -60,55 +54,62 @@ static int eeh_event_handler(void * dummy)
 	struct eeh_event *event;
 	struct eeh_pe *pe;
 
-	spin_lock_irqsave(&eeh_eventlist_lock, flags);
-	event = NULL;
-
-	/* Unqueue the event, get ready to process. */
-	if (!list_empty(&eeh_eventlist)) {
-		event = list_entry(eeh_eventlist.next, struct eeh_event, list);
-		list_del(&event->list);
-	}
-	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
-
-	if (event == NULL)
-		return 0;
-
-	/* Serialize processing of EEH events */
-	mutex_lock(&eeh_event_mutex);
-	pe = event->pe;
-	eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
-	pr_info("EEH: Detected PCI bus error on PHB#%d-PE#%x\n",
-		pe->phb->global_number, pe->addr);
-
-	set_current_state(TASK_INTERRUPTIBLE);	/* Don't add to load average */
-	eeh_handle_event(pe);
-	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
-
-	kfree(event);
-	mutex_unlock(&eeh_event_mutex);
-
-	/* If there are no new errors after an hour, clear the counter. */
-	if (pe && pe->freeze_count > 0) {
-		msleep_interruptible(3600*1000);
-		if (pe->freeze_count > 0)
-			pe->freeze_count--;
-
+	while (!kthread_should_stop()) {
+		down(&eeh_eventlist_sem);
+
+		/* Fetch EEH event from the queue */
+		spin_lock_irqsave(&eeh_eventlist_lock, flags);
+		event = NULL;
+		if (!list_empty(&eeh_eventlist)) {
+			event = list_entry(eeh_eventlist.next,
+					   struct eeh_event, list);
+			list_del(&event->list);
+		}
+		spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+		if (!event)
+			continue;
+
+		/* We might have event without binding PE */
+		pe = event->pe;
+		if (pe) {
+			eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
+			pr_info("EEH: Detected PCI bus error on PHB#%d-PE#%x\n",
+				 pe->phb->global_number, pe->addr);
+			eeh_handle_event(pe);
+			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
+		} else {
+			eeh_handle_event(NULL);
+		}
+
+		kfree(event);
 	}
 
 	return 0;
 }
 
 /**
- * eeh_thread_launcher - Start kernel thread to handle EEH events
- * @dummy - unused
+ * eeh_event_init - Start kernel thread to handle EEH events
  *
  * This routine is called to start the kernel thread for processing
  * EEH event.
  */
-static void eeh_thread_launcher(struct work_struct *dummy)
+int eeh_event_init(void)
 {
-	if (IS_ERR(kthread_run(eeh_event_handler, NULL, "eehd")))
-		printk(KERN_ERR "Failed to start EEH daemon\n");
+	struct task_struct *t;
+	int ret = 0;
+
+	/* Initialize semaphore */
+	sema_init(&eeh_eventlist_sem, 0);
+
+	t = kthread_run(eeh_event_handler, NULL, "eehd");
+	if (IS_ERR(t)) {
+		ret = PTR_ERR(t);
+		pr_err("%s: Failed to start EEH daemon (%d)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 /**
@@ -136,7 +137,8 @@ int eeh_send_failure_event(struct eeh_pe *pe)
 	list_add(&event->list, &eeh_eventlist);
 	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
 
-	schedule_work(&eeh_event_wq);
+	/* For EEH deamon to knick in */
+	up(&eeh_eventlist_sem);
 
 	return 0;
 }
-- 
1.7.5.4
