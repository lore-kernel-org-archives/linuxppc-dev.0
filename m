Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CB0BA2C02FB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 16:54:19 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 6 Feb 2014 00:54:16 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 28B1B6E8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 00:54:09 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s165sD4a8978908
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Feb 2014 05:54:13 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s165sC3d025109
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Feb 2014 00:54:13 -0500
Subject: [PATCH V3 3/3] time/cpuidle:Handle failed call to BROADCAST_ENTER
 on archs with CPUIDLE_FLAG_TIMER_STOP set
To: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, peterz@infradead.org,
 fweisbec@gmail.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 benh@kernel.crashing.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Thu, 06 Feb 2014 11:20:37 +0530
Message-ID: <20140206055036.4595.86947.stgit@preeti>
In-Reply-To: <20140206054158.4595.17827.stgit@preeti>
References: <20140206054158.4595.17827.stgit@preeti>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: deepthi@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some archs set the CPUIDLE_FLAG_TIMER_STOP flag for idle states in which the
local timers stop. The cpuidle_idle_call() currently handles such idle states
by calling into the broadcast framework so as to wakeup CPUs at their next
wakeup event. With the hrtimer mode of broadcast, the BROADCAST_ENTER call
into the broadcast frameowork can fail for archs that do not have an external
clock device to handle wakeups and the CPU in question has to thus be made
the stand by CPU. This patch handles such cases by failing the call into
cpuidle so that the arch can take some default action. The arch will certainly
not enter a similar idle state because a failed cpuidle call will also implicitly
indicate that the broadcast framework has not registered this CPU to be woken up.
Hence we are safe if we fail the cpuidle call.

In the process move the functions that trace idle statistics just before and
after the entry and exit into idle states respectively. In other
scenarios where the call to cpuidle fails, we end up not tracing idle
entry and exit since a decision on an idle state could not be taken. Similarly
when the call to broadcast framework fails, we skip tracing idle statistics
because we are in no further position to take a decision on an alternative
idle state to enter into.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 drivers/cpuidle/cpuidle.c |   38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a55e68f..8f42033 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -117,15 +117,19 @@ int cpuidle_idle_call(void)
 {
 	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
 	struct cpuidle_driver *drv;
-	int next_state, entered_state;
-	bool broadcast;
+	int next_state, entered_state, ret = 0;
+	bool broadcast = false;
 
-	if (off || !initialized)
-		return -ENODEV;
+	if (off || !initialized) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	/* check if the device is ready */
-	if (!dev || !dev->enabled)
-		return -EBUSY;
+	if (!dev || !dev->enabled) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	drv = cpuidle_get_cpu_driver(dev);
 
@@ -137,15 +141,18 @@ int cpuidle_idle_call(void)
 		if (cpuidle_curr_governor->reflect)
 			cpuidle_curr_governor->reflect(dev, next_state);
 		local_irq_enable();
-		return 0;
+		goto out;
 	}
 
-	trace_cpu_idle_rcuidle(next_state, dev->cpu);
-
 	broadcast = !!(drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP);
 
-	if (broadcast)
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+	if (broadcast) {
+		ret = clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+		if (ret)
+			goto out;
+	}
+
+	trace_cpu_idle_rcuidle(next_state, dev->cpu);
 
 	if (cpuidle_state_is_coupled(dev, drv, next_state))
 		entered_state = cpuidle_enter_state_coupled(dev, drv,
@@ -153,16 +160,17 @@ int cpuidle_idle_call(void)
 	else
 		entered_state = cpuidle_enter_state(dev, drv, next_state);
 
-	if (broadcast)
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
-
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* give the governor an opportunity to reflect on the outcome */
 	if (cpuidle_curr_governor->reflect)
 		cpuidle_curr_governor->reflect(dev, entered_state);
 
-	return 0;
+out:	if (broadcast)
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+
+
+	return ret;
 }
 
 /**
