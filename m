Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id C68211A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 09:06:08 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
Date: Tue, 12 May 2015 01:31:14 +0200
Message-ID: <2602092.6h7ufczYGd@vostro.rjw.lan>
In-Reply-To: <5550E999.8080005@linaro.org>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <8965830.CMQzZzsqm0@vostro.rjw.lan> <5550E999.8080005@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rlippert@google.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org,
 peterz@infradead.org, linus.walleij@linaro.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, May 11, 2015 07:40:41 PM Daniel Lezcano wrote:
> On 05/10/2015 01:15 AM, Rafael J. Wysocki wrote:
> > On Saturday, May 09, 2015 10:33:05 PM Rafael J. Wysocki wrote:
> >> On Saturday, May 09, 2015 10:11:41 PM Rafael J. Wysocki wrote:
> >>> On Saturday, May 09, 2015 11:19:16 AM Preeti U Murthy wrote:
> >>>> Hi Rafael,
> >>>>
> >>>> On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:
> >>>
> >>> [cut]
> >>>
> >>>>>>
> >>>>>> +	/* Take note of the planned idle state. */
> >>>>>> +	idle_set_state(smp_processor_id(), target_state);
> >>>>>
> >>>>> And I wouldn't do this either.
> >>>>>
> >>>>> The behavior here is pretty much as though the driver demoted the state chosen
> >>>>> by the governor and we don't call idle_set_state() again in those cases.
> >>>>
> >>>> Why is this wrong?
> >>>
> >>> It is not "wrong", but incomplete, because demotions done by the cpuidle driver
> >>> should also be taken into account in the same way.
> >>>
> >>> But I'm seeing that the recent patch of mine that made cpuidle_enter_state()
> >>> call default_idle_call() was a mistake, because it might confuse find_idlest_cpu()
> >>> significantly as to what state the CPU is in.  I'll drop that one for now.
> >>
> >> OK, done.
> >>
> >> So after I've dropped it I think we need to do three things:
> >> (1) Move the idle_set_state() calls to cpuidle_enter_state().
> >> (2) Make cpuidle_enter_state() call default_idle_call() again, but this time
> >>      do that *before* it has called idle_set_state() for target_state.
> >> (3) Introduce demotion as per my last patch.
> >>
> >> Let me cut patches for that.
> >
> > Done as per the above and the patches follow in replies to this messge.
> >
> > All on top of the current linux-next branch of the linux-pm.git tree.
> 
> IMO the resulting code is more and more confusing.

Why is it confusing?

What part of it is confusing?

Patches [1-2/3] simply replace https://patchwork.kernel.org/patch/6326761/
and I'm not sure why that would be confusing.

Patch [3/3] simply causes cpuidle_enter_state() to pick up a more suitable
state if tick_broadcast_enter() fails instead of returning an error code
in that case.  What exactly is confusing in that?

> Except I miss something, the tick_broadcast_enter can fail only if the 
> local timer of the current cpu is used as a broadcast timer (which is 
> the case today for PPC only).

well, why does this matter?

> The correct fix would be to tie this local timer with the cpu power 
> domain and disable the idle state powering down this domain like it was 
> done for the renesas cpuidle driver.
> 
> IOW, the cpu power domain is in use (because of its local timer), so we 
> shouldn't shut it down.
> 
> No ?

Sorry, I'm not sure what you're talking about.

The problem at hand is that tick_broadcast_enter() can fail and we need to
handle that.  If we can prevent it from ever failing, that would be awesome,
but quite honestly I don't see how to do that ATM.

> I am aware this is not easily fixable because the genpd framework is 
> incomplete and has some restrictions but I believe it is worth to have a 
> discussion. Add Kevin and Ulf in Cc.

So I'm going to queue up these patches for 4.2 and we can have a discussion
just fine regardless.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
