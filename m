Message-Id: <4.3.2.20010110104647.00baee80@falcon.si.com>
Date: Wed, 10 Jan 2001 10:56:58 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Using realtime clock? 
In-Reply-To: <200101101506.f0AF6j408007@denx.local.net>
References: <Your message of "Wed, 10 Jan 2001 07:33:58 EST." <4.3.2.20010110072315.00bb5230@falcon.si.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang:

A good place to start is the clock mini HOWTO:
   http://www.linuxdoc.org/HOWTO/mini/Clock.html

The astronomy people, among others, are really fanatical about accurate
time and have some very elaborate programs to synchronize clocks to the
nanosecond (microsecond?) level.  These involve NTP daemons.  Note that
the NTP daemons can synchronize to a radio clock that provides a
1/second tick: your simplest solution would probably be to set up your
accurate RTC to do a 1/second interrupt and then tie it into a NTP
daemon to keep your kernel clock accurate.

Note that utilities like adjtimex (covered in the HOWTO) adjust time
slowly so that it is monotonically increasing (i.e. they speed up or
slow down the tick announcement rather than jamming a new value in the
linux clock).  This is a VERY GOOD feature: otherwise you the risk of
having Really Bad things happen like your cron job running twice if the
clock jam happens to run at just the wrong moment (quite likely,
actually, since you probably update the clock as a cron job).

gvb

Disclaimer: some of this is from memory and may be inaccurate in details.


At 04:06 PM 1/10/01 +0100, Wolfgang Denk wrote:

>In message <4.3.2.20010110072315.00bb5230@falcon.si.com> Jerry Van
>Baren wrote:
> >
> > The "proper" way to handle a RTC is to read it on power up and set the
> > system clock based on it.  From then on, the system clock will be
> > correct and everyone will use the system clock efficiently and
> accurately.
>
>Well, that's the way  it's  often  done,  but  it's  far  from  being
>perfect. On many embedded systems I'm working with the RTC is running
>from  a high precision oscillator which provides much better accuracy
>than the system clock. Both clocks will drift, and usually there will
>be a noticable difference after a few days. This is not really nice.
>
> > On the x86 (PC host), the utility is "hwclock" (man hwclock).  Your
> > best approach is to get the source for that, modify it to read your RTC
> > hardware (which may be different from the PC RTC hardware, although you
> > might get lucky and only have to deal with endian issues).  Then add a
> > call to it in your startup scripts, typically in /etc/rc.d/rc.local.
>
>Any idea how to keep the system clock permanently synchronized to the
>RTC?
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>In an infinite universe all things are possible, including the possi-
>bility that the universe does not exist.
>                         - Terry Pratchett, _The Dark Side of the Sun_
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
