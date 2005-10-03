Return-Path: <mgreer@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 190D668423
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Oct 2005 06:46:40 +1000 (EST)
Date: Mon, 3 Oct 2005 13:46:08 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Corey Minyard <minyard@acm.org>
Message-ID: <20051003204608.GC29005@mag.az.mvista.com>
References: <20050929183221.GA17292@i2.minyard.local>
	<20050929203647.GA6597@mag.az.mvista.com>
	<433D557C.4020301@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <433D557C.4020301@acm.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: MV64x60 watchdog timer driver updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 30, 2005 at 10:10:52AM -0500, Corey Minyard wrote:
> Mark A. Greer wrote:
> 
> >On Thu, Sep 29, 2005 at 01:32:21PM -0500, Corey Minyard wrote:
> > 
> >
> >>James looked at an earlier version and said it was ok, and suggested
> >>a few changes.  This has been tested against 2.6.14-rc2 on a Katana.
> >>
> >>Note that the bus_clk value from the platform information seems to
> >>be in MHZ, but the actual frequency is generally 133,333,333, not
> >>133,000,000.  I don't think the inaccuracy matters here, but it seems
> >>a little odd.
> >>   
> >>
> >
> >Yes, it makes more sense to me to pass the actual frequency and not do
> >the '* 1000000'.
> > 
> >
> The only trouble is if  you go over 4GHZ...  Maybe it should be in KHZ 
> instead of MHZ?  or 64-bits?  Or maybe we don't worry about >4GHZ busses?

My vote is to worry about it when the time comes.  IIRC, the fastest a
Marvell bridge part can be clocked right now is 200 MHz so there's some time.

> Also, how would one go about changing this?  Would you need something like:
> 
> if (bus_clk < 1000)
>  bus_clk *= 1000000
> 
> for backwards compatability?

When I didn't see anyone passing that value in via platform_data so
there's no compatibility issue.  I could have missed something though...

> >Also--I should have thought of this earlier--there should probably be a
> >patch to add a default platform_data entry in arch/ppc/syslib/mv64x60.c
> >and a patch for katana.c if the defaults in mv64x60.c aren't correct
> >for the katana.  At least, that's how things are done now.
> > 
> >
> I'm not sure I understand completely.  How would you go about setting 
> the platform data?

Look near the top of arch/ppc/syslib/mv64x60.c and you will see a bunch
of default platform_data being set up for marvell bridges.  They can then
be tweaked by the platform specific code via the platform_notify() hook
(see arch/ppc/platforms/katana.c:katana_platform_notify(), et. al.).

Mark
