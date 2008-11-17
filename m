Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D43CDDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 09:01:00 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mAHM0uIf021082
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 15:00:56 -0700 (MST)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Silence timebase sync code
Date: Mon, 17 Nov 2008 13:58:31 -0800
Message-Id: <1226959111-11221-1-git-send-email-tpiepho@freescale.com>
Cc: Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's over a dozen lines of output and doesn't appear to provide any useful
information.  Even after looking at the code, I'm in the dark about what
"score 299, offset 250" means.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 arch/powerpc/kernel/smp-tbsync.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/smp-tbsync.c b/arch/powerpc/kernel/smp-tbsync.c
index bc892e6..b590135 100644
--- a/arch/powerpc/kernel/smp-tbsync.c
+++ b/arch/powerpc/kernel/smp-tbsync.c
@@ -113,7 +113,7 @@ void __devinit smp_generic_give_timebase(void)
 {
 	int i, score, score2, old, min=0, max=5000, offset=1000;
 
-	printk("Synchronizing timebase\n");
+	pr_info("Synchronizing timebase\n");
 
 	/* if this fails then this kernel won't work anyway... */
 	tbsync = kzalloc( sizeof(*tbsync), GFP_KERNEL );
@@ -123,14 +123,10 @@ void __devinit smp_generic_give_timebase(void)
 	while (!tbsync->ack)
 		barrier();
 
-	printk("Got ack\n");
-
 	/* binary search */
 	for (old = -1; old != offset ; offset = (min+max) / 2) {
 		score = start_contest(kSetAndTest, offset, NUM_ITER);
 
-		printk("score %d, offset %d\n", score, offset );
-
 		if( score > 0 )
 			max = offset;
 		else
@@ -140,8 +136,8 @@ void __devinit smp_generic_give_timebase(void)
 	score = start_contest(kSetAndTest, min, NUM_ITER);
 	score2 = start_contest(kSetAndTest, max, NUM_ITER);
 
-	printk("Min %d (score %d), Max %d (score %d)\n",
-	       min, score, max, score2);
+	pr_debug("Min %d (score %d), Max %d (score %d)\n",
+		 min, score, max, score2);
 	score = abs(score);
 	score2 = abs(score2);
 	offset = (score < score2) ? min : max;
@@ -155,7 +151,7 @@ void __devinit smp_generic_give_timebase(void)
 		if (score2 <= score || score2 < 20)
 			break;
 	}
-	printk("Final offset: %d (%d/%d)\n", offset, score2, NUM_ITER );
+	pr_debug("Final offset: %d (%d/%d)\n", offset, score2, NUM_ITER);
 
 	/* exiting */
 	tbsync->cmd = kExit;
-- 
1.5.4.1
