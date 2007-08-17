Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C873DDE33
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 03:10:59 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7HHAtRI004690
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 13:10:55 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7HHAtCD511878
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 13:10:55 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7HHAs5M017300
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 13:10:54 -0400
Date: Fri, 17 Aug 2007 12:10:53 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] Add scaled time to taskstats based process accounting
Message-ID: <20070817171053.GB4261@austin.ibm.com>
References: <20070816070922.37B5370074@localhost.localdomain>
	<20070816163850.GU4261@austin.ibm.com>
	<18116.52784.132826.595409@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18116.52784.132826.595409@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 17, 2007 at 08:22:40AM +1000, Paul Mackerras wrote:
> Linas Vepstas writes:
> 
> > My gut impression (maybe wrong?) is that the scaled time is,
> > in a certain sense, "more accurate" than the unscaled time.
> 
> The "unscaled" time is just time, as in "how many seconds did this
> task spend on the CPU".  It's what all the tools (except a certain
> proprietary workload manager) expect.  Top, ps, etc. get unhappy if
> the times reported (user, system, hardirq, softirq, idle, stolen)
> don't add up to elapsed wall-clock time.

OK, so to keep the tools happy, the total time needs to add up
to wall-clock time.  Which tells me that the "scaled idle time"
should be defined as "wall clock time minus the other stuff".

> The "scaled" time is really CPU cycles divided by some arbitrary
> factor (the notional CPU frequency).  So yes it does give some
> indication of how much progress the task should have made, in some
> sense.

Yes, good, that's what I was expecting.  As a sysadmin and/or 
back-of-the-envelope performance person, I would certainly like 
to have ps and top report the scaled time. When I do "performance 
tuning", I almost always can get away with quick-n-dirty use of
vmstat and top, and only rarely have to descend into more complex 
tools.  I'd hate to loose this quick-n-dirty utility, which,
again ... my gut impression is that these numbers suddenly turn 
mostly meaningless.

That is, if I run the same task 3 times over the next few hours,
will vmstat/top/ps report more or less he same figures?  I'm 
concerned that they won't ... that I'll see different values
come out, depending on whether the chip is overheating, or whether
some other partition is stealing, or whatever causes this thing to 
dynamically scale.

> Both measures are useful.  Because the current user API is in terms of
> real time rather than cycles, we have to continue reporting real time,
> not scaled time, which is why the existing interfaces report unscaled
> time, and the scaled time values are reported through a new extension
> to the taskstats interface.

This begs the question of "what is the real, actual elapsed time?" 
... currently, the "real time" depends very much on how often your 
process got scheduled -- but, if your process is scheduled but 
(due to scaling) isn't "actually running", should that count towards 
the "real time"?

---
I supose that its inevitable that this stuff will get more complex;
I'm just trying to make sure we don't end up doing this backwards,
and deciding to change it around later.

I already notice that "stolen time" is causing confusion in some 
areas.  Its disconcerting to have lots of cores, and lots of threads
per core, only to find that some of your time has been "stolen".
I'm still wondering ... was this the right way to report this?

--linas
