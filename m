Date: Mon, 18 Jan 1999 10:00:01 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>, Cort Dougan <cort@cs.nmt.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MCLK=100 breaks PowerBook
In-Reply-To: <19990118021910.020182@smtp.calvacom.fr>
Message-ID: <Pine.LNX.4.03.9901180953040.339-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 18 Jan 1999, Benjamin Herrenschmidt wrote:
> The default mclk setting of 100MHz for the Rage LT-G breaks on my
> PowerBook G3 Series (garbage on screen, accelerated X hangs). I added
> mclk:83 to my command line and it works fine again (and, progress from
> pre-4, I have no more snow in X when moving things around).
> 
> >atyfb: 3D RAGE LT PRO [0x4c47 rev 0x80] 4M SGRAM, 230 MHz PLL, 83 Mhz MCLK
> 
> the chip ID 0x4c47 should be set to 83 MHz by default, not 100.
> 
> Note that I made a typo the first time I tested and I used 88Mhz. it
> works fine too.

I'm already aware that the parameters for the LT versions are not really
correct. On Cort's PowerBook, it's even worse: OF (or MacOS) seem to program it
to a mclk of only 40 MHz, with a PLL limit of 120 MHz. Unfortunately even with
these parameters it doesn't work :-(

> MacOS ATI driver creates a strange property in the device tree. It's name
> is "MCLK,XCLK" and the value is 00001a38 00001a38. Geert, those values

If you convert these to decimal, you get `6712', i.e. a mclk of 67 MHz.
Cort: what are the `MCLK,XCLK' properties for your PowerBook?

(my RAGE II+ doesn't have `MCLK,XCLK')

> have any meaning to you ? If you tell me how to do, I could calc the MCLK
> used by MacOS by peeking appropriate registers from MacsBug and we could
> use this value for the kernel with this chipID.

Just enable #define DEBUG in atyfb and feed the PLL values reported during boot
up to

    http://www.cs.kuleuven.ac.be/~geert/bin/atydebug.c.gz

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
