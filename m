From: "Oliver Fuchs" <olivers.lists@gmx.net>
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 24 Aug 2004 10:01:01 +0200
MIME-Version: 1.0
Subject: Re: How to port ppc-linux to new custom boards? (virtexII)
Message-ID: <412B11DD.135.65107F@localhost>
In-reply-to: <18802.1093328823@www32.gmx.net>
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

From:           	"Patrick Huesmann" <tricknology@gmx.de>

> Unfortunately, neither of these docs talks about tailoring the kernel to
> custom hardware. They only state that "some changes" have to be applied to
> the startup code. I need some more specific information, because I'm not a
> expert PPC guru.
>
I had to get up the kernel on two boards (MPC857T and MPC8280)
recently. I use the ELDK3.0 with the kernel 2.4.24 shipped with it.

I had to modify the following files:
arch/ppc/config.in
	machine type (my board) added
arch/ppc/boot/simple/embed_config.c
	there is a function emebd_config() for every board selected by
	#ifdefs; so I added one for my board
arch/ppc/platforms
	there are header files for every board; so I added one for my board
include/asm-ppc/mpc8xx.h
	#include <platforms/myboard.h> added; selected by #ifdef

This was enough to get the kernel up with a serial i/f.
It may be necessary to modify the ethernet driver a little bit to
adapt it to your pin configuration.

Flash support was no problem for the CFI chips on the boards.

I'm just a newbie too, so don't kill me if there is something missed
or wrong.

HTH,
Oliver

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
