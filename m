Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 708872C0353
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 18:44:52 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 8 Sep 2012 02:44:49 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8BB6719D803C
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 02:44:37 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q888ibSe220498
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 02:44:37 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q888iawm003343
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 02:44:36 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/22] ppc/eeh: build EEH event based on PE
Date: Sat,  8 Sep 2012 16:44:11 +0800
Message-Id: <1347093863-6319-11-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/eeh_event.h       |    4 +-
 arch/powerpc/platforms/pseries/eeh_event.c |   29 +++++++--------------------
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
index 6132772..7f89f1e 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -119,36 +119,23 @@ static void eeh_thread_launcher(struct work_struct *dummy)
 
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
1.7.5.4
