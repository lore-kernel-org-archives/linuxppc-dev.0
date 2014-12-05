Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 604241A0BC3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 23:48:20 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 5 Dec 2014 05:48:17 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EE5BA19D801C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 05:36:54 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB5Cmdcd26214514
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 05:48:39 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB5CmDYK022292
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 05:48:14 -0700
Subject: [PATCH] tick-broadcast: Register for hrtimer based broadcast as the
 default broadcast mode
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: tglx@linutronix.de
Date: Fri, 05 Dec 2014 18:17:57 +0530
Message-ID: <20141205124756.25803.4988.stgit@preeti.in.ibm.com>
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

Commit 5d1638acb9f62fa7 added a hrtimer based broadcast mode for those
platforms in which local timers stop when CPUs enter deep idle states. The
commit expected the platforms to register for this mode explicitly when they
lacked a better external device to wake up CPUs in deep idle. Given that
more platforms are beginning to use this mode, we can avoid the call to
set it up on every platform that requires it, by registering for the hrtimer
based broadcast mode in the core code before clock devices begin to get
initialized.

So if there exists a better broadcast device, it will overide the hrtimer
based one; else there is a backup mechanism when a wakeup device is required.
This commit also helps detect cases where the platform fails to register for
a broadcast device but invokes the help of one when entering deep idle states.
Currently we do not handle this situation at all and invoke the help of the
broadcast clock device without checking for its existence. Registering a default
broadcast mode will handle such buggy cases properly.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 arch/arm64/kernel/time.c   |    2 --
 arch/powerpc/kernel/time.c |    1 -
 kernel/time/timekeeping.c  |    4 ++++
 3 files changed, 4 insertions(+), 3 deletions(-)

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
 
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ec1791f..6044a51 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1016,6 +1016,10 @@ void __init timekeeping_init(void)
 		boot.tv_sec = 0;
 		boot.tv_nsec = 0;
 	}
+	/* Register for hrtimer based broadcast as the default timekeeping
+	 * mode in deep idle states.
+	 */
+	tick_setup_hrtimer_broadcast();
 
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
