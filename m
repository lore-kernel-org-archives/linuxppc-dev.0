Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 Aug 2010 16:38:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc, perf_event: Reduce latency of calling
	perf_event_do_pending
Message-ID: <20100811063823.GB15252@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 0fe1ac48 ("powerpc/perf_event: Fix oops due to
perf_event_do_pending call") moved the call to perf_event_do_pending
in timer_interrupt() down so that it was after the irq_enter() call.
Unfortunately this moved it after the code that checks whether it
is time for the next decrementer clock event.  The result is that
the call to perf_event_do_pending() won't happen until the next
decrementer clock event is due.  This was pointed out by Milton
Miller.

This fixes it by moving the check for whether it's time for the
next decrementer clock event down to the point where we're about
to call the event handler, after we've called perf_event_do_pending.

This has the side effect that on old pre-Core99 Powermacs where we
use the ppc_n_lost_interrupts mechanism to replay interrupts, a
replayed interrupt will incur a little more latency since it will
now do the code from the irq_enter down to the irq_exit, that it
used to skip.  However, these machines are now old and rare enough
that this doesn't matter.  To make it clear that ppc_n_lost_interrupts
is only used on Powermacs, and to speed up the code slightly on
non-Powermac ppc32 machines, the code that tests ppc_n_lost_interrupts
is now conditional on CONFIG_PMAC as well as CONFIG_PPC32.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Cc: stable@kernel.org
---
Ingo, Peter: this is for information & comment, I'll ask Ben to send
this to Linus through his tree.

 arch/powerpc/kernel/time.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index ce53dfa..8533b3b 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -577,20 +577,11 @@ void timer_interrupt(struct pt_regs * regs)
 	 * some CPUs will continuue to take decrementer exceptions */
 	set_dec(DECREMENTER_MAX);
 
-#ifdef CONFIG_PPC32
+#if defined(CONFIG_PPC32) && defined(CONFIG_PMAC)
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
 		do_IRQ(regs);
 #endif
 
-	now = get_tb_or_rtc();
-	if (now < decrementer->next_tb) {
-		/* not time for this event yet */
-		now = decrementer->next_tb - now;
-		if (now <= DECREMENTER_MAX)
-			set_dec((int)now);
-		trace_timer_interrupt_exit(regs);
-		return;
-	}
 	old_regs = set_irq_regs(regs);
 	irq_enter();
 
@@ -606,8 +597,16 @@ void timer_interrupt(struct pt_regs * regs)
 		get_lppaca()->int_dword.fields.decr_int = 0;
 #endif
 
-	if (evt->event_handler)
-		evt->event_handler(evt);
+	now = get_tb_or_rtc();
+	if (now >= decrementer->next_tb) {
+		decrementer->next_tb = ~(u64)0;
+		if (evt->event_handler)
+			evt->event_handler(evt);
+	} else {
+		now = decrementer->next_tb - now;
+		if (now <= DECREMENTER_MAX)
+			set_dec((int)now);
+	}
 
 #ifdef CONFIG_PPC_ISERIES
 	if (firmware_has_feature(FW_FEATURE_ISERIES) && hvlpevent_is_pending())
