Date: Fri, 10 Oct 2003 12:39:04 -0400
From: Bill Fink <billfink@mindspring.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org,
	Bill Fink <billfink@mindspring.com>
Subject: Re: Time precision, adjtime(x) vs. gettimeofday
Message-Id: <20031010123904.24a8c6cd.billfink@mindspring.com>
In-Reply-To: <20031010073314.GA14632@iram.es>
References: <20031010011254.078c84a8.billfink@mindspring.com>
	<20031010073314.GA14632@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 10 Oct 2003, Gabriel Paubert wrote:

> On Fri, Oct 10, 2003 at 01:12:54AM -0400, Bill Fink wrote:
> >
> > This discussion prompted me to finally ask about another clock related
> > problem I see on the 867 MHz G4 systems at work.  The clocks on these
> > systems continuously run 0.2% slow (about 3 minutes per day).  Apparently
> > this is more than ntp can adjust for (using scaling), as I get many of
> > these error messages in the log:
>
> Indeed, the limit of NTP is about 500ppm (0.05%) AFAIR. Anything higher
> and you go into period time steps like the one you report.
>
> 2.4.20 is recent enough and should not have this kind of problems.
>
> What is the initial decrementer frequency from boot messages log?

clifford% dmesg | grep -i decr
time_init: decrementer frequency = 33.290001 MHz

> What is the timebase frequency from OF?
> (od -td4 /proc/device-tree/cpus/PowerPC,G4/timebase-frequency)

clifford% od -td4 /proc/device-tree/cpus/PowerPC,G4/timebase-frequency
0000000    33290001
0000004

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
