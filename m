Message-Id: <4.3.2.20010110114302.00ba2830@falcon.si.com>
Date: Wed, 10 Jan 2001 11:51:27 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Using realtime clock? 
In-Reply-To: <200101101622.f0AGMw208453@denx.local.net>
References: <Your message of "Wed, 10 Jan 2001 10:56:58 EST." <4.3.2.20010110104647.00baee80@falcon.si.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:22 PM 1/10/01 +0100, Wolfgang Denk wrote:
>In message <4.3.2.20010110104647.00baee80@falcon.si.com> you wrote:
> >
> > The astronomy people, among others, are really fanatical about accurate
> > time and have some very elaborate programs to synchronize clocks to the
> > nanosecond (microsecond?) level.  These involve NTP daemons.  Note that
> > the NTP daemons can synchronize to a radio clock that provides a
> > 1/second tick: your simplest solution would probably be to set up your
> > accurate RTC to do a 1/second interrupt and then tie it into a NTP
> > daemon to keep your kernel clock accurate.
>
>Seems a bit of overhead (especially for embedded systems with limited
>resources) to add a NTP daemon just to make one part  of  the  kernel
>timekeeping toal to the other...
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>"It's when they say 2 + 2 = 5 that I begin to argue."    - Eric Pepke

Yup.  However, adjtimex() is a function call that tweaks the clock
parameters in the kernel.  If you understood those parameters (I
don't), you could keep your clock very accurate.

If you tracked down some references (NTP source code, NTP RFCs, "David
L. Mills' clock adjustment algorithm"), I suspect you would be able to
figure out how to properly use adjtimex().  Further, I suspect
adjtimex() a pretty lightweight routine since it merely adjusts the
parameters that presumably already exist in your kernel.

I'm just leaving the fun parts for the reader :-).

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
