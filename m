Message-ID: <3973274F.F305D3FD@biophys.uni-duesseldorf.de>
Date: Mon, 17 Jul 2000 17:33:35 +0200
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Reply-To: schmitz@opal.biophys.uni-duesseldorf.de
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Alain RICHARD <alain.richard@equation.fr>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        Paul Mackerras <paulus@linuxcare.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MacSerial and Serial driver cohabitation
References: <Pine.LNX.4.10.10007171426170.449-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> And CHRP boxes, which may have both 16550 and 8530 serial ports on the
> motherboard. Never tried my 8530 ports, though.
>
> To me it would sound logical to start counting serial ports from ttyS0 in one
> driver, and continue counting in a second driver, and so on. We had that on
> m68k, but the PC guys didn't like it and want to keep the current scheme (one
> major device for 16550 serial, and one for each type of multiserial board on
> the market).

I think the fight was rather about other design decisions in the m68k
driver, not as much about the device numbering. As far as I recall, the
proposed solution was to have the 'builtin' serials at least on m68k use
the default (16550) major but cut out the midlevel abstraction. I never
understood what was supposed to perform hardware abstraction though.

I'd say agree on a fixed order of probing, allocate minors in that order
(with the possible exception of allowing a driver to allocate specific
minors out of order if someone wants to make sure their driver always
gets the same minors).

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
