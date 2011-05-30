Return-Path: <greg@kroah.com>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1CF3B6F6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 May 2011 14:21:45 +1000 (EST)
Subject: Patch "seqlock: Don't smp_rmb in seqlock reader spin loop" has been
	added to the 2.6.32-longterm tree
To: miltonm@bga.com, andi@firstfloor.org, anton@samba.org,
	benh@kernel.crashing.org, eric.dumazet@gmail.com, gregkh@suse.de,
	linuxppc-dev@lists.ozlabs.org, npiggin@kernel.dk,
	paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
	torvalds@linux-foundation.org
From: <gregkh@suse.de>
Date: Mon, 30 May 2011 12:14:23 +0800
Message-ID: <13067288631671@kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Cc: stable@kernel.org, stable-commits@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    seqlock: Don't smp_rmb in seqlock reader spin loop

to the 2.6.32-longterm tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/longterm/longterm-queue-2.6.32.git;a=summary

The filename of the patch is:
     seqlock-don-t-smp_rmb-in-seqlock-reader-spin-loop.patch
and it can be found in the queue-2.6.32 subdirectory.

If you, or anyone else, feels it should not be added to the 2.6.32 longterm tree,
please let <stable@kernel.org> know about it.


>From 5db1256a5131d3b133946fa02ac9770a784e6eb2 Mon Sep 17 00:00:00 2001
From: Milton Miller <miltonm@bga.com>
Date: Thu, 12 May 2011 04:13:54 -0500
Subject: seqlock: Don't smp_rmb in seqlock reader spin loop

From: Milton Miller <miltonm@bga.com>

commit 5db1256a5131d3b133946fa02ac9770a784e6eb2 upstream.

Move the smp_rmb after cpu_relax loop in read_seqlock and add
ACCESS_ONCE to make sure the test and return are consistent.

A multi-threaded core in the lab didn't like the update
from 2.6.35 to 2.6.36, to the point it would hang during
boot when multiple threads were active.  Bisection showed
af5ab277ded04bd9bc6b048c5a2f0e7d70ef0867 (clockevents:
Remove the per cpu tick skew) as the culprit and it is
supported with stack traces showing xtime_lock waits including
tick_do_update_jiffies64 and/or update_vsyscall.

Experimentation showed the combination of cpu_relax and smp_rmb
was significantly slowing the progress of other threads sharing
the core, and this patch is effective in avoiding the hang.

A theory is the rmb is affecting the whole core while the
cpu_relax is causing a resource rebalance flush, together they
cause an interfernce cadance that is unbroken when the seqlock
reader has interrupts disabled.

At first I was confused why the refactor in
3c22cd5709e8143444a6d08682a87f4c57902df3 (kernel: optimise
seqlock) didn't affect this patch application, but after some
study that affected seqcount not seqlock. The new seqcount was
not factored back into the seqlock.  I defer that the future.

While the removal of the timer interrupt offset created
contention for the xtime lock while a cpu does the
additonal work to update the system clock, the seqlock
implementation with the tight rmb spin loop goes back much
further, and is just waiting for the right trigger.

Signed-off-by: Milton Miller <miltonm@bga.com>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Nick Piggin <npiggin@kernel.dk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Eric Dumazet <eric.dumazet@gmail.com>
Link: http://lkml.kernel.org/r/%3Cseqlock-rmb%40mdm.bga.com%3E
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/seqlock.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -88,12 +88,12 @@ static __always_inline unsigned read_seq
 	unsigned ret;
 
 repeat:
-	ret = sl->sequence;
-	smp_rmb();
+	ret = ACCESS_ONCE(sl->sequence);
 	if (unlikely(ret & 1)) {
 		cpu_relax();
 		goto repeat;
 	}
+	smp_rmb();
 
 	return ret;
 }


Patches currently in longterm-queue-2.6.32 which might be from miltonm@bga.com are
