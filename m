Message-ID: <3DADAC87.DF5FE2B4@esteem.com>
Date: Wed, 16 Oct 2002 11:14:31 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Patrick Mahoney <pmahoney@8d.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx - power save modes - PIT
References: <20021010183502.GA843@segfault.usine.8d.com> <3DA5F5EC.2844DE06@esteem.com> <20021015225625.GA8153@segfault.usine.8d.com> <3DACBC0F.DDB832E0@esteem.com> <20021016130153.GA16430@segfault.usine.8d.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Patrick Mahoney wrote:
>
> > > Progress has been made... I can succesfully raise the clock rate
> > > divider up to a factor of 8 before the kernel starts. This makes the
> > > current consumption drop from 0.41A to 0.32A...
> >
> > Where are you doing this?
> > Is the divide by 8 in the SCCR[DFNH] or SCCR[DFNL]?
> > If you are going to have a SCCR[DFNL] divider that drops your clock
> > speed below 24MHz you need to set the SCCR[CRQEN] bit to keep ethernet
> > working. (assuming your DFNH keeps it above 24MHz)
>
> I do this in the planetcore bootloader... Ethernet works fine. Note
> that I am not currently combining this technique with any power saving
> mode...

Does the Planetcore Bootloader allow you to specify both the SCCR[DFNH] and
SCCR[DNFL]?

If it doesn't I would recommend you set the board to run at its highest
speed and set the SCCR[DFNL] in the m8xx_setup.c to something like divide
by 8.


>
> > > All right... Now I know 'idled' gets called... The thing is... Power
> > > consumption stays the same! :(
> >
> > Power consumption will stay the same as long as you aren't taxing the
> > CPU with some task. When you have task running that that needs scheduling
> > it prevents the idle loop from running the power saving code. When the
> > CPU is kept busy chewing on this task power consumption should rise back
> > to about what it was before.
>
> I poorly expressed myself here... Let me rephrase...
>
> The idled routine gets executed repeatedly, as it should be. The
> current consumption, however, does not drop. It stays as high as it
> normally is in full high mode.
>

This may be due to other components current demands making the CPU current
seem insignifigant. This power saving idle loop only saved us about .3 watts
or 50mA in current. We are running a 49.1MHz clock with a normal high
division factor of 1 and a normal low division factor of 2. I found that
using Doze Low doubled our current savings vs Doze High. I would expect
better results with a higher normal low division factor.


> > Could you check and see what you have the SCCR[CRQEN] set to?
>
> PLPRCR[CRQEN] and PLPRCR[PRQEN] are both set in the planetcore
> bootloader. If either one of those bit is not set, the chip never
> wakes up from doze mode.


If the PLPRCR[CRQEN] is not set the chip will still wake up. However your
CPM may not work correctly if the clock speed in normal low mode is not
fast enough.

>
> > I belive if your SCCR[DFNL] is set to a divide ratio that is to high
> > it could keep the CPM from functioning correctly if the SCCR[CRQEN]
> > bit is not set. If this bit is set your processor should pop back
> > into normal high mode for any CPM activity.
>
> Currently, the clock divider = 1. This should not be an issue.
>
> >
> > I recommend that you set the SCCR[DFNH] to divide by 1 (000 binary)
> > and SCCR[DFNL] to divide by 8 (010 binary) since your board seems to
> > function that slowly. Also make sure that the SCCR[CRQEN] bit is set.
>
> Why play with SCCR[DFNL] since i use neither normal low nor doze low
> mode?
>

So that you can use Doze Low Mode to save more power.

> >
> >       Your idle loop should work fine. I still don't see why Doze Low mode
> > hangs your kernel.
>
> I found that one out. The kernel does not support runtime clock rate
> modifications. As simple as that.
>

If I have done the idle loop code correctly the kernel shouldn't be able to
tell. I should have sent you an updated idle.c in my response to Cameron.
Try it in Doze Low mode and see if it works with your board now.

>
> Any explanation as to why the consumption does not drop, even if idled
> get called?
>

As explaned earlier your other commponents may swamp the CPU current draw
making savings unnoticable. In Doze high I noticed we only saved about
25mA.

>
> Thanks a lot,
>
> Pat Mahoney

Good luck and keep me advised.

--

*****************************************************************
  If you live at home long enough, your parents will move out.
 (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
