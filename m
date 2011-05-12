Return-Path: <bounces.tip@hpa.at.zytor.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 173F7B6FD7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 20:16:40 +1000 (EST)
Date: Thu, 12 May 2011 10:15:49 GMT
Sender: tip tree robot <bounces.tip@hpa.at.zytor.com>
From: tip-bot for Milton Miller <miltonm@bga.com>
Message-ID: <tip-5db1256a5131d3b133946fa02ac9770a784e6eb2@git.kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/locking] seqlock: Don't smp_rmb in seqlock reader spin loop
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: andi@firstfloor.org, npiggin@kernel.dk, eric.dumazet@gmail.com,
	linuxppc-dev@lists.ozlabs.org, miltonm@bga.com, mingo@redhat.com,
	anton@samba.org, hpa@zytor.com, stable@vger.kernel.org,
	tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
	torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
	anton@samba.org, andi@firstfloor.org, eric.dumazet@gmail.com,
	torvalds@linux-foundation.org, miltonm@bga.com,
	linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
	paulmck@linux.vnet.ibm.com, npiggin@kernel.dk,
	benh@kernel.crashing.org, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  5db1256a5131d3b133946fa02ac9770a784e6eb2
Gitweb:     http://git.kernel.org/tip/5db1256a5131d3b133946fa02ac9770a784e6eb2
Author:     Milton Miller <miltonm@bga.com>
AuthorDate: Thu, 12 May 2011 04:13:54 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 12 May 2011 12:13:43 +0200

seqlock: Don't smp_rmb in seqlock reader spin loop

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

Cc: <stable@vger.kernel.org>
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
---
 include/linux/seqlock.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index e98cd2e..06d6964 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -88,12 +88,12 @@ static __always_inline unsigned read_seqbegin(const seqlock_t *sl)
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
