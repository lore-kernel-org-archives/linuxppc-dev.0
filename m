Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9011DB70A4
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:54:28 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 10:54:25 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id CC46519DA3FA
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 16:02:30 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG2BV2157090
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:14 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG29sW004789
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:10 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 17/21] ppc/eeh: make EEH handler PE sensitive
Date: Thu, 28 Jun 2012 00:01:47 +0800
Message-Id: <1340812911-6793-18-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once eeh error is found, eeh event will be created and put it into
the global linked list. At the mean while, kernel thread will be
started to process it. The handler for the kernel thread originally
was eeh device sensitive.

The patch reworks the handler of the kernel thread so that it's PE
sensitive.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_event.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
index ab8ca18..67c82c2 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -57,7 +57,7 @@ static int eeh_event_handler(void * dummy)
 {
 	unsigned long flags;
 	struct eeh_event *event;
-	struct eeh_dev *edev;
+	struct eeh_pe *pe;
 
 	set_task_comm(current, "eehd");
 
@@ -76,27 +76,23 @@ static int eeh_event_handler(void * dummy)
 
 	/* Serialize processing of EEH events */
 	mutex_lock(&eeh_event_mutex);
-	edev = event->edev;
-	eeh_mark_slot(eeh_dev_to_of_node(edev), EEH_MODE_RECOVERING);
+	pe = event->pe;
+	eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
+	pr_info("EEH: Detected PCI bus error on PHB#%d-PE#%x\n",
+		pe->phb->global_number, pe->addr);
 
-	printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
-	       eeh_pci_name(edev->pdev));
+	handle_eeh_events(event);
 
-	set_current_state(TASK_INTERRUPTIBLE);	/* Don't add to load average */
-	edev = handle_eeh_events(event);
-
-	eeh_clear_slot(eeh_dev_to_of_node(edev), EEH_MODE_RECOVERING);
-	pci_dev_put(edev->pdev);
+	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 
 	kfree(event);
 	mutex_unlock(&eeh_event_mutex);
 
 	/* If there are no new errors after an hour, clear the counter. */
-	if (edev && edev->freeze_count>0) {
+	if (pe && pe->freeze_count > 0) {
 		msleep_interruptible(3600*1000);
-		if (edev->freeze_count>0)
-			edev->freeze_count--;
-
+		if (pe->freeze_count > 0)
+			pe->freeze_count--;
 	}
 
 	return 0;
-- 
1.7.9.5
