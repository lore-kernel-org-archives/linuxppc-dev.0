Message-ID: <3DA62C69.A5BD884F@esteem.com>
Date: Thu, 10 Oct 2002 18:42:01 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Patrick Mahoney <pmahoney@8d.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx - power save modes - PIT
References: <20021010183502.GA843@segfault.usine.8d.com> <3DA5F5EC.2844DE06@esteem.com> <20021010230042.GA8690@segfault.usine.8d.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Patrick Mahoney wrote:
>
> Conn,
>
> Thanks a lot for your reply.
>
> >       I have played with some of the power saving modes on our custom
> > 850 board and have had no problems. I have toyed with the Doze High and
> > Doze Low modes in the idle loop. Attached is a hacked up idle loop for
> > kernel 2.4.19 that works for me.
>
>
> I recompiled and booted... it crashed on me! :( Maybe some differences
> with the platform... I'll look into that tomorrow.
>

I forgot to mention my kernel source tree was directly from kernel.org

When using my idle loop, does it crash right away or only when you try to
use the PIT?


>
>
> > Is there any particular reason you want to wake up the processor with
> > the PIT instead of just letting any old interrupt wake it up?
>
> Well i'd just like to be able to say : "im going to sleep. please wake
> me in 5 seconds". If theres an easier way, please enlighten me! :)

	Well if you put the power saving code in the idle loop, when there
isn't anything to do the processor sleeps. When an interrupt happens it
wakes up to service the interrupt then checks to see if it is needed for
other things and if not it goes back to bed (much like me ;-)). If you need
to do something 5 seconds later a sleep call should do the trick unless
you need more precision.

>
> > You should be able to drop my idle.c in place of the old one. To disable
> > my hack just comment out the #define MPC8XX_POWERSAVE . My comments
> > shouldn't be to hard to understand. Also I have the SCCR[PRQEN] and the
> > SCCR[CRQEN] bits set.
>
> Yep, i'll dig into it tomorrow. I'm kind of allergic to inline
> assembly, but it's allright... ill have some pills! ;)
>

	I had it all in C at one point which worked. I have to disable
interrupts and I don't like to be in this state any longer than I have to.
Its a practice I got driven into my head from my Z80 days. Besides, the
inline asm is quicker and smaller and saves you more power because you get
the processor to sleep sooner ;-) . If we all wrote our idle loops in
assembly we could get nothing done a lot quicker.

>
> Once again, thanks a lot for your help.
> Best regards,
>
> Pat Mahoney

If you find something out please let me know.

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
