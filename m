Message-Id: <4.3.2.20000912172534.00b5c460@falcon.si.com>
Date: Tue, 12 Sep 2000 17:56:17 -0400
To: <linuxppc-embedded@lists.linuxppc.org>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Programming Flash
In-Reply-To: <319E391E2049D311843500609457383D07FD09@exchange.vividimage
 .com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Are you using the Wiggler or Raven?

You should check with MaCraigor.  Last I checked (about 6 months ago?),
Craig said he was working on a flash programming utility for the
Wiggler.  That would be the cheapest way to go for bootstrapping.

If you are loading any significant amount of code, it is fastest to
load a simple minded bootstrap program in flash: the simple minded
bootstrap program then loads the real program via a serial port or
ethernet.  This is much faster than bit-banging a PC parallel port
(assuming a bit-banging PC parallel port: the faster non-bit-banged
parallel port JTAG debuggers (Raven) and the ethernet connected JTAG
adapters are pretty fast).

If you cannot get direct flash programming support from your JTAG
debugger supplier, the JTAG definition of the I/O circle on the 823 is
provided by Mot
(http://www.mot.com/SPS/ADC/pps/download/823e/21-ieee.pdf).  Using
this, you can set each I/O pin on the 823 to be an input or an output
and set the outputs high or low.  You can write your own parallel port
JTAG bit-banger (plans are available on the net) or use Macraigor's I/O
library.  The PC program would control the 823 I/O pins (address lines,
data lines, chip select(s), write line) and program the flash
indirectly via a PC->JTAG->823->flash.  This is dead slow: you have to
shift in {address, data, chip select, write inactive}, then shift it
all in again with write active, then shift it all in with write
inactive again (theoretically the three steps can be combined into two)
with roughly 400 bits in each shift set.

Note that direct support from Macraigor will be faster than the hand
job outlined above: he has knowledge of the COP (BDM) hardware debugger
mechanism (which requires a nondisclosure with Mot) which will be able
to do write operations with a lot fewer than 1200 clocks.

gvb



At 01:04 PM 9/12/00 -0700, Kirk Haderlie wrote:

>We have a FADS 823 board and a MPC823 custom board on the way.  The
>question
>is: Using the Macrgraigor flash programmer can we program blank flash, or
>does some sort of boot strap need to be run in order to configure the on
>board memory to use the flash programmer?  How do you program in
>production
>with soldered down flash?  I realize this is a general embedded question.
>
>Kirk Haderlie
>kirk@vividimage.com
>Vivid Image Engineering
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
