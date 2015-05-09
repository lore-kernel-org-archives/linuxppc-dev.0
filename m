Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 668161A002B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 08:55:25 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, peterz@infradead.org
Subject: [PATCH 3/3] cpuidle: Select a different state on
 tick_broadcast_enter() failures
Date: Sun, 10 May 2015 01:19:52 +0200
Message-ID: <4652506.tkuQIhnkdH@vostro.rjw.lan>
In-Reply-To: <8965830.CMQzZzsqm0@vostro.rjw.lan>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <3161640.llJtBoKCBr@vostro.rjw.lan> <8965830.CMQzZzsqm0@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rlippert@google.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linus.walleij@linaro.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If tick_broadcast_enter() fails in cpuidle_enter_state(),
try to find another idle state to enter instead of invoking
default_idle_call() immediately and returning -EBUSY which
should increase the chances of saving some energy in those
cases.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -73,7 +73,10 @@ int cpuidle_play_dead(void)
 }
 
 static int find_deepest_state(struct cpuidle_driver *drv,
-			      struct cpuidle_device *dev, bool freeze)
+			      struct cpuidle_device *dev,
+			      unsigned int max_latency,
+			      unsigned int forbidden_flags,
+			      bool freeze)
 {
 	unsigned int latency_req = 0;
 	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
@@ -83,6 +86,8 @@ static int find_deepest_state(struct cpu
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
 		if (s->disabled || su->disable || s->exit_latency <= latency_req
+		    || s->exit_latency > max_latency
+		    || (s->flags & forbidden_flags)
 		    || (freeze && !s->enter_freeze))
 			continue;
 
@@ -100,7 +105,7 @@ static int find_deepest_state(struct cpu
 int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 			       struct cpuidle_device *dev)
 {
-	return find_deepest_state(drv, dev, false);
+	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
 }
 
 static void enter_freeze_proper(struct cpuidle_driver *drv,
@@ -139,7 +144,7 @@ int cpuidle_enter_freeze(struct cpuidle_
 	 * that interrupts won't be enabled when it exits and allows the tick to
 	 * be frozen safely.
 	 */
-	index = find_deepest_state(drv, dev, true);
+	index = find_deepest_state(drv, dev, UINT_MAX, 0, true);
 	if (index >= 0)
 		enter_freeze_proper(drv, dev, index);
 
@@ -168,8 +173,13 @@ int cpuidle_enter_state(struct cpuidle_d
 	 * CPU as a broadcast timer, this call may fail if it is not available.
 	 */
 	if (broadcast && tick_broadcast_enter()) {
-		default_idle_call();
-		return -EBUSY;
+		index = find_deepest_state(drv, dev, target_state->exit_latency,
+					   CPUIDLE_FLAG_TIMER_STOP, false);
+		if (index < 0) {
+			default_idle_call();
+			return -EBUSY;
+		}
+		target_state = &drv->states[index];
 	}
 
 	/* Take note of the planned idle state. */
