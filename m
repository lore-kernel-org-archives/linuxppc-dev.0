Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BE251A0D32
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 03:50:55 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 18 Jan 2015 09:50:52 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id EEECF1FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jan 2015 09:42:01 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0IGnXBn25362458
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jan 2015 09:49:33 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0IGomrH023929
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jan 2015 09:50:49 -0700
Message-ID: <54BBE464.7000704@linux.vnet.ibm.com>
Date: Sun, 18 Jan 2015 22:20:44 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: offlining cpus breakage
References: <54ACFE6D.3070308@ozlabs.ru> <54B7BEF9.8090603@linux.vnet.ibm.com>
 <54B85B3C.1030000@ozlabs.ru> <1421377482.18166.5.camel@ellerman.id.au>
 <54BA660B.7050609@linux.vnet.ibm.com>
In-Reply-To: <54BA660B.7050609@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/17/2015 07:09 PM, Preeti U Murthy wrote:
> On 01/16/2015 08:34 AM, Michael Ellerman wrote:
>> On Fri, 2015-01-16 at 13:28 +1300, Alexey Kardashevskiy wrote:
>>> On 01/16/2015 02:22 AM, Preeti U Murthy wrote:
>>>> Hi Alexey,
>>>>
>>>> Can you let me know if the following patch fixes the issue for you ?
>>>> It did for us on one of our machines that we were investigating on.
>>>
>>> This fixes the issue for me as well, thanks!
>>>
>>> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>	
>>
>> OK, that's great.
>>
>> But, I really don't think we can ask upstream to merge this patch to generic
>> code when we don't have a good explanation for why it's necessary. At least I'm
>> not going to ask anyone to do that :)
>>
>> So Pretti can you either write a 100% convincing explanation of why this patch
>> is correct in the general case, or (preferably) do some more investigating to
>> work out what Alexey's bug actually is.
> 
> On further investigation, I found that the issue lies in the latency of
> cpu hotplug operation, specifically the time taken for the offline cpu
> to enter powersave mode.
> 
> The time between the beginning of the cpu hotplug operation and the
> beginning of __cpu_die() operation (which is one of the last stages of
> cpu hotplug) takes around a maximum of 40ms. Although this is not
> causing softlockups, it is quite a large duration.
> 
> The more serious issue is the time taken for __cpu_die() operation to
> complete. The __cpu_die() operation waits for the offline cpu to set its
> state to CPU_DEAD before entering powersave state. This time varies from
> 4s to a maximum of 200s! It is not this bad always but it does happen
> quite a few times. It is during these times that we observe softlockups.
> I added trace prints throughout the cpu hotplug code to measure these
> numbers. This delay is causing the softlockup and here is why.
> 
> If the cpu going offline is the one broadcasting wakeups to cpus in
> fastsleep, it queues the broadcast timer on another cpu during the
> CPU_DEAD phase. The CPU_DEAD notifiers are run only after the
> __cpu_die() operation completes, which is taking a long time as
> mentioned above. So between the time irqs are migrated off the about to
> go offline cpu and CPU_DEAD stage, no cpu can be woken up. The above
> numbers show that this can be a horridly long time. Hence the next time
> that they get woken up the unnatural idle time is detected and
> softlockup triggers.
> 
> The patch on this thread that I proposed covered up the problem by
> allowing the remaining cpus to freshly reevaluate their wakeups after
> the stop machine phase without having to depend on the previous
> broadcast state.So it did not matter what the previously appointed
> broadcast cpu was upto.However there are still corner cases which cannot
> get solved with this patch. And understandably because it is not
> addressing the core issue, which is how to get around the latency issue
> of cpu hotplug.
> 
> There can be ways in which the broadcast timer be migrated in time
> during hotplug to get around the softlockups, but the latency of the cpu
> hotplug operation looks like a serious issue. Has anybody observed or
> explicitly instrumented cpu hotplug operation before and happened to
> notice the large time duration required for its completion?
> 
> Ccing Paul.

Ok, finally the problem is clear. The latency observed during hotplug
was a result of a bug in the tick-broadcast framework in the cpu offline
path as was previously presumed. The problem description and the apt fix
is below.

Alexey, would you mind giving this patch a try yet again ? I will
post it out to mainline as soon as you confirm it fixes your issue.
This patch is a tad bit different from the previous one.

Thanks!

Regards
Preeti U Murthy

-------------------------start patch-----------------------------------

tick/broadcast: Make movement of broadcast hrtimer robust against hotplug

From: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Today if a cpu handling broadcasting of wakeups goes offline, it hands over
the job of broadcasting to another cpu in the CPU_DEAD phase. The CPU_DEAD
notifiers are run only after the offline cpu sets its state as CPU_DEAD.
Meanwhile, the kthread doing the offline is scheduled out while waiting for
this transition by queuing a timer. This is fatal because if the cpu on which
this kthread was running has no other work queued on it, it can re-enter deep
idle state, since it sees that a broadcast cpu still exists. However the broadcast
wakeup will never come since the cpu which was handling it is offline, and this cpu
never wakes up to see this because its in deep idle state.

Fix this by setting the broadcast timer to a max value so as to force the cpus
entering deep idle states henceforth to freshly nominate the broadcast cpu. More
importantly this has to be done in the CPU_DYING phase so that it is visible to
all cpus right after exiting stop_machine, which is when they can re-enter idle.
This ensures that handover of the broadcast duty falls in place on offline, without
having to do it explicitly.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/time/clockevents.c    |    2 +-
 kernel/time/tick-broadcast.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 066f0ec..e9c1d9b 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -675,8 +675,8 @@ static void broadcast_move_bc(int deadcpu)
 
 	if (!bc || !broadcast_needs_cpu(bc, deadcpu))
 		return;
-	/* This moves the broadcast assignment to this cpu */
-	clockevents_program_event(bc, bc->next_event, 1);
+	/* This allows fresh nomination of broadcast cpu */
+	bc->next_event.tv64 = KTIME_MAX;
 }
 
 /*
> 
> Thanks
> 
> Regards
> Preeti U Murthy
>>
>> cheers
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
