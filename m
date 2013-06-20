Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 19DB52C0315
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 15:21:40 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 01:21:38 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 44AC338C8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:21:35 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K5LZ8M65667162
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:21:35 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K5LYvT001701
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:21:35 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/31] powerpc/eeh: Allow to purge EEH events
Date: Thu, 20 Jun 2013 13:21:02 +0800
Message-Id: <1371705681-24632-13-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform, we might run into the situation where subsequent
events are duplicated events of former one, which is being processed.
For the case, we need the function implemented by the patch to purge
EEH events accordingly.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh_event.h |    1 +
 arch/powerpc/kernel/eeh_event.c      |   37 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
index de92c86..89d5670 100644
--- a/arch/powerpc/include/asm/eeh_event.h
+++ b/arch/powerpc/include/asm/eeh_event.h
@@ -33,6 +33,7 @@ struct eeh_event {
 
 int eeh_event_init(void);
 int eeh_send_failure_event(struct eeh_pe *pe);
+void eeh_remove_event(struct eeh_pe *pe);
 void eeh_handle_event(struct eeh_pe *pe);
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index 62e532d..39bcd81 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -142,3 +142,40 @@ int eeh_send_failure_event(struct eeh_pe *pe)
 
 	return 0;
 }
+
+/**
+ * eeh_remove_event - Remove EEH event from the queue
+ * @pe: Event binding to the PE
+ *
+ * On PowerNV platform, we might have subsequent coming events
+ * is part of the former one. For that case, those subsequent
+ * coming events are totally duplicated and unnecessary, thus
+ * they should be removed.
+ */
+void eeh_remove_event(struct eeh_pe *pe)
+{
+	unsigned long flags;
+	struct eeh_event *event, *tmp;
+
+	spin_lock_irqsave(&eeh_eventlist_lock, flags);
+	list_for_each_entry_safe(event, tmp, &eeh_eventlist, list) {
+		/*
+		 * If we don't have valid PE passed in, that means
+		 * we already have event corresponding to dead IOC
+		 * and all events should be purged.
+		 */
+		if (!pe) {
+			list_del(&event->list);
+			kfree(event);
+		} else if (pe->type & EEH_PE_PHB) {
+			if (event->pe && event->pe->phb == pe->phb) {
+				list_del(&event->list);
+				kfree(event);
+			}
+		} else if (event->pe == pe) {
+			list_del(&event->list);
+			kfree(event);
+		}
+	}
+	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
+}
-- 
1.7.5.4
