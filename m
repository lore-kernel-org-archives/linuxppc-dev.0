Return-Path: <paulus@ozlabs.org>
Date: Thu, 11 Feb 2010 14:01:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] perf_event: e500 support
Message-ID: <20100211030143.GA11245@brick.ozlabs.ibm.com>
References: <20100115214351.GA2869@loki.buserror.net>
	<20100210222932.GA9844@brick.ozlabs.ibm.com>
	<4B7349F2.8030802@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B7349F2.8030802@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 10, 2010 at 06:06:10PM -0600, Scott Wood wrote:

> Paul Mackerras wrote:
> >>Some limitations:
> >>- No threshold support -- need to figure out how to represent it in
> >>  the event struct from userspace.
> >
> >What does "threshold support" mean in this context?  Does it mean
> >something different from getting an interrupt after N events have been
> >counted?  Or does it mean counting instances where something takes
> >longer than a specific number of cycles?
> 
> The latter.

OK.  I handled that on classic by using some extra high bits in the
event config for the threshold value.  If you have a single threshold
value in hardware but more than one event that uses that threshold
value, then you will need to add a constraint that all threshold
events have to specify the same threshold.

> >>- When trying to schedule multiple event groups at once, and using
> >>  restricted events, situations could arise where scheduling fails even
> >>  though it would be possible.  Consider three groups, each with two events.
> >>  One group has restricted events, the others don't.  The two non-restricted
> >>  groups are scheduled, then one is removed, which happens to occupy the two
> >>  counters that can't do restricted events.  The remaining non-restricted
> >>  group will not be moved to the non-restricted-capable counters to make
> >>  room if the restricted group tries to be scheduled.  Since thresholds are
> >>  not yet supported (though you can use the events with a threshold of
> >>  zero), and threshold events are the only restricted events, this seems
> >>  like a low priority issue.
> >
> >Which way around are the restrictions?  That some events can only be
> >counted on certain counters, or that some counters can only count a
> >subset of the available events?
> 
> You could look at it either way -- threshold-capable events can only
> go on counters 0-1, or counters 2-3 can only count
> non-threshold-capable events.

So, it sounds like you have a class of events which are the
thresholding events, and two constraints:

* at most two events in the thresholding event class
* at most four events in total

Are there other constraints?  Apart from the thresholding events, can
any event go on any counter, or can some events only be counted on one
particular counter?

> >Did you look at the constraint satisfaction code in the existing
> >perf_event.c and p*-pmu.c?  That lets you express both sorts of
> >restrictions and automatically find the best solution (including
> >moving events from one counter to another like you describe).
> 
> I did look at it -- but I had a hard time understanding it, and went
> with the simpler approach for now since the constraints are minimal
> on these chips.  I'm open to converting with a little help, if it
> doesn't add too much complexity or if future chips need it.

Well, the first thing is that it separates out the question "can the
PMU handle this set of events?" from the question "which counter
should each event go on?".  The second question is handled by
model-specific code, and turns out to be fairly straightforward once
you know the answer to the first question is yes.  In general you just
work from the most constrained events to the least constrained.

For the first question, you have to look at the specific hardware
details of the PMU and turn its programming model into a set of
constraints.  The two main sorts of constraints I used were:

* Some events require a particular hardware register bitfield to be
  programmed to a specific value, so if you have two such events, they
  must require the same value in that bitfield, or else they conflict.
  There can be several such bitfields, each with an associated class
  of events.

* For some events, there is a limit on how many such events the PMU
  can support (for example, your threshold events, where you can have
  at most 2).  For each such limit, there is a class of events which
  are subject to that limit.  There is always the "all events" class,
  which is subject to the limit imposed by the number of PMCs.

Now, obviously you can represent each such constraint with a variable
and have a piece of code for each constraint that checks whether it is
satisfied or not.  What I did with the code for the POWER cpus was to
work out a way to represent all the constraint information in a pair
of unsigned long values ("value" and "mask").  This means that the
constraint checking can be done with some simple integer arithmetic,
and it can be done by generic code that doesn't need to know what the
individual constraints are.

If your constraints are just the two listed above (<= 2 threshold
events, <= 4 events total), then doing it the obvious straightforward
way is fine.  If there are other constraints as well, such as certain
events only being available on one specific PMC, then you should
consider reusing the constraint checking machinery from ppc64.

Paul.
