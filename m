Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04020a02b2cd1200fc57@[192.168.240.10]>
In-Reply-To: 
 <Pine.LNX.4.03.9901202221410.28223-100000@mercator.cs.kuleuven.ac.be>
Date: Thu, 21 Jan 1999 18:32:21 +0100
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
From: Alain RICHARD <alain_richard@equation.fr>
Subject: Re:de4x5 vs. tulip on PPC
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On my machine, de4x5.c works, while tulip.c doesn't.
>
>Machine is a CHRP/PPC box, Ethernet is 21041 based D-Link DE-530CT.
>
>Relevant kernel messages:
>
>| eth0: DC21041 at 0x1080 (PCI bus 0, device 4), h/w address
>00:80:c8:5a:f8:5b,
>                                                             ^^^^^^^^^^^^^^^^^
>|       and requires IRQ29 (provided by PCI BIOS).
>| de4x5.c:V0.543 1998/12/30 davies@maniac.ultranet.com
>| eth0: media is TP.
>
>| tulip.c:v0.89H 5/23/98 becker@cesdis.gsfc.nasa.gov
>| eth0: Digital DC21041 Tulip at 0x1080, 21041 mode, 80 00 5a c8 5b f8,
>IRQ 29.
>                                                     ^^^^^^^^^^^^^^^^^
>| eth0: 21041 transmit timed out, status fc680000, CSR12 000001c8, CSR13
>ffffef05, CSR14 ffffff3f, resetting...
>| eth0: 21041 transmit timed out, status fc680010, CSR12 000052c8, CSR13
>ffffef09, CSR14 fffff7fd, resetting...
>| eth0: 21041 transmit timed out, status fc680010, CSR12 000001c8, CSR13
>ffffef05, CSR14 ffffff3f, resetting...
>| eth0: 21041 transmit timed out, status fc680010, CSR12 000052c8, CSR13
>ffffef09, CSR14 fffff7fd, resetting...
>
>So at least the Ethernet HW address is in the wrong endiannes for tulip.c.
>
>Are there people who can use tulip.c on a big endian machine?
>
>Greetings,
>
>						Geert
>
>--
>Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
>Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
>Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium
>
>

I have tried both tulip and de4x5.c driver and I have had the same problem
as you. In fact de4x5 works perfectly and there is no real reason to try to
use the tulip driver.

As far as I know, the first version of de4x5 driver was developped only for
10Mb/s ethernet Dec chips (DE425/DE434/DE435/DE450/DE500), and the tulip
driver was developped for the 10/100Mb/s chips (DEC 21040-family).

But the tulip driver was buggy and not well maintained, so the support for
the Dec 21x4x chip was added to the de4x5 driver.

Now, the tulip driver is not updated and was not tested on big-endian
machines. I think this driver will be removed at some time from the
distribution.

The de4x5 driver is regularly updated and maintained and works great for
all the 10/100 cards I have tested and its performance is very good (near
95mb/s per sec between two linux machines). It works on the i386 and PPC
side (PowerMac, and probably with other big-endian plateform such as Sparc).

As far as I know, there is no real reason to prefer the tulip driver. Also
the de4x5 driver works well as a module (I hope one day the drivers will be
removed from the core kernel to evols separately as modules only).

Regards,
------------------------------------------------
Alain RICHARD <mailto:alain_richard@equation.fr>
EQUATION SA <http://www.equation.fr>

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
