Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3025DDF1B
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 23:36:56 +1000 (EST)
Subject: [PATCH] windfarm: fix windfarm thread freezer interaction
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 14:33:42 +0200
Message-Id: <1193142822.7733.3.camel@johannes.berg>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When I fixed the windfarm freezer interaction first in commit
1ed2ddf380e19dafeec2150ca709ef7f4a67cd21, an earlier patch than the one
I came up with after comments was committed. This has come back to haunt
us now because commit d5d8c5976d6adeddb8208c240460411e2198b393 changed
the freezer to no long send signals. Fix it by removing the windfarm
thread's signal logic and restoring the original try_to_freeze().

We could simply revert 1ed2ddf380e19dafeec2150ca709ef7f4a67cd21 now
but I feel that the assertion that no signal is delivered to the
windfarm thread needs not be there.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 drivers/macintosh/windfarm_core.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- linux-2.6-git.orig/drivers/macintosh/windfarm_core.c	2007-10-23 14:23:02.406437623 +0200
+++ linux-2.6-git/drivers/macintosh/windfarm_core.c	2007-10-23 14:25:28.745447695 +0200
@@ -94,7 +94,9 @@ static int wf_thread_func(void *data)
 	DBG("wf: thread started\n");
 
 	set_freezable();
-	while(!kthread_should_stop()) {
+	while (!kthread_should_stop()) {
+		try_to_freeze();
+
 		if (time_after_eq(jiffies, next)) {
 			wf_notify(WF_EVENT_TICK, NULL);
 			if (wf_overtemp) {
@@ -116,12 +118,6 @@ static int wf_thread_func(void *data)
 		delay = next - jiffies;
 		if (delay <= HZ)
 			schedule_timeout_interruptible(delay);
-
-		/* there should be no non-suspend signal, but oh well */
-		if (signal_pending(current) && !try_to_freeze()) {
-			printk(KERN_WARNING "windfarm: thread got sigl !\n");
-			break;
-		}
 	}
 
 	DBG("wf: thread stopped\n");
