From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 10 Oct 2003 09:33:14 +0200
To: Bill Fink <billfink@mindspring.com>
Cc: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Time precision, adjtime(x) vs. gettimeofday
Message-ID: <20031010073314.GA14632@iram.es>
References: <20031010011254.078c84a8.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031010011254.078c84a8.billfink@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 10, 2003 at 01:12:54AM -0400, Bill Fink wrote:
>
> On Wed, 08 Oct 2003, Benjamin Herrenschmidt wrote:
>
> > > I repeat the question: what are the values of drift on the machines
> > > that encounter the problem ? Is this drift stable or unstable?
> >
> > So far, there is no problem. The problem that was happening
> > was a via_calibrate_decr() bug with HZ != 100, but when
> > investigating, I figured out that we had a potential problem
> > there, that's all and that's why I want people like you who
> > know those problems well to state if it's worth bothering ;)
> >
> > > > On all cases, those will drift some way from what the NTP server
> > > > will give, either a lot or not, it will. So we may end up adjusting
> > > > our kernel rate and thus opening a window for the problem.
> > >
> > > The worst variations of drift I've seen are a few ppm for a given
> > > machine, barring the occasional boot-time calibration problems that I
> > > have encountered.
> >
> > OK.
>
> This discussion prompted me to finally ask about another clock related
> problem I see on the 867 MHz G4 systems at work.  The clocks on these
> systems continuously run 0.2% slow (about 3 minutes per day).  Apparently
> this is more than ntp can adjust for (using scaling), as I get many of
> these error messages in the log:

Indeed, the limit of NTP is about 500ppm (0.05%) AFAIR. Anything higher
and you go into period time steps like the one you report.

2.4.20 is recent enough and should not have this kind of problems.

What is the initial decrementer frequency from boot messages log?

What is the timebase frequency from OF?
(od -td4 /proc/device-tree/cpus/PowerPC,G4/timebase-frequency)

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
