Message-Id: <200007252156.XAA00879@piglet.grunz.lu>
Date: Tue, 25 Jul 2000 23:56:38 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: MacSerial and Serial driver cohabitation
To: schmitz@opal.biophys.uni-duesseldorf.de
cc: geert@linux-m68k.org, alain.richard@equation.fr, bh40@calva.net,
        paulus@linuxcare.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3973274F.F305D3FD@biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  17 Jul, this message from Michael Schmitz echoed through cyberspace:
> I'd say agree on a fixed order of probing, allocate minors in that order
> (with the possible exception of allowing a driver to allocate specific
> minors out of order if someone wants to make sure their driver always
> gets the same minors).

Whoever fixes this problem should be decorated, and a statue put up in
his memory. ;-)

But if anyone is brave enough to attempt it, don't forget that there are
_two_ places where serial ports are probed for: serial console init very
early in the booting, and driver init much later in the boot process.
Those two should be guaranteed to be in sync re minor assignment/device
naming. Right now, that's not the case.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
