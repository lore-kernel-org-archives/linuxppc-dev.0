Message-ID: <001601c3f6d7$8291ca60$4a34a8c0@av34>
From: "Marcus Overhagen" <marcus.overhagen@ims.fhg.de>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <A3240F62EF3C2749B1A25D3BC9548F410309FE@ExchWENZ02.wenz.global.vpn> <20040217221957.GH16881@smtp.west.cox.net> <007b01c3f648$14ce2bc0$4a34a8c0@av34> <4033B7DB.8050905@embeddededge.com>
Subject: Re: 2.6 kernel ppc tree
Date: Thu, 19 Feb 2004 11:59:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dan Malek" <dan@embeddededge.com> wrote:

> Marcus Overhagen wrote:
>
> > I tried compiling 2.6.3 for a MPC850 based board today,
>
> OK, everyone, just wait a day or so.......

Ok, you convinced me. I'll wait until VM updates are done :)
Thanks to Rod Boyce, who sent me the 2.5 uart.c I tried compiling.
I also noticed that some defines for enet.c were missing from commproc.h
and these errors:
| arch/ppc/kernel/entry.S(__ksymtab+0x3e0): undefined reference to `request_8xxirq'
| arch/ppc/syslib/built-in.o: In function `m8xx_calibrate_decr':
| arch/ppc/syslib/built-in.o(.init.text+0x124): undefined reference to `request_8xxirq'
| arch/ppc/syslib/built-in.o(.init.text+0x124): relocation truncated to fit: R_PPC_REL24 request_8xxirq

> The 8xx stuff hasn't worked at all for a long time......if ever.
Well, it was working in 2.4.4 as publish in ELDK 2.1 at www.denx.de
However, the uart.c driver in that package has some enhancements,
compared to the mainline 2.4.25 kernel (or it was removed for 2.4.25)
Especially the ability to configure a wide variety of different pins, and
hardware handshake.
Unfortunately, RTS handshake as implemented in 2.4.4 is not working
with the MPC850, since the MPC850 doesn't do a correct UART like
RTS signal, instead it activates /RTS only during transmit. I need to fix
that, and will wait with 2.6 until you are finished.
Luckily, MPC850 can do at least a correct /CTS handshake when bit FLC
in registert PSMR is set, and you can control /RTS in UART like fashion
by programming it as general IO pin.

> Tom fixed up the drivers for me, I'm working on the VM updates.
Thats great.

> Stop trying to compile it and complaining about it because it
> is known to not work properly :-)
Yeah, now I know :) BTW, this is not a complaint!

Marcus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
