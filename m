Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E3411A03C3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 18:53:15 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 14 Oct 2014 03:53:13 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 8B7EC6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 03:41:54 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9E7rArX51707916
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 07:53:10 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9E7r9iX017297
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 03:53:10 -0400
Subject: [PATCH] cpuidle/powernv: Populate cpuidle state details by querying
 the device-tree
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, rjw@rjwysocki.net, benh@kernel.crashing.org
Date: Tue, 14 Oct 2014 13:23:00 +0530
Message-ID: <20141014075259.11810.50996.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: shreyas@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We hard code the metrics relevant for cpuidle states in the kernel today.
Instead pick them up from the device tree so that they remain relevant
and updated for the system that the kernel is running on.

Cc: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: devicetree@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---

 drivers/cpuidle/cpuidle-powernv.c |   27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index fa79392..b57681d 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -165,7 +165,8 @@ static int powernv_add_idle_states(void)
 	int nr_idle_states = 1; /* Snooze */
 	int dt_idle_states;
 	const __be32 *idle_state_flags;
-	u32 len_flags, flags;
+	const __be32 *idle_state_latency;
+	u32 len_flags, flags, latency_ns;
 	int i;
 
 	/* Currently we have snooze statically defined */
@@ -182,18 +183,32 @@ static int powernv_add_idle_states(void)
 		return nr_idle_states;
 	}
 
+	idle_state_latency = of_get_property(power_mgt,
+			"ibm,cpu-idle-state-latencies-ns", NULL);
+	if (!idle_state_latency) {
+		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-latencies-ns\n");
+		return nr_idle_states;
+	}
+
 	dt_idle_states = len_flags / sizeof(u32);
 
 	for (i = 0; i < dt_idle_states; i++) {
 
 		flags = be32_to_cpu(idle_state_flags[i]);
+
+		/* Cpuidle accepts exit_latency in us and we estimate
+		 * target residency to be 10x exit_latency
+		 */
+		latency_ns = be32_to_cpu(idle_state_latency[i]);
 		if (flags & IDLE_USE_INST_NAP) {
 			/* Add NAP state */
 			strcpy(powernv_states[nr_idle_states].name, "Nap");
 			strcpy(powernv_states[nr_idle_states].desc, "Nap");
 			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIME_VALID;
-			powernv_states[nr_idle_states].exit_latency = 10;
-			powernv_states[nr_idle_states].target_residency = 100;
+			powernv_states[nr_idle_states].exit_latency =
+					((unsigned int)latency_ns) / 1000;
+			powernv_states[nr_idle_states].target_residency =
+					((unsigned int)latency_ns / 100);
 			powernv_states[nr_idle_states].enter = &nap_loop;
 			nr_idle_states++;
 		}
@@ -204,8 +219,10 @@ static int powernv_add_idle_states(void)
 			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
 			powernv_states[nr_idle_states].flags =
 				CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TIMER_STOP;
-			powernv_states[nr_idle_states].exit_latency = 300;
-			powernv_states[nr_idle_states].target_residency = 1000000;
+			powernv_states[nr_idle_states].exit_latency =
+					((unsigned int)latency_ns) / 1000;
+			powernv_states[nr_idle_states].target_residency =
+					((unsigned int)latency_ns / 100);
 			powernv_states[nr_idle_states].enter = &fastsleep_loop;
 			nr_idle_states++;
 		}
