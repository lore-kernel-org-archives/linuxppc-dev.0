Message-ID: <3DADC571.AF3050F4@esteem.com>
Date: Wed, 16 Oct 2002 13:00:49 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Patrick Mahoney <pmahoney@8d.com>
Cc: Cameron Rich <CameronR@nulec.com.au>,
	May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx - power save modes - PIT
References: <1072F1A27E99D3119747005004B9A380016F9573@MAIL> <20021016132208.GA16734@segfault.usine.8d.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Patrick Mahoney wrote:
>
> > I've tried Conn's code, but I'm experiencing problems with PLPRCR[CSCR] as
> > being 1 all the time after a rfi. I am also occasionally seeing MSR_POW set
> > to 1 after the rfi return.
>
> Well the 2.4 Linux kernel does not support runtime modifications to
> the clock rate. So what's the point of playing with CSCR?

If the CPU is dozing The kernel will never know we changed it as long as
we change it back when the CPU wakes up.

>
> >
> > I can work around this problem by setting PLPRCR[CSCR] = 0 and MSR_POW = 0
> > after the rfi and this eventually works. But is this the solution? I'm also
> > noticing no great decrease in power consumption even though I've only got a
> > couple of (sleeping) processes. And it seems that there is (mostly) no time
> > between entering Doze Low mode and the rfi which confirms the unsatisfactory
> > power consumption figures.
>
> I notice no decrease at all!  :(

You may be expecting to much.

>
> I set both crqen and prqen in the bootloader. The idled routine gets
> entered and executed repeatedly, but no decrease in current
> consumption can be observed.
>
> Pat Mahoney

	Compile up a version of top and see how much time the CPU is Idle.

Good luck

	Conn
--

*****************************************************************
  If you live at home long enough, your parents will move out.
 (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
