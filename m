Message-ID: <885489B3B89FB6449F93E525DF78777F064524@srvnt506.ALLOPTIC.COM>
From: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>,
	Wolfgang Denk <wd@denx.de>
Cc: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MMU on the power pc 860
Date: Thu, 2 Jan 2003 11:19:55 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

After changing my IMMR to what the suggested value of 0xf0000000 in both
the bootloader and the linux kernel (zImage), I tried to bootup the
linux again.  But, it seems to failed at the same location.

I see the MMU is NOT enabled when I jump to _start in
kernel/arch/ppc/kernel/head_8xx.S: _start.  I can follow with the
visionICE II until the instruction "rfi" under "turn_on_mmu:" section.

Before the rfi, I checked the M_TMB register, and it is some garbage value.
from the description in the MPC860 PowerQUICC User's Manual, looks like this
should have been the base register for the MMU tablewalk.  Is this register
been set by the bootloader before jumping into the linux kernel?

Also, in the section between _start and turn_on_mmu, the TLB is been setup,
where
are the table entries?  Is it in memory where I can take a peek with the
BDM?

You help is greatly appreciated.

THanks

Cecilia


-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Monday, December 23, 2002 9:21 AM
To: Wolfgang Denk
Cc: Muaddi, Cecilia; 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: MMU on the power pc 860


On Sat, Dec 21, 2002 at 09:59:00PM +0100, Wolfgang Denk wrote:
>
> Dear Cecilia,
>
> in message <885489B3B89FB6449F93E525DF78777F06451E@srvnt506.ALLOPTIC.COM>
you wrote:
> >
> > I am porting the timeSys Linux to a custom Power PC 860 board.  Our
board
> > currently runs
> > windRiver VxWorks.  I have modified the VxWorks bootrom to allow me to
> > download a motorola
> > hex record, and I have modified the timeSys bootcode
> > arch/ppc/boot/mbx/misc.c:decompress_kernel
>
> This is the generic Linux bootstrap loader, it has nothing to do with
> TimeSys.
>
> > loaded at:     00400000 0040C30C
> > board data at: 004001C0 004001E4
> > relocated to:  0040C0E8 0040C10C
> > zimage at:     0040C30C 004BC440
> > avail ram:     004BD000 00800000
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> This loos strange to me. Didn't you map RAM to 0x0000?

This is fine.  We assume that end of the wrapper, rounded slightly ->
8mb is 'good' for doing whatever we need.  It's not perfect, but it's
not unexpected anyhow.
[snip]
> > to be the value for this register?  My physical memory map consists of
RAM
> > at location 0 to 0x1ffffff
>
> This is not what I see above.

That's only what the bootloader/wrapper assumes it can use.

> > and my IMMR is set to 0x2b00 0000
>
> And this is plain wrong. The IMMR _must_ be mapped above 0xF0000000.

Indeed.  That could be why things are blowing up, yes?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
