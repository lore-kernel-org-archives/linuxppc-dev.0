Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 423E267A77
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 00:13:59 +1000 (EST)
Subject: [PATCH] windfarm: proper try_to_freeze / signal_pending handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1150847482.16662.13.camel@johannes>
References: <1150847482.16662.13.camel@johannes>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 12:05:44 +0200
Message-Id: <1151057144.7608.14.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This seems to work for me:
---
This patch makes windfarm handle signal_pending()/try_to_freeze()
better.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-git.orig/drivers/macintosh/windfarm_core.c	2006-06-22 16:41:18.182172154 +0200
+++ linux-2.6-git/drivers/macintosh/windfarm_core.c	2006-06-22 16:42:49.045354378 +0200
@@ -93,8 +93,6 @@ static int wf_thread_func(void *data)
 	DBG("wf: thread started\n");
 
 	while(!kthread_should_stop()) {
-		try_to_freeze();
-
 		if (time_after_eq(jiffies, next)) {
 			wf_notify(WF_EVENT_TICK, NULL);
 			if (wf_overtemp) {
@@ -117,8 +115,8 @@ static int wf_thread_func(void *data)
 		if (delay <= HZ)
 			schedule_timeout_interruptible(delay);
 
-		/* there should be no signal, but oh well */
-		if (signal_pending(current)) {
+		/* there should be no non-suspend signal, but oh well */
+		if (signal_pending(current) && !try_to_freeze()) {
 			printk(KERN_WARNING "windfarm: thread got sigl !\n");
 			break;
 		}
