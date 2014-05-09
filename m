Return-Path: <anton@samba.org>
Date: Fri, 9 May 2014 17:47:12 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 paulmck@linux.vnet.ibm.com
Subject: [PATCH] powerpc: irq work racing with timer interrupt can result in
 timer interrupt hang
Message-ID: <20140509174712.55fe72d0@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am seeing an issue where a CPU running perf eventually hangs.
Traces show timer interrupts happening every 4 seconds even
when a userspace task is running on the CPU. /proc/timer_list
also shows pending hrtimers have not run in over an hour,
including the scheduler.

Looking closer, decrementers_next_tb is getting set to
0xffffffffffffffff, and at that point we will never take
a timer interrupt again.

In __timer_interrupt() we set decrementers_next_tb to
0xffffffffffffffff and rely on ->event_handler to update it:

        *next_tb = ~(u64)0;
        if (evt->event_handler)
                evt->event_handler(evt);

In this case ->event_handler is hrtimer_interrupt. This will eventually
call back through the clockevents code with the next event to be
programmed:

static int decrementer_set_next_event(unsigned long evt,
                                      struct clock_event_device *dev)
{
        /* Don't adjust the decrementer if some irq work is pending */
        if (test_irq_work_pending())
                return 0;
        __get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;

If irq work came in between these two points, we will return
before updating decrementers_next_tb and we never process a timer
interrupt again.

This looks to have been introduced by 0215f7d8c53f (powerpc: Fix races
with irq_work). Fix it by removing the early exit and relying on
code later on in the function to force an early decrementer:

       /* We may have raced with new irq work */
       if (test_irq_work_pending())
               set_dec(1);

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org # 3.14+
---

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 122a580..4f0b676 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -813,9 +888,6 @@ static void __init clocksource_init(void)
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev)
 {
-	/* Don't adjust the decrementer if some irq work is pending */
-	if (test_irq_work_pending())
-		return 0;
 	__get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;
 	set_dec(evt);
 
