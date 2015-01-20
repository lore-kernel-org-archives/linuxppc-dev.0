Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1971A097F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:36:46 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 20 Jan 2015 03:36:44 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CEBD23E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 03:36:05 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0KAarSb42008764
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 03:36:53 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0KAaepD004460
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 03:36:41 -0700
Subject: [PATCH V3] tick/broadcast: Make movement of broadcast hrtimer
 robust against hotplug
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: tglx@linutronix.de
Date: Tue, 20 Jan 2015 16:06:30 +0530
Message-ID: <20150120103559.8430.50933.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: aik@ozlabs.ru, shreyas@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 michael@ellerman.id.au, anton@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today if the cpu handling broadcasting of wakeups goes offline, the job of
broadcasting is handed over to another cpu in the CPU_DEAD phase. The CPU_DEAD
notifiers are run only after the offline cpu sets its state as CPU_DEAD.
Meanwhile, the kthread doing the offline is scheduled out while waiting for
this transition by queuing a timer. This is fatal because if the cpu on which
this kthread was running has no other work queued on it, it can re-enter deep
idle state, since it sees that a broadcast cpu still exists. However the broadcast
wakeup will never come since the cpu which was handling it is offline, and the cpu
on which the kthread doing the hotplug operation was running never wakes up to see
this because its in deep idle state.

Fix this by setting the broadcast timer to a max value so as to force the cpus
entering deep idle states henceforth to freshly nominate the broadcast cpu. More
importantly this has to be done in the CPU_DYING phase so that it is visible to
all cpus right after exiting stop_machine, which is when they can re-enter idle.
This ensures that handover of the broadcast duty falls in place on offline of the
broadcast cpu, without having to do it explicitly.

It fixes the bug reported here:
http://linuxppc.10917.n7.nabble.com/offlining-cpus-breakage-td88619.html

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
Changes from previous versions:
1. Modification to the changelog
2. Clarified the comments

 kernel/time/clockevents.c    |    2 +-
 kernel/time/tick-broadcast.c |    7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

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
index 066f0ec..f983983 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -675,8 +675,11 @@ static void broadcast_move_bc(int deadcpu)
 
 	if (!bc || !broadcast_needs_cpu(bc, deadcpu))
 		return;
-	/* This moves the broadcast assignment to this cpu */
-	clockevents_program_event(bc, bc->next_event, 1);
+	/* Since a cpu with the earliest wakeup is nominated as the 
+	 * standby cpu, the next cpu to invoke BROADCAST_ENTER
+	 * will now automatically take up the duty of broadcasting.
+	 */
+	bc->next_event.tv64 = KTIME_MAX;
 }
 
 /*
