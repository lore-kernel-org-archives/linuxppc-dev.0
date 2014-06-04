Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A15E1A0AC3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 17:31:59 +1000 (EST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DEB3714009E
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2014 17:31:58 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Jun 2014 17:31:58 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C41923578052
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2014 17:31:54 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s547VcWH4456740
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2014 17:31:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s547VrjV021879
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2014 17:31:53 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: Fix killed EEH event
Date: Wed,  4 Jun 2014 17:31:52 +1000
Message-Id: <1401867112-7297-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform, EEH errors are reported by IO accessors or poller
driven by interrupt. After the PE is isolated, we won't produce EEH
event for the PE. The current implementation has possibility of EEH
event lost in this way:

The interrupt handler queues one "special" event, which drives the poller.
EEH thread doesn't pick the special event yet. IO accessors kicks in, the
frozen PE is marked as "isolated" and EEH event is queued to the list.
EEH thread runs because of special event and purge all existing EEH events.
However, we never produce an other EEH event for the frozen PE. Eventually,
the PE is marked as "isolated" and we don't have EEH event to recover it.

The patch fixes the issue to keep EEH events for PEs that have been
marked as "isolated" with the help of additional "force" help to
eeh_remove_event().

Reported-by: Rolf Brudeseth <rolfb@us.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh_event.h      |  2 +-
 arch/powerpc/kernel/eeh_driver.c          |  4 ++--
 arch/powerpc/kernel/eeh_event.c           | 21 +++++++++++++++------
 arch/powerpc/platforms/powernv/eeh-ioda.c |  2 +-
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
index 89d5670..1e551a2 100644
--- a/arch/powerpc/include/asm/eeh_event.h
+++ b/arch/powerpc/include/asm/eeh_event.h
@@ -33,7 +33,7 @@ struct eeh_event {
 
 int eeh_event_init(void);
 int eeh_send_failure_event(struct eeh_pe *pe);
-void eeh_remove_event(struct eeh_pe *pe);
+void eeh_remove_event(struct eeh_pe *pe, bool force);
 void eeh_handle_event(struct eeh_pe *pe);
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 8bb40e7..420da61 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -770,7 +770,7 @@ static void eeh_handle_special_event(void)
 			eeh_serialize_lock(&flags);
 
 			/* Purge all events */
-			eeh_remove_event(NULL);
+			eeh_remove_event(NULL, true);
 
 			list_for_each_entry(hose, &hose_list, list_node) {
 				phb_pe = eeh_phb_pe_get(hose);
@@ -789,7 +789,7 @@ static void eeh_handle_special_event(void)
 			eeh_serialize_lock(&flags);
 
 			/* Purge all events of the PHB */
-			eeh_remove_event(pe);
+			eeh_remove_event(pe, true);
 
 			if (rc == EEH_NEXT_ERR_DEAD_PHB)
 				eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index 72d748b..4eefb6e 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -152,24 +152,33 @@ int eeh_send_failure_event(struct eeh_pe *pe)
 /**
  * eeh_remove_event - Remove EEH event from the queue
  * @pe: Event binding to the PE
+ * @force: Event will be removed unconditionally
  *
  * On PowerNV platform, we might have subsequent coming events
  * is part of the former one. For that case, those subsequent
  * coming events are totally duplicated and unnecessary, thus
  * they should be removed.
  */
-void eeh_remove_event(struct eeh_pe *pe)
+void eeh_remove_event(struct eeh_pe *pe, bool force)
 {
 	unsigned long flags;
 	struct eeh_event *event, *tmp;
 
+	/*
+	 * If we have NULL PE passed in, we have dead IOC
+	 * or we're sure we can report all existing errors
+	 * by the caller.
+	 *
+	 * With "force", the event with associated PE that
+	 * have been isolated, the event won't be removed
+	 * to avoid event lost.
+	 */
 	spin_lock_irqsave(&eeh_eventlist_lock, flags);
 	list_for_each_entry_safe(event, tmp, &eeh_eventlist, list) {
-		/*
-		 * If we don't have valid PE passed in, that means
-		 * we already have event corresponding to dead IOC
-		 * and all events should be purged.
-		 */
+		if (!force && event->pe &&
+		    (event->pe->state & EEH_PE_ISOLATED))
+			continue;
+
 		if (!pe) {
 			list_del(&event->list);
 			kfree(event);
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index cab3e62..f1f089d 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -797,7 +797,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 	 * And we should keep the cached OPAL notifier event sychronized
 	 * between the kernel and firmware.
 	 */
-	eeh_remove_event(NULL);
+	eeh_remove_event(NULL, false);
 	opal_notifier_update_evt(OPAL_EVENT_PCI_ERROR, 0x0ul);
 
 	list_for_each_entry(hose, &hose_list, list_node) {
-- 
1.8.3.2
