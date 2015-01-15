Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CDCA1A0D9E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 00:22:17 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 06:22:15 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0F9A93E40030
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 06:14:37 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0FDMCC152691090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 06:22:12 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0FDMCct011771
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 06:22:12 -0700
Message-ID: <54B7BEF9.8090603@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 18:52:01 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: offlining cpus breakage
References: <54ACFE6D.3070308@ozlabs.ru>
In-Reply-To: <54ACFE6D.3070308@ozlabs.ru>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alexey,

Can you let me know if the following patch fixes the issue for you ?
It did for us on one of our machines that we were investigating on.

Anton,
Can you let me know if the patch fixes the odd perf report that you observed?
This is the latest fix that there is to it.

-------------------------------START PATCH--------------------------------------

tick/broadcast-hrtimer : Make movement of broadcast hrtimer robust against cpu offline

From: Preeti U Murthy <preeti@linux.vnet.ibm.com>

When a cpu on which the broadcast hrtimer is queued goes offline, the hrtimer
needs to be moved to another cpu. There maybe potential race conditions here,
which can lead to the hrtimer not being queued on any cpu.

There was a report on softlockups, with cpus being stuck in deep idle states,
when smt mode switching was being done, especially on systems with smaller number of
cpus [1]. This is hard to reproduce on a large machine because the chances that an
offline cpu was the stand by cpu handling broadcast become lesser. Given the
current code, the only situation that looks capable of triggering scenarios where
broadcast IPIs are not delivered, is in the cpu offline path. I am
at a loss to pin point the precise scenario.

Therefore to avoid any possible race condition between cpu offline and
movement of the broadcast hrtimer, this patch ensures that the act of keeping
track of broadcasting wakeup IPIs is started afresh after a cpu offline operation.
This is done by reseting the expiry time of the hrtimer to a max value. This
has to be done in the CPU_DYING phase so that it is visible to all cpus right
after exiting stop_machine.

The rationale is that during cpu offline, since all cpus are woken up anyway
to run stop_machine, we are only required to keep track of broadcasting to cpus
that henceforth enter deep idle states. This ensures that the broadcast hrtimer
gets positively queued on a cpu as long as there are cpus in deep idle states.

It has to be noted that this code is in addition to retaining the logic that we
have today in the broadcast code on an offline operation. If this logic fails to
move the broadcast hrtimer due to a race condition we have the following patch to
handle it right.

[1]http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html
There is no issue in programming the decrementer as was presumed and stated in
this link.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/time/clockevents.c    |    2 +-
 kernel/time/tick-broadcast.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 5544990..f3907c9 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -568,6 +568,7 @@ int clockevents_notify(unsigned long reason, void *arg)
 
 	case CLOCK_EVT_NOTIFY_CPU_DYING:
 		tick_handover_do_timer(arg);
+		tick_shutdown_broadcast_oneshot(arg);
 		break;
 
 	case CLOCK_EVT_NOTIFY_SUSPEND:
@@ -580,7 +581,6 @@ int clockevents_notify(unsigned long reason, void *arg)
 		break;
 
 	case CLOCK_EVT_NOTIFY_CPU_DEAD:
-		tick_shutdown_broadcast_oneshot(arg);
 		tick_shutdown_broadcast(arg);
 		tick_shutdown(arg);
 		/*
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 066f0ec..1f5eda6 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -677,6 +677,7 @@ static void broadcast_move_bc(int deadcpu)
 		return;
 	/* This moves the broadcast assignment to this cpu */
 	clockevents_program_event(bc, bc->next_event, 1);
+	bc->next_event.tv64 = KTIME_MAX;
 }
 
 /*

---------------------------------------END PATCH-------------------------
Thanks

Regards
Preeti U Murthy

On 01/07/2015 03:07 PM, Alexey Kardashevskiy wrote:
> Hi!
> 
> "ppc64_cpu --smt=off" produces multiple error on the latest upstream kernel
> (sha1 bdec419):
> 
> NMI watchdog: BUG: soft lockup - CPU#20 stuck for 23s! [swapper/20:0]
> 
> or
> 
> INFO: rcu_sched detected stalls on CPUs/tasks: { 2 7 8 9 10 11 12 13 14 15
> 16 17 18 19 20 21 22 23 2
> 4 25 26 27 28 29 30 31} (detected by 6, t=2102 jiffies, g=1617, c=1616,
> q=1441)
> 
> and many others, all about lockups
> 
> I did bisecting and found out that reverting these helps:
> 
> 77b54e9f213f76a23736940cf94bcd765fc00f40 powernv/powerpc: Add winkle
> support for offline cpus
> 7cba160ad789a3ad7e68b92bf20eaad6ed171f80 powernv/cpuidle: Redesign idle
> states management
> 8eb8ac89a364305d05ad16be983b7890eb462cc3 powerpc/powernv: Enable Offline
> CPUs to enter deep idle states
> 
> btw reverting just two of them produces a compile error.
> 
> It is pseries_le_defconfig, POWER8 machine:
> timebase        : 512000000
> platform        : PowerNV
> model           : palmetto
> machine         : PowerNV palmetto
> firmware        : OPAL v3
> 
> 
> Please help to fix it. Thanks.
> 
> 
