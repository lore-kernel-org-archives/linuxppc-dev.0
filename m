Date: Fri, 10 May 2002 22:15:46 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: "'Troy Benjegerdes'" <hozer@drgw.net>,
	"'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'Paul Mackerras'" <paulus@samba.org>
Subject: RE: Bogomips and loops_per_jiffy
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFFA00C@mail.mediatrix.com>
Message-ID: <Pine.LNX.4.33.0205101659590.23021-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 10 May 2002, Jean-Denis Boyer wrote:

>
> Gabriel, (sorry to all for the previous incomplete mail!)
>
> > I don't yet understand this explanation. Jiffy stamp is
> > initialized in time_init, in the line:
> >
> > last_jiffy_stamp(0) = tb_last_stamp = stamp;
> >
> > and then jiffy_stamp is simply a temporary copy of
> > last_jiffy_stamp in the interrupt handler.
>
> Mmmm! You are right! I was annoyed of always getting the message,
>  "Warning: real time clock seems stuck!"
> and it also caused a 1-2 seconds delay before getting something printed to
> the serial port on boot up.

Yes, but it's basically impossible to detect problems in a time shorter
than the RTC resolution of one second. I'd just love to be able to detect
this condition faster, believe me. I also wrote it to get subsecond
precision initial system time (I don't reach the jiffy, but I don't
remember being off by over 0.1 second very often either).

> So I set the value of ppc_md.get_rtc_time to
> NULL, since I have no RTC. That is why I never enter this code in time_init.
> It correctly removed the annoying message, but brought this insidious bug.

Of course, if you break the initial conditions required by the algorithms,
you run into problems :-).

This explains that I never had this problem since all my boards have a
lithium battery powered timekeeping device called the RTC, not to be
mistaken for the RTC register in the 8260 or the RTCU/RTCL registers
of the PPC601 (actually inherited from IBM's Power AFAICT).

But in any case the solution may be as simple as either set_tb(0,0) as you
did or initializing last_jiffy_stamp(0) and tb_last_stamp with the
timebase value systematically at some earlier point. Which way is a matter
of taste, but at least it won't complicate the existing algorithms which
behave well even in the case of:

- early interrupts which can happen since the decrementer is used as a
self IPI in pmac_pic.c (actually it could be set_dec(0) instead of
set_dec(1) since the dec interrupt triggers on the rising transition of
the MSB).

- late interrupts in which you have to catch up several jiffies, which
happened quite frequently at some point when switching consoles...

I don't have the time to study whether the patches proposed would work
well in all these weird cases.

BTW, how do you initially set the system time in your RTC less machines ?

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
