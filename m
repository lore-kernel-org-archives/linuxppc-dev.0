Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Oct 2008 15:25:28 +1100
Subject: [PATCH] powerpc: Silent SW timebase sync
Message-Id: <20081015042610.7ABA0DDDEE@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When no HW method is provided to sync the timebase, linux uses
a software algorithm.

The code for that is very verbose using straight printk's without
log level. A lot of this is mostly useless unless you want to debug
the process, and we didn't have any problem with it for years anyway
so this turns the bunch of them into pr_debug.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/smp-tbsync.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/smp-tbsync.c	2008-10-15 14:42:24.000000000 +1100
+++ linux-work/arch/powerpc/kernel/smp-tbsync.c	2008-10-15 15:23:03.000000000 +1100
@@ -113,7 +113,7 @@ void __devinit smp_generic_give_timebase
 {
 	int i, score, score2, old, min=0, max=5000, offset=1000;
 
-	printk("Synchronizing timebase\n");
+	pr_debug("Software timebase sync\n");
 
 	/* if this fails then this kernel won't work anyway... */
 	tbsync = kzalloc( sizeof(*tbsync), GFP_KERNEL );
@@ -123,13 +123,13 @@ void __devinit smp_generic_give_timebase
 	while (!tbsync->ack)
 		barrier();
 
-	printk("Got ack\n");
+	pr_debug("Got ack\n");
 
 	/* binary search */
 	for (old = -1; old != offset ; offset = (min+max) / 2) {
 		score = start_contest(kSetAndTest, offset, NUM_ITER);
 
-		printk("score %d, offset %d\n", score, offset );
+		pr_debug("score %d, offset %d\n", score, offset );
 
 		if( score > 0 )
 			max = offset;
@@ -140,8 +140,8 @@ void __devinit smp_generic_give_timebase
 	score = start_contest(kSetAndTest, min, NUM_ITER);
 	score2 = start_contest(kSetAndTest, max, NUM_ITER);
 
-	printk("Min %d (score %d), Max %d (score %d)\n",
-	       min, score, max, score2);
+	pr_debug("Min %d (score %d), Max %d (score %d)\n",
+		 min, score, max, score2);
 	score = abs(score);
 	score2 = abs(score2);
 	offset = (score < score2) ? min : max;
@@ -155,7 +155,7 @@ void __devinit smp_generic_give_timebase
 		if (score2 <= score || score2 < 20)
 			break;
 	}
-	printk("Final offset: %d (%d/%d)\n", offset, score2, NUM_ITER );
+	pr_debug("Final offset: %d (%d/%d)\n", offset, score2, NUM_ITER );
 
 	/* exiting */
 	tbsync->cmd = kExit;
