Return-Path: <domen@coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id 93C1567A7B
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Mar 2005 21:55:03 +1100 (EST)
To: benh@kernel.crashing.org
From: domen@coderock.org
Date: Sun, 06 Mar 2005 11:44:42 +0100
Message-Id: <20050306104442.B2D671F204@trashy.coderock.org>
Cc: linuxppc-dev@ozlabs.org, janitor@sternwelten.at, domen@coderock.org
Subject: [patch 1/3] list_for_each_entry: drivers-macintosh-via-pmu.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Make code more readable with list_for_each_entry.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/macintosh/via-pmu.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff -puN drivers/macintosh/via-pmu.c~list-for-each-entry-drivers_macintosh_via-pmu drivers/macintosh/via-pmu.c
--- kj/drivers/macintosh/via-pmu.c~list-for-each-entry-drivers_macintosh_via-pmu	2005-03-05 16:09:01.000000000 +0100
+++ kj-domen/drivers/macintosh/via-pmu.c	2005-03-05 16:09:01.000000000 +0100
@@ -2054,12 +2054,9 @@ static LIST_HEAD(sleep_notifiers);
 int
 pmu_register_sleep_notifier(struct pmu_sleep_notifier *n)
 {
-	struct list_head *list;
 	struct pmu_sleep_notifier *notifier;
 
-	for (list = sleep_notifiers.next; list != &sleep_notifiers;
-	     list = list->next) {
-		notifier = list_entry(list, struct pmu_sleep_notifier, list);
+	list_for_each_entry(notifier, &sleep_notifiers, list) {
 		if (n->priority > notifier->priority)
 			break;
 	}
@@ -2085,8 +2082,7 @@ broadcast_sleep(int when, int fallback)
 	struct list_head *list;
 	struct pmu_sleep_notifier *notifier;
 
-	for (list = sleep_notifiers.prev; list != &sleep_notifiers;
-	     list = list->prev) {
+	list_for_each_prev(list, &sleep_notifiers) {
 		notifier = list_entry(list, struct pmu_sleep_notifier, list);
 		ret = notifier->notifier_call(notifier, when);
 		if (ret != PBOOK_SLEEP_OK) {
@@ -2107,14 +2103,10 @@ static int __pmac
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
 
@@ -2716,15 +2708,13 @@ static void __pmac
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
_
