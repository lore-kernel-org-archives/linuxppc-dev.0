Message-ID: <3DACBC0F.DDB832E0@esteem.com>
Date: Tue, 15 Oct 2002 18:08:31 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Patrick Mahoney <pmahoney@8d.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx - power save modes - PIT
References: <20021010183502.GA843@segfault.usine.8d.com> <3DA5F5EC.2844DE06@esteem.com> <20021015225625.GA8153@segfault.usine.8d.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Patrick Mahoney wrote:
>
> Hello Conn,
>
> Progress has been made... I can succesfully raise the clock rate
> divider up to a factor of 8 before the kernel starts. This makes the
> current consumption drop from 0.41A to 0.32A...

Where are you doing this?
Is the divide by 8 in the SCCR[DFNH] or SCCR[DFNL]?
If you are going to have a SCCR[DFNL] divider that drops your clock
speed below 24MHz you need to set the SCCR[CRQEN] bit to keep ethernet
working. (assuming your DFNH keeps it above 24MHz)

>
> Also, the timer thing, that was a rookie mistake... The timer variable
> was declared on init_module stack, which disappeared before the timer
> interrupt. (Thanks to Hollis for that one).
>
> One more thing. I thought I had SCCR[PRQEN] set, but I did not. Thats
> why your idle.c hack caused a hang before the shell came up. I now
> set SCCR[PRQEN] from the planetcore bootloader and can reach the
> shell.
>
> phew!
>
> All right... Now I know 'idled' gets called... The thing is... Power
> consumption stays the same! :(

Power consumption will stay the same as long as you aren't taxing the
CPU with some task. When you have task running that that needs scheduling
it prevents the idle loop from running the power saving code. When the
CPU is kept busy chewing on this task power consumption should rise back
to about what it was before.

>  The only modification i brought is
> going into doze high instead of doze low... Going to doze low changes
> the clock rate and hangs my kernel...


Could you check and see what you have the SCCR[CRQEN] set to?
I belive if your SCCR[DFNL] is set to a divide ratio that is to high
it could keep the CPM from functioning correctly if the SCCR[CRQEN]
bit is not set. If this bit is set your processor should pop back
into normal high mode for any CPM activity.

I recommend that you set the SCCR[DFNH] to divide by 1 (000 binary)
and SCCR[DFNL] to divide by 8 (010 binary) since your board seems to
function that slowly. Also make sure that the SCCR[CRQEN] bit is set.

IF this works we might beable to try a higher division factor in your
SCCR[DFNL] to save more power.

> Here is my comment-stripped
> loop:
>
>                 while(!current->need_resched) {
>                         _nmask_and_or_msr( ( MSR_POW | MSR_EE ), 0);
>                         ((immap_t *)IMAP_ADDR)->im_clkrstk.cark_plprcrk = KAPWR_KEY;
>                         reg = ((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr;
>                         ((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr = reg ;
>                         reg &= 0xFFFFF8FF;
>                         ((immap_t *)IMAP_ADDR)->im_clkrstk.cark_plprcrk = KAPWR_KEY;
>                         reg |= 0x00000100;
>                         ((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr = reg;
>                         _nmask_and_or_msr(0, MSR_POW | MSR_EE);
>                 }
>                 schedule();
>                 check_pgt_cache();
>
> Waddaya think?
> Thanks for you help,
>
> Pat Mahoney
>
> On Thu, Oct 10, 2002 at 02:49:32PM -0700, Conn Clark wrote:
> > Patrick Mahoney wrote:
> > >
> > > Hello pple,

<snip>

> > }
> > #endif

	Your idle loop should work fine. I still don't see why Doze Low mode
hangs your kernel. If you have the SCCR[CRQEN] bit set the only time the CPU
should be in Doze Low mode is when its in the idle loop and no CPM activity
is present. If there is CPM activity it should transparently pop into Doze
High mode then back after the CPM activity has finished. Any interupt should
snap it out of either Doze mode and into Normal High mode until the idle loop
power saving code gets executed again. If the SCCR[CRQEN] bit is set then
Doze High and Doze Low modes in the idle loop should be indistingushable from
one another.

There has to be something fishy about a setting for this not to work.

Please keep me advised.

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
