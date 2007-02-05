Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E767DDE25
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 09:58:10 +1100 (EST)
Subject: [PATCH revision 2] windfarm: dont die on suspend thread signal
From: Johannes Berg <johannes@sipsolutions.net>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070205224325.GA8453@lst.de>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185835.700233000@sipsolutions.net>
	<20070205224325.GA8453@lst.de>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 23:54:34 +0100
Message-Id: <1170716074.30959.13.camel@johannes.berg>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When the windfarm thread gets a suspend signal it will die instead of
freezing. This fixes it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
Adresses Christoph's comment: This keeps the original try_to_freeze() in
place and just remove the code that kills the thread on a signal.

--- mb-wireless.orig/drivers/macintosh/windfarm_core.c	2007-02-05 16:07:10.524524763 +0100
+++ mb-wireless/drivers/macintosh/windfarm_core.c	2007-02-05 23:49:46.004524763 +0100
@@ -117,12 +117,6 @@ static int wf_thread_func(void *data)
 		delay = next - jiffies;
 		if (delay <= HZ)
 			schedule_timeout_interruptible(delay);
-
-		/* there should be no signal, but oh well */
-		if (signal_pending(current)) {
-			printk(KERN_WARNING "windfarm: thread got sigl !\n");
-			break;
-		}
 	}
 
 	DBG("wf: thread stopped\n");
