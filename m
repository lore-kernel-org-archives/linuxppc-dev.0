Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B305B7D43
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jun 2010 08:52:59 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp08.in.ibm.com (8.14.4/8.13.1) with ESMTP id o51Lm0gL007642
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jun 2010 03:18:00 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o51Mqv851904834
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jun 2010 04:22:57 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o51Mqt2C018728
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jun 2010 04:22:56 +0530
Date: Wed, 2 Jun 2010 04:22:50 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/5] sched: fix capacity calculations for SMT4
Message-ID: <20100601225250.GA7764@dirshya.in.ibm.com>
References: <20100409062118.D4096CBB6C@localhost.localdomain>
	<1271161766.4807.1280.camel@twins> <2906.1271219317@neuling.org>
	<1271426308.1674.429.camel@laptop>
	<1275294796.27810.21554.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1275294796.27810.21554.camel@twins>
Cc: Michael Neuling <mikey@neuling.org>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <peterz@infradead.org> [2010-05-31 10:33:16]:

> On Fri, 2010-04-16 at 15:58 +0200, Peter Zijlstra wrote:
> > 
> > 
> > Hrmm, my brain seems muddled but I might have another solution, let me
> > ponder this for a bit..
> > 
> 
> Right, so the thing I was thinking about is taking the group capacity
> into account when determining the capacity for a single cpu.
> 
> Say the group contains all the SMT siblings, then use the group capacity
> (usually larger than 1024) and then distribute the capacity over the
> group members, preferring CPUs with higher individual cpu_power over
> those with less.
> 
> So suppose you've got 4 siblings with cpu_power=294 each, then we assign
> capacity 1 to the first member, and the remaining 153 is insufficient,
> and thus we stop and the rest lives with 0 capacity.
> 
> Now take the example that the first sibling would be running a heavy RT
> load, and its cpu_power would be reduced to say, 50, then we still got
> nearly 933 left over the others, which is still sufficient for one
> capacity, but because the first sibling is low, we'll assign it 0 and
> instead assign 1 to the second, again, leaving the third and fourth 0.

Hi Peter,

Thanks for the suggestion.

> If the group were a core group, the total would be much higher and we'd
> likely end up assigning 1 to each before we'd run out of capacity.

This is a tricky case because we are depending upon the
DIV_ROUND_CLOSEST to decide whether to flag capacity to 0 or 1.  We
will not have any task movement until capacity is depleted to quite
low value due to RT task.  Having a threshold to flag 0/1 instead of
DIV_ROUND_CLOSEST just like you have suggested in the power savings
case may help here as well to move tasks to other idle cores.

> For power savings, we can lower the threshold and maybe use the maximal
> individual cpu_power in the group to base 1 capacity from.
> 
> So, suppose the second example, where sibling0 has 50 and the others
> have 294, you'd end up with a capacity distribution of: {0,1,1,1}.

One challenge here is that if RT tasks run on more that one thread in
this group, we will have slightly different cpu powers.  Arranging
them from max to min and having a cutoff threshold should work.

Should we keep the RT scaling as a separate entity along with
cpu_power to simplify these thresholds.  Whenever we need to scale
group load with cpu power can take the product of cpu_power and
scale_rt_power but in these cases where we compute capacity, we can
mark a 0 or 1 just based on whether scale_rt_power was less than
SCHED_LOAD_SCALE or not.  Alternatively we can keep cpu_power as
a product of all scaling factors as it is today but save the component
scale factors also like scale_rt_power() and arch_scale_freq_power()
so that it can be used in load balance decisions.

Basically in power save balance we would give all threads a capacity
'1' unless the cpu_power was reduced due to RT task.  Similarly in
the non-power save case, we can have flag 1,0,0,0 unless first thread
had a RT scaling during the last interval.

I am suggesting to distinguish the reduction is cpu_power due to
architectural (hardware DVFS) reasons from RT tasks so that it is easy
to decide if moving tasks to sibling thread or core can help or not.

--Vaidy
