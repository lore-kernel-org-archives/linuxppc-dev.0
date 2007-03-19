Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3954DE056
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 06:59:14 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2JJxCuW028825
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:59:12 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2JJxBlW068200
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 13:59:11 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2JJxAvG021385
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 13:59:10 -0600
Date: Mon, 19 Mar 2007 14:59:10 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 9/11] ppc64: EEH: rm un-needed data
Message-ID: <20070319195910.GI11532@austin.ibm.com>
References: <20070319194349.GT5151@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070319194349.GT5151@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The EEH event notification system passes around data that is
not needed or at least, not used properly. Stop passing this 
data; get it in a more reliable fashion.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c        |    8 +-------
 arch/powerpc/platforms/pseries/eeh_driver.c |   16 +++-------------
 arch/powerpc/platforms/pseries/eeh_event.c  |    6 +-----
 include/asm-powerpc/eeh_event.h             |    6 +-----
 4 files changed, 6 insertions(+), 30 deletions(-)

Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_event.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh_event.c	2007-02-04 12:44:54.000000000 -0600
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_event.c	2007-03-19 13:21:49.000000000 -0500
@@ -118,9 +118,7 @@ static void eeh_thread_launcher(struct w
  * (from a workqueue).
  */
 int eeh_send_failure_event (struct device_node *dn,
-                            struct pci_dev *dev,
-                            enum pci_channel_state state,
-                            int time_unavail)
+                            struct pci_dev *dev)
 {
 	unsigned long flags;
 	struct eeh_event *event;
@@ -144,8 +142,6 @@ int eeh_send_failure_event (struct devic
 
 	event->dn = dn;
 	event->dev = dev;
-	event->state = state;
-	event->time_unavail = time_unavail;
 
 	/* We may or may not be called in an interrupt context */
 	spin_lock_irqsave(&eeh_eventlist_lock, flags);
Index: linux-2.6.21-rc4-git4/include/asm-powerpc/eeh_event.h
===================================================================
--- linux-2.6.21-rc4-git4.orig/include/asm-powerpc/eeh_event.h	2007-02-04 12:44:54.000000000 -0600
+++ linux-2.6.21-rc4-git4/include/asm-powerpc/eeh_event.h	2007-03-19 13:21:49.000000000 -0500
@@ -30,8 +30,6 @@ struct eeh_event {
 	struct list_head     list;
 	struct device_node 	*dn;   /* struct device node */
 	struct pci_dev       *dev;  /* affected device */
-	enum pci_channel_state state; /* PCI bus state for the affected device */
-	int time_unavail;    /* milliseconds until device might be available */
 };
 
 /**
@@ -46,9 +44,7 @@ struct eeh_event {
  * (from a workqueue).
  */
 int eeh_send_failure_event (struct device_node *dn,
-                            struct pci_dev *dev,
-                            enum pci_channel_state state,
-                            int time_unavail);
+                            struct pci_dev *dev);
 
 /* Main recovery function */
 struct pci_dn * handle_eeh_events (struct eeh_event *);
Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:21:46.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:21:49.000000000 -0500
@@ -346,7 +346,6 @@ int eeh_dn_check_failure(struct device_n
 	int rets[3];
 	unsigned long flags;
 	struct pci_dn *pdn;
-	enum pci_channel_state state;
 	int rc = 0;
 
 	total_mmio_ffs++;
@@ -452,12 +451,7 @@ int eeh_dn_check_failure(struct device_n
 	eeh_mark_slot (dn, EEH_MODE_ISOLATED);
 	spin_unlock_irqrestore(&confirm_error_lock, flags);
 
-	state = pci_channel_io_normal;
-	if ((rets[0] == 1) || (rets[0] == 2) || (rets[0] == 4))
-		state = pci_channel_io_frozen;
-	if (rets[0] == 5)
-		state = pci_channel_io_perm_failure;
-	eeh_send_failure_event (dn, dev, state, rets[2]);
+	eeh_send_failure_event (dn, dev);
 
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 13:21:35.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 13:21:49.000000000 -0500
@@ -342,13 +342,6 @@ struct pci_dn * handle_eeh_events (struc
 		return NULL;
 	}
 
-#if 0
-	/* We may get "permanent failure" messages on empty slots.
-	 * These are false alarms. Empty slots have no child dn. */
-	if ((event->state == pci_channel_io_perm_failure) && (frozen_device == NULL))
-		return;
-#endif
-
 	frozen_pdn = PCI_DN(frozen_dn);
 	frozen_pdn->eeh_freeze_count++;
 
@@ -363,12 +356,9 @@ struct pci_dn * handle_eeh_events (struc
 	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
 		goto excess_failures;
 
-	/* If the reset state is a '5' and the time to reset is 0 (infinity)
-	 * or is more then 15 seconds, then mark this as a permanent failure.
-	 */
-	if ((event->state == pci_channel_io_perm_failure) &&
-	    ((event->time_unavail <= 0) ||
-	     (event->time_unavail > MAX_WAIT_FOR_RECOVERY*1000))) {
+	/* Get the current PCI slot state. */
+	rc = eeh_wait_for_slot_status (frozen_pdn, MAX_WAIT_FOR_RECOVERY*1000);
+	if (rc < 0) {
 		printk(KERN_WARNING "EEH: Permanent failure\n");
 		goto hard_fail;
 	}
