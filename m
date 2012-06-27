Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B092B6FD3
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:02:26 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 12:02:23 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9C2016E8057
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:18 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG2Ec836372652
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:14 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG28ZL024335
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:08 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/21] ppc/eeh: build EEH event based on PE
Date: Thu, 28 Jun 2012 00:01:40 +0800
Message-Id: <1340812911-6793-11-git-send-email-shangw@linux.vnet.ibm.com>
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

The original implementation builds EEH event based on EEH device.
We already had dedicated struct to depict PE. It's reasonable to
build EEH event based on PE.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh_event.h       |    4 ++--
 arch/powerpc/platforms/pseries/eeh_event.c |   29 ++++++++--------------------
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
index c68b012..dc722b5 100644
--- a/arch/powerpc/include/asm/eeh_event.h
+++ b/arch/powerpc/include/asm/eeh_event.h
@@ -28,10 +28,10 @@
  */
 struct eeh_event {
 	struct list_head	list;	/* to form event queue	*/
-	struct eeh_dev		*edev;	/* EEH device		*/
+	struct eeh_pe		*pe;	/* EEH PE		*/
 };
 
-int eeh_send_failure_event(struct eeh_dev *edev);
+int eeh_send_failure_event(struct eeh_pe *pe);
 struct eeh_dev *handle_eeh_events(struct eeh_event *);
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
index 87fea2e..ab8ca18 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -117,36 +117,23 @@ static void eeh_thread_launcher(struct work_struct *dummy)
 
 /**
  * eeh_send_failure_event - Generate a PCI error event
- * @edev: EEH device
+ * @pe: EEH PE
  *
  * This routine can be called within an interrupt context;
  * the actual event will be delivered in a normal context
  * (from a workqueue).
  */
-int eeh_send_failure_event(struct eeh_dev *edev)
+int eeh_send_failure_event(struct eeh_pe *pe)
 {
 	unsigned long flags;
 	struct eeh_event *event;
-	struct device_node *dn = eeh_dev_to_of_node(edev);
-	const char *location;
-
-	if (!mem_init_done) {
-		printk(KERN_ERR "EEH: event during early boot not handled\n");
-		location = of_get_property(dn, "ibm,loc-code", NULL);
-		printk(KERN_ERR "EEH: device node = %s\n", dn->full_name);
-		printk(KERN_ERR "EEH: PCI location = %s\n", location);
-		return 1;
-	}
-	event = kzalloc(sizeof(*event), GFP_ATOMIC);
-	if (event == NULL) {
-		printk(KERN_ERR "EEH: out of memory, event not handled\n");
-		return 1;
- 	}
-
-	if (edev->pdev)
-		pci_dev_get(edev->pdev);
 
-	event->edev = edev;
+	event = kzalloc(sizeof(*event), GFP_ATOMIC);
+	if (!event) {
+		pr_err("EEH: out of memory, event not handled\n");
+		return -ENOMEM;
+	}
+	event->pe = pe;
 
 	/* We may or may not be called in an interrupt context */
 	spin_lock_irqsave(&eeh_eventlist_lock, flags);
-- 
1.7.9.5
