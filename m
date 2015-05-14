Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEF991A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 13:59:27 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 13 May 2015 21:59:25 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2B7E01FF0049
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 21:50:34 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4E3wu3v34668766
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 20:58:56 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4E3xM5d000430
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 21:59:23 -0600
Message-ID: <55541D95.4020107@linux.vnet.ibm.com>
Date: Thu, 14 May 2015 09:29:17 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <2602092.6h7ufczYGd@vostro.rjw.lan> <5551BCBF.2000806@linaro.org>
 <2919083.VPTOth98op@vostro.rjw.lan> <7h7fsc2idw.fsf@deeprootsystems.com>
In-Reply-To: <7h7fsc2idw.fsf@deeprootsystems.com>
Content-Type: text/plain; charset=UTF-8
Cc: rlippert@google.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 peterz@infradead.org, linus.walleij@linaro.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 Lina Iyer <lina.iyer@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/2015 04:29 AM, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> [...]
> 
>> Second, quite honestly, I don't see a connection to genpd here.
> 
> The connection with genpd is because the *reason* the timer was
> shutdown/stopped is because it shares power with the CPU, which is why
> the timer stops when the CPU hits ceratin low power states.  IOW, it's
> in the same power domain as the CPU.
> 
>> What you seem to be saying is "maybe we can eliminate the need to check the
>> return value of tick_broadcast_enter() in the idle loop if we proactively
>> disable the TIMER_STOP idle states of a CPU when we start to use that CPU's
>> timer as a broadcast one".
>>
>> So this seems to be about the timekeeping rather than power domains, because
>> that's where the broadcast thing is done.  So the code setting up the CPU's
>> timer for broadcast would pretty much need to pause cpuidle, go through the
>> CPU's idle states and disable the TIMER_STOP ones.  And do the reverse when the
>> timer is not going the be used for broadcast any more.  
> 
> Or..., modify the timer subystem to use runtime PM on the timer devices,
> create a genpd that includes the timer device, and use
> pm_genpd_attach_cpuidle() to attach that genpd so that whenever that
> timer is runtime PM active, the deeper C-states cannot be hit.

I think you are missing a point here. If such a solution were possible,
the tick broadcast framework would not have been designed to support
deep cpu idle states. One reason we cannot go this way of course, is not
all archs may support genpd as was pointed out. But the second reason
IMO is that a timer is runtime PM active as long as there is some
deferred work, either in the near or far future.

The point behind the broadcast framework is let these CPUs go to deeper
idle states when the timers are in the "far" future. We can potentially
save power by doing so and don't need to keep the entire power domain
active just because the timer is supposed to fire 5 minutes from now,
which is precisely what happens if we go the genpd way.

Hence I don't think we can trivially club timers with genpd unless we
have a way to power the timer PM domain down, depending on when it is
supposed to fire, in which case we will merely be replicating the
cpuidle governor code.

Regards
Preeti U Murthy

> 
>> So question is whether or not this is actually really more
>> straightforward than checking the return value of
>> tick_broadcast_enter() in the idle loop after all.
> 
> Unfortunetly this problem doesn't only affect timers.
> 
> Daniel's broader point is that $SUBJECT series only handles this for the
> timer, but there's actually a more general problem to solve for *any*
> device that shares a power domain with a CPU (e.g. CPU-local
> timers, interrupt controllers, performance monitoring units, floating
> point units, etc. etc.)
> 
> If we keep adding checks to the idle loop for all those devices, we're
> heading for a mess.  (In fact, this is exactly what CPUidle drivers in
> lots of vendor trees are doing, and it is indeed quite messy, and very
> vendor specific.)
> 
> Also, solving this more general problem was the primary motivation for
> adding the gnpd _attach_cpuidle() feature in the first place, so why not
> use that?
> 
> Longer term, IMO, these dependencies between CPUs and all these "extras"
> logic that share a power domain should be modeled by a genpd.  If all
> those devices are using runtime PM, including the CPUs, and they are
> grouped into a genpd, then we we can very easily know at the genpd level
> whether or not the CPU could be powered down, and to what level.  This
> longer-term solution is what I want to discuss at LPC this year in my
> "Unifiy idle management of CPUs and IO devices" topic[1].  ( Also FYI,
> using a genpd to model a CPU and connected logic is part of the
> motivation behind the recent proposals to add support for multiple
> states to genpd by Axel Haslam. )
> 
> Anyways I digress...
> 
> In the short term, while your patches look fine to me, the objection I
> have is that it's only a band-aid fix that handles timers, but none of
> the other "extras" that might share a power rail with the CPU.  So,
> until we have the long-term stuff sorted out, the better
> short-term solution IMO is the _attach_cpuidle() one above.
> 
> Kevin
> 
> [1] http://wiki.linuxplumbersconf.org/2015:energy-aware_scheduling
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
