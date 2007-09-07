Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id C1D10DDE4A
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 18:50:50 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 7 Sep 2007 10:50:43 +0200
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH 1/2] Basic generic time/clocksource code for PowerPC
Message-ID: <20070907085043.GB27058@iram.es>
References: <18144.4514.601900.881855@cargo.ozlabs.ibm.com>
	<20070906165535.GA11420@iram.es>
	<18144.17628.612658.91528@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18144.17628.612658.91528@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2007 at 04:20:12AM +1000, Paul Mackerras wrote:
> Gabriel Paubert writes:
> 
> > On Fri, Sep 07, 2007 at 12:41:38AM +1000, Paul Mackerras wrote:
> > > This changes PowerPC to use the generic time infrastructure for
> > > gettimeofday et al.  We register a clocksource which uses the timebase
> > > register, or the RTC on the 601.
> > > 
> > > It also gets rid of the RTC update stuff.  IIRC we discussed removing
> > > this some time ago but never actually did it.
> > 
> > So who will be in charge of updating the RTC now? The update 
> > every 11 min is there to stay on x86(-64) it seems.
> 
> I had an impression that ntpd would do it, but that seems to be wrong.
> 
> I also have been unable to find where in the kernel source there is
> code for x86[-64] to do the RTC updates.  Do you know where it is?

It goes through CONFIG_CMOS_UPDATE, which is set to Y by default
on i386/x86-64/sparc64.

> 
> Doing the updates from timer_interrupt will no longer really be
> suitable since it is not called at regular intervals any more.  The
> best thing would be for the ntp code to set up a timer when it reaches
> synchronization.

This is what CONFIG_CMOS_UPDATE does through the sync_cmos_timer
variable. 

> 
> > Removing this will have strange side effects: as an example,
> > your laptop clock will be good if it synchronized on NTP, 
> > then you put it to sleep, disconnect the network and RTC read 
> > on wake up returns a wrong value, giving wrong timestamps.
> 
> No, the suspend/resume code reads the RTC on both suspend and resume,
> and advances xtime by the difference between the two readings.  So the
> time might be out by up to a second after resume, but it shouldn't be
> way off, assuming that your RTC is advancing at the right speed.

Ok, I did not know this. Well, my PreP boards never sleep (not worth
when doing real time data acquisition at 100-200 Hz interrupt rate)
but I rely on ntp and a fairly precise time setup at boot in some cases.

Actually I have slightly modified my kernels: I loop waiting 
for the second boundary to set the time and also use one full 
second of the RTC to calibrate the timebase, even that has
its own issues since I cannot use the last and first second 
of every minute because of RTC vagaries:

http://www.st.com/stonline/products/literature/an/5228.pdf

and that does not describe also the calibration which shortens 
or lengthens also specific seconds but I can afford to 
systematically set the calibration factor to 0:

http://www.st.com/stonline/products/literature/an/6393.pdf

This is the only way I found to have reproducible timebase
measurements on these machines; it means that it takes up to 
3 seconds to calibrate the timebase at boot, but it's better
than to have ntp error rate starting to depend on the phase
of the moon (this was my impression when I first found the
problem :-)), or more precisely on which second in the minute
the timebase calibration is performed.

> 
> > As someone who has a network of tens of machines using
> > NTP for synchornisation I think it is a very bad idea
> > unless we have a replacement.
> 
> OK, but I think that doing it in timer_interrupt is the wrong place.

Indeed, but please bring up something using the CONFIG_CMOS_UPDATE
infrastructure. I'm aware that some RTC have awfully slow accesses
(the more recent, the longest the latency it seems), but it is always 
possible to disable it through the no_sync_cmos_clock variable.
Default it to 1 if you want, after all it should not be the job
of the kernel if you have an hypervisor too, I don't care as long as 
you give me the possibility of enabling automatic RTC updates.

	Regards,
	Gabriel
