Date: Wed, 10 Jan 2001 20:05:16 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Jerry Van Baren <vanbaren_gerald@si.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using realtime clock? 
In-Reply-To: <4.3.2.20010110104647.00baee80@falcon.si.com>
Message-ID: <Pine.HPX.4.10.10101101955310.1811-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 10 Jan 2001, Jerry Van Baren wrote:

>
> Wolfgang:
>
> A good place to start is the clock mini HOWTO:
>    http://www.linuxdoc.org/HOWTO/mini/Clock.html
>
> The astronomy people, among others, are really fanatical about accurate
> time and have some very elaborate programs to synchronize clocks to the
> nanosecond (microsecond?) level.  These involve NTP daemons.  Note that
> the NTP daemons can synchronize to a radio clock that provides a
> 1/second tick: your simplest solution would probably be to set up your
> accurate RTC to do a 1/second interrupt and then tie it into a NTP
> daemon to keep your kernel clock accurate.

As an astronomer, I'm not that fanatical about clock accuracy, let us say
a couple of milliseconds is sufficient. OTOH VLBI and pulsar astronomers
are absolutely obsessed by clock precision. But yes, ntp is the protocol
to use to synchronize machines on a LAN: one machine has a radio clock
or whatever and all the other lock on it through ntp.

>
> Note that utilities like adjtimex (covered in the HOWTO) adjust time
> slowly so that it is monotonically increasing (i.e. they speed up or
> slow down the tick announcement rather than jamming a new value in the
> linux clock).  This is a VERY GOOD feature: otherwise you the risk of
> having Really Bad things happen like your cron job running twice if the
> clock jam happens to run at just the wrong moment (quite likely,
> actually, since you probably update the clock as a cron job).

ntp does it too, actually they both ajust the duration of the jiffy though
the adjtimex syscall. Funny things may still happen around leap seconds
however (one second is repeated).

Why would you update the clock as a cron job ?

ntpd does it (actually the kernel does it on a regular basis when adjtimex
tells it that the pll with the time server is closed).

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
