Date: Tue, 21 Sep 1999 16:15:56 +0200
To: ostermann@cs.ohiou.edu
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: PB3400 ethernet and Q1->Q3 upgrade
Message-Id: <19990921161556.026124@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Sep 21, 1999, Shawn Ostermann <ostermann@cs.ohiou.edu> wrote:

>Unfortunately, I get in over my head very quickly when talking about
>hardware details.  Do you have enough information to look into those
>points?

I think I found where this mysterious ethernet interrupt is. I don't have
one of those machines to test with, but you can find interesting things
in darwin's source code in the drvPExpert package (platform expert,
contains the motherboard specific stuffs).

Basically, it appears that Apple checks for the presence of ohare2
(pci106b,7). When available, the ethernet irq is "fixed" (xor'ed with
0x18) and a special ohare2 handler is cascaded on the fifth irq of ohare
(bit 27 or 28, there's apparently a bug in the comment).
The eth itself is on the fourth or fifth interrupt of ohare 2 controller.
(I'm afraid: did they put an entire second ohare just for an interrupt
controller ? Or do they also use the SCC for the modem ? Do you have 2
media bays on this machine ?)

So it may be possible to implement this the same way I implemented the
gatwick interrupts for the wallstreet.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
