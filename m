Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 114532C03A7
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2012 14:42:28 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 4 Oct 2012 10:12:26 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q944gOJS37027878
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2012 10:12:24 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q94AC6tY012778
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2012 15:42:06 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [PATCH v1 3/3] cpuidle: (POWER) Fix snooze state problem persistant
 in the current cpuidle design on pseries.
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Date: Thu, 04 Oct 2012 10:12:26 +0530
Message-ID: <20121004044223.15921.72522.stgit@deepthi.in.ibm.com>
In-Reply-To: <20121004044154.15921.51256.stgit@deepthi.in.ibm.com>
References: <20121004044154.15921.51256.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Earlier without cpuidle framework on pseries, the native arch
idle routine comprised of both snooze and nap
states.  smt_snooze_delay variable was used to delay
the idle process entry to deeper idle state like  nap.
With the coming of cpuidle, this arch specific idle was replaced
by two different idle routines, one for supporting snooze and other
for nap. This enabled addition of more
low level idle states on pseries in the future.

On adopting the generic cpuidle framework for POWER systems,
the decision of which idle state to choose from,  given a predicted
idle time is taken by the menu governor based on
target_residency and  exit_latency of the idle states.
target_residency is the minimum time to be resident in that idle state.
Exit_latency is time taken to exit out of idle state.
Deeper the idle state, both the target residency and exit latency
would be higher.

In the current design, smt_snooze_delay is used as target_residency
for the  snooze state which is incorrect, as it is not the
minimum but the maximum duration to be in snooze state.
This would  result in the governor in taking bad decision,
as presently target_residency of nap < target_residency of snooze
inspite of nap being deeper idle state.

This patch aims to fix this problem by replacing the smt_snooze_delay loop
in snooze state, with the need_resched()  as the governor is aware of
entry and exit of various idle transitions based on which
next idle time prediction.

The governor is intelligent enough to determine the idle state the needs to
be transitioned to and maintains a whole of heuristics including
io load, previous idle states predictions etc for the same, based on
which idle state entry decision is taken.

With this fix, of setting target_residency of snooze to 0
					     nap to smt_snooze_delay
if the predicted idle time is less
than smt_snooze_delay (target_residency of nap)
value governor would pick snooze state, else nap. This adhers to the
previous native idle design.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/processor_idle.c |   36 ++++++++---------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index a32d56d..45d00e5 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -59,32 +59,22 @@ static int snooze_loop(struct cpuidle_device *dev,
 {
 	unsigned long in_purr;
 	ktime_t kt_before;
-	unsigned long start_snooze;
-	long snooze = drv->states[0].target_residency;
+	int cpu = dev->cpu;
 
 	idle_loop_prolog(&in_purr, &kt_before);
+	local_irq_enable();
+	set_thread_flag(TIF_POLLING_NRFLAG);
 
-	if (snooze) {
-		start_snooze = get_tb() + snooze * tb_ticks_per_usec;
-		local_irq_enable();
-		set_thread_flag(TIF_POLLING_NRFLAG);
-
-		while ((snooze < 0) || (get_tb() < start_snooze)) {
-			if (need_resched() || cpu_is_offline(dev->cpu))
-				goto out;
-			ppc64_runlatch_off();
-			HMT_low();
-			HMT_very_low();
-		}
-
-		HMT_medium();
-		clear_thread_flag(TIF_POLLING_NRFLAG);
-		smp_mb();
-		local_irq_disable();
+	while ((!need_resched()) && cpu_online(cpu)) {
+		ppc64_runlatch_off();
+		HMT_low();
+		HMT_very_low();
 	}
 
-out:
 	HMT_medium();
+	clear_thread_flag(TIF_POLLING_NRFLAG);
+	smp_mb();
+
 	dev->last_residency =
 		(int)idle_loop_epilog(in_purr, kt_before);
 	return index;
@@ -165,8 +155,8 @@ static struct cpuidle_state dedicated_states[MAX_IDLE_STATE_COUNT] = {
 		.name = "CEDE",
 		.desc = "CEDE",
 		.flags = CPUIDLE_FLAG_TIME_VALID,
-		.exit_latency = 1,
-		.target_residency = 10,
+		.exit_latency = 10,
+		.target_residency = 100,
 		.enter = &dedicated_cede_loop },
 };
 
@@ -197,7 +187,7 @@ void update_smt_snooze_delay(int cpu, int residency)
 			dev->states_usage[1].disable = 1;
 	} else
 		if (drv)
-			drv->states[0].target_residency = residency;
+			drv->states[1].target_residency = residency;
 }
 
 static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
