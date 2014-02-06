Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 777262C02FB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 03:03:59 +1100 (EST)
Date: Thu, 6 Feb 2014 17:03:45 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/3] tick/cpuidle: Initialize hrtimer mode of broadcast
In-Reply-To: <20140206055012.4595.55692.stgit@preeti>
Message-ID: <alpine.DEB.2.02.1402061655560.21991@ionos.tec.linutronix.de>
References: <20140206054158.4595.17827.stgit@preeti>
 <20140206055012.4595.55692.stgit@preeti>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-695086802-1391702627=:21991"
Cc: deepthi@linux.vnet.ibm.com, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-695086802-1391702627=:21991
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 6 Feb 2014, Preeti U Murthy wrote:

Compiler warnings are not so important, right?

kernel/time/tick-broadcast.c: In function ‘tick_broadcast_oneshot_control’:
kernel/time/tick-broadcast.c:700:3: warning: ‘return’ with no value, in function returning non-void [-Wreturn-type]
kernel/time/tick-broadcast.c:711:3: warning: ‘return’ with no value, in function returning non-void [-Wreturn-type]

> +		/*
> +		 * If the current CPU owns the hrtimer broadcast
> +		 * mechanism, it cannot go deep idle.
> +		 */
> +		ret = broadcast_needs_cpu(bc, cpu);

So we leave the CPU in the broadcast mask, just to force another call
to the notify code right away to remove it again. Wouldn't it be more
clever to clear the flag right away? That would make the changes to
the cpuidle code simpler. Delta patch below.

Thanks,

	tglx
---

--- tip.orig/kernel/time/tick-broadcast.c
+++ tip/kernel/time/tick-broadcast.c
@@ -697,7 +697,7 @@ int tick_broadcast_oneshot_control(unsig
 	 * states
 	 */
 	if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC)
-		return;
+		return 0;
 
 	/*
 	 * We are called with preemtion disabled from the depth of the
@@ -708,7 +708,7 @@ int tick_broadcast_oneshot_control(unsig
 	dev = td->evtdev;
 
 	if (!(dev->features & CLOCK_EVT_FEAT_C3STOP))
-		return;
+		return 0;
 
 	bc = tick_broadcast_device.evtdev;
 
@@ -731,9 +731,14 @@ int tick_broadcast_oneshot_control(unsig
 		}
 		/*
 		 * If the current CPU owns the hrtimer broadcast
-		 * mechanism, it cannot go deep idle.
+		 * mechanism, it cannot go deep idle and we remove the
+		 * CPU from the broadcast mask. We don't have to go
+		 * through the EXIT path as the local timer is not
+		 * shutdown.
 		 */
 		ret = broadcast_needs_cpu(bc, cpu);
+		if (ret)
+			cpumask_clear_cpu(cpu, tick_broadcast_oneshot_mask);
 	} else {
 		if (cpumask_test_and_clear_cpu(cpu, tick_broadcast_oneshot_mask)) {
 			clockevents_set_mode(dev, CLOCK_EVT_MODE_ONESHOT);
--8323329-695086802-1391702627=:21991--
