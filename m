Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B6AE1A0297
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 17:56:00 +1100 (AEDT)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 7 Dec 2014 23:55:56 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5319C3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Dec 2014 23:55:54 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB86uH7Y30081238
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 7 Dec 2014 23:56:17 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB86tprx024341
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 7 Dec 2014 23:55:54 -0700
Subject: [PATCH V2] tick-broadcast: Register for hrtimer based broadcast as
 the fallback broadcast mode
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: tglx@linutronix.de
Date: Mon, 08 Dec 2014 12:25:43 +0530
Message-ID: <20141208065513.3075.48721.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, peterz@infradead.org,
 rafael.j.wysocki@intel.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 jingchang.lu@freescale.com, linux-arm-kernel@lists.infradead.org,
 fweisbec@gmail.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
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
cases properly.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
Changes from V1: https://lkml.org/lkml/2014/12/5/261
1.Moved registering the hrtimer based broadcast from timekeeping code
to an early_initcall.

 arch/arm64/kernel/time.c             |    2 --
 arch/powerpc/kernel/time.c           |    1 -
 include/linux/clockchips.h           |    6 +++---
 kernel/time/tick-broadcast-hrtimer.c |    4 +++-
 4 files changed, 6 insertions(+), 7 deletions(-)

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
index 2e4cb67..91754b0 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -187,11 +187,11 @@ extern int tick_receive_broadcast(void);
 #endif
 
 #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_TICK_ONESHOT)
-extern void tick_setup_hrtimer_broadcast(void);
+extern int __init tick_setup_hrtimer_broadcast(void);
 extern int tick_check_broadcast_expired(void);
 #else
 static inline int tick_check_broadcast_expired(void) { return 0; }
-static inline void tick_setup_hrtimer_broadcast(void) {};
+static inline int __init tick_setup_hrtimer_broadcast(void) { return 0; }
 #endif
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
@@ -207,7 +207,7 @@ static inline void clockevents_resume(void) {}
 
 static inline int clockevents_notify(unsigned long reason, void *arg) { return 0; }
 static inline int tick_check_broadcast_expired(void) { return 0; }
-static inline void tick_setup_hrtimer_broadcast(void) {};
+static inline int __init tick_setup_hrtimer_broadcast(void) { return 0; }
 
 #endif
 
diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index eb682d5..5c35995 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -98,9 +98,11 @@ static enum hrtimer_restart bc_handler(struct hrtimer *t)
 	return HRTIMER_RESTART;
 }
 
-void tick_setup_hrtimer_broadcast(void)
+int __init tick_setup_hrtimer_broadcast(void)
 {
 	hrtimer_init(&bctimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	bctimer.function = bc_handler;
 	clockevents_register_device(&ce_broadcast_hrtimer);
+	return 0;
 }
+early_initcall(tick_setup_hrtimer_broadcast);
