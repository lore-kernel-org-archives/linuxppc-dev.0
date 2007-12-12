Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EE120DDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 14:58:12 +1100 (EST)
Date: Wed, 12 Dec 2007 14:58:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: don't printk with HV spinlock held.
Message-Id: <20071212145812.92ac6f75.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Printk was observed to hang during module unload due to a limited
window of characters that may be sent to the hypervisor.  The window
only reexpands when we receive an ack from the HV and the spinlock here
prevents us from ever processing that ack.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/lpevents.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

Paul, this would be nice for 2.6.24 if at all possible.

diff --git a/arch/powerpc/platforms/iseries/lpevents.c b/arch/powerpc/platforms/iseries/lpevents.c
index 02c1422..e5b40e3 100644
--- a/arch/powerpc/platforms/iseries/lpevents.c
+++ b/arch/powerpc/platforms/iseries/lpevents.c
@@ -121,6 +121,7 @@ void process_hvlpevents(void)
 {
 	struct HvLpEvent * event;
 
+ restart:
 	/* If we have recursed, just return */
 	if (!spin_trylock(&hvlpevent_queue.hq_lock))
 		return;
@@ -146,8 +147,20 @@ void process_hvlpevents(void)
 			if (event->xType < HvLpEvent_Type_NumTypes &&
 					lpEventHandler[event->xType])
 				lpEventHandler[event->xType](event);
-			else
-				printk(KERN_INFO "Unexpected Lp Event type=%d\n", event->xType );
+			else {
+				u8 type = event->xType;
+
+				/*
+				 * Don't printk in the spinlock as printk
+				 * may require ack events form the HV to send
+				 * any characters there.
+				 */
+				hvlpevent_clear_valid(event);
+				spin_unlock(&hvlpevent_queue.hq_lock);
+				printk(KERN_INFO
+					"Unexpected Lp Event type=%d\n", type);
+				goto restart;
+			}
 
 			hvlpevent_clear_valid(event);
 		} else if (hvlpevent_queue.hq_overflow_pending)
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
