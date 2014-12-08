Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D9441A026E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 23:23:49 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 8 Dec 2014 05:23:47 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E755238C8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 07:23:43 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB8CNhHX21430296
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 12:23:43 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB8CNfNE021041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 07:23:43 -0500
Subject: [PATCH V3] tick-broadcast: Register for hrtimer based broadcast as
 the fallback broadcast mode
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: mark.rutland@arm.com, tglx@linutronix.de
Date: Mon, 08 Dec 2014 17:53:27 +0530
Message-ID: <20141208122210.5639.82110.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: lorenzo.pieralisi@arm.com, peterz@infradead.org, rafael.j.wysocki@intel.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, jingchang.lu@freescale.com,
 linux-arm-kernel@lists.infradead.org, fweisbec@gmail.com, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 5d1638acb9f6 ('tick: Introduce hrtimer based broadcast') added a
hrtimer based broadcast mode for those platforms in which local timers stop
when CPUs enter deep idle states. The commit expected the platforms to
register for this mode explicitly when they lacked a better external device
to wake up CPUs in deep idle. Given that more platforms are beginning to use
this mode, we can avoid the call to set it up on every platform that requires
it, by registering for the hrtimer based broadcast mode in the core code if
no better broadcast device is available.

This commit also helps detect cases where the platform fails to register for
a broadcast device but invokes the help of one when entering deep idle states.
Currently we do not handle this situation at all and call the broadcast clock
device without checking for its existence. This patch will handle such buggy
cases properly. While at it, give a name to this mode of broadcast which was
missing all along.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
Changes from V1: https://lkml.org/lkml/2014/12/5/261
1.Moved registering the hrtimer based broadcast from timekeeping code
to an early_initcall.

Changes from V2: https://lkml.org/lkml/2014/12/8/57
1.Added the 'name' param to hrtimer broadcast mode and removed the prototype
to setup this mode since there are no external callers of it.

 arch/arm64/kernel/time.c             |    2 --
 arch/powerpc/kernel/time.c           |    1 -
 include/linux/clockchips.h           |    3 ---
 kernel/time/tick-broadcast-hrtimer.c |    5 ++++-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 1a7125c..47baaa8 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -70,8 +70,6 @@ void __init time_init(void)
 	of_clk_init(NULL);
 	clocksource_of_init();
 
-	tick_setup_hrtimer_broadcast();
-
 	arch_timer_rate = arch_timer_get_rate();
 	if (!arch_timer_rate)
 		panic("Unable to initialise architected timer.\n");
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7505599..51433a8 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -942,7 +942,6 @@ void __init time_init(void)
 	clocksource_init();
 
 	init_decrementer_clockevent();
-	tick_setup_hrtimer_broadcast();
 }
 
 
diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 2e4cb67..c362143 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -187,11 +187,9 @@ extern int tick_receive_broadcast(void);
 #endif
 
 #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_TICK_ONESHOT)
-extern void tick_setup_hrtimer_broadcast(void);
 extern int tick_check_broadcast_expired(void);
 #else
 static inline int tick_check_broadcast_expired(void) { return 0; }
-static inline void tick_setup_hrtimer_broadcast(void) {};
 #endif
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
@@ -207,7 +205,6 @@ static inline void clockevents_resume(void) {}
 
 static inline int clockevents_notify(unsigned long reason, void *arg) { return 0; }
 static inline int tick_check_broadcast_expired(void) { return 0; }
-static inline void tick_setup_hrtimer_broadcast(void) {};
 
 #endif
 
diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index eb682d5..1f6bc6a 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -72,6 +72,7 @@ static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 }
 
 static struct clock_event_device ce_broadcast_hrtimer = {
+	.name			= "broadcast_hrtimer",
 	.set_mode		= bc_set_mode,
 	.set_next_ktime		= bc_set_next,
 	.features		= CLOCK_EVT_FEAT_ONESHOT |
@@ -98,9 +99,11 @@ static enum hrtimer_restart bc_handler(struct hrtimer *t)
 	return HRTIMER_RESTART;
 }
 
-void tick_setup_hrtimer_broadcast(void)
+static int __init tick_setup_hrtimer_broadcast(void)
 {
 	hrtimer_init(&bctimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	bctimer.function = bc_handler;
 	clockevents_register_device(&ce_broadcast_hrtimer);
+	return 0;
 }
+early_initcall(tick_setup_hrtimer_broadcast);
