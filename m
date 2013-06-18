Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 922B42C0376
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:34:22 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 02:34:17 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6708D3E4004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:33:56 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I8YEpY370464
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:34:14 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I8YDRf000929
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:34:14 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/31] powerpc/eeh: Allow to purge EEH events
Date: Tue, 18 Jun 2013 16:33:36 +0800
Message-Id: <1371544435-4943-13-git-send-email-shangw@linux.vnet.ibm.com>
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
