Message-ID: <3C0E2113.779E89DF@laposte.net>
Date: Wed, 05 Dec 2001 14:28:51 +0100
From: Phil <ibm405.linux@laposte.net>
MIME-Version: 1.0
To: frowand@mvista.com
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More walnut boottime "fun" and BDI2000 
References: <20011127103042.A11612@cse.unsw.edu.au> <20011126221728.D13091@cpe-24-221-152-185.az.sprintbbd.net> <20011127050754.B15728@cx258813-a.chnd1.az.home.com> <3C0CD3C6.ECB0E61B@laposte.net> <20011204141147.GD17651@cpe-24-221-152-185.az.sprintbbd.net> <3C0CDCB1.9F3A9423@laposte.net> <3C0D06F8.57DD8837@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Rowand a écrit :
>
> Phil wrote:
> >
> > I resync the kernel sources today at 7:15 am GMT.
> > Any idea ?
> >
> > Tom Rini a écrit :
> > >
> > > On Tue, Dec 04, 2001 at 02:46:46PM +0100, Phil wrote:
> > >
> > > > I'am trying to boot the latest linuxppc_2_4_devel kernel version
> > > > (2.4.27-pre2).
> > >
> > > What date?  This isn't a problem anymore, at least on a few walnuts I've
> > > gotten people to test.
>
> Rev 1.731 of linuxppc_2_4_devel(mid-day California time yesterday) boots
> fine on my walnut.
>
> HHL2.0 toolchain and ibm OpenBios.
>
> I used an almost default configuration (I was working on a KGDB
> problem so I enabled KGDB):
>
>    make walnut_config
>    make menconfig
>         select KGDB
>         select CONFIG_MORE_COMPILE_OPTIONS
>    make dep
>    make zImage
>
> (I needed to fix config.in to allow CONFIG_MORE_COMPILE_OPTIONS - see
> the patch I posted yesterday.)
>
> You shouldn't have to enable KGDB.
>
> Do you have KGDB enabled by mistake?  If you do, it will sit at the
> "Now booting the kernel" console message until KGDB connects to the
> target.


Thanks Frank
You're right. It works fine with
    make walnut_config
    make menconfig
    make dep
    make zImage
and the ibm openbios
but i want to use my BDi 2000  Abatron debugger to debug the kernel.
So, i select the following options :
         select CONFIG_BDI_SWITCH
         select CONFIG_MORE_COMPILE_OPTIONS
I download the kernel with the debugger(latest 1.07 firmware). It works
fine (i can put for
example a breakpoint in start_kernel or in do_init_bootmem, it stops at
the right address)
If i continue, nothing happened, the 405GP seems locked in the __udelay
routines.
Is it a debugger config file pb ?
Any idea ? Thanks

-Phil.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
