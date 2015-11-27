Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 933541A013E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 14:06:59 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 22:06:56 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 05BB038C8039
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 22:06:54 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR36rbF22610038
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 03:06:54 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR36rgg019614
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 22:06:53 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [RFC PATCH] powerpc/powernv: Add winkle as cpuidle state
Date: Fri, 27 Nov 2015 14:06:36 +1100
Message-Id: <1448593596-32329-1-git-send-email-stewart@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a *very* RFC patch and one that is no doubt missing something
fairly important that I don't even know about (along with the things
that I know it's lacking).

i.e. don't merge this.

However, posting for discussion of the possibility of enabling winkle
as a cpuidle state on powernv as currently it's just used if we
hotplug out the CPU.

Using powertop with the following two patches:
https://lists.01.org/pipermail/powertop/2015-November/001852.html
https://lists.01.org/pipermail/powertop/2015-November/001854.html
also at: https://github.com/stewart-ibm/powertop/tree/power

I was able to easily measure power consumption of an idle Ubuntu 15.04
system running 4.4.0-rc2+ when idle. With the addition of this patch,
with SMT=3Doff I observed a solid 20W power saving on a dual socket 20 co=
re
system.

It seems that we have a fair few wakeups caused by IPI and dbs_timer.
There's a lot more of them with SMT=3D8 which means we spend a whole bunc=
h
less time in winkle.

After letting the machine be idle for a while, powertop was telling me
the lead causes of wakeup (SMT=3Doff) were:
              25.0 =C2=B5s/s      21.5        Interrupt      [16] IPI
              90.9 =C2=B5s/s      17.5        kWork          dbs_timer
              28.5 =C2=B5s/s       5.3        Interrupt      [3] net_rx(s=
oftirq)

Even with that though, with cores in around 50% winkle, 20W is a pretty
solid power saving that may make us want to reconsider the commonly
held wisdom that the latency of coming out of winkle isn't worth it over
just fastsleep and nap.

With some investigation as to why we're relatively often waking up, we
could get closer to the ideal situation in this workload (well, absence
of workload) in pretty much completely powering off everything but a
single core.

Note that I have *NOT* run any benchmarks on this (and we obviously want
to get the residency and latency measurements correct, likely direct
from firmware... and get them right there too).

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-=
powernv.c
index 845bafcfa792..50726f11ac80 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -93,6 +93,14 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 	return index;
 }
 #endif
+
+static int winkle_loop(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	power7_winkle();
+	return index;
+}
 /*
  * States for dedicated partition case.
  */
@@ -235,6 +243,13 @@ static int powernv_add_idle_states(void)
 			powernv_states[nr_idle_states].enter =3D &fastsleep_loop;
 		}
 #endif
+		if (flags[i] & OPAL_PM_WINKLE_ENABLED) {
+			strcpy(powernv_states[nr_idle_states].name, "winkle");
+			strcpy(powernv_states[nr_idle_states].desc, "winkle");
+			powernv_states[nr_idle_states].flags =3D CPUIDLE_FLAG_TIMER_STOP;
+			powernv_states[nr_idle_states].target_residency =3D 3000000;
+			powernv_states[nr_idle_states].enter =3D &winkle_loop;
+		}
 		powernv_states[nr_idle_states].exit_latency =3D
 				((unsigned int)latency_ns[i]) / 1000;
=20
--=20
2.1.4
