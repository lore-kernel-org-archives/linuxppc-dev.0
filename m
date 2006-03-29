Return-Path: <linas@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9197E679F3
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 08:55:21 +1100 (EST)
Received: from e33.co.us.ibm.com (e33.boulder.ibm.com [9.17.249.43])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2TLTkhS023045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 16:29:47 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2TLTP6i012638
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 16:29:25 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2TLQE6L270678
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 14:26:14 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2TLTOgu010034
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 14:29:24 -0700
Date: Wed, 29 Mar 2006 15:29:18 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH]: powerpc/pseries: mutex lock to serialze EEH event processing
Message-ID: <20060329212918.GJ2172@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,
Please review/apply/forward upstream. Seems I forgot to do this before.
--linas

[PATCH]: powerpc/pseries: mutex lock to serialze EEH event processing

This patch forces the processing of EEH PCI events to be serialized,
using a very simple mutex lock. This serialization is required to 
avoid races involving additional PCI device failures that may occur
during the recovery hase of a previous failure.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_event.c |   30 +++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

Index: linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_event.c
===================================================================
--- linux-2.6.16-git6.orig/arch/powerpc/platforms/pseries/eeh_event.c	2006-03-28 17:44:38.000000000 -0600
+++ linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_event.c	2006-03-29 14:45:42.522111515 -0600
@@ -19,7 +19,9 @@
  */
 
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/workqueue.h>
 #include <asm/eeh_event.h>
 #include <asm/ppc-pci.h>
 
@@ -37,14 +39,18 @@ LIST_HEAD(eeh_eventlist);
 static void eeh_thread_launcher(void *);
 DECLARE_WORK(eeh_event_wq, eeh_thread_launcher, NULL);
 
+/* Serialize reset sequences for a given pci device */
+DEFINE_MUTEX(eeh_event_mutex);
+
 /**
- * eeh_event_handler - dispatch EEH events.  The detection of a frozen
- * slot can occur inside an interrupt, where it can be hard to do
- * anything about it.  The goal of this routine is to pull these
- * detection events out of the context of the interrupt handler, and
- * re-dispatch them for processing at a later time in a normal context.
- *
+ * eeh_event_handler - dispatch EEH events.
  * @dummy - unused
+ *
+ * The detection of a frozen slot can occur inside an interrupt,
+ * where it can be hard to do anything about it.  The goal of this
+ * routine is to pull these detection events out of the context
+ * of the interrupt handler, and re-dispatch them for processing
+ * at a later time in a normal context.
  */
 static int eeh_event_handler(void * dummy)
 {
@@ -64,23 +70,24 @@ static int eeh_event_handler(void * dumm
 			event = list_entry(eeh_eventlist.next, struct eeh_event, list);
 			list_del(&event->list);
 		}
-		
-		if (event)
-			eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
-
 		spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+
 		if (event == NULL)
 			break;
 
+		/* Serialize processing of EEH events */
+		mutex_lock(&eeh_event_mutex);
+		eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
+
 		printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
 		       pci_name(event->dev));
 
 		handle_eeh_events(event);
 
 		eeh_clear_slot(event->dn, EEH_MODE_RECOVERING);
-
 		pci_dev_put(event->dev);
 		kfree(event);
+		mutex_unlock(&eeh_event_mutex);
 	}
 
 	return 0;
@@ -88,7 +95,6 @@ static int eeh_event_handler(void * dumm
 
 /**
  * eeh_thread_launcher
- *
  * @dummy - unused
  */
 static void eeh_thread_launcher(void *dummy)
