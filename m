Date: Tue, 3 Aug 2004 14:00:38 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Optimize/fix timer_interrupt loop
Message-ID: <20040803140038.A5454@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The following patch fixes the situation where loop condition could
generate a next_dec of zero while exiting the loop.  This is
undesirable because a Book E decrementer operate a bit differently
from a Classic decrementer. On a Book E core, the decrementer interrupts
on a transition from 1->0. On a Classic core, the decrementer interrupts
on a transition from 0->-1. Exiting the loop and writing a decrementer
value of 0 will not result in an immediate decrementer exception like
on a Classic PPC core.

That said, the whole notion of exiting the loop when next_dec == 0
is suboptimal. Since we are in the timer_interrupt and the jiffy
is _now_, it makes more sense to travel to handling loop one
more time instead of generating yet another interrupt, waiting
until exceptions are reenabled and waiting to be dispatched again.
This should be more efficient for all PPCs, and neatly avoids
the possibility of writing a value of 0 into a Book E decrementer
(thereby disabling it, no exception will occur).

If you made it this far, you must be asking, "How the heck does
this show up in the real world?". :) The easiest path is by
applying the high-res timers patches.  With the notion of a
sub-jiffy interrupt, it's possible to be in timer_interrupt
at the same time that a real jiffy must be processed. With the
current code, this results in a deadlock.  The other method
is by running code with long interrupt off times. In this case,
it's possible to enter timer_interrupt and be processing the
jiffy _very late_, creating the same situation. i.e.
tb_ticks_per_jiffy - tb_delta(jiffy_stamp) is 0.

Comments? Otherwise, I'd like to submit to mainline.

[Thanks to Randy Vinson for doing the real work of locating
 this and helping me to understand more of time.c]

-Matt

===== arch/ppc/kernel/time.c 1.29 vs edited =====
--- 1.29/arch/ppc/kernel/time.c	Tue Jun 22 12:05:08 2004
+++ edited/arch/ppc/kernel/time.c	Tue Aug  3 13:32:22 2004
@@ -161,7 +161,7 @@

 	irq_enter();

-	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
+	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) <= 0) {
 		jiffy_stamp += tb_ticks_per_jiffy;

 		ppc_do_profile(regs);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
