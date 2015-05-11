Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 340C21A0010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 08:48:40 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
Date: Tue, 12 May 2015 01:13:45 +0200
Message-ID: <3712156.vJ010G77Nq@vostro.rjw.lan>
In-Reply-To: <55503C3E.6020804@linux.vnet.ibm.com>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <8965830.CMQzZzsqm0@vostro.rjw.lan> <55503C3E.6020804@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rlippert@google.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 peterz@infradead.org, linus.walleij@linaro.org, rafael.j.wysocki@intel.com,
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

On Monday, May 11, 2015 10:51:02 AM Preeti U Murthy wrote:
> On 05/10/2015 04:45 AM, Rafael J. Wysocki wrote:
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
> >>     do that *before* it has called idle_set_state() for target_state.
> >> (3) Introduce demotion as per my last patch.
> >>
> >> Let me cut patches for that.
> > 
> > Done as per the above and the patches follow in replies to this messge.
> > 
> > All on top of the current linux-next branch of the linux-pm.git tree.
> 
> The patches look good. Based and tested these patches on top of
> linux-pm/linux-next (They are not yet in the branch as far as I can see.)

They aren't in the tree yet.  I'll put them in there later today.

> All patches in this series
> Reviewed and Tested-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Thanks!
