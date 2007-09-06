Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18144.17628.612658.91528@cargo.ozlabs.ibm.com>
Date: Fri, 7 Sep 2007 04:20:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [RFC/PATCH 1/2] Basic generic time/clocksource code for PowerPC
In-Reply-To: <20070906165535.GA11420@iram.es>
References: <18144.4514.601900.881855@cargo.ozlabs.ibm.com>
	<20070906165535.GA11420@iram.es>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel Paubert writes:

> On Fri, Sep 07, 2007 at 12:41:38AM +1000, Paul Mackerras wrote:
> > This changes PowerPC to use the generic time infrastructure for
> > gettimeofday et al.  We register a clocksource which uses the timebase
> > register, or the RTC on the 601.
> > 
> > It also gets rid of the RTC update stuff.  IIRC we discussed removing
> > this some time ago but never actually did it.
> 
> So who will be in charge of updating the RTC now? The update 
> every 11 min is there to stay on x86(-64) it seems.

I had an impression that ntpd would do it, but that seems to be wrong.

I also have been unable to find where in the kernel source there is
code for x86[-64] to do the RTC updates.  Do you know where it is?

Doing the updates from timer_interrupt will no longer really be
suitable since it is not called at regular intervals any more.  The
best thing would be for the ntp code to set up a timer when it reaches
synchronization.

> Removing this will have strange side effects: as an example,
> your laptop clock will be good if it synchronized on NTP, 
> then you put it to sleep, disconnect the network and RTC read 
> on wake up returns a wrong value, giving wrong timestamps.

No, the suspend/resume code reads the RTC on both suspend and resume,
and advances xtime by the difference between the two readings.  So the
time might be out by up to a second after resume, but it shouldn't be
way off, assuming that your RTC is advancing at the right speed.

> As someone who has a network of tens of machines using
> NTP for synchornisation I think it is a very bad idea
> unless we have a replacement.

OK, but I think that doing it in timer_interrupt is the wrong place.

Paul.
