Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com
 [IPv6:2a00:1450:400c:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D11EB1A08B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 22:31:49 +1100 (AEDT)
Received: by wibgn9 with SMTP id gn9so101727863wib.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2015 04:31:45 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 2 Apr 2015 13:31:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] clockevents: Fix cpu down race for hrtimer based
 broadcasting
Message-ID: <20150402113141.GB14370@gmail.com>
References: <20150330092410.24979.59887.stgit@preeti.in.ibm.com>
 <20150402104226.GB21105@gmail.com>
 <551D2733.7040108@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <551D2733.7040108@linux.vnet.ibm.com>
Cc: nicolas.pitre@linaro.org, peterz@infradead.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:

> On 04/02/2015 04:12 PM, Ingo Molnar wrote:
> > 
> > * Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
> > 
> >> It was found when doing a hotplug stress test on POWER, that the machine
> >> either hit softlockups or rcu_sched stall warnings.  The issue was
> >> traced to commit 7cba160ad789a powernv/cpuidle: Redesign idle states
> >> management, which exposed the cpu down race with hrtimer based broadcast
> >> mode(Commit 5d1638acb9f6(tick: Introduce hrtimer based broadcast). This
> >> is explained below.
> >>
> >> Assume CPU1 is the CPU which holds the hrtimer broadcasting duty before
> >> it is taken down.
> >>
> >> CPU0					CPU1
> >>
> >> cpu_down()				take_cpu_down()
> >> 					disable_interrupts()
> >>
> >> cpu_die()
> >>
> >>  while(CPU1 != CPU_DEAD) {
> >>   msleep(100);
> >>    switch_to_idle();
> >>     stop_cpu_timer();
> >>      schedule_broadcast();
> >>  }
> >>
> >> tick_cleanup_cpu_dead()
> >> 	take_over_broadcast()
> >>
> >> So after CPU1 disabled interrupts it cannot handle the broadcast hrtimer
> >> anymore, so CPU0 will be stuck forever.
> >>
> >> Fix this by explicitly taking over broadcast duty before cpu_die().
> >> This is a temporary workaround. What we really want is a callback in the
> >> clockevent device which allows us to do that from the dying CPU by
> >> pushing the hrtimer onto a different cpu. That might involve an IPI and
> >> is definitely more complex than this immediate fix.
> > 
> > So why not use a suitable CPU_DOWN* notifier for this, instead of open 
> > coding it all into a random place in the hotplug machinery?
> 
> This is because each of them is unsuitable for a reason:
> 
> 1. CPU_DOWN_PREPARE stage allows for a fail. The cpu in question may not
> successfully go down. So we may pull the hrtimer unnecessarily.

Failure is really rare - and as long as things will continue to work 
afterwards it's not a problem to pull the hrtimer to this CPU. Right?

Thanks,

	Ingo
