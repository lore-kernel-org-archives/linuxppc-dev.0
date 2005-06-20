Return-Path: <domen@nd47.coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id A4C4867B26
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2005 07:57:11 +1000 (EST)
Message-Id: <20050620215246.859337000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:52:47 +0200
From: domen@coderock.org
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, domen@coderock.org
Subject: [patch 1/1] [Fwd: [patch 1/3] list_for_each_entry:
	drivers-macintosh-via-pmu.c]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Domen Puncer <domen@coderock.org>


Replace for loops with nice list_for_each* macros.

Signed-off-by: Domen Puncer <domen@coderock.org>
---
 via-pmu.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

Index: quilt/drivers/macintosh/via-pmu.c
===================================================================
--- quilt.orig/drivers/macintosh/via-pmu.c
+++ quilt/drivers/macintosh/via-pmu.c
@@ -2062,8 +2062,7 @@ pmu_register_sleep_notifier(struct pmu_s
 	struct list_head *list;
 	struct pmu_sleep_notifier *notifier;
 
-	for (list = sleep_notifiers.next; list != &sleep_notifiers;
-	     list = list->next) {
+	list_for_each(list, &sleep_notifiers) {
 		notifier = list_entry(list, struct pmu_sleep_notifier, list);
 		if (n->priority > notifier->priority)
 			break;
@@ -2090,8 +2089,7 @@ broadcast_sleep(int when, int fallback)
 	struct list_head *list;
 	struct pmu_sleep_notifier *notifier;
 
-	for (list = sleep_notifiers.prev; list != &sleep_notifiers;
-	     list = list->prev) {
+	list_for_each_prev(list, &sleep_notifiers) {
 		notifier = list_entry(list, struct pmu_sleep_notifier, list);
 		ret = notifier->notifier_call(notifier, when);
 		if (ret != PBOOK_SLEEP_OK) {
@@ -2112,14 +2110,10 @@ static int __pmac
 broadcast_wake(void)
 {
 	int ret = PBOOK_SLEEP_OK;
-	struct list_head *list;
 	struct pmu_sleep_notifier *notifier;
 
-	for (list = sleep_notifiers.next; list != &sleep_notifiers;
-	     list = list->next) {
-		notifier = list_entry(list, struct pmu_sleep_notifier, list);
+	list_for_each_entry(notifier, &sleep_notifiers, list)
 		notifier->notifier_call(notifier, PBOOK_WAKE);
-	}
 	return ret;
 }
 
@@ -2731,15 +2725,13 @@ static void __pmac
 pmu_pass_intr(unsigned char *data, int len)
 {
 	struct pmu_private *pp;
-	struct list_head *list;
 	int i;
 	unsigned long flags;
 
 	if (len > sizeof(pp->rb_buf[0].data))
 		len = sizeof(pp->rb_buf[0].data);
 	spin_lock_irqsave(&all_pvt_lock, flags);
-	for (list = &all_pmu_pvt; (list = list->next) != &all_pmu_pvt; ) {
-		pp = list_entry(list, struct pmu_private, list);
+	list_for_each_entry(pp, &all_pmu_pvt, list) {
 		spin_lock(&pp->lock);
 		i = pp->rb_put + 1;
 		if (i >= RB_SIZE)

--
