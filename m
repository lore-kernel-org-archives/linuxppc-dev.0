Return-Path: <paubert@iram.es>
Received: from gra-vd1.iram.es (gra-vd1.iram.es [150.214.224.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EEA0567B2A
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 18:09:53 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 8 Apr 2005 10:09:42 +0200
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050408080942.GA3587@iram.es>
References: <20050311172401.18ba47f6.akpm@osdl.org>
	<20050407181726.GS3396@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050407181726.GS3396@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org, Giovambattista Pulcini <gpulcini@swintel.it>
Subject: Re: Fw: Problem with NTP on (embedded) PPC, patch and RFC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 07, 2005 at 11:17:26AM -0700, Tom Rini wrote:
> > Date: Fri, 11 Mar 2005 14:16:32 +0100
> > From: Giovambattista Pulcini <gpulcini@swintel.it>
> > To: LKML <linux-kernel@vger.kernel.org>
> > Subject: Problem with NTP on (embedded) PPC, patch and RFC
> > 
> > 
> > Hi,
> > 
> > On an embedded device based on the IBM 405GP, but this may be a general 
> > problem for most PPC platforms except for chrp and gemini, the NTP 
> > utility 'ntptime' always returns error code 5 (TIME_ERROR) even after 
> > that NTP status reaches the PLL and FLL state. Analysis of problem 
> > showed that the time_state variable set to TIME_ERROR by 
> > do_settimeofday() is never set back to TIME_OK.
> > I found the problem in 2.4.10-1 (Lynuxworks BlueCat) but I also checked 
> > the 2.6.11 and found similar problem. Many architectures under arch/ppc 
> > may be affected with the exception of chrp and gemini.
> > 
> > Steps to reproduce:
> > On a PowerPC (non-CHRP) platform, set the system date with 'date', 
> > configure and start the NTP daemon as client of a working NTP server. 
> > Wait for it to reach the PLL/FLL state. Issue the 'ntptime' command and 
> > check that the following two errors never disappear no matter how long 
> > you let it running: "ntp_gettime() returns code 5 (ERROR)", 
> > "ntp_adjtime() returns code 5 (ERROR)".
> > 
> > Detailed analysis:
> > AFAIK NTP relies on the global time_state variable which is statically 
> > initialized to TIME_OK (kernel/timer.c). The ntptime utility calls 
> > adjtimex() which results in a call to do_adjtimex() and prints its 
> > return value which is basically the value of time_state. It is changed 
> > by (kernel/timer.c)second_overflow() and by the 
> > (kernel/time.c)do_adjtimex() state machine.
> > These two functions never set time_state to TIME_OK once it has been set 
> > to TIME_ERROR.
> > Also, do_settimeofday() sets the STA_UNSYNC flag in time_status and sets 
> > time_state to TIME_ERROR (in ppc but not in ppc64 nor in x86).
> > The function (arch/ppc/kernel/time.c)timer_interrupt() calls the 
> > ppc_md.set_rtc_time() when certain conditions are met, as follows 
> > (time.c:171):
> > 
> >         if ( ppc_md.set_rtc_time && (time_status & STA_UNSYNC) == 0 &&
> >              xtime.tv_sec - last_rtc_update >= 659 &&
> >              abs(xtime.tv_usec - (1000000-1000000/HZ)) < 500000/HZ &&
> >              jiffies - wall_jiffies == 1) {
> >               if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
> > 
> > In the CHRP architecture (see arch/ppc/platforms/chrp_*) the specific 
> > implementation of the set_rtc_time(), chrp_set_rtc_time(), has a check 
> > like this (chrp_time.c:76):
> > 
> >         if ( (time_state == TIME_ERROR) || (time_state == TIME_BAD) )
> >                 time_state = TIME_OK;
> > 
> > which is the only chance for the time_state to be set back to TIME_OK 
> > after a do_settimeofday(). In other platforms this is not done.
> > 
> > 
> > Proposed patch:
> > This change should make NTP to work on any ppc platform, while not 
> > breaking chrp and gemini. Although I've tested it only on mine.
> > --- linux-2.6.11/arch/ppc/kernel/time.c 2005-03-02 08:38:17.000000000 +0100
> > +++ linux/arch/ppc/kernel/time.c        2005-03-08 14:16:56.000000000 +0100
> > @@ -272,7 +272,6 @@
> > 
> >         time_adjust = 0;                /* stop active adjtime() */
> >         time_status |= STA_UNSYNC;
> > -       time_state = TIME_ERROR;        /* p. 24, (a) */
> >         time_maxerror = NTP_PHASE_LIMIT;
> >         time_esterror = NTP_PHASE_LIMIT;
> >         write_sequnlock_irqrestore(&xtime_lock, flags);
> > 
> > 
> > My question:
> > I've read some documentation but I am by no means an expert in the NTP 
> > kernel support implementation. So I ask you where the time_state should 
> > be reset to TIME_OK. Should this be done by the <platform>set_rtc_time() ?
> > Or, as in the x86 case, do_settimeofday should not set time_state to 
> > TIME_ERROR ?
> > 
> > 
> > Giovambattista Pulcini
> 
> So, digging back to 2.2.20 even, i386 does not have this TIME_ERROR
> line, and we do.  Gabriel, as guru of all things NTP-related, can you
> please shed some enlightenment on what should be fixed?  Should we drop
> that line?  Make the various RTC drivers do the check CHRP does (which
> at first thought seems like a 'Hey, that's wrong, let me kludge it' kind
> of thing.  Thanks.

I've been looking into my own archives and this line predates my 
timekeeping patches, which entered the official kernel tree sometime
in the 2.4.0-test series I believe. 

Well, I see that time_state is exclusively used for leap second
processing, so it has nothing to do in the arch specific code.
Please remove all its uses, the only thing that _might_ make sense 
is to try to update the RTC sooner in kernel/timer.c (i.e., set 
last_rtc_update to current time -12 minutes when we switch back 
to TIME_OK so that it will be updated asap). But I don't think
it's worth worrying at this level of detail. 

Now I want to be able to disable is the time interpolator when 
a leap second comes in. The interpolation is the right thing,
or at least the less invasive, thing to do for many users.

It is however the worst thing that can happen when driving a 
telescope: the earth does not start rotating a fraction of a 
percent faster or slower for 20 minutes or so :-)

However, there are other problems with timekeeping in recent
kernels. I'd like to fix them, but I'm short on time (no pun
intended) and right now trying to get out of the whole
bitkeeper fiasco.

	Regards,
	Gabriel
